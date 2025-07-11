package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import afero.model.PedidoSaidaSubItem;
import afero.model.SaidasProdutos;
import afero.model.MaisVendidos;

public class PedidoSaidaSubItemDAO{

	private Connection conn;
	
    public PedidoSaidaSubItemDAO(Connection conn) {
		this.conn = conn;
    }
	
	public void incluir(PedidoSaidaSubItem pedidoSaidaItem) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (pedidoSaidaItem == null)
			throw new AferoDAOException(
					"O valor passado n�o pode ser nulo");

		try {
			String sql = "INSERT INTO tbpedidosaidaitem(idPedidoSaida, idProduto, idUnidade, idAgrupamento, dsCompProduto, comp, larg, quant," +
						" valor, pDesc, vlUni, dtMod, usuario) " +
				         "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now(), ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, pedidoSaidaItem.getIdPedidoSaida());
			ps.setInt(2, pedidoSaidaItem.getIdProduto());
			ps.setInt(3, pedidoSaidaItem.getIdUnidade());
			if(pedidoSaidaItem.getIdAgrupamento() > 0){
				ps.setInt(4, pedidoSaidaItem.getIdAgrupamento());
			}else{
				ps.setNull(4, 0);
			}
			ps.setString(5, pedidoSaidaItem.getDsCompProduto());
			ps.setFloat(6, pedidoSaidaItem.getComp());
			ps.setFloat(7, pedidoSaidaItem.getLarg());
			ps.setFloat(8, pedidoSaidaItem.getQuant());
			ps.setFloat(9, pedidoSaidaItem.getValor());
			ps.setFloat(10, pedidoSaidaItem.getpDesc());
			ps.setFloat(11, pedidoSaidaItem.getVlUni());
			ps.setString(12, pedidoSaidaItem.getUsuario());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(PedidoSaidaSubItem pedidoSaidaItem) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (pedidoSaidaItem == null)
			throw new AferoDAOException("O valor passado n�o pode ser nulo");

		try {
			String sql = "UPDATE tbpedidosaidaitem set idPedidoSaida = ?, idProduto = ?, idUnidade = ?, idAgrupamento = ?, dsCompProduto = ?, " +
						 "comp = ?, larg = ?, quant = ?, valor = ?, pDesc = ?, vlUni = ?, dtMod = now(), usuario = ? " +
						 "WHERE idPedidoSaidaItem = ?";		
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, pedidoSaidaItem.getIdPedidoSaida());
			ps.setInt(2, pedidoSaidaItem.getIdProduto());
			ps.setInt(3, pedidoSaidaItem.getIdUnidade());
			ps.setInt(4, pedidoSaidaItem.getIdAgrupamento());
			ps.setString(5, pedidoSaidaItem.getDsCompProduto());
			ps.setFloat(6, pedidoSaidaItem.getComp());
			ps.setFloat(7, pedidoSaidaItem.getLarg());
			ps.setFloat(8, pedidoSaidaItem.getQuant());
			ps.setFloat(9, pedidoSaidaItem.getValor());
			ps.setFloat(10, pedidoSaidaItem.getpDesc());
			ps.setFloat(11, pedidoSaidaItem.getVlUni());
			ps.setString(12, pedidoSaidaItem.getUsuario());
			ps.setInt(13, pedidoSaidaItem.getIdPedidoSaidaItem());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void excluir(PedidoSaidaSubItem pedidoSaidaItem) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;		
		if (pedidoSaidaItem == null)
			throw new AferoDAOException(
					"O valor passado n�o pode ser nulo");

		try {			
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbpedidosaidaitem WHERE idPedidoSaidaItem = ?");
			ps.setInt(1, pedidoSaidaItem.getIdPedidoSaidaItem());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public List procurarPedidoSaidaItem(int idPedidoSaidaItem) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<PedidoSaidaSubItem> list = null;
		
		try {
			String sql = "SELECT idPedidoSaidaItem, idPedidoSaida, idProduto, idUnidade, idAgrupamento, dsCompProduto, comp, larg, quant, " +
						 "valor, pDesc, vlUni, dtMod, usuario " +
						 "FROM tbpedidosaidaitem " +
						 "WHERE idPedidoSaida = ?";			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idPedidoSaidaItem);
			rs = ps.executeQuery();
			list = new ArrayList<PedidoSaidaSubItem>();
			while (rs.next()) {
				
				int idPedSaidaItem = rs.getInt(1);
				int idPedidoSaida = rs.getInt(2);
				int idProduto = rs.getInt(3);
				int idUnidade   = rs.getInt(4);
				int idAgrupamento = rs.getInt(5);
				String dsCompProduto = rs.getString(6);
				float comp = rs.getFloat(7);
				float larg = rs.getFloat(8);
				float quant = rs.getFloat(9);
				float valor = rs.getFloat(10);
				float pDesc = rs.getFloat(11);
				float vlUni = rs.getFloat(12);
				Date dtMod = rs.getDate(13);
				String usuario = rs.getString(14);
				
				list.add(new PedidoSaidaSubItem(idPedSaidaItem, idPedidoSaida, idProduto, idUnidade, idAgrupamento, dsCompProduto, comp, larg,
						quant, valor, dtMod, usuario, pDesc, vlUni));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}

	public List listarPedidoSaidaItem(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<PedidoSaidaSubItem> list = null;
		
		try {
			String sql = "SELECT idPedidoSaidaItem, idPedidoSaida, idProduto, idUnidade, idAgrupamento, dsCompProduto, comp, larg, quant, " +
						 "valor, pDesc, vlUni, dtMod, usuario " +
					     "from tbpedidosaidaitem ";
			if (clausula != null) sql = sql + clausula;			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<PedidoSaidaSubItem>();
			while (rs.next()) {
				
				int idPedSaidaItem = rs.getInt(1);
				int idPedidoSaida = rs.getInt(2);
				int idProduto = rs.getInt(3);
				int idUnidade   = rs.getInt(4);
				int idAgrupamento = rs.getInt(5);
				String dsCompProduto = rs.getString(6);
				float comp = rs.getFloat(7);
				float larg = rs.getFloat(8);
				float quant = rs.getFloat(9);
				float valor = rs.getFloat(10);
				float pDesc = rs.getFloat(11);
				float vlUni = rs.getFloat(12);
				Date dtMod = rs.getDate(13);
				String usuario = rs.getString(14);
				
				list.add(new PedidoSaidaSubItem(idPedSaidaItem, idPedidoSaida, idProduto, idUnidade, idAgrupamento, dsCompProduto, comp, larg,
						quant, valor, dtMod, usuario, pDesc, vlUni));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	public boolean getIdAgrupamentoPedido(int idAgrupamento) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = true;

		try {
			String sql = "select distinct(ag.idAgrupamento) "+
		                         "from tbpedidosaidaitem it "+ 
                                 "Join tbagrupamento ag on it.idAgrupamento = ag.idAgrupamento "+ 
                                 "where ag.idAgrupamento = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idAgrupamento);
			rs = ps.executeQuery();
			if (rs.next()) {
				ok = true;
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
	public boolean getidPedidoItem(int idPedidoSaidaItem) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = true;

		try {
			String sql = "Select distinct(ag.idPedidoSaidaItem) "+
			             "from tbpedidosaidaitem it "+ 
                         "Join tbpedidosaidasubitem ag on it.idPedidoSaidaItem = ag.idPedidoSaidaItem "+ 
                         "where ag.idPedidoSaidaItem = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idPedidoSaidaItem);
			rs = ps.executeQuery();
			if (rs.next()) {
				ok = true;
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
	public List listarSaidaItem(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<SaidasProdutos> list = null;
		
		try {
			String sql = "Select ps.idPedidoSaida, ps.dtPed, psi.quant, ps.operacao, ps.status "+
                         "From tbproduto p "+ 
                         "Join tbpedidosaidaitem psi on (p.idProduto = psi.idProduto) "+
                         "Join tbpedidosaida ps on (psi.idPedidoSaida = ps.idPedidoSaida) ";
			if (clausula != null) sql = sql + clausula;			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<SaidasProdutos>();
			while (rs.next()) {
				int idPedidoSaida = rs.getInt(1);
				Date dtPed   = rs.getDate(2);
				float quant     = rs.getFloat(3);
				String operacao  = rs.getString(4);
				String status  = rs.getString(5);
				
				list.add(new SaidasProdutos(idPedidoSaida, dtPed, quant, operacao, status));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	public float quantDeSaidaPorItem(int idProduto, int idLoja) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		float quant = 0;
		
		try {
			String sql = "SELECT sum(pi.quant) "+
                         "FROM tbpedidosaidaitem pi "+ 
                         "JOIN tbpedidosaida p on (pi.idPedidoSaida = p.idPedidoSaida) "+
			             "WHERE pi.idProduto = ? and p.idLoja = ? and p.status='A' and pi.quant >= 0 ";
			             		
			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idProduto);
			ps.setInt(2, idLoja);
			rs = ps.executeQuery();
			if (rs.next()) {
			    quant = rs.getFloat(1);
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return quant;
	}
	public List maisVendidos(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<MaisVendidos> list = null;
		
		try {
			String sql = "select distinct(ps.idProduto),p.nmProduto, sum(ps.quant) as quantidade "+
                         "from tbpedidosaida pss " +
	                     "join tbpedidosaidaitem ps on (pss.idPedidoSaida = ps.idPedidoSaida) "+
                         "join tbproduto p on (ps.idProduto = p.idProduto) ";
			if (clausula != null) sql = sql + clausula;			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<MaisVendidos>();
			while (rs.next()) {
				int idProduto = rs.getInt(1);
				String nmProduto = rs.getString(2);
				float quant     = rs.getFloat(3);
				list.add(new MaisVendidos(idProduto, nmProduto, quant));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	public int idPedidoSaidaItem() throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		int numPedidoSaida = 0;
		
		try {
			String sql = "select max(idPedidoSaidaItem) from tbpedidosaidaitem order by idPedidoSaidaItem DESC LIMIT 1";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if (rs.next()) {
				numPedidoSaida = rs.getInt(1);
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return numPedidoSaida;
	}
	public float maiorValor(int idPedidoSaida)throws AferoDAOException{
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		float maiorValor = 0;
		
		try {
			String sql = "SELECT max(pr.preco) "+ 
            				"from tbpedidosaidaitem subi "+
            				"join tbproduto p on (subi.idProduto = p.idProduto) "+
            				"join tbestoque e on (p.idProduto = e.idProduto) "+
            				"join tbpreco pr on (e.idEstoque = pr.idEstoque) "+
            				"where pr.precoPadrao = 'S' AND subi.idPedidoSaida = ? ";
			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idPedidoSaida);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o c�digo: " + idPedidoSaida);
			}
			maiorValor = rs.getFloat(1);
			
		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		}
		  return maiorValor;
		}
	
	public void atualizarValorUnit(int idPedidoSaidaItem, float vlUni, String usuario) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		try {
			String sql = "UPDATE tbpedidosaidaitem SET valor = ?, dtMod = now(), usuario = ? "+
						"WHERE idPedidoSaidaItem = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setFloat(1, vlUni);
			ps.setString(2, usuario);
			ps.setInt(3, idPedidoSaidaItem);
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao atualizar dados: " + e);
		}
	}
	public float getValorSubItens(int idPedidoSaidaItem) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		float total = 0;

		try {
			String sql = "select round(sum(quant*vlUni),2) from tbpedidosaidasubitem it where it.idPedidoSaidaItem = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idPedidoSaidaItem);
			rs = ps.executeQuery();
			if (rs.next()) {
				total = rs.getFloat(1);
		
			}
            
		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return total;
	}
	public void atualizarImpProducao(String impProducao,int idPedidoSaidaItem) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		try {
			String sql = "UPDATE tbpedidosaidaitem set impProducao = ? WHERE idPedidoSaidaItem = ?";		
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, impProducao);
			ps.setInt(2, idPedidoSaidaItem);
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} 
	}
	public String getImpProducao(int idPedidoSaidaItem) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		String impProducao = "";

		try {
			String sql = "SELECT impProducao FROM tbpedidosaidaitem WHERE idPedidoSaidaItem = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idPedidoSaidaItem);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException(
						"N�o foi encontrado nenhum registro");
			}

			impProducao = rs.getString(1);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		}
		return impProducao;
	}
}
