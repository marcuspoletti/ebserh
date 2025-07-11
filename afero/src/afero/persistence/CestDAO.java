package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import afero.model.Cest;

public class CestDAO {
	
	private Connection conn;
	
	public CestDAO(Connection conn) {
		this.conn = conn;
	}
	
	public List listarCestAutoComplete(String cdCest) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<Cest> list = null;

		try {
			String sql = " Select nr_cest, ds_cest from tbcest where nr_cest like '%"+cdCest+"%' or ds_cest like '%"+cdCest+"%'";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<Cest>();
			while (rs.next()) {
				
				String nr_cest = rs.getString(1);
				String ds_cest = rs.getString(2);
				
				list.add(new Cest(nr_cest, ds_cest));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		}
		return list;
	}

}
