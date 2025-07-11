package afero.persistence;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import afero.model.Divisao;

public class DivisaoDAO implements IDivisaoDAO{

	private Connection conn;

	public DivisaoDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;
	}

	public void incluir(Divisao divisao) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (divisao == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbdivisao(idSubGrupo, idGrupo, dsDivisao, dtCad, dtMod, status, usuario)VALUES (?, ?, ?, now(), now(), ?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, divisao.getIdSubGrupo());
			ps.setInt(2, divisao.getIdGrupo());
			ps.setString(3, divisao.getDsDivisao());
			ps.setString(4, divisao.getStatus());
			ps.setString(5, divisao.getUsuario());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}
	}

	public void atualizar(Divisao divisao) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (divisao == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbdivisao SET idSubGrupo = ?, idGrupo = ?, dsDivisao = ?, dtMod = now(), status = ?, usuario = ? WHERE idDivisao = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, divisao.getIdSubGrupo());
			ps.setInt(2, divisao.getIdGrupo());
			ps.setString(3, divisao.getDsDivisao());
			ps.setString(4, divisao.getStatus());
			ps.setString(5, divisao.getUsuario());
			ps.setInt(6, divisao.getIdDivisao());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}
	}

	public void excluir(Divisao divisao) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (divisao == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbdivisao WHERE idDivisao=?");
			ps.setInt(1, divisao.getIdDivisao());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public Divisao procurarDivisao(int idDivisao) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		Divisao divisao = null;

		try {
			String sql = "SELECT idDivisao, idSubGrupo, idGrupo, dsDivisao, dtCad, dtMod, status, usuario FROM tbdivisao WHERE idDivisao=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idDivisao);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o cód.setor: " + idDivisao);
			}
            
			int idSubGrupo = rs.getInt(2);
			int idGrupo = rs.getInt(3);
			String dsDivisao = rs.getString(4);
			Date dtCad = rs.getDate(5);
			Date dtMod= rs.getDate(6);
			String status = rs.getString(7);
			String usuario = rs.getString(8);

			divisao = new Divisao(idDivisao, idSubGrupo, idGrupo, dsDivisao, dtCad,
					dtMod, status, usuario);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return divisao;
	}
	
	public int retornarIdGrupo(int cdDivisao)throws AferoDAOException{
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		int idGrupo = 0;
		try {
			String sql = "SELECT idGrupo FROM tbdivisao where idDivisao = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cdDivisao);
			rs = ps.executeQuery();
			while (rs.next()) {
				idGrupo = rs.getInt(1); 

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return idGrupo;
	}
		
	public List listarDivisao(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<Divisao> list = null;
		
		try {
			String sql = "SELECT idDivisao, idSubGrupo, idGrupo, dsDivisao, dtCad, dtMod, status, usuario FROM tbdivisao";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<Divisao>();
			while (rs.next()) {
				int idDivisao = rs.getInt(1);
				int idSubGrupo = rs.getInt(2);
				int idGrupo = rs.getInt(3);
				String dsDivisao = rs.getString(4);
				Date dtCad = rs.getDate(5);
				Date dtMod= rs.getDate(6);
				String status = rs.getString(7);
				String usuario = rs.getString(8);
				
				list.add(new Divisao(idDivisao, idSubGrupo, idGrupo, dsDivisao, dtCad,
						dtMod, status, usuario));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	
	public boolean exclusaoIdDivisao(int idDivisao) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = false;

		try {
			String sql = "select d.idDivisao from tbdivisao d "+
                         "join tbproduto p on (d.idDivisao = p.idDivisao) " +
                         "where d.idDivisao = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idDivisao);
			rs = ps.executeQuery();
			if (rs.next()) {
				ok=true;
			}else{
				ok = false;
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return ok;
	}
	public boolean AtualizarIdDivisao(int idDivisao, int idGrupo, int idSubGrupo) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = false;

		try {
			String sql = "select distinct(idDivisao) from tbproduto where idDivisao = ? and idGrupo = ? and idSubGrupo = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idDivisao);
			ps.setInt(2, idGrupo);
			ps.setInt(3, idSubGrupo);
			rs = ps.executeQuery();
			if (rs.next()) {
				ok=true;
			}else{
				ok = false;
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return ok;
	}
}
