package afero.persistence;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import afero.model.Cfop;


public class CfopDAO{
	
	private Connection conn;

	public CfopDAO(Connection conn) {
		this.conn = conn;
	}

	public void incluir(Cfop cfop) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		String sql = "";
		if (cfop == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			   sql = "INSERT INTO tbcfop (cdCfop, dsCfop, descricao, aplicacao) values(?, ?, ?, ?) ";
			   conn = this.conn;
			   ps = conn.prepareStatement(sql);
			   ps.setInt(1, cfop.getCdCfop());
			   ps.setString(2, cfop.getDsCfop());
			   ps.setString(3, cfop.getDescricao());
			   ps.setString(4, cfop.getAplicacao());
			   ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(Cfop cfop) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		String sql = "";
		if (cfop == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			
			sql = "UPDATE tbcfop set dsCfop = ?, descricao = ?, aplicacao = ? WHERE cdCfop = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
		
			ps.setString(1, cfop.getDsCfop());
			ps.setString(2, cfop.getDescricao());
			ps.setString(3, cfop.getAplicacao());
			ps.setInt(4, cfop.getCdCfop());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);

		}
	}
	
	
	public void excluir(Cfop cfop) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (cfop == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbcfop WHERE cdCfop = ? ");
			ps.setInt(1, cfop.getCdCfop());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			// ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public Cfop procurarCfop(int cdCfop)
			throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		Cfop cfop = null;

		try {
			String sql = "Select dsCfop, descricao, aplicacao from tbcfop where cdCfop = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cdCfop);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + cdCfop);
			}
			String dsCfop = rs.getString(1);
			String descricao = rs.getString(2);
			String aplicacao = rs.getString(3);
			cfop = new Cfop(cdCfop, dsCfop, descricao, aplicacao);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return cfop;
	}
	
	public List listarCfop(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<Cfop> list = null;

		try {
			String sql = " Select cdCfop, dsCfop, descricao, aplicacao from tbcfop ";
			if (clausula != null)
				sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<Cfop>();
			while (rs.next()) {
				
				int cdCfop = rs.getInt(1);
				String dsCfop = rs.getString(2);
				String descricao = rs.getString(3);
				String aplicacao = rs.getString(4);
				
				list.add(new Cfop(cdCfop, dsCfop, descricao, aplicacao));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	
	public boolean exclusaoCfop(int cdCfop) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = true;
		try {
			String sql = "select ci.cdCfop from tbCfop ci " +
                          "join tbproduto t on ci.cdCfop = t.cdCfopSaidaFora "+
                          "join tbproduto p on ci.cdCfop = p.cdCfopSaidaDentro " +
						  "where ci.cdCfop = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cdCfop);
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