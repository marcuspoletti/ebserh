package persistence;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.HistoricoPreco;
import utilitario.ConverteDate;




public class HistoricoPrecoDAO {
	
private Connection conn;
	
	public HistoricoPrecoDAO(Connection conn) {
		this.conn = conn;
		
	}
	
	public List historicoPreco(String database, String codigo) throws SQLException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<HistoricoPreco> list = null;

		try {
			String sql = "DECLARE @codproduto AS VARCHAR(30) "+

				         "SET @codproduto = (SELECT B1_COD from SB1010 where B1_CODBAR = ? and D_E_L_E_T_ = '') "+
			
		   		         "SELECT TOP 1 B1_TITULO,B1_PRV1,D2_PRUNIT AS 'ANTIGO_PREÇO_1',D2_EMISSAO AS 'EMISSAO_1', "+
				         "(SELECT TOP 1 D2_PRUNIT FROM SD2010  WHERE D2_EMISSAO <= '"+ConverteDate.convertData2(database)+"' AND D2_COD = @codproduto "+
				         "AND D2_SERIE NOT IN ('1','2','3','4','5','6','7') AND D2_PRUNIT <> D2.D2_PRUNIT AND R_E_C_N_O_ < D2.R_E_C_N_O_ "+
				         "AND D_E_L_E_T_ = '' ORDER BY R_E_C_N_O_ DESC) AS 'ANTIGO_PREÇO_2', "+
				         "(SELECT TOP 1 D2_EMISSAO FROM SD2010  WHERE D2_EMISSAO <= '"+ConverteDate.convertData2(database)+"' AND D2_COD = @codproduto AND D2_SERIE NOT IN ('1','2','3','4','5','6','7') "+
				         "AND D2_PRUNIT <> D2.D2_PRUNIT AND R_E_C_N_O_ < D2.R_E_C_N_O_ AND D_E_L_E_T_ = '' ORDER BY R_E_C_N_O_ DESC) AS 'EMISSAO_2' "+
				         "FROM SD2010 D2 INNER JOIN SB1010 "+
				         "ON B1_COD = D2_COD "+
				         "WHERE B1_COD = @codproduto  AND D2.D2_EMISSAO <= '"+ConverteDate.convertData2(database)+"' AND D2.D2_SERIE NOT IN ('1','2','3','4','5','6','7') AND D2.D_E_L_E_T_ = '' "+
				         "AND (B1_PRV1 <> (SELECT TOP 1 D2_1.D2_PRUNIT FROM SD2010 D2_1 WHERE D2_1.D2_EMISSAO <= '"+ConverteDate.convertData2(database)+"' AND D2_1.D2_COD = @codproduto "+
				         "AND D2_1.D2_SERIE NOT IN ('1','2','3','4','5','6','7') AND D2_1.D_E_L_E_T_ = '' ORDER BY D2_1.R_E_C_N_O_ DESC) "+
				         "OR B1_PRV1 = (SELECT TOP 1 D2_2.D2_PRUNIT FROM SD2010 D2_2 WHERE D2_2.D2_EMISSAO <= '"+ConverteDate.convertData2(database)+"' AND D2_2.D2_COD = @codproduto "+
				         "AND D2_2.D2_SERIE NOT IN ('1','2','3','4','5','6','7') AND D2_2.D_E_L_E_T_ = '' ORDER BY D2_2.R_E_C_N_O_ DESC )) "+
				         "ORDER BY D2.R_E_C_N_O_ DESC ";
                
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, codigo);
			rs = ps.executeQuery();
			list = new ArrayList<HistoricoPreco>();
			while (rs.next()) {
				
				String B1_TITULO 	   = rs.getString(1);
				double B1_PRV1 		   = rs.getDouble(2);
				double ANTIGO_PREÇO_1   = rs.getDouble(3);
				String EMISSAO_1       = rs.getString(4);
				double ANTIGO_PREÇO_2   = rs.getDouble(5);
				String  EMISSAO_2      = rs.getString(6);


				
				
				
				
				list.add(new HistoricoPreco(B1_TITULO, B1_PRV1, ANTIGO_PREÇO_1,
						EMISSAO_1, ANTIGO_PREÇO_2, EMISSAO_2));

			}

		} catch (SQLException sqle) {
			throw new SQLException(sqle);
		}
		return list;
	}

}
