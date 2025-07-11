package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import afero.model.CondPagto;

public class CondPagtoDAO {
	
	public Connection conn;
	
	public CondPagtoDAO(Connection conn){
		this.conn = conn;
	}
	
	// INSERIR
	public void incluir(CondPagto condPagto) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (condPagto == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");
		
		try {
			String sql = "INSERT INTO tbCondPagto (dsCondPagto, status)" +
						"VALUES (?, ?)";
			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, condPagto.getDsCondPagto());
			ps.setString(2, condPagto.getStatus());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);
		}
	}

	// ATUALIZAR 
	
	public void atualiza(CondPagto condPagto) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (condPagto == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");
		
		try {
			String sql = "UPDATE tbCondPagto set dsCondPagto = ?, status = ?" +
						"WHERE cdCondPagto = ?";
			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, condPagto.getDsCondPagto());
			ps.setString(2, condPagto.getStatus());
			ps.setInt(3, condPagto.getCdCondPagto());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao atualizar dados: " + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);
		}
	}
	
	// EXCLUIR
	
	public void excluir(CondPagto condPagto) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (condPagto == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbCondPagto WHERE cdCondPagto = ?");
			ps.setInt(1, condPagto.getCdCondPagto());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);
		}
	}
	
	// BUSCAR
	
	public CondPagto procurarCondPagto (String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		CondPagto condPagto = null;
		
		try {
			String sql = "SELECT cdCondPagto, dsCondPagto, status" +
						" FROM tbCondPagto";
			
			if(clausula != null)
				sql += clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				
				condPagto = new CondPagto();
				
				condPagto.setCdCondPagto(rs.getInt(1));
				condPagto.setDsCondPagto(rs.getString(2));
				condPagto.setStatus(rs.getString(3));
				
			}
		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao procurar dados:" + sqle);
		}catch (Exception e){
			throw new AferoDAOException ("Erro ao procurar dados:" + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);
		}
		return condPagto;
	}
	public CondPagto procurarCondPagto (int cdCondPagto) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		CondPagto condPagto = null;
		
		try {
			String sql = "SELECT cdCondPagto, dsCondPagto, status" +
						" FROM tbCondPagto WHERE cdCondPagto = ?";
			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cdCondPagto);
			rs = ps.executeQuery();
			while (rs.next()) {
				
				condPagto = new CondPagto();
				
				condPagto.setCdCondPagto(rs.getInt(1));
				condPagto.setDsCondPagto(rs.getString(2));
				condPagto.setStatus(rs.getString(3));
				
			}
		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao procurar dados:" + sqle);
		}catch (Exception e){
			throw new AferoDAOException ("Erro ao procurar dados:" + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);
		}
		return condPagto;
	}
	
	// LISTAR
	
	public List<CondPagto> listarCondPagto(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<CondPagto> list = null;

		try {
			String sql = "SELECT cdCondPagto, dsCondPagto, status " +
						"FROM tbCondPagto";
			
			if (clausula != null)
				sql += clausula;
			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<CondPagto>();
			
			while (rs.next()){
				
				int cdCondPagto = rs.getInt(1);
				String dsCondPagto = rs.getString(2);
				String status = rs.getString(3);
				
				list.add( new CondPagto(cdCondPagto, dsCondPagto, status));
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao listar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao listar dados: " + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);
		}
		return list;
	}	
}