package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import afero.model.AreaAtuacao;
import afero.model.Entidade;

public class AreaAtuacaoDAO implements IAreaAtuacao {

	private Connection conn;

	public AreaAtuacaoDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;
	}

	public void incluir(AreaAtuacao areaAtuacao) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (areaAtuacao == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbareaatuacao (cdEntidade, idRamoAtividade) "
					+ "VALUES (?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, areaAtuacao.getCdEntidade());
			ps.setInt(2, areaAtuacao.getIdRamoAtividade());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}
	}

	public void excluir(AreaAtuacao areaAtuacao) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (areaAtuacao == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbareaatuacao WHERE cdEntidade=? and idRamoAtividade=?");
			ps.setInt(1, areaAtuacao.getCdEntidade());
			ps.setInt(2, areaAtuacao.getIdRamoAtividade());
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
			ps = conn.prepareStatement("DELETE FROM tbareaatuacao WHERE cdEntidade=?");
			ps.setInt(1, entidade.getCdEntidade());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}
	}

	public AreaAtuacao procurarAreaAtuacao(int cdEntidade, int idRamoAtividade)
			throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		AreaAtuacao areaAtuacao = null;

		try {
			String sql = "SELECT cdEntidade, idRamoAtividade FROM tbareaatuacao "
				+ "WHERE cdEntidade=? and idRamoAtividade=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cdEntidade);
			ps.setInt(2, idRamoAtividade);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + cdEntidade + "/" + idRamoAtividade);
			}
			cdEntidade  = rs.getInt(1);
			idRamoAtividade  = rs.getInt(2);
            
			areaAtuacao = new AreaAtuacao(cdEntidade, idRamoAtividade);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return areaAtuacao;
	}

	public boolean possuiAreaAtuacao(int cdEntidade, int idRamoAtividade) 
			throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean possui = false;

		try {
			String sql = "SELECT cdEntidade, idRamoAtividade FROM tbareaatuacao "
				+ "WHERE cdEntidade=? and idRamoAtividade=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cdEntidade);
			ps.setInt(2, idRamoAtividade);
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

	public List<AreaAtuacao> listarAreaAtuacao(String clausula)
			throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<AreaAtuacao> list = null;
		
		try {
			String sql = "SELECT cdEntidade, idRamoAtividade FROM tbareaatuacao ";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<AreaAtuacao>();
			while (rs.next()) {
				int cdEntidade  = rs.getInt(1);
				int idRamoAtividade  = rs.getInt(2);
	            				
				list.add(new AreaAtuacao(cdEntidade, idRamoAtividade));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}

}
