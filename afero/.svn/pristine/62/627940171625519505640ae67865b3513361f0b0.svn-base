package afero.persistence;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import afero.model.TipoFrequencia;
public class TipoFrequenciaDAO implements ITipoFrequenciaDAO{
	private Connection conn;

	public TipoFrequenciaDAO (Connection conn) throws AferoDAOException {
		this.conn = conn;
	}

	public void incluir(TipoFrequencia tipoFrequencia) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (tipoFrequencia == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbtipofrequencia (dsTipoFrequencia, status) "
					+ "VALUES (?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, tipoFrequencia.getDsTipoFrequencia());
			ps.setString(2, tipoFrequencia.getStatus());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(TipoFrequencia tipoFrequencia) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (tipoFrequencia == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbtipofrequencia SET dsTipoFrequencia = ?, status = ? "
					+ "WHERE cdTipoFrequencia = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, tipoFrequencia.getDsTipoFrequencia());
			ps.setString(2, tipoFrequencia.getStatus());
			ps.setInt(3, tipoFrequencia.getCdTipoFrequencia());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void excluir(TipoFrequencia tipoFrequencia) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (tipoFrequencia == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbtipofrequencia WHERE cdTipoFrequencia=?");
			ps.setInt(1, tipoFrequencia.getCdTipoFrequencia());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public TipoFrequencia procurarTipoFrequencia(int cdTipoFrequencia) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		TipoFrequencia tipoFrequencia = null;

		try {
			String sql = "SELECT cdTipoFrequencia, dsTipoFrequencia, status FROM tbtipofrequencia "
				+ "WHERE cdTipoFrequencia=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cdTipoFrequencia);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + cdTipoFrequencia);
			}
            
			int idTipoFrequencia = rs.getInt(1);
			String dsTipoFrequencia  = rs.getString(2);
			String status = rs.getString(3);

			tipoFrequencia = new TipoFrequencia(idTipoFrequencia,dsTipoFrequencia,status);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return tipoFrequencia;
	}

	public List listarTipoFrequencia(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<TipoFrequencia> list = null;
		
		try {
			String sql = "SELECT cdTipoFrequencia, dsTipoFrequencia, status FROM tbtipofrequencia ";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<TipoFrequencia>();
			while (rs.next()) {
				int idTipoFrequencia = rs.getInt(1);
				String dsTipoFrequencia  = rs.getString(2);
				String status = rs.getString(3);
				
				list.add(new TipoFrequencia(idTipoFrequencia,dsTipoFrequencia,status));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	public boolean exclusaoCdTipoFrequencia(int cdTipoFrequencia) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = true;
		try {
			String sql = "select tf.cdTipoFrequencia from tbtipofrequencia tf join tbtransferencia t on tf.cdTipoFrequencia = t.cdTipoFrequencia where tf.cdTipoFrequencia = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cdTipoFrequencia);
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
