package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import afero.model.PedidoSaidaSubItens;

public class PedidoSaidaSubItensDAO {
	
	public Connection conn;

	public PedidoSaidaSubItensDAO(Connection conn) {
		this.conn = conn;
	}
			
		public void incluir(PedidoSaidaSubItens pedidoSaidaSubItem) throws AferoDAOException {
			PreparedStatement ps = null;
			Connection conn = null;
			if (pedidoSaidaSubItem == null)
				throw new AferoDAOException("O valor passado não pode ser nulo");

			try {
				String sql = "INSERT INTO tbpedidosaidasubitem(idPedidoSaidaItem, idProduto, idUnidade, comp, larg, quant, pDesc, vlUni," +
							" dtMod, usuario)" +
							" VALUES (?, ?, ?, ?, ?, ?, ?, ?, now(), ?)";
				conn = this.conn;
				ps = conn.prepareStatement(sql);
				ps.setInt(1, pedidoSaidaSubItem.getIdPedidoSaidaItem());
				ps.setInt(2, pedidoSaidaSubItem.getIdProduto());
				ps.setInt(3, pedidoSaidaSubItem.getIdUnidade());
				ps.setFloat(4, pedidoSaidaSubItem.getComp());
				ps.setFloat(5, pedidoSaidaSubItem.getLarg());
				ps.setFloat(6, pedidoSaidaSubItem.getQuant());
				ps.setFloat(7, pedidoSaidaSubItem.getpDesc());
				ps.setFloat(8, pedidoSaidaSubItem.getVlUni());
				ps.setString(9, pedidoSaidaSubItem.getUsuario());
				ps.executeUpdate();

			} catch (SQLException sqle) {
				throw new AferoDAOException("Erro ao inserir dados: " + sqle);
			} catch (Exception e) {
				throw new AferoDAOException("Erro ao inserir dados: " + e);
			} finally {
				// ConnectionFactory.closeConnection(conn, ps);
			}
		}
		public void incluirPizzaria(PedidoSaidaSubItens pedidoSaidaSubItem) throws AferoDAOException {
			PreparedStatement ps = null;
			Connection conn = null;
			if (pedidoSaidaSubItem == null)
				throw new AferoDAOException("O valor passado não pode ser nulo");

			try {
				String sql = "INSERT INTO tbpedidosaidasubitem(idPedidoSaidaItem, idProduto, idUnidade, dsCompProduto, comp, larg, quant, pDesc, vlUni," +
							" dtMod, usuario)" +
							" VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, now(), ?)";
				conn = this.conn;
				ps = conn.prepareStatement(sql);
				ps.setInt(1, pedidoSaidaSubItem.getIdPedidoSaidaItem());
				ps.setInt(2, pedidoSaidaSubItem.getIdProduto());
				ps.setInt(3, pedidoSaidaSubItem.getIdUnidade());
				ps.setString(4, pedidoSaidaSubItem.getDsCompProduto());
				ps.setFloat(5, pedidoSaidaSubItem.getComp());
				ps.setFloat(6, pedidoSaidaSubItem.getLarg());
				ps.setFloat(7, pedidoSaidaSubItem.getQuant());
				ps.setFloat(8, pedidoSaidaSubItem.getpDesc());
				ps.setFloat(9, pedidoSaidaSubItem.getVlUni());
				ps.setString(10, pedidoSaidaSubItem.getUsuario());
				ps.executeUpdate();

			} catch (SQLException sqle) {
				throw new AferoDAOException("Erro ao inserir dados: " + sqle);
			} catch (Exception e) {
				throw new AferoDAOException("Erro ao inserir dados: " + e);
			} finally {
				// ConnectionFactory.closeConnection(conn, ps);
			}
		}

