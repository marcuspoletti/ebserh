package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import afero.model.LogUsuario;
import afero.util.ConverteDate;

public class LogUsuarioDAO {
	
	public Connection conn;

	public LogUsuarioDAO(Connection conn) {
		this.conn = conn;
	}
	
	// INSERIR
	
	public void incluir(LogUsuario logUsuario) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (logUsuario == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");
		
		try {
			String sql = "INSERT INTO tblogusuario (idLoja, usuario, dtAcesso, dtSaida)" +
						"VALUES (?, ?, now(), now())";
			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, logUsuario.getIdLoja());
			ps.setString(2, logUsuario.getUsuario());
			
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e.getStackTrace());
		} 
	}
	public void incluirSaida(LogUsuario logUsuario) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (logUsuario == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");
		
		try {
			String sql = "INSERT INTO tblogusuario (idLoja, usuario, dtAcesso, dtSaida)" +
						"VALUES (?, ?, now(), now())";
			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, logUsuario.getIdLoja());
			ps.setString(2, logUsuario.getUsuario());
			
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e.getStackTrace());
		} 
	}

	// ATUALIZAR 
	
	public void atualiza(LogUsuario logUsuario) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (logUsuario == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");
		
		try {
			String sql = "UPDATE tblogusuario set idLoja = ?, usuario = ?, dtSaida = now()" +
						"WHERE idLogUsuario = ?";
			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, logUsuario.getIdLoja());
			ps.setString(2, logUsuario.getUsuario());
			ps.setInt(3, logUsuario.getIdLogUsuario());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao atualizar dados: " + e.getStackTrace());
		} 
	}
	

	
	// BUSCAR
	
	
	public List<LogUsuario> listarTarefa(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<LogUsuario> list = null;

		try {
			String sql = "SELECT idLogUsuario, idLoja, usuario, dtAcesso, dtSaida " +
						 "FROM tblogusuario ";
			
			if (clausula != null)
				sql += clausula;
			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<LogUsuario>();
			
			while (rs.next()){
				
				int idLogUsuario = rs.getInt(1);
				int idLoja = rs.getInt(2);
				String usuario = rs.getString(3);
				Date dtAcesso = rs.getDate(4);
				Date dtSaida = rs.getDate(5);
				
				
				list.add( new LogUsuario(idLogUsuario, idLoja, usuario, dtAcesso, dtSaida));
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao listar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao listar dados: " + e.getStackTrace());
		} 
		return list;
	}
}