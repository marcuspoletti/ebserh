package afero.persistence;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import afero.model.Banco;
public class BancoDAO implements IBancoDAO{
	private Connection conn;

	public BancoDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;
	}

	public void incluir(Banco banco) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (banco == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbbanco (nmBanco, nrBanco, status) "
					+ "VALUES (?, ?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, banco.getNmBanco());
			ps.setString(2, banco.getNrBanco());
			ps.setString(3, banco.getStatus());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(Banco banco) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (banco == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbbanco SET nmBanco=?, nrBanco=?, status=? "
					+ "WHERE idBanco=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, banco.getNmBanco());
			ps.setString(2, banco.getNrBanco());
			ps.setString(3, banco.getStatus());
			ps.setInt(4, banco.getIdBanco());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void excluir(Banco banco) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (banco == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbbanco WHERE idBanco=?");
			ps.setInt(1, banco.getIdBanco());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public Banco procurarBanco(int idBanco) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		Banco banco = null;

		try {
			String sql = "SELECT idBanco, nmBanco, nrBanco, status FROM tbbanco "
				+ "WHERE idBanco=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idBanco);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + idBanco);
			}
            
			int cdBanco = rs.getInt(1);
			String nmBanco  = rs.getString(2);
			String nrBanco  = rs.getString(3);
			String status = rs.getString(4);

			banco = new Banco(cdBanco, nmBanco, nrBanco, status);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return banco;
	}

	public List listarBanco(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<Banco> list = null;
		
		try {
			String sql = "SELECT idBanco, nmBanco, nrBanco, status FROM tbbanco ";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<Banco>();
			while (rs.next()) {
				int idBanco = rs.getInt(1);
				String nmBanco = rs.getString(2);
				String nrBanco = rs.getString(3);
				String status = rs.getString(4);
				
				list.add(new Banco(idBanco, nmBanco, nrBanco, status));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	public boolean exclusaoIdBanco(int idBanco) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = true;
		try {
			String sql = "select b.idBanco from tbbanco b join tbconta c on b.idBanco = c.idBanco where b.idBanco = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idBanco);
			rs = ps.executeQuery();
			if(rs.next()) {
			   ok=true;
			}else{
				ok=false;
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return ok;
		
	}

}
