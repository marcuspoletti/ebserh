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

public class ContaDAO implements IContaDAO {
	private Connection conn;

	public ContaDAO(Connection conn) {
		this.conn = conn;
	}

	public void incluir(Conta conta) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (conta == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbconta(idLoja, nmConta, idTipoConta, idBanco, agencia, contaCorrente,"
						+ " vlLimiteCredito, dtVencLimite, dtSaldoAbertura, vlSaldoAbertura, paginaInicial, status,"
						+ " pessoaContato, nroTelefone, email, site, observacao, dtSaldoAtual, vlSaldoAtual,"
						+ " dtCad, dtMod, usuario)"
						+ " values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now(), ?, now(), now(), ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, conta.getIdLoja());
			ps.setString(2, conta.getNmConta());
			ps.setInt(3, conta.getIdTipoConta());
			if (conta.getIdBanco() > 0) {
				ps.setInt(4, conta.getIdBanco());
			} else {
				ps.setNull(4, 0);
			}
			ps.setString(5, conta.getAgencia());
			ps.setString(6, conta.getContaCorrente());
			ps.setFloat(7, conta.getVlLimiteCredito());
			ps.setDate(8, ConverteDate.DateToDateSql(conta.getDtVencLimite()));
			ps.setDate(9, ConverteDate.DateToDateSql(conta.getDtSaldoAbertura()));
			ps.setFloat(10, conta.getVlSaldoAbertura());
			ps.setString(11, conta.getPaginaInicial());
			ps.setString(12, conta.getStatus());
			ps.setString(13, conta.getPessoaContato());
			ps.setString(14, conta.getNroTelefone());
			ps.setString(15, conta.getEmail());
			ps.setString(16, conta.getSite());
			ps.setString(17, conta.getObservacao());
			ps.setFloat(18, conta.getVlSaldoAbertura());
			ps.setString(19, conta.getUsuario());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(Conta conta) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (conta == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbconta set idLoja = ?, nmConta = ?, idTipoConta = ?, idBanco = ?, agencia = ?,"
						+ " contaCorrente = ?, vlLimiteCredito = ?, dtVencLimite = ?, dtSaldoAbertura = ?,"
						+ " vlSaldoAbertura = ?, paginaInicial = ?, status = ?, pessoaContato = ?, nroTelefone = ?,"
						+ " email = ?, site = ?, observacao = ?,"
						+ " dtMod = now(), usuario = ? where idConta = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, conta.getIdLoja());
			ps.setString(2, conta.getNmConta());
			ps.setInt(3, conta.getIdTipoConta());
			if (conta.getIdBanco() > 0) {
				ps.setInt(4, conta.getIdBanco());
			} else {
				ps.setNull(4, 0);
			}
			ps.setString(5, conta.getAgencia());
			ps.setString(6, conta.getContaCorrente());
			ps.setFloat(7, conta.getVlLimiteCredito());
			ps.setDate(8, ConverteDate.DateToDateSql(conta.getDtVencLimite()));
			ps.setDate(9, ConverteDate.DateToDateSql(conta.getDtSaldoAbertura()));
			ps.setFloat(10, conta.getVlSaldoAbertura());
			ps.setString(11, conta.getPaginaInicial());
			ps.setString(12, conta.getStatus());
			ps.setString(13, conta.getPessoaContato());
			ps.setString(14, conta.getNroTelefone());
			ps.setString(15, conta.getEmail());
			ps.setString(16, conta.getSite());
			ps.setString(17, conta.getObservacao());
			ps.setString(18, conta.getUsuario());
			ps.setInt(19, conta.getIdConta());
			ps.executeUpdate();
			
			//atualiza saldo atual da conta
			atualizarSaldoAtual(conta.getIdConta(), saldoEm(conta.getIdConta(), new Date()));

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao atualizar dados: " + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void excluir(Conta conta) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (conta == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbconta WHERE idConta=?");
			ps.setInt(1, conta.getIdConta());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			// ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public Conta procurarConta(int idConta) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		Conta conta = null;
		
		try {
			String sql = "SELECT idConta, idLoja, nmConta, idTipoConta, idBanco, agencia, contaCorrente, vlLimiteCredito, "
					+ "dtVencLimite, dtSaldoAbertura, vlSaldoAbertura, paginaInicial, status, pessoaContato, nroTelefone, email, "
					+ "site, observacao, dtSaldoAtual, vlSaldoAtual, dtSaldoConciliado, vlSaldoConciliado, dtCad, dtMod, usuario "
					+ "from tbconta " + "Where idConta = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idConta);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + idConta);
			}

			int idLoja = rs.getInt(2);
			String nmConta = rs.getString(3);
			int idTipoConta = rs.getInt(4);
			int idBanco = rs.getInt(5);
			String agencia = rs.getString(6);
			String contaCorrente = rs.getString(7);
			float vlLimiteCredito = rs.getFloat(8);
			Date dtVencLimite = rs.getDate(9);
			Date dtSaldoAbertura = rs.getDate(10);
			float vlSaldoAbertura = rs.getFloat(11);
			String paginaInicial = rs.getString(12);
			String status = rs.getString(13);
			String pessoaContato = rs.getString(14);
			String nroTelefone = rs.getString(15);
			String email = rs.getString(16);
			String site = rs.getString(17);
			String observacao = rs.getString(18);
			Date dtSaldoAtual = rs.getDate(19);
			float vlSaldoAtual = rs.getFloat(20);
			Date dtSaldoConciliado = rs.getDate(21);
			float vlSaldoConciliado = rs.getFloat(22);
			Date dtCad = rs.getDate(23);
			Date dtMod = rs.getDate(24);
			String usuario = rs.getString(25);
			conta = new Conta(idConta, idLoja, nmConta, idTipoConta, idBanco,
					agencia, contaCorrente, vlLimiteCredito, dtVencLimite,
					dtSaldoAbertura, vlSaldoAbertura, paginaInicial, status,
					pessoaContato, nroTelefone, email, site, observacao,
					dtSaldoAtual, vlSaldoAtual, dtSaldoConciliado, vlSaldoConciliado,
					dtCad, dtMod, usuario);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return conta;
	}

	public List listarConta(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<Conta> list = null;

		try {
			String sql = "SELECT c.idConta, c.idLoja, c.nmConta, c.idTipoConta, c.idBanco, c.agencia, c.contaCorrente, c.vlLimiteCredito, "
					+ " c.dtVencLimite, c.dtSaldoAbertura, c.vlSaldoAbertura, c.paginaInicial, c.status, c.pessoaContato, c.nroTelefone, c.email, "
					+ " c.site, c.observacao, c.dtSaldoAtual, c.vlSaldoAtual, c.dtSaldoConciliado, c.vlSaldoConciliado, c.dtCad, c.dtMod, c.usuario "
					+ " from tbconta c ";
			if (clausula != null)
				sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<Conta>();
			while (rs.next()) {
				int idConta = rs.getInt(1);
				int idLoja = rs.getInt(2);
				String nmConta = rs.getString(3);
				int idTipoConta = rs.getInt(4);
				int idBanco = rs.getInt(5);
				String agencia = rs.getString(6);
				String contaCorrente = rs.getString(7);
				float vlLimiteCredito = rs.getFloat(8);
				Date dtVencLimite = rs.getDate(9);
				Date dtSaldoAbertura = rs.getDate(10);
				float vlSaldoAbertura = rs.getFloat(11);
				String paginaInicial = rs.getString(12);
				String status = rs.getString(13);
				String pessoaContato = rs.getString(14);
				String nroTelefone = rs.getString(15);
				String email = rs.getString(16);
				String site = rs.getString(17);
				String observacao = rs.getString(18);
				Date dtSaldoAtual = rs.getDate(19);
				float vlSaldoAtual = rs.getFloat(20);
				Date dtSaldoConciliado = rs.getDate(21);
				float vlSaldoConciliado = rs.getFloat(22);
				Date dtCad = rs.getDate(23);
				Date dtMod = rs.getDate(24);
				String usuario = rs.getString(25);
				list.add(new Conta(idConta, idLoja, nmConta, idTipoConta,
						idBanco, agencia, contaCorrente, vlLimiteCredito,
						dtVencLimite, dtSaldoAbertura, vlSaldoAbertura,
						paginaInicial, status, pessoaContato, nroTelefone,
						email, site, observacao, 
						dtSaldoAtual, vlSaldoAtual, dtSaldoConciliado, vlSaldoConciliado,
						dtCad, dtMod, usuario));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}

	public boolean exclusaoIdConta(int idConta) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = true;
		try {
			String sql = " Select c.idConta from tbconta c "
					+ " join tbtransferencia t on t.idContaDe = c.idConta "
					+ " join tbtransferencia tr on tr.idContaPara = c.idConta "
					+ " join tbContaMovto cm on cm.idConta = c.idConta "
					+ " join tbduplicata d on c.idconta = d.idConta "
					+ " where c.idConta = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idConta);
			rs = ps.executeQuery();
			if (rs.next()) {
				ok = true;
			} else {
				ok = false;
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return ok;

	}

	public float saldoEm(int idConta, Date dtSaldoEm) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		if (idConta == 0)
			throw new AferoDAOException("O código passado não pode ser 0");
		
		Date dtSaldoAbertura = new Date(0);
		float vlSaldoAbertura = 0.00f;
		ContaDAO contaDAO = new ContaDAO(this.conn);
		Conta conta = contaDAO.procurarConta(idConta);
		if (conta != null) {
			if (conta.getDtSaldoAbertura() != null)
				dtSaldoAbertura = conta.getDtSaldoAbertura();
			vlSaldoAbertura = conta.getVlSaldoAbertura();
		}
			
		float vlSaldoEm = vlSaldoAbertura;

		try {
			String sql = "SELECT sum(if(dc='C', valor, (-1)*valor)) saldo FROM tbcontamovto t " +
						 "	WHERE idConta = ? AND status = 'A' AND dtLanc >= ? AND dtLanc <= ? " +
						 "	ORDER BY dtLanc,idContaMovto ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idConta);
			ps.setDate(2, ConverteDate.DateToDateSql(dtSaldoAbertura));
			ps.setDate(3, ConverteDate.DateToDateSql(dtSaldoEm));
			rs = ps.executeQuery();
			if (rs.next()) {
				vlSaldoEm += rs.getDouble(1);
			}
            
			
		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao consultar dados: " + e);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return vlSaldoEm;
	}
	
	public void atualizarSaldoAtual(int idConta, double valor) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (idConta == 0)
			throw new AferoDAOException("O código passado não pode ser 0");

		try {
			String sql = "UPDATE tbconta " +
							"set dtSaldoAtual = now(), vlSaldoAtual = ? " +
							"WHERE idConta = ?;";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setDouble(1, valor);
			ps.setInt(2, idConta);
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao atualizar dados: " + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void adicionarSaldoAtual(int idConta, double valor) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (idConta == 0)
			throw new AferoDAOException("O código passado não pode ser 0");

		try {
			String sql = "UPDATE tbconta " +
							"set dtSaldoAtual = now(), vlSaldoAtual = (vlSaldoAtual + ?) " +
							"WHERE idConta = ?;";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setDouble(1, valor);
			ps.setInt(2, idConta);
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
