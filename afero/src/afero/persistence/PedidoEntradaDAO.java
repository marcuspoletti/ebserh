package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import afero.model.PedidoEntrada;
import afero.util.ConverteDate;
import afero.model.EntradaProduto;

public class PedidoEntradaDAO implements IPedidoEntradaDAO{
	
	private Connection conn;
	
    public PedidoEntradaDAO(Connection conn) {
		this.conn = conn;		
    }
	
	public void incluir(PedidoEntrada pedidoEntrada) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (pedidoEntrada == null)
			throw new AferoDAOException(
					"O valor passado n�o pode ser nulo");

		try {
			String sql = "INSERT INTO tbpedidoentrada(idLoja, cdEntidade, idColaborador, " +
					     "idOrdemServico, dtPed, operacao, vlPed, observacao, status, nrDoc, dtMov, " +
					     "dtMod, dtEmissao, usuario, idPedidoEntradaOrigem) " +
					     "VALUES (?, ?, ?, ?, now(), ?, ?, ?, ?, ?, now(), now(), ?, ?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, pedidoEntrada.getIdLoja());
			ps.setInt(2, pedidoEntrada.getCdEntidade());
			ps.setInt(3, pedidoEntrada.getIdColaborador());
			if (pedidoEntrada.getIdOrdemServico() != 0) {
				ps.setInt(4, pedidoEntrada.getIdOrdemServico());
			} else {
				ps.setString(4, null);
			}
			ps.setString(5, pedidoEntrada.getOperacao());
			ps.setDouble(6, pedidoEntrada.getVlPed());
			ps.setString(7, pedidoEntrada.getObservacao());
			ps.setString(8, pedidoEntrada.getStatus());
			ps.setString(9, pedidoEntrada.getNrDoc());
			ps.setDate(10, ConverteDate.DateToDateSql(pedidoEntrada.getDtEmissao()));
			ps.setString(11, pedidoEntrada.getUsuario());
			if (pedidoEntrada.getIdPedidoEntradaOrigem() != 0) {
				ps.setInt(12, pedidoEntrada.getIdPedidoEntradaOrigem());
			} else {
				ps.setString(12, null);
			}
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(PedidoEntrada pedidoEntrada) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (pedidoEntrada == null)
			throw new AferoDAOException("O valor passado n�o pode ser nulo");

		try {
			String sql = "UPDATE tbpedidoentrada set idLoja = ?, cdEntidade = ?, idColaborador = ?, " +
					     "idOrdemServico = ?, operacao = ?, vlPed = ?, observacao = ?, status = ?, nrDoc = ?, " +
					     "dtMov = now(), dtMod = now(), dtEmissao = ?, usuario = ?, idPedidoEntradaOrigem = ? "+
					     "WHERE idPedidoEntrada = ? ";		
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, pedidoEntrada.getIdLoja());
			ps.setInt(2, pedidoEntrada.getCdEntidade());
			ps.setInt(3, pedidoEntrada.getIdColaborador());
			if(pedidoEntrada.getIdOrdemServico()!=0){
				ps.setInt(4, pedidoEntrada.getIdOrdemServico());
			}else{
				ps.setString(4, null);
			}
			
			ps.setString(5, pedidoEntrada.getOperacao());
			ps.setDouble(6, pedidoEntrada.getVlPed());
			ps.setString(7, pedidoEntrada.getObservacao());
			ps.setString(8, pedidoEntrada.getStatus());
			ps.setString(9, pedidoEntrada.getNrDoc());
			ps.setDate(10, ConverteDate.DateToDateSql(pedidoEntrada.getDtEmissao()));
			ps.setString(11, pedidoEntrada.getUsuario());
			if(pedidoEntrada.getIdPedidoEntradaOrigem() != 0){
				ps.setInt(12, pedidoEntrada.getIdPedidoEntradaOrigem());
			}else{
				ps.setString(12, null);
			}
			ps.setInt(13, pedidoEntrada.getIdPedidoEntrada());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void excluir(PedidoEntrada pedidoEntrada) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (pedidoEntrada == null)
			throw new AferoDAOException(
					"O valor passado n�o pode ser nulo");

		try {			
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbpedidoentrada WHERE idPedidoEntrada=?");
			ps.setInt(1, pedidoEntrada.getIdPedidoEntrada());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public PedidoEntrada procurarPedidoEntrada(int idPedidoEntrada) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		PedidoEntrada  pedidoEntrada= null;
		
		try {
			String sql = "SELECT idLoja, cdEntidade, idColaborador, idOrdemServico, dtPed, operacao, "+
			                     "vlPed, observacao, status, nrDoc, dtMov, dtMod, usuario, dtEmissao, idPedidoEntradaOrigem "+
			                     "from tbpedidoentrada "+
			                     "WHERE idPedidoEntrada = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idPedidoEntrada);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("N�o foi encontrado nenhum "
						+ "registro com o c�digo: " + idPedidoEntrada);
			}
			int idLoja = rs.getInt(1);
			int cdEntidade = rs.getInt(2);
			int idColaborador = rs.getInt(3);
			int idOrdemServico = rs.getInt(4);
			Date dtPed = rs.getDate(5);
			String operacao = rs.getString(6);
			double vlPed = rs.getDouble(7);
			String observacao = rs.getString(8);
			String status = rs.getString(9);
			String nrDoc = rs.getString(10);
			Date dtMov   = rs.getDate(11);
			Date dtMod   = rs.getDate(12);
			String usuario = rs.getString(13);
			Date dtEmissao = rs.getDate(14);
		    int idPedidoEntradaOrigem = rs.getInt(15);

			pedidoEntrada = new PedidoEntrada(idPedidoEntrada, idLoja, cdEntidade,
					idColaborador, idOrdemServico, dtPed, operacao,
					vlPed, observacao, status, nrDoc, dtMov, dtMod, dtEmissao, usuario, idPedidoEntradaOrigem);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return pedidoEntrada;
	}

