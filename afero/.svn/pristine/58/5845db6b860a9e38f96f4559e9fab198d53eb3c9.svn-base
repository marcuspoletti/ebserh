package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import afero.model.Estado;

public class EstadoDAO implements IEstadoDAO {
	
	private Connection conn;

	public EstadoDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;
	}

	public void incluir(Estado estado) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (estado == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbestado (cdEstado, cdRegiao, siglaEstado, ufEstado, status) "
					+ "VALUES (?, ?, ?, ?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, estado.getCdEstado());
			ps.setInt(2, estado.getCdRegiao());
			ps.setString(3, estado.getSiglaEstado());
			ps.setString(4, estado.getUfEstado());
			ps.setString(5, estado.getStatus());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(Estado estado) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (estado == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbestado SET cdEstado=?, cdRegiao=?, siglaEstado=?, ufEstado=?, status=? "
					+ "WHERE cdEstado=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, estado.getCdEstado());
			ps.setInt(2, estado.getCdRegiao());
			ps.setString(3, estado.getSiglaEstado());
			ps.setString(4, estado.getUfEstado());
			ps.setString(5, estado.getStatus());
			ps.setInt(6, estado.getCdEstado());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void excluir(Estado estado) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (estado == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbestado WHERE cdEstado=?");
			ps.setInt(1, estado.getCdEstado());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public Estado procurarEstado(int cdEstado) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		Estado estado = null;

		try {
			String sql = "SELECT cdEstado, cdRegiao, siglaEstado, ufEstado, status FROM tbestado "
				+ "WHERE cdEstado=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cdEstado);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + cdEstado);
			}
            
			int cdRegiao = rs.getInt(2);
			String siglaEstado  = rs.getString(3);
			String ufEstado  = rs.getString(4);
			String status = rs.getString(5);

			estado = new Estado(cdEstado, cdRegiao, siglaEstado, ufEstado, status);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return estado;
	}

	public List listarEstado(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<Estado> list = null;
		
		try {
			String sql = "SELECT cdEstado, cdRegiao, siglaEstado, ufEstado, status FROM tbestado";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<Estado>();
			while (rs.next()) {
				int cdEstado = rs.getInt(1);
				int cdRegiao = rs.getInt(2);
				String siglaEstado = rs.getString(3);
				String ufEstado = rs.getString(4);
				String status = rs.getString(5);

				list.add(new Estado(cdEstado, cdRegiao, siglaEstado, ufEstado, status));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}

}
