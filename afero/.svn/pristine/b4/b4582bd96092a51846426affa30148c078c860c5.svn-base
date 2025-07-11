package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import afero.model.RamoAtividade;

public class RamoAtividadeDAO implements IRamoAtividadeDAO {
	
	private Connection conn;

	public RamoAtividadeDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;		
	}

	public void incluir(RamoAtividade ramoAtividade) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (ramoAtividade == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbramoatividade (dsRamoAtividade, status) "
					+ "VALUES (?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, ramoAtividade.getDsRamoAtividade());
			ps.setString(2, ramoAtividade.getStatus());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(RamoAtividade ramoAtividade) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (ramoAtividade == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbramoatividade SET dsRamoAtividade=?, status=? "
					+ "WHERE idRamoAtividade=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, ramoAtividade.getDsRamoAtividade());
			ps.setString(2, ramoAtividade.getStatus());
			ps.setInt(3, ramoAtividade.getIdRamoAtividade());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void excluir(RamoAtividade ramoAtividade) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (ramoAtividade == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM  tbramoatividade WHERE idRamoAtividade=?");
			ps.setInt(1, ramoAtividade.getIdRamoAtividade());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public RamoAtividade procurarRamoAtividade(int idRamoAtividade) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		RamoAtividade ramoAtividade = null;

		try {
			String sql = "SELECT idRamoAtividade, dsRamoAtividade, status FROM tbramoatividade "
				+ "WHERE idRamoAtividade = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idRamoAtividade);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + idRamoAtividade);
			}

			String dsRamoAtividade  = rs.getString(2);
			String status = rs.getString(3);

			ramoAtividade = new RamoAtividade(idRamoAtividade, dsRamoAtividade, status);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return ramoAtividade;
	}

	public List listarRamoAtividade(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<RamoAtividade> list = null;
		
		try {
			String sql = "SELECT idRamoAtividade, dsRamoAtividade, status FROM tbramoatividade ";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<RamoAtividade>();
			while (rs.next()) {
				int idRamoAtividade = rs.getInt(1);
				String dsRamoAtividade = rs.getString(2);
				String status = rs.getString(3);
				
				list.add(new RamoAtividade(idRamoAtividade, dsRamoAtividade, status));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
}
