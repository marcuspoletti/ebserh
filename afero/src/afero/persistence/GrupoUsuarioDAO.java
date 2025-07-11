package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import afero.model.GrupoUsuario;

public class GrupoUsuarioDAO implements IGrupoUsuarioDAO{
	private Connection conn;

	public GrupoUsuarioDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;
	}

	public void incluir(GrupoUsuario grupoUsuario) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (grupoUsuario == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
		    String sql = "INSERT INTO tbgrupousuario(dsGrupoUsuario, status)VALUES (?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, grupoUsuario.getDsGrupoUsuario());
			ps.setString(2, grupoUsuario.getStatus());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(GrupoUsuario grupoUsuario) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (grupoUsuario == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbgrupousuario SET dsGrupoUsuario = ?, status = ? Where idGrupoUsuario = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, grupoUsuario.getDsGrupoUsuario());
			ps.setString(2, grupoUsuario.getStatus());
			ps.setInt(3, grupoUsuario.getIdGrupoUsuario());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void excluir(GrupoUsuario grupoUsuario) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (grupoUsuario == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbgrupousuario WHERE idGrupoUsuario = ?");
			ps.setInt(1, grupoUsuario.getIdGrupoUsuario());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public GrupoUsuario procurarGrupoUsuario(int idGrupoUsuario) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		GrupoUsuario grupoUsuario = null;

		try {
			String sql = "SELECT dsGrupoUsuario, status FROM tbgrupousuario WHERE idGrupoUsuario=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idGrupoUsuario);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o cód.setor: " + idGrupoUsuario);
			}

			String dsGrupoUsuario = rs.getString(1);
			String status = rs.getString(2);
			

			grupoUsuario = new GrupoUsuario(idGrupoUsuario, dsGrupoUsuario, status);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return grupoUsuario;
	}

	public List listarGrupoUsuario(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<GrupoUsuario> list = null;
		
		try {
			String sql = "SELECT idGrupoUsuario, dsGrupoUsuario, status FROM tbgrupousuario";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<GrupoUsuario>();
			while (rs.next()) {
				
				int idGrupoUsuario = rs.getInt(1);
				String dsGrupoUsuario = rs.getString(2);
				String status = rs.getString(3);
				
				list.add(new GrupoUsuario(idGrupoUsuario, dsGrupoUsuario, status));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}


}
