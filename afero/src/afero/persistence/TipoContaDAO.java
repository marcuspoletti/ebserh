package afero.persistence;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import afero.model.TipoConta;
public class TipoContaDAO implements ITipoContaDAO{
	private Connection conn;

	public TipoContaDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;
	}

	public void incluir(TipoConta tipoConta) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (tipoConta == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbtipoconta (dsTipoConta, status) "
					+ "VALUES (?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, tipoConta.getDsTipoConta());
			ps.setString(2, tipoConta.getStatus());
			
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(TipoConta tipoConta) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (tipoConta == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbtipoconta SET dsTipoConta= ?, status=? "
					+ "WHERE idTipoConta=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, tipoConta.getDsTipoConta());
			ps.setString(2, tipoConta.getStatus());
			ps.setInt(3, tipoConta.getIdTipoConta());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void excluir(TipoConta tipoConta) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (tipoConta == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbtipoconta WHERE idTipoConta=?");
			ps.setInt(1, tipoConta.getIdTipoConta());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public TipoConta procurarTipoConta(int idTipoConta) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		TipoConta tipoConta = null;

		try {
			String sql = "SELECT idTipoConta, dsTipoConta, status FROM tbtipoconta "
				+ "WHERE idTipoConta=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idTipoConta);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + idTipoConta);
			}
            
			int cdTipoConta = rs.getInt(1);
			String dsTipoConta  = rs.getString(2);
			String status = rs.getString(3);

			tipoConta = new TipoConta(cdTipoConta, dsTipoConta, status);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return tipoConta;
	}

	public List listarTipoConta(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<TipoConta> list = null;
		
		try {
			String sql = "SELECT idTipoConta, dsTipoConta, status FROM tbtipoconta ";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<TipoConta>();
			while (rs.next()) {
				int cdTipoConta = rs.getInt(1);
				String dsTipoConta  = rs.getString(2);
				String status = rs.getString(3);
				list.add(new TipoConta(cdTipoConta, dsTipoConta, status));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	public boolean exclusaoIdTipoConta(int idTipoConta) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = true;
		try {
			String sql = "select t.idTipoConta from tbtipoconta t join tbconta c on t.idTipoConta = c.idTipoConta where t.idTipoConta = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idTipoConta);
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
