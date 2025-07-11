package afero.integracao.xprocess;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import afero.util.ConnectionFactory;
import afero.util.Utilitaria;
import afero.integracao.xprocess.Modalidade;
import afero.persistence.AferoDAOException;

//Arquivo

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;


public class GerarArquivoModalidade {
	
	

	
	public String listarModalidadePedido(Connection conn) throws AferoDAOException, Exception {
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		String tipoPagamentoNFC = "";
		StringBuilder sb = new StringBuilder();

		try {
			String sql = "SELECT cdCondPagto, convert(dsCondPagto using ascii), status FROM tbCondPagto WHERE status = 'A' ";
			
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			//list = new ArrayList<Modalidade>();
			while (rs.next()) {

//				Integer tipo = 3;
                sb.append("3");
//				String idCondicaoPagamento = Utilitaria.completarZeros("".valueOf(rs.getInt(1)), 5);
                sb.append(Utilitaria.completarZeros("".valueOf(rs.getInt(1)), 5));
//				String dsCondicaoPagamento = Utilitaria.completarBrancos(rs.getString(2), 80);
                sb.append(Utilitaria.completarBrancos(new String(rs.getString(2).getBytes(), "ISO-8859-1"), 80));
//				String quantParcelas = Utilitaria.completarZeros("3", 3);
                sb.append(Utilitaria.completarZeros("1", 3));
				
				/// Código válidos para tipoPagamentoNFC
				/// 01 = Dinheiro
				/// 02 = Cheque
				/// 03 = Cartão de Crédito
				/// 04 = Cartão de Débito
				/// 05 = Crédito Loja
				/// 10 = Vale Alimentação
				/// 11 = Vale Refeição
				/// 12 = Vale Presente
				/// 13 = Vale Combustível
				/// 15 = Boleto Bancário
				/// 90 = Sem pagamento
				/// 99 = Outros
				
				/// Códigos para tBand
				/// 01=Visa
				/// 02=Mastercard
				/// 03=American Express
				/// 04=Sorocred 
				/// 05=Diners Club 
				/// 06=Elo 
				/// 07=Hipercard 
				/// 08=Aura 
				/// 09=Cabal
				/// 99=Outros
							
				String tBand = "00";
				String cnpjOperadoraCartao = "";
				
				if(rs.getString(2).equalsIgnoreCase("DINHEIRO")){
					tipoPagamentoNFC = "01";
				}else if(rs.getString(2).equalsIgnoreCase("VALE")){
					tipoPagamentoNFC = "05";
				}else if(rs.getString(2).equalsIgnoreCase("C.ALIMENTACAO")){
					tipoPagamentoNFC = "10";
				}else if(rs.getString(2).equalsIgnoreCase("CHEQUE")){
					tipoPagamentoNFC = "02";
				}else if(rs.getString(2).equalsIgnoreCase("C.CREDITO")){
					tipoPagamentoNFC = "03";
					cnpjOperadoraCartao = ""; // <------ PREENCHER
					tBand = "99";
				}else if(rs.getString(2).equalsIgnoreCase("C.DEBITO")){
					tipoPagamentoNFC = "04";
					cnpjOperadoraCartao = ""; // <------ PREENCHER
					tBand = "99";
				}else{
					tipoPagamentoNFC = "99";
				}
				
				sb.append(Utilitaria.completarBrancos(cnpjOperadoraCartao,14));
				sb.append(tipoPagamentoNFC);
				sb.append(tBand);
                sb.append(Utilitaria.completarZeros("".valueOf(rs.getInt(1)), 5));
                sb.append(Utilitaria.completarBrancos(new String(rs.getString(2).getBytes(), "ISO-8859-1"), 80));
				sb.append(Utilitaria.completarBrancos("", 3));	

				sb.append("\n");
				
//				list.add(new Modalidade(tipo, idCondicaoPagamento, dsCondicaoPagamento,
//						quantParcelas, naoUsado, tipoPagamentoNFC, naoUsado1));
			}
			
		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return new String(sb.toString().getBytes(), "ISO-8859-1");
	}
	
	public void GerarArquivoTxt(List list){
		File arquivo = new File("/MODALIDADES.txt");
		 
		try {
		 
		if (!arquivo.exists()) {
		//cria um arquivo (vazio)
		arquivo.createNewFile();
		}
		 
		//caso seja um diretório, é possível listar seus arquivos e diretórios
		//File[] arquivos = arquivo.listFiles();
		 
		//escreve no arquivo
		FileWriter fw = new FileWriter(arquivo, true);
		 
		BufferedWriter bw = new BufferedWriter(fw);
		for ( Iterator it = list.iterator(); it.hasNext(); ) {
			Modalidade modalidade = (Modalidade) it.next();
			if(modalidade.getDscModalidade()!= null || modalidade.getDscModalidade()!= ""){
				bw.write(modalidade.getTipo()+modalidade.getIdModalidade()+modalidade.getDscModalidade()+modalidade.getQuantParcelas()+modalidade.getNaoUsado()+modalidade.getTipoPagamentoNFC()+modalidade.getNaoUsado1());
				bw.newLine();
			}
		}
		bw.close();
		fw.close();
		 
		}catch (IOException ex) {
			ex.printStackTrace();
		}
	}
}



