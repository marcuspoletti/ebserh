
package afero.persistence;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


import afero.model.CartaCorrecaoNotaFiscal;



public class RetornoCartaCorrecaoDAO{
	
	private Connection conn;

	public RetornoCartaCorrecaoDAO(Connection conn) {
		this.conn = conn;
	}

	public void incluir(CartaCorrecaoNotaFiscal cartaCorrecaoNotaFiscal) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		String sql = "";
		if (cartaCorrecaoNotaFiscal == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			   sql = "INSERT INTO tbretornonotafiscalcorrecao(idRetornoNotaFiscal, idPedidoSaida, justificativa, mensagemRetorno, dtRegistro, usuario)values(?, ?, ?, ?, now(), ?)";
			   conn = this.conn;
			   ps = conn.prepareStatement(sql);
			   ps.setInt(1, cartaCorrecaoNotaFiscal.getIdRetornoNotaFiscal());
			   ps.setInt(2, cartaCorrecaoNotaFiscal.getReferencia());
			   ps.setString(3, cartaCorrecaoNotaFiscal.getJustificativa());
			   ps.setString(4, cartaCorrecaoNotaFiscal.getMensagemRetorno());
			   ps.setString(5, cartaCorrecaoNotaFiscal.getUsuario());

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
		List<CartaCorrecaoNotaFiscal> list = null;
		CartaCorrecaoNotaFiscal cartaCorrecaoNotaFiscal = null;
		
		try {
			String sql = " Select idNotaFiscalCorrecao, idRetornoNotaFiscal, idPedidoSaida, justificativa, mensagemRetorno, dtRegistro, usuario from tbretornonotafiscalcorrecao ";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<CartaCorrecaoNotaFiscal>();
			while (rs.next()) {
				Integer idNotaFiscalCorrecao     = rs.getInt(1);
				Integer idRetornoNotaFiscal      = rs.getInt(2);
				Integer idPedidoSaida            = rs.getInt(3);
				String justificativa             = rs.getString(4);
				String mensagemRetorno           = rs.getString(5);
				Date dtRegistro                  = rs.getTimestamp(6);
				String usuario                   = rs.getString(7);
				 
				cartaCorrecaoNotaFiscal = new CartaCorrecaoNotaFiscal(idNotaFiscalCorrecao, idRetornoNotaFiscal,
						idPedidoSaida, justificativa, mensagemRetorno, dtRegistro, usuario);
				
				list.add(cartaCorrecaoNotaFiscal);
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return list;
	}

	


}