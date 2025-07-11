package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import afero.model.Orcamento;
import afero.model.RelatorioOrcamentoCabecalho;
import afero.model.RelatorioOrcamentoCliente;
import afero.model.RelatorioOrcamentoCorpo;
import afero.util.ConverteDate;

public class OrcamentoDAO implements IOrcamentoDAO {

	private Connection conn;

	public OrcamentoDAO(Connection conn) {
		this.conn = conn;
	}

	public void incluir(Orcamento orcamento) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (orcamento == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tborcamento(idLoja, cdEntidade, "
					+ "idEntrega, idColaborador, dtOrc, vlOrc, prazoValidade, "
					+ "observacao, status, dtMod, usuario, dtEntrega, pessoaResponsavel) "
					+ "values(?, ?, ?, ?, now(), ?, ?, ?, ?, now(), ?, ?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, orcamento.getIdLoja());
			ps.setInt(2, orcamento.getCdEntidade());
			ps.setInt(3, orcamento.getIdEntrega());
			ps.setInt(4, orcamento.getIdColaborador());
			ps.setDouble(5, orcamento.getVlOrc());
			ps.setInt(6, orcamento.getPrazoValidade());
			ps.setString(7, orcamento.getObservacao());
			ps.setString(8, orcamento.getStatus());
			ps.setString(9, orcamento.getUsuario());
			ps.setDate(10, ConverteDate.DateToDateSql(orcamento.getDtEntrega()));
			ps.setString(11, orcamento.getPessoaResponsavel());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(Orcamento orcamento) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (orcamento == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tborcamento set idLoja = ?, cdEntidade = ?, "
					+ "idEntrega = ?, idColaborador = ?, vlOrc = ?, prazoValidade = ?, "
					+ "observacao = ?, status = ?, dtMod = now(), usuario = ?, dtEntrega = ?, pessoaResponsavel = ? "
					+ "where idOrcamento = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, orcamento.getIdLoja());
			ps.setInt(2, orcamento.getCdEntidade());
			ps.setInt(3, orcamento.getIdEntrega());
			ps.setInt(4, orcamento.getIdColaborador());
			ps.setDouble(5, orcamento.getVlOrc());
			ps.setInt(6, orcamento.getPrazoValidade());
			ps.setString(7, orcamento.getObservacao());
			ps.setString(8, orcamento.getStatus());
			ps.setString(9, orcamento.getUsuario());
			ps.setDate(10, ConverteDate.DateToDateSql(orcamento.getDtEntrega()));
			ps.setString(11, orcamento.getPessoaResponsavel());
			ps.setInt(12, orcamento.getIdOrcamento());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);

		}
	}
	
