package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;

import afero.model.ListaServico;
import afero.util.ConverteDate;


public class ListaServicoDAO {
	public Connection conn;

	public ListaServicoDAO(Connection conn) {
		this.conn = conn;
	}
	
	// INSERIR
	
	public void incluir(ListaServico listaServico) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (listaServico == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");
		
		try {
			String sql = "INSERT INTO tbListaServico ( idLoja, dsListaServico, cdListaServico, preco, idUnidade, status, dtCad, dtMod, usuario)" +
						"VALUES ( ?, ?, ?, ?, ?, ?, now(), now(), ?)";
			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, listaServico.getIdLoja());
			ps.setString(2, listaServico.getDsListaServico());
			ps.setInt(3, listaServico.getCdListaServico());
			ps.setFloat(4, listaServico.getPreco());
			ps.setInt(5, listaServico.getIdUnidade());
			ps.setString(6, listaServico.getStatus());
			ps.setString(7, listaServico.getUsuario());
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
	
	public void atualiza(ListaServico listaServico) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (listaServico == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");
		
		try {
			String sql = "UPDATE tbListaServico SET idLoja = ?, dsListaServico = ?, cdListaServico = ?, preco = ?, idUnidade = ?, status = ?," +
						" dtCad = ?, dtMod = now(), usuario = ?" +
						" WHERE idListaServico = ?";
			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, listaServico.getIdLoja());
			ps.setString(2, listaServico.getDsListaServico());
			ps.setInt(3, listaServico.getCdListaServico());
			ps.setFloat(4, listaServico.getPreco());
			ps.setInt(5, listaServico.getIdUnidade());
			ps.setString(6, listaServico.getStatus());
			ps.setDate(7, ConverteDate.DateToDateSql(listaServico.getDtCad()));
			ps.setString(8, listaServico.getUsuario());
			ps.setInt(9, listaServico.getIdListaServico());
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
	
	public void excluir(ListaServico listaServico) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (listaServico == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbListaServico WHERE idListaServico = ?");
			ps.setInt(1, listaServico.getIdListaServico());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);
		}
	}
	
	// BUSCAR
	
	public ListaServico procurarListaServico(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		ListaServico listaServico = null;
		
		try {
			String sql = "SELECT idListaServico, idLoja, dsListaServico, cdListaServico, preco, idUnidade, status, dtCad, dtMod, usuario" +
						" FROM tbListaServico ";
			
			if(clausula != null)
				sql += clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				
				listaServico = new ListaServico();
				
				listaServico.setIdListaServico(rs.getInt(1));
				listaServico.setIdLoja(rs.getInt(2));
				listaServico.setDsListaServico(rs.getString(3));
				listaServico.setCdListaServico(rs.getInt(4));
				listaServico.setPreco(rs.getFloat(5));
				listaServico.setIdUnidade(rs.getInt(6));
				listaServico.setStatus(rs.getString(7));
				listaServico.setDtCad(rs.getDate(8));
				listaServico.setDtMod(rs.getDate(9));
				listaServico.setUsuario(rs.getString(10));	

			}
		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao procurar dados:" + sqle);
		}catch (Exception e){
			throw new AferoDAOException ("Erro ao procurar dados:" + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);
		}
		return listaServico;
	}
	
	// LISTAR
	
	public List<ListaServico> listarListaServico(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<ListaServico> list = null;
		
		try {
			String sql = "SELECT idListaServico, idLoja, dsListaServico, cdListaServico, preco, idUnidade, status, dtCad, dtMod, usuario" +
						" FROM tblistaservico ";
						
			if (clausula != null)
				sql += clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<ListaServico>();
			
			while (rs.next()){
				
				int idListaServico = rs.getInt(1);
				int idLoja = rs.getInt(2);
				String dsListaServico = rs.getString(3);
				int cdListaServico = rs.getInt(4);
				float preco = rs.getFloat(5);
				int idUnidade = rs.getInt(6);
				String status = rs.getString(7);
				Date dtCad = rs.getDate(8);
				Date dtMod = rs.getDate(9);
				String usuario = rs.getString(10);
					
				list.add( new ListaServico(idListaServico, idLoja, dsListaServico, cdListaServico, preco, idUnidade, status, dtCad, dtMod, usuario));						
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