package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import afero.model.TipoTelefone;

public class TipoTelefoneDAO implements ITipoTelefoneDAO {
	
	private Connection conn;

	public TipoTelefoneDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;		
	}

	public void incluir(TipoTelefone tipoTelefone) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (tipoTelefone == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbtipotelefone (cdTipoTelefone, dsTipoTelefone, status) "
					+ "VALUES (?, ?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, tipoTelefone.getCdTipoTelefone());
			ps.setString(2, tipoTelefone.getDsTipoTelefone());
			ps.setString(3, tipoTelefone.getStatus());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(TipoTelefone tipoTelefone) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (tipoTelefone == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbtipotelefone SET cdTipoTelefone=?, dsTipoTelefone=?, status=? "
					+ "WHERE cdTipoTelefone=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, tipoTelefone.getCdTipoTelefone());
			ps.setString(2, tipoTelefone.getDsTipoTelefone());
			ps.setString(3, tipoTelefone.getStatus());
			ps.setInt(4, tipoTelefone.getCdTipoTelefone());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void excluir(TipoTelefone tipoTelefone) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (tipoTelefone == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbtipotelefone WHERE cdTipoTelefone=?");
			ps.setInt(1, tipoTelefone.getCdTipoTelefone());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public TipoTelefone procurarTipoTelefone(int cdTipoTelefone) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		TipoTelefone tipoTelefone = null;

		try {
			String sql = "SELECT cdTipoTelefone, dsTipoTelefone, status FROM tbtipotelefone "
				+ "WHERE cdTipoTelefone=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, tipoTelefone.getCdTipoTelefone());
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + cdTipoTelefone);
			}
            
			String dsTipoTelefone  = rs.getString(2);
			String status = rs.getString(3);

			tipoTelefone = new TipoTelefone(cdTipoTelefone, dsTipoTelefone, status);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return tipoTelefone;
	}

	public List listarTipoTelefone(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<TipoTelefone> list = null;
		
		try {
			String sql = "SELECT cdTipoTelefone, dsTipoTelefone, status FROM tbtipotelefone ";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<TipoTelefone>();
			while (rs.next()) {
				int cdTipoTelefone= rs.getInt(1);
				String dsTipoTelefone = rs.getString(2);
				String status = rs.getString(3);
				
				list.add(new TipoTelefone(cdTipoTelefone, dsTipoTelefone, status));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	
}
