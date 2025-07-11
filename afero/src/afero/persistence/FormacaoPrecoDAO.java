package afero.persistence;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import afero.model.FormacaoPreco;


public class FormacaoPrecoDAO {
	
private Connection conn;
	
    public FormacaoPrecoDAO(Connection conn) {
		this.conn = conn;
    }
	
	public void incluir(FormacaoPreco formacaoPreco) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;		
		if (formacaoPreco == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbformacaopreco(dsFormacaoPreco, pFrete, pIPI, pOutrasDespesas, pICMSEntrada, pICMSSaida, " +
					     "pCustoOperacional, pOutrosImpostos, pComissao, pLucro, status, dtMod, usuario ) " +
					     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now(), ?) ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, formacaoPreco.getDsFormacapPreco());
			ps.setFloat(2, formacaoPreco.getpFrete());
			ps.setFloat(3, formacaoPreco.getpIpi());
			ps.setFloat(4, formacaoPreco.getpOutrasDespesas());
			ps.setFloat(5, formacaoPreco.getpIcmsEntrada());
			ps.setFloat(6, formacaoPreco.getpIcmsSaida());
			ps.setFloat(7, formacaoPreco.getpCustoOperacional());
			ps.setFloat(8, formacaoPreco.getpOutrosImpostos());
			ps.setFloat(9, formacaoPreco.getpComissao());
			ps.setFloat(10, formacaoPreco.getpLucro());
			ps.setString(11, formacaoPreco.getStatus());
			ps.setString(12, formacaoPreco.getUsuario());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		}
	}

	public void atualizar(FormacaoPreco formacaoPreco) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (formacaoPreco == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbformacaopreco set dsFormacaoPreco = ?, pFrete = ?, pIPI = ?, pOutrasDespesas = ?, pICMSEntrada = ?, pICMSSaida = ?, " +
					     "pCustoOperacional = ?, pOutrosImpostos = ?, pComissao = ?, pLucro = ?, status = ?, dtMod = now(), usuario = ? "+
		                 "where idFormacaoPreco = ?";
		
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, formacaoPreco.getDsFormacapPreco());
			ps.setFloat(2, formacaoPreco.getpFrete());
			ps.setFloat(3, formacaoPreco.getpIpi());
			ps.setFloat(4, formacaoPreco.getpOutrasDespesas());
			ps.setFloat(5, formacaoPreco.getpIcmsEntrada());
			ps.setFloat(6, formacaoPreco.getpIcmsSaida());
			ps.setFloat(7, formacaoPreco.getpCustoOperacional());
			ps.setFloat(8, formacaoPreco.getpOutrosImpostos());
			ps.setFloat(9, formacaoPreco.getpComissao());
			ps.setFloat(10, formacaoPreco.getpLucro());
			ps.setString(11, formacaoPreco.getStatus());
			ps.setString(12, formacaoPreco.getUsuario());
			ps.setInt(13, formacaoPreco.getIdFormacaoPreco());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void excluir(FormacaoPreco formacaoPreco) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (formacaoPreco == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;			
			ps = conn.prepareStatement("DELETE FROM tbformacaopreco WHERE idFormacaoPreco = ? ");
			ps.setInt(1, formacaoPreco.getIdFormacaoPreco());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public FormacaoPreco procurarFormacaoPreco(int idFormacaoPreco) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		FormacaoPreco formacaoPreco = null;
		
		try {
			String sql = "SELECT dsFormacaoPreco, pFrete, pIPI, pOutrasDespesas, pICMSEntrada, pICMSSaida, " +
					     "pCustoOperacional, pOutrosImpostos, pComissao, pLucro, status, dtMod, usuario " +
					     "from tbformacaopreco "+
					     "WHERE idFormacaoPreco = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idFormacaoPreco);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + idFormacaoPreco);
			}
            
			
			String dsFormacapPreco = rs.getString(1);
			float pFrete = rs.getFloat(2);
			float pIpi = rs.getFloat(3);
			float pOutrasDespesas = rs.getFloat(4);
			float pIcmsEntrada = rs.getFloat(5);
			float pIcmsSaida = rs.getFloat(6);
			float pCustoOperacional = rs.getFloat(7);
			float pOutrosImpostos = rs.getFloat(8);
			float pComissao = rs.getFloat(9);
			float pLucro = rs.getFloat(10);
			String status = rs.getString(11);
			Date dtMod = rs.getDate(12);
			String usuario = rs.getString(13);

			formacaoPreco = new FormacaoPreco(idFormacaoPreco, dsFormacapPreco,
					 pFrete, pIpi, pOutrasDespesas, pIcmsEntrada, pIcmsSaida, pCustoOperacional,
					 pOutrosImpostos, pComissao, pLucro, status,  dtMod,  usuario);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return formacaoPreco;
	}

	public List listarFormacaoPreco(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<FormacaoPreco> list = null;
		
		try {
			String sql = "SELECT idFormacaoPreco, dsFormacaoPreco, pFrete, pIPI, pOutrasDespesas, pICMSEntrada, pICMSSaida, " +
					     "pCustoOperacional, pOutrosImpostos, pComissao, pLucro, status, dtMod, usuario " +
					     "from tbformacaopreco ";
			if (clausula != null) sql = sql + clausula;			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<FormacaoPreco>();
			
			while (rs.next()) {
				
				int idFormacaoPreco = rs.getInt(1);
				String dsFormacapPreco = rs.getString(2);
				float pFrete = rs.getFloat(3);
				float pIpi = rs.getFloat(4);
				float pOutrasDespesas = rs.getFloat(5);
				float pIcmsEntrada = rs.getFloat(6);
				float pIcmsSaida = rs.getFloat(7);
				float pCustoOperacional = rs.getFloat(8);
				float pOutrosImpostos = rs.getFloat(9);
				float pComissao = rs.getFloat(10);
				float pLucro = rs.getFloat(11);
				String status = rs.getString(12);
				Date dtMod = rs.getDate(13);
				String usuario = rs.getString(14);
				list.add(new FormacaoPreco(idFormacaoPreco, dsFormacapPreco,
						 pFrete, pIpi, pOutrasDespesas, pIcmsEntrada, pIcmsSaida, pCustoOperacional,
						 pOutrosImpostos, pComissao, pLucro, status,  dtMod,  usuario));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	
	public boolean exclusaoIdFormacaoPreco(int idFormacaoPreco) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = true;
		try {
			String sql = "select idFormacaoPreco from tbproduto where idFormacaoPreco = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idFormacaoPreco);
			rs = ps.executeQuery();
			if(rs.next()) {
			   ok=true;
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
	
	

}
