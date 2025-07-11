package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;

import afero.model.OrdemServico;
import afero.model.Regiao;
import afero.util.ConverteDate;

public class OrdemServicoDAO {
	
	public Connection conn;

	public OrdemServicoDAO(Connection conn) {
		this.conn = conn;
	}
	
	// INSERIR	
	public void incluir(OrdemServico ordemServico) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (ordemServico == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");
		
		try {
			String sql = "INSERT INTO tbOrdemServico (idLoja, cdEntidade, idColaborador, cdTipoAtendimento, tipo, dtOrc, dtOS, dtAprov, dtEntrega," +
						" dtConclusao, pessoaResponsavel, dtInicio, dtEntRealizada, cdCondPagto, prazoEntrega, prazoValidade, prazoGarantia, cmpOS1," +
						" cmpOS2, cmpOS3, cmpOS4, observacao, vlServ, vlProd, vlFrete, vlDesc, status, dtMod, usuario )" +
						"VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now(), ?)";
			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, ordemServico.getIdLoja());
			ps.setInt(2, ordemServico.getCdEntidade());
			ps.setInt(3, ordemServico.getIdColaborador());
			ps.setInt(4, ordemServico.getCdTipoAtendimento());
			ps.setString(5, ordemServico.getTipo());
			if (ordemServico.getDtOrc() != null){
				ps.setDate(6, ConverteDate.DateToDateSql(ordemServico.getDtOrc()));				
			}else{
				ps.setDate(6, null);
			}
			if (ordemServico.getDtOS() != null){
				ps.setDate(7, ConverteDate.DateToDateSql(ordemServico.getDtOS()));				
			}else{
				ps.setDate(7, null);
			}
			if (ordemServico.getDtAprov() != null){
				ps.setDate(8, ConverteDate.DateToDateSql(ordemServico.getDtAprov()));				
			}else{
				ps.setDate(8, null);
			}			
			if (ordemServico.getDtEntrega() != null){
				ps.setDate(9, ConverteDate.DateToDateSql(ordemServico.getDtEntrega()));				
			}else{
				ps.setDate(9, null);
			}
			if (ordemServico.getDtConclusao() != null){
				ps.setDate(10, ConverteDate.DateToDateSql(ordemServico.getDtConclusao()));				
			}else{
				ps.setDate(10, null);
			}
			
			ps.setString(11, ordemServico.getPessoaResponsavel());
			
			if (ordemServico.getDtInicio() != null){
				ps.setDate(12, ConverteDate.DateToDateSql(ordemServico.getDtInicio()));				
			}else{
				ps.setDate(12, null);
			}
			if (ordemServico.getDtEntRealizada() != null){
				ps.setDate(13, ConverteDate.DateToDateSql(ordemServico.getDtEntRealizada()));				
			}else{
				ps.setDate(13, null);
			}
			
			ps.setInt(14, ordemServico.getCdCondPagto());
			ps.setInt(15, ordemServico.getPrazoEntrega());
			ps.setInt(16, ordemServico.getPrazoValidade());
			ps.setInt(17, ordemServico.getPrazoGarantia());
			ps.setString(18, ordemServico.getCmpOS1());
			ps.setString(19, ordemServico.getCmpOS2());
			ps.setString(20, ordemServico.getCmpOS3());
			ps.setString(21, ordemServico.getCmpOS4());
			ps.setString(22, ordemServico.getObservacao());
			ps.setDouble(23, ordemServico.getVlServ());
			ps.setDouble(24, ordemServico.getVlProd());
			ps.setDouble(25, ordemServico.getVlFrete());
			ps.setDouble(26, ordemServico.getVlDesc());
			ps.setString(27, ordemServico.getStatus());
			ps.setString(28, ordemServico.getUsuario());
			
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);
		}
	}

	// ATUALIZAR 
	public void atualiza(OrdemServico ordemServico) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (ordemServico == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");
		
		try {
			String sql = "UPDATE tbOrdemServico SET idLoja = ?, cdEntidade = ?, idColaborador = ?, cdTipoAtendimento = ?, tipo = ?," +
						" dtOrc = ?, dtOS = ?, dtAprov = ?, dtEntrega = ?, dtConclusao = ?, pessoaResponsavel = ?, dtInicio = ?, dtEntRealizada = ?," +
						" cdCondPagto = ?, prazoEntrega = ?, prazoValidade = ?, prazoGarantia = ?, cmpOS1 = ?, cmpOS2 = ?, cmpOS3 = ?, cmpOS4 = ?," +
						" observacao = ?, vlServ = ?, vlProd = ?, vlFrete = ?, vlDesc = ?, status = ?, dtMod = now(), usuario = ? " +
						" WHERE idOrdemServico = ?";
			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, ordemServico.getIdLoja());
			ps.setInt(2, ordemServico.getCdEntidade());
			ps.setInt(3, ordemServico.getIdColaborador());
			ps.setInt(4, ordemServico.getCdTipoAtendimento());
			ps.setString(5, ordemServico.getTipo());
			if (ordemServico.getDtOrc() != null){
				ps.setDate(6, ConverteDate.DateToDateSql(ordemServico.getDtOrc()));				
			}else{
				ps.setDate(6, null);
			}
			if (ordemServico.getDtOS() != null){
				ps.setDate(7, ConverteDate.DateToDateSql(ordemServico.getDtOS()));				
			}else{
				ps.setDate(7, null);
			}
			if (ordemServico.getDtAprov() != null){
				ps.setDate(8, ConverteDate.DateToDateSql(ordemServico.getDtAprov()));				
			}else{
				ps.setDate(8, null);
			}			
			if (ordemServico.getDtEntrega() != null){
				ps.setDate(9, ConverteDate.DateToDateSql(ordemServico.getDtEntrega()));				
			}else{
				ps.setDate(9, null);
			}
			if (ordemServico.getDtConclusao() != null){
				ps.setDate(10, ConverteDate.DateToDateSql(ordemServico.getDtConclusao()));				
			}else{
				ps.setDate(10, null);
			}
			
			ps.setString(11, ordemServico.getPessoaResponsavel());
			
			if (ordemServico.getDtInicio() != null){
				ps.setDate(12, ConverteDate.DateToDateSql(ordemServico.getDtInicio()));				
			}else{
				ps.setDate(12, null);
			}
			if (ordemServico.getDtEntRealizada() != null){
				ps.setDate(13, ConverteDate.DateToDateSql(ordemServico.getDtEntRealizada()));				
			}else{
				ps.setDate(13, null);
			}
			
			ps.setInt(14, ordemServico.getCdCondPagto());
			ps.setInt(15, ordemServico.getPrazoEntrega());
			ps.setInt(16, ordemServico.getPrazoValidade());
			ps.setInt(17, ordemServico.getPrazoGarantia());
			ps.setString(18, ordemServico.getCmpOS1());
			ps.setString(19, ordemServico.getCmpOS2());
			ps.setString(20, ordemServico.getCmpOS3());
			ps.setString(21, ordemServico.getCmpOS4());
			ps.setString(22, ordemServico.getObservacao());
			ps.setDouble(23, ordemServico.getVlServ());
			ps.setDouble(24, ordemServico.getVlProd());
			ps.setDouble(25, ordemServico.getVlFrete());
			ps.setDouble(26, ordemServico.getVlDesc());
			ps.setString(27, ordemServico.getStatus());
			ps.setString(28, ordemServico.getUsuario());
			ps.setInt(29, ordemServico.getIdOrdemServico());

			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao atualizar dados: " + e);
		} 
	}
	
	// EXCLUIR	
	public void excluir(OrdemServico ordemServico) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (ordemServico == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbOrdemServico WHERE idOrdemServico = ?");
			ps.setInt(1, ordemServico.getIdOrdemServico());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);
		}
	}
	
	// BUSCAR	
	public OrdemServico procurarOrdemServico (String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		OrdemServico ordemServico = null;
		
		try {
			String sql = "SELECT idOrdemServico, idLoja, cdEntidade, idColaborador, cdTipoAtendimento, tipo, dtOrc, dtOS, dtAprov, dtEntrega," +
						" dtConclusao, pessoaResponsavel, dtInicio, dtEntRealizada, cdCondPagto, prazoEntrega, prazoValidade, prazoGarantia, cmpOS1," +
						" cmpOS2, cmpOS3, cmpOS4, observacao, vlServ, vlProd, vlFrete, vlDesc, status, dtMod, usuario " +
						" FROM tbOrdemServico";
			
			if(clausula != null)
				sql += clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				
				int idOS = rs.getInt(1);
				int idLoja = rs.getInt(2);
				int cdEntidade = rs.getInt(3);
				int idColaborador = rs.getInt(4);
				int cdTipoAtendimento = rs.getInt(5);
				String tipo = rs.getString(6);
				Date dtOrc = rs.getDate(7);
				Date dtOS = rs.getDate(8);
				Date dtAprov = rs.getDate(9);
				Date dtEntrega = rs.getDate(10);
				Date dtConclusao = rs.getDate(11);
				String pessoaResponsavel = rs.getString(12);
				Date dtInicio = rs.getDate(13);
				Date dtEntRealizada = rs.getDate(14);
				int cdCondPagto = rs.getInt(15);
				int prazoEntrega = rs.getInt(16);
				int prazoValidade = rs.getInt(17);
				int prazoGarantia = rs.getInt(18);
				String cmpOS1 = rs.getString(19);
				String cmpOS2 = rs.getString(20);
				String cmpOS3 = rs.getString(21);
				String cmpOS4 = rs.getString(22);
				String observacao = rs.getString(23);
				double vlServ = rs.getDouble(24);
				double vlProd = rs.getDouble(25);
				float vlFrete = rs.getFloat(26);
				float vlDesc = rs.getFloat(27);
				String status = rs.getString(28);
				Date dtMod = rs.getDate(29);
				String usuario = rs.getString(30);
				
				ordemServico = new OrdemServico( idOS, idLoja, cdEntidade, idColaborador, cdTipoAtendimento, tipo, dtOrc, 
						dtOS, dtAprov, dtEntrega, pessoaResponsavel, dtInicio, dtConclusao, dtEntRealizada, cdCondPagto, prazoEntrega, prazoValidade,
						prazoGarantia, cmpOS1, cmpOS2, cmpOS3, cmpOS4, observacao, vlServ, vlProd, vlFrete, vlDesc, status, dtMod, usuario);
				
			}
		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao procurar dados:" + sqle);
		}catch (Exception e){
			throw new AferoDAOException ("Erro ao procurar dados:" + e);
		} 
		return ordemServico;
	}
	
	// LISTAR	
	public List<OrdemServico> listar(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<OrdemServico> list = null;

		try {
			String sql = " SELECT idOrdemServico, idLoja, cdEntidade, idColaborador, cdTipoAtendimento, tipo, dtOrc, dtOS, dtAprov, " +
						" dtEntrega, dtConclusao, pessoaResponsavel, dtInicio, dtEntRealizada, cdCondPagto, prazoEntrega, prazoValidade, " +
						" prazoGarantia, cmpOS1, cmpOS2, cmpOS3, cmpOS4, observacao, vlServ, vlProd, vlFrete, vlDesc, status, dtMod, usuario "+ 
						" FROM tbOrdemServico";
			
			if (clausula != null)
				sql += clausula;
			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<OrdemServico>();
			
			while (rs.next()){
				
				int idOS = rs.getInt(1);
				int idLoja = rs.getInt(2);
				int cdEntidade = rs.getInt(3);
				int idColaborador = rs.getInt(4);
				int cdTipoAtendimento = rs.getInt(5);
				String tipo = rs.getString(6);
				Date dtOrc = rs.getDate(7);
				Date dtOS = rs.getDate(8);
				Date dtAprov = rs.getDate(9);
				Date dtEntrega = rs.getDate(10);
				Date dtConclusao = rs.getDate(11);
				String pessoaResponsavel = rs.getString(12);
				Date dtInicio = rs.getDate(13);
				Date dtEntRealizada = rs.getDate(14);
				int cdCondPagto = rs.getInt(15);
				int prazoEntrega = rs.getInt(16);
				int prazoValidade = rs.getInt(17);
				int prazoGarantia = rs.getInt(18);
				String cmpOS1 = rs.getString(19);
				String cmpOS2 = rs.getString(20);
				String cmpOS3 = rs.getString(21);
				String cmpOS4 = rs.getString(22);
				String observacao = rs.getString(23);
				double vlServ = rs.getDouble(24);
				double vlProd = rs.getDouble(25);
				float vlFrete = rs.getFloat(26);
				float vlDesc = rs.getFloat(27);
				String status = rs.getString(28);
				Date dtMod = rs.getDate(29);
				String usuario = rs.getString(30);
				
				list.add( new OrdemServico( idOS, idLoja, cdEntidade, idColaborador, cdTipoAtendimento, tipo, dtOrc, 
						dtOS, dtAprov, dtEntrega, pessoaResponsavel, dtInicio, dtConclusao, dtEntRealizada, cdCondPagto, prazoEntrega, prazoValidade,
						prazoGarantia, cmpOS1, cmpOS2, cmpOS3, cmpOS4, observacao, vlServ, vlProd, vlFrete, vlDesc, status, dtMod, usuario));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao listar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao listar dados: " + e);
		} 
		return list;
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
		} 
		return dataAtual;
	}
	public int ultimoInsert() throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		int idUltimo = 0;

		try {
			String sql = " SELECT MAX(idOrdemServico) FROM tbOrdemServico ORDER BY idOrdemServico DESC ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if (rs.next()) {
				idUltimo = rs.getInt(1);
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return idUltimo;
	}
	public List<OrdemServico> listarOrdemServicoCliente(String clausula, String tpEntidade) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<OrdemServico> list = null;

		try {
			String sql = "";
			if(tpEntidade.equalsIgnoreCase("F")){
				sql += " SELECT distinct(o.idOrdemServico), o.idLoja, o.cdEntidade, o.idColaborador, o.cdTipoAtendimento, o.tipo, o.dtOrc, o.dtOS, o.dtAprov, "+ 
						 " o.dtEntrega, o.dtConclusao, o.pessoaResponsavel, o.dtInicio, o.dtEntRealizada, o.cdCondPagto, o.prazoEntrega, o.prazoValidade, "+
						 " o.prazoGarantia, o.cmpOS1, o.cmpOS2, o.cmpOS3, o.cmpOS4, o.observacao, o.vlServ, o.vlProd, o.vlFrete, o.vlDesc, o.status, o.dtMod, o.usuario "+ 
						 " FROM tbOrdemServico o "+
						 " JOIN tbEntidade e on o.cdEntidade = e.cdEntidade "+
						 " JOIN tbentidadefisica f on e.cdEntidade = f.cdEntidade "+
						 " JOIN tbentidadetelefone l on f.cdEntidade = l.cdEntidade ";
			}else{
				sql += " SELECT distinct(o.idOrdemServico), o.idLoja, o.cdEntidade, o.idColaborador, o.cdTipoAtendimento, o.tipo, o.dtOrc, o.dtOS, o.dtAprov, "+ 
				 " o.dtEntrega, o.dtConclusao, o.pessoaResponsavel, o.dtInicio, o.dtEntRealizada, o.cdCondPagto, o.prazoEntrega, o.prazoValidade, "+
				 " o.prazoGarantia, o.cmpOS1, o.cmpOS2, o.cmpOS3, o.cmpOS4, o.observacao, o.vlServ, o.vlProd, o.vlFrete, o.vlDesc, o.status, o.dtMod, o.usuario "+ 
				 " FROM tbOrdemServico o "+
				 " JOIN tbEntidade e on o.cdEntidade = e.cdEntidade "+
				 " JOIN tbentidadejuridica f on e.cdEntidade = f.cdEntidade "+
				 " JOIN tbentidadetelefone l on f.cdEntidade = l.cdEntidade ";
			}
			if (clausula != null)
				sql += clausula;
			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<OrdemServico>();
			
			while (rs.next()){
				
				int idOS = rs.getInt(1);
				int idLoja = rs.getInt(2);
				int cdEntidade = rs.getInt(3);
				int idColaborador = rs.getInt(4);
				int cdTipoAtendimento = rs.getInt(5);
				String tipo = rs.getString(6);
				Date dtOrc = rs.getDate(7);
				Date dtOS = rs.getDate(8);
				Date dtAprov = rs.getDate(9);
				Date dtEntrega = rs.getDate(10);
				Date dtConclusao = rs.getDate(11);
				String pessoaResponsavel = rs.getString(12);
				Date dtInicio = rs.getDate(13);
				Date dtEntRealizada = rs.getDate(14);
				int cdCondPagto = rs.getInt(15);
				int prazoEntrega = rs.getInt(16);
				int prazoValidade = rs.getInt(17);
				int prazoGarantia = rs.getInt(18);
				String cmpOS1 = rs.getString(19);
				String cmpOS2 = rs.getString(20);
				String cmpOS3 = rs.getString(21);
				String cmpOS4 = rs.getString(22);
				String observacao = rs.getString(23);
				double vlServ = rs.getDouble(24);
				double vlProd = rs.getDouble(25);
				float vlFrete = rs.getFloat(26);
				float vlDesc = rs.getFloat(27);
				String status = rs.getString(28);
				Date dtMod = rs.getDate(29);
				String usuario = rs.getString(30);
				
				list.add( new OrdemServico( idOS, idLoja, cdEntidade, idColaborador, cdTipoAtendimento, tipo, dtOrc, 
						dtOS, dtAprov, dtEntrega, pessoaResponsavel, dtInicio, dtConclusao, dtEntRealizada, cdCondPagto, prazoEntrega, prazoValidade,
						prazoGarantia, cmpOS1, cmpOS2, cmpOS3, cmpOS4, observacao, vlServ, vlProd, vlFrete, vlDesc, status, dtMod, usuario));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao listar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao listar dados: " + e);
		} 
		return list;
	}
	
	public float getTotalServicos(Integer idOrdemServico) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		float totalServico = 0;
		
		try {
			String sql = " SELECT sum(i.valor) "+
						 " FROM tbordemservico o "+
						 " JOIN tbordemservicoobjeto ob on o.idOrdemServico = ob.idOrdemServico "+
                         " JOIN tbordemservicoitem i on ob.idOrdemServicoObjeto = i.idOrdemServicoObjeto "+
                         " WHERE o.idOrdemServico = ? "; 
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idOrdemServico);
			rs = ps.executeQuery();
			if (rs.next()) {
				totalServico = rs.getFloat(1);
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return totalServico;
	}
	
	public float getTotalTarefas(Integer idOrdemServico) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		float totalTarefas = 0;
		
		try {
			String sql = " SELECT sum(f.valor * f.quant) "+
						 " FROM tbordemservico o "+
						 " JOIN tbordemservicoobjeto ob on o.idOrdemServico = ob.idOrdemServico "+
                         " JOIN tbordemservicoitem i on ob.idOrdemServicoObjeto = i.idOrdemServicoObjeto "+
                         " JOIN tbordemservicotarefa f on i.idOrdemServicoItem = f.idOrdemServicoItem "+
                         " WHERE o.idOrdemServico = ? "; 
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idOrdemServico);
			rs = ps.executeQuery();
			if (rs.next()) {
				totalTarefas = rs.getFloat(1);
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return totalTarefas;
	}
	
	public float getTotalPedidosOrdemServico(Integer idOrdemServico) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		float totalPedidos = 0;
		
		try {
			String sql = " SELECT sum(s.vlPed) "+
						 " FROM tbordemservico o "+
                         " JOIN tbpedidosaida s on o.idOrdemServico = s.idOrdemServico "+
                         " WHERE o.idOrdemServico =  ? "; 
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idOrdemServico);
			rs = ps.executeQuery();
			if (rs.next()) {
				totalPedidos = rs.getFloat(1);
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return totalPedidos;
	}
	
	
	public float getTotal(Integer idOrdemServico)throws AferoDAOException{
		float total = 0;
		if(getTotalServicos(idOrdemServico) >= getTotalTarefas(idOrdemServico)){
			total = getTotalServicos(idOrdemServico);
		}else{
			total = getTotalTarefas(idOrdemServico);
		}
		return total;
		
	}
	
	public void atualizarValorTotal(Integer idOrdemServico, float valorTotal) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (idOrdemServico == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = " UPDATE tbordemservico SET vlTotalOrdemServico = ? "+ 
					     " WHERE idOrdemServico = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setFloat(1, valorTotal);
			ps.setInt(2, idOrdemServico);
			
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} 
	}
	public boolean existeObjeto(int idOrdemServico) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean id = false;
		
		try {
			String sql = " SELECT distinct(o.idOrdemServico) "+
						 " FROM tbordemservico o "+
						 " JOIN tbordemservicoobjeto b on o.idOrdemServico = b.idOrdemServico "+
						 " WHERE o.idOrdemServico = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idOrdemServico);
			rs = ps.executeQuery();
			if (rs.next()) {
				id =true;
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return id;
	}
	public boolean existePedido(int idOrdemServico) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean id = false;
		
		try {
			String sql = " SELECT distinct(idOrdemServico) from tbpedidosaida where idOrdemServico = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idOrdemServico);
			rs = ps.executeQuery();
			if (rs.next()) {
				id =true;
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return id;
	}
	public float getValorTotal(Integer idOrdemServico) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		float total= 0;
		
		try {
			String sql = " SELECT o.vlTotalOrdemServico "+
						 " FROM tbordemservico o "+
                         " WHERE o.idOrdemServico =  ? "; 
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idOrdemServico);
			rs = ps.executeQuery();
			if (rs.next()) {
				total= rs.getFloat(1);
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return total;
	}
	
	public void atualizarHoraEntradaHoraSaida(Integer idOrdemServico, String horaEntrada, String horaSaida) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (idOrdemServico == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = " UPDATE tbordemservico SET horaEntrada = ?, horaSaida = ? "+ 
					     " WHERE idOrdemServico = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, horaEntrada);
			ps.setString(2, horaSaida);
			ps.setInt(3, idOrdemServico);
			
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} 
	}
	public String getHoraEntrada(Integer idOrdemServico) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		String horaEntrada = "00:00";
		
		try {
			String sql = " SELECT o.horaEntrada "+
						 " FROM tbordemservico o "+
                         " WHERE o.idOrdemServico =  ? "; 
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idOrdemServico);
			rs = ps.executeQuery();
			if (rs.next()) {
				horaEntrada= rs.getString(1);
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return horaEntrada;
	}
	public String getHoraSaida(Integer idOrdemServico) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		String horaSaida = "00:00";
		
		try {
			String sql = " SELECT o.horaSaida "+
						 " FROM tbordemservico o "+
                         " WHERE o.idOrdemServico =  ? "; 
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idOrdemServico);
			rs = ps.executeQuery();
			if (rs.next()) {
				horaSaida= rs.getString(1);
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return horaSaida;
	}
	public Integer getIdMecanico(Integer idOrdemServico) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		Integer idMecanico = 0;
		
		try {
			String sql = " SELECT o.idMecanico "+
						 " FROM tbordemservico o "+
                         " WHERE o.idOrdemServico =  ? "; 
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idOrdemServico);
			rs = ps.executeQuery();
			if (rs.next()) {
				idMecanico= rs.getInt(1);
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return idMecanico;
	}
	public void atualizarIdMecanico(Integer idOrdemServico, Integer idMecanico) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (idOrdemServico == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = " UPDATE tbordemservico SET idMecanico = ? "+ 
					     " WHERE idOrdemServico = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idMecanico);
			ps.setInt(2, idOrdemServico);
			
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} 
	}
	
}