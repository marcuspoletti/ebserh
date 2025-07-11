package afero.persistence;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import afero.model.Grupo;

public class GrupoDAO implements IGrupoDAO{
	
	private Connection conn;

	public GrupoDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;
	}

	public void incluir(Grupo grupo) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (grupo == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbgrupo (dsGrupo, dtCad, dtMod, status, usuario) "
					+ "VALUES (?, now(), now(), ?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, grupo.getDsGrupo());
			ps.setString(2, grupo.getStatus());
			ps.setString(3, grupo.getUsuario());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(Grupo grupo) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (grupo == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbgrupo SET dsGrupo=?, dtMod=now(), status=?, usuario=? "
					+ "WHERE idGrupo=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, grupo.getDsGrupo());
			ps.setString(2, grupo.getStatus());
			ps.setString(3, grupo.getUsuario());
			ps.setInt(4, grupo.getIdGrupo());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void excluir(Grupo grupo) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (grupo == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbgrupo WHERE idGrupo=?");
			ps.setInt(1, grupo.getIdGrupo());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public Grupo procurarGrupo(int idGrupo) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		Grupo grupo = null;

		try {
			String sql = "SELECT dsGrupo, dtCad, dtMod, status, usuario FROM tbgrupo "
				+ "WHERE idGrupo=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idGrupo);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o cód.setor: " + idGrupo);
			}
            
			String dsGrupo = rs.getString(1); 
		    Date dtCad = rs.getDate(2);
		    Date dtMod = rs.getDate(3);
		    String status = rs.getString(4);
		    String usuario = rs.getString(5);

			grupo = new Grupo(idGrupo, dsGrupo, dtCad, dtMod, status, usuario);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return grupo;
	}

	public List listarGrupo(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<Grupo> list = null;
		
		try {
			String sql = "SELECT idGrupo, dsGrupo, dtCad, dtMod, status, usuario FROM tbgrupo ";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<Grupo>();
			while (rs.next()) {
				int idGrupo = rs.getInt(1);
				String dsGrupo = rs.getString(2); 
			    Date dtCad = rs.getDate(3);
			    Date dtMod = rs.getDate(4);
			    String status = rs.getString(5);
			    String usuario = rs.getString(6);
				
				list.add(new Grupo(idGrupo, dsGrupo, dtCad, dtMod, status, usuario));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	public boolean exclusaoIdGrupo(int idGrupo) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = true;

		try {
			String sql = "SELECT idSubGrupo from tbsubgrupo "
				+ "WHERE idGrupo=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idGrupo);
			rs = ps.executeQuery();
			if (rs.next()) {
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
