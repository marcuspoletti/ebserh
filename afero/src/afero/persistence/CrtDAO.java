package afero.persistence;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import afero.model.Crt;


public class CrtDAO {
	
	
	private Connection conn;

	public CrtDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;
	}

	public void incluir(Crt crt) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (crt == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbcrt (codigo, descricao) "
					+ "VALUES (?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, crt.getCodigo());
			ps.setString(2, crt.getDescricao());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} 
	}

	public void atualizar(Crt crt) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (crt == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbcrt SET codigo=?, descricao=?  "
					+ "WHERE idCrt=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, crt.getCodigo());
			ps.setString(2, crt.getDescricao());
			ps.setInt(3, crt.getIdCrt());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} 
	}

	public void excluir(Crt crt) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (crt == null)
			throw new AferoDAOException(
					"O valor passado n�o pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbcrt WHERE idCrt=?");
			ps.setInt(1, crt.getIdCrt());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} 

	}

	public Crt procurarCrt(int idCrt) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		Crt crt = null;

		try {
			String sql = "SELECT codigo, Descricao FROM tbcrt "
				+ "WHERE idCrt=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idCrt);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("N�o foi encontrado nenhum "
						+ "registro com o c�digo: " + idCrt);
			}
            
			int codigo = rs.getInt(1);
			String descricao  = rs.getString(2);
			

			crt = new Crt(idCrt, codigo, descricao);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return crt;
	}

	
	public List listarCrt(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<Crt> list = null;
		
		try {
			String sql = "SELECT idCrt, codigo, descricao status FROM tbcrt ";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<Crt>();
			while (rs.next()) {
				int idCrt = rs.getInt(1);
				int codigo = rs.getInt(2);
				String descricao = rs.getString(3);
				
				
				list.add(new Crt(idCrt, codigo, descricao));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return list;
	}
	
	public boolean exclusaoIdCrt(int idCrt) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = true;
		try {
			String sql = "select idCrt from tbloja where idCrt = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idCrt);
			rs = ps.executeQuery();
			if(rs.next()) {
			   ok=true;
			}else{
				ok=false;
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return ok;
		
	}
	

}
