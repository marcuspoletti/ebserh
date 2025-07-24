package util;

import util.ConnectionFactory;
import util.IDatabase;







public class TesteConexaoPostgres {

	public TesteConexaoPostgres() {
		// TODO Auto-generated constructor stub
	}

	public static void main(String[] args) throws AferoDAOException {
		// TODO Auto-generated method stub
		
		ConnectionFactory conn = new ConnectionFactory();
		
		System.out.println(conn.getConnection());

	}

}
