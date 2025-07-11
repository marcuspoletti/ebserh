package afero.persistence;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import afero.model.Agrupamento;
public class AgrupamentoDAO {
	private Connection conn;

	public AgrupamentoDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;
	}

	public void incluir(Agrupamento agrupamento) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (agrupamento == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbAgrupamento (dsAgrupamento, status) "
					+ "VALUES (?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, agrupamento.getDsAgrupamento());
			ps.setString(2, agrupamento.getStatus());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}
	}

	public void atualizar(Agrupamento agrupamento) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (agrupamento == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbAgrupamento SET dsAgrupamento = ?, status = ? "
					+ "WHERE idAgrupamento = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, agrupamento.getDsAgrupamento());
			ps.setString(2, agrupamento.getStatus());
			ps.setInt(3, agrupamento.getIdAgrupamento());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}
	}

	public void excluir(Agrupamento agrupamento) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (agrupamento == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbAgrupamento WHERE idAgrupamento = ?");
			ps.setInt(1, agrupamento.getIdAgrupamento());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}
	}

	public Agrupamento procurarAgrupamento (int idAgrupamento) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		Agrupamento agrupamento = null;

		try {
			String sql = "SELECT idAgrupamento, dsAgrupamento, status FROM tbAgrupamento "
				+ "WHERE idAgrupamento = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idAgrupamento);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + idAgrupamento);
			}
            
			int IdAgrupamento = rs.getInt(1);
			String dsAgrupamento  = rs.getString(2);
			String status = rs.getString(3);

			agrupamento = new Agrupamento(IdAgrupamento, dsAgrupamento, status);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return agrupamento;
	}

	public List listarAgrupamento(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<Agrupamento> list = null;
		
		try {
			String sql = "SELECT idAgrupamento, dsAgrupamento, status FROM tbAgrupamento ";
			if (clausula != null) 
				sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<Agrupamento>();
			while (rs.next()) {
				int idAgrupamento = rs.getInt(1);
				String dsAgrupamento  = rs.getString(2);
				String status = rs.getString(3);
				list.add(new Agrupamento(idAgrupamento, dsAgrupamento, status ));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	public boolean exclusaoIdAgrupamento(int idAgrupamento) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = false;

		try {
			String sql = "select d.idContaMovtoDivisao from tbcontaMovtoDivisao d "+
                         "join tbContaMovto p on (d.idContaMovto = p.idContaMovto) " +
                         "where d.idContaMovto = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idAgrupamento);
			rs = ps.executeQuery();
			if (rs.next()) {
				ok=true;
			}else{
				ok = false;
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return ok;
	}
	
	
}