	public List listarPedidoEntrada(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<PedidoEntrada> list = null;
		
		try {
			String sql = "SELECT pe.idPedidoEntrada, pe.idLoja, pe.cdEntidade, pe.idColaborador, pe.idOrdemServico, pe.dtPed, pe.operacao, "+ 
			                     "pe.vlPed, pe.observacao, pe.status, pe.nrDoc, pe.dtMov, pe.dtMod, pe.dtEmissao, pe.usuario, pe.idPedidoEntradaOrigem "+ 
			                     "from tbpedidoentrada pe "+
			                     "join tbentidade e on (pe.cdEntidade = e.cdEntidade) ";
			if (clausula != null) sql = sql + clausula;			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<PedidoEntrada>();
			while (rs.next()) {
				int idPedidoEntrada = rs.getInt(1);
				int idLoja = rs.getInt(2);
				int cdEntidade = rs.getInt(3);
				int idColaborador = rs.getInt(4);
				int idOrdemServico = rs.getInt(5);
				Date dtPed = rs.getDate(6);
				String operacao = rs.getString(7);
				double vlPed = rs.getDouble(8);
				String observacao = rs.getString(9);
				String status = rs.getString(10);
				String nrDoc = rs.getString(11);
				Date dtMov   = rs.getDate(12);
				Date dtMod   = rs.getDate(13);
				Date dtEmissao = rs.getDate(14);
				String usuario = rs.getString(15);
			    int idPedidoEntradaOrigem = rs.getInt(16);
				
				list.add(new PedidoEntrada(idPedidoEntrada, idLoja, cdEntidade,
						idColaborador, idOrdemServico, dtPed, operacao,
						vlPed, observacao, status, nrDoc, dtMov, dtMod, dtEmissao, usuario, idPedidoEntradaOrigem));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	
	public int getIdPedidoEntrada() throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		int numOrcamento = 0;
				
		try {
			String sql = "select max(idPedidoEntrada) from tbpedidoentrada order by idPedidoEntrada DESC LIMIT 1";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if (rs.next()) {
				numOrcamento = rs.getInt(1);
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return numOrcamento;
	}
	
	public String dataAtualPedido() throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		String dataAtual = "";
		
		try {
			String sql = "select now();";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if (rs.next()) {
				dataAtual = ConverteDate.dateToString(rs.getDate(1));
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return dataAtual;
	}
	
	public List listarEntradaProduto(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<EntradaProduto> list = null;
		
		try {
			String sql = "SELECT p.idProduto, pe.nrDoc, pe.dtPed, pei.quant, pei.valor, pr.custoDireto, p.dsProduto "+ 
			                     "from tbpedidoentrada pe "+
			                     "Join tbpedidoentradaitem pei on pe.idPedidoEntrada = pei.idPedidoEntrada "+
			                     "Join tbproduto p on pei.idProduto = p.idProduto "+
			                     "Join tbestoque e on p.idProduto = e.idProduto "+
			                     "Join tbpreco pr on e.idEstoque = pr.idEstoque AND pr.precoPadrao = 'S' ";
			if (clausula != null) sql = sql + clausula;			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<EntradaProduto>();
			while (rs.next()) {
				String cdProduto = rs.getString(1);
				String numPedido    = rs.getString(2);
				Date dtPed       = rs.getDate(3);
				float quant      = rs.getFloat(4);
				float prUnit     = rs.getFloat(5);
				float custo      = rs.getFloat(6);
				String dsProduto = rs.getString(7);				
				list.add(new EntradaProduto(cdProduto, dsProduto, numPedido, dtPed,
						quant, prUnit, custo));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return list;
	}
	public void atualizarFornecedor(Integer idPedidoEntrada, Integer cdEntidade, String usuario) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (idPedidoEntrada == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbpedidoentrada SET cdEntidade = ?, dtMod = now(), usuario = ? "+
					     "WHERE idPedidoEntrada = ? ";		
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cdEntidade);
			ps.setString(2, usuario);
			ps.setInt(3, idPedidoEntrada);
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} 
	}
		
}
