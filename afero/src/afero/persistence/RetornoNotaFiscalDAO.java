package afero.persistence;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


import afero.model.RetornoNotaFiscal;
import afero.util.ConverteDate;



public class RetornoNotaFiscalDAO{
	
	private Connection conn;

	public RetornoNotaFiscalDAO(Connection conn) {
		this.conn = conn;
	}

	public void incluir(RetornoNotaFiscal retornonotaFiscal) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		String sql = "";
		if (retornonotaFiscal == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			   sql = "INSERT INTO tbretornonotafiscal(idPedidoSaida, mensagemRetorno, dtRegistro, usuario)values(?, ?, now(), ?)";
			   conn = this.conn;
			   ps = conn.prepareStatement(sql);
			   ps.setInt(1, retornonotaFiscal.getId_pedido_saida());
			   ps.setString(2, retornonotaFiscal.getMensagem_retorno());
			   ps.setString(3, retornonotaFiscal.getUsuario());

			   ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} 
	}
	public List listarRetornoNotaFiscal(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<RetornoNotaFiscal> list = null;
		RetornoNotaFiscal retornoNotaFiscal = null;
		
		try {
			String sql = "Select idRetornoNotaFiscal,idPedidoSaida, mensagemRetorno, dtRegistro, usuario from tbretornonotafiscal";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<RetornoNotaFiscal>();
			while (rs.next()) {
				Integer idRetornoNotaFiscal = rs.getInt(1);
				Integer idPedidoSaida       = rs.getInt(2);
				String mensagemRetorno      = rs.getString(3);
				Date dtRegistro             = rs.getTimestamp(4);
				String usuario              = rs.getString(5);
				retornoNotaFiscal = new RetornoNotaFiscal(idRetornoNotaFiscal,
						idPedidoSaida, mensagemRetorno,
						dtRegistro, usuario);
				
				list.add(retornoNotaFiscal);
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return list;
	}
	public String PeriodoNotaFiscal(Integer IdPedidoSaida, Integer idRetornoNotaFiscal) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		String diferencaAtual = null;
		
		try {
			String sql = "SELECT HOUR(TIMEDIFF(curtime(), (select dtRegistro from tbretornonotafiscal where idPedidoSaida = ? AND idRetornoNotaFiscal = ?)))";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, IdPedidoSaida);
			ps.setInt(2, idRetornoNotaFiscal);
			rs = ps.executeQuery();
			if (rs.next()) {
				diferencaAtual = rs.getString(1);
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return diferencaAtual;
	}
	public String ConsultaPeriodoNotaFiscal(Integer IdPedidoSaida) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		String diferencaAtual = null;
		
		try {
			String sql = "SELECT HOUR(TIMEDIFF(curtime(), (select dtRegistro from tbretornonotafiscal where idPedidoSaida = ? AND idRetornoNotaFiscal > 0)))";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, IdPedidoSaida);
			
			rs = ps.executeQuery();
			if (rs.next()) {
				diferencaAtual = rs.getString(1);
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return diferencaAtual;
	}
	


}