
package afero.persistence;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


import afero.model.InutilizacaoNumeracao;;



public class InutilizacaoNumeracaoDAO{
	
	private Connection conn;

	public InutilizacaoNumeracaoDAO(Connection conn) {
		this.conn = conn;
	}

	public void incluir(InutilizacaoNumeracao inutilizacaoNumeracao) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		String sql = "";
		if (inutilizacaoNumeracao == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			   sql = "INSERT INTO tbinutilizacaonumeracao( cnpj, serie, numeroInicial, numeroFinal, justificativa, dtRegistro, usuario )values(?, ?, ?, ?, ?, now(), ?)";
			   conn = this.conn;
			   ps = conn.prepareStatement(sql);
			   ps.setString(1, inutilizacaoNumeracao.getCnpj());
			   ps.setString(2, inutilizacaoNumeracao.getSerie());
			   ps.setString(3, inutilizacaoNumeracao.getNumeroInicial());
			   ps.setString(4, inutilizacaoNumeracao.getNumeroFinal());
			   ps.setString(5, inutilizacaoNumeracao.getJustificativa());
			   ps.setString(6, inutilizacaoNumeracao.getUsuarios());

			   ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} 
	}
	public List listarInutilizacaoNumeracao(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<InutilizacaoNumeracao> list = null;
		InutilizacaoNumeracao inutilizacaoNumeracao = null;
		
		try {
			String sql = " Select idInutilizacaoNumeracao, cnpj, serie, numeroInicial, numeroFinal, justificativa, dtRegistro, usuario from tbinutilizacaonumeracao ";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<InutilizacaoNumeracao>();
			while (rs.next()) {
				 Integer idInutilizacaoNumeracao = rs.getInt(1);
				 String cnpj = rs.getString(2);
				 String serie= rs.getString(3);
				 String numeroInicial= rs.getString(4);
				 String numeroFinal= rs.getString(5);
				 String justificativa= rs.getString(6);
				 Date dtRegistro= rs.getDate(7);
				 String usuarios= rs.getString(8);
				 
				inutilizacaoNumeracao = new InutilizacaoNumeracao(idInutilizacaoNumeracao, cnpj,
						 serie,  numeroInicial,  numeroFinal,
						 justificativa,  dtRegistro,  usuarios);
				
				list.add(inutilizacaoNumeracao);
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return list;
	}

	


}