package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import afero.model.Regiao;

public class RegiaoDAO implements IRegiaoDAO {
	
	private Connection conn;

	public RegiaoDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;		
	}

	public void incluir(Regiao regiao) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (regiao == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbregiao (nmRegiao, status) "
					+ "VALUES (?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, regiao.getNmRegiao());
			ps.setString(2, regiao.getStatus());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}
	}

	public void atualizar(Regiao regiao) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (regiao == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbregiao SET nmRegiao=?, status=? "
					+ "WHERE cdRegiao=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, regiao.getNmRegiao());
			ps.setString(2, regiao.getStatus());
			ps.setInt(3, regiao.getCdRegiao());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}
	}

	public void excluir(Regiao regiao) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (regiao == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbregiao WHERE cdRegiao=?");
			ps.setInt(1, regiao.getCdRegiao());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}
	}

	public Regiao procurarRegiao(int cdRegiao) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		Regiao regiao = null;

		try {
			String sql = "SELECT cdRegiao, nmRegiao, status FROM tbregiao "
				+ "WHERE cdRegiao=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cdRegiao);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + cdRegiao);
			}
            
			String nmRegiao  = rs.getString(2);
			String status = rs.getString(3);

			regiao = new Regiao(cdRegiao, nmRegiao, status);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return regiao;
	}

	public List listarRegiao(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<Regiao> list = null;
		
		try {
			String sql = "SELECT cdRegiao, nmRegiao, status FROM tbregiao ";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<Regiao>();
			while (rs.next()) {
				int cdRegiao = rs.getInt(1);
				String nmRegiao = rs.getString(2);
				String status = rs.getString(3);
				
				list.add(new Regiao(cdRegiao, nmRegiao, status));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}

}
