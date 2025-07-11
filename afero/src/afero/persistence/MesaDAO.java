package afero.persistence;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import afero.model.Mesa;


public class MesaDAO {
	private Connection conn;

	public MesaDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;
	}

	public void incluir(Mesa mesa) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (mesa == null)
			throw new AferoDAOException(
					"O valor passado n�o pode ser nulo");

		try {
			String sql = "INSERT INTO tbmesa (dsMesa, status) "
					+ "VALUES (?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, mesa.getDsMesa());
			ps.setString(2, mesa.getStatus());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(Mesa mesa) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (mesa == null)
			throw new AferoDAOException(
					"O valor passado n�o pode ser nulo");

		try {
			String sql = "UPDATE tbmesa SET dsMesa=?, status=? "
					+ "WHERE idMesa=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, mesa.getDsMesa());
			ps.setString(2, mesa.getStatus());
			ps.setInt(3, mesa.getIdMesa());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void excluir(Mesa mesa) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (mesa == null)
			throw new AferoDAOException(
					"O valor passado n�o pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbmesa WHERE idMesa=?");
			ps.setInt(1, mesa.getIdMesa());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}
	public void atualizarStatus(int idMesa, String status) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		try {
			String sql = "UPDATE tbmesa SET status=? "
					+ "WHERE idMesa=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, status);
			ps.setInt(2, idMesa);
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}
	public Mesa procurarMesa(int idMesa) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		Mesa mesa = null;

		try {
			String sql = "SELECT idMesa, dsMesa, status FROM tbmesa "
				+ "WHERE idMesa= ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idMesa);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("N�o foi encontrado nenhum "
						+ "registro com o c�digo: " + idMesa);
			}
			String dsMesa  = rs.getString(2);
			String status = rs.getString(3);

			mesa = new Mesa(idMesa, dsMesa, status);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return mesa;
	}

	public List listarMesa(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<Mesa> list = null;
		
		try {
			String sql = "SELECT idMesa, dsMesa, status FROM tbmesa ";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<Mesa>();
			while (rs.next()) {
				int idMesa = rs.getInt(1);
				String dsMesa = rs.getString(2);
				String status = rs.getString(3);
				
				list.add(new Mesa(idMesa, dsMesa, status));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	public boolean exclusaoIdMesa(int idMesa) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = true;
		try {
			String sql = "select idMesa from tbpedidosaida where idMesa = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idMesa);
			rs = ps.executeQuery();
			if(rs.next()) {
			   ok=true;
			}else{
				ok=false;
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		}
		return ok;
		
	}
	public int getIdMesa(int idPedidoSaida) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		int id = 0;
		try {
			String sql = "select idMesa from tbpedidosaida where idPedidoSaida = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idPedidoSaida);
			rs = ps.executeQuery();
			if(rs.next()) {
				id = rs.getInt("idMesa"); 
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		}
		return id;
		
	}
	public boolean existeIdMesa(int idMesa) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = true;
		try {
			String sql = "select idMesa from tbmesa where idMesa = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idMesa);
			rs = ps.executeQuery();
			if(rs.next()) {
			   ok=true;
			}else{
				ok=false;
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		}
		return ok;
		
	}
	public String statusMesa(int idMesa) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		String status = "";
		try {
			String sql = "select status from tbmesa where idMesa = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idMesa);
			rs = ps.executeQuery();
			if(rs.next()) {
			   status = rs.getString(1);
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		}
		return status;
		
	}
	public void transfMesa(int idMesa, int idMesaTrocada, int idPedidoSaida) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		try {
			String sql = "UPDATE tbpedidosaida SET idMesa = ? "
					+ " WHERE idMesa = ? AND idPedidoSaida = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idMesaTrocada);
			ps.setInt(2, idMesa);
			ps.setInt(3, idPedidoSaida);
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} 
	}
	
	public void transfMesaItens(int idPedidoSaida, int idMesaTrocada) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		try {
			String sql = "UPDATE tbpedidosaidaitem SET idMesaTransferencia = ? "
					+ "WHERE idPedidoSaida = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idMesaTrocada);
			ps.setInt(2, idPedidoSaida);
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} 
	}
	public boolean verificarMesa(int idMesa) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = true;
		Integer idMesaLocalizada = 0 ;
		try {
			String sql = "select idMesa from tbpedidosaida where idMesa = ? AND status = 'P' ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idMesa);
			rs = ps.executeQuery();
			if(rs.next()) {
			   idMesaLocalizada = rs.getInt(1);
			   ok = false;
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		}
		return ok;
		
	}


	

}
