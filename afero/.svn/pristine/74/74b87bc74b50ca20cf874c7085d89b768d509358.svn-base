package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import afero.model.DuplicataParcela;
import afero.util.ConverteDate;

public class DuplicataParcelaDAO {
	private Connection conn;

	public DuplicataParcelaDAO(Connection conn) {
		this.conn = conn;
	}

	public void incluir(DuplicataParcela duplicataParcela)
			throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		String sql = "";
		if (duplicataParcela == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			sql = "INSERT INTO tbduplicataparcela(idDuplicata, nrParcela, idConta, dtVenc, valor, cdFormaPagto, dtEmissao, dtComp, nrDoc, "
					+ "idPlanoConta, idCentroCusto, historico, divideValor, dtOperacao, vlOperacao, vlJuros, vlMulta, vlDesc, nossoNumero, "
					+ "dtQuitacao, formaQuitacao, atualizaFinanceiro, status, dtMov, usuario) "
					+ "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now(), ?);";

			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, duplicataParcela.getIdDuplicata());
			ps.setInt(2, duplicataParcela.getNrParcela());
			if (duplicataParcela.getIdConta() != 0) {
				ps.setInt(3, duplicataParcela.getIdConta());
			} else {
				ps.setNull(3, 0);
			}
			ps.setDate(4,ConverteDate.DateToDateSql(duplicataParcela.getDtVenc()));
			ps.setDouble(5, duplicataParcela.getValor());
			if (duplicataParcela.getCdFormaPagto() != 0) {
				ps.setInt(6, duplicataParcela.getCdFormaPagto());
			} else {
				ps.setNull(6, 0);
			}
			ps.setDate(7,ConverteDate.DateToDateSql(duplicataParcela.getDtEmissao()));
			if (duplicataParcela.getDtComp() != null) {
				ps.setDate(8, ConverteDate.DateToDateSql(duplicataParcela.getDtComp()));
			} else {
				ps.setDate(8, null);
			}
			ps.setString(9, duplicataParcela.getNrDoc());
			ps.setInt(10, duplicataParcela.getIdPlanoConta());
			ps.setInt(11, duplicataParcela.getIdCentroCusto());
			ps.setString(12, duplicataParcela.getHistorico());
			ps.setString(13, duplicataParcela.getDivideValor());
			if (duplicataParcela.getDtOperacao() != null) {
				ps.setDate(14, ConverteDate.DateToDateSql(duplicataParcela.getDtOperacao()));
			} else {
				ps.setDate(14, null);
			}
			ps.setDouble(15, duplicataParcela.getVlOperacao());
			ps.setFloat(16, duplicataParcela.getVlJuros());
			ps.setFloat(17, duplicataParcela.getVlMulta());
			ps.setFloat(18, duplicataParcela.getVlDesc());
			ps.setString(19, duplicataParcela.getNossoNumero());
			ps.setDate(20, ConverteDate.DateToDateSql(duplicataParcela.getDtQuitacao()));
			ps.setString(21, duplicataParcela.getFormaQuitacao());
			// ps.setInt(22, duplicataParcela.getIdColaborador());
			ps.setString(22, duplicataParcela.getAtualizaFinanceiro());
			// ps.setInt(24, duplicataParcela.getIdContaMovto());
			ps.setString(23, duplicataParcela.getStatus());
			ps.setString(24, duplicataParcela.getUsuario());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(DuplicataParcela duplicataParcela)
			throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (duplicataParcela == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {

			String sql = "UPDATE tbduplicataparcela set idDuplicata = ?, nrParcela = ?, idConta = ?, dtVenc = ?, valor = ?, cdFormaPagto = ?, dtEmissao = ?, dtComp = ?, nrDoc = ?, "
					+ "idPlanoConta = ?, idCentroCusto = ?, historico = ?, divideValor = ?, dtOperacao = ?, vlOperacao = ?, vlJuros = ?, vlMulta = ?, vlDesc = ?, nossoNumero = ?, "
					+ "dtQuitacao = ?, formaQuitacao = ?, atualizaFinanceiro = ?, status = ?, dtMov = now(), usuario = ? "
					+ "WHERE idDuplicataParcela = ? ;";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, duplicataParcela.getIdDuplicata());
			ps.setInt(2, duplicataParcela.getNrParcela());
			if (duplicataParcela.getIdConta() != 0) {
				ps.setInt(3, duplicataParcela.getIdConta());
			} else {
				ps.setNull(3, 0);
			}
			if (duplicataParcela.getDtVenc() != null) {
				ps.setDate(4, ConverteDate.DateToDateSql(duplicataParcela.getDtVenc()));
			} else {
				ps.setDate(4, null);
			}
			ps.setDouble(5, duplicataParcela.getValor());
			if (duplicataParcela.getCdFormaPagto() != 0) {
				ps.setInt(6, duplicataParcela.getCdFormaPagto());
			} else {
				ps.setNull(6, 0);
			}
			if (duplicataParcela.getDtEmissao() != null) {
				ps.setDate(7, ConverteDate.DateToDateSql(duplicataParcela.getDtEmissao()));
			} else {
				ps.setDate(7, null);
			}
			if (duplicataParcela.getDtComp() != null) {
				ps.setDate(8, ConverteDate.DateToDateSql(duplicataParcela.getDtComp()));
			} else {
				ps.setDate(8, null);
			}
			ps.setString(9, duplicataParcela.getNrDoc());
			ps.setInt(10, duplicataParcela.getIdPlanoConta());
			ps.setInt(11, duplicataParcela.getIdCentroCusto());
			ps.setString(12, duplicataParcela.getHistorico());
			ps.setString(13, duplicataParcela.getDivideValor());
			if (duplicataParcela.getDtOperacao() != null) {
				ps.setDate(14, ConverteDate.DateToDateSql(duplicataParcela.getDtOperacao()));
			} else {
				ps.setDate(14, null);
			}
			ps.setDouble(15, duplicataParcela.getVlOperacao());
			ps.setFloat(16, duplicataParcela.getVlJuros());
			ps.setFloat(17, duplicataParcela.getVlMulta());
			ps.setFloat(18, duplicataParcela.getVlDesc());
			ps.setString(19, duplicataParcela.getNossoNumero());
			ps.setDate(20, ConverteDate.DateToDateSql(duplicataParcela.getDtQuitacao()));
			ps.setString(21, duplicataParcela.getFormaQuitacao());
			// ps.setInt(22, duplicataParcela.getIdColaborador());
			ps.setString(22, duplicataParcela.getAtualizaFinanceiro());
			// ps.setInt(24, duplicataParcela.getIdContaMovto());
			ps.setString(23, duplicataParcela.getStatus());
			ps.setString(24, duplicataParcela.getUsuario());
			ps.setInt(25, duplicataParcela.getIdDuplicataParcela());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void excluir(DuplicataParcela duplicataParcela)
			throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (duplicataParcela == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn
					.prepareStatement("DELETE FROM tbduplicataparcela WHERE idDuplicataParcela = ? ");
			ps.setInt(1, duplicataParcela.getIdDuplicataParcela());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			// ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public DuplicataParcela procurarDuplicataParcela(int idDuplicataParcela)
			throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		DuplicataParcela duplicataParcela = null;

		try {
			String sql = "SELECT idDuplicata, nrParcela, idConta, dtVenc, valor, cdFormaPagto, dtEmissao, dtComp, nrDoc, "
					+ "idPlanoConta, idCentroCusto, historico, divideValor, dtOperacao, vlOperacao, vlJuros, vlMulta, vlDesc, nossoNumero, "
					+ "dtQuitacao, formaQuitacao, idColaborador, atualizaFinanceiro, idContaMovto, status, dtMov, usuario "
					+ "from tbduplicataparcela Where idDuplicataParcela = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idDuplicataParcela);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + idDuplicataParcela);
			}
			int idDuplicata = rs.getInt(1);
			int nrParcela = rs.getInt(2);
			int idConta = rs.getInt(3);
			Date dtVenc = rs.getDate(4);
			double valor = rs.getDouble(5);
			int cdFormaPagto = rs.getInt(6);
			Date dtEmissao = rs.getDate(7);
			Date dtComp = rs.getDate(8);
			String nrDoc = rs.getString(9);
			int idPlanoConta = rs.getInt(10);
			int idCentroCusto = rs.getInt(11);
			String historico = rs.getString(12);
			String divideValor = rs.getString(13);
			Date dtOperacao = rs.getDate(14);
			double vlOperacao = rs.getDouble(15);
			float vlJuros = rs.getFloat(16);
			float vlMulta = rs.getFloat(17);
			float vlDesc = rs.getFloat(18);
			String nossoNumero = rs.getString(19);
			Date dtQuitacao = rs.getDate(20);
			String formaQuitacao = rs.getString(21);
			int idColaborador = rs.getInt(22);
			String atualizaFinanceiro = rs.getString(23);
			int idContaMovto = rs.getInt(24);
			String status = rs.getString(25);
			Date dtMov = rs.getDate(26);
			String usuario = rs.getString(27);
			duplicataParcela = new DuplicataParcela(idDuplicataParcela,
					idDuplicata, nrParcela, idConta, dtVenc, valor,
					cdFormaPagto, dtEmissao, dtComp, nrDoc, idPlanoConta,
					idCentroCusto, historico, divideValor, dtOperacao,
					vlOperacao, vlJuros, vlMulta, vlDesc, nossoNumero,
					dtQuitacao, formaQuitacao, idColaborador,
					atualizaFinanceiro, idContaMovto, status, dtMov, usuario);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return duplicataParcela;
	}

	public DuplicataParcela procurarDuplicataParcelaAberta(int idDuplicata)
			throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		DuplicataParcela duplicataParcela = null;

		try {
			String sql = "SELECT idDuplicataParcela, nrParcela, idConta, dtVenc, valor, cdFormaPagto, dtEmissao, dtComp, nrDoc, "
					+ "idPlanoConta, idCentroCusto, historico, divideValor, dtOperacao, vlOperacao, vlJuros, vlMulta, vlDesc, nossoNumero, "
					+ "dtQuitacao, formaQuitacao, idColaborador, atualizaFinanceiro, idContaMovto, status, dtMov, usuario "
					+ "from tbduplicataparcela Where idDuplicata = ? and status = 'A' ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idDuplicata);
			rs = ps.executeQuery();
			if (!rs.next()) {
				//throw new AferoDAOException("Não foi encontrado nenhum "
				//		+ "registro com o código: " + idDuplicata);
				return null;
			}
			int idDuplicataParcela = rs.getInt(1);
			int nrParcela = rs.getInt(2);
			int idConta = rs.getInt(3);
			Date dtVenc = rs.getDate(4);
			double valor = rs.getDouble(5);
			int cdFormaPagto = rs.getInt(6);
			Date dtEmissao = rs.getDate(7);
			Date dtComp = rs.getDate(8);
			String nrDoc = rs.getString(9);
			int idPlanoConta = rs.getInt(10);
			int idCentroCusto = rs.getInt(11);
			String historico = rs.getString(12);
			String divideValor = rs.getString(13);
			Date dtOperacao = rs.getDate(14);
			double vlOperacao = rs.getDouble(15);
			float vlJuros = rs.getFloat(16);
			float vlMulta = rs.getFloat(17);
			float vlDesc = rs.getFloat(18);
			String nossoNumero = rs.getString(19);
			Date dtQuitacao = rs.getDate(20);
			String formaQuitacao = rs.getString(21);
			int idColaborador = rs.getInt(22);
			String atualizaFinanceiro = rs.getString(23);
			int idContaMovto = rs.getInt(24);
			String status = rs.getString(25);
			Date dtMov = rs.getDate(26);
			String usuario = rs.getString(27);
			duplicataParcela = new DuplicataParcela(idDuplicataParcela,
					idDuplicata, nrParcela, idConta, dtVenc, valor,
					cdFormaPagto, dtEmissao, dtComp, nrDoc, idPlanoConta,
					idCentroCusto, historico, divideValor, dtOperacao,
					vlOperacao, vlJuros, vlMulta, vlDesc, nossoNumero,
					dtQuitacao, formaQuitacao, idColaborador,
					atualizaFinanceiro, idContaMovto, status, dtMov, usuario);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return duplicataParcela;
	}

	public List listarDuplicataParcela(String clausula)
			throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<DuplicataParcela> list = null;

		try {
			String sql = "SELECT dp.idDuplicata, dp.nrParcela, dp.idConta, dp.dtVenc, dp.valor, dp.cdFormaPagto, dp.dtEmissao, dp.dtComp, dp.nrDoc, "
					+ "dp.idPlanoConta, dp.idCentroCusto, dp.historico, dp.divideValor, dp.dtOperacao, dp.vlOperacao, dp.vlJuros, dp.vlMulta, dp.vlDesc, dp.nossoNumero, "
					+ "dp.dtQuitacao, dp.formaQuitacao, dp.atualizaFinanceiro, dp.idContaMovto, dp.status, dp.dtMov, dp.usuario, idDuplicataParcela "
					+ "from tbduplicataparcela dp "
					+ "join tbduplicata d on dp.idDuplicata = d.idDuplicata "
					+ "join tbentidade e on d.cdEntidade = e.cdEntidade ";
			if (clausula != null)
				sql += clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<DuplicataParcela>();
			while (rs.next()) {
				int idDuplicata = rs.getInt(1);
				int nrParcela = rs.getInt(2);
				int idConta = rs.getInt(3);
				Date dtVenc = rs.getDate(4);
				double valor = rs.getDouble(5);
				int cdFormaPagto = rs.getInt(6);
				Date dtEmissao = rs.getDate(7);
				Date dtComp = rs.getDate(8);
				String nrDoc = rs.getString(9);
				int idPlanoConta = rs.getInt(10);
				int idCentroCusto = rs.getInt(11);
				String historico = rs.getString(12);
				String divideValor = rs.getString(13);
				Date dtOperacao = rs.getDate(14);
				double vlOperacao = rs.getDouble(15);
				float vlJuros = rs.getFloat(16);
				float vlMulta = rs.getFloat(17);
				float vlDesc = rs.getFloat(18);
				String nossoNumero = rs.getString(19);
				Date dtQuitacao = rs.getDate(20);
				String formaQuitacao = rs.getString(21);
				String atualizaFinanceiro = rs.getString(22);
				int idContaMovto = rs.getInt(23);
				String status = rs.getString(24);
				Date dtMov = rs.getDate(25);
				String usuario = rs.getString(26);
				int idDuplicataParcela = rs.getInt(27);
				int idColaborador = 0;
				list.add(new DuplicataParcela(idDuplicataParcela, idDuplicata,
						nrParcela, idConta, dtVenc, valor, cdFormaPagto,
						dtEmissao, dtComp, nrDoc, idPlanoConta, idCentroCusto,
						historico, divideValor, dtOperacao, vlOperacao,
						vlJuros, vlMulta, vlDesc, nossoNumero, dtQuitacao,
						formaQuitacao, idColaborador, atualizaFinanceiro,
						idContaMovto, status, dtMov, usuario));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}

	public boolean exclusaoIdDuplicataParcela(int idDuplicataParcela)
			throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = true;
		try {
			String sql = "select dd.idDuplicataParcela "
					+ "from tbduplicataparcela dd "
					+ "join tbduplicata d on d.idDuplicata = dd.idDuplicata "
					+ "where dd.idDuplicataParcela = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idDuplicataParcela);
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

	public String dataAtualDuplicata() throws AferoDAOException {
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
		}
		return dataAtual;
	}

	public String dataVencimentoDataAtual(int num) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		String sql = null;
		String dataAtual = "";

		try {
			sql = "SELECT DATE_ADD(CURDATE(), INTERVAL ? DAY);";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			if (num == 0) {
				ps.setInt(1, 30);
			} else {
				ps.setInt(1, num);
			}
			rs = ps.executeQuery();
			if (rs.next()) {

				dataAtual = ConverteDate.dateToString(rs.getDate(1));
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		}
		return dataAtual;
	}

	public String dataVencimentoEntreDatas(Date dataVencimento, int num)
			throws Exception {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		String sql = null;
		String dataAtual = "";

		try {
			sql = "SELECT DATE_ADD(?, INTERVAL ? DAY);";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setDate(1, ConverteDate.DateToDateSql(dataVencimento));
			if (num == 0) {
				ps.setInt(2, 30);
			} else {
				ps.setInt(2, num);
			}
			rs = ps.executeQuery();
			if (rs.next()) {

				dataAtual = ConverteDate.dateToString(rs.getDate(1));
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		}
		return dataAtual;
	}

	public int contDuplicataParcelaQuitada(int idDuplicata)
			throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		DuplicataParcela duplicataParcela = null;
		int contQuitada = 0;

		try {
			String sql = "SELECT idDuplicata, nrParcela, idConta, dtVenc, valor, cdFormaPagto, dtEmissao, dtComp, nrDoc, "
					+ "idPlanoConta, idCentroCusto, historico, divideValor, dtOperacao, vlOperacao, vlJuros, vlMulta, vlDesc, nossoNumero, "
					+ "dtQuitacao, formaQuitacao, idColaborador, atualizaFinanceiro, idContaMovto, status, dtMov, usuario "
					+ "from tbduplicataparcela "
					+ "Where status = 'DQ' AND idDuplicata = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idDuplicata);
			rs = ps.executeQuery();
			while (rs.next()) {
				contQuitada++;
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		}
		return contQuitada;
	}

	public int contDuplicataParcelaAberta(int idDuplicata)
			throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		DuplicataParcela duplicataParcela = null;
		int contAberta = 0;

		try {
			String sql = "SELECT idDuplicata, nrParcela, idConta, dtVenc, valor, cdFormaPagto, dtEmissao, dtComp, nrDoc, "
					+ "idPlanoConta, idCentroCusto, historico, divideValor, dtOperacao, vlOperacao, vlJuros, vlMulta, vlDesc, nossoNumero, "
					+ "dtQuitacao, formaQuitacao, idColaborador, atualizaFinanceiro, idContaMovto, status, dtMov, usuario "
					+ "from tbduplicataparcela Where status = 'A' AND idDuplicata = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idDuplicata);
			rs = ps.executeQuery();
			while (rs.next()) {
				contAberta++;
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return contAberta;
	}

	public void alterarParcelas(DuplicataParcela duplicataParcela)
			throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (duplicataParcela == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {

			String sql = "UPDATE tbduplicataparcela set dtVenc = ?, valor = ?, dtMov = now() "
					+ " WHERE nrParcela = ? AND idDuplicata = ? ";

			conn = this.conn;
			ps = conn.prepareStatement(sql);
			if (duplicataParcela.getDtVenc() != null) {
				ps.setDate(1, ConverteDate.DateToDateSql(duplicataParcela.getDtVenc()));
			} else {
				ps.setDate(1, null);
			}
			ps.setDouble(2, duplicataParcela.getValor());
			ps.setInt(3, duplicataParcela.getNrParcela());
			ps.setInt(4, duplicataParcela.getIdDuplicata());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);
		}
	}
	public int getCdEntidade(int idDuplicataParcela)throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		int cdEntidade = 0;
		try {
			String sql = "select d.cdEntidade "
				+ "from tbduplicataparcela dd "
				+ "join tbduplicata d on d.idDuplicata = dd.idDuplicata "
				+ "where dd.idDuplicataParcela = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idDuplicataParcela);
			rs = ps.executeQuery();
			if (rs.next()) {
				cdEntidade = rs.getInt(1);
			} 

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		}
		return cdEntidade;
	}
	public void incluirContasReceber(DuplicataParcela duplicataParcela)throws Exception {
		PreparedStatement ps = null;
		Connection conn = null;
		String sql = "";
		if (duplicataParcela == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");
		
		try {
			sql = "INSERT INTO tbduplicataparcela(idDuplicata, nrParcela, dtVenc, valor, dtEmissao, nrDoc, historico, status, dtMov, usuario) "
					+ "VALUES(?, ?, ?, ?, ?, ?, ?, ?, now(), ?);";
		
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, duplicataParcela.getIdDuplicata());
			ps.setInt(2, duplicataParcela.getNrParcela());
			ps.setDate(3,ConverteDate.DateToDateSql(duplicataParcela.getDtVenc()));
			ps.setDouble(4, duplicataParcela.getValor());
			ps.setDate(5,ConverteDate.DateToDateSql(duplicataParcela.getDtEmissao()));
			ps.setString(6, duplicataParcela.getNrDoc());
			ps.setString(7, duplicataParcela.getHistorico());
			ps.setString(8, duplicataParcela.getStatus());
			ps.setString(9, duplicataParcela.getUsuario());
			ps.executeUpdate();
		
		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} 
		}

}
