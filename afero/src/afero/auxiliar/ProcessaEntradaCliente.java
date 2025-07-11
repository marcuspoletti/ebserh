package afero.auxiliar;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import afero.model.Cidade;
import afero.model.Classificacao;
import afero.model.Entidade;
import afero.model.EntidadeEmail;
import afero.model.EntidadeEndereco;
import afero.model.EntidadeFisica;
import afero.model.EntidadeJuridica;
import afero.model.EntidadeTelefone;
import afero.persistence.AferoDAOException;
import afero.persistence.ClassificacaoDAO;
import afero.persistence.CidadeDAO;
import afero.persistence.EntidadeDAO;
import afero.persistence.EntidadeEmailDAO;
import afero.persistence.EntidadeEnderecoDAO;
import afero.persistence.EntidadeFisicaDAO;
import afero.persistence.EntidadeJuridicaDAO;
import afero.persistence.EntidadeTelefoneDAO;
//import afero.persistence.EstadoDAO;
//import afero.persistence.TipoLogradouroDAO;
import afero.util.ConnectionFactory;
import afero.util.Utilitaria;

public class ProcessaEntradaCliente {
	private int qdtClientes = 0;
	private String tipoRegistro = "";
	private int registrosLidos = 0;
	private int registrosErro = 0;
	private int registrosGravados = 0;
	private PrintWriter out;
	private String usuario;
	
	private EntidadeDAO entidadeDAO = null;
	private EntidadeFisicaDAO entidadeFisicaDAO = null;
	private EntidadeJuridicaDAO entidadeJuridicaDAO = null;
	private EntidadeEnderecoDAO entidadeEnderecoDAO = null;
	private EntidadeTelefoneDAO entidadeTelefoneDAO = null;
	private EntidadeEmailDAO entidadeEmailDAO = null;	
	private ClassificacaoDAO classificacaoDAO = null;
	//private TipoLogradouroDAO tipoLogradouroDAO = null;
	private CidadeDAO cidadeDAO = null;
	//private EstadoDAO estadoDAO = null;
	//private int seqArquivo = 0;
	//private int numLinha = 0;
	private Connection conn = null;
	
	
	public ProcessaEntradaCliente() throws Exception {
	}

	private Date preparaData(String st) {
		
		if (st.length() == 8) {
			try {
				st = st.subSequence(0, 2) + "/" + st.substring(2, 4) + "/"
						+ st.substring(4, 8);
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				long timestamp = df.parse(st).getTime();
				return new Date(timestamp);
			} catch (Exception e) {
				return null;
			}
		} else
			return null;
		
	}

	private void processaHeader(String linha) throws Exception {
		
		if (!linha.startsWith("CLIENTE|"))
			throw new Exception("Arquivo de registro não é de cliente (Emissor NF-e)");
				
		try {
			qdtClientes = Integer.parseInt(linha.substring(8,linha.length()));
		} catch (Exception e) {
			throw new Exception("Quantiade de registros de clientes no arquivo não informada");
		}
		
	}
	
	private void processaVersao(String linha) throws Exception {
		
		if (!linha.startsWith("A|1.02"))
			throw new Exception("Versão de layout do cliente inválida");
				
	}
	
