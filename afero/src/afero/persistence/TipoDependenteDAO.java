package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import afero.model.TipoDependente;

public class TipoDependenteDAO implements ITipoDependenteDAO {
	
	private Connection conn;

	public TipoDependenteDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;		
	}

	public void incluir(TipoDependente tipoDependente) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (tipoDependente == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbtipodependente (dsTipoDependente, status) "
					+ "VALUES (?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, tipoDependente.getDsTipoDependente());
			ps.setString(2, tipoDependente.getStatus());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(TipoDependente tipoDependente) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (tipoDependente == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbtipodependente SET dsTipoDependente=?, status=? "
					+ "WHERE idTipoDependente=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, tipoDependente.getDsTipoDependente());
			ps.setString(2, tipoDependente.getStatus());
			ps.setInt(3, tipoDependente.getIdTipoDependente());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void excluir(TipoDependente tipoDependente) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (tipoDependente == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbtipodependente WHERE IdTipoDependente=?");
			ps.setInt(1, tipoDependente.getIdTipoDependente());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public TipoDependente procurarTipoDependente(int IdTipoDependente) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		TipoDependente tipoDependente = null;

		try {
			String sql = "SELECT IdTipoDependente, dsTipoDependente, status FROM tbtipodependente "
				+ "WHERE IdTipoDependente=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, IdTipoDependente);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + IdTipoDependente);
			}

			String dsTipoDependente  = rs.getString(2);
			String status = rs.getString(3);

			tipoDependente = new TipoDependente(IdTipoDependente, dsTipoDependente, status);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return tipoDependente;
	}

	public List listarTipoDependente(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<TipoDependente> list = null;
		
		try {
			String sql = "SELECT idTipoDependente, dsTipoDependente, status FROM tbtipodependente ";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<TipoDependente>();
			while (rs.next()) {
				int idTipoDependente = rs.getInt(1);
				String dsTipoDependente = rs.getString(2);
				String status = rs.getString(3);
				
				list.add(new TipoDependente(idTipoDependente, dsTipoDependente, status));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
}
