package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import afero.model.TipoEmail;

public class TipoEmailDAO implements ITipoEmailDAO {
	
	private Connection conn;

	public TipoEmailDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;		
	}

	public void incluir(TipoEmail tipoEmail) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (tipoEmail == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbtipoemail (cdTipoEmail, dsTipoEmail, status) "
					+ "VALUES (?, ?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, tipoEmail.getCdTipoEmail());
			ps.setString(2, tipoEmail.getDsTipoEmail());
			ps.setString(3, tipoEmail.getStatus());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(TipoEmail tipoEmail) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (tipoEmail == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbtipoemail SET cdTipoEmail=?, dsTipoEmail=?, status=? "
					+ "WHERE cdTipoEmail=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, tipoEmail.getCdTipoEmail());
			ps.setString(2, tipoEmail.getDsTipoEmail());
			ps.setString(3, tipoEmail.getStatus());
			ps.setInt(4, tipoEmail.getCdTipoEmail());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void excluir(TipoEmail tipoEmail) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (tipoEmail == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbtipoemail WHERE cdTipoEmail=?");
			ps.setInt(1, tipoEmail.getCdTipoEmail());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public TipoEmail procurarTipoEmail(int cdTipoEmail) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		TipoEmail tipoEmail = null;

		try {
			String sql = "SELECT cdTipoEmail, dsTipoEmail, status FROM tbtipoemail "
				+ "WHERE cdTipoEmail=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, tipoEmail.getCdTipoEmail());
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + cdTipoEmail);
			}
            
			String dsTipoEmail  = rs.getString(2);
			String status = rs.getString(3);

			tipoEmail = new TipoEmail(cdTipoEmail, dsTipoEmail, status);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return tipoEmail;
	}

	public List listarTipoEmail(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<TipoEmail> list = null;
		
		try {
			String sql = "SELECT cdTipoEmail, dsTipoEmail, status FROM tbtipoemail ";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<TipoEmail>();
			while (rs.next()) {
				int cdTipoEmail= rs.getInt(1);
				String dsTipoEmail = rs.getString(2);
				String status = rs.getString(3);
				
				list.add(new TipoEmail(cdTipoEmail, dsTipoEmail, status));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}

}
