package afero.persistence;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import afero.model.CentroCusto;

import afero.model.PlanoConta;
public class CentroCustoDAO implements ICentroCustoDAO{
	
	private Connection conn;

	public CentroCustoDAO(Connection conn) {
		this.conn = conn;
	}

	public void incluir(CentroCusto centroCusto) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		String sql = "";
		if (centroCusto == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			   sql = "INSERT INTO tbcentrocusto (idCentroCustoPai, nmCentroCusto, cdCentroCusto, pessoaResponsavel, nroTelefone, status) values(?, ?, ?, ?, ?, ?) ";
			   conn = this.conn;
			   ps = conn.prepareStatement(sql);
			   if(centroCusto.getIdCentroCustoPai() > 0){
				   ps.setInt(1, centroCusto.getIdCentroCustoPai());
			   } else {
				   ps.setNull(1, 0);
			   }
			   ps.setString(2, centroCusto.getNmCentroCusto());
			   ps.setString(3, centroCusto.getCdCentroCusto());
			   ps.setString(4, centroCusto.getPessoaResponsavel());
			   ps.setString(5, centroCusto.getNroTelefone());
			   ps.setString(6, centroCusto.getStatus());
			   ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(CentroCusto centroCusto) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		String sql = "";
		if (centroCusto == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			
			sql = "UPDATE tbcentrocusto set idCentroCustoPai = ?, nmCentroCusto = ?, cdCentroCusto = ?, pessoaResponsavel = ?, nroTelefone = ?, status = ? WHERE idCentroCusto = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
		    if(centroCusto.getIdCentroCustoPai() > 0){
				ps.setInt(1, centroCusto.getIdCentroCustoPai());
			} else {
			   ps.setNull(1, 0);
			}
			ps.setString(2, centroCusto.getNmCentroCusto());
			ps.setString(3, centroCusto.getCdCentroCusto());
			ps.setString(4, centroCusto.getPessoaResponsavel());
			ps.setString(5, centroCusto.getNroTelefone());
			ps.setString(6, centroCusto.getStatus());
			ps.setInt(7, centroCusto.getIdCentroCusto());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);

		}
	}
	
	
	public void excluir(CentroCusto centroCusto) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (centroCusto == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbcentrocusto WHERE idCentroCusto = ? ");
			ps.setInt(1, centroCusto.getIdCentroCusto());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			// ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public CentroCusto procurarCentroCusto(int idCentroCusto)
			throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		CentroCusto centroCusto = null;

		try {
			String sql = "Select idCentroCustoPai, nmCentroCusto, cdCentroCusto, pessoaResponsavel, nroTelefone, status from tbcentrocusto where idCentroCusto = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idCentroCusto);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + idCentroCusto);
			}

			
			int idCentroCustoPai = rs.getInt(1);
			String nmCentroCusto = rs.getString(2);
			String cdCentroCusto = rs.getString(3);
			String pessoaResponsavel = rs.getString(4);
			String nroTelefone = rs.getString(5);
			String status = rs.getString(6);
			
			centroCusto = new CentroCusto(idCentroCusto, idCentroCustoPai,
					cdCentroCusto, nmCentroCusto,
					pessoaResponsavel, nroTelefone, status);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return centroCusto;
	}
	
	public List listarCentroCusto(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<CentroCusto> list = null;

		try {
			String sql = " Select cc.idCentroCusto, cc.idCentroCustoPai, cc.nmCentroCusto, cc.cdCentroCusto, cc.pessoaResponsavel, cc.nroTelefone, cc.status from tbcentrocusto cc ";
			if (clausula != null)
				sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<CentroCusto>();
			while (rs.next()) {
				int idCentroCusto = rs.getInt(1);
				int idCentroCustoPai = rs.getInt(2);
				String nmCentroCusto = rs.getString(3);
				String cdCentroCusto = rs.getString(4);
				String pessoaResponsavel = rs.getString(5);
				String nroTelefone = rs.getString(6);
				String status = rs.getString(7);
				list.add(new CentroCusto(idCentroCusto, idCentroCustoPai,
						cdCentroCusto, nmCentroCusto,
						pessoaResponsavel, nroTelefone, status));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	
	public boolean exclusaoIdCentroCusto(int idCentroCusto) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = true;
		try {
			String sql = "select cc.idCentroCusto from tbcentrocusto cc " +
                          "join tbduplicatadivisao dd on cc.idCentroCusto = dd.idCentroCusto "+
                          "join tbcontamovtodivisao md on cc.idCentroCusto = md.idCentroCusto "+
						  "join tbduplicata d on cc.idCentroCusto = d.idCentroCusto "+
						  "where cc.idCentroCusto = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idCentroCusto);
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
