package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import afero.model.OrcamentoPedidoSaida;

public class OrcamentoPedidoSaidaDAO implements IOrcamentoPedidoSaidaDAO{
    
	private Connection conn;

	public OrcamentoPedidoSaidaDAO(Connection conn) {
		this.conn = conn;		
	}
	
	public void incluir(OrcamentoPedidoSaida orcamentoPedidoSaida) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (orcamentoPedidoSaida == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tborcamentopedidosaida(idOrcamento, idPedidoSaida) VALUES (?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, orcamentoPedidoSaida.getIdOrcamento());
			ps.setInt(2, orcamentoPedidoSaida.getIdPedidoSaida());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(OrcamentoPedidoSaida orcamentoPedidoSaida) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (orcamentoPedidoSaida == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tborcamentopedidosaida set idOrcamento = ?, idPedidoSaida = ? "+
		                 "where idOrcamento = ?";		
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, orcamentoPedidoSaida.getIdOrcamento());
			ps.setInt(2, orcamentoPedidoSaida.getIdPedidoSaida());
			ps.setInt(3, orcamentoPedidoSaida.getIdOrcamento());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void excluir(OrcamentoPedidoSaida orcamentoPedidoSaida) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (orcamentoPedidoSaida == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {			
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tborcamentopedidosaida WHERE idOrcamento=?");
			ps.setInt(1, orcamentoPedidoSaida.getIdOrcamento());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public OrcamentoPedidoSaida  procurarOrcamentoPedidoSaida(int idOrcamento) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		OrcamentoPedidoSaida orcamentoPedidoSaida = null;
				
		try {
			String sql = "SELECT idPedidoSaida  from tborcamentopedidosaida WHERE idOrcamento = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idOrcamento);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + idOrcamento);
			}
            
			int idPedidoSaida = rs.getInt(1);

			orcamentoPedidoSaida = new OrcamentoPedidoSaida(idOrcamento, idPedidoSaida);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		}
		return orcamentoPedidoSaida;
	}

	public List listarOrcamentoPedidoSaida(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<OrcamentoPedidoSaida> list = null;
		
		try {
			String sql = "select idOrcamento, idPedidoSaida from tborcamentopedidosaida";
			if (clausula != null) sql = sql + clausula;			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<OrcamentoPedidoSaida>();
			while (rs.next()) {
				int idOrcamento = rs.getInt(1);
				int idPedidoSaida = rs.getInt(2);
				
				list.add(new OrcamentoPedidoSaida(idOrcamento, idPedidoSaida));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}

}
