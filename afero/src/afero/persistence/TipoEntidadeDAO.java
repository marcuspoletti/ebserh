package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import afero.model.TipoEntidade;

public class TipoEntidadeDAO implements ITipoEntidadeDAO {
	
	private Connection conn;

	public TipoEntidadeDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;		
	}

	public void incluir(TipoEntidade tipoEntidade) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (tipoEntidade == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbtipoentidade (dsTipoEntidade, status) "
					+ "VALUES (?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, tipoEntidade.getDsTipoEntidade());
			ps.setString(2, tipoEntidade.getStatus());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(TipoEntidade tipoEntidade) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (tipoEntidade == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbtipoentidade SET dsTipoEntidade=?, status=? "
					+ "WHERE idTipoEntidade=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, tipoEntidade.getDsTipoEntidade());
			ps.setString(2, tipoEntidade.getStatus());
			ps.setInt(3, tipoEntidade.getIdTipoEntidade());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void excluir(TipoEntidade tipoEntidade) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (tipoEntidade == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbtipoentidade WHERE idTipoEntidade=?");
			ps.setInt(1, tipoEntidade.getIdTipoEntidade());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public TipoEntidade procurarTipoEntidade(int idEntidade) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		TipoEntidade tipoEntidade = null;

		try {
			String sql = "SELECT idTipoEntidade, dsTipoEntidade, status FROM tbtipoentidade "
				+ "WHERE idTipoEntidade=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idEntidade);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + idEntidade);
			}

			String dsTipoEntidade  = rs.getString(2);
			String status = rs.getString(3);

			tipoEntidade = new TipoEntidade(idEntidade, dsTipoEntidade, status);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return tipoEntidade;
	}

	public List listarTipoEntidade(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<TipoEntidade> list = null;
		
		try {
			String sql = "SELECT idTipoEntidade, dsTipoEntidade, status FROM tbtipoentidade ";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<TipoEntidade>();
			while (rs.next()) {
				int idTipoEntidade = rs.getInt(1);
				String dsTipoEntidade = rs.getString(2);
				String status = rs.getString(3);
				
				list.add(new TipoEntidade(idTipoEntidade, dsTipoEntidade, status));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
}
