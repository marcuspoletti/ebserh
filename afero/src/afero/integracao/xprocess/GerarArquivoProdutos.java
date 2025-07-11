package afero.integracao.xprocess;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;

import afero.persistence.AferoDAOException;
import afero.util.ConnectionFactory;
import afero.util.Utilitaria;

public class GerarArquivoProdutos {
	
	
	
	
	public static String listarProdutos(Connection conn, int idEmpresa) throws AferoDAOException, IOException {
		PreparedStatement ps = null;
		ResultSet rs = null;
		//List<Produtos> list = null;
		StringBuilder sb = new StringBuilder();
		
		

		try {
			
			
			
			String sql ="SELECT p.cdBarra, p.dsProduto, e.qtEstoque, round(pr.preco*10000), '0' as 'Desconto Máx', p.idProduto, u.dsUnidade, round(pr.custoDireto*10000), "+
						"round(pr.custoMedioGeral*10000), '0' as 'Markup', round(t.aliquotaIcms*10000), '0' as 'Valor Comissao', csti.cdCstIcms, '0' as 'CST. Orig. Mercadoria', "+
						"csti.cdCstIcms as 'CST. Trib. ICMS', t.pReduBCIcms as 'Reducao', pis.cdCstPis as 'Cód. CST PIS', con.cdCstCofins as 'Cód. CST COFINS', "+
						"'0' as 'Alíquota PIS', '0' as 'Alíquota COFINS', p.cdNcm as 'NCM',cfop.cdCfop as 'CFOP P. Física', cfop.cdCfop as 'CFOP P. Juridica', "+
						"round(t.percCargaTrib*10000), p.idDivisao as 'idSecao', divi.dsDivisao as 'Divisao', p.cdCest "+
						"FROM tbproduto p "+
						"JOIN tbdivisao d on p.idDivisao = d.idDivisao AND p.status = 'A' "+
						"JOIN tbestoque e on p.idProduto = e.idProduto AND e.idLoja = ? "+
						"JOIN tbpreco pr on e.idEstoque = pr.idEstoque AND pr.precoPadrao = 'S' "+ 
						"JOIN tbunidade u on pr.idUnidade = u.idUnidade "+
						"JOIN tbcattributaria cat on p.idCatTributaria = cat.idCatTributaria "+
						"JOIN tbtributacao t on cat.idCatTributaria = t.idCatTributaria "+
						"JOIN tbcstpis pis on cat.cdCstPis = pis.cdCstPis "+
						"JOIN tbcstcofins con on cat.cdCstCofins = con.cdCstCofins "+
						"JOIN tbcsticms csti on t.cdCstIcms = csti.cdCstIcms "+
						"JOIN tbcfop cfop on p.cdCfopSaidaDentro = cfop.cdCfop "+
						"JOIN tbdivisao divi on p.idDivisao = divi.idDivisao ";
			
			
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idEmpresa);
			rs = ps.executeQuery();
			
			
			while (rs.next()) {

				sb.append("2");
				sb.append(Utilitaria.completarBrancos(Utilitaria.calcularDigitoGTIN("789"+Utilitaria.completarZeros(String.valueOf(rs.getInt(6)),9)+"0"), 14));
//				String CodBarras        = Utilitaria.completarBrancos(Utilitaria.calcularDigitoGTIN("789"+Utilitaria.completarZeros(String.valueOf(rs.getInt(6)),9)+"0"), 14);
//				String descProduto      = Utilitaria.completarBrancos(rs.getString(2), 100);
				sb.append(Utilitaria.completarBrancos(rs.getString(2), 100));
//				String qtdEstoque       = Utilitaria.completarZeros("1000000", 10);
				sb.append(Utilitaria.completarZeros("1000000", 10));
//				String valorVarejo      = Utilitaria.completarZeros(Utilitaria.limpar(String.valueOf(rs.getFloat(4)),"0123456789"), 11);
				sb.append(Utilitaria.completarZeros(Utilitaria.limpar(String.valueOf(rs.getInt(4)),"0123456789"), 12));
//				String descontoMax      = Utilitaria.completarZeros(rs.getString(5),8);
				sb.append(Utilitaria.completarZeros(rs.getString(5),8));
//				String naoUsado1        = Utilitaria.completarBrancos("", 12);
				sb.append(Utilitaria.completarBrancos("", 6));
//				String codProduto       = Utilitaria.completarZeros(String.valueOf(rs.getInt(6)), 8);
				sb.append(Utilitaria.completarZeros(String.valueOf(rs.getInt(6)), 8));
//				String unidadeVenda     = Utilitaria.completarBrancos(rs.getString(7), 2);
				sb.append(Utilitaria.completarBrancos(rs.getString(7), 2));
//				String custo            = Utilitaria.completarZeros(Utilitaria.limpar(String.valueOf(rs.getFloat(8)),"0123456789"), 12);
				sb.append(Utilitaria.completarZeros(Utilitaria.limpar(String.valueOf(rs.getInt(8)),"0123456789"), 12));
//				String custoMedio       = Utilitaria.completarZeros(Utilitaria.limpar(String.valueOf(rs.getFloat(9)),"0123456789"), 12);
				sb.append(Utilitaria.completarZeros(Utilitaria.limpar(String.valueOf(rs.getInt(9)),"0123456789"), 12));
//				String markup           = Utilitaria.completarZeros(rs.getString(10), 8);
				sb.append(Utilitaria.completarZeros(rs.getString(10), 8));
//				String naoUsado2        = Utilitaria.completarZeros("", 12);
				sb.append(Utilitaria.completarZeros("", 12));
//				String alquotaICMS      = Utilitaria.completarZeros(Utilitaria.limpar(String.valueOf(rs.getFloat(11))+"0000","0123456789"), 8);
				sb.append(Utilitaria.completarZeros(Utilitaria.limpar(String.valueOf(rs.getInt(11)),"0123456789"), 8));
//				String valorComissao    = Utilitaria.completarZeros(Utilitaria.limpar(rs.getString(12),"0123456789"), 8);
				sb.append(Utilitaria.completarZeros(Utilitaria.limpar(rs.getString(12),"0123456789"), 8));
//				String CSTOrigMercadoria= Utilitaria.completarZeros(Utilitaria.limpar(rs.getString(14),"0123456789"), 1);
				sb.append(Utilitaria.completarZeros(Utilitaria.limpar(rs.getString(14),"0123456789"), 1));
				
				String CSTTribICMS      = Utilitaria.limpar(String.valueOf(rs.getInt(15)),"0123456789");
				sb.append(Utilitaria.completarBrancos(String.valueOf(CSTTribICMS),3));
				
//				String naoUsado3        = Utilitaria.completarZeros("", 8);
				sb.append(Utilitaria.completarZeros("", 8));
//				String naoUsado4        = Utilitaria.completarZeros("", 12);
				sb.append(Utilitaria.completarZeros("", 12));
				//String Reducao          = Utilitaria.completarZeros(Utilitaria.limpar(String.valueOf(rs.getFloat(16)),"0123456789"),8);
				sb.append(Utilitaria.completarZeros(Utilitaria.limpar(String.valueOf(rs.getFloat(16)),"0123456789"),8));
//				String codCSTPIS        = Utilitaria.completarBrancos(Utilitaria.limpar(String.valueOf(rs.getFloat(16)),"0123456789"), 2);
				sb.append(Utilitaria.completarZeros(Utilitaria.limpar(String.valueOf(rs.getInt(17)),"0123456789"), 2));
//				String codCSTCOFINS     = Utilitaria.completarBrancos(Utilitaria.limpar(String.valueOf(rs.getFloat(17)),"0123456789"),2);
				sb.append(Utilitaria.completarZeros(Utilitaria.limpar(String.valueOf(rs.getInt(18)),"0123456789"),2));
//				String alquotaPIS       = Utilitaria.completarZeros(Utilitaria.limpar(String.valueOf(rs.getFloat(17)),"0123456789"),12);
				sb.append(Utilitaria.completarZeros(Utilitaria.limpar(String.valueOf(rs.getInt(19)),"0123456789"),12));
//				String aliquotaCOFINS   = Utilitaria.completarZeros(Utilitaria.limpar(rs.getString(19),"0123456789"), 12);
				sb.append(Utilitaria.completarZeros(Utilitaria.limpar(String.valueOf(rs.getInt(20)),"0123456789"), 12));
//				String naoUsado5        = Utilitaria.completarBrancos("", 2);
				sb.append(Utilitaria.completarBrancos("", 2));
//				String naoUsado6        = Utilitaria.completarBrancos("", 2);
				sb.append(Utilitaria.completarBrancos("", 2));
//				String naoUsado7        = Utilitaria.completarZeros("", 12);
				sb.append(Utilitaria.completarZeros("", 12));
//				String naoUsado8        = Utilitaria.completarZeros("", 12);
				sb.append(Utilitaria.completarZeros("", 12));
//				String codNCM           = Utilitaria.completarBrancos(rs.getString(21), 10);
				sb.append(Utilitaria.completarBrancos(rs.getString(21), 10));
//				String CFOPPFísica      = Utilitaria.completarBrancos(rs.getString(22), 4);
				sb.append(Utilitaria.completarBrancos(rs.getString(22), 4));
//				String CFOPPJurídica    = Utilitaria.completarBrancos(rs.getString(23), 4);
				sb.append(Utilitaria.completarBrancos(rs.getString(23), 4));
//				String percentualCargaTributária = Utilitaria.completarZeros(Utilitaria.limpar(rs.getString(24),"0123456789"), 8);
				sb.append(Utilitaria.completarZeros(Utilitaria.limpar(rs.getString(24),"0123456789"), 8));
//				String naoUsado10       = Utilitaria.completarBrancos("", 36);
				sb.append(Utilitaria.completarBrancos("", 36));
//				String naoUsado11       = Utilitaria.completarBrancos("", 1);
				sb.append(Utilitaria.completarBrancos("", 1));
//				String idSecao          = Utilitaria.completarZeros(String.valueOf(rs.getInt(25)), 8);
				sb.append(Utilitaria.completarZeros(String.valueOf(rs.getInt(25)), 8));
//				String naoUsado12       = Utilitaria.completarBrancos("", 1);
				sb.append(Utilitaria.completarBrancos("N", 1));

				String cest = rs.getString("cdCest"); 
				if(cest ==null)cest="";
				
				try{
					if(cest != null){
						cest = cest.replace(".", "");
					}
				}catch(Exception sqle){
					throw new AferoDAOException(sqle);
				}
				
				// NECESSÁRIO CRIAR ESTE CAMPO NO CADASTRO DO PRODUTO NA RETAGUARDA. São 7 números.
				// TODO: cest  varchar(7)
				// TABELA DE CEST POR NCM: https://www.confaz.fazenda.gov.br/legislacao/convenios/2017/CV052_17
				sb.append(Utilitaria.completarBrancos(cest, 7));
//				String naoUsado13       = Utilitaria.completarBrancos("", 1);
				sb.append(Utilitaria.completarBrancos("S", 1));
//				String naoUsado14       = Utilitaria.completarBrancos("", 1);
				sb.append(Utilitaria.completarBrancos("", 15));
//				String unidadeVenda     = Utilitaria.completarBrancos(rs.getString(7), 6);
				sb.append(Utilitaria.completarBrancos(rs.getString(7), 6));
//				String naoUsado15       = Utilitaria.completarBrancos("N", 1);
				sb.append(Utilitaria.completarBrancos("N", 1));
//				String naoUsado16       = Utilitaria.completarBrancos("N", 1);
				sb.append(Utilitaria.completarBrancos("N", 1));
				sb.append("\n");
				
				//bw.write(sb);
				

			
				
//				list.add(new Produtos( tipo,  CodBarras,  descProduto,
//						 qtdEstoque,  valorVarejo,  descontoMax,
//						 naoUsado1,  codProduto,  unidadeVenda,
//						 custo,  custoMedio,  markup,  naoUsado2,
//						 alquotaICMS,  valorComissao,
//						 CSTOrigMercadoria,  CSTTribICMS,  naoUsado3,
//						 naoUsado4,  Reducao,  codCSTPIS,
//						 codCSTCOFINS,  alquotaPIS,  aliquotaCOFINS,
//						 naoUsado5,  naoUsado6,  naoUsado7,
//						 naoUsado8,  codNCM,  CFOPPFísica,
//						 CFOPPJurídica,  percentualCargaTributária,
//						 naoUsado10,  naoUsado11,  idSecao));
			}
			
		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return sb.toString();
	}
	
