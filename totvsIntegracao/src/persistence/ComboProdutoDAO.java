package persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.ComboTipoProduto;


public class ComboProdutoDAO {
	
	private Connection conn;

	public ComboProdutoDAO(Connection conn) {
		super();
		this.conn = conn;
	}
	
	public List getTipoProduto() throws SQLException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<ComboTipoProduto> list = null;

		try {
			String sql = " Select distinct B1_TIPO from SB1010 ";
                
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<ComboTipoProduto>();
			while (rs.next()) {
				
				String tipoProduto 	   = rs.getString(1);
				String codTipoProduto  = "0";
				

				
				
				
				
				list.add(new ComboTipoProduto(tipoProduto, codTipoProduto));

			}

		} catch (SQLException sqle) {
			throw new SQLException(sqle);
		}
		return list;
	}

}