		public void atualizar(PedidoSaidaSubItens pedidoSaidaSubItem) throws AferoDAOException {
			PreparedStatement ps = null;
			Connection conn = null;
			if (pedidoSaidaSubItem == null)
				throw new AferoDAOException("O valor passado não pode ser nulo");

			try {
				String sql = "UPDATE tbPedidoSaidaSubItem SET idPedidoSaidaItem = ?, idProduto = ?, idUnidade = ?, comp = ?, larg = ?, quant = ?, " +
							" pDesc = ?, vlUni = ?, dtMod = now(), usuario = ? " +
							"WHERE idPedidoSaidaSubItem = ?";
				conn = this.conn;
				ps = conn.prepareStatement(sql);
				ps.setInt(1, pedidoSaidaSubItem.getIdPedidoSaidaItem());
				ps.setInt(2, pedidoSaidaSubItem.getIdProduto());
				ps.setInt(3, pedidoSaidaSubItem.getIdUnidade());
				ps.setFloat(4, pedidoSaidaSubItem.getComp());
				ps.setFloat(5, pedidoSaidaSubItem.getLarg());
				ps.setFloat(6, pedidoSaidaSubItem.getQuant());
				ps.setFloat(7, pedidoSaidaSubItem.getpDesc());
				ps.setFloat(8, pedidoSaidaSubItem.getVlUni());
				ps.setString(9, pedidoSaidaSubItem.getUsuario());
				ps.setInt(10, pedidoSaidaSubItem.getIdPedidoSaidaSubItem());
				ps.executeUpdate();

			} catch (SQLException sqle) {
				throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
			} catch (Exception e) {
				throw new AferoDAOException("Erro ao atualizar dados: " + e);
			} finally {
				// ConnectionFactory.closeConnection(conn, ps);
			}
		}
		public void atualizarPizzaria(PedidoSaidaSubItens pedidoSaidaSubItem) throws AferoDAOException {
			PreparedStatement ps = null;
			Connection conn = null;
			if (pedidoSaidaSubItem == null)
				throw new AferoDAOException("O valor passado não pode ser nulo");

			try {
				String sql = "UPDATE tbPedidoSaidaSubItem SET idPedidoSaidaItem = ?, idProduto = ?, idUnidade = ?, dsCompProduto = ?, comp = ?, larg = ?, quant = ?, " +
							" pDesc = ?, vlUni = ?, dtMod = now(), usuario = ? " +
							"WHERE idPedidoSaidaSubItem = ?";
				conn = this.conn;
				ps = conn.prepareStatement(sql);
				ps.setInt(1, pedidoSaidaSubItem.getIdPedidoSaidaItem());
				ps.setInt(2, pedidoSaidaSubItem.getIdProduto());
				ps.setInt(3, pedidoSaidaSubItem.getIdUnidade());
				ps.setString(4, pedidoSaidaSubItem.getDsCompProduto());
				ps.setFloat(5, pedidoSaidaSubItem.getComp());
				ps.setFloat(6, pedidoSaidaSubItem.getLarg());
				ps.setFloat(7, pedidoSaidaSubItem.getQuant());
				ps.setFloat(8, pedidoSaidaSubItem.getpDesc());
				ps.setFloat(9, pedidoSaidaSubItem.getVlUni());
				ps.setString(10, pedidoSaidaSubItem.getUsuario());
				ps.setInt(11, pedidoSaidaSubItem.getIdPedidoSaidaSubItem());
				ps.executeUpdate();

			} catch (SQLException sqle) {
				throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
			} catch (Exception e) {
				throw new AferoDAOException("Erro ao atualizar dados: " + e);
			} finally {
				// ConnectionFactory.closeConnection(conn, ps);
			}
		}
		
