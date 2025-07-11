package persistence;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Estoque;




public class PesquisaProdutoDAO {
	
private Connection conn;
	
	public PesquisaProdutoDAO(Connection conn) {
		this.conn = conn;
		
	}
	
	public List listarProduto(String consulta) throws SQLException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<Estoque> list = null;

		try {
			String sql = "SELECT B1_COD, B1_CODBAR, B1_TITULO, B1_NAUTOR, BM_DESC, B1_PRV1, B2_QATU, B2_FILIAL, B1_SETOR, B1_MSBLQL "+
                		 "FROM SB1010 AS B1 "+
                		 "LEFT JOIN SB2010 B2 ON B1_COD = B2_COD "+
                		 "INNER JOIN SBM010 BM ON BM_GRUPO = B1_GRUPO "+
                		 "WHERE B2.B2_FILIAL <> '' AND (B2_FILIAL <> '11' AND B2_LOCAL = '01' AND B2.D_E_L_E_T_ = '' OR B2.B2_COD IS NULL) ";                
                
			conn = this.conn;
			sql+=consulta;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<Estoque>();
			while (rs.next()) {
				
				String B1_COD    = rs.getString(1);
				String B1_CODBAR = rs.getString(2);
				String B1_TITULO = rs.getString(3);
				String B1_NAUTOR = rs.getString(4);
				String BM_DESC   = rs.getString(5);
				float  B1_PRV1   = rs.getFloat(6);
				float B2_QATU    = rs.getFloat(7);
				String B2_FILIAL = rs.getString(8);
				String B1_SETOR  = rs.getString(9);
				String B1_MSBLQL = rs.getString(10);
				
				
				
				list.add(new Estoque(B2_FILIAL, B2_QATU, B1_COD,
						B1_CODBAR, B1_TITULO, B1_NAUTOR, BM_DESC,
						B1_PRV1, B1_SETOR, B1_MSBLQL));

			}

		} catch (SQLException sqle) {
			throw new SQLException(sqle);
		}
		return list;
	}

}