	private String processaDetalhe(String linha, int i) throws Exception {
		
		registrosLidos++;
		String alerta = "OK";
		
		if (!linha.startsWith("E|CPF") && !linha.startsWith("E|CNPJ"))
			throw new Exception("Estrutura do arquivo de cliente inválida");

		Entidade entidade = new Entidade();
		EntidadeFisica entidadeFisica = new EntidadeFisica();
		EntidadeJuridica entidadeJuridica = new EntidadeJuridica();
		EntidadeEndereco entidadeEndereco = new EntidadeEndereco();
		EntidadeTelefone entidadeTelefone = new EntidadeTelefone();
		EntidadeEmail entidadeEmail = new EntidadeEmail();
		//TipoLogradouro tipoLogradouro = null;
		Cidade cidade = new Cidade();
		//Estado estado = null;
		
   	 	String[] fields = linha.split("\\|");   	 	
   	 	
   	 	//for (int j = 0; j < fields.length; j++) {
		//	System.out.println(j+"|"+fields[j]+"|");			
		//}

		Integer cdEntidade = 0;
		
		if (linha.startsWith("E|CPF")) {
			
			if (fields[2].equals("00000000000") || fields[2].equals("000.000.000-00")) 
				alerta = "ALERTA: CPF zerado. Linha nº"+i;
			else 
			  cdEntidade = entidadeFisicaDAO.procurarCpf(Utilitaria.formatarCPF(fields[2]));
		} else {
			if (fields[2].equals("00000000000000") || fields[2].equals("00.000.000/0000-00")) 
				alerta = "ALERTA: CNPJ zerado. Linha nº"+i;
			else 
				cdEntidade = entidadeJuridicaDAO.procurarCnpj(Utilitaria.formatarCPF(fields[2]));
		}
		
		if (alerta.equals("OK")) {
			if (linha.startsWith("E|CPF")) {
				if (cdEntidade != 0)
					entidadeFisica = entidadeFisicaDAO.procurarEntidadeFisica(cdEntidade);
		   	 	entidade.setTpInsc("F");//tpDoc
				entidadeFisica.setCpf(Utilitaria.formatarCPF(fields[2]));//numDoc
				entidade.setNome(fields[3]);//xNome
				//entidadeJuridica.setInscEstadual("");//IE
				//ISUF
			} else {
				if (cdEntidade != 0)
					entidadeJuridica = entidadeJuridicaDAO.procurarEntidadeJuridica(cdEntidade);
		   	 	entidade.setTpInsc("J");//tpDoc
		   	 	entidadeJuridica.setCnpj(Utilitaria.formatarCNPJ(fields[2]));//numDoc
				entidade.setNome(fields[3]);//xNome
				entidadeJuridica.setInscEstadual(fields[4]);//IE
				//ISUF
			}
			if (cdEntidade != 0) {
				entidadeEndereco = entidadeEnderecoDAO.procurarEntidadeEndereco(cdEntidade);
				entidadeTelefone = entidadeTelefoneDAO.procurarEntidadeTelefone(cdEntidade);
				entidadeEmail = entidadeEmailDAO.procurarEntidadeEmail(cdEntidade);
			}
			entidadeEndereco.setDsEndereco(fields[6]);//xLgr
			entidadeEndereco.setNroEndereco(fields[7]);//nro
			entidadeEndereco.setCmpEndereco(fields[8]);//xCpl
			entidadeEndereco.setBaiEndereco(fields[9]);//xBairro
			//linha += cidade.getCdMunicipio()+"|";//cMun
			//linha += "2800308|"; //Aracaju
			//linha += cidade.getNmCidade()+"|";//xMun
			//linha += estado.getSiglaEstado()+"|";//UF
			entidadeEndereco.setCepEndereco(fields[13]);//CEP
			//linha += "1058|"; //cPais
			//linha += "BRASIL|";//xPais			
			entidadeTelefone.setNroTelefone(fields.length>16?fields[16]:"");//fone
			entidadeEmail.setDsEmail(fields.length>17?fields[17]:"");//email

			String cdMunicipio = fields[10];
			cidade = cidadeDAO.procurarMunicipio(cdMunicipio);
			if (cidade == null) {
				cidade = new Cidade();
				Integer cdEstado = Integer.parseInt(cdMunicipio.substring(0, 2));
				cidade.setCdEstado(cdEstado);
				cidade.setNmCidade(fields[11]);
				cidade.setCdMunicipio(cdMunicipio);
				cidade.setStatus("A");
				cidadeDAO.incluir(cidade);
				cidade = cidadeDAO.procurarMunicipio(cdMunicipio);
			}
			
			if (cdEntidade == 0) {
				entidade.setStatus("A");
				entidade.setBloqueio("N");
				entidade.setUsuario(usuario);
				cdEntidade = entidadeDAO.incluir(entidade);
				if (entidade.getTpInsc().equals("F")) {
					entidadeFisica.setCdEntidade(cdEntidade);
					entidadeFisica.setSexo("M");
					entidadeFisica.setCdEstadoCivil(1);
					entidadeFisica.setCdEscolaridade(7);
					entidadeFisicaDAO.incluir(entidadeFisica);
				} else {
					entidadeJuridica.setCdEntidade(cdEntidade);
					entidadeJuridica.setRazaoSocial(entidade.getNome());
					entidadeJuridicaDAO.incluir(entidadeJuridica);
				}
				entidadeEndereco.setCdEntidade(cdEntidade);
				entidadeEndereco.setCdTipoEndereco(1);
				entidadeEndereco.setCdTipoLogradouro(34);
				entidadeEndereco.setIdCidade(cidade.getIdCidade());
				entidadeEndereco.setPadrao("S");
				entidadeEndereco.setUsuario(usuario);
				entidadeEnderecoDAO.incluir(entidadeEndereco);
				entidadeTelefone.setCdEntidade(cdEntidade);
				entidadeTelefone.setCdTipoTelefone(1);
				entidadeTelefone.setPadrao("S");
				entidadeTelefone.setUsuario(usuario);
				entidadeTelefoneDAO.incluir(entidadeTelefone);
				entidadeEmail.setCdEntidade(cdEntidade);
				entidadeEmail.setCdTipoEmail(1);
				entidadeEmail.setPadrao("S");
				entidadeEmail.setUsuario(usuario);
				entidadeEmailDAO.incluir(entidadeEmail);			
				classificacaoDAO.incluir(new Classificacao(entidade.getCdEntidade(), 1));
			} else {
				entidade.setUsuario(usuario);
				entidadeDAO.atualizar(entidade);
				if (entidade.getTpInsc().equals("F")) {
					entidadeFisicaDAO.atualizar(entidadeFisica);
				} else {
					entidadeJuridicaDAO.atualizar(entidadeJuridica);
				}
				entidadeEndereco.setUsuario(usuario);
				entidadeEnderecoDAO.atualizar(entidadeEndereco);
				entidadeTelefone.setUsuario(usuario);
				entidadeTelefoneDAO.atualizar(entidadeTelefone);
				entidadeEmail.setUsuario(usuario);
				entidadeEmailDAO.atualizar(entidadeEmail);			
			}
			
			registrosGravados++;
		}

		return (alerta);
		
	}

