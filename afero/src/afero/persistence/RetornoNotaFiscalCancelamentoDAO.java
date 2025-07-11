package afero.persistence;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


import afero.model.CancelamentoNotaFiscal;



public class RetornoNotaFiscalCancelamentoDAO{
	
	private Connection conn;

	public RetornoNotaFiscalCancelamentoDAO(Connection conn) {
		this.conn = conn;
	}

	public void incluir(CancelamentoNotaFiscal cancelamentoNotaFiscal) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		String sql = "";
		if (cancelamentoNotaFiscal == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			   sql = "INSERT INTO tbretornonotafiscalcancelamento(idRetornoNotaFiscal, idPedidoSaida, mensagemRetorno, justificativa, dtRegistro, usuario)values(?, ?, ?, ?, now(), ?)";
			   conn = this.conn;
			   ps = conn.prepareStatement(sql);
			   ps.setInt(1, cancelamentoNotaFiscal.getIdRetornoNotaFiscal());
			   ps.setInt(2, cancelamentoNotaFiscal.getIdPedidoSaida());
			   ps.setString(3, cancelamentoNotaFiscal.getMensagemRetorno());
			   ps.setString(4, cancelamentoNotaFiscal.getJustificativa());
			   ps.setString(5, cancelamentoNotaFiscal.getUsuario());

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
		List<CancelamentoNotaFiscal> list = null;
		CancelamentoNotaFiscal cancelamentoNotaFiscal = null;
		
		try {
			String sql = "select idRetornoNotaFiscalCanc, idRetornoNotaFiscal, idPedidoSaida, mensagemRetorno, justificativa, dtRegistro, usuario from tbretornonotafiscalcancelamento ";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<CancelamentoNotaFiscal>();
			while (rs.next()) {
				Integer idRetornoNotaFiscalCanc     = rs.getInt(1);
				Integer idRetornoNotaFiscal      = rs.getInt(2);
				Integer idPedidoSaida            = rs.getInt(3);
				String mensagemRetorno             = rs.getString(4);
				String justificativa              = rs.getString(5);
				Date dtRegistro                  = rs.getTimestamp(6);
				String usuario                   = rs.getString(7);
				 
				cancelamentoNotaFiscal = new CancelamentoNotaFiscal(idRetornoNotaFiscalCanc, idRetornoNotaFiscal,
						idPedidoSaida, mensagemRetorno, justificativa, dtRegistro, usuario);
				
				list.add(cancelamentoNotaFiscal);
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return list;
	}

	


}