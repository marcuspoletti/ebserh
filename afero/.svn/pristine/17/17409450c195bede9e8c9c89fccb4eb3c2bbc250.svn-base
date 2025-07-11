package afero.persistence;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


import afero.model.CstIcms;
public class CstIcmsDAO{
	
	private Connection conn;

	public CstIcmsDAO(Connection conn) {
		this.conn = conn;
	}

	public void incluir(CstIcms cstIcms) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		String sql = "";
		if (cstIcms == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			   sql = "INSERT INTO tbcsticms (cdCstIcms, dsCstIcms) values(?, ?) ";
			   conn = this.conn;
			   ps = conn.prepareStatement(sql);
			   ps.setInt(1, cstIcms.getCdCstIcms());
			   ps.setString(2, cstIcms.getDsCstIcms());
			   ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(CstIcms cstIcms) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		String sql = "";
		if (cstIcms == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			
			sql = "UPDATE tbcsticms set dsCstIcms = ? WHERE cdCstIcms= ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, cstIcms.getDsCstIcms());
			ps.setInt(2, cstIcms.getCdCstIcms());
			
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);

		}
	}
	
	
	public void excluir(CstIcms cstIcms) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (cstIcms == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbcsticms WHERE cdCstIcms = ? ");
			ps.setInt(1, cstIcms.getCdCstIcms());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			// ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public CstIcms procurarCstIcms(int cdCstIcms)
			throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		CstIcms cstIcms = null;

		try {
			String sql = "Select dsCstIcms from tbcsticms where cdCstIcms = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cdCstIcms);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + cdCstIcms);
			}
			String dsCstIcms = rs.getString(1);
			cstIcms = new CstIcms(cdCstIcms, dsCstIcms);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return cstIcms;
	}
	
	public List listarCstIcms(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<CstIcms> list = null;

		try {
			String sql = " Select cdCstIcms, dsCstIcms from tbcsticms ";
			if (clausula != null)
				sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<CstIcms>();
			while (rs.next()) {
				
				int cdCstIcms = rs.getInt(1);
				String dsCstIcms = rs.getString(2);
				
				list.add(new CstIcms(cdCstIcms, dsCstIcms));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	
	public boolean exclusaoCstIcms(int cdCstIcms) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = true;
		try {
			String sql = "select ci.cdCstIcms from tbcsticms ci " +
                          "join tbtributacao t on ci.cdCstIcms = t.cdCstIcms "+
						  "where ci.cdCstIcms = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cdCstIcms);
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