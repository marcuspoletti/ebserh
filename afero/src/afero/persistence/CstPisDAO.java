package afero.persistence;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import afero.model.CstPis;


public class CstPisDAO{
	
	private Connection conn;

	public CstPisDAO(Connection conn) {
		this.conn = conn;
	}

	public void incluir(CstPis cstPis) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		String sql = "";
		if (cstPis == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			   sql = "INSERT INTO tbcstpis (cdCstPis, dsCstPis) values(?, ?) ";
			   conn = this.conn;
			   ps = conn.prepareStatement(sql);
			   ps.setInt(1, cstPis.getCdCstPis());
			   ps.setString(2, cstPis.getDsCstPis());
			   ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(CstPis cstPis) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		String sql = "";
		if (cstPis == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			
			sql = "UPDATE tbcstpis set dsCstPis = ? WHERE cdCstPis= ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, cstPis.getDsCstPis());
			ps.setInt(2, cstPis.getCdCstPis());
			
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);

		}
	}
	
	
	public void excluir(CstPis cstPis) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (cstPis == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbcstpis WHERE cdCstPis = ? ");
			ps.setInt(1, cstPis.getCdCstPis());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			// ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public CstPis procurarCstPis(int cdCstPis)
			throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		CstPis cstPis = null;

		try {
			String sql = "Select dsCstPis from tbcstpis where cdCstPis = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cdCstPis);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + cdCstPis);
			}
			String dsCstPis = rs.getString(1);
			cstPis = new CstPis(cdCstPis, dsCstPis);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return cstPis;
	}
	
	public List listarCstPis(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<CstPis> list = null;

		try {
			String sql = " Select cdCstPis, dsCstPis from tbcstpis ";
			if (clausula != null)
				sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<CstPis>();
			while (rs.next()) {
				
				int cdCstPis = rs.getInt(1);
				String dsCstPis = rs.getString(2);
				
				list.add(new CstPis(cdCstPis, dsCstPis));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	
	public boolean exclusaoCstPis(int cdCstPis) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = true;
		try {
			String sql = "select ci.cdCstPis from tbcstpis ci " +
                          "join tbcattributaria t on ci.cdCstPis = t.cdCstPis "+
						  "where ci.cdCstPis = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cdCstPis);
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