package afero.persistence;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import afero.model.Usuario;

public class UsuarioDAO implements IUsuarioDAO{
	
	private Connection conn;

	public UsuarioDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;		
	}

	public void incluir(Usuario usuario) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (usuario == null)
			throw new AferoDAOException(
					"O valor passado n�o pode ser nulo");

		try {
		    String sql = "INSERT INTO tbusuario(idGrupoUsuario, email, login, senha, status, dtCad, dtMod, usuario) VALUES (?, ?, ?, ?, ?, now(), now(), ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, usuario.getIdGrupoUsuario());
			ps.setString(2, usuario.getEmail());
			ps.setString(3, usuario.getLogin());
			ps.setString(4, usuario.getSenha());
			ps.setString(5, usuario.getStatus());
			ps.setString(6, usuario.getUsuario());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(Usuario usuario) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (usuario == null)
			throw new AferoDAOException(
					"O valor passado n�o pode ser nulo");

		try {
			String sql = "UPDATE tbusuario SET idGrupoUsuario = ?, email = ?, login = ?, senha = ?, status = ?, dtMod = now(), usuario = ? Where idUsuario = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, usuario.getIdGrupoUsuario());
			ps.setString(2, usuario.getEmail());
			ps.setString(3, usuario.getLogin());
			ps.setString(4, usuario.getSenha());
			ps.setString(5, usuario.getStatus());
			ps.setString(6, usuario.getUsuario());
			ps.setInt(7, usuario.getIdUsuario());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void excluir(Usuario usuario) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (usuario == null)
			throw new AferoDAOException(
					"O valor passado n�o pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbusuario WHERE idUsuario=?");
			ps.setInt(1, usuario.getIdUsuario());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public Usuario procurarUsuario(int idUsuario) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		Usuario usuario = null;

		try {
			String sql = "SELECT idUsuario, idGrupoUsuario, email, login, senha, status, dtCad, dtMod, usuario FROM tbusuario WHERE idUsuario=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idUsuario);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("N�o foi encontrado nenhum "
						+ "registro com o c�d.setor: " + idUsuario);
			}

			int idGrupoUsuario = rs.getInt(2);
			String email = rs.getString(3);
			String login = rs.getString(4);
			String senha = rs.getString(5);
			String status = rs.getString(6);
			Date dtCad = rs.getDate(7);
			Date dtMod = rs.getDate(8);
			String usuarioMod = rs.getString(9);
			usuario = new Usuario(idUsuario, idGrupoUsuario, email, login, senha, status, dtCad, dtMod, usuarioMod);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return usuario;
	}

	public List listarUsuario(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<Usuario> list = null;
		
		try {
			String sql = "SELECT idUsuario, idGrupoUsuario, email, login, senha, status, dtCad, dtMod, usuario FROM tbusuario ";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<Usuario>();
			while (rs.next()) {
				
				int idUsuario = rs.getInt(1);
				int idGrupoUsuario = rs.getInt(2);
				String email = rs.getString(3);
				String login = rs.getString(4);
				String senha = rs.getString(5);
				String status = rs.getString(6);
				Date dtCad = rs.getDate(7);
				Date dtMod = rs.getDate(8);
				String usuario = rs.getString(9);
				list.add(new Usuario(idUsuario, idGrupoUsuario, email, login, senha, status, dtCad, dtMod, usuario));
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	
	public int procurarLogin(String login) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
	    int idUsuario = 0;

		try {
			String sql = "SELECT idUsuario FROM tbusuario WHERE login = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, login);
			rs = ps.executeQuery();
			if (!rs.next()) {
				idUsuario = 0;
			}else{
				idUsuario = rs.getInt(1);	
			}
			

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return idUsuario;
	}
	
	public boolean procurarExisteLogin(String login) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
	    boolean ok = true;

		try {
			String sql = "SELECT idUsuario FROM tbusuario WHERE login = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, login);
			rs = ps.executeQuery();
			if (!rs.next()) {
				ok = false;
			}
		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return ok;
	}
	
	public Usuario validarLogin(Usuario usuario) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		Usuario user = null;

		try {
			String sql = "SELECT idUsuario, idGrupoUsuario, email, login, senha, status, dtCad, dtMod, usuario FROM tbusuario WHERE login = ? and senha = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, usuario.getLogin());
			ps.setString(2, usuario.getSenha());
			rs = ps.executeQuery();
			if (!rs.next()) {
				user = null;
			} else {
				int idUsuario = rs.getInt(1);
				int idGrupoUsuario = rs.getInt(2);
				String email = rs.getString(3);
				String login = rs.getString(4);
				String senha = rs.getString(5);
				String status = rs.getString(6);
				Date dtCad = rs.getDate(7);
				Date dtMod = rs.getDate(8);
				String usuarioMod = rs.getString(9);
				user = new Usuario(idUsuario, idGrupoUsuario, email, login, senha, status, dtCad, dtMod, usuarioMod);
			}
		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return user;
	}
	public boolean exclusaoIdUsuario(int idUsuario) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = true;
		try {
			String sql = "select idUsuario from tbcolaborador where idUsuario =?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idUsuario);
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