		public float maiorValor(int idPedidoSaidaItem)throws AferoDAOException{
			PreparedStatement ps = null;
			Connection conn = null;
			ResultSet rs = null;
			float maiorValor = 0;
			
			try {
				String sql = "SELECT max(pr.preco) "+ 
                                 "from tbpedidosaidasubitem subi "+
                                 "join tbproduto p on (subi.idProduto = p.idProduto) "+
                                 "join tbestoque e on (p.idProduto = e.idProduto) "+
                                 "join tbpreco pr on (e.idEstoque = pr.idEstoque) "+
	                             "where pr.precoPadrao = 'S' AND subi.idPedidoSaidaItem = ? ";
				
				conn = this.conn;
				ps = conn.prepareStatement(sql);
				ps.setInt(1, idPedidoSaidaItem);
				rs = ps.executeQuery();
				if (rs.next()) {
					maiorValor = rs.getFloat(1);
				}
				
				
			} catch (SQLException sqle) {
				throw new AferoDAOException(sqle);
			}
			  return maiorValor;
			}
		
		public void atualizarValorUnit(int idPedidoSaidaSubItem, float vlUni, String usuario) throws AferoDAOException {
			PreparedStatement ps = null;
			Connection conn = null;
			try {
				String sql = "UPDATE tbPedidoSaidaSubItem SET vlUni = ?, dtMod = now(), usuario = ? "+
							"WHERE idPedidoSaidaSubItem = ?";
				conn = this.conn;
				ps = conn.prepareStatement(sql);
				ps.setFloat(1, vlUni);
				ps.setString(2, usuario);
				ps.setInt(3, idPedidoSaidaSubItem);
				ps.executeUpdate();

			} catch (SQLException sqle) {
				throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
			} catch (Exception e) {
				throw new AferoDAOException("Erro ao atualizar dados: " + e);
			}
		}
		
		public void excluir(PedidoSaidaSubItens pedidoSaidaSubItem) throws AferoDAOException {
			PreparedStatement ps = null;
			Connection conn = null;
			if (pedidoSaidaSubItem == null)
				throw new AferoDAOException("O valor passado não pode ser nulo");

			try {
				conn = this.conn;
				ps = conn.prepareStatement("DELETE FROM tbpedidoSaidaSubItem WHERE idPedidoSaidaSubItem = ?");
				ps.setInt(1, pedidoSaidaSubItem.getIdPedidoSaidaSubItem());
				ps.executeUpdate();

			} catch (SQLException sqle) {
				throw new AferoDAOException("Erro ao excluir dados:" + sqle);

			} finally {
				// ConnectionFactory.closeConnection(conn, ps);
			}
		}
		
		
		public PedidoSaidaSubItens procurarPedidoSaidaSubItem(int idPedidoSaidaSubItem) throws AferoDAOException {
			PreparedStatement ps = null;
			Connection conn = null;
			ResultSet rs = null;
			PedidoSaidaSubItens pedidoSaidaSubItem = null;
			
			try {
				String sql = "SELECT idPedidoSaidaSubItem, idPedidoSaidaItem, idProduto, idUnidade, comp, larg, quant, pDesc, vlUni, dtMod, usuario " +
							"FROM tbPedidoSaidaSubItem " +
							"WHERE idPedidoSaidaSubItem = ?";
				
				conn = this.conn;
				ps = conn.prepareStatement(sql);
				ps.setInt(1, idPedidoSaidaSubItem);
				rs = ps.executeQuery();
				if (!rs.next()) {
					throw new AferoDAOException("Não foi encontrado nenhum "
							+ "registro com o código: " + idPedidoSaidaSubItem);
				}
				
				int idPedSaidaSubItem = rs.getInt(1);
				int idPedidoSaidaItem = rs.getInt(2);
				int idProduto = rs.getInt(3);
				int idUnidade = rs.getInt(4);
				float comp = rs.getFloat(5);
				float larg = rs.getFloat(6);
				float quant = rs.getFloat(7);
				float pDesc = rs.getFloat(8);
				float vlUni = rs.getFloat(9);
				Date dtMod = rs.getDate(10);
				String usuario = rs.getString(11);
				
				
				pedidoSaidaSubItem = new PedidoSaidaSubItens(idPedSaidaSubItem, idPedidoSaidaItem, idProduto, idUnidade, comp, larg, quant, pDesc, vlUni,
									dtMod, usuario); 
				
			} catch (SQLException sqle) {
				throw new AferoDAOException(sqle);
			} finally {
				// ConnectionFactory.closeConnection(conn, ps, rs);
			}
			return pedidoSaidaSubItem;
			}

