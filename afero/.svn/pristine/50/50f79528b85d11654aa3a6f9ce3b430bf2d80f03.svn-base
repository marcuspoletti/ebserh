package aferopet.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import afero.persistence.AferoDAOException;
import aferopet.model.TipoRaca;

public class TipoRacaDAO implements ITipoRacaDAO {
	
	private Connection conn;

	public TipoRacaDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;		
	}

	public void incluir(TipoRaca tipoRaca) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (tipoRaca == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbTipoRaca (idTipoRaca, dsTipoRaca, status) "
					+ "VALUES (?, ?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, tipoRaca.getIdTipoRaca());
			ps.setString(2, tipoRaca.getDsTipoRaca());
			ps.setString(3, tipoRaca.getStatus());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao atualizar dados: " + e);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}
	}

	public void atualizar(TipoRaca tipoRaca) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (tipoRaca == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbtipoRaca SET idTipoRaca = ?, dsTipoRaca = ?, status = ? "
					+ "WHERE idTipoRaca = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, tipoRaca.getIdTipoRaca());
			ps.setString(2, tipoRaca.getDsTipoRaca());
			ps.setString(3, tipoRaca.getStatus());
			ps.setInt(4, tipoRaca.getIdTipoRaca());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao atualizar dados: " + e);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}
	}

	public void excluir(TipoRaca tipoRaca) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (tipoRaca == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbTipoRaca WHERE idTipoRaca = ?");
			ps.setInt(1, tipoRaca.getIdTipoRaca());
			ps.executeUpdate();

		}catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		}finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}
	
	public TipoRaca procurarTipoRaca(int idTipoRaca) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		TipoRaca tipoRaca = null;

		try {
			String sql = "SELECT idTipoRaca, dsTipoRaca, status FROM tbTipoRaca "
				+ "WHERE idTipoRaca=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idTipoRaca);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + idTipoRaca);
			}
            
			String dsTipoRaca = rs.getString(2);
			String status  = rs.getString(3);
					
			tipoRaca = new TipoRaca(idTipoRaca, dsTipoRaca, status);
			
			
		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return tipoRaca;
	}

	public List<TipoRaca> listarTipoRaca(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<TipoRaca> list = null;
		
		try {
			String sql = "SELECT idTipoRaca, dsTipoRaca, status FROM tbTipoRaca ";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<TipoRaca>();
			while (rs.next()) {
				
				int idTipoRaca = rs.getInt(1);
				String dsTipoRaca = rs.getString(2);
				String status  = rs.getString(3);
								
				list.add(new TipoRaca(idTipoRaca, dsTipoRaca, status ));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
}
