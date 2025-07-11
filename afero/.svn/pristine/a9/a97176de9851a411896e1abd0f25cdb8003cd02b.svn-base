package afero.persistence;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import afero.model.Entrega;

public class EntregaDAO implements IEntregaDAO{
	
	private Connection conn;

	public EntregaDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;
	}

	public void incluir(Entrega entrega) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (entrega == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbentrega(dsEntrega, txEntrega, dtCad, dtMod, usuario) "
					+ "VALUES (?, ?, now(), now(), ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, entrega.getDsEntrega());
			ps.setFloat(2, entrega.getTxEntrega());
			ps.setString(3, entrega.getUsuario());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(Entrega entrega) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (entrega == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbentrega SET dsEntrega = ?, txEntrega = ?, dtMod = now(), usuario = ? " +
					     "WHERE idEntrega = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, entrega.getDsEntrega());
			ps.setFloat(2, entrega.getTxEntrega());
			ps.setString(3, entrega.getUsuario());
			ps.setInt(4, entrega.getIdEntrega());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void excluir(Entrega entrega) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (entrega == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbentrega WHERE idEntrega=?");
			ps.setInt(1, entrega.getIdEntrega());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public Entrega procurarEntrega(int idEntrega) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		Entrega entrega = null;

		try {
			String sql = "SELECT dsEntrega, txEntrega, dtCad, dtMod, usuario FROM tbentrega " +
				         "WHERE idEntrega = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idEntrega);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o cód.setor: " + idEntrega);
			}
            
			String dsEntrega = rs.getString(1);
			float txEntrega = rs.getFloat(2);
			Date dtCad = rs.getDate(3);
			Date dtMod = rs.getDate(4);
			String usuario = rs.getString(5);

			entrega = new Entrega(idEntrega, dsEntrega, txEntrega, dtCad, dtMod, usuario);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return entrega;
	}

	public List listarEntrega(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<Entrega> list = null;
		
		try {
			String sql = "SELECT idEntrega, dsEntrega, txEntrega, dtCad, dtMod, usuario FROM tbentrega ";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<Entrega>();
			while (rs.next()) {
				int idEntrega = rs.getInt(1);
				String dsEntrega = rs.getString(2);
				float txEntrega = rs.getFloat(3);
				Date dtCad = rs.getDate(4);
				Date dtMod = rs.getDate(5);
				String usuario = rs.getString(6);
				
				list.add(new Entrega(idEntrega, dsEntrega, txEntrega, dtCad, dtMod, usuario));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}

	public boolean exclusaoIdEntrega(int idEntrega) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = true;
		try {
			String sql = "select idEntrega from tbpedidosaida where idEntrega = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idEntrega);
			rs = ps.executeQuery();
			if(rs.next()) {
			   ok=true;
			}else{
				ok=false;
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return ok;
		
	}
	public boolean getIdEntregaAtu(int idEntrega) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = true;
		try {
			String sql = "select idEntrega from tbpedidosaida where idEntrega = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idEntrega);
			rs = ps.executeQuery();
			if(rs.next()) {
			   ok=true;
			}else{
				ok=false;
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return ok;
		
	}
}
