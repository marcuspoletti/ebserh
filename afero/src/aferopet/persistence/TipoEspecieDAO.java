package aferopet.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import afero.persistence.AferoDAOException;
import aferopet.model.TipoEspecie;

public class TipoEspecieDAO implements ITipoEspecieDAO {
	
	private Connection conn;

	public TipoEspecieDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;		
	}

	public void incluir(TipoEspecie tipoEspecie) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (tipoEspecie == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbTipoEspecie (cdTipoEspecie, dsTipoEspecie, status) "
					+ "VALUES (?, ?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, tipoEspecie.getCdTipoEspecie());
			ps.setString(2, tipoEspecie.getDsTipoEspecie());
			ps.setString(3, tipoEspecie.getStatus());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao atualizar dados: " + e);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}
	}

	public void atualizar(TipoEspecie tipoEspecie) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (tipoEspecie == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbtipoEspecie SET cdTipoEspecie = ?, dsTipoEspecie = ?, status = ? "
					+ "WHERE cdTipoEspecie = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, tipoEspecie.getCdTipoEspecie());
			ps.setString(2, tipoEspecie.getDsTipoEspecie());
			ps.setString(3, tipoEspecie.getStatus());
			ps.setInt(4, tipoEspecie.getCdTipoEspecie());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao atualizar dados: " + e);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}
	}

	public void excluir(TipoEspecie tipoEspecie) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (tipoEspecie == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbTipoEspecie WHERE cdTipoEspecie = ?");
			ps.setInt(1, tipoEspecie.getCdTipoEspecie());
			ps.executeUpdate();

		}catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		}finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}
	
	public TipoEspecie procurarTipoEspecie(int cdTipoEspecie) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		TipoEspecie tipoEspecie = null;

		try {
			String sql = "SELECT cdTipoEspecie, dsTipoEspecie, status FROM tbTipoEspecie "
				+ "WHERE cdTipoEspecie=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cdTipoEspecie);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + cdTipoEspecie);
			}
            
			String dsTipoEspecie = rs.getString(2);
			String status  = rs.getString(3);
					
			tipoEspecie = new TipoEspecie(cdTipoEspecie, dsTipoEspecie, status);
			
			
		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return tipoEspecie;
	}

	public List<TipoEspecie> listarTipoEspecie(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<TipoEspecie> list = null;
		
		try {
			String sql = "SELECT cdTipoEspecie, dsTipoEspecie, status FROM tbTipoEspecie ";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<TipoEspecie>();
			while (rs.next()) {
				
				int cdTipoEspecie = rs.getInt(1);
				String dsTipoEspecie = rs.getString(2);
				String status  = rs.getString(3);
								
				list.add(new TipoEspecie(cdTipoEspecie, dsTipoEspecie, status ));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
}
