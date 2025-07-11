package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import afero.model.PedidoEntradaItem;
import afero.util.ConverteDate;
import afero.model.EntradaProdutos;
import afero.model.ListarEntradasProduto;
public class PedidoEntradaItemDAO implements IPedidoEntradaItemDAO{

	private Connection conn;

	public PedidoEntradaItemDAO(Connection conn) {
		this.conn = conn;		
	}
	
	public void incluir(PedidoEntradaItem pedidoEntradaItem) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (pedidoEntradaItem == null)
			throw new AferoDAOException(
					"O valor passado n�o pode ser nulo");

		try {
			String sql = "INSERT INTO tbpedidoentradaitem(idPedidoEntrada, idProduto, idUnidade, quantPedida, quant, valor, loteFab, dtVal, dtMod, usuario) " +
					     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, now(), ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, pedidoEntradaItem.getIdPedidoEntrada());
			ps.setInt(2, pedidoEntradaItem.getIdProduto());
			ps.setInt(3, pedidoEntradaItem.getIdUnidade());
			ps.setFloat(4, pedidoEntradaItem.getQuantPedida());
			ps.setFloat(5, pedidoEntradaItem.getQuant());
			ps.setDouble(6, pedidoEntradaItem.getValor());
			ps.setString(7, pedidoEntradaItem.getLoteFab());
			//if((pedidoEntradaItem.getDtVal().toString() != "")||(pedidoEntradaItem.getDtVal().toString() != null)){
			ps.setDate(8, ConverteDate.DateToDateSql(pedidoEntradaItem.getDtVal()));
			//}else{
			//	ps.setString(8, null);
			//}
			ps.setString(9, pedidoEntradaItem.getUsuario());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} 
	}

	public void atualizar(PedidoEntradaItem pedidoEntradaItem) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (pedidoEntradaItem == null)
			throw new AferoDAOException("O valor passado n�o pode ser nulo");

		try {
			String sql = "UPDATE tbpedidoentradaitem set idPedidoEntrada = ?, idProduto = ?, idUnidade = ?, quantPedida = ?, quant = ?, valor = ?, loteFab = ?, dtVal = ?, dtMod = now(), usuario = ? "+
					     "WHERE idPedidoEntradaItem = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, pedidoEntradaItem.getIdPedidoEntrada());
			ps.setInt(2, pedidoEntradaItem.getIdProduto());
			ps.setInt(3, pedidoEntradaItem.getIdUnidade());
			ps.setFloat(4, pedidoEntradaItem.getQuantPedida());
			ps.setFloat(5, pedidoEntradaItem.getQuant());
			ps.setDouble(6, pedidoEntradaItem.getValor());
			ps.setString(7, pedidoEntradaItem.getLoteFab());
			ps.setDate(8, ConverteDate.DateToDateSql(pedidoEntradaItem.getDtVal()));
			ps.setString(9, pedidoEntradaItem.getUsuario());
			ps.setInt(10, pedidoEntradaItem.getIdPedidoEntradaItem());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} 
	}

	public void excluir(PedidoEntradaItem pedidoEntradaItem) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (pedidoEntradaItem == null)
			throw new AferoDAOException(
					"O valor passado n�o pode ser nulo");

		try {			
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbpedidoentradaitem WHERE idPedidoEntradaItem=?");
			ps.setInt(1, pedidoEntradaItem.getIdPedidoEntradaItem());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} 

	}

	public PedidoEntradaItem procurarPedidoEntradaItem(int idPedidoEntradaItem) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		PedidoEntradaItem  pedidoEntradaItem = null;
				
		try {
			String sql = "SELECT idPedidoEntrada, idProduto, idUnidade, quantPedida, quant, valor, loteFab, dtVal, dtMod, usuario "+
			             "from tbpedidoentradaitem "+
                         "WHERE idPedidoEntradaItem = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idPedidoEntradaItem);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("N�o foi encontrado nenhum "
						+ "registro com o c�digo: " + idPedidoEntradaItem);
			}
			int idPedidoEntrada = rs.getInt(1);
			int idProduto = rs.getInt(2);
			int idUnidade = rs.getInt(3);
			float quantPedida = rs.getFloat(4);
			float quant = rs.getFloat(5);
			float valor = rs.getFloat(6);
			String loteFab = rs.getString(7);
			Date dtVal = rs.getDate(7);
			Date dtMod = rs.getDate(9);
			String usuario = rs.getString(10);

			pedidoEntradaItem = new PedidoEntradaItem(idPedidoEntradaItem, idPedidoEntrada,
					idProduto, idUnidade, quantPedida, quant,
					valor, loteFab, dtVal, dtMod, usuario);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return pedidoEntradaItem;
	}

	public List listarPedidoEntradaItem(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<PedidoEntradaItem> list = null;
		
		try {
			String sql = "SELECT pi.idPedidoEntradaItem, pi.idPedidoEntrada, pi.idProduto, pi.idUnidade, pi.quantPedida, pi.quant, pi.valor, pi.loteFab, pi.dtVal, pi.dtMod, pi.usuario "+ 
			             "from tbpedidoentradaitem pi "+
			             "join tbentidade e on (pi.cdEntidade = e.cdEntidade) ";
			if (clausula != null) sql = sql + clausula;			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<PedidoEntradaItem>();
			while (rs.next()) {
				int idPedidoEntradaItem = rs.getInt(1);
				int idPedidoEntrada = rs.getInt(2);
				int idProduto = rs.getInt(3);
				int idUnidade = rs.getInt(4);
				float quantPedida = rs.getFloat(5);
				float quant = rs.getFloat(6);
				float valor = rs.getFloat(7);
				String loteFab = rs.getString(8);
				Date dtVal = rs.getDate(9);
				Date dtMod = rs.getDate(10);
				String usuario = rs.getString(11);
				
				list.add(new PedidoEntradaItem(idPedidoEntradaItem, idPedidoEntrada,
						idProduto, idUnidade, quantPedida, quant,
						valor, loteFab, dtVal, dtMod, usuario));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return list;
	}
	
	public List listarProcurarPedidoEntradaItem(int idPedidoEntradaPesquisa) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<PedidoEntradaItem> list = null;
		
		try {
			String sql = "SELECT pi.idPedidoEntradaItem, pi.idPedidoEntrada, pi.idProduto, pi.idUnidade, pi.quantPedida, pi.quant, pi.valor, pi.loteFab, pi.dtVal, pi.dtMod, pi.usuario "+ 
			             "FROM tbpedidoentradaitem pi "+
			             "WHERE idPedidoEntrada = ?";			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idPedidoEntradaPesquisa);
			rs = ps.executeQuery();
			list = new ArrayList<PedidoEntradaItem>();
			while (rs.next()) {
				int idPedidoEntradaItem = rs.getInt(1);
				int idPedidoEntrada = rs.getInt(2);
				int idProduto = rs.getInt(3);
				int idUnidade = rs.getInt(4);
				float quantPedida = rs.getFloat(5);
				float quant = rs.getFloat(6);
				float valor = rs.getFloat(7);
				String loteFab = rs.getString(8);
				Date dtVal = rs.getDate(9);
				Date dtMod = rs.getDate(10);
				String usuario = rs.getString(11);
				
				list.add(new PedidoEntradaItem(idPedidoEntradaItem, idPedidoEntrada,
						idProduto, idUnidade, quantPedida, quant,
						valor, loteFab, dtVal, dtMod, usuario));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return list;
	}
	public List listarEntrada(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<EntradaProdutos> list = null;
		
		try {
			String sql = "Select pe.nrDoc, pe.dtPed, pei.quant, pe.operacao, pe.status, pe.idPedidoEntrada "+
                         "From tbproduto p "+
                         "Join tbpedidoentradaitem pei on (p.idProduto = pei.idProduto) "+
                         "Join tbpedidoentrada pe on (pei.idPedidoEntrada = pe.idPedidoEntrada) ";
			if (clausula != null) sql = sql + clausula;			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<EntradaProdutos>();
			while (rs.next()) {
				String nrDoc = rs.getString(1);
				Date dtPed= rs.getDate(2);
				float quant = rs.getInt(3);
				String operacao = rs.getString(4);
				String status = rs.getString(5);
				int idPedidoEntrada = rs.getInt(6);
				
				list.add(new EntradaProdutos(nrDoc, idPedidoEntrada, dtPed,
						quant, operacao, status));
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return list;
	}
	public List listarEntradaProduto(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<ListarEntradasProduto> list = null;
		
		try {
			String sql = "Select p.idProduto, p.idDivisao, p.idSubGrupo, p.idGrupo, p.nmProduto, p.dsProduto, p.tipoProduto, p.status, p.dtCad, p.dtMod, p.usuario, p.cdBarra, pe.nrDoc, pe.dtPed, pei.quant, pe.operacao, pe.status, pe.idPedidoEntrada, pei.valor "+
                         "From tbproduto p "+
                         "Join tbpedidoentradaitem pei on (p.idProduto = pei.idProduto) "+
                         "Join tbpedidoentrada pe on (pei.idPedidoEntrada = pe.idPedidoEntrada) ";
			if (clausula != null) sql = sql + clausula;			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<ListarEntradasProduto>();
			while (rs.next()) {
				int idProduto = rs.getInt(1);
				int idDivisao = rs.getInt(2);
				int idSubGrupo = rs.getInt(3);
				int idGrupo = rs.getInt(4);
				String nmProduto = rs.getString(5);
				String dsProduto = rs.getString(6);
				String tipoProduto = rs.getString(7);
				String status = rs.getString(8);
				Date dtCad = rs.getDate(9);
				Date dtMod = rs.getDate(10);
				String usuario = rs.getString(11);
				String cdBarra = rs.getString(12);
				String nrDoc = rs.getString(13);
				Date dtPed= rs.getDate(14);
				float quant = rs.getInt(15);
				String operacao = rs.getString(16);
				String statusPedido = rs.getString(17);
				int idPedidoEntrada = rs.getInt(18);
				float valor = rs.getFloat(19);
				float custo = 0;
				
				list.add(new ListarEntradasProduto(idProduto,  idDivisao,  idSubGrupo,
						 idGrupo,  nmProduto,  dsProduto,
						 tipoProduto,  status,  dtCad,  dtMod,
						 usuario,  cdBarra,  nrDoc,  dtPed,
						 quant,  operacao,  statusPedido,
						 idPedidoEntrada,  valor,  custo));
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return list;
	}
	
	
	public float quantDeEntradaPorItem(int idProduto, int idLoja) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		PedidoEntradaItem  pedidoEntradaItem = null;
		float quant = 0;
				
		try {
			String sql = "SELECT sum(pi.quant) " +
					     "FROM tbpedidoentradaitem pi " +
					     "JOIN tbpedidoentrada p on (pi.idPedidoEntrada = p.idPedidoEntrada) " +
					     "WHERE pi.idProduto = ? and p.idLoja = ? and p.status='A' " ;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idProduto);
			ps.setInt(2, idLoja);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("N�o foi encontrado nenhum "
						+ "registro com o c�digo: " + idProduto);
			}
			quant = rs.getFloat(1);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return quant;
	}
	public List listarProcurarPedidoEntradaItemDeletados() throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<PedidoEntradaItem> list = null;
		
		try {
			String sql = "SELECT pi.idPedidoEntradaItem, pi.idPedidoEntrada, pi.idProduto, pi.idUnidade, pi.quantPedida, pi.quant, pi.valor, pi.loteFab, pi.dtVal, pi.dtMod, pi.usuario "+
						 "from tbpedidoentradaitem pi "+
						 "join tbproduto p on pi.idProduto = p.idProduto "+
		                 "where p.status = 'I' "+
		                 "Group by pi.idPedidoEntradaItem ";			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<PedidoEntradaItem>();
			while (rs.next()) {
				int idPedidoEntradaItem = rs.getInt(1);
				int idPedidoEntrada = rs.getInt(2);
				int idProduto = rs.getInt(3);
				int idUnidade = rs.getInt(4);
				float quantPedida = rs.getFloat(5);
				float quant = rs.getFloat(6);
				float valor = rs.getFloat(7);
				String loteFab = rs.getString(8);
				Date dtVal = rs.getDate(9);
				Date dtMod = rs.getDate(10);
				String usuario = rs.getString(11);
				
				list.add(new PedidoEntradaItem(idPedidoEntradaItem, idPedidoEntrada,
						idProduto, idUnidade, quantPedida, quant,
						valor, loteFab, dtVal, dtMod, usuario));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		}
		return list;
	}
	
	
	public void updateItensFiscaisItem(int idPedido, PedidoEntradaItem pedidoEntradaItem) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;		
		try {
			String sql = "UPDATE tbpedidoentradaitem set nfNCST = ?, nfICFOP = ?, nfNvBC = ?, nfNvBCST = ?, nfNvICMSST = ?, nfNpICMS = ?, nfNvICMS = ?, nfOpIPI = ?, nfOvIPI = ? WHERE idPedidoEntradaItem = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			if(pedidoEntradaItem.getNfNCST().length() <= 0){
				ps.setString(1, "0");
			}else{
				ps.setString(1, pedidoEntradaItem.getNfNCST());
			}
			if(pedidoEntradaItem.getNfICFOP().length() <= 0){
				ps.setString(2, "0");
			}else{
				ps.setString(2, pedidoEntradaItem.getNfICFOP());
			}
			ps.setFloat(3, pedidoEntradaItem.getNfNvBC());
			ps.setFloat(4, pedidoEntradaItem.getNfNvBCST());
			ps.setFloat(5, pedidoEntradaItem.getNfNvICMSST());
			ps.setFloat(6, pedidoEntradaItem.getNfNpICMS());
			ps.setFloat(7, pedidoEntradaItem.getNfNvICMS());
			ps.setFloat(8, pedidoEntradaItem.getNfOpIPI());
			ps.setFloat(9, pedidoEntradaItem.getNfOvIPI());
			ps.setInt(10, idPedido);
			ps.executeUpdate();

		}catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 	
	}
	public int getIdEntradaItem() throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		PedidoEntradaItem  pedidoEntradaItem = null;
		int idPedidoEntradaItem = 0;
				
		try {
			String sql = "select max(idPedidoEntradaItem) from tbpedidoentradaitem " ;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("N�o foi encontrado nenhum "
						+ "registro.");
			}
			idPedidoEntradaItem = rs.getInt(1);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return idPedidoEntradaItem;
	}
	
	public PedidoEntradaItem listarPedidoEntradaItemFiscal(int idPedidoEntradaItem) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		PedidoEntradaItem  pedidoEntradaItem = new PedidoEntradaItem();
				
		try {
			String sql = "SELECT nfNCST, nfICFOP, nfNvBC, nfNvBCST, nfNvICMSST, nfNpICMS, nfOpIPI, nfOvIPI "+
			             "from tbpedidoentradaitem "+
                         "WHERE idPedidoEntradaItem = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idPedidoEntradaItem);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("N�o foi encontrado nenhum "
						+ "registro com o c�digo: " + idPedidoEntradaItem);
			}
			
			String nfNCST     = rs.getString(1);
			String nfICFOP    = rs.getString(2);
			float nfNvBC      = rs.getFloat(3);   
			float nfNvBCST    = rs.getFloat(4);
			float nfNvICMSST  = rs.getFloat(5);
			float nfNpICMS    = rs.getFloat(6);
			float nfOpIPI     = rs.getFloat(7);
			float nfOvIPI     = rs.getFloat(8);

			pedidoEntradaItem.setNfICFOP(nfICFOP);
	  		pedidoEntradaItem.setNfNCST(nfNCST);
	  		pedidoEntradaItem.setNfNvBC(nfNvBC);
	  		pedidoEntradaItem.setNfNvBCST(nfNvBCST);
	  		pedidoEntradaItem.setNfNvICMSST(nfNvICMSST);
	  		pedidoEntradaItem.setNfNpICMS(nfNpICMS);
	  		pedidoEntradaItem.setNfOvIPI(nfOvIPI);
	  		pedidoEntradaItem.setNfOpIPI(nfOpIPI);
	  		pedidoEntradaItem.setIdPedidoEntradaItem(idPedidoEntradaItem);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return pedidoEntradaItem;
	}
}