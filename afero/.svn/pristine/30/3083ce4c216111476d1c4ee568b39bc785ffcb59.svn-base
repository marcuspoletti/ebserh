package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import afero.model.OrcamentoSubItem;

public class OrcamentoSubItemDAO{

	private Connection conn;
	
	public OrcamentoSubItemDAO(Connection conn) { 
		this.conn = conn;		
	}
	
	public void incluir(OrcamentoSubItem orcamentoItem) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (orcamentoItem == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tborcamentoitem(idOrcamento, idProduto, tbUnidade_idUnidade, idAgrupamento, dsCompProduto, comp, " +
						 "larg, quant, valor, pDesc, vlUni, aprovado, valorAprov, dtMod, usuario) " +
			             "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now(), ?)"; // ATENÇÃO -  O "tbUnidade_idUnidade" MUDOU para "idUnidade";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, orcamentoItem.getIdOrcamento());
			ps.setInt(2, orcamentoItem.getIdProduto());
			ps.setInt(3, orcamentoItem.getIdUnidade());
			if(orcamentoItem.getIdAgrupamento() > 0){
				ps.setInt(4, orcamentoItem.getIdAgrupamento());
			}else{
				ps.setNull(4, 0);
			}
			ps.setString(5, orcamentoItem.getDsCompProduto());
			ps.setFloat(6, orcamentoItem.getComp());
			ps.setFloat(7, orcamentoItem.getLarg());			
			ps.setFloat(8, orcamentoItem.getQuant());
			ps.setFloat(9, orcamentoItem.getValor());
			ps.setFloat(10, orcamentoItem.getpDesc());
			ps.setFloat(11, orcamentoItem.getVlUni());
			ps.setString(12, orcamentoItem.getAprovado());
			if(orcamentoItem.getValorAprov() > 0){
				ps.setFloat(13, orcamentoItem.getValorAprov());
			}else{
				ps.setNull(13, 0);
			}
			ps.setString(14, orcamentoItem.getUsuario());
			ps.executeUpdate();
		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(OrcamentoSubItem orcamentoItem) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (orcamentoItem == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tborcamentoitem set idOrcamento = ?, idProduto = ?, tbUnidade_idUnidade = ?, idAgrupamento = ?, dsCompProduto = ?, comp = ?, " +
						" larg = ?, quant = ?, valor = ?, pDesc = ?, vlUni = ?, aprovado = ?, valorAprov = ?, dtMod = now(), usuario = ? " +
						"WHERE idOrcamentoItem = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, orcamentoItem.getIdOrcamento());
			ps.setInt(2, orcamentoItem.getIdProduto());
			ps.setInt(3, orcamentoItem.getIdUnidade());
			ps.setInt(4, orcamentoItem.getIdAgrupamento());
			ps.setString(5, orcamentoItem.getDsCompProduto());
			ps.setFloat(6, orcamentoItem.getComp());
			ps.setFloat(7, orcamentoItem.getLarg());			
			ps.setFloat(8, orcamentoItem.getQuant());
			ps.setFloat(9, orcamentoItem.getValor());
			ps.setFloat(10, orcamentoItem.getpDesc());
			ps.setFloat(11, orcamentoItem.getVlUni());
			ps.setString(12, orcamentoItem.getAprovado());
			ps.setFloat(13, orcamentoItem.getValorAprov());
			ps.setString(14, orcamentoItem.getUsuario());
			ps.setInt(15, orcamentoItem.getIdOrcamentoItem());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void excluir(OrcamentoSubItem orcamentoItem) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (orcamentoItem == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {			
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tborcamentoitem WHERE idOrcamentoItem = ?");
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
		List<OrcamentoSubItem> list = null;
		
		try {
			String sql = "SELECT idOrcamentoItem, idOrcamento, idProduto, tbUnidade_idUnidade, idAgrupamento, dsCompProduto, comp, " +
						" larg, quant, valor, pDesc, vlUni, aprovado, valorAprov, dtMod, usuario " +
			             "FROM tborcamentoitem "+
			             "WHERE idOrcamento = ?";			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idOrcamento);
			rs = ps.executeQuery();
			list = new ArrayList<OrcamentoSubItem>();
			while (rs.next()) {
				int idOrcamentoItem = rs.getInt(1);
				int idOrc = rs.getInt(2);
				int idProduto   = rs.getInt(3);
				int idUnidade   = rs.getInt(4);
				int idAgrupamento = rs.getInt(5);
				String dsCompProduto = rs.getString(6);
				float comp = rs.getFloat(7);
				float larg = rs.getFloat(8);
				float quant     = rs.getFloat(9);
				float valor     = rs.getFloat(10);
				float pDesc = rs.getFloat(11);
				float vlUni = rs.getFloat(12);
				String aprovado = rs.getString(13);
				float valorAprov= rs.getFloat(14);
				Date dtMod      = rs.getDate(15);
				String usuario  = rs.getString(16);
				
				list.add(new OrcamentoSubItem(idOrcamentoItem, idOrc, idProduto, idUnidade, idAgrupamento, dsCompProduto, comp, larg, quant, 
						valor, pDesc, vlUni, aprovado, valorAprov, dtMod, usuario));

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
		List<OrcamentoSubItem> list = null;
		
		try {
			String sql = "SELECT idOrcamentoItem, idOrcamento, idProduto, tbUnidade_idUnidade, idAgrupamento, dsCompProduto, comp, " +
						" larg, quant, valor, pDesc, vlUni, aprovado, valorAprov, dtMod, usuario " +
			             "FROM tborcamentoitem";
			if (clausula != null) sql = sql + clausula;			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<OrcamentoSubItem>();
			while (rs.next()) {
				int idOrcamentoItem = rs.getInt(1);
				int idOrc = rs.getInt(2);
				int idProduto   = rs.getInt(3);
				int idUnidade   = rs.getInt(4);
				int idAgrupamento = rs.getInt(5);
				String dsCompProduto = rs.getString(6);
				float comp = rs.getFloat(7);
				float larg = rs.getFloat(8);
				float quant     = rs.getFloat(9);
				float valor     = rs.getFloat(10);
				float pDesc = rs.getFloat(11);
				float vlUni = rs.getFloat(12);
				String aprovado = rs.getString(13);
				float valorAprov= rs.getFloat(14);
				Date dtMod      = rs.getDate(15);
				String usuario  = rs.getString(16);

				list.add(new OrcamentoSubItem(idOrcamentoItem, idOrc, idProduto, idUnidade, idAgrupamento, dsCompProduto, comp, larg, quant, 
						valor, pDesc, vlUni, aprovado, valorAprov, dtMod, usuario));
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	
	public void aprovarOrcamentoItem(OrcamentoSubItem orcamentoItem)throws AferoDAOException{
		PreparedStatement ps = null;
		Connection conn = null;
		if (orcamentoItem == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tborcamentoitem set aprovado = ?, valorAprov = ? "+
		                 "WHERE idOrcamentoItem = ?";		
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, orcamentoItem.getAprovado());
			ps.setFloat(2, orcamentoItem.getValorAprov());
			ps.setInt(3, orcamentoItem.getIdOrcamentoItem());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}
	
	// LISTAR ORCAMENTO 
	
	public List listarOrcamento(int idOrcamento) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<OrcamentoSubItem> list = null;
		
		try {
			String sql = "SELECT idOrcamentoItem, idOrcamento, idProduto, tbUnidade_idUnidade, idAgrupamento, dsCompProduto, comp, " +
						" larg, quant, valor, pDesc, vlUni, aprovado, valorAprov, dtMod, usuario " +
			             "FROM tborcamentoitem " +
			             "WHERE idOrcamento = ?";			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idOrcamento);
			rs = ps.executeQuery();
			list = new ArrayList<OrcamentoSubItem>();
			while (rs.next()) {
				int idOrcamentoItem = rs.getInt(1);
				int idOrc = rs.getInt(2);
				int idProduto   = rs.getInt(3);
				int idUnidade   = rs.getInt(4);
				int idAgrupamento = rs.getInt(5);
				String dsCompProduto = rs.getString(6);
				float comp = rs.getFloat(7);
				float larg = rs.getFloat(8);
				float quant     = rs.getFloat(9);
				float valor     = rs.getFloat(10);
				float pDesc = rs.getFloat(11);
				float vlUni = rs.getFloat(12);
				String aprovado = rs.getString(13);
				float valorAprov= rs.getFloat(14);
				Date dtMod      = rs.getDate(15);
				String usuario  = rs.getString(16);

				list.add(new OrcamentoSubItem(idOrcamentoItem, idOrc, idProduto, idUnidade, idAgrupamento, dsCompProduto, comp, larg, quant, 
						valor, pDesc, vlUni, aprovado, valorAprov, dtMod, usuario));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	
	public OrcamentoSubItem procurarOrcamentoSubItem(int idOrcamentoItem) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		OrcamentoSubItem orcSubItem = null;
		
		try {
			String sql = "SELECT idOrcamentoItem, idOrcamento, idProduto, tbUnidade_idUnidade, idAgrupamento, dsCompProduto, comp, " +
						" larg, quant, valor, pDesc, vlUni, aprovado, valorAprov, dtMod, usuario " +
			             "FROM tborcamentoitem "+
			             "WHERE idOrcamentoItem = ?";			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idOrcamentoItem);
			rs = ps.executeQuery();
			while (rs.next()) {
				idOrcamentoItem = rs.getInt(1);
				int idOrc = rs.getInt(2);
				int idProduto   = rs.getInt(3);
				int idUnidade   = rs.getInt(4);
				int idAgrupamento = rs.getInt(5);
				String dsCompProduto = rs.getString(6);
				float comp = rs.getFloat(7);
				float larg = rs.getFloat(8);
				float quant     = rs.getFloat(9);
				float valor     = rs.getFloat(10);
				float pDesc = rs.getFloat(11);
				float vlUni = rs.getFloat(12);
				String aprovado = rs.getString(13);
				float valorAprov= rs.getFloat(14);
				Date dtMod      = rs.getDate(15);
				String usuario  = rs.getString(16);
				
				orcSubItem = new OrcamentoSubItem(idOrcamentoItem, idOrc, idProduto, idUnidade, idAgrupamento, dsCompProduto, comp, larg, quant, 
						valor, pDesc, vlUni, aprovado, valorAprov, dtMod, usuario);

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return orcSubItem;
	}
	public boolean getIdAgrupamentoOrcamento(int idAgrupamento) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = true;

		try {
			String sql = "select distinct(ag.idAgrupamento) "+
			             "from tborcamentoitem it "+
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
	public boolean getIdOrcamentoItem(int idOrcamentoItem) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = true;

		try {
			String sql = "select distinct(ag.idOrcamentoItem) "+
			             "from tborcamentoitem it "+ 
                         "Join tborcamentosubitem ag on it.idOrcamentoItem = ag.idOrcamentoItem "+ 
                         "where ag.idOrcamentoItem = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idOrcamentoItem);
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
	public float getValorSubItens(int idOrcamentoItem) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		float total = 0;

		try {
			String sql = "select round(sum(quant*vlUni),2) from tborcamentosubitem it where it.idOrcamentoItem = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idOrcamentoItem);
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

}
