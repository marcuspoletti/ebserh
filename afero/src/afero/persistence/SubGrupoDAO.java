package afero.persistence;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import afero.model.SubGrupo;

public class SubGrupoDAO implements ISubGrupoDAO{
	private Connection conn;

	public SubGrupoDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;		
	}

	public void incluir(SubGrupo subGrupo) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (subGrupo == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
		    String sql = "INSERT INTO tbsubgrupo(idGrupo, dsSubGrupo, dtCad, dtMod, status, usuario)VALUES (?, ?, now(), now(), ?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, subGrupo.getIdGrupo());
			ps.setString(2,subGrupo.getDsSubGrupo());
			ps.setString(3, subGrupo.getStatus());
			ps.setString(4, subGrupo.getUsuario());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(SubGrupo subGrupo) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (subGrupo == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbsubgrupo SET idGrupo = ?, dsSubGrupo=?, dtMod = now(), status = ?, usuario = ? Where idSubGrupo = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, subGrupo.getIdGrupo());
			ps.setString(2, subGrupo.getDsSubGrupo());
			ps.setString(3, subGrupo.getStatus());
			ps.setString(4, subGrupo.getUsuario());
			ps.setInt(5, subGrupo.getIdSubGrupo());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void excluir(SubGrupo subGrupo) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (subGrupo == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbsubgrupo WHERE idSubGrupo=?");
			ps.setInt(1, subGrupo.getIdSubGrupo());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public SubGrupo procurarSubGrupo(int idSubGrupo) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		SubGrupo subGrupo = null;

		try {
			String sql = "SELECT idSubGrupo, idGrupo, dsSubGrupo, dtCad, dtMod, status, usuario FROM tbsubgrupo WHERE idSubGrupo=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idSubGrupo);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o cód.setor: " + idSubGrupo);
			}

		    int idGrupo = rs.getInt(2);
		    String dsSubGrupo = rs.getString(3);
		    Date dtCad = rs.getDate(4);
		    Date dtMod = rs.getDate(5);
		    String status = rs.getString(6);
		    String usuario = rs.getString(7);
			

			subGrupo = new SubGrupo(idSubGrupo, idGrupo, dsSubGrupo, dtCad, dtMod, status, usuario);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return subGrupo;
	}

	public List listarSubGrupo(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<SubGrupo> list = null;
		
		try {
			String sql = "SELECT idSubGrupo, idGrupo, dsSubGrupo, dtCad, dtMod, status, usuario FROM tbsubgrupo";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<SubGrupo>();
			while (rs.next()) {
				
				    int idSubGrupo = rs.getInt(1);
				    int idGrupo = rs.getInt(2);
				    String dsSubGrupo = rs.getString(3);
				    Date dtCad = rs.getDate(4);
				    Date dtMod = rs.getDate(5);
				    String status = rs.getString(6);
				    String usuario = rs.getString(7);
				
				list.add(new SubGrupo(idSubGrupo, idGrupo, dsSubGrupo, dtCad, dtMod, status, usuario));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	public boolean exclusaoIdSubGrupo(int idSubGrupo) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = true;
		try {
			String sql = "SELECT idDivisao FROM tbdivisao WHERE idSubGrupo=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idSubGrupo);
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
	public boolean AtualizarIdSubGrupo(int idSubGrupo, int idGrupo) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = true;
		try {
			String sql = "SELECT idDivisao FROM tbdivisao WHERE idSubGrupo=? and idGrupo=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idSubGrupo);
			ps.setInt(2, idGrupo);
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
