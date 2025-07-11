package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import afero.model.TipoNivel;

public class TipoNivelDAO implements ITipoNivelDAO {
	
	private Connection conn;

	public TipoNivelDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;		
	}

	public void incluir(TipoNivel tipoNivel) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (tipoNivel == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbtiponivel (cdTipoNivel, dsTipoNivel, status) "
					+ "VALUES (?, ?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, tipoNivel.getCdTipoNivel());
			ps.setString(2, tipoNivel.getDsTipoNivel());
			ps.setString(3, tipoNivel.getStatus());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(TipoNivel tipoNivel) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (tipoNivel == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbtiponivel SET cdTipoNivel=?, dsTipoNivel=?, status=? "
					+ "WHERE cdTipoNivel=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, tipoNivel.getCdTipoNivel());
			ps.setString(2, tipoNivel.getDsTipoNivel());
			ps.setString(3, tipoNivel.getStatus());
			ps.setInt(4, tipoNivel.getCdTipoNivel());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void excluir(TipoNivel tipoNivel) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (tipoNivel == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbtiponivel WHERE cdTipoNivel=?");
			ps.setInt(1, tipoNivel.getCdTipoNivel());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public TipoNivel procurarTipoNivel(int cdTipoNivel) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		TipoNivel tipoNivel = null;

		try {
			String sql = "SELECT cdTipoNivel, dsTipoNivel, status FROM tbtiponivel "
				+ "WHERE cdTipoNivel=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, tipoNivel.getCdTipoNivel());
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + cdTipoNivel);
			}
            
			String dsTipoNivel  = rs.getString(2);
			String status = rs.getString(3);

			tipoNivel = new TipoNivel(cdTipoNivel, dsTipoNivel, status);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return tipoNivel;
	}

	public List listarTipoNivel(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<TipoNivel> list = null;
		
		try {
			String sql = "SELECT cdTipoNivel, dsTipoNivel, status FROM tbtiponivel ";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<TipoNivel>();
			while (rs.next()) {
				int cdTipoNivel= rs.getInt(1);
				String dsTipoNivel = rs.getString(2);
				String status = rs.getString(3);
				
				list.add(new TipoNivel(cdTipoNivel, dsTipoNivel, status));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	
}
