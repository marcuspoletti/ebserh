package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import afero.model.EntidadeDependente;
import afero.util.ConverteDate;

public class EntidadeDependenteDAO implements IEntidadeDependenteDAO {
	
	private Connection conn;

	public EntidadeDependenteDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;
	}

	public void incluir(EntidadeDependente entidadeDependente) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (entidadeDependente == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbentidadedependente (cdEntidade, idTipoDependente, nmDependente, dtNascimento, " +
			             "sexo, status, dtMod, usuario) VALUES (?, ?, ?, ?, ?, ?, now(), ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, entidadeDependente.getCdEntidade());
			ps.setInt(2, entidadeDependente.getIdTipoDependente());
			ps.setString(3, entidadeDependente.getNmDependente());
			ps.setDate(4, ConverteDate.DateToDateSql(entidadeDependente.getDtNascimento()));
			ps.setString(5, entidadeDependente.getSexo());
			ps.setString(6, entidadeDependente.getStatus());
			ps.setString(7, entidadeDependente.getUsuario());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(EntidadeDependente entidadeDependente) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (entidadeDependente == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbentidadedependente SET cdEntidade = ?, idTipoDependente = ?, nmDependente = ?, dtNascimento = ?, " +
			             "sexo = ?, status = ?, dtMod = now(), usuario = ? Where idEntidadeDependente = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, entidadeDependente.getCdEntidade());
			ps.setInt(2, entidadeDependente.getIdTipoDependente());
			ps.setString(3, entidadeDependente.getNmDependente());
			ps.setDate(4, ConverteDate.DateToDateSql(entidadeDependente.getDtNascimento()));
			ps.setString(5, entidadeDependente.getSexo());
			ps.setString(6, entidadeDependente.getStatus());
			ps.setString(7, entidadeDependente.getUsuario());
			ps.setInt(8, entidadeDependente.getIdEntidadeDependente());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao atualizar dados: " + e);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void excluir(EntidadeDependente entidadeDependente) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (entidadeDependente == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbentidadedependente WHERE idEntidadeDependente = ?");
			ps.setInt(1, entidadeDependente.getIdEntidadeDependente());
			ps.executeUpdate();

		}catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		}finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}
	}

	public EntidadeDependente procurarEntidadeDependente(int idEntidadeDependente) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		EntidadeDependente entidadeDependente= null;

		try {
			String sql = "SELECT idEntidadeDependente, cdEntidade, idTipoDependente, nmDependente, dtNascimento, " +
			             "sexo, status, dtMod, usuario FROM tbentidadedependente " +
				         "WHERE idEntidadeDependente = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idEntidadeDependente);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + idEntidadeDependente);
			}
            
			int cdEntidade = rs.getInt(2);
			int idTipoDependente = rs.getInt(3);
			String nmDependente = rs.getString(4);
			Date dtNascimento = rs.getDate(5);
			String sexo = rs.getString(6);
			String status = rs.getString(7);
			Date dtMod = rs.getDate(8);
			String usuario = rs.getString(9);

		    entidadeDependente = new EntidadeDependente(idEntidadeDependente, cdEntidade, idTipoDependente, nmDependente, 
		    		dtNascimento, sexo, status, dtMod, usuario);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return entidadeDependente;
	}
	public List listarEntidadeDependente(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<EntidadeDependente> list = null;
		
		try {
			String sql = "SELECT ed.idEntidadeDependente, ed.cdEntidade, ed.idTipoDependente, ed.nmDependente, ed.dtNascimento, ed.sexo, ed.status, ed.dtMod, ed.usuario " +
							"FROM tbentidadedependente ed " +
							"JOIN tbtipodependente td on (td.idTipoDependente = ed.idTipoDependente) " +
							"JOIN tbentidade e on (e.cdEntidade = ed.cdEntidade) ";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<EntidadeDependente>();
			while (rs.next()) {
				
				int idEntidadeDependente = rs.getInt(1);
				int cdEntidade = rs.getInt(2);
				int idTipoDependente = rs.getInt(3);
				String nmDependente = rs.getString(4);
				Date dtNascimento = rs.getDate(5);
				String sexo = rs.getString(6);
				String status = rs.getString(7);
				Date dtMod = rs.getDate(8);
				String usuario = rs.getString(9);
				
				list.add(new EntidadeDependente(idEntidadeDependente, cdEntidade, idTipoDependente, nmDependente, dtNascimento, 
						sexo, status, dtMod, usuario));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	
}
