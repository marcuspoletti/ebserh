package afero.persistence;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import afero.model.FormaPagto;
public class FormaPagtoDAO implements IFormaPagtoDAO{
	private Connection conn;

	public FormaPagtoDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;
	}

	public void incluir(FormaPagto formaPagto) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (formaPagto == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbformapagto(dsFormaPagto, status) "
					+ "VALUES (?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, formaPagto.getDsFormaPagto());
			ps.setString(2, formaPagto.getStatus());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(FormaPagto formaPagto) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (formaPagto == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbformapagto SET dsFormaPagto = ?, status = ? "
					+ "WHERE cdFormaPagto = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, formaPagto.getDsFormaPagto());
			ps.setString(2, formaPagto.getStatus());
			ps.setInt(3, formaPagto.getCdFormaPagto());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void excluir(FormaPagto formaPagto) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (formaPagto == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbformapagto WHERE cdFormaPagto=?");
			ps.setInt(1, formaPagto.getCdFormaPagto());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public FormaPagto procurarFormaPagto(int cdFormaPagto) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		FormaPagto formaPagto= null;

		try {
			String sql = "SELECT cdFormaPagto, dsFormaPagto, status FROM tbformapagto "
				+ "WHERE cdFormaPagto=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cdFormaPagto);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + cdFormaPagto);
			}
            
			int idFormaPagto = rs.getInt(1);
			String dsFormaPagto  = rs.getString(2);
			String status = rs.getString(3);

			formaPagto = new FormaPagto(idFormaPagto, dsFormaPagto, status);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return formaPagto;
	}

	public List listarFormaPagto(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<FormaPagto> list = null;
		
		try {
			String sql = "SELECT cdFormaPagto, dsFormaPagto, status FROM tbformapagto ";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<FormaPagto>();
			while (rs.next()) {
				int idFormaPagto = rs.getInt(1);
				String dsFormaPagto  = rs.getString(2);
				String status = rs.getString(3);
				list.add(new FormaPagto(idFormaPagto, dsFormaPagto, status));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	public boolean exclusaoCdFormaPagto(int cdFormaPagto) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = true;
		try {
			String sql = "select fp.cdFormaPagto from tbformapagto fp "+
                         "join tbcontamovtodivisao md on fp.cdFormaPagto = md.cdFormaPagto " +
                         "join tbduplicatadivisao dd on  fp.cdFormaPagto = dd.cdFormaPagto " +
                         "join tbtransferencia t on fp.cdFormaPagto = t.cdFormaPagto " +
                         "where fp.cdFormaPagto = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cdFormaPagto);
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
