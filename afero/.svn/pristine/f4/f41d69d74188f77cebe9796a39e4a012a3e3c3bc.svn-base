package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import afero.model.Classificacao;
import afero.model.Entidade;

public class ClassificacaoDAO implements IClassificacao {

	private Connection conn;

	public ClassificacaoDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;
	}

	public void incluir(Classificacao classificacao) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (classificacao == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbclassificacao (cdEntidade, idTipoEntidade) "
					+ "VALUES (?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, classificacao.getCdEntidade());
			ps.setInt(2, classificacao.getIdTipoEntidade());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}
	}

	public void excluir(Classificacao classificacao) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (classificacao == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbclassificacao WHERE cdEntidade=? and idTipoEntidade=?");
			ps.setInt(1, classificacao.getCdEntidade());
			ps.setInt(2, classificacao.getIdTipoEntidade());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public void excluir(Entidade entidade) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (entidade == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbclassificacao WHERE cdEntidade=?");
			ps.setInt(1, entidade.getCdEntidade());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public Classificacao procurarClassificacao(int cdEntidade,
			int idTipoEntidade) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		Classificacao classificacao = null;

		try {
			String sql = "SELECT cdEntidade, idTipoEntidade FROM tbclassificacao "
				+ "WHERE cdEntidade=? and idTipoEntidade=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cdEntidade);
			ps.setInt(2, idTipoEntidade);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + cdEntidade + "/" + idTipoEntidade);
			}
			cdEntidade  = rs.getInt(1);
			idTipoEntidade  = rs.getInt(2);
            
			classificacao = new Classificacao(cdEntidade, idTipoEntidade);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return classificacao;
	}

	public boolean possuiClassificacao(int cdEntidade,
			int idTipoEntidade) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean possui = false;

		try {
			String sql = "SELECT cdEntidade, idTipoEntidade FROM tbclassificacao "
				+ "WHERE cdEntidade=? and idTipoEntidade=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cdEntidade);
			ps.setInt(2, idTipoEntidade);
			rs = ps.executeQuery();
			if (rs.next()) {
				possui = true;
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return possui;
	}

	public List<Classificacao> listarClassificacao(String clausula)
			throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<Classificacao> list = null;
		
		try {
			String sql = "SELECT cdEntidade, idTipoEntidade FROM tbclassificacao ";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<Classificacao>();
			while (rs.next()) {
				int cdEntidade  = rs.getInt(1);
				int idTipoEntidade  = rs.getInt(2);
	            				
				list.add(new Classificacao(cdEntidade, idTipoEntidade));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}

}
