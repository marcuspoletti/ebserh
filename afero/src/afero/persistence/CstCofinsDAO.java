package afero.persistence;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import afero.model.CstCofins;



public class CstCofinsDAO{
	
	private Connection conn;

	public CstCofinsDAO(Connection conn) {
		this.conn = conn;
	}

	public void incluir(CstCofins cstCofins) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		String sql = "";
		if (cstCofins == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			   sql = "INSERT INTO tbcstcofins (cdCstCofins, dsCstCofins) values(?, ?) ";
			   conn = this.conn;
			   ps = conn.prepareStatement(sql);
			   ps.setInt(1, cstCofins.getCdCstCofins());
			   ps.setString(2, cstCofins.getDsCstCofins());
			   ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(CstCofins cstCofins) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		String sql = "";
		if (cstCofins == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			
			sql = "UPDATE tbcstcofins set dsCstCofins = ? WHERE cdCstCofins= ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
		
			ps.setString(1, cstCofins.getDsCstCofins());
			ps.setInt(2, cstCofins.getCdCstCofins());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);

		}
	}
	
	
	public void excluir(CstCofins cstCofins) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (cstCofins == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbcstcofins WHERE cdCstCofins = ? ");
			ps.setInt(1, cstCofins.getCdCstCofins());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			// ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public CstCofins procurarCstCofins(int cdCstCofins)
			throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		CstCofins cstCofins = null;

		try {
			String sql = "Select dsCstCofins from tbcstcofins where cdCstCofins = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cdCstCofins);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + cdCstCofins);
			}
			String dsCstCofins = rs.getString(1);
			cstCofins = new CstCofins(cdCstCofins, dsCstCofins);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return cstCofins;
	}
	
	public List listarCstCofins(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<CstCofins> list = null;

		try {
			String sql = " Select cdCstCofins, dsCstCofins from tbcstcofins ";
			if (clausula != null)
				sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<CstCofins>();
			while (rs.next()) {
				
				int cdCstCofins = rs.getInt(1);
				String dsCstCofins = rs.getString(2);
				
				list.add(new CstCofins(cdCstCofins, dsCstCofins));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	
	public boolean exclusaoCstCofins(int cdCstCofins) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = true;
		try {
			String sql = "select ci.cdCstCofins from tbcstcofins ci " +
                          "join tbcattributaria t on ci.cdCstCofins = t.cdCstCofins "+
						  "where ci.cdCstCofins = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cdCstCofins);
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