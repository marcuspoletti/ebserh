package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import afero.model.CotacaoPedidoEntrada;

public class CotacaoPedidoEntradaDAO implements ICotacaoPedidoEntradaDAO{

	private Connection conn;
    
	public CotacaoPedidoEntradaDAO(Connection conn) {
		this.conn = conn;
	}
	
	public void incluir(CotacaoPedidoEntrada cotacaoPedidoEntrada) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;		
		if (cotacaoPedidoEntrada == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbcotacaopedidoentrada(idCotacao, idPedidoEntrada)VALUES(?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cotacaoPedidoEntrada.getIdCotacao());
			ps.setInt(2, cotacaoPedidoEntrada.getIdPedidoEntrada());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		}finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(CotacaoPedidoEntrada cotacaoPedidoEntrada) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (cotacaoPedidoEntrada == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbcotacaopedidoentrada set idPedidoEntrada = ?"+
			             "WHERE idCotacao = ?";
			conn = this.conn;		
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cotacaoPedidoEntrada.getIdPedidoEntrada());
			ps.setInt(2, cotacaoPedidoEntrada.getIdCotacao());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void excluir(CotacaoPedidoEntrada cotacaoPedidoEntrada) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;		
		if (cotacaoPedidoEntrada == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbcotacaopedidoentrada WHERE idCotacao=?");
			ps.setInt(1, cotacaoPedidoEntrada.getIdCotacao());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public CotacaoPedidoEntrada procurarCotacaoPedidoEntrada(int idCotacao) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		CotacaoPedidoEntrada cotacaoPedidoEntrada = null;
		
		try {
			String sql = "SELECT idCotacao, idPedidoEntrada from tbcotacaopedidoentrada WHERE idCotacao = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idCotacao);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " +idCotacao);
			}
			int idPedidoEntrada = rs.getInt(1);

			cotacaoPedidoEntrada = new CotacaoPedidoEntrada(idCotacao, idPedidoEntrada);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return cotacaoPedidoEntrada;
	}
	
	public CotacaoPedidoEntrada procurarCotacaoPedidoEntradaIdPedidoEntrada(int idPedidoEntrada) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		CotacaoPedidoEntrada cotacaoPedidoEntrada = null;
		
		try {
			String sql = "SELECT idCotacao, idPedidoEntrada from tbcotacaopedidoentrada WHERE idPedidoEntrada = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idPedidoEntrada);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " +idPedidoEntrada);
			}
			int idCotacao = rs.getInt(1);

			cotacaoPedidoEntrada = new CotacaoPedidoEntrada(idCotacao, idPedidoEntrada);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return cotacaoPedidoEntrada;
	}

	public List<CotacaoPedidoEntrada> listarCotacaoPedidoEntrada(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<CotacaoPedidoEntrada> list = null;

		try {
			String sql = "SELECT idCotacao, idPedidoEntrada from tbcotacaopedidoentrada";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;			
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<CotacaoPedidoEntrada>();
			while (rs.next()) {
				int idCotacao = rs.getInt(1);
				int idPedidoEntrada = rs.getInt(2);
				list.add(new CotacaoPedidoEntrada(idCotacao, idPedidoEntrada));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
}
