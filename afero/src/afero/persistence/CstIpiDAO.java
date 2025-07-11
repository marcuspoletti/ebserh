package afero.persistence;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


import afero.model.CstIpi;
public class CstIpiDAO{
	
	private Connection conn;

	public CstIpiDAO(Connection conn) {
		this.conn = conn;
	}

	public void incluir(CstIpi cstIpi) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		String sql = "";
		if (cstIpi == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			   sql = "INSERT INTO tbcstipi (cdCstIpi, dsCstIpi) values(?, ?) ";
			   conn = this.conn;
			   ps = conn.prepareStatement(sql);
			   ps.setInt(1, cstIpi.getCdCstIpi());
			   ps.setString(2, cstIpi.getDsCstIpi());
			   ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(CstIpi cstIpi) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		String sql = "";
		if (cstIpi == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			
			sql = "UPDATE tbcstipi set dsCstIpi = ? WHERE cdCstIpi= ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			
			ps.setString(1, cstIpi.getDsCstIpi());
			ps.setInt(2, cstIpi.getCdCstIpi());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);

		}
	}
	
	
	public void excluir(CstIpi cstIpi) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (cstIpi == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbcstipi WHERE cdCstIpi = ? ");
			ps.setInt(1, cstIpi.getCdCstIpi());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			// ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public CstIpi procurarCstIpi(int cdCstIpi)
			throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		CstIpi cstIpi = null;

		try {
			String sql = "Select dsCstIpi from tbcstipi where cdCstIpi = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cdCstIpi);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + cdCstIpi);
			}
			String dsCstIpi = rs.getString(1);
			cstIpi = new CstIpi(cdCstIpi, dsCstIpi);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return cstIpi;
	}
	
	public List listarCstIpi(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<CstIpi> list = null;

		try {
			String sql = " Select cdCstIpi, dsCstIpi from tbcstipi ";
			if (clausula != null)
				sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<CstIpi>();
			while (rs.next()) {
				
				int cdCstIpi = rs.getInt(1);
				String dsCstIpi = rs.getString(2);
				
				list.add(new CstIpi(cdCstIpi, dsCstIpi));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	
	public boolean exclusaoCstIpi(int cdCstIpi) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = true;
		try {
			String sql = "select ci.cdCstIpi from tbcstipi ci " +
                          "join tbcattributaria t on ci.cdCstIpi = t.cdCstIpi "+
						  "where ci.cdCstIpi = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cdCstIpi);
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