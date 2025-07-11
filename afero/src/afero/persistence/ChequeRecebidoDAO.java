package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import afero.model.ChegueRecebido;
import afero.util.ConverteDate;

public class ChequeRecebidoDAO {
	private Connection conn;

	public ChequeRecebidoDAO(Connection conn) {
		this.conn = conn;
	}

	public void incluir(ChegueRecebido chequeRecebido) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		String sql = "";
		if (chequeRecebido == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			sql = "INSERT INTO tbchequerecebido( idLoja, cdEntidade, idBanco, agencia, dvAgencia, contaCorrente, dvConta, nrCheque, "
					+ "valor, dtEmissao, dtVenc, Correntista, CpfCnpj, destino, observacao, dtReceb, idContaMovto, status, dtCad, dtMod, usuario)"
					+ " VALUES( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now(), now(), ?);";

			conn = this.conn;
			ps = conn.prepareStatement(sql);

			ps.setInt(1, chequeRecebido.getIdLoja());
			ps.setInt(2, chequeRecebido.getCdEntidade());
			ps.setInt(3, chequeRecebido.getIdBanco());
			ps.setString(4, chequeRecebido.getAgencia());
			ps.setString(5, chequeRecebido.getDvAgencia());
			ps.setString(6, chequeRecebido.getContaCorrente());
			ps.setString(7, chequeRecebido.getDvConta());
			ps.setInt(8, chequeRecebido.getNrChegue());
			ps.setDouble(9, chequeRecebido.getValor());
			if (chequeRecebido.getDtEmissao() != null) {
				ps.setDate(10, ConverteDate.DateToDateSql(chequeRecebido.getDtEmissao()));
			} else {
				ps.setDate(10, null);
			}
			if (chequeRecebido.getDtVenc() != null) {
				ps.setDate(11,
						ConverteDate.DateToDateSql(chequeRecebido.getDtVenc()));
			} else {
				ps.setDate(11, null);
			}
			ps.setString(12, chequeRecebido.getCorrentista());
			ps.setString(13, chequeRecebido.getCpfCnpj());
			ps.setString(14, chequeRecebido.getDestino());
			ps.setString(15, chequeRecebido.getObservacao());
			if (chequeRecebido.getDtReceb() != null) {
				ps.setDate(16, ConverteDate.DateToDateSql(chequeRecebido.getDtReceb()));
			} else {
				ps.setDate(16, null);
			}
			if (chequeRecebido.getIdContaMovto() != 0) {
				ps.setInt(17, chequeRecebido.getIdContaMovto());
			} else {
				ps.setNull(17, 0);
			}
			ps.setString(18, chequeRecebido.getStatus());
			ps.setString(19, chequeRecebido.getUsuario());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public void atualizar(ChegueRecebido chequeRecebido)
			throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (chequeRecebido == null) {
			throw new AferoDAOException("O valor passado não pode ser nulo");
		}
		try {
			String sql = "UPDATE tbchequerecebido set idLoja = ?, cdEntidade = ?, idBanco = ?, agencia = ?, dvAgencia = ?, contaCorrente = ?, "
					+ "dvConta = ?, nrCheque = ?, valor = ?, dtEmissao = ?, dtVenc = ?, Correntista = ?, CpfCnpj = ?, destino = ?, "
					+ "observacao = ?, dtReceb = ?, idContaMovto = ?, status = ?, dtMod = now(), usuario = ? "
					+ "WHERE idChequeRecebido = ?";

			conn = this.conn;
			ps = conn.prepareStatement(sql);

			ps.setInt(1, chequeRecebido.getIdLoja());
			ps.setInt(2, chequeRecebido.getCdEntidade());
			ps.setInt(3, chequeRecebido.getIdBanco());
			ps.setString(4, chequeRecebido.getAgencia());
			ps.setString(5, chequeRecebido.getDvAgencia());
			ps.setString(6, chequeRecebido.getContaCorrente());
			ps.setString(7, chequeRecebido.getDvConta());
			ps.setInt(8, chequeRecebido.getNrChegue());
			ps.setDouble(9, chequeRecebido.getValor());
			if (chequeRecebido.getDtEmissao() != null) {
				ps.setDate(10, ConverteDate.DateToDateSql(chequeRecebido.getDtEmissao()));
			} else {
				ps.setDate(10, null);
			}
			if (chequeRecebido.getDtVenc() != null) {
				ps.setDate(11,
						ConverteDate.DateToDateSql(chequeRecebido.getDtVenc()));
			} else {
				ps.setDate(11, null);
			}
			ps.setString(12, chequeRecebido.getCorrentista());
			ps.setString(13, chequeRecebido.getCpfCnpj());
			ps.setString(14, chequeRecebido.getDestino());
			ps.setString(15, chequeRecebido.getObservacao());
			if (chequeRecebido.getDtReceb() != null) {
				ps.setDate(16, ConverteDate.DateToDateSql(chequeRecebido.getDtReceb()));
			} else {
				ps.setDate(16, null);
			}
			if (chequeRecebido.getIdContaMovto() != 0) {
				ps.setInt(17, chequeRecebido.getIdContaMovto());
			} else {
				ps.setNull(17, 0);
			}
			ps.setString(18, chequeRecebido.getStatus());
			ps.setString(19, chequeRecebido.getUsuario());
			ps.setInt(20, chequeRecebido.getIdChegueRecebido());
			ps.executeUpdate();
		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao atualizar dados: " + e);
		} finally {
			// ConnectionFactory.closeConnection(conn);
		}
	}

	public void excluir(ChegueRecebido chequeRecebido) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (chequeRecebido == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn
					.prepareStatement("DELETE FROM tbchequerecebido WHERE idChequeRecebido = ? ");

			ps.setInt(1, chequeRecebido.getIdChegueRecebido());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			// ConnectionFactory.closeConnection(conn, ps);
		}
	}

	public ChegueRecebido procurarChegueRecebido(int idChequeRecebido)
			throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		ChegueRecebido chequeRecebido = null;

		try {
			String sql = "SELECT idChequeRecebido, idLoja, cdEntidade, idBanco, agencia, dvAgencia, contaCorrente, dvConta, nrCheque, valor, dtEmissao, dtVenc, "
					+ "Correntista, CpfCnpj, destino, observacao, dtReceb, idContaMovto, status, dtCad, dtMod, usuario "
					+ "FROM tbchequerecebido WHERE idChequeRecebido = ? ";

			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idChequeRecebido);
			rs = ps.executeQuery();

			while (rs.next()) {

				int idChegueRecebido = rs.getInt(1);
				int idLoja = rs.getInt(2);
				int cdEntidade = rs.getInt(3);
				int idBanco = rs.getInt(4);
				String agencia = rs.getString(5);
				String dvAgencia = rs.getString(6);
				String contaCorrente = rs.getString(7);
				String dvConta = rs.getString(8);
				int nrChegue = rs.getInt(9);
				double valor = rs.getDouble(10);
				Date dtEmissao = rs.getDate(11);
				Date dtVenc = rs.getDate(12);
				String correntista = rs.getString(13);
				String cpfCnpj = rs.getString(14);
				String destino = rs.getString(15);
				String observacao = rs.getString(16);
				Date dtRecebido = rs.getDate(17);
				int idContaMovto = rs.getInt(18);
				String status = rs.getString(19);
				Date dtCad = rs.getDate(20);
				Date dtMod = rs.getDate(21);
				String usuario = rs.getString(22);

				chequeRecebido = new ChegueRecebido(idChegueRecebido, idLoja, 
						cdEntidade, idBanco, agencia, dvAgencia, contaCorrente,
						dvConta, nrChegue, valor, dtEmissao, dtVenc,
						correntista, cpfCnpj, destino, observacao, dtRecebido,
						idContaMovto, status, dtCad, dtMod, usuario);
			}
		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return chequeRecebido;
	}

	public List listarChegueRecebido(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<ChegueRecebido> list = null;

		try {
			String sql = "SELECT ch.idChequeRecebido, ch.idLoja, ch.cdEntidade, ch.idBanco, ch.agencia, ch.dvAgencia, ch.contaCorrente, ch.dvConta,"
					+ "ch.nrCheque, ch.valor, ch.dtEmissao, ch.dtVenc, ch.correntista, ch.cpfCnpj, ch.destino, ch.observacao, ch.dtReceb,"
					+ "ch.idContaMovto, ch.status, ch.dtCad, ch.dtMod, ch.usuario "
					+ "FROM tbchequerecebido ch "
					+ "Join tbentidade e on ch.cdEntidade = e.cdEntidade ";
			if (clausula != null)
				sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<ChegueRecebido>();
			while (rs.next()) {

				int idChegueRecebido = rs.getInt(1);
				int idLoja = rs.getInt(2);
				int cdEntidade = rs.getInt(3);
				int idBanco = rs.getInt(4);
				String agencia = rs.getString(5);
				String dvAgencia = rs.getString(6);
				String contaCorrente = rs.getString(7);
				String dvConta = rs.getString(8);
				int nrChegue = rs.getInt(9);
				double valor = rs.getDouble(10);
				Date dtEmissao = rs.getDate(11);
				Date dtVenc = rs.getDate(12);
				String correntista = rs.getString(13);
				String cpfCnpj = rs.getString(14);
				String destino = rs.getString(15);
				String observacao = rs.getString(16);
				Date dtRecebido = rs.getDate(17);
				int idContaMovto = rs.getInt(18);
				String status = rs.getString(19);
				Date dtCad = rs.getDate(20);
				Date dtMod = rs.getDate(21);
				String usuario = rs.getString(22);

				list.add(new ChegueRecebido(idChegueRecebido, idLoja, cdEntidade,
						idBanco, agencia, dvAgencia, contaCorrente, dvConta,
						nrChegue, valor, dtEmissao, dtVenc, correntista,
						cpfCnpj, destino, observacao, dtRecebido, idContaMovto,
						status, dtCad, dtMod, usuario));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}

}
