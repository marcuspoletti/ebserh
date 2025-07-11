package persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


import utilitario.ConverteDate;
import model.VendasPeriodo;




public class VendasPeriodoDAO {
	
	private Connection conn;

	public VendasPeriodoDAO(Connection conn) {
		this.conn = conn;
	}
	
	public List listarVendasPeriodo(String consulta) throws SQLException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<VendasPeriodo> list = null;

		try {
			String sql = "SELECT SL1.L1_FILIAL as D2_FILIAL, 'QUANTVEND' = sum(SL1.L1_VLRLIQ) "
					+ " FROM SL1010 SL1 "
					+ " WHERE ((SL1.L1_TIPO = 'P' AND SL1.L1_DOCPED <> '') "
					+ " OR  (SL1.L1_TIPO = 'V' AND SL1.L1_DOC = '' AND SL1.L1_DOCPED <> '' AND SL1.L1_SERPED <> '') "
					+ " OR  (SL1.L1_TIPO = 'V' AND SL1.L1_DOC <> '')) "
					+ " AND SL1.L1_STORC <> 'C'  AND SL1.D_E_L_E_T_ = ' ' ";
					                
                
			conn = this.conn;
			sql+=consulta;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<VendasPeriodo>();
			while (rs.next()) {
				
				String loja    = rs.getString(1);
				double valorVenda = rs.getDouble(2);
				
				
				
				
				list.add(new VendasPeriodo(loja, valorVenda));

			}

		} catch (SQLException sqle) {
			throw new SQLException(sqle);
		}
		return list;
	}
	
	public String dataAtual() throws SQLException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		String dataAtual = "";
		
		try {
			String sql = "select GETDATE();";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if (rs.next()) {
				dataAtual = ConverteDate.dateToString(rs.getDate(1));
			}

		} catch (SQLException sqle) {
			throw new SQLException(sqle);
		}
		return dataAtual;
	}

}
