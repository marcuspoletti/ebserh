package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import afero.model.TipoColaborador;

public class TipoColaboradorDAO implements ITipoColaboradorDAO {
	private Connection conn;

	public TipoColaboradorDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;		
	}

	public void incluir(TipoColaborador tipoColaborador) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (tipoColaborador == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbtipocolaborador(dsTipoColaborador, status) "
					+ "VALUES (?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, tipoColaborador.getDsColaborador());
			ps.setString(2, tipoColaborador.getStatus());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(TipoColaborador tipoColaborador) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (tipoColaborador == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbtipocolaborador SET dsTipoColaborador=?, status=? "
					+ "WHERE idTipoColaborador=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, tipoColaborador.getDsColaborador());
			ps.setString(2, tipoColaborador.getStatus());
			ps.setInt(3, tipoColaborador.getIdTipoColaborador());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void excluir(TipoColaborador tipoColaborador) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (tipoColaborador == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbtipocolaborador WHERE idTipoColaborador=?");
			ps.setInt(1, tipoColaborador.getIdTipoColaborador());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public TipoColaborador procurarTipoColaborador(int idTipoColaborador) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		TipoColaborador tipoColaborador = null;

		try {
			String sql = "SELECT idTipoColaborador, dsTipoColaborador, status FROM tbtipocolaborador "
				+ "WHERE idTipoColaborador=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idTipoColaborador);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o cód.setor: " + idTipoColaborador);
			}

			String dsTipoColaborador  = rs.getString(2);
			String status = rs.getString(3);

			tipoColaborador = new TipoColaborador(idTipoColaborador, dsTipoColaborador, status);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return tipoColaborador;
	}

	public List listarTipoColaborador(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<TipoColaborador> list = null;
		
		try {
			String sql = "SELECT idTipoColaborador, dsTipoColaborador, status FROM tbtipocolaborador ";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<TipoColaborador>();
			while (rs.next()) {
				int idTipoColaborador = rs.getInt(1);
				String dsTipoColaborador = rs.getString(2);
				String status = rs.getString(3);
				
				list.add(new TipoColaborador(idTipoColaborador, dsTipoColaborador, status));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	public boolean exclusaoIdColaborador(int idTipoColaborador) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = true;
		try {
			String sql = "select idTipoColaborador from tbcolaborador where idTipoColaborador = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idTipoColaborador);
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