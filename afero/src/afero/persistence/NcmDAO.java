package afero.persistence;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


import afero.model.Ncm;
public class NcmDAO{
	
	private Connection conn;

	public NcmDAO(Connection conn) {
		this.conn = conn;
	}

	public void incluir(Ncm ncm) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		String sql = "";
		if (ncm == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			   sql = "INSERT INTO tbncm (cdNcm, dsNcm) values(?, ?) ";
			   conn = this.conn;
			   ps = conn.prepareStatement(sql);
			   ps.setString(1, ncm.getCdNcm());
			   ps.setString(2, ncm.getDsNcm());
			   ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(Ncm ncm) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		String sql = "";
		if (ncm == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			
			sql = "UPDATE tbncm set dsNcm = ? WHERE cdNcm= ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, ncm.getDsNcm());
			ps.setString(2, ncm.getCdNcm());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);

		}
	}
	
	
	public void excluir(Ncm ncm) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (ncm == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbncm WHERE cdNcm = ? ");
			ps.setString(1, ncm.getCdNcm());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			// ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public Ncm procurarNcm(String cdNcm)
			throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		Ncm ncm = null;

		try {
			String sql = "Select dsNcm from tbncm where cdNcm = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, cdNcm);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + cdNcm);
			}
			String dsNcm = rs.getString(1);
			ncm = new Ncm(cdNcm, dsNcm);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return ncm;
	}
	
	public List listarNcm(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<Ncm> list = null;

		try {
			String sql = " Select cdNcm, dsNcm from tbncm ";
			if (clausula != null)
				sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<Ncm>();
			while (rs.next()) {
				
				String cdNcm = rs.getString(1);
				String dsNcm = rs.getString(2);
				
				list.add(new Ncm(cdNcm, dsNcm));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	
	public boolean exclusaoCdNcm(String cdNcm) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = true;
		try {
			String sql = "select n.cdNcm from tbncm n " +
                          "join tbproduto p on n.cdNcm = p.cdNcm "+
						  "where n.cdNcm = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, cdNcm);
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
	
	public List listarNcmAutoComplete(String cdNcm) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<Ncm> list = null;

		try {
			String sql = " Select cdNcm, dsNcm from tbncm where cdNcm like '%"+cdNcm+"%' or dsNcm like '%"+cdNcm+"%'";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<Ncm>();
			while (rs.next()) {
				
				cdNcm = rs.getString(1);
				String dsNcm = rs.getString(2);
				
				list.add(new Ncm(cdNcm, dsNcm));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		}
		return list;
	}
	


}