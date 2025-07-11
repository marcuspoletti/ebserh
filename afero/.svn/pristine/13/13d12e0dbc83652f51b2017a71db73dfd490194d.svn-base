package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import afero.model.Orcamento;
import afero.model.OrcamentoSubItens;

public class OrcamentoSubItensDAO {
	
	public Connection conn;

	public OrcamentoSubItensDAO(Connection conn) {
		this.conn = conn;
	}
	
	public void incluir(OrcamentoSubItens orcamentoSubItem) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (orcamentoSubItem == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbOrcamentoSubItem(idOrcamentoItem, idProduto, idUnidade, comp, larg, quant, pDesc, vlUni, dtMod, usuario)" +
						" VALUES (?, ?, ?, ?, ?, ?, ?, ?, now(), ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, orcamentoSubItem.getIdOrcamentoItem());
			ps.setInt(2, orcamentoSubItem.getIdProduto());
			ps.setInt(3, orcamentoSubItem.getIdUnidade());
			ps.setFloat(4, orcamentoSubItem.getComp());
			ps.setFloat(5, orcamentoSubItem.getLarg());
			ps.setFloat(6, orcamentoSubItem.getQuant());
			ps.setFloat(7, orcamentoSubItem.getpDesc());
			ps.setFloat(8, orcamentoSubItem.getVlUni());
			ps.setString(9, orcamentoSubItem.getUsuario());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);
		}
	}

	public void atualizar(OrcamentoSubItens orcamentoSubItem) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (orcamentoSubItem == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbOrcamentoSubItem SET idOrcamentoItem = ?, idProduto = ?, idUnidade = ?, comp = ?, larg = ?, quant = ?, " +
						" pDesc = ?, vlUni = ?, dtMod = now(), usuario = ? " +
						"WHERE idOrcamentoSubItem = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, orcamentoSubItem.getIdOrcamentoItem());
			ps.setInt(2, orcamentoSubItem.getIdProduto());
			ps.setInt(3, orcamentoSubItem.getIdUnidade());
			ps.setFloat(4, orcamentoSubItem.getComp());
			ps.setFloat(5, orcamentoSubItem.getLarg());
			ps.setFloat(6, orcamentoSubItem.getQuant());
			ps.setFloat(7, orcamentoSubItem.getpDesc());
			ps.setFloat(8, orcamentoSubItem.getVlUni());
			ps.setString(9, orcamentoSubItem.getUsuario());
			ps.setInt(10, orcamentoSubItem.getIdOrcamentoSubItem());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao atualizar dados: " + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);
		}
	}
	
	public void excluir(OrcamentoSubItens orcamentoSubItem) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (orcamentoSubItem == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tborcamentoSubItem WHERE idOrcamentoSubItem = ?");
			ps.setInt(1, orcamentoSubItem.getIdOrcamentoSubItem());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			// ConnectionFactory.closeConnection(conn, ps);
		}
	}
	
	
	public OrcamentoSubItens procurarOrcamentoSubItem(int idOrcamentoSubItem) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		OrcamentoSubItens orcamentoSubItem = null;
		
		try {
			String sql = "SELECT idOrcamentoSubItem, idOrcamentoItem, idProduto, idUnidade, comp, larg, quant, pDesc, vlUni, dtMod, usuario " +
						"FROM tbOrcamentoSubItem " +
						"WHERE idOrcamentoSubItem = ?";
			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idOrcamentoSubItem);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + idOrcamentoSubItem);
			}
			
			int idOrcSubItem = rs.getInt(1);
			int idOrcamentoItem = rs.getInt(2);
			int idProduto = rs.getInt(3);
			int idUnidade = rs.getInt(4);
			float comp = rs.getFloat(5);
			float larg = rs.getFloat(6);
			float quant = rs.getFloat(7);
			float pDesc = rs.getFloat(8);
			float vlUni = rs.getFloat(9);
			Date dtMod = rs.getDate(10);
			String usuario = rs.getString(11);
			
			
			orcamentoSubItem = new OrcamentoSubItens(idOrcSubItem, idOrcamentoItem, idProduto, idUnidade, comp, larg, quant, pDesc, vlUni,
								dtMod, usuario); 
			
		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return orcamentoSubItem;
		}

	public OrcamentoSubItens procurarOrcamentoSubItens(int idOrcamentoItem) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		OrcamentoSubItens orcamentoSubItem = null;
		
		try {
			String sql = "SELECT idOrcamentoSubItem, idOrcamentoItem, idProduto, idUnidade, comp, larg, quant, pDesc, vlUni, dtMod, usuario " +
						"FROM tbOrcamentoSubItem " +
						"WHERE idOrcamentoItem = ?";
			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idOrcamentoItem);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + idOrcamentoItem);
			}
			
			int idOrcSubItem = rs.getInt(1);
			idOrcamentoItem = rs.getInt(2);
			int idProduto = rs.getInt(3);
			int idUnidade = rs.getInt(4);
			float comp = rs.getFloat(5);
			float larg = rs.getFloat(6);
			float quant = rs.getFloat(7);
			float pDesc = rs.getFloat(8);
			float vlUni = rs.getFloat(9);
			Date dtMod = rs.getDate(10);
			String usuario = rs.getString(11);
			
			
			orcamentoSubItem = new OrcamentoSubItens(idOrcSubItem, idOrcamentoItem, idProduto, idUnidade, comp, larg, quant, pDesc, vlUni,
								dtMod, usuario); 
			
		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return orcamentoSubItem;
		}

	public List<OrcamentoSubItens> listarOrcamentoSubItem(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<OrcamentoSubItens> list = null;
		
		try {
			String sql = "SELECT idOrcamentoSubItem, idOrcamentoItem, idProduto, idUnidade, comp, larg, quant, pDesc, vlUni, dtMod, usuario " +
						"FROM tbOrcamentoSubItem ";
			
			if (clausula != null)
				sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<OrcamentoSubItens>();
			while (rs.next()) {

				
				int idOrcSubItem = rs.getInt(1);
				int idOrcamentoItem = rs.getInt(2);
				int idProduto = rs.getInt(3);
				int idUnidade = rs.getInt(4);
				float comp = rs.getFloat(5);
				float larg = rs.getFloat(6);
				float quant = rs.getFloat(7);
				float pDesc = rs.getFloat(8);
				float vlUni = rs.getFloat(9);
				Date dtMod = rs.getDate(10);
				String usuario = rs.getString(11);
			
			
			list.add( new OrcamentoSubItens (idOrcSubItem, idOrcamentoItem, idProduto, idUnidade, comp, larg, quant, pDesc, vlUni,
								dtMod, usuario));
			
			}
			
		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
		}
	public List<OrcamentoSubItens> procurarOrcamentoSubItensList(int idOrcamentoItem) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<OrcamentoSubItens> list = null;
		
		try {
			String sql = "SELECT idOrcamentoSubItem, idOrcamentoItem, idProduto, idUnidade, comp, larg, quant, pDesc, vlUni, dtMod, usuario " +
						"FROM tbOrcamentoSubItem " +
						"WHERE idOrcamentoItem = ?";
			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idOrcamentoItem);
			rs = ps.executeQuery();
			list = new ArrayList<OrcamentoSubItens>();
			while (rs.next()) {
				int idOrcSubItem = rs.getInt(1);
				 idOrcamentoItem = rs.getInt(2);
				int idProduto = rs.getInt(3);
				int idUnidade = rs.getInt(4);
				float comp = rs.getFloat(5);
				float larg = rs.getFloat(6);
				float quant = rs.getFloat(7);
				float pDesc = rs.getFloat(8);
				float vlUni = rs.getFloat(9);
				Date dtMod = rs.getDate(10);
				String usuario = rs.getString(11);
			
			
			    list.add( new OrcamentoSubItens (idOrcSubItem, idOrcamentoItem, idProduto, idUnidade, comp, larg, quant, pDesc, vlUni,
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
