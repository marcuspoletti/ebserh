package afero.persistence;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import afero.model.CotacaoEntidade;


public class CotacaoEntidadeDAO implements ICotacaoEntidadeDAO{

	private Connection conn;
	
	public CotacaoEntidadeDAO(Connection conn) {
		this.conn = conn;
	}
	
	public void incluir(CotacaoEntidade cotacaoEntidade) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (cotacaoEntidade == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbcotacaoentidade(idCotacaoItem, cdEntidade, valor, " +
			             "prazoEntrega, aprovado, valorAprov, dtMod, usuario) " +
			             "values(?, ?, ?, ?, ?, ?, now(), ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cotacaoEntidade.getIdCotacaoItem());
			ps.setInt(2, cotacaoEntidade.getCdEntidade());
			ps.setFloat(3, cotacaoEntidade.getValor());
			ps.setInt(4, cotacaoEntidade.getPrazoEntrega());
			ps.setString(5, cotacaoEntidade.getAprovado());
			ps.setFloat(6, cotacaoEntidade.getValorAprov());
			ps.setString(7, cotacaoEntidade.getUsuario());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(CotacaoEntidade cotacaoEntidade) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (cotacaoEntidade == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbcotacaoentidade set idCotacaoItem = ?, cdEntidade = ?, valor = ?, " +
			             "prazoEntrega = ?, aprovado = ?, valorAprov = ?, dtMod = now(), usuario = ? "+
		             "where idCotacaoEntidade = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cotacaoEntidade.getIdCotacaoItem());
			ps.setInt(2, cotacaoEntidade.getCdEntidade());
			ps.setFloat(3, cotacaoEntidade.getValor());
			ps.setInt(4, cotacaoEntidade.getPrazoEntrega());
			ps.setString(5, cotacaoEntidade.getAprovado());
			ps.setFloat(6, cotacaoEntidade.getValorAprov());
			ps.setString(7, cotacaoEntidade.getUsuario());
			ps.setInt(8, cotacaoEntidade.getIdCotacaoEntidade());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void excluir(CotacaoEntidade cotacaoEntidade) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (cotacaoEntidade == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbcotacaoentidade WHERE idCotacaoEntidade = ?");
			ps.setInt(1, cotacaoEntidade.getIdCotacaoEntidade());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public CotacaoEntidade procurarCotacaoEntidade(int idCotacaoEntidade) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		CotacaoEntidade cotacaoEntidade = null;
		
		try {
			String sql = "SELECT idCotacaoItem, cdEntidade, valor, " +
			             "prazoEntrega, aprovado, valorAprov, dtMod, usuario " +
			             "from tbcotacaoentidade " +
			             "WHERE idCotacaoEntidade = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idCotacaoEntidade);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + idCotacaoEntidade);
			}
            
			int idCotacaoItem = rs.getInt(1);
			int cdEntidade = rs.getInt(2);
			float valor = rs.getFloat(3);
			int prazoEntrega = rs.getInt(4);
			String aprovado = rs.getString(5);
			float valorAprov = rs.getFloat(6);
			Date dtMod = rs.getDate(7);
			String usuario = rs.getString(8);

			cotacaoEntidade = new CotacaoEntidade(idCotacaoEntidade, idCotacaoItem,
					cdEntidade, valor, prazoEntrega, aprovado,
					valorAprov, usuario);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return cotacaoEntidade;
	}

	public List listarCotacaoEntidade(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<CotacaoEntidade> list = null;
		
		try {
			String sql = "SELECT idCotacaoEntidade, idCotacaoItem, cdEntidade, valor, " +
			             "prazoEntrega, aprovado, valorAprov, dtMod, usuario " +
			             "from tbcotacaoentidade ";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;			
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<CotacaoEntidade>();
			
			while (rs.next()) {
				
				int idCotacaoEntidade = rs.getInt(1);
				int idCotacaoItem = rs.getInt(2);
				int cdEntidade = rs.getInt(3);
				float valor = rs.getFloat(4);
				int prazoEntrega = rs.getInt(5);
				String aprovado = rs.getString(6);
				float valorAprov = rs.getFloat(7);
				Date dtMod = rs.getDate(8);
				String usuario = rs.getString(9);
				
				list.add(new CotacaoEntidade(idCotacaoEntidade, idCotacaoItem,
						cdEntidade, valor, prazoEntrega, aprovado,
						valorAprov, usuario));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
}
