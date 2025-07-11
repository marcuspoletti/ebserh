package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import afero.model.Conta;
import afero.model.ContaMovto;
import afero.util.ConverteDate;


public class ContaMovtoDAO implements IContaMovtoDAO{
	
	private Connection conn;

	public ContaMovtoDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;
	}

	public void incluir(ContaMovto contaMovto) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (contaMovto == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			contaMovto.setVlSaldoAnterior(getVlSaldoAtual(contaMovto.getIdConta())); 
			contaMovto.setVlSaldoAtual(contaMovto.getVlSaldoAnterior() + contaMovto.getValor()); 
			
			String sql = "INSERT INTO tbcontamovto (idConta, dc, valor, formaMovto, dtLanc, dtComp, idTransferencia, nrDoc, idPlanoConta, " +
						"idCentroCusto, historico, divideValor, idColaborador, vlSaldoAnterior, vlSaldoAtual, conciliado, status, dtCad, dtMod, usuario)" +
					     " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now(), now(), ?)";			
			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, contaMovto.getIdConta());
			ps.setString(2, contaMovto.getDc());
			ps.setDouble(3, contaMovto.getValor());
			ps.setString(4, contaMovto.getFormaMovto());
			if(contaMovto.getDtLanc() != null){
				ps.setDate(5, ConverteDate.DateToDateSql(contaMovto.getDtLanc()));
			}else{
				ps.setDate(5, null);
			}
			if(contaMovto.getDtComp() != null){
				ps.setDate(6, ConverteDate.DateToDateSql(contaMovto.getDtComp()));
			}else{
				ps.setDate(6,null);
			}
			if (contaMovto.getIdTransferencia() != 0) {
				ps.setInt(7, contaMovto.getIdTransferencia());
			} else {
				ps.setNull(7, 0);				
			}
			ps.setString(8, contaMovto.getNrDoc());
			if (contaMovto.getIdPlanoConta() != 0) {
				ps.setInt(9, contaMovto.getIdPlanoConta());
			} else {
				ps.setNull(9, 0);				
			}
			if (contaMovto.getIdCentroCusto() != 0) {
				ps.setInt(10, contaMovto.getIdCentroCusto());
			} else {
				ps.setNull(10, 0);				
			}
			ps.setString(11, contaMovto.getHistorico());
			ps.setString(12, contaMovto.getDivideValor());
			if (contaMovto.getIdColaborador() != 0) {
				ps.setInt(13, contaMovto.getIdColaborador());
			} else {
				ps.setNull(13, 0);				
			}
			ps.setDouble(14, contaMovto.getVlSaldoAnterior());
			ps.setDouble(15, contaMovto.getVlSaldoAtual());
			ps.setString(16, contaMovto.getConciliado());
			ps.setString(17, contaMovto.getStatus());
			ps.setString(18, contaMovto.getUsuario());
						
			ps.executeUpdate();
			
			//atualiza saldo atual da conta
			ContaDAO contaDAO = new ContaDAO(conn);
			if (contaMovto.getDc().equals("C")) {
				contaDAO.adicionarSaldoAtual(contaMovto.getIdConta(), contaMovto.getValor());
			} else {
				contaDAO.adicionarSaldoAtual(contaMovto.getIdConta(), (-1)*contaMovto.getValor());
			}
			atualizarVlSaldoAtual(contaMovto.getIdConta());

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		}finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(ContaMovto contaMovto) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (contaMovto == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");
		
		ContaMovto contaMovtoBefore = procurarContaMovto(contaMovto.getIdConta());
		if (contaMovtoBefore == null)
			throw new AferoDAOException("Não foi encontrado nenhum "
					+ "registro com o código: " + contaMovto.getIdConta());

		try {
			String sql = "UPDATE tbcontamovto SET idConta = ?, dc = ?, valor = ?, formaMovto = ?, dtLanc = ?, dtComp = ?, idTransferencia = ?, nrDoc = ?," +
						" idPlanoConta = ?, idCentroCusto = ?, historico = ?, divideValor = ?, idColaborador = ?, vlSaldoAnterior = ?, vlSaldoAtual = ?," +
						" conciliado = ?, status = ?, dtCad = ?, dtMod = now(), usuario = ?" +
					     "WHERE idContaMovto = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, contaMovto.getIdConta());
			ps.setString(2, contaMovto.getDc());
			ps.setDouble(3, contaMovto.getValor());
			ps.setString(4, contaMovto.getFormaMovto());
			ps.setDate(5, ConverteDate.DateToDateSql(contaMovto.getDtLanc()));
			ps.setDate(6, ConverteDate.DateToDateSql(contaMovto.getDtComp()));
			if (contaMovto.getIdTransferencia() != 0) {
				ps.setInt(7, contaMovto.getIdTransferencia());
			} else {
				ps.setNull(7, 0);				
			}
			ps.setString(8, contaMovto.getNrDoc());
			if (contaMovto.getIdPlanoConta() != 0) {
				ps.setInt(9, contaMovto.getIdPlanoConta());
			} else {
				ps.setNull(9, 0);				
			}
			if (contaMovto.getIdCentroCusto() != 0) {
				ps.setInt(10, contaMovto.getIdCentroCusto());
			} else {
				ps.setNull(10, 0);				
			}
			ps.setString(11, contaMovto.getHistorico());
			ps.setString(12, contaMovto.getDivideValor());
			if (contaMovto.getIdColaborador() != 0) {
				ps.setInt(13, contaMovto.getIdColaborador());
			} else {
				ps.setNull(13, 0);				
			}
			ps.setDouble(14, contaMovto.getVlSaldoAnterior());
			ps.setDouble(15, contaMovto.getVlSaldoAtual());
			ps.setString(16, contaMovto.getConciliado());
			ps.setString(17, contaMovto.getStatus());
			ps.setDate(18, ConverteDate.DateToDateSql(contaMovto.getDtCad()));
			ps.setString(19, contaMovto.getUsuario());
			ps.setInt(20, contaMovto.getIdContaMovto());
			ps.executeUpdate();

			//atualiza saldo atual da conta
			ContaDAO contaDAO = new ContaDAO(conn);
			if (contaMovto.getDc().equals("C")) {
				contaDAO.adicionarSaldoAtual(contaMovto.getIdConta(), (-1)*contaMovtoBefore.getValor()+contaMovto.getValor());
			} else {
				contaDAO.adicionarSaldoAtual(contaMovto.getIdConta(), contaMovtoBefore.getValor()+(-1)*contaMovto.getValor());
			}
			atualizarVlSaldoAtual(contaMovto.getIdConta());

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		}catch (Exception e) {
		throw new AferoDAOException("Erro ao inserir dados: " + e);
		}finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void excluir(ContaMovto contaMovto) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (contaMovto == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbcontamovto WHERE idContaMovto=?");
			ps.setInt(1, contaMovto.getIdContaMovto());
			ps.executeUpdate();

			//atualiza saldo atual da conta
			ContaDAO contaDAO = new ContaDAO(conn);
			if (contaMovto.getDc().equals("D")) {
				contaDAO.adicionarSaldoAtual(contaMovto.getIdConta(), contaMovto.getValor());
			} else {
				contaDAO.adicionarSaldoAtual(contaMovto.getIdConta(), (-1)*contaMovto.getValor());
			}
			atualizarVlSaldoAtual(contaMovto.getIdConta());

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public ContaMovto procurarContaMovto(int idContaMovto) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		ContaMovto contaMovto = null;

		try {
			String sql = " SELECT idConta, dc, valor, formaMovto, dtLanc, dtComp, idTransferencia, nrDoc, idPlanoConta, " +
						"idCentroCusto, historico, divideValor, idColaborador, vlSaldoAnterior, vlSaldoAtual, conciliado, status, dtCad, dtMod, usuario " +
						"FROM tbcontamovto" +						
			            " WHERE idContaMovto = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idContaMovto);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + idContaMovto);
			}
            
			int idConta = rs.getInt(1);
			String dc = rs.getString(2);
			double valor = rs.getDouble(3);
			String formaMovto = rs.getString(4);
			Date dtLanc = rs.getDate(5);
			Date dtComp = rs.getDate(6);
			int idTransferencia = rs.getInt(7);
			String nrDoc = rs.getString(8);			
			int idPlanoConta = rs.getInt(9);
			int idCentroCusto = rs.getInt(10);
			String historico = rs.getString(11);
			String divideValor = rs.getString(12);
			int idColaborador = rs.getInt(13);
			double vlSaldoAnterior = rs.getDouble(14);
			double vlSaldoAtual = rs.getDouble(15);
			String conciliado = rs.getString(16);
			String status = rs.getString(17);
			Date dtCad = rs.getDate(18);
			Date dtMod = rs.getDate(19);
			String usuario = rs.getString(20);
			
			contaMovto = new ContaMovto(idContaMovto, idConta, dc, valor, formaMovto, dtLanc, dtComp, idTransferencia, nrDoc, idPlanoConta,
					idCentroCusto, historico, divideValor, idColaborador, vlSaldoAnterior, vlSaldoAtual, conciliado, status, dtCad, dtMod, usuario);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return contaMovto;
	}

	public List listarContaMovto(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<ContaMovto> list = null;
		
		try {
			String sql = "SELECT cm.idContaMovto, cm.idConta, cm.dc, cm.valor, cm.formaMovto, cm.dtLanc, cm.dtComp, cm.idTransferencia, cm.nrDoc, cm.idPlanoConta, " +
						 "cm.idCentroCusto, cm.historico, cm.divideValor, cm.idColaborador, cm.vlSaldoAnterior, cm.vlSaldoAtual, cm.conciliado, cm.status, " +
						 "cm.dtCad, cm.dtMod, cm.usuario, c.idLoja " +
						 "FROM tbcontamovto cm " +
						 "JOIN tbConta c ON (cm.idConta = c.idConta) ";			              
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<ContaMovto>();
			while (rs.next()) {
				
				int idContaMovto = rs.getInt(1);
				int idConta = rs.getInt(2);
				String dc = rs.getString(3);
				double valor = rs.getDouble(4);
				String formaMovto = rs.getString(5);
				Date dtLanc = rs.getDate(6);
				Date dtComp = rs.getDate(7);
				int idTransferencia = rs.getInt(8);
				String nrDoc = rs.getString(9);			
				int idPlanoConta = rs.getInt(10);
				int idCentroCusto = rs.getInt(11);
				String historico = rs.getString(12);
				String divideValor = rs.getString(13);
				int idColaborador = rs.getInt(14);
				double vlSaldoAnterior = rs.getDouble(15);
				double vlSaldoAtual = rs.getDouble(16);
				String conciliado = rs.getString(17);
				String status = rs.getString(18);
				Date dtCad = rs.getDate(19);
				Date dtMod = rs.getDate(20);
				String usuario = rs.getString(21);
				
				list.add( new ContaMovto(idContaMovto, idConta, dc, valor, formaMovto, dtLanc, dtComp, idTransferencia, nrDoc, idPlanoConta,
						idCentroCusto, historico, divideValor, idColaborador, vlSaldoAnterior, vlSaldoAtual, conciliado, status, dtCad, dtMod, usuario));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}

	public boolean exclusaoIdContaMovto(int idContaMovto) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = false;

		try {
			String sql = "select d.idContaMovtoDivisao from tbcontaMovtoDivisao d "+
                         "join tbContaMovto p on (d.idContaMovto = p.idContaMovto) " +
                         "where d.idContaMovto = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idContaMovto);
			rs = ps.executeQuery();
			if (rs.next()) {
				ok=true;
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
	
	public double getVlSaldoAtual(int idConta) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		double valor = 0.0;

		try {
			String sql = "SELECT vlSaldoAtual FROM tbcontamovto t "+
                         "WHERE t.idConta = ? and t.idContaMovto = (SELECT max(idContaMovto) FROM tbcontamovto m WHERE m.idConta = ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idConta);
			ps.setInt(2, idConta);
			rs = ps.executeQuery();
			if (rs.next()) {
				valor = rs.getDouble(1);
			}else{
				valor = 0.0;
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return valor;
	}
	
	public void atualizarVlSaldoAtual(int idConta) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		double vlSaldoAnterior = 0.0;
		double vlSaldoAtual = 0.0;

		try {
			String sql = "SELECT cm.idContaMovto, cm.idConta, cm.dc, cm.valor FROM tbcontamovto cm " +
                         "WHERE cm.idConta = ? " +
                         "ORDER BY cm.dtLanc, cm.idContaMovto ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idConta);
			rs = ps.executeQuery();
			while (rs.next()) {
				int idContaMovto = rs.getInt(1);
				String dc = rs.getString(3);
				double valor = rs.getDouble(4);
				if (dc.equals("C")) {
					vlSaldoAtual = vlSaldoAnterior + valor; 
				} else {
					vlSaldoAtual = vlSaldoAnterior - valor; 
				}					
				atualizarVlSaldoAtual(idContaMovto, vlSaldoAnterior, vlSaldoAtual);
				vlSaldoAnterior = vlSaldoAtual;
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
	}

	public void atualizarVlSaldoAtual(int idContaMovto, double vlSaldoAnterior, double vlSaldoAtual) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (idContaMovto == 0)
			throw new AferoDAOException("O código passado não pode ser 0");

		try {
			String sql = "UPDATE tbcontamovto " +
							"SET vlSaldoAnterior = ?, vlSaldoAtual = ? " +
							"WHERE idContaMovto = ?;";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setDouble(1, vlSaldoAnterior);
			ps.setDouble(2, vlSaldoAtual);
			ps.setDouble(3, idContaMovto);
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao atualizar dados: " + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);

		}
	}
	
}