		public PedidoSaidaSubItens procurarPedidoSaidaItem(int idPedidoSaidaItem) throws AferoDAOException {
			PreparedStatement ps = null;
			Connection conn = null;
			ResultSet rs = null;
			PedidoSaidaSubItens pedidoSaidaSubItem = null;
			
			try {
				String sql = "SELECT idPedidoSaidaSubItem, idPedidoSaidaItem, idProduto, idUnidade, comp, larg, quant, pDesc, vlUni, dtMod, usuario " +
							"FROM tbPedidoSaidaSubItem " +
							"WHERE idPedidoSaidaItem = ?";
				
				conn = this.conn;
				ps = conn.prepareStatement(sql);
				ps.setInt(1, idPedidoSaidaItem);
				rs = ps.executeQuery();
				if (!rs.next()) {
					throw new AferoDAOException("Não foi encontrado nenhum "
							+ "registro com o código: " + idPedidoSaidaItem);
				}
				
				int idPedSaidaSubItem = rs.getInt(1);
				idPedidoSaidaItem = rs.getInt(2);
				int idProduto = rs.getInt(3);
				int idUnidade = rs.getInt(4);
				float comp = rs.getFloat(5);
				float larg = rs.getFloat(6);
				float quant = rs.getFloat(7);
				float pDesc = rs.getFloat(8);
				float vlUni = rs.getFloat(9);
				Date dtMod = rs.getDate(10);
				String usuario = rs.getString(11);
				
				
				pedidoSaidaSubItem = new PedidoSaidaSubItens(idPedSaidaSubItem, idPedidoSaidaItem, idProduto, idUnidade, comp, larg, quant, pDesc, vlUni,
									dtMod, usuario); 
				
			} catch (SQLException sqle) {
				throw new AferoDAOException(sqle);
			} finally {
				// ConnectionFactory.closeConnection(conn, ps, rs);
			}
			return pedidoSaidaSubItem;
			}
		public List<PedidoSaidaSubItens> listarPedidoSaidaSubItensList(int idPedidoSaidaItem) throws AferoDAOException {
			PreparedStatement ps = null;
			Connection conn = null;
			ResultSet rs = null;
			List<PedidoSaidaSubItens> list = null;
			
			try {
				String sql = "SELECT idPedidoSaidaSubItem, idPedidoSaidaItem, idProduto, idUnidade, comp, larg, quant, pDesc, vlUni, dtMod, usuario " +
							 "FROM tbPedidoSaidaSubItem " +
							 "WHERE idPedidoSaidaItem = ?";
				
				conn = this.conn;
				ps = conn.prepareStatement(sql);
				ps.setInt(1, idPedidoSaidaItem);
				rs = ps.executeQuery();
				list = new ArrayList<PedidoSaidaSubItens>();
				while (rs.next()) {

					
					int idPedSaidaSubItem = rs.getInt(1);
					idPedidoSaidaItem = rs.getInt(2);
					int idProduto = rs.getInt(3);
					int idUnidade = rs.getInt(4);
					float comp = rs.getFloat(5);
					float larg = rs.getFloat(6);
					float quant = rs.getFloat(7);
					float pDesc = rs.getFloat(8);
					float vlUni = rs.getFloat(9);
					Date dtMod = rs.getDate(10);
					String usuario = rs.getString(11);
				
				
				list.add( new PedidoSaidaSubItens (idPedSaidaSubItem, idPedidoSaidaItem, idProduto, idUnidade, comp, larg, quant, pDesc, vlUni,
									dtMod, usuario));
				
				}
				
			} catch (SQLException sqle) {
				throw new AferoDAOException(sqle);
			} finally {
				// ConnectionFactory.closeConnection(conn, ps, rs);
			}
			return list;
		}
		public List<PedidoSaidaSubItens> listarPedidoSaidaSubItensListCompProduto(int idPedidoSaidaItem) throws AferoDAOException {
			PreparedStatement ps = null;
			Connection conn = null;
			ResultSet rs = null;
			List<PedidoSaidaSubItens> list = null;
			
			try {
				String sql = "SELECT idPedidoSaidaSubItem, idPedidoSaidaItem, idProduto, idUnidade, dsCompProduto, comp, larg, quant, pDesc, vlUni, dtMod, usuario " +
							 "FROM tbPedidoSaidaSubItem " +
							 "WHERE idPedidoSaidaItem = ?";
				
				conn = this.conn;
				ps = conn.prepareStatement(sql);
				ps.setInt(1, idPedidoSaidaItem);
				rs = ps.executeQuery();
				list = new ArrayList<PedidoSaidaSubItens>();
				while (rs.next()) {

					
					int idPedSaidaSubItem = rs.getInt(1);
					idPedidoSaidaItem = rs.getInt(2);
					int idProduto = rs.getInt(3);
					int idUnidade = rs.getInt(4);
					String dsCompProduto = rs.getString(5);
					float comp = rs.getFloat(6);
					float larg = rs.getFloat(7);
					float quant = rs.getFloat(8);
					float pDesc = rs.getFloat(9);
					float vlUni = rs.getFloat(10);
					Date dtMod = rs.getDate(11);
					String usuario = rs.getString(12);
				
				
				list.add( new PedidoSaidaSubItens (idPedSaidaSubItem, idPedidoSaidaItem, idProduto, idUnidade, dsCompProduto, comp, larg, quant, pDesc, vlUni,
									dtMod, usuario));
				
				}
				
			} catch (SQLException sqle) {
				throw new AferoDAOException(sqle);
			} finally {
				// ConnectionFactory.closeConnection(conn, ps, rs);
			}
			return list;
		}


