package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import afero.model.OrcamentoSub;
import afero.util.ConverteDate;

public class OrcamentoSubDAO  {

	private Connection conn;

	public OrcamentoSubDAO(Connection conn) {
		this.conn = conn;
	}

	public void incluir(OrcamentoSub orcamento) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (orcamento == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tborcamento(idLoja, cdEntidade, idEntrega, idColaborador, dtOrc, dtEntrega, pessoaResponsavel, " +
						" vlOrc, prazoValidade, vlDesc, observacao, status, vlAprov, dtAprov, idOrdemServico, cdCondPagto, prazoEntrega," +
						" prazoGarantia, cmpOc1, cmpOc2, cmpOc3, cmpOc4, dtMod, usuario) " +
						"values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now(), ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, orcamento.getIdLoja());
			ps.setInt(2, orcamento.getCdEntidade());
			ps.setInt(3, orcamento.getIdEntrega());
			ps.setInt(4, orcamento.getIdColaborador());
			if (orcamento.getDtOrc() != null){
				ps.setDate(5, ConverteDate.DateToDateSql(orcamento.getDtOrc()));
			}else{
				ps.setDate(5, null);
			}
			if (orcamento.getDtEntrega() != null){
				ps.setDate(6, ConverteDate.DateToDateSql(orcamento.getDtEntrega()));
			}else{
				ps.setDate(6, null);
			}
			ps.setString(7, orcamento.getPessoaResponsavel());
			ps.setDouble(8, orcamento.getVlOrc());
			ps.setInt(9, orcamento.getPrazoValidade());
			ps.setFloat(10, orcamento.getVlDesc());
			ps.setString(11, orcamento.getObservacao());
			ps.setString(12, orcamento.getStatus());
			ps.setDouble(13, orcamento.getVlAprov());
			if (orcamento.getDtAprov() != null) {
				ps.setDate(14, ConverteDate.DateToDateSql(orcamento.getDtAprov()));
			}else{
				ps.setDate(14, null);
			}
			if(orcamento.getIdOrdemServico() > 0){
				ps.setInt(15, orcamento.getIdOrdemServico());
			}else{
				ps.setNull(15, 0);
			}
			if(orcamento.getCdCondPagto() > 0){
				ps.setInt(16, orcamento.getCdCondPagto());
			}else{
				ps.setNull(16, 0);
			}
			ps.setInt(17, orcamento.getPrazoEntrega());
			ps.setInt(18, orcamento.getPrazoGarantia());
			ps.setString(19, orcamento.getCmpOc1());
			ps.setString(20, orcamento.getCmpOc2());
			ps.setString(21, orcamento.getCmpOc3());
			ps.setString(22, orcamento.getCmpOc4());
			ps.setString(23, orcamento.getUsuario());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(OrcamentoSub orcamento) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (orcamento == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tborcamento set idLoja = ?, cdEntidade = ?, idEntrega = ?, idColaborador = ?, dtOrc = ?, dtEntrega = ?," +
						" pessoaResponsavel = ?, vlOrc = ?, prazoValidade = ?, vlDesc = ?, observacao = ?, status = ?, vlAprov = ?, dtAprov = ?," +
						" idOrdemServico = ?, cdCondPagto = ?, prazoEntrega = ?, prazoGarantia = ?, cmpOc1 = ?, cmpOc2 = ?, cmpOc3 = ?, cmpOc4 = ?," +
						" dtMod = now(), usuario = ? " +
						"WHERE idOrcamento = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, orcamento.getIdLoja());
			ps.setInt(2, orcamento.getCdEntidade());
			ps.setInt(3, orcamento.getIdEntrega());
			ps.setInt(4, orcamento.getIdColaborador());
			if (orcamento.getDtOrc() != null){
				ps.setDate(5, ConverteDate.DateToDateSql(orcamento.getDtOrc()));
			}else{
				ps.setDate(5, null);
			}
			if (orcamento.getDtEntrega() != null){
				ps.setDate(6, ConverteDate.DateToDateSql(orcamento.getDtEntrega()));
			}else{
				ps.setDate(6, null);
			}
			ps.setString(7, orcamento.getPessoaResponsavel());
			ps.setDouble(8, orcamento.getVlOrc());
			ps.setInt(9, orcamento.getPrazoValidade());
			ps.setFloat(10, orcamento.getVlDesc());
			ps.setString(11, orcamento.getObservacao());
			ps.setString(12, orcamento.getStatus());
			ps.setDouble(13, orcamento.getVlAprov());
			if (orcamento.getDtAprov() != null) {
				ps.setDate(14, ConverteDate.DateToDateSql(orcamento.getDtAprov()));
			}else{
				ps.setDate(14, null);
			}
			if(orcamento.getIdOrdemServico() > 0){
				ps.setInt(15, orcamento.getIdOrdemServico());
			}else{
				ps.setNull(15, 0);
			}
			if(orcamento.getCdCondPagto() > 0){
				ps.setInt(16, orcamento.getCdCondPagto());
			}else{
				ps.setNull(16, 0);
			}
			ps.setInt(17, orcamento.getPrazoEntrega());
			ps.setInt(18, orcamento.getPrazoGarantia());
			ps.setString(19, orcamento.getCmpOc1());
			ps.setString(20, orcamento.getCmpOc2());
			ps.setString(21, orcamento.getCmpOc3());
			ps.setString(22, orcamento.getCmpOc4());
			ps.setString(23, orcamento.getUsuario());
			ps.setInt(24, orcamento.getIdOrcamento());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao atualizar dados: " + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);

		}
	}
	
	public void atualizarCabecalho(OrcamentoSub orcamento) throws AferoDAOException {
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
	
	public void atualizarItem(OrcamentoSub orcamento) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (orcamento == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tborcamento set idLoja = ?, cdEntidade = ?, idEntrega = ?, idColaborador = ?, pessoaResponsavel = ?, vlOrc = ?, " +
						"prazoValidade = ?, vlDesc = ?, observacao = ?, status = ?, vlAprov = ?, dtAprov = ?, " +
						"cdCondPagto = ?, prazoEntrega = ?, prazoGarantia = ?, cmpOc1 = ?, cmpOc2 = ?, cmpOc3 = ?, cmpOc4 = ?, " +
						" dtMod = now(), usuario = ? " +
						"WHERE idOrcamento = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, orcamento.getIdLoja());
			ps.setInt(2, orcamento.getCdEntidade());
			ps.setInt(3, orcamento.getIdEntrega());
			ps.setInt(4, orcamento.getIdColaborador());
			ps.setString(5, orcamento.getPessoaResponsavel());
			ps.setDouble(6, orcamento.getVlOrc());
			ps.setInt(7, orcamento.getPrazoValidade());
			ps.setFloat(8, orcamento.getVlDesc());
			ps.setString(9, orcamento.getObservacao());
			ps.setString(10, orcamento.getStatus());
			ps.setDouble(11, orcamento.getVlAprov());
			ps.setDate(12,ConverteDate.DateToDateSql(orcamento.getDtAprov()));
			if(orcamento.getCdCondPagto() > 0){
				ps.setInt(13, orcamento.getCdCondPagto());
			}else{
				ps.setNull(13, 0);
			}
			
			ps.setInt(14, orcamento.getPrazoEntrega());
			ps.setInt(15, orcamento.getPrazoGarantia());
			ps.setString(16, orcamento.getCmpOc1());
			ps.setString(17, orcamento.getCmpOc2());
			ps.setString(18, orcamento.getCmpOc3());
			ps.setString(19, orcamento.getCmpOc4());
			ps.setString(20, orcamento.getUsuario());
			ps.setInt(21, orcamento.getIdOrcamento());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void excluir(OrcamentoSub orcamento) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (orcamento == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn
					.prepareStatement("DELETE FROM tborcamento WHERE idOrcamento = ?");
			ps.setInt(1, orcamento.getIdOrcamento());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			// ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public OrcamentoSub procurarOrcamento(int idOrcamento)
			throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		OrcamentoSub orcamento = null;

		try {
			String sql = "SELECT idOrcamento, idLoja, cdEntidade, idEntrega, idColaborador, dtOrc, dtEntrega, pessoaResponsavel, " +
						" vlOrc, prazoValidade, vlDesc, observacao, status, vlAprov, dtAprov, idOrdemServico, cdCondPagto, prazoEntrega," +
						" prazoGarantia, cmpOc1, cmpOc2, cmpOc3, cmpOc4, dtMod, usuario " +
						"FROM tborcamento " +
						"WHERE idOrcamento = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idOrcamento);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + idOrcamento);
			}
			
			int idOrc = rs.getInt(1);
			int idLoja = rs.getInt(2);
			int cdEntidade = rs.getInt(3);
			int idEntrega = rs.getInt(4);
			int idColaborador = rs.getInt(5);
			Date dtOrc = rs.getDate(6);
			Date dtEntrega = rs.getDate(7);
			String pessoaResponsavel = rs.getString(8);
			double vlOrc = rs.getDouble(9);
			int prazoValidade = rs.getInt(10);
			float vlDesc = rs.getFloat(11);
			String observacao = rs.getString(12);
			String status = rs.getString(13);
			double vlAprov = rs.getDouble(14);
			Date dtAprov = rs.getDate(15);
			int idOrdemServico = rs.getInt(16);
			int cdCondPagto = rs.getInt(17);
			int prazoEntrega = rs.getInt(18);
			int prazoGarantia = rs.getInt(19);
			String cmpOc1 = rs.getString(20);
			String cmpOc2 = rs.getString(21);
			String cmpOc3 = rs.getString(22);
			String cmpOc4 = rs.getString(23);
			Date dtMod = rs.getDate(24);
			String usuario = rs.getString(25);
			
			orcamento = new OrcamentoSub(idOrc, idLoja, cdEntidade, idEntrega, idColaborador, dtOrc, dtEntrega, pessoaResponsavel, vlOrc,
					prazoValidade, vlDesc, observacao, status, vlAprov, dtAprov, idOrdemServico, cdCondPagto, prazoEntrega, prazoGarantia, 
					cmpOc1, cmpOc2, cmpOc3, cmpOc4, dtMod, usuario); 
			
		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return orcamento;
	}
	

	public OrcamentoSub procurarOrcamentoItem(int idOrcamento)throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		OrcamentoSub orcamento = null;

		try {
			String sql = "SELECT idOrcamento, idLoja, cdEntidade, idEntrega, idColaborador, dtOrc, dtEntrega, pessoaResponsavel, " +
						" vlOrc, prazoValidade, vlDesc, observacao, status, vlAprov, dtAprov, idOrdemServico, cdCondPagto, prazoEntrega," +
						" prazoGarantia, cmpOc1, cmpOc2, cmpOc3, cmpOc4, dtMod, usuario " +
						"FROM tborcamento " +
						"WHERE idOrcamento = ?";
			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idOrcamento);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum"
						+ "registro com o código: " + idOrcamento);
			}
			
			int idOrc = rs.getInt(1);
			int idLoja = rs.getInt(2);
			int cdEntidade = rs.getInt(3);
			int idEntrega = rs.getInt(4);
			int idColaborador = rs.getInt(5);
			Date dtOrc = rs.getDate(6);
			Date dtEntrega = rs.getDate(7);
			String pessoaResponsavel = rs.getString(8);
			double vlOrc = rs.getDouble(9);
			int prazoValidade = rs.getInt(10);
			float vlDesc = rs.getFloat(11);
			String observacao = rs.getString(12);
			String status = rs.getString(13);
			double vlAprov = rs.getDouble(14);
			Date dtAprov = rs.getDate(15);
			int idOrdemServico = rs.getInt(16);
			int cdCondPagto = rs.getInt(17);
			int prazoEntrega = rs.getInt(18);
			int prazoGarantia = rs.getInt(19);
			String cmpOc1 = rs.getString(20);
			String cmpOc2 = rs.getString(21);
			String cmpOc3 = rs.getString(22);
			String cmpOc4 = rs.getString(23);
			Date dtMod = rs.getDate(24);
			String usuario = rs.getString(25);
			
			orcamento = new OrcamentoSub(idOrc, idLoja, cdEntidade, idEntrega, idColaborador, dtOrc, dtEntrega, pessoaResponsavel, vlOrc,
					prazoValidade, vlDesc, observacao, status, vlAprov, dtAprov, idOrdemServico, cdCondPagto, prazoEntrega, prazoGarantia, 
					cmpOc1, cmpOc2, cmpOc3, cmpOc4, dtMod, usuario); 

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
		List<OrcamentoSub> list = null;

		try {
			String sql = "SELECT o.idOrcamento, o.idLoja, o.cdEntidade, o.idEntrega, o.idColaborador, o.dtOrc, o.dtEntrega, o.pessoaResponsavel, " +
						" o.vlOrc, o.prazoValidade, o.vlDesc, o.observacao, o.status, o.vlAprov, o.dtAprov, o.idOrdemServico, o.cdCondPagto, " +
						" o.prazoEntrega, o.prazoGarantia, o.cmpOc1, o.cmpOc2, o.cmpOc3, o.cmpOc4, o.dtMod, o.usuario " +
						"from tborcamento o JOIN tbentidade e on (o.cdEntidade = e.cdEntidade) ";
			if (clausula != null)
				sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<OrcamentoSub>();
			while (rs.next()) {

				int idOrc = rs.getInt(1);
				int idLoja = rs.getInt(2);
				int cdEntidade = rs.getInt(3);
				int idEntrega = rs.getInt(4);
				int idColaborador = rs.getInt(5);
				Date dtOrc = rs.getDate(6);
				Date dtEntrega = rs.getDate(7);
				String pessoaResponsavel = rs.getString(8);
				double vlOrc = rs.getDouble(9);
				int prazoValidade = rs.getInt(10);
				float vlDesc = rs.getFloat(11);
				String observacao = rs.getString(12);
				String status = rs.getString(13);
				double vlAprov = rs.getDouble(14);
				Date dtAprov = rs.getDate(15);
				int idOrdemServico = rs.getInt(16);
				int cdCondPagto = rs.getInt(17);
				int prazoEntrega = rs.getInt(18);
				int prazoGarantia = rs.getInt(19);
				String cmpOc1 = rs.getString(20);
				String cmpOc2 = rs.getString(21);
				String cmpOc3 = rs.getString(22);
				String cmpOc4 = rs.getString(23);
				Date dtMod = rs.getDate(24);
				String usuario = rs.getString(25);


				list.add(new OrcamentoSub(idOrc, idLoja, cdEntidade, idEntrega, idColaborador, dtOrc, dtEntrega, pessoaResponsavel, vlOrc,
						prazoValidade, vlDesc, observacao, status, vlAprov, dtAprov, idOrdemServico, cdCondPagto, prazoEntrega, prazoGarantia, 
						cmpOc1, cmpOc2, cmpOc3, cmpOc4, dtMod, usuario));
				
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}


	public void aprovarOrcamento(OrcamentoSub orcamento) throws AferoDAOException {
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

}
