package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import afero.model.TipoAtendimento;

public class TipoAtendimentoDAO {
	
	public Connection conn;

	public TipoAtendimentoDAO(Connection conn) {
		
		this.conn = conn;

	}
	
	public void incluir(TipoAtendimento tipoAtendimento) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (tipoAtendimento == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");
		
		try {
			String sql = "INSERT INTO tbTipoAtendimento (dsTipoAtendimento, status)" +
						"VALUES (?, ?);";
			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, tipoAtendimento.getDsTipoAtendimento());
			ps.setString(2, tipoAtendimento.getStatus());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);

		}
	}
	
	
	public void atualiza(TipoAtendimento tipoAtendimento) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (tipoAtendimento == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");
		
		try {
			String sql = "UPDATE tbTipoAtendimento set dsTipoAtendimento = ?, status = ?" +
						"WHERE cdTipoAtendimento = ?";
			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, tipoAtendimento.getDsTipoAtendimento());
			ps.setString(2, tipoAtendimento.getStatus());
			ps.setInt(3, tipoAtendimento.getCdTipoAtendimento());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao atualizar dados: " + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);

		}
	}
	
	public void excluir(TipoAtendimento tipoAtendimento) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (tipoAtendimento == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn
					.prepareStatement("DELETE FROM tbTipoAtendimento WHERE cdTipoAtendimento = ?");
			ps.setInt(1, tipoAtendimento.getCdTipoAtendimento());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);
		}

	}
	
	public TipoAtendimento procurarTipoAtendimento (String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		TipoAtendimento tipoAtendimento = null;
		
		try {
			String sql = "SELECT cdTipoAtendimento, dsTipoAtendimento, status" +
						" FROM tbTipoAtendimento ";
			
			if(clausula != null)
				sql += clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				
				tipoAtendimento = new TipoAtendimento();
				
				tipoAtendimento.setCdTipoAtendimento(rs.getInt(1));
				tipoAtendimento.setDsTipoAtendimento(rs.getString(2));
				tipoAtendimento.setStatus(rs.getString(3));
				
			}
		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao procurar dados:" + sqle);
		}catch (Exception e){
			throw new AferoDAOException ("Erro ao procurar dados:" + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);
		}
		return tipoAtendimento;
	}


	public List<TipoAtendimento> listarTipoAtendimento(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<TipoAtendimento> list = null;

		try {
			String sql = "SELECT cdTipoAtendimento, dsTipoAtendimento, status " +
						"FROM tbTipoAtendimento";
			
			if (clausula != null)
				sql += clausula;
			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<TipoAtendimento>();
			
			while (rs.next()){
				
				int cdTipoAtendimento = rs.getInt(1);
				String dsTipoAtendimento = rs.getString(2);
				String status = rs.getString(3);
				
				list.add( new TipoAtendimento(cdTipoAtendimento, dsTipoAtendimento, status));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao listar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao listar dados: " + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);
		}
		return list;
	}
}