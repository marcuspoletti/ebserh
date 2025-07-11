package afero.auxiliar;

import java.io.File;
import java.io.FileWriter;
import java.sql.Connection;
import java.util.Iterator;
import java.util.List;

import afero.model.Loja;
import afero.model.Cidade;
import afero.persistence.AferoDAOException;
import afero.persistence.LojaDAO;
import afero.persistence.CidadeDAO;
import afero.util.ConnectionFactory;
import afero.util.Utilitaria;

public class GerarArquivoEmitente {

	private LojaDAO lojaDAO = null;
	private CidadeDAO cidadeDAO = null;
	//private int seqArquivo = 0;
	private int numLinha = 0;
	private Connection conn = null;

	public GerarArquivoEmitente() throws Exception {
		try {
			conn = ConnectionFactory.getConnection();
			lojaDAO = new LojaDAO(conn);
			cidadeDAO = new CidadeDAO(conn);

		} catch (Exception e) {
			throw new AferoDAOException("Erro: " + ":\n" + e.getMessage());
		}
	}

	private String montarHeader(int qtdReg) throws Exception {
		//seqArquivo += 1;
		String linha = "EMITENTE|"+qtdReg;
		return linha;
	}
	
	private String montarVersao() throws Exception {
		//seqArquivo += 1;
		String linha = "A|1.02";//versao
		return linha;
	}
	
	private String montarDetalhe(Loja loja) throws Exception {
		//Cidade cidade = cidadeDAO.procurarCidade(loja.getIdCidade);
		Cidade cidade = cidadeDAO.procurarCidade(1);
		String linha = "C|";		
		//DecimalFormat fmtN = new DecimalFormat("000000");
		//linha += fmtN.format(numLinha++);		
		linha += loja.getCnpj().length()==14?"CPF":"CNPJ"+"|";//tpDoc
		linha += Utilitaria.soNumeros(loja.getCnpj())+"|";//numDoc
		linha += loja.getRazaoSocial()+"|";//xNome
		linha += loja.getApelido()+"|";//xFant
		linha += loja.getInscEstadual()+"|";//IE
		//linha += loja.getInscEstadualSTrib()+"|";//IEST
		linha += "|";
		//linha += loja.getInscMunicipal()+"|";//IM
		linha += "|";
		//linha += loja.getCnae()+"|";//CNAE
		linha += "|";
		//linha += loja.getCrt()+"|";//CRT
		linha += "1|";
		linha += loja.getEndereco()+"|";//xLgr
		linha += "000|";//nro
		linha += loja.getCmpEndereco()+"|";//xCpl
		linha += loja.getBairro()+"|";//xBairro
		//linha += cidade.getCdMunicipio()+"|";//cMun
		linha += "2800308|"; //Aracaju
		linha += loja.getCidade()+"|";//xMun
		linha += loja.getEstado()+"|";//UF
		linha += Utilitaria.soNumeros(loja.getCep())+"|";//CEP
		linha += "1058|"; //cPais
		linha += "BRASIL|";//xPais
		linha += Utilitaria.soNumeros(loja.getNroTelefone())+"|";//fone
		return linha;
	}

	private String montaTrailler() {
		String linha = "";
		return linha;
	}

	public String gerarArquivo(String nomeArquivo, String clausula)
			throws Exception {
		String linha = "";
		String retorno = "";
		FileWriter arquivo;
		try {
			List list = lojaDAO.listarLoja(clausula);
			if (list.size()>0) {
				String path = "c:/temp/";
				if (!path.endsWith("/")) {
					path += "/";
				}

				numLinha = 1;
				arquivo = new FileWriter(new File(path + nomeArquivo));

				linha = montarHeader(list.size());
				arquivo.write(linha+"\r\n");

				int nreg1 = 0;
				if (list!=null && list.size()>0) {
					for (Iterator<Loja> it = list.iterator(); it.hasNext();) {
						linha = montarVersao();
						arquivo.write(linha+"\r\n");

						Loja bean = (Loja) it.next();
						linha = this.montarDetalhe(bean);
						arquivo.write(linha+"\r\n");

						nreg1++;
					}
				}

				linha = montaTrailler();
				arquivo.write(linha+"\r\n");
				arquivo.close();
				if (nreg1==0)
					retorno = "<p style=\"color:red\">registros não encontrados</p>";
				else {
					retorno = "<p style=\"color:blue\">Arquivo "+nomeArquivo+" gerado com sucesso</p>";
					retorno += "<a href=\"download.jsp?path="+path+"&arquivo="+nomeArquivo+"\">Download</a>";
				}
			} else
				retorno="<p style=\"color:red\">Dados inexistentes para gerar o arquivo</p>";
		} catch (Exception e) {
			retorno="<p style=\"color:red\">ERRO: "+e.getMessage()+"</p>";
		} finally {
			ConnectionFactory.closeConnection(conn);
		}
		return retorno;
	}

}
