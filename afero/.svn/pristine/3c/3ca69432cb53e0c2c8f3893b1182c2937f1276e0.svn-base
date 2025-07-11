package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import afero.model.TipoEndereco;

public class TipoEnderecoDAO implements ITipoEnderecoDAO {
	
	private Connection conn;

	public TipoEnderecoDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;		
	}

	public void incluir(afero.model.TipoEndereco tipoEndereco) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (tipoEndereco == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbtipoendereco (cdTipoEndereco, dsTipoEndereco, status) "
					+ "VALUES (?, ?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, tipoEndereco.getCdTipoEndereco());
			ps.setString(2, tipoEndereco.getDsTipoEndereco());
			ps.setString(3, tipoEndereco.getStatus());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(afero.model.TipoEndereco tipoEndereco) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (tipoEndereco == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbtipoendereco SET cdTipoEndereco=?, dsTipoEndereco=?, status=? "
					+ "WHERE cdTipoEndereco=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, tipoEndereco.getCdTipoEndereco());
			ps.setString(2, tipoEndereco.getDsTipoEndereco());
			ps.setString(3, tipoEndereco.getStatus());
			ps.setInt(4, tipoEndereco.getCdTipoEndereco());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void excluir(TipoEndereco tipoEndereco) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (tipoEndereco == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbtipoendereco WHERE cdTipoEndereco=?");
			ps.setInt(1, tipoEndereco.getCdTipoEndereco());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public TipoEndereco procurarTipoEndereco(int cdTipoEndereco) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		TipoEndereco tipoEndereco = null;

		try {
			String sql = "SELECT cdTipoEndereco, dsTipoEndereco, status FROM tbtipoendereco "
				+ "WHERE cdTipoEndereco=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, tipoEndereco.getCdTipoEndereco());
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + cdTipoEndereco);
			}
            
			String dsTipoEndereco  = rs.getString(2);
			String status = rs.getString(3);

			tipoEndereco = new TipoEndereco(cdTipoEndereco, dsTipoEndereco, status);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return tipoEndereco;
	}

	public List listarTipoEndereco(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<TipoEndereco> list = null;
		
		try {
			String sql = "SELECT cdTipoEndereco, dsTipoEndereco, status FROM tbtipoendereco ";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<TipoEndereco>();
			while (rs.next()) {
				int cdTipoEndereco= rs.getInt(1);
				String dsTipoEndereco = rs.getString(2);
				String status = rs.getString(3);
				
				list.add(new TipoEndereco(cdTipoEndereco, dsTipoEndereco, status));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}

}