	private void processaTrailer() {
		
		out.println("<p>***Fim da leitura do arquivo***</p>");
		
	}

	private void validaLinha(String linha, int i) throws Exception {
				
		if (i == 1) {
			processaHeader(linha);
			out.println("<p>Quantidade de clientes: "+qdtClientes+"</p>" );
		} else {
			tipoRegistro = linha.substring(0, 1);
			if ((!tipoRegistro.equals("A")) && (!tipoRegistro.equals("E")))
				throw new Exception("Grupo do registro inválido");
			if (tipoRegistro.equals("A"))
				processaVersao(linha);
			else if (tipoRegistro.equals("E")) {
				try {
					String alerta = processaDetalhe(linha, i);
					if (!alerta.equals("OK"))
						out.println("<p>Linha: "+i+" "+alerta+"</p>");
				} catch (Exception ex) {
					out.println("<p>Linha: "+i+" "+ex.getMessage()+"</p>");
					out.flush();
					registrosErro++;
				}			
			}
		}
		
	}

	public void processaArquivo(String saveFile, PrintWriter pw, String user) throws Exception {
		
		out = pw;
		
		usuario = user;
		
		String linha = "";
		int i = 0;
		try {
			out.println("<p><b>Aguarde...</b></p>");
			out.flush();
			try {
				conn = ConnectionFactory.getConnection();
				conn.setAutoCommit(false);
				entidadeDAO = new EntidadeDAO(conn);
				entidadeFisicaDAO = new EntidadeFisicaDAO(conn);
				entidadeJuridicaDAO = new EntidadeJuridicaDAO(conn);
				entidadeEnderecoDAO = new EntidadeEnderecoDAO(conn);
				entidadeTelefoneDAO = new EntidadeTelefoneDAO(conn);
				entidadeEmailDAO = new EntidadeEmailDAO(conn);
				classificacaoDAO = new ClassificacaoDAO(conn);
				//tipoLogradouroDAO = new TipoLogradouroDAO(conn);
				cidadeDAO = new CidadeDAO(conn);
				//estadoDAO = new EstadoDAO(conn);
				
			} catch (SQLException e) {
				throw new Exception ("Erro conectando com o banco de dados");
			} catch (Exception e) {
				throw new AferoDAOException("Erro: " + ":\n" + e.getMessage());
			}
			BufferedReader br = new BufferedReader(new FileReader(saveFile));
			while ((linha = br.readLine()) != null) {
				i++;
				validaLinha(linha, i);
			}
			processaTrailer();
			br.close();
			out.println("<p>Registros lidos: "+registrosLidos+"</p>");
			out.println("<p>Registros com erros: "+registrosErro+"</p>");
			out.println("<p>Registros gravados: "+registrosGravados+"</p>");
			conn.commit();
			conn.setAutoCommit(true);
			conn.close();
			conn=null;
			out.println("<p>***Processamento finalizado***</p>");
		} catch (FileNotFoundException fnfe) {
			throw new Exception("Nao foi possivel encontrar o arquivo "
					+ saveFile);
		} catch (IOException ioe) {
			throw new Exception(
					"Foi produzido um erro durante a leitura do arquivo "
							+ saveFile);
		} catch (Exception e) {
			throw new Exception("Erro na linha " + i + ": " + e.getMessage());
		} finally {
			if (conn!=null && !conn.isClosed()) {
				conn.rollback();
				conn.close();
				conn=null;
			}
			ConnectionFactory.closeConnection(conn);
		}
	}
	
}
