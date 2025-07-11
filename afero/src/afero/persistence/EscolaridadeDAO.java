package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import afero.model.Escolaridade;

public class EscolaridadeDAO  implements IEscolaridadeDAO {
	
	private Connection conn;

	public EscolaridadeDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;
	}

	public void incluir(Escolaridade escolaridade) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (escolaridade == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbescolaridade (cdEscolaridade, dsEscolaridade, status) "
					+ "VALUES (?, ?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, escolaridade.getCdEscolaridade());
			ps.setString(2,escolaridade.getDsEscolaridade());
			ps.setString(3, escolaridade.getStatus());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(Escolaridade escolaridade) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (escolaridade == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbescolaridade SET cdEscolaridade=?, dsEscolaridade=?, status=? "
					+ "WHERE cdEscolaridade=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, escolaridade.getCdEscolaridade());
			ps.setString(2, escolaridade.getDsEscolaridade());
			ps.setString(3, escolaridade.getStatus());
			ps.setInt(4, escolaridade.getCdEscolaridade());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void excluir(Escolaridade escolaridade) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (escolaridade == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbescolaridade WHERE cdEscolaridade=?");
			ps.setInt(1, escolaridade.getCdEscolaridade());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public Escolaridade procurarEscolaridade(int cdEscolaridade) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		Escolaridade escolaridade = null;

		try {
			String sql = "SELECT cdEscolaridade, dsEscolaridade, status FROM tbescolaridade "
				+ "WHERE cdEscolaridade=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cdEscolaridade);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + cdEscolaridade);
			}
            
			String dsEscolaridade  = rs.getString(2);
			String status = rs.getString(3);

			escolaridade = new Escolaridade(cdEscolaridade, dsEscolaridade, status);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return escolaridade;
	}

	public List listarEscolaridade(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<Escolaridade> list = null;
		
		try {
			String sql = "SELECT cdEscolaridade, dsEscolaridade, status FROM tbescolaridade ";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<Escolaridade>();
			while (rs.next()) {
				int cdEscolaridade = rs.getInt(1);
				String dsEscolaridade = rs.getString(2);
				String status = rs.getString(3);
				
				list.add(new Escolaridade(cdEscolaridade, dsEscolaridade, status));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}

}
