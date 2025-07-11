package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import afero.model.OrcamentoItem;

public class OrcamentoItemDAO implements IOrcamentoItemDAO{

	private Connection conn;
	
	public OrcamentoItemDAO(Connection conn) { 
		this.conn = conn;		
	}
	
	public void incluir(OrcamentoItem orcamentoItem) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (orcamentoItem == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tborcamentoitem(idOrcamento, idProduto, " +
			             "tbUnidade_idUnidade, quant, valor, aprovado, dtMod, "+
			             "usuario, pDesc, vlUni) " +
			             "values(?, ?, ?, ?, ?, ?, now(), ?, ?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, orcamentoItem.getIdOrcamento());
			ps.setInt(2, orcamentoItem.getIdProduto());
			ps.setInt(3, orcamentoItem.getIdUnidade());
			ps.setFloat(4, orcamentoItem.getQuant());
			ps.setFloat(5, orcamentoItem.getValor());
			ps.setString(6, orcamentoItem.getAprovado());
			ps.setString(7, orcamentoItem.getUsuario());
			ps.setFloat(8, orcamentoItem.getPDesc());
			ps.setFloat(9, orcamentoItem.getVlUni());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(OrcamentoItem orcamentoItem) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (orcamentoItem == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tborcamentoitem set idProduto = ? idUnidade = ?, "+
		             "quant = ?, valor = ?, dtMod = now(), usuario = ?, pDesc = ?, vlUni = ? "+
		             "where idOrcamentoItem = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, orcamentoItem.getIdProduto());
			ps.setInt(2, orcamentoItem.getIdUnidade());
			ps.setFloat(3, orcamentoItem.getQuant());
			ps.setFloat(4, orcamentoItem.getValor());
			ps.setString(5, orcamentoItem.getUsuario());
			ps.setFloat(6, orcamentoItem.getPDesc());
			ps.setFloat(7, orcamentoItem.getVlUni());
			ps.setInt(8, orcamentoItem.getIdOrcamentoItem());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void excluir(OrcamentoItem orcamentoItem) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (orcamentoItem == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {			
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tborcamentoitem WHERE idOrcamentoItem=?");
			ps.setInt(1, orcamentoItem.getIdOrcamentoItem());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public List procurarOrcamentoItem(int idOrcamento) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<OrcamentoItem> list = null;
		
		try {
			String sql = "SELECT idOrcamentoItem, idOrcamento, idProduto, "+
			             "tbUnidade_idUnidade, quant, valor, aprovado, "+
			             "valorAprov, dtMod, usuario, pDesc, vlUni "+
			             "FROM tborcamentoitem "+
			             "Where idOrcamento = ?";			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idOrcamento);
			rs = ps.executeQuery();
			list = new ArrayList<OrcamentoItem>();
			while (rs.next()) {
				int idOrcamentoItem = rs.getInt(1);
				int idOrc = rs.getInt(2);
				int idProduto   = rs.getInt(3);
				int idUnidade   = rs.getInt(4);
				float quant     = rs.getFloat(5);
				float valor     = rs.getFloat(6);
				String aprovado = rs.getString(7);
				float valorAprov= rs.getFloat(8);
				Date dtMod      = rs.getDate(9);
				String usuario  = rs.getString(10);
				float pDesc = rs.getFloat(11);
				float vlUni = rs.getFloat(12);
				
				list.add(new OrcamentoItem(idOrcamentoItem, idOrc, idProduto,
						idUnidade, quant, valor, aprovado, valorAprov, dtMod, 
						usuario, pDesc, vlUni));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}

	public List listarOrcamentoItem(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<OrcamentoItem> list = null;
		
		try {
			String sql = "SELECT idOrcamentoItem, idOrcamento, idProduto, "+
			             "tbUnidade_idUnidade, quant, valor, aprovado, "+
			             "valorAprov, dtMod, usuario, pDesc, vlUni "+
			             "FROM tborcamentoitem";
			if (clausula != null) sql = sql + clausula;			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<OrcamentoItem>();
			while (rs.next()) {
				int idOrcamentoItem = rs.getInt(1);
				int idOrcamento = rs.getInt(2);
				int idProduto   = rs.getInt(3);
				int idUnidade   = rs.getInt(4);
				float quant     = rs.getFloat(5);
				float valor     = rs.getFloat(6);
				String aprovado = rs.getString(7);
				float valorAprov= rs.getFloat(8);
				Date dtMod      = rs.getDate(9);
				String usuario  = rs.getString(10);
				float pDesc = rs.getFloat(11);
				float vlUni = rs.getFloat(12);

				list.add(new OrcamentoItem(idOrcamentoItem, idOrcamento, idProduto,
						idUnidade, quant, valor, aprovado, valorAprov, dtMod, usuario,
						pDesc, vlUni));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	
	public void aprovarOrcamentoItem(OrcamentoItem orcamentoItem)throws AferoDAOException{
		PreparedStatement ps = null;
		Connection conn = null;
		if (orcamentoItem == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tborcamentoitem set aprovado = ?, valorAprov = ? "+
		                 "where idOrcamentoItem = ?";		
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, orcamentoItem.getAprovado());
			ps.setFloat(2, orcamentoItem.getValor());
			ps.setInt(3, orcamentoItem.getIdOrcamentoItem());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}
	public List listarOrcamento(int idOrcamento) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<OrcamentoItem> list = null;
		
		try {
			String sql = "SELECT idOrcamentoItem, idOrcamento, idProduto, "+
			             "tbUnidade_idUnidade, quant, valor, aprovado, "+
			             "valorAprov, dtMod, usuario, pDesc, vlUni "+
			             "FROM tborcamentoitem " +
			             "WHERE idOrcamento = ?";			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idOrcamento);
			rs = ps.executeQuery();
			list = new ArrayList<OrcamentoItem>();
			while (rs.next()) {
				int idOrcamentoItem = rs.getInt(1);
				int idProduto   = rs.getInt(3);
				int idUnidade   = rs.getInt(4);
				float quant     = rs.getFloat(5);
				float valor     = rs.getFloat(6);
				String aprovado = rs.getString(7);
				float valorAprov= rs.getFloat(8);
				Date dtMod      = rs.getDate(9);
				String usuario  = rs.getString(10);
				float pDesc = rs.getFloat(11);
				float vlUni = rs.getFloat(12);
				
				list.add(new OrcamentoItem(idOrcamentoItem, idOrcamento, idProduto,
						idUnidade, quant, valor, aprovado, valorAprov, dtMod, usuario,
						pDesc, vlUni));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	public List listarOrcamentoItemDeletados(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<OrcamentoItem> list = null;
		
		try {
			String sql =  "SELECT oi.idOrcamentoItem, oi.idOrcamento, oi.idProduto, "+ 
			 			  "oi.tbUnidade_idUnidade, oi.quant, oi.valor, oi.aprovado, "+ 
			              "oi.valorAprov, oi.dtMod, oi.usuario, oi.pDesc, oi.vlUni "+
                          "FROM tborcamentoitem oi "+
                          "JOIN tbproduto p  on (oi.idProduto = p.idProduto) "+
                          "WHERE p.status='I' "+
                          "Group by oi.idOrcamentoItem ";
			if (clausula != null) sql = sql + clausula;			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<OrcamentoItem>();
			while (rs.next()) {
				int idOrcamentoItem = rs.getInt(1);
				int idOrcamento = rs.getInt(2);
				int idProduto   = rs.getInt(3);
				int idUnidade   = rs.getInt(4);
				float quant     = rs.getFloat(5);
				float valor     = rs.getFloat(6);
				String aprovado = rs.getString(7);
				float valorAprov= rs.getFloat(8);
				Date dtMod      = rs.getDate(9);
				String usuario  = rs.getString(10);
				float pDesc = rs.getFloat(11);
				float vlUni = rs.getFloat(12);

				list.add(new OrcamentoItem(idOrcamentoItem, idOrcamento, idProduto,
						idUnidade, quant, valor, aprovado, valorAprov, dtMod, usuario,
						pDesc, vlUni));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}

}
