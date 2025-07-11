package afero.persistence;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


import afero.model.Csosn;
public class CsosnDAO{
	
	private Connection conn;

	public CsosnDAO(Connection conn) {
		this.conn = conn;
	}

	public void incluir(Csosn csosn) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		String sql = "";
		if (csosn == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			   sql = "INSERT INTO tbcsosn (cdCsosn, dsCsosn) values(?, ?) ";
			   conn = this.conn;
			   ps = conn.prepareStatement(sql);
			   ps.setInt(1, csosn.getCdCsosn());
			   ps.setString(2, csosn.getDsCsosn());
			   ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(Csosn csosn) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		String sql = "";
		if (csosn == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			
			sql = "UPDATE tbcsosn set dsCsosn = ? WHERE cdCsosn= ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, csosn.getDsCsosn());
			ps.setInt(2, csosn.getCdCsosn());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);

		}
	}
	
	
	public void excluir(Csosn csosn) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (csosn == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbcsosn WHERE cdCsosn = ? ");
			ps.setInt(1, csosn.getCdCsosn());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			// ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public Csosn procurarCsosn(int cdCsosn)
			throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		Csosn csosn = null;

		try {
			String sql = "Select dsCsosn from tbcsosn where cdCsosn = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cdCsosn);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + cdCsosn);
			}
			String dsCsosn = rs.getString(1);
			csosn = new Csosn(cdCsosn, dsCsosn);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return csosn;
	}
	
	public List listarCsosn(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<Csosn> list = null;

		try {
			String sql = " Select cdCsosn, dsCsosn from tbCsosn ";
			if (clausula != null)
				sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<Csosn>();
			while (rs.next()) {
				
				int cdCsosn = rs.getInt(1);
				String dsCsosn = rs.getString(2);
				
				list.add(new Csosn(cdCsosn, dsCsosn));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	
	public boolean exclusaoCsosn(int cdCsosn) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = true;
		try {
			String sql = "select ci.cdCsosn from tbcsosn ci " +
                          "join tbtributacao t on ci.cdCsosn = t.cdCsosn "+
						  "where ci.cdCsosn = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cdCsosn);
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