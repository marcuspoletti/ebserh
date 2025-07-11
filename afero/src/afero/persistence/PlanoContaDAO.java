package afero.persistence;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import afero.model.PlanoConta;
public class PlanoContaDAO implements IPlanoContaDAO{
	
	private Connection conn;

	public PlanoContaDAO(Connection conn) {
		this.conn = conn;
	}

	public void incluir(PlanoConta planoConta) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		String sql = "";
		if (planoConta == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
		   sql = "INSERT INTO tbplanoconta (idPlanoContaPai, cdPlanoConta, nmPlanoConta, dc, status) values(?, ?, ?, ?, ?) ";
		   conn = this.conn;
		   ps = conn.prepareStatement(sql);
		   if(planoConta.getIdPlanoContaPai() > 0){
			   ps.setInt(1, planoConta.getIdPlanoContaPai());
		   } else {
			   ps.setNull(1, 0);
		   }
		   ps.setString(2,planoConta.getCdPlanoConta());
		   ps.setString(3, planoConta.getNmPlanoConta());
		   ps.setString(4, planoConta.getDc());
		   ps.setString(5, planoConta.getStatus());
		   ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(PlanoConta planoConta) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		String sql = "";
		if (planoConta == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			
			sql = "UPDATE tbplanoconta set idPlanoContaPai = ?, cdPlanoConta = ?, nmPlanoConta = ?, dc = ?, status = ? where idPlanoConta = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			if (planoConta.getIdPlanoContaPai() > 0){
				   ps.setInt(1, planoConta.getIdPlanoContaPai());
			} else {
				ps.setNull(1, 0);
			}
			ps.setString(2, planoConta.getCdPlanoConta());
			ps.setString(3, planoConta.getNmPlanoConta());
			ps.setString(4, planoConta.getDc());
			ps.setString(5, planoConta.getStatus());
			ps.setInt(6, planoConta.getIdPlanoConta());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);

		}
	}
	
	
	public void excluir(PlanoConta planoConta) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (planoConta == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbplanoconta WHERE idPlanoConta=?");
			ps.setInt(1, planoConta.getIdPlanoConta());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			// ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public PlanoConta procurarPlanoConta(int idPlanoConta)
			throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		PlanoConta planoConta = null;

		try {
			String sql = "Select idPlanoConta, idPlanoContaPai, cdPlanoConta, nmPlanoConta, dc, status from tbplanoconta where idPlanoConta = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idPlanoConta);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + idPlanoConta);
			}

			
			int idPlanoContaPai = rs.getInt(2);
			String cdPlanoConta = rs.getString(3);
			String nmPlanoConta = rs.getString(4);
			String dc = rs.getString(5);
			String status = rs.getString(6);
			
			planoConta = new PlanoConta(idPlanoConta, idPlanoContaPai, cdPlanoConta, nmPlanoConta, dc, status);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return planoConta;
	}
	
	public List listarPlanoConta(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<PlanoConta> list = null;

		try {
			String sql = "Select pc.idPlanoConta, pc.idPlanoContaPai, pc.cdPlanoConta, pc.nmPlanoConta, pc.dc, pc.status from tbplanoconta pc ";
			if (clausula != null)
				sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<PlanoConta>();
			while (rs.next()) {
				int idPlanoConta = rs.getInt(1);
				int idPlanoContaPai = rs.getInt(2);
				String cdPlanoConta = rs.getString(3);
				String nmPlanoConta = rs.getString(4);
				String dc = rs.getString(5);
				String status = rs.getString(6);
				list.add(new PlanoConta(idPlanoConta, idPlanoContaPai, cdPlanoConta, nmPlanoConta, dc, status));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	
	public boolean exclusaoIdPlanoConta(int idPlanoConta) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = true;
		try {
			String sql = "select pc.idPlanoConta from tbplanoconta pc " +
                          "join tbduplicatadivisao dd on pc.idPlanoConta = dd.idPlanoConta "+
                          "join tbcontamovtodivisao md on dd.idCentroCusto = md.idCentroCusto "+
						  "join tbcentrocusto cc on md.idCentroCusto = cc.idCentroCusto "+
						  "join tbduplicata d on cc.idCentroCusto = d.idCentroCusto "+
						  "where pc.idPlanoConta = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idPlanoConta);
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
