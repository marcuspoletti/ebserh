package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import afero.model.Cnae;

public class CnaeDAO {
	
	private Connection conn;

	public CnaeDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;
	}

	public void incluir(Cnae cnae) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (cnae == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbcnae (secao, divisao, grupo, classe, subclasse, denominacao) "
					+ "VALUES (?, ?, ?, ?, ?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, cnae.getSecao());
			ps.setString(2, cnae.getDivisao());
			ps.setString(3, cnae.getGrupo());
			ps.setString(4, cnae.getClasse());
			ps.setString(5, cnae.getSubclasse());
			ps.setString(6, cnae.getDenominacao());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} 
	}

	public void atualizar(Cnae cnae) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (cnae == null)
			throw new AferoDAOException(
					"O valor passado n�o pode ser nulo");

		try {
			String sql = "UPDATE tbcnae SET secao = ?, divisao = ?, grupo = ?, classe = ?, subclasse = ?, denominacao = ? "
					+ "WHERE idCnae = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, cnae.getSecao());
			ps.setString(2, cnae.getDivisao());
			ps.setString(3, cnae.getGrupo());
			ps.setString(4, cnae.getClasse());
			ps.setString(5, cnae.getSubclasse());
			ps.setString(6, cnae.getDenominacao());
			ps.setInt(7, cnae.getIdCnae());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} 
	}

	public void excluir(Cnae cnae) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (cnae == null)
			throw new AferoDAOException(
					"O valor passado n�o pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbcnae WHERE idCnae=?");
			ps.setInt(1, cnae.getIdCnae());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} 

	}

	

	public Cnae procurarCnae(int idCnae) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		Cnae cnae = null;

		try {
			String sql = "SELECT secao, divisao, grupo, classe, subclasse, denominacao FROM tbcnae "
				+ "WHERE idCnae=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idCnae);
			rs = ps.executeQuery();
			if (rs.next()) {
				String secao = rs.getString(1);
				String divisao = rs.getString(2);
				String grupo = rs.getString(3);
				String classe = rs.getString(4);
				String subclasse = rs.getString(5);
				String denominacao = rs.getString(6);

				cnae = new Cnae(idCnae, secao, divisao, grupo, classe, subclasse, denominacao);
			}            

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return cnae;
	}

	public List listarCnae(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<Cnae> list = null;
		
		try {
			String sql = "SELECT idCnae, secao, divisao, grupo, classe, subclasse, denominacao FROM tbcnae ";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<Cnae>();
			while (rs.next()) {
				Integer idCnae = rs.getInt(1);
				String secao = rs.getString(2);
				String divisao = rs.getString(3);
				String grupo = rs.getString(4);
				String classe = rs.getString(5);
				String subclasse = rs.getString(6);
				String denominacao = rs.getString(7);
				
				list.add(new Cnae(idCnae, secao, divisao, grupo, classe, subclasse, denominacao));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return list;
	}
	public boolean exclusaoIdCnae(int idCnae) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = true;
		try {
			String sql = "select idCnae from tbloja where idCnae = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idCnae);
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