package afero.persistence;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import afero.model.Unidade;

public class UnidadeDAO implements IUnidadeDAO{
	private Connection conn;

	public UnidadeDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;		
	}

	public void incluir(Unidade unidade) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (unidade == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbunidade(dsUnidade, dtCad, dtMod, status, usuario) "
					+ "VALUES (?, now(), now(), ?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, unidade.getDsUnidade());
			ps.setString(2, unidade.getStatus());
			ps.setString(3, unidade.getUsuario());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(Unidade unidade) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (unidade == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbunidade SET dsUnidade=?, status=?, usuario=? "
					+ "WHERE idUnidade=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, unidade.getDsUnidade());
			ps.setString(2, unidade.getStatus());
			ps.setString(3, unidade.getUsuario());
			ps.setInt(4, unidade.getIdUnidade());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void excluir(Unidade unidade) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (unidade == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbunidade WHERE idUnidade=?");
			ps.setInt(1, unidade.getIdUnidade());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public Unidade procurarUnidade(int idUnidade) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		Unidade unidade = null;

		try {
			String sql = "SELECT dsUnidade, dtCad, dtMod, status, usuario FROM tbunidade "
				+ "WHERE idUnidade=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idUnidade);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o cód.setor: " + idUnidade);
			}
            
			String dsUnidade  = rs.getString(1);
			Date dtCad =  rs.getDate(2);
			Date dtMod =rs.getDate(3);
			String status = rs.getString(4);
			String usuario = rs.getString(5);

			unidade = new Unidade(idUnidade, dsUnidade, dtCad, dtMod, status, usuario);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return unidade;
	}

	public List listarUnidade(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<Unidade> list = null;
		
		try {
			String sql = "SELECT idUnidade, dsUnidade, dtCad, dtMod, status, usuario FROM tbunidade ";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<Unidade>();
			while (rs.next()) {
				int idUnidade = rs.getInt(1);
				String dsUnidade  = rs.getString(2);
				Date dtCad =  rs.getDate(3);
				Date dtMod =rs.getDate(4);
				String status = rs.getString(5);
				String usuario = rs.getString(6);
				
				list.add(new Unidade(idUnidade, dsUnidade, dtCad, dtMod, status,usuario));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	public boolean exclusaIdUnidade(int idUnidade) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = true;

		try {
			String sql = "select u.idUnidade " +
			             "from tbunidade u " +
			             "join tbpreco p on (u.idUnidade = p.idUnidade) " +
			             "where u.idUnidade = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idUnidade);
			rs = ps.executeQuery();
			if (rs.next()) {
				ok = true;
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
