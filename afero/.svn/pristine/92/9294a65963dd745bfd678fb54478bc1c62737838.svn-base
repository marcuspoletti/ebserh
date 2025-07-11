package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import afero.model.Cotacao;
import afero.util.ConverteDate;

public class CotacaoDAO implements ICotacaoDAO{

	private Connection conn;
	
    public CotacaoDAO(Connection conn) {
		this.conn = conn;
    }
	
	public void incluir(Cotacao cotacao) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;		
		if (cotacao == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbcotacao(idLoja, idColaborador, dtCotacao, "+
			             "observacao, status, dtMod, usuario) " +
			             "values(?, ?, ?, ?, ?, now(), ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cotacao.getIdLoja());
			ps.setInt(2, cotacao.getIdColaborador());
			ps.setDate(3, ConverteDate.DateToDateSql(cotacao.getDtCotacao()));
			ps.setString(4, cotacao.getObservacao());
			ps.setString(5, cotacao.getStatus());
			ps.setString(6, cotacao.getUsuario());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(Cotacao cotacao) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (cotacao == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbcotacao set idLoja = ?, idColaborador = ?, dtCotacao = ?, "+
			             "observacao = ?, status = ?, dtMod = now(), usuario = ? "+
		             "where idCotacao = ?";
		
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cotacao.getIdLoja());
			ps.setInt(2, cotacao.getIdColaborador());
			ps.setDate(3, ConverteDate.DateToDateSql(cotacao.getDtCotacao()));
			ps.setString(4, cotacao.getObservacao());
			ps.setString(5, cotacao.getStatus());
			ps.setString(6, cotacao.getUsuario());
			ps.setInt(7, cotacao.getIdCotacao());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void excluir(Cotacao cotacao) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (cotacao == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;			
			ps = conn.prepareStatement("DELETE FROM tbcotacao WHERE idCotacao=?");
			ps.setInt(1, cotacao.getIdCotacao());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public Cotacao procurarCotacao(int idCotacao) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		Cotacao cotacao = null;
		
		try {
			String sql = "SELECT idLoja, idColaborador, dtCotacao, "+
			             "observacao, status, dtMod, usuario " +
			             "from tbcotacao " +
			             "WHERE idCotacao = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idCotacao);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + idCotacao);
			}
            
			int idLoja = rs.getInt(1);
			int idColaborador = rs.getInt(2);
			Date dtCotacao = rs.getDate(3);
			String observacao = rs.getString(4);
			String status = rs.getString(5);
			Date dtMod = rs.getDate(6);
			String usuario = rs.getString(7);

			cotacao = new Cotacao(idCotacao, idLoja, idColaborador,
					dtCotacao, observacao, status, dtMod,
					usuario);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return cotacao;
	}

	public List listarCotacao(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<Cotacao> list = null;
		
		try {
			String sql = "SELECT idCotacao, idLoja, idColaborador, dtCotacao, "+
			             "observacao, status, dtMod, usuario " +
			             "from tbcotacao ";
			if (clausula != null) sql = sql + clausula;			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<Cotacao>();
			
			while (rs.next()) {
				int idCotacao = rs.getInt(1);
				int idLoja = rs.getInt(2);
				int idColaborador = rs.getInt(3);
				Date dtCotacao = rs.getDate(4);
				String observacao = rs.getString(5);
				String status = rs.getString(6);
				Date dtMod = rs.getDate(7);
				String usuario = rs.getString(8);
				
				list.add(new Cotacao(idCotacao, idLoja, idColaborador,
						dtCotacao, observacao, status, dtMod,
						usuario));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	
	public String dataAtualCotacao() throws AferoDAOException {
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
	public int idCotacaoCorrente() throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		int numCotacao = 0;
		
		try {
			String sql = "select max(idCotacao) from tbcotacao order by idCotacao DESC LIMIT 1";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if (rs.next()) {
				numCotacao = rs.getInt(1);
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return numCotacao;
	}

}
