package afero.persistence;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import afero.model.OrcamentoEmpresa;


public class OrcamentoEmpresaDAO implements IOrcamentoEmpresaDAO{
	private Connection conn;

	public OrcamentoEmpresaDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;
	}

	public void incluir(OrcamentoEmpresa orcamentoEmpresa) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (orcamentoEmpresa == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tborcamentoempresa (nmOrcamentoEmpresa, status) "
					+ "VALUES (?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, orcamentoEmpresa.getNmOrcamentoEmpresa());
			ps.setString(2, orcamentoEmpresa.getStatus());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(OrcamentoEmpresa orcamentoEmpresa) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (orcamentoEmpresa == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tborcamentoempresa SET nmOrcamentoEmpresa=?, status=? "
					+ "WHERE idOrcamentoEmpresa=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, orcamentoEmpresa.getNmOrcamentoEmpresa());
			ps.setString(2, orcamentoEmpresa.getStatus());
			ps.setInt(3, orcamentoEmpresa.getIdOrcamentoEmpresa());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void excluir(OrcamentoEmpresa orcamentoEmpresa) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (orcamentoEmpresa == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tborcamentoempresa WHERE idOrcamentoEmpresa=?");
			ps.setInt(1, orcamentoEmpresa.getIdOrcamentoEmpresa());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public OrcamentoEmpresa procurarOrcamentoEmpresa(int idOrcamentoEmpresa) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		OrcamentoEmpresa orcamentoEmpresa = null;

		try {
			String sql = "SELECT idOrcamentoEmpresa, nmOrcamentoEmpresa, status FROM tborcamentoempresa "
				+ "WHERE idOrcamentoEmpresa=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idOrcamentoEmpresa);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + idOrcamentoEmpresa);
			}
            
			int cdOrcamentoEmpresa = rs.getInt(1);
			String nmOrcamentoEmpresa  = rs.getString(2);
			String status = rs.getString(3);

			orcamentoEmpresa = new OrcamentoEmpresa(cdOrcamentoEmpresa,nmOrcamentoEmpresa,status);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return orcamentoEmpresa;
	}

	public List listarOrcamentoEmpresa(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<OrcamentoEmpresa> list = null;
		
		try {
			String sql = "SELECT idOrcamentoEmpresa, nmOrcamentoEmpresa, status FROM tborcamentoempresa ";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<OrcamentoEmpresa>();
			while (rs.next()) {
				int idOrcamentoEmpresa = rs.getInt(1);
				String nmOrcamentoEmpresa = rs.getString(2);
				String status = rs.getString(3);
				
				list.add(new OrcamentoEmpresa(idOrcamentoEmpresa, nmOrcamentoEmpresa, status));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	public boolean exclusaoIdOrcamentoEmpresa(int idOrcamentoEmpresa) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = true;
		try {
			String sql = "select oe.idOrcamentoEmpresa from tborcamentoempresa oe join tborcamentoempresaitem oei on oe.idOrcamentoEmpresa = oei.idOrcamentoEmpresa where oe.idOrcamentoEmpresa = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idOrcamentoEmpresa);
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