	public void atualizarCabecalho(Orcamento orcamento) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (orcamento == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tborcamento set idLoja = ?, cdEntidade = ?, "
					+ "idEntrega = ?, idColaborador = ?, prazoValidade = ?, "
					+ "observacao = ?, status = ?, dtMod = now(), usuario = ?, dtEntrega = ?, pessoaResponsavel = ? "
					+ "where idOrcamento = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, orcamento.getIdLoja());
			ps.setInt(2, orcamento.getCdEntidade());
			ps.setInt(3, orcamento.getIdEntrega());
			ps.setInt(4, orcamento.getIdColaborador());
			ps.setInt(5, orcamento.getPrazoValidade());
			ps.setString(6, orcamento.getObservacao());
			ps.setString(7, orcamento.getStatus());
			ps.setString(8, orcamento.getUsuario());
			ps.setDate(9, ConverteDate.DateToDateSql(orcamento.getDtEntrega()));
			ps.setString(10, orcamento.getPessoaResponsavel());
			ps.setInt(11, orcamento.getIdOrcamento());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);

		}
	}
	
	public void atualizarItem(Orcamento orcamento) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (orcamento == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tborcamento set idLoja = ?, cdEntidade = ?, "
					+ "idEntrega = ?, idColaborador = ?, vlOrc = ?, prazoValidade = ?, "
					+ "observacao = ?, status = ?, dtMod = now(), usuario = ?, dtEntrega = ?, pessoaResponsavel = ?, vlDesc = ? "
					+ "where idOrcamento = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, orcamento.getIdLoja());
			ps.setInt(2, orcamento.getCdEntidade());
			ps.setInt(3, orcamento.getIdEntrega());
			ps.setInt(4, orcamento.getIdColaborador());
			ps.setDouble(5, orcamento.getVlOrc());
			ps.setInt(6, orcamento.getPrazoValidade());
			ps.setString(7, orcamento.getObservacao());
			ps.setString(8, orcamento.getStatus());
			ps.setString(9, orcamento.getUsuario());
			ps.setDate(10, ConverteDate.DateToDateSql(orcamento.getDtEntrega()));
			ps.setString(11, orcamento.getPessoaResponsavel());
			ps.setFloat(12, orcamento.getVlDesc());
			ps.setInt(13, orcamento.getIdOrcamento());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void excluir(Orcamento orcamento) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (orcamento == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn
					.prepareStatement("DELETE FROM tborcamento WHERE idOrcamento=?");
			ps.setInt(1, orcamento.getIdOrcamento());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			// ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public Orcamento procurarOrcamento(int idOrcamento)
			throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		Orcamento orcamento = null;

		try {
			String sql = "SELECT idLoja, cdEntidade, "
					+ "idEntrega, idColaborador, dtOrc, vlOrc, "
					+ "prazoValidade, observacao, status, vlAprov, dtAprov, dtMod, usuario, dtEntrega, pessoaResponsavel "
					+ "FROM tborcamento " 
					+ "WHERE idOrcamento = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idOrcamento);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + idOrcamento);
			}

			int idLoja = rs.getInt(1);
			int cdEntidade = rs.getInt(2);
			int idEntrega = rs.getInt(3);
			int idColaborador = rs.getInt(4);
			Date dtOrc = rs.getTimestamp(5);
			double vlOrc = rs.getDouble(6);
			int prazoValidade = rs.getInt(7);
			String observacao = rs.getString(8);
			String status = rs.getString(9);
			double vlAprov = rs.getDouble(10);
			Date dtAprov = rs.getDate(11);
			Date dtMod = rs.getDate(12);
			String usuario = rs.getString(13);
			Date dtEntrega = rs.getDate(14);
			String pessoaResponsavel = rs.getString(15);

			orcamento = new Orcamento(idOrcamento, idLoja, cdEntidade,
					idEntrega, idColaborador, dtOrc, vlOrc, prazoValidade,
					observacao, status, vlAprov, dtAprov, dtMod, usuario,
					dtEntrega, pessoaResponsavel);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return orcamento;
	}
	public Orcamento procurarOrcamentoItem(int idOrcamento)throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		Orcamento orcamento = null;

		try {
			String sql = "SELECT idLoja, cdEntidade, "
				+ "idEntrega, idColaborador, dtOrc, vlOrc, "
				+ "prazoValidade, observacao, status, vlAprov, dtAprov, dtMod, usuario, dtEntrega, pessoaResponsavel, vlDesc "
				+ "FROM tborcamento "  
				+ "WHERE idOrcamento = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idOrcamento);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + idOrcamento);
			}

			int idLoja = rs.getInt(1);
			int cdEntidade = rs.getInt(2);
			int idEntrega = rs.getInt(3);
			int idColaborador = rs.getInt(4);
			Date dtOrc = rs.getTimestamp(5);
			double vlOrc = rs.getDouble(6);
			int prazoValidade = rs.getInt(7);
			String observacao = rs.getString(8);
			String status = rs.getString(9);
			double vlAprov = rs.getDouble(10);
			Date dtAprov = rs.getDate(11);
			Date dtMod = rs.getDate(12);
			String usuario = rs.getString(13);
			Date dtEntrega = rs.getDate(14);
			String pessoaResponsavel = rs.getString(15);
			float vlDesc = rs.getFloat(16);

			orcamento = new Orcamento(idOrcamento, idLoja, cdEntidade,
					idEntrega, idColaborador, dtOrc, vlOrc, prazoValidade,
					observacao, status, vlAprov, dtAprov, dtMod, usuario,
					dtEntrega, pessoaResponsavel, vlDesc);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return orcamento;
	}
	
	

	public List listarOrcamento(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<Orcamento> list = null;

		try {
			String sql = "select o.idOrcamento, o.idLoja, o.cdEntidade, o.idEntrega, o.idColaborador, o.dtOrc, o.vlOrc, o.prazoValidade, "
					+ "o.observacao, o.status, o.vlAprov, o.dtAprov, o.dtMod, o.usuario, o.dtEntrega, o.pessoaResponsavel "
					+ "from tborcamento o "
					+ "join tbentidade e on (o.cdEntidade = e.cdEntidade) ";
			if (clausula != null)
				sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<Orcamento>();
			while (rs.next()) {
				int idOrcamento = rs.getInt(1);
				int idLoja = rs.getInt(2);
				int cdEntidade = rs.getInt(3);
				int idEntrega = rs.getInt(4);
				int idColaborador = rs.getInt(5);
				Date dtOrc = rs.getTimestamp(6);
				double vlOrc = rs.getDouble(7);
				int prazoValidade = rs.getInt(8);
				String observacao = rs.getString(9);
				String status = rs.getString(10);
				double vlAprov = rs.getDouble(11);
				Date dtAprov = rs.getDate(12);
				Date dtMod = rs.getDate(13);
				String usuario = rs.getString(14);
				Date dtEntrega = rs.getDate(15);
				String pessoaResponsavel = rs.getString(16);

				list.add(new Orcamento(idOrcamento, idLoja, cdEntidade,
						idEntrega, idColaborador, dtOrc, vlOrc, prazoValidade,
						observacao, status, vlAprov, dtAprov, dtMod, usuario,
						dtEntrega, pessoaResponsavel));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}

	public void aprovarOrcamento(Orcamento orcamento) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (orcamento == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tborcamento set vlAprov = ?, dtAprov = now(), usuario = ?, status = ? "
					+ "where idOrcamento = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setDouble(1, orcamento.getVlAprov());
			ps.setString(2, orcamento.getUsuario());
			ps.setString(3, orcamento.getStatus());
			ps.setInt(4, orcamento.getIdOrcamento());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public String dataAtualOrcamento() throws AferoDAOException {
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

	public int idOrcamentoCorrente() throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		int numOrcamento = 0;

		try {
			String sql = "select max(idOrcamento) from tborcamento order by idOrcamento DESC LIMIT 1";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if (rs.next()) {
				numOrcamento = rs.getInt(1);
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return numOrcamento;
	}
	public RelatorioOrcamentoCabecalho relatorioOrcamentoLoja(int idLoja) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		RelatorioOrcamentoCabecalho relatorioCabecalho = null;

		try {
			String sql = "select l.razaoSocial, l.endereco, l.cmpEndereco, l.cnpj, l.inscEstadual, l.bairro, l.cmpEndereco, l.nroTelefone "+
                         "from tbloja l "+
                         "where l.idLoja = ?";
			conn = this.conn;
			ps.setInt(1, idLoja);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + idLoja);
			}
			String razaoSocial = rs.getString(1);
			String endereco = rs.getString(2);
			String cmpEndereco = rs.getString(3);
			String cnpj = rs.getString(4);
			String inscEstadual = rs.getString(5);
			String bairro = rs.getString(6);
			String nroTelefone = rs.getString(7);
			relatorioCabecalho = new RelatorioOrcamentoCabecalho(razaoSocial, endereco,
					cmpEndereco, cnpj, inscEstadual,
					bairro, nroTelefone, idLoja);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		}
		return relatorioCabecalho;
	}
	public RelatorioOrcamentoCliente relatorioOrcamentoCliente(int idOrcamento) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		RelatorioOrcamentoCliente relatorioCliente = null;

		try {
			String sql = "select o.idOrcamento, e.nome, o.dtEntrega, en.dsEntrega, o.pessoaResponsavel, o.prazoValidade, o.observacao, "+
                         "o.status, ent.nroTelefone "+
                         "from tborcamento o "+
                         "Join tbentidade e on (o.cdEntidade = e.cdEntidade) "+
                         "join tbentidadetelefone ent on (o.cdEntidade = ent.cdEntidade) AND ent.padrao = 'S' "+
                         "Join tbentrega en on (o.idEntrega = en.idEntrega) "+
                         "where o.idOrcamento = ?";
			conn = this.conn;
			ps.setInt(1, idOrcamento);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + idOrcamento);
			}
			String nome = rs.getString(2);
			Date dtEntrega = rs.getDate(3);
			String dsEntrega = rs.getString(4);
			String pessoaResponsavel = rs.getString(5);
			int prazoValidade = rs.getInt(6);
			String observacao = rs.getString(7);
			String status = rs.getString(8);
			String nroTelefone = rs.getString(9);
			relatorioCliente = new RelatorioOrcamentoCliente(idOrcamento, nome,
					dtEntrega, dsEntrega, pessoaResponsavel,
					prazoValidade, observacao, status,
					nroTelefone);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		}
		return relatorioCliente;
	}
	public List relatorioOrcamentoCorpo(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<RelatorioOrcamentoCorpo> list = null;

		try {
			String sql = "select p.dsProduto, oi.quant, oi.pDesc, oi.vlUni,(oi.quant * oi.vlUni)as valor, u.dsUnidade "+
                         "from tborcamentoitem oi "+
                         "join tbproduto p on (oi.idProduto = p.idProduto) "+
                         "join tbestoque e on (p.idProduto = e.idProduto) "+
                         "join tbpreco pr on (e.idEstoque = pr.idEstoque) "+
                         "join tbunidade u on (pr.idUnidade = u.idUnidade) "+
                         "Where p.status='A' AND pr.precoPadrao = 'S' AND oi.idOrcamento = ? ";
			if (clausula != null)
				sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<RelatorioOrcamentoCorpo>();
			while (rs.next()) {
				String dsProduto = rs.getString(1);
				float quant = rs.getFloat(2);
				float pDesc = rs.getFloat(3);
				float vlUni = rs.getFloat(4);
				float valor = rs.getFloat(5);
				String dsUnidade = rs.getString(6);
				list.add(new RelatorioOrcamentoCorpo(dsProduto, quant, pDesc,
						vlUni, valor, dsUnidade));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return list;
	}
	
	public void setHoraEntrega(Orcamento orcamento) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (orcamento == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tborcamento set hrEntrega = ? "
					+ "where idOrcamento = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, orcamento.getHrEntrega());
			ps.setInt(2, orcamento.getIdOrcamento());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} 
	}
	
	public String procurarHrEntrega(int idOrcamento)throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		String hrEntrega = null;

		try {
			String sql = "SELECT hrEntrega FROM tborcamento WHERE idOrcamento = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idOrcamento);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
				+ "registro com o código: " + idOrcamento);
			}

			hrEntrega = rs.getString(1);
			

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		}
		return hrEntrega;
	}

}
