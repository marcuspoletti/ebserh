package afero.auxiliar;

import java.io.File;
import java.io.FileWriter;
import java.sql.Connection;
import java.text.DecimalFormat;
import java.util.Iterator;
import java.util.List;
import afero.model.Produto;
import afero.model.Preco;
import afero.model.Unidade;
import afero.persistence.AferoDAOException;
import afero.persistence.ProdutoDAO;
import afero.persistence.PrecoDAO;
import afero.persistence.UnidadeDAO;
import afero.util.ConnectionFactory;
import afero.util.Utilitaria;

public class GerarArquivoProduto {

	private ProdutoDAO produtoDAO = null;
	private PrecoDAO precoDAO = null;
	private UnidadeDAO unidadeDAO = null;
	//private int seqArquivo = 0;
	private int numLinha = 0;
	private Connection conn = null;

	public GerarArquivoProduto() throws Exception {
		try {
			conn = ConnectionFactory.getConnection();
			produtoDAO = new ProdutoDAO(conn);
			precoDAO = new PrecoDAO(conn);
			unidadeDAO = new UnidadeDAO(conn);

		} catch (Exception e) {
			throw new AferoDAOException("Erro: " + ":\n" + e.getMessage());
		}
	}

	private String montarHeader(int qtdReg) throws Exception {
		//seqArquivo += 1;
		String linha = "PRODUTO|"+qtdReg;
		return linha;
	}
	
	private String montarVersao() throws Exception {
		//seqArquivo += 1;
		String linha = "A|1.02";//versao
		return linha;
	}
	
	private String montarDetalhe(Produto produto) throws Exception {
		Preco preco = precoDAO.procurarPrecoIdProduto(produto.getIdProduto());
		Unidade unidade = unidadeDAO.procurarUnidade(preco.getIdUnidade());
		String linha = "I|";	
		DecimalFormat fmtN = new DecimalFormat("000000");
		//linha += fmtN.format(numLinha++);		
		linha += fmtN.format(produto.getIdProduto())+"|";//cProd
		linha += produto.getNmProduto()+"|";//xProd
		linha += "|";//cEAN
		linha += Utilitaria.soNumeros(produto.getCdNcm())+"|";//NCM
		//linha += Utilitaria.soNumeros(produto.getCdExTipi())+"|";//EXTIPI
		linha += "|";
		//linha += Utilitaria.soNumeros(produto.getCdGenero())+"|";//genero
		linha += "|";
		linha += unidade.getDsUnidade()+"|";//uCom
		linha += Utilitaria.replace(Utilitaria.formatarNumero(preco.getPreco(),4), ",", ".")+"|";//vUnCom
		//linha += produto.getCdBarra()+"|";//cEANTrib
		linha += "|";
		linha += unidade.getDsUnidade()+"|";//uTrib
		linha += Utilitaria.replace(Utilitaria.formatarNumero(preco.getPreco(),4), ",", ".")+"|";//vUnTrib
		linha += "1";//qTrib
		return linha;
	}

	private String montarTributacaoIPI(Produto produto) throws Exception {
		String linha = "M|0|1";//M|mIPI|qtdeN
		return linha;
	}

	private String montarTributacaoICMS(Produto produto) throws Exception {
		String linha = "N|40|0||||||||3|||";//N|CST|orig|modBC|pICMS|pRedBC|modBCST|pRedBCST|pMVAST||3|||
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
			List list = produtoDAO.listarProduto(clausula);
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
					for (Iterator<Produto> it = list.iterator(); it.hasNext();) {
						linha = montarVersao();
						arquivo.write(linha+"\r\n");

						Produto bean = (Produto) it.next();
						linha = this.montarDetalhe(bean);
						arquivo.write(linha+"\r\n");

						linha = montarTributacaoIPI(bean);
						arquivo.write(linha+"\r\n");

						linha = montarTributacaoICMS(bean);
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
			//ConnectionFactory.closeConnection(conn);
		}
		return retorno;
	}

}