	public void GerarArquivoTxt(List list){
		File arquivo = new File("/PRODUTOS.txt");
		 
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
			Produtos produtos = (Produtos) it.next();
			
				bw.write(produtos.getTipo()+produtos.getCoddBarras()+produtos.getDescProduto()+produtos.getQtdEstoque()+
						produtos.getValorVarejo()+produtos.getDescontoMax()+produtos.getNaoUsado1()+
						produtos.getCoddProduto()+produtos.getUnidadeVenda()+produtos.getCusto()+
						produtos.getCustoMedio()+produtos.getMarkup()+produtos.getNaoUsado2()+produtos.getAliquotaICMS()+
						produtos.getValorComissão()+produtos.getCSTOrigMercadoria()+produtos.getCSTTribICMS()+
						produtos.getNaoUsado3()+produtos.getNaoUsado4()+produtos.getReducao()+produtos.getCodCSTPIS()+
						produtos.getCodCSTCOFINS()+produtos.getAlquotaPIS()+produtos.getAliquotaCOFINS()+produtos.getNaoUsado5()+
						produtos.getNaoUsado6()+produtos.getNaoUsado7()+produtos.getNaoUsado8()+produtos.getCodNCM()+
						produtos.getCFOPPFisica()+produtos.getCFOPPJuridica()+produtos.getPercentualCargaTributária()+
						produtos.getNaoUsado10()+produtos.getNaoUsado11()+produtos.getIdSecao());
				bw.newLine();
			
		}
		bw.close();
		fw.close();
		 
		}catch (IOException ex) {
			ex.printStackTrace();
		}
	}
	
	public static void main(String[] args) throws Exception{
		
		System.out.println(listarProdutos(ConnectionFactory.getConnection(), 1));
		
	}
	
	

}
