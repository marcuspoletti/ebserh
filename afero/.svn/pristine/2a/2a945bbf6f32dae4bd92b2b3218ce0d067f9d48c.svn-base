package aferopet.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import afero.persistence.AferoDAOException;
import afero.util.ConverteDate;
import aferopet.model.AnimalRetorno;

public class AnimalRetornoDAO implements IAnimalRetornoDAO {
	
	private Connection conn;

	public AnimalRetornoDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;		
	}

	public void incluir(AnimalRetorno animalRetorno) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (animalRetorno == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbanimalRetorno (idAnimalRetorno, idAnimal, dtRetorno, descricao, lembrete, avisoTempo, avisoUnidade, status, dtMod, usuario) "
					+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, now(), ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, animalRetorno.getIdAnimalRetorno());
			ps.setInt(2, animalRetorno.getIdAnimal());
			ps.setDate(3, ConverteDate.DateToDateSql(animalRetorno.getDtRetorno()));
			ps.setString(4, animalRetorno.getDescricao());
			ps.setString(5, animalRetorno.getLembrete());
			ps.setInt(6, animalRetorno.getAvisoTempo());
			ps.setString(7, animalRetorno.getAvisoUnidade());
			ps.setString(8, animalRetorno.getStatus());
			ps.setString(9, animalRetorno.getUsuario());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao atualizar dados: " + e);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}
	}

	public void atualizar(AnimalRetorno animalRetorno) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (animalRetorno == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbanimalRetorno SET idAnimalRetorno = ?, idAnimal = ?, dtRetorno = ?, descricao = ?, lembrete = ?, avisoTempo = ?, avisoUnidade = ?, status = ?, dtMod = now(), usuario = ? "
					+ "WHERE idanimalRetorno = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, animalRetorno.getIdAnimalRetorno());
			ps.setInt(2, animalRetorno.getIdAnimal());
			ps.setDate(3, ConverteDate.DateToDateSql(animalRetorno.getDtRetorno()));
			ps.setString(4, animalRetorno.getDescricao());
			ps.setString(5, animalRetorno.getLembrete());
			ps.setInt(6, animalRetorno.getAvisoTempo());
			ps.setString(7, animalRetorno.getAvisoUnidade());
			ps.setString(8, animalRetorno.getStatus());
			ps.setString(9, animalRetorno.getUsuario());
			ps.setInt(10, animalRetorno.getIdAnimalRetorno());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao atualizar dados: " + e);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}
	}

	public void excluir(AnimalRetorno animalRetorno) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (animalRetorno == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbanimalRetorno WHERE idAnimalRetorno = ?");
			ps.setInt(1, animalRetorno.getIdAnimalRetorno());
			ps.executeUpdate();

		}catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		}finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}
	
	public AnimalRetorno procurarAnimalRetorno(int idAnimalRetorno) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		AnimalRetorno animalRetorno = null;

		try {
			String sql = "SELECT idAnimalRetorno, idAnimal, dtRetorno, descricao, lembrete, avisoTempo, avisoUnidade, status, dtMod, usuario FROM tbanimalRetorno "
				+ "WHERE idAnimalRetorno=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idAnimalRetorno);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + idAnimalRetorno);
			}
            
			int idAnimal = rs.getInt(2);
			Date dtRetorno = rs.getDate(3);
			String descricao  = rs.getString(4);
			String lembrete  = rs.getString(5);
			int avisoTempo = rs.getInt(6);
			String avisoUnidade = rs.getString(7);
			String status = rs.getString(8);
			Date dtMod = rs.getDate(9);
			String usuario  = rs.getString(10);
				
			animalRetorno = new AnimalRetorno(idAnimalRetorno, idAnimal, dtRetorno, descricao, lembrete, avisoTempo, avisoUnidade, status, dtMod, usuario);
			
			
		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return animalRetorno;
	}

	public List<AnimalRetorno> listarAnimalRetorno(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<AnimalRetorno> list = null;
		
		try {
			String sql = "SELECT idAnimalRetorno, idAnimal, dtRetorno, descricao, lembrete, avisoTempo, avisoUnidade, status, dtMod, usuario FROM tbanimalRetorno ";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<AnimalRetorno>();
			while (rs.next()) {
				
				int idAnimalRetorno = rs.getInt(1);
				int idAnimal = rs.getInt(2);
				Date dtRetorno = rs.getDate(3);
				String descricao  = rs.getString(4);
				String lembrete  = rs.getString(5);
				int avisoTempo = rs.getInt(6);
				String avisoUnidade = rs.getString(7);
				String status = rs.getString(8);
				Date dtMod = rs.getDate(9);
				String usuario  = rs.getString(10);
								
				list.add(new AnimalRetorno(idAnimalRetorno, idAnimal, dtRetorno, descricao, lembrete, avisoTempo, avisoUnidade, status, dtMod, usuario));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
}
