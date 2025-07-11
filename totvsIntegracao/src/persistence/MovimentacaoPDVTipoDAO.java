package persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import utilitario.ConverteDate;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.MovimentacaoPDVTipo;



public class MovimentacaoPDVTipoDAO {
	
	private Connection conn;

	public MovimentacaoPDVTipoDAO(Connection conn) {
		this.conn = conn;
	}
	
	public List movimentacaoPDVtipo(String dataInicial, String dataFinal) throws SQLException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<MovimentacaoPDVTipo> list = null;

		try {
			String sql = "SELECT D2_FILIAL, 'QUANTVEND' = SUM(D2_TOTAL), D2_TP "+
			        "FROM SL2010 L2 WITH (NOLOCK) "+
			        "INNER JOIN SD2010 D2 WITH (NOLOCK) "+
			        "ON L2_DOC = D2_DOC AND L2_SERIE = D2_SERIE AND L2_FILIAL = D2_FILIAL AND D2_EMISSAO = L2_EMISSAO "+
			        "AND D2_PDV = L2_PDV AND L2_ITEM = D2_ITEM "+
			        "INNER JOIN SL1010 L1 WITH (NOLOCK) "+
			        "ON L1_DOC = L2_DOC AND L1_FILIAL = D2_FILIAL AND L2_EMISSAO = L1_EMISSAO "+
			        "WHERE L2_EMISSAO BETWEEN '"+ConverteDate.convertData2(dataInicial)+"' AND '"+ConverteDate.convertData2(dataFinal)+"'  AND D2.D_E_L_E_T_ = '' AND L2.D_E_L_E_T_ = '' "+
			        "AND L1.D_E_L_E_T_ = '' AND D2_PDV  <> '' "+
			        "GROUP BY D2_FILIAL, D2_TP "+
			        "ORDER BY D2_FILIAL, D2_TP "; 
			
					
                
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<MovimentacaoPDVTipo>();
			while (rs.next()) {
				
				String filial    		  = rs.getString(1);
				double quantidadeVendida  = rs.getDouble(2);
				String tipo 			  = rs.getString(3);
								
				
				list.add(new MovimentacaoPDVTipo(filial, quantidadeVendida, tipo));

			}

		} catch (SQLException sqle) {
			throw new SQLException(sqle);
		}
		return list;
	}
	

}
