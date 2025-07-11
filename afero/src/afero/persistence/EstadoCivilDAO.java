package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import afero.model.EstadoCivil;

public class EstadoCivilDAO implements IEstadoCivilDAO {
	
	private Connection conn;

	public EstadoCivilDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;
	}

	public void incluir(EstadoCivil estadoCivil) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (estadoCivil == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbestadocivil (cdEstadoCivil, dsEstadoCivil, status) "
					+ "VALUES (?, ?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, estadoCivil.getCdEstadoCivil());
			ps.setString(2,estadoCivil.getDsEstadoCivil());
			ps.setString(3, estadoCivil.getStatus());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(EstadoCivil estadoCivil) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (estadoCivil == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbestadocivil SET cdEstadoCivil=?, dsEstadoCivil=?, status=? "
					+ "WHERE cdEstadoCivil=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, estadoCivil.getCdEstadoCivil());
			ps.setString(2, estadoCivil.getDsEstadoCivil());
			ps.setString(3, estadoCivil.getStatus());
			ps.setInt(4, estadoCivil.getCdEstadoCivil());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void excluir(EstadoCivil estadoCivil) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (estadoCivil == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbestadocivil WHERE cdEstadoCivil=?");
			ps.setInt(1, estadoCivil.getCdEstadoCivil());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public EstadoCivil procurarEstadoCivil(int cdEstadoCivil) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		EstadoCivil estadoCivil = null;

		try {
			String sql = "SELECT cdEstadoCivil, dsEstadoCivil, status FROM tbestadocivil "
				+ "WHERE cdEstadoCivil=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cdEstadoCivil);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + cdEstadoCivil);
			}
            
			String dsEstadoCivil  = rs.getString(2);
			String status = rs.getString(3);

			estadoCivil = new EstadoCivil(cdEstadoCivil, dsEstadoCivil, status);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return estadoCivil;
	}

	public List listarEstadoCivil(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<EstadoCivil> list = null;
		
		try {
			String sql = "SELECT cdEstadoCivil, dsEstadoCivil, status FROM tbestadocivil ";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<EstadoCivil>();
			while (rs.next()) {
				int cdEstadoCivil= rs.getInt(1);
				String dsEstadoCivil = rs.getString(2);
				String status = rs.getString(3);
				
				list.add(new EstadoCivil(cdEstadoCivil, dsEstadoCivil, status));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}

}
