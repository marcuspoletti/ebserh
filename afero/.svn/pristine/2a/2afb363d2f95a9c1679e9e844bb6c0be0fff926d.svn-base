package afero.persistence;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import afero.model.TipoDocumento;

public class TipoDocumentoDAO implements ITipoDocumentoDAO{
	private Connection conn;

	public TipoDocumentoDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;		
	}

	public void incluir(TipoDocumento tipoDocumento) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (tipoDocumento == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbtipodocumento(dsTipoDocumento, cdTipoDocumento, status) "
					+ "VALUES (?, ?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, tipoDocumento.getDsTipoDocumento());
			ps.setString(2, tipoDocumento.getCdTipoDocumento());
			ps.setString(3, tipoDocumento.getStatus());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(TipoDocumento tipoDocumento) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (tipoDocumento == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbtipodocumento SET dsTipoDocumento = ?, cdTipoDocumento = ?, status = ? "
					+ "WHERE idTipoDocumento=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, tipoDocumento.getDsTipoDocumento());
			ps.setString(2, tipoDocumento.getCdTipoDocumento());
			ps.setString(3, tipoDocumento.getStatus());
			ps.setInt(4, tipoDocumento.getIdTipoDocumento());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void excluir(TipoDocumento tipoDocumento) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (tipoDocumento == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbtipodocumento WHERE idTipoDocumento=?");
			ps.setInt(1, tipoDocumento.getIdTipoDocumento());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public TipoDocumento procurarTipoDocumento(int idTipoDocumento) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		TipoDocumento tipoDocumento = null;

		try {
			String sql = "SELECT idTipoDocumento, dsTipoDocumento, cdTipoDocumento, status FROM tbtipodocumento "
				+ "WHERE idTipoDocumento=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idTipoDocumento);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o cód.setor: " + idTipoDocumento);
			}
            int cTipoDocumento  = rs.getInt(1);
			String dsTipoDocumento  = rs.getString(2);
			String cdTipoDocumento  = rs.getString(3);
			String status = rs.getString(4);

			tipoDocumento = new TipoDocumento(cTipoDocumento, dsTipoDocumento, cdTipoDocumento, status);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return tipoDocumento;
	}

	public List listarTipoDocumento(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<TipoDocumento> list = null;
		
		try {
			String sql = "SELECT idTipoDocumento, dsTipoDocumento, cdTipoDocumento, status FROM tbtipodocumento ";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<TipoDocumento>();
			while (rs.next()) {
				int    idTipoDocumento  = rs.getInt(1);
				String dsTipoDocumento  = rs.getString(2);
				String cdTipoDocumento  = rs.getString(3);
				String status = rs.getString(4);
				
				list.add(new TipoDocumento(idTipoDocumento, dsTipoDocumento, cdTipoDocumento, status));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	public boolean exclusaoIdTipoDocumento(int idTipoDocumento) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = true;
		try {
			String sql = "select td.idTipoDocumento "+
                         "from tbtipodocumento td "+
		                 "join tbduplicata d on td.idTipoDocumento =  d.idTipoDocumento "+
                         "where td.idTipoDocumento = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idTipoDocumento);
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
