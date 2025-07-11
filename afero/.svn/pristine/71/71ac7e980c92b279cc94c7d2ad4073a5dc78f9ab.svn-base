package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import afero.model.MapaEntregaBairro;
import afero.model.PedidoSaidaSub;
import afero.model.MapaEntregaData;
import afero.util.ConverteDate;

public class PedidoSaidaSubDAO{

	private Connection conn;
	
    public PedidoSaidaSubDAO(Connection conn) {
		this.conn = conn;		
    }
	
	public void incluir(PedidoSaidaSub pedidoSaida) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (pedidoSaida == null)
			throw new AferoDAOException(
					"O valor passado nï¿½o pode ser nulo");

		try {
			String sql = "";
			if(pedidoSaida.getCdCondPagto() != 0){
			  sql = "INSERT INTO tbpedidosaida( idLoja, cdEntidade, idColaborador, idEntrega, dtPed, dtEntrega, hrEntrega, pessoaResponsavel," +
						" operacao, vlDesc, vlPed, vlFrete, observacao, anotacao, status, dtMov, impPedido, dtInicio, dtConclusao, dtEntRealizada, cdCondPagto, " +
						" dtMod, usuario )" +
						" VALUES (?, ?, ?, ?, now(), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now(), ?)";
			}else{
				sql = "INSERT INTO tbpedidosaida( idLoja, cdEntidade, idColaborador, idEntrega, dtPed, dtEntrega, hrEntrega, pessoaResponsavel," +
				" operacao, vlDesc, vlPed, vlFrete, observacao, anotacao, status, dtMov, impPedido, dtInicio, dtConclusao, dtEntRealizada, " +
				" dtMod, usuario )" +
				" VALUES (?, ?, ?, ?, now(), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now(), ?)";
			}
			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			
			ps.setInt(1, pedidoSaida.getIdLoja());
			ps.setInt(2, pedidoSaida.getCdEntidade());
			ps.setInt(3, pedidoSaida.getIdColaborador());
			ps.setInt(4, pedidoSaida.getIdEntrega());
			//if(pedidoSaida.getDtPed() != null){
				//ps.setDate(5, ConverteDate.DateToDateSql(pedidoSaida.getDtPed()));
			//}else{
				//ps.setDate(5, null);
		//	}
			if(pedidoSaida.getDtEntrega() != null){
				ps.setDate(5, ConverteDate.DateToDateSql(pedidoSaida.getDtEntrega()));
			}else{
				ps.setDate(5, null);
			}
			ps.setString(6, pedidoSaida.getHrEntrega());
			ps.setString(7, pedidoSaida.getPessoaResponsavel());
			ps.setString(8, pedidoSaida.getOperacao());
			ps.setFloat(9, pedidoSaida.getVlDesc());
			ps.setDouble(10, pedidoSaida.getVlPed());
			ps.setFloat(11, pedidoSaida.getVlFrete());
			ps.setString(12, pedidoSaida.getObservacao());
			ps.setString(13, pedidoSaida.getAnotacao());
			ps.setString(14, pedidoSaida.getStatus());
			if(pedidoSaida.getDtMov() != null){
				ps.setDate(15, ConverteDate.DateToDateSql(pedidoSaida.getDtMov()));
			}else{
				ps.setDate(15, null);
			}
			ps.setString(16, pedidoSaida.getImpPedido());
			if(pedidoSaida.getDtInicio() != null){
				ps.setDate(17, ConverteDate.DateToDateSql(pedidoSaida.getDtInicio()));
			}else{
				ps.setDate(17, null);
			}
			if(pedidoSaida.getDtConclusao() != null){
				ps.setDate(18, ConverteDate.DateToDateSql(pedidoSaida.getDtConclusao()));
			}else{
				ps.setDate(18, null);
			}
			if(pedidoSaida.getDtEntRealizada() != null){
				ps.setDate(19, ConverteDate.DateToDateSql(pedidoSaida.getDtEntRealizada()));
			}else{
				ps.setDate(19, null);
			}
			//if(pedidoSaida.getIdOrdemServico() != 0){
				//ps.setInt(20, pedidoSaida.getIdOrdemServico());
			//}else{
				//ps.setNull(20, (Integer) null);
		//	}
			if(pedidoSaida.getCdCondPagto() != 0){
				ps.setInt(20, pedidoSaida.getCdCondPagto());
				ps.setString(21, pedidoSaida.getUsuario());
			}else{
				ps.setString(20, pedidoSaida.getUsuario());
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
	
	public void incluirDesconto(PedidoSaidaSub pedidoSaida) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (pedidoSaida == null)
			throw new AferoDAOException(
					"O valor passado nï¿½o pode ser nulo");

		try {
			String sql = "INSERT INTO tbpedidosaida(idLoja, cdEntidade, idColaborador, idEntrega, operacao, dtPed, "+
			             "vlDesc, vlPed, observacao, anotacao, status, dtMod, usuario, dtEntrega, hrEntrega, dtMov, pessoaResponsavel, cdCondPagto) " +
			             "VALUES(?, ?, ?, ?, ?, now(), ?, ?, ?, ?, ?, now(), ?, ?, ?, now(), ?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, pedidoSaida.getIdLoja());
			ps.setInt(2, pedidoSaida.getCdEntidade());
			ps.setInt(3, pedidoSaida.getIdColaborador());
			ps.setInt(4, pedidoSaida.getIdEntrega());
			ps.setString(5, pedidoSaida.getOperacao());
			ps.setFloat(6, pedidoSaida.getVlDesc());
			ps.setDouble(7, pedidoSaida.getVlPed());
			ps.setString(8, pedidoSaida.getObservacao());
			ps.setString(9, pedidoSaida.getAnotacao());
			ps.setString(10, pedidoSaida.getStatus());
			ps.setString(11, pedidoSaida.getUsuario());
			if(pedidoSaida.getDtEntrega() != null){
				ps.setDate(12, ConverteDate.DateToDateSql(pedidoSaida.getDtEntrega()));
			}else{
				ps.setDate(12, null);
			}
			ps.setString(13, pedidoSaida.getHrEntrega());
			ps.setString(14, pedidoSaida.getPessoaResponsavel());
			ps.setInt(15, pedidoSaida.getCdCondPagto());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(PedidoSaidaSub pedidoSaida) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (pedidoSaida == null)
			throw new AferoDAOException("O valor passado nï¿½o pode ser nulo");

		try {		
			String sql = "UPDATE tbpedidosaida set idLoja = ?, cdEntidade = ?, idColaborador = ?, idEntrega = ?, dtEntrega = ?, " +
						" hrEntrega = ?, pessoaResponsavel = ?, operacao = ?, vlDesc = ?, vlPed = ?, observacao = ?, anotacao = ?, status = ?, " +
						" dtMov = ?, impPedido = ?, dtInicio = ?, dtConclusao = ?, dtEntRealizada = ?, cdCondPagto = ?, dtMod = now(), usuario = ? " +
            			" WHERE idPedidoSaida = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, pedidoSaida.getIdLoja());
			ps.setInt(2, pedidoSaida.getCdEntidade());
			ps.setInt(3, pedidoSaida.getIdColaborador());
			ps.setInt(4, pedidoSaida.getIdEntrega());
			//if(pedidoSaida.getDtPed() != null){
				//ps.setDate(5, ConverteDate.DateToDateSql(pedidoSaida.getDtPed()));
			//}else{
				//ps.setDate(5, null);
			//}
			if(pedidoSaida.getDtEntrega() != null){
				ps.setDate(5, ConverteDate.DateToDateSql(pedidoSaida.getDtEntrega()));
			}else{
				ps.setDate(5, null);
			}
			ps.setString(6, pedidoSaida.getHrEntrega());
			ps.setString(7, pedidoSaida.getPessoaResponsavel());
			ps.setString(8, pedidoSaida.getOperacao());
			ps.setFloat(9, pedidoSaida.getVlDesc());
			ps.setDouble(10, pedidoSaida.getVlPed());
			ps.setString(11, pedidoSaida.getObservacao());
			ps.setString(12, pedidoSaida.getAnotacao());
			ps.setString(13, pedidoSaida.getStatus());
			if(pedidoSaida.getDtMov() != null){
				ps.setDate(14, ConverteDate.DateToDateSql(pedidoSaida.getDtMov()));
			}else{
				ps.setDate(14, null);
			}
			ps.setString(15, pedidoSaida.getImpPedido());
			if(pedidoSaida.getDtInicio() != null){
				ps.setDate(16, ConverteDate.DateToDateSql(pedidoSaida.getDtInicio()));
			}else{
				ps.setDate(16, null);
			}
			if(pedidoSaida.getDtConclusao() != null){
				ps.setDate(17, ConverteDate.DateToDateSql(pedidoSaida.getDtConclusao()));
			}else{
				ps.setDate(17, null);
			}
			if(pedidoSaida.getDtEntRealizada() != null){
				ps.setDate(18, ConverteDate.DateToDateSql(pedidoSaida.getDtEntRealizada()));
			}else{
				ps.setDate(18, null);
			}
			//ps.setInt(20, pedidoSaida.getIdOrdemServico());
			ps.setInt(19, pedidoSaida.getCdCondPagto());
			ps.setString(20, pedidoSaida.getUsuario());
			ps.setInt(21, pedidoSaida.getIdPedidoSaida());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}
	
	public void atualizarCabecalho(PedidoSaidaSub pedidoSaida) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (pedidoSaida == null)
			throw new AferoDAOException("O valor passado nï¿½o pode ser nulo");

		try {		
			String sql = "UPDATE tbpedidosaida set idLoja = ?, cdEntidade = ?, idColaborador = ?, idEntrega = ?, operacao = ?, "+
                         "observacao = ?, anotacao = ?, status = ?, dtMod = now(), usuario = ?, dtEntrega = ?, hrEntrega = ?, "+
                         "pessoaResponsavel = ?, vlFrete = ? "+
            			 "WHERE idPedidoSaida = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, pedidoSaida.getIdLoja());
			ps.setInt(2, pedidoSaida.getCdEntidade());
			ps.setInt(3, pedidoSaida.getIdColaborador());
			ps.setInt(4, pedidoSaida.getIdEntrega());
			ps.setString(5, pedidoSaida.getOperacao());
			ps.setString(6, pedidoSaida.getObservacao());
			ps.setString(7, pedidoSaida.getAnotacao());
			ps.setString(8, pedidoSaida.getStatus());
			ps.setString(9, pedidoSaida.getUsuario());
			ps.setDate(10, ConverteDate.DateToDateSql(pedidoSaida.getDtEntrega()));
			ps.setString(11, pedidoSaida.getHrEntrega());
			ps.setString(12, pedidoSaida.getPessoaResponsavel());
			ps.setFloat(13, pedidoSaida.getVlFrete());
			ps.setInt(14, pedidoSaida.getIdPedidoSaida());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void excluir(PedidoSaidaSub pedidoSaida) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;		
		if (pedidoSaida == null)
			throw new AferoDAOException(
					"O valor passado nï¿½o pode ser nulo");

		try {			
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbpedidoSaida WHERE idPedidoSaida=?");
			ps.setInt(1, pedidoSaida.getIdPedidoSaida());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public PedidoSaidaSub procurarPedidoSaida(int idPedidoSaida) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		PedidoSaidaSub pedidoSaida = null;
		
		try {
			String sql = "SELECT idPedidoSaida, idLoja, cdEntidade, idColaborador, idEntrega, dtPed, dtEntrega, hrEntrega, pessoaResponsavel," +
						" operacao, vlDesc, vlPed, observacao, anotacao, status, dtMov, impPedido, dtInicio, dtConclusao, dtEntRealizada, " +
						" idOrdemServico, cdCondPagto, dtMod, usuario " +
					    " FROM tbpedidosaida " +
					    " WHERE idPedidoSaida = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idPedidoSaida);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Nï¿½o foi encontrado nenhum "
						+ "registro com o cï¿½digo: " +idPedidoSaida);
			}
			int idPedSaida = rs.getInt(1);
			int idLoja = rs.getInt(2);
		    int cdEntidade = rs.getInt(3);
			int idColaborador = rs.getInt(4);
			int idEntrega = rs.getInt(5);
			Date dtPed = rs.getDate(6);
			Date dtEntrega = rs.getDate(7);
			String hrEntrega = rs.getString(8);
			String pessoaResponsavel = rs.getString(9);
			String operacao = rs.getString(10);
			float vlDesc = rs.getFloat(11);
			double vlPed = rs.getDouble(12);
		    String observacao = rs.getString(13);
		    String anotacao = rs.getString(14);
		    String status = rs.getString(15);
		    Date dtMov = rs.getDate(16);
		    String impPedido = rs.getString(17);
		    Date dtInicio = rs.getDate(18);
		    Date dtConclusao = rs.getDate(19);
		    Date dtEntRealizada = rs.getDate(20);
		    int idOrdemServico = rs.getInt(21);
		    int cdCondPagto = rs.getInt(22);
		    Date dtMod = rs.getDate(23);
		    String usuario = rs.getString(24);
		    
		    pedidoSaida = new PedidoSaidaSub(idPedSaida, idLoja, cdEntidade, idColaborador, idEntrega, dtPed, dtEntrega, hrEntrega, pessoaResponsavel,
		    		operacao, vlDesc, vlPed, observacao, anotacao, status, dtMov, impPedido, dtInicio, dtConclusao, dtEntRealizada, idOrdemServico,
		    		cdCondPagto, dtMod, usuario);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return pedidoSaida;
	}
	
	public PedidoSaidaSub procurarPedidoSaidaItem(int idPedidoSaida) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		PedidoSaidaSub pedidoSaida = null;
		
		try {
			String sql = "SELECT idPedidoSaida, idLoja, cdEntidade, idColaborador, idEntrega, dtPed, dtEntrega, hrEntrega, pessoaResponsavel, " +
						"operacao, vlDesc, vlPed, observacao, anotacao, status, dtMov, impPedido, dtInicio, dtConclusao, dtEntRealizada, " +
						"idOrdemServico, cdCondPagto, dtMod, usuario, vlFrete " +
					    "FROM tbpedidosaida " +
					    "WHERE idPedidoSaida = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idPedidoSaida);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Nï¿½o foi encontrado nenhum "
						+ "registro com o cï¿½digo: " +idPedidoSaida);
			}
			int idPedSaida = rs.getInt(1);
			int idLoja = rs.getInt(2);
		    int cdEntidade = rs.getInt(3);
			int idColaborador = rs.getInt(4);
			int idEntrega = rs.getInt(5);
			Date dtPed = rs.getDate(6);
			Date dtEntrega = rs.getDate(7);
			String hrEntrega = rs.getString(8);
			String pessoaResponsavel = rs.getString(9);
			String operacao = rs.getString(10);
			float vlDesc = rs.getFloat(11);
			double vlPed = rs.getDouble(12);
		    String observacao = rs.getString(13);
		    String anotacao = rs.getString(14);
		    String status = rs.getString(15);
		    Date dtMov = rs.getDate(16);
		    String impPedido = rs.getString(17);
		    Date dtInicio = rs.getDate(18);
		    Date dtConclusao = rs.getDate(19);
		    Date dtEntRealizada = rs.getDate(20);
		    int idOrdemServico = rs.getInt(21);
		    int cdCondPagto = rs.getInt(22);
		    Date dtMod = rs.getDate(23);
		    String usuario = rs.getString(24);
		    float vlFrete = rs.getFloat(25);
		    
		    pedidoSaida = new PedidoSaidaSub(idPedSaida, idLoja, cdEntidade, idColaborador, idEntrega, dtPed, dtEntrega, hrEntrega, pessoaResponsavel,
		    		operacao, vlDesc, vlPed, observacao, anotacao, status, dtMov, impPedido, dtInicio, dtConclusao, dtEntRealizada, idOrdemServico,
		    		cdCondPagto, dtMod, usuario, vlFrete);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return pedidoSaida;
	}

	public List listarPedidoSaida(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<PedidoSaidaSub> list = null;
		
		try {
			String sql = "SELECT ps.idPedidoSaida, ps.idLoja, ps.cdEntidade, ps.idColaborador, ps.idEntrega, ps.dtPed, ps.dtEntrega, ps.hrEntrega," +
						" ps.pessoaResponsavel, ps.operacao, ps.vlDesc, ps.vlPed, ps.observacao, ps.anotacao, ps.status, ps.dtMov, ps.impPedido," +
						" ps.dtInicio, ps.dtConclusao, ps.dtEntRealizada, ps.idOrdemServico, ps.cdCondPagto, ps.dtMod, ps.usuario " +
						" FROM tbpedidosaida ps " +
						" JOIN tbentidade e on (ps.cdEntidade = e.cdEntidade) ";
			
			if (clausula != null) sql = sql + clausula;			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<PedidoSaidaSub>();
			while (rs.next()) {

					int idPedSaida = rs.getInt(1);
					int idLoja = rs.getInt(2);
				    int cdEntidade = rs.getInt(3);
					int idColaborador = rs.getInt(4);
					int idEntrega = rs.getInt(5);
					Date dtPed = rs.getDate(6);
					Date dtEntrega = rs.getDate(7);
					String hrEntrega = rs.getString(8);
					String pessoaResponsavel = rs.getString(9);
					String operacao = rs.getString(10);
					float vlDesc = rs.getFloat(11);
					double vlPed = rs.getDouble(12);
				    String observacao = rs.getString(13);
				    String anotacao = rs.getString(14);
				    String status = rs.getString(15);
				    Date dtMov = rs.getDate(16);
				    String impPedido = rs.getString(17);
				    Date dtInicio = rs.getDate(18);
				    Date dtConclusao = rs.getDate(19);
				    Date dtEntRealizada = rs.getDate(20);
				    int idOrdemServico = rs.getInt(21);
				    int cdCondPagto = rs.getInt(22);
				    Date dtMod = rs.getDate(23);
				    String usuario = rs.getString(24);
				    
				    list.add(new PedidoSaidaSub(idPedSaida, idLoja, cdEntidade, idColaborador, idEntrega, dtPed, dtEntrega, hrEntrega, pessoaResponsavel,
				    		operacao, vlDesc, vlPed, observacao, anotacao, status, dtMov, impPedido, dtInicio, dtConclusao, dtEntRealizada, idOrdemServico,
				    		cdCondPagto, dtMod, usuario));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	
	public int idPedidoSaida() throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		int numPedidoSaida = 0;
		
		try {
			String sql = "select max(idPedidoSaida) from tbpedidosaida order by idPedidoSaida DESC LIMIT 1";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if (rs.next()) {
				numPedidoSaida = rs.getInt(1);
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return numPedidoSaida;
	}
	
	public boolean respPedidoSaida(int idOrcamento) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = true;
		
		try {
			String sql = "select ops.idPedidoSaida " +  
			             "from tborcamentopedidosaida ops "+
	                     "where ops.idOrcamento= ? limit 1";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idOrcamento);
			rs = ps.executeQuery();
			if(rs.next()) {
				ok = true;
			}else{
				ok=false;
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return ok;
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

	public int getIdOrcamento(int id) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		int idOrcamento = 0;
		
		try {
			String sql = "select o.idOrcamento " +
                                 "from tbpedidosaida p " +
                                 "join tborcamentopedidosaida op on (p.idPedidoSaida = op.idPedidoSaida) "+
                                 "join tborcamento o on (op.idOrcamento = o.idOrcamento) "+
                                 "where p.idPedidoSaida = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, id);
			rs = ps.executeQuery();
			if (rs.next()) {
				idOrcamento = rs.getInt(1);
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return idOrcamento;
	}

	public boolean confirmarPedido(int idPedidoSaida) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = true;
		
		try {
			String sql = "select p.idPedidoSaida "+ 
                                 "from tbordemservico os "+
                                 "join tborcamento o on (os.idOrcamento = o.idOrcamento) "+
                                 "join tborcamentopedidosaida op on (o.idOrcamento = op.idOrcamento) "+
                                 "join tbpedidosaida p on (op.idPedidoSaida = p.idPedidoSaida) "+
                                 "where p.idPedidoSaida = ? and os.status='A'"; 
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idPedidoSaida);
			rs = ps.executeQuery();
			if(rs.next()) {
				ok = true;
			} else {
				ok=false;
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return ok;
	}
	
	public List listarMapaEntragaData(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<MapaEntregaData> list = null;
		
		try {
			String sql = "select ps.dtEntrega, ps.hrEntrega, count(ps.idEntrega) as quantidade "+
                         "from tbpedidosaida ps ";
 
			if (clausula != null) sql = sql + clausula;			
			conn = this.conn; 
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<MapaEntregaData>();
			while (rs.next()) {
				Date dtEntrega = rs.getDate(1);
				String hrEntrega = rs.getString(2);
				int quantidade = rs.getInt(3);
				list.add(new MapaEntregaData(dtEntrega, hrEntrega, quantidade));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	
	public List listarMapaEntragaBairro(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<MapaEntregaBairro> list = null;
		
		try {
			String sql = "select e.dsEntrega, count(ps.idEntrega) as quantidade "+ 
                         "from tbpedidosaida ps "+
                         "Join tbentrega e on e.idEntrega = ps.idEntrega ";
                        
 
			if (clausula != null) sql = sql + clausula;			
			conn = this.conn; 
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<MapaEntregaBairro>();
			while (rs.next()) {
				String dsEntrega = rs.getString(1);
				int quantidade = rs.getInt(2);
				list.add(new MapaEntregaBairro(dsEntrega, quantidade));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	public List listarPedidoSaidaMapaPedido(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<PedidoSaidaSub> list = null;
		
		try {
			String sql = "SELECT ps.idPedidoSaida, ps.idLoja, ps.cdEntidade, ps.idColaborador, ps.idEntrega, ps.dtPed, ps.dtEntrega, ps.hrEntrega," +
							" ps.pessoaResponsavel, ps.operacao, ps.vlDesc, ps.vlPed, ps.observacao, ps.anotacao, ps.status, ps.dtMov, ps.impPedido," +
							" ps.dtInicio, ps.dtConclusao, ps.dtEntRealizada, ps.idOrdemServico, ps.cdCondPagto, ps.dtMod, ps.usuario )" +
							" FROM tbpedidosaida ps JOIN tbentidade e ON (ps.cdEntidade = e.cdEntidade) " +
							" JOIN tbentrega en ON (ps.idEntrega = en.idEntrega) ";
				
				if (clausula != null) sql = sql + clausula;			
				conn = this.conn;
				ps = conn.prepareStatement(sql);
				rs = ps.executeQuery();
				list = new ArrayList<PedidoSaidaSub>();
				while (rs.next()) {

						int idPedSaida = rs.getInt(1);
						int idLoja = rs.getInt(2);
					    int cdEntidade = rs.getInt(3);
						int idColaborador = rs.getInt(4);
						int idEntrega = rs.getInt(5);
						Date dtPed = rs.getDate(6);
						Date dtEntrega = rs.getDate(7);
						String hrEntrega = rs.getString(8);
						String pessoaResponsavel = rs.getString(9);
						String operacao = rs.getString(10);
						float vlDesc = rs.getFloat(11);
						double vlPed = rs.getDouble(12);
					    String observacao = rs.getString(13);
					    String anotacao = rs.getString(14);
					    String status = rs.getString(15);
					    Date dtMov = rs.getDate(16);
					    String impPedido = rs.getString(17);
					    Date dtInicio = rs.getDate(18);
					    Date dtConclusao = rs.getDate(19);
					    Date dtEntRealizada = rs.getDate(20);
					    int idOrdemServico = rs.getInt(21);
					    int cdCondPagto = rs.getInt(22);
					    Date dtMod = rs.getDate(23);
					    String usuario = rs.getString(24);
					    
					    list.add(new PedidoSaidaSub(idPedSaida, idLoja, cdEntidade, idColaborador, idEntrega, dtPed, dtEntrega, hrEntrega, pessoaResponsavel,
					    		operacao, vlDesc, vlPed, observacao, anotacao, status, dtMov, impPedido, dtInicio, dtConclusao, dtEntRealizada, idOrdemServico,
					    		cdCondPagto, dtMod, usuario));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	
	public void atualizarImpressaoPedido(int idPedidoSaida) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;		
		if (idPedidoSaida == 0)
			throw new AferoDAOException(
					"O valor passado nï¿½o pode ser nulo");

		try {			
			conn = this.conn;
			ps = conn.prepareStatement("UPDATE tbpedidosaida set impPedido= ? where idPedidoSaida=?");
			ps.setString(1, "S");
			ps.setInt(2, idPedidoSaida);
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}
	public void atualizarMesaPedido(int idPedidoSaida, int idMesa) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;		
		if (idPedidoSaida == 0)
			throw new AferoDAOException(
					"O valor passado nï¿½o pode ser nulo");

		try {			
			conn = this.conn;
			ps = conn.prepareStatement("UPDATE tbpedidosaida set idMesa= ? where idPedidoSaida=?");
			ps.setInt(1, idMesa);
			ps.setInt(2, idPedidoSaida);
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados:" + sqle);

		}

	}

	public void atualizarStatusPag(int idPedidoSaida, String statusPag) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;		
		if (idPedidoSaida == 0)
			throw new AferoDAOException(
					"O valor passado nï¿½o pode ser nulo");

		try {			
			conn = this.conn;
			if(statusPag.equalsIgnoreCase("P")){
				ps = conn.prepareStatement("UPDATE tbpedidosaida set statusPag = ?, dtPag=now() where idPedidoSaida=?");
			}else{
				ps = conn.prepareStatement("UPDATE tbpedidosaida set statusPag = ? where idPedidoSaida=?");
			}
			
			ps.setString(1, statusPag);
			ps.setInt(2, idPedidoSaida);
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} 

	}
	
	public void atualizarAnotacao(int idPedidoSaida, String anotacao) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;		
		if (idPedidoSaida == 0)
			throw new AferoDAOException(
					"O valor passado nï¿½o pode ser nulo");

		try {			
			conn = this.conn;
			ps = conn.prepareStatement("UPDATE tbpedidosaida set anotacao = ? where idPedidoSaida=?");
			ps.setString(1, anotacao);
			ps.setInt(2, idPedidoSaida);
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}
	
	public void atualizarObservacao(int idPedidoSaida, String observacao) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;		
		if (idPedidoSaida == 0)
			throw new AferoDAOException(
					"O valor passado nï¿½o pode ser nulo");

		try {			
			conn = this.conn;
			ps = conn.prepareStatement("UPDATE tbpedidosaida set observacao = ? where idPedidoSaida=?");
			ps.setString(1, observacao);
			ps.setInt(2, idPedidoSaida);
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}
	
	public void atualizarVlFrete(int idPedidoSaida, float vlFrete) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;		
		if (idPedidoSaida == 0)
			throw new AferoDAOException(
					"O valor passado nï¿½o pode ser nulo");

		try {			
			conn = this.conn;
			ps = conn.prepareStatement("UPDATE tbpedidosaida set vlFrete = ? where idPedidoSaida=?");
			ps.setFloat(1, vlFrete);
			ps.setInt(2, idPedidoSaida);
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}
	
	public void atualizarTipoPedido(int idPedidoSaida, String tipoPedido) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;		
		if (idPedidoSaida == 0)
			throw new AferoDAOException(
					"O valor passado nï¿½o pode ser nulo");

		try {			
			conn = this.conn;
			ps = conn.prepareStatement("UPDATE tbpedidoSaida set tipoPedido = ? where idPedidoSaida=?");
			ps.setString(1, tipoPedido);
			ps.setInt(2, idPedidoSaida);
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}
	public String statusPag(int idPedidoSaida) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		String statusPag = null;
		
		try {
			String sql = "select statusPag from tbpedidosaida where idPedidoSaida = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idPedidoSaida);
			rs = ps.executeQuery();
			if (rs.next()) {
				statusPag = rs.getString(1);
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return statusPag;
	}
	public String tipoPedido(int idPedidoSaida) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		String tipoPedido = null;
		
		try {
			String sql = "select tipoPedido from tbpedidosaida where idPedidoSaida = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idPedidoSaida);
			rs = ps.executeQuery();
			if (rs.next()) {
				tipoPedido = rs.getString(1);
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return tipoPedido;
	}
	public String statusImpressao(int idPedidoSaida) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		String statusImpressao = "";
		
		try {
			String sql = "select impPedido from tbpedidosaida where idPedidoSaida = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idPedidoSaida);
			rs = ps.executeQuery();
			if (rs.next()) {
				statusImpressao =rs.getString(1);
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return statusImpressao;
	}
	
	public void atualizarCondPagto(int idPedidoSaida, int cdCondPagto) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;		
		if (idPedidoSaida == 0)
			throw new AferoDAOException(
					"O valor passado nï¿½o pode ser nulo");

		try {			
			conn = this.conn;
			ps = conn.prepareStatement("UPDATE tbpedidoSaida set cdCondPagto = ? where idPedidoSaida=?");
			ps.setInt(1, cdCondPagto);
			ps.setInt(2, idPedidoSaida);
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}
	
	public float mostrarVlFrete(int idPedidoSaida) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		float vlFrete = 0;
		
		try {
			String sql = "select vlFrete from tbpedidosaida where idPedidoSaida = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idPedidoSaida);
			rs = ps.executeQuery();
			if (rs.next()) {
				vlFrete = rs.getFloat(1);
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return vlFrete;
	}
	public PedidoSaidaSub procurarMesa(int idMesa) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		PedidoSaidaSub pedidoSaida = null;
		
		try {
			String sql = "SELECT p.idPedidoSaida, p.idLoja, p.cdEntidade, p.idColaborador, p.idEntrega, p.dtPed, p.dtEntrega, p.hrEntrega, p.pessoaResponsavel, "+
			             "p.operacao, p.vlDesc, p.vlPed, p.observacao, p.anotacao, p.status, p.dtMov, p.impPedido, p.dtInicio, p.dtConclusao, p.dtEntRealizada, "+ 
			             "p.idOrdemServico, p.cdCondPagto, p.dtMod, p.usuario "+ 
		                 "FROM tbpedidosaida p "+
			             "JOIN tbmesa m on p.idMesa = m.idMesa "+  
                         "WHERE m.status in ('A','C') AND m.idMesa = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idMesa);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " +idMesa);
			}
			int idPedSaida = rs.getInt(1);
			int idLoja = rs.getInt(2);
		    int cdEntidade = rs.getInt(3);
			int idColaborador = rs.getInt(4);
			int idEntrega = rs.getInt(5);
			Date dtPed = rs.getDate(6);
			Date dtEntrega = rs.getDate(7);
			String hrEntrega = rs.getString(8);
			String pessoaResponsavel = rs.getString(9);
			String operacao = rs.getString(10);
			float vlDesc = rs.getFloat(11);
			double vlPed = rs.getDouble(12);
		    String observacao = rs.getString(13);
		    String anotacao = rs.getString(14);
		    String status = rs.getString(15);
		    Date dtMov = rs.getDate(16);
		    String impPedido = rs.getString(17);
		    Date dtInicio = rs.getDate(18);
		    Date dtConclusao = rs.getDate(19);
		    Date dtEntRealizada = rs.getDate(20);
		    int idOrdemServico = rs.getInt(21);
		    int cdCondPagto = rs.getInt(22);
		    Date dtMod = rs.getDate(23);
		    String usuario = rs.getString(24);
		    
		    pedidoSaida = new PedidoSaidaSub(idPedSaida, idLoja, cdEntidade, idColaborador, idEntrega, dtPed, dtEntrega, hrEntrega, pessoaResponsavel,
		    		operacao, vlDesc, vlPed, observacao, anotacao, status, dtMov, impPedido, dtInicio, dtConclusao, dtEntRealizada, idOrdemServico,
		    		cdCondPagto, dtMod, usuario);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		}
		return pedidoSaida;
	}
	
	public void atualizarEntregador(int idPedidoSaida, int idEntregador) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;		
		if (idPedidoSaida == 0)
			throw new AferoDAOException(
					"O valor passado nï¿½o pode ser nulo");

		try {			
			conn = this.conn;
			ps = conn.prepareStatement("UPDATE tbpedidoSaida set idEntregador = ? where idPedidoSaida=?");
			ps.setInt(1, idEntregador);
			ps.setInt(2, idPedidoSaida);
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		}

	}
	public void atualizarQuantPessoas(int idPedidoSaida, int quantPessoas) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;		
		if (idPedidoSaida == 0)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {			
			conn = this.conn;
			ps = conn.prepareStatement("UPDATE tbpedidoSaida set quantPessoas = ? where idPedidoSaida=?");
			ps.setInt(1, quantPessoas);
			ps.setInt(2, idPedidoSaida);
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		}

	}
	public int getQuantPessoas(int idPedidoSaida) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		int quantPessoas = 0;
		
		try {
			String sql = "select quantPessoas from tbpedidosaida where idPedidoSaida = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idPedidoSaida);
			rs = ps.executeQuery();
			if (rs.next()) {
				quantPessoas = rs.getInt(1);
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return quantPessoas;
	}

	public int getIdEntregador(int idPedidoSaida) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		int idEntregador = 0;
		
		try {
			String sql = "select idEntregador from tbpedidosaida where idPedidoSaida = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idPedidoSaida);
			rs = ps.executeQuery();
			if (rs.next()) {
				idEntregador = rs.getInt(1);
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return idEntregador;
	}

}