		public List<PedidoSaidaSubItens> listarPedidoSaidaSubItem(String clausula) throws AferoDAOException {
			PreparedStatement ps = null;
			Connection conn = null;
			ResultSet rs = null;
			List<PedidoSaidaSubItens> list = null;
			
			try {
				String sql = "SELECT idPedidoSaidaSubItem, idPedidoSaidaItem, idProduto, idUnidade, comp, larg, quant, pDesc, vlUni, dtMod, usuario " +
							"FROM tbPedidoSaidaSubItem ";
				
				if (clausula != null)
					sql = sql + clausula;
				conn = this.conn;
				ps = conn.prepareStatement(sql);
				rs = ps.executeQuery();
				list = new ArrayList<PedidoSaidaSubItens>();
				while (rs.next()) {

					
					int idPedSaidaSubItem = rs.getInt(1);
					int idPedidoSaidaItem = rs.getInt(2);
					int idProduto = rs.getInt(3);
					int idUnidade = rs.getInt(4);
					float comp = rs.getFloat(5);
					float larg = rs.getFloat(6);
					float quant = rs.getFloat(7);
					float pDesc = rs.getFloat(8);
					float vlUni = rs.getFloat(9);
					Date dtMod = rs.getDate(10);
					String usuario = rs.getString(11);
				
				
				list.add( new PedidoSaidaSubItens (idPedSaidaSubItem, idPedidoSaidaItem, idProduto, idUnidade, comp, larg, quant, pDesc, vlUni,
									dtMod, usuario));
				
				}
				
			} catch (SQLException sqle) {
				throw new AferoDAOException(sqle);
			} finally {
				// ConnectionFactory.closeConnection(conn, ps, rs);
			}
			return list;
		}
}

