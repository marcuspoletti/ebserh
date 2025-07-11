package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import afero.model.ListaObjeto;

public class ListaObjetoDAO {
	
	public Connection conn;

	public ListaObjetoDAO(Connection conn) {
		this.conn = conn;
	}
	
	// INSERIR
	
	public void incluir(ListaObjeto listaObjeto) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (listaObjeto == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");
		
		try {
			String sql = "INSERT INTO tbListaObjeto (idLoja, dsListaObjeto, campo1, campo2, campo3, campo4, status)" +
						"VALUES (?, ?, ?, ?, ?, ?, ?)";
			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, listaObjeto.getIdLoja());
			ps.setString(2, listaObjeto.getDsListaObjeto());
			ps.setString(3, listaObjeto.getCampo1());
			ps.setString(4, listaObjeto.getCampo2());
			ps.setString(5, listaObjeto.getCampo3());
			ps.setString(6, listaObjeto.getCampo4());
			ps.setString(7, listaObjeto.getStatus());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);
		}
	}

	// ATUALIZAR 
	
	public void atualiza(ListaObjeto listaObjeto) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (listaObjeto == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");
		
		try {
			String sql = "UPDATE tbListaObjeto SET idLoja = ?, dsListaObjeto = ?, campo1 = ?, campo2 = ?, campo3 = ?, campo4 = ?,  status = ?" +
						"WHERE idListaObjeto = ?";
			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, listaObjeto.getIdLoja());
			ps.setString(2, listaObjeto.getDsListaObjeto());
			ps.setString(3, listaObjeto.getCampo1());
			ps.setString(4, listaObjeto.getCampo2());
			ps.setString(5, listaObjeto.getCampo3());
			ps.setString(6, listaObjeto.getCampo4());
			ps.setString(7, listaObjeto.getStatus());
			ps.setInt(8, listaObjeto.getIdListaObjeto());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao atualizar dados: " + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);
		}
	}
	
	// EXCLUIR
	
	public void excluir(ListaObjeto listaObjeto) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (listaObjeto == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbListaObjeto WHERE idListaObjeto = ?");
			ps.setInt(1, listaObjeto.getIdListaObjeto());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);
		}
	}
	
	// BUSCAR
	
	public ListaObjeto procurarListaObjeto (String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		ListaObjeto listaObjeto = null;
		
		try {
			String sql = "SELECT idListaObjeto, idLoja, dsListaObjeto, campo1, campo2, campo3, campo4, status " +
						" FROM tbListaObjeto";
			
			if(clausula != null)
				sql += clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				
				listaObjeto = new ListaObjeto();
				
				listaObjeto.setIdListaObjeto(rs.getInt(1));
				listaObjeto.setIdLoja(rs.getInt(2));
				listaObjeto.setDsListaObjeto(rs.getString(3));
				listaObjeto.setCampo1(rs.getString(4));
				listaObjeto.setCampo2(rs.getString(5));
				listaObjeto.setCampo3(rs.getString(6));
				listaObjeto.setCampo4(rs.getString(7));
				listaObjeto.setStatus(rs.getString(8));
				
			}
		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao procurar dados:" + sqle);
		}catch (Exception e){
			throw new AferoDAOException ("Erro ao procurar dados:" + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);
		}
		return listaObjeto;
	}
	
	// LISTAR
	
	public List<ListaObjeto> listarObjetos(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<ListaObjeto> list = null;

		try {
			String sql = "SELECT  idListaObjeto, idLoja, dsListaObjeto, campo1, campo2, campo3, campo4, status " +
						"FROM tbListaObjeto";
			
			if (clausula != null)
				sql += clausula;
			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<ListaObjeto>();
			while (rs.next()){
				
				int idListaObjeto = rs.getInt(1);
				int idLoja = rs.getInt(2); 
				String dsListaObjeto = rs.getString(3);
				String campo1 = rs.getString(4);
				String campo2 = rs.getString(5);
				String campo3 = rs.getString(6);
				String campo4 = rs.getString(7);
				String status = rs.getString(8);
				
				list.add( new ListaObjeto(idListaObjeto, idLoja, dsListaObjeto, campo1, campo2, campo3, campo4, status));
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