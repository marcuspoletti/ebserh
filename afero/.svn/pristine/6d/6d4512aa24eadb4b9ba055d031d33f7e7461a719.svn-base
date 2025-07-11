
package afero.util;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import afero.persistence.AferoDAOException;

public class ConnectionFactory {

	public static Connection getConnection() throws AferoDAOException {
		
		try {
			Class.forName(IDatabase.driver);
			return DriverManager.getConnection(IDatabase.url, IDatabase.user,
					IDatabase.password);

		} catch (Exception e) {
			throw new AferoDAOException(e.getMessage());
		}
	}

	public static void closeConnection(Connection conn, Statement stmt,
			ResultSet rs) throws AferoDAOException {
		close(conn, stmt, rs);
	}

	public static void closeConnection(Connection conn, Statement stmt)
			throws AferoDAOException {
		close(conn, stmt, null);
	}

	public static void closeConnection(Connection conn)
			throws AferoDAOException {
		close(conn, null, null);
	}

	private static void close(Connection conn, Statement stmt, ResultSet rs)
			throws AferoDAOException {
		try {
			if (rs != null)
				rs.close();
			if (stmt != null)
				stmt.close();
			if (conn != null)
				conn.close();
		} catch (Exception e) {
			throw new AferoDAOException(e.getMessage());
		}
	}
	
	

}
