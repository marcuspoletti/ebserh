package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import afero.model.TipoLogradouro;

public class TipoLogradouroDAO implements ITipoLogradouroDAO {
	
	private Connection conn;

	public TipoLogradouroDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;		
	}

	public void incluir(TipoLogradouro tipoLogradouro) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (tipoLogradouro == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbtipologradouro (cdTipoLogradouro, AbrevTipoLogradouro, dsTipoLogradouro, status) "
					+ "VALUES (?, ?, ?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, tipoLogradouro.getCdTipoLogradouro());
			ps.setString(2, tipoLogradouro.getAbrevTipoLogradouro());
			ps.setString(3, tipoLogradouro.getDsTipoLogradouro());
			ps.setString(4, tipoLogradouro.getStatus());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(TipoLogradouro tipoLogradouro) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (tipoLogradouro == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbtipologradouro SET cdTipoLogradouro=?, AbrevTipoLogradouro=?, dsTipoLogradouro=?, status=? "
					+ "WHERE cdTipoLogradouro=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, tipoLogradouro.getCdTipoLogradouro());
			ps.setString(2, tipoLogradouro.getAbrevTipoLogradouro());
			ps.setString(3, tipoLogradouro.getDsTipoLogradouro());
			ps.setString(4, tipoLogradouro.getStatus());
			ps.setInt(5, tipoLogradouro.getCdTipoLogradouro());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void excluir(TipoLogradouro tipoLogradouro) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (tipoLogradouro == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbtipologradouro WHERE cdTipoLogradouro=?");
			ps.setInt(1, tipoLogradouro.getCdTipoLogradouro());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public TipoLogradouro procurarTipoLogradouro(int cdTipoLogradouro) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		TipoLogradouro tipoLogradouro = null;

		try {
			String sql = "SELECT cdTipoLogradouro, AbrevTipoLogradouro, dsTipoLogradouro, status FROM tbtipologradouro "
				+ "WHERE cdTipoLogradouro=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cdTipoLogradouro);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + cdTipoLogradouro);
			}
            
			String AbrevTipoLogradouro  = rs.getString(2);
			String dsTipoLogradouro = rs.getString(3);
			String status = rs.getString(4);

			tipoLogradouro = new TipoLogradouro(cdTipoLogradouro, AbrevTipoLogradouro, dsTipoLogradouro, status);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return tipoLogradouro;
	}

	public List listarTipoLogradouro(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<TipoLogradouro> list = null;
		
		try {
			String sql = "SELECT cdTipoLogradouro, AbrevTipoLogradouro, dsTipoLogradouro, status FROM tbtipologradouro ";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<TipoLogradouro>();
			while (rs.next()) {
				int cdTipoLogradouro = rs.getInt(1);
				String AbrevTipoLogradouro = rs.getString(2);
				String dsTipoLogradouro = rs.getString(3);
				String status = rs.getString(4);
				
				list.add(new TipoLogradouro(cdTipoLogradouro, AbrevTipoLogradouro, dsTipoLogradouro, status));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}

}
