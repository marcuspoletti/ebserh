package aferopet.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import afero.persistence.AferoDAOException;
import aferopet.model.GrupoMedicamento;

public class GrupoMedicamentoDAO implements IGrupoMedicamentoDAO {
	
	private Connection conn;

	public GrupoMedicamentoDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;		
	}

	public void incluir(GrupoMedicamento grupoMedicamento) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (grupoMedicamento == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbGrupoMedicamento (idGrupoMedicamento, dsGrupoMedicamento, status, idDivisao, idSubGrupo, idGrupo) "
					+ "VALUES (?, ?, ?, ?, ?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, grupoMedicamento.getIdGrupoMedicamento());
			ps.setString(2, grupoMedicamento.getDsGrupoMedicamento());
			ps.setString(3, grupoMedicamento.getStatus());
			ps.setInt(4, grupoMedicamento.getIdDivisao());
			ps.setInt(5, grupoMedicamento.getIdSubGrupo());
			ps.setInt(6, grupoMedicamento.getIdGrupo());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao atualizar dados: " + e);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}
	}

	public void atualizar(GrupoMedicamento grupoMedicamento) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (grupoMedicamento == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbgrupoMedicamento SET idGrupoMedicamento = ?, dsGrupoMedicamento = ?, status = ?, idDivisao = ?, idSubGrupo = ?, idGrupo = ?  "
					+ "WHERE idgrupoMedicamento = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, grupoMedicamento.getIdGrupoMedicamento());
			ps.setString(2, grupoMedicamento.getDsGrupoMedicamento());
			ps.setString(3, grupoMedicamento.getStatus());
			ps.setInt(4, grupoMedicamento.getIdDivisao());
			ps.setInt(5, grupoMedicamento.getIdSubGrupo());
			ps.setInt(6, grupoMedicamento.getIdGrupo());
			ps.setInt(7, grupoMedicamento.getIdGrupoMedicamento());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao atualizar dados: " + e);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}
	}

	public void excluir(GrupoMedicamento grupoMedicamento) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (grupoMedicamento == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbGrupoMedicamento WHERE idGrupoMedicamento = ?");
			ps.setInt(1, grupoMedicamento.getIdGrupoMedicamento());
			ps.executeUpdate();

		}catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		}finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}
	
	public GrupoMedicamento procurarGrupoMedicamento(int idGrupoMedicamento) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		GrupoMedicamento grupoMedicamento = null;

		try {
			String sql = "SELECT idGrupoMedicamento, dsGrupoMedicamento, status, idDivisao, idSubGrupo, idGrupo  FROM tbGrupoMedicamento "
				+ "WHERE idGrupoMedicamento=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idGrupoMedicamento);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + idGrupoMedicamento);
			}
            
			String dsGrupoMedicamento = rs.getString(2);
			String status  = rs.getString(3);
			int idDivisao = rs.getInt(4);
			int idSubGrupo = rs.getInt(5);
			int idGrupo = rs.getInt(6);
					
			grupoMedicamento = new GrupoMedicamento(idGrupoMedicamento, dsGrupoMedicamento, status, idDivisao, idSubGrupo, idGrupo);
			
			
		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return grupoMedicamento;
	}

	public List<GrupoMedicamento> listarGrupoMedicamento(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<GrupoMedicamento> list = null;
		
		try {
			String sql = "SELECT idGrupoMedicamento, dsGrupoMedicamento, status, idDivisao, idSubGrupo, idGrupo FROM tbGrupoMedicamento ";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<GrupoMedicamento>();
			while (rs.next()) {
				
				int idGrupoMedicamento = rs.getInt(1);
				String dsGrupoMedicamento = rs.getString(2);
				String status  = rs.getString(3);
				int idDivisao = rs.getInt(4);
				int idSubGrupo = rs.getInt(5);
				int idGrupo = rs.getInt(6);				
				list.add(new GrupoMedicamento(idGrupoMedicamento, dsGrupoMedicamento, status, idDivisao, idSubGrupo, idGrupo ));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
}
