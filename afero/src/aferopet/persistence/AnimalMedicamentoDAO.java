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
import aferopet.model.AnimalMedicamento;

public class AnimalMedicamentoDAO implements IAnimalMedicamentoDAO {
	
	private Connection conn;

	public AnimalMedicamentoDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;		
	}

	public void incluir(AnimalMedicamento animalMedicamento) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (animalMedicamento == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbanimalMedicamento (idAnimalMedicamento, idAnimalFicha, idMedicamento, nrLote, dtFab, dtVal, dtMod, usuario) "
					+ "VALUES (?, ?, ?, ?, ?, ?, now(), ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, animalMedicamento.getIdAnimalMedicamento());
			ps.setInt(2, animalMedicamento.getIdAnimalFicha());
			ps.setInt(3, animalMedicamento.getIdMedicamento());
			ps.setString(4, animalMedicamento.getNrLote());
			ps.setDate(5, ConverteDate.DateToDateSql(animalMedicamento.getDtFab()));
			ps.setDate(6, ConverteDate.DateToDateSql(animalMedicamento.getDtVal()));
			ps.setString(7, animalMedicamento.getUsuario());			
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao atualizar dados: " + e);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}
	}

	public void atualizar(AnimalMedicamento animalMedicamento) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (animalMedicamento == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbanimalMedicamento SET idAnimalMedicamento = ?, idAnimalFicha = ?, idMedicamento = ?, nrLote = ?, dtFab = ?, dtVal = ?, dtMod = ?, usuario = ? "
					+ "WHERE idanimalMedicamento = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, animalMedicamento.getIdAnimalMedicamento());
			ps.setInt(2, animalMedicamento.getIdAnimalFicha());
			ps.setInt(3, animalMedicamento.getIdMedicamento());
			ps.setString(4, animalMedicamento.getNrLote());
			ps.setDate(5, ConverteDate.DateToDateSql(animalMedicamento.getDtFab()));
			ps.setDate(6, ConverteDate.DateToDateSql(animalMedicamento.getDtVal()));
			ps.setString(7, animalMedicamento.getUsuario());	
			ps.setInt(8, animalMedicamento.getIdAnimalMedicamento());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao atualizar dados: " + e);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}
	}

	public void excluir(AnimalMedicamento animalMedicamento) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (animalMedicamento == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbanimalMedicamento WHERE idAnimalMedicamento = ?");
			ps.setInt(1, animalMedicamento.getIdAnimalMedicamento());
			ps.executeUpdate();

		}catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		}finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}
	
	public AnimalMedicamento procurarAnimalMedicamento(int idAnimalMedicamento) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		AnimalMedicamento animalMedicamento = null;

		try {
			String sql = "SELECT idAnimalMedicamento, idAnimalFicha, idMedicamento, nrLote, dtFab, dtVal, dtMod, usuario FROM tbanimalMedicamento "
				+ "WHERE idAnimalMedicamento=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idAnimalMedicamento);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + idAnimalMedicamento);
			}
            
			int idAnimalFicha = rs.getInt(2);
			int idMedicamento = rs.getInt(3);
			String nrLote  = rs.getString(4);
			Date dtFab = rs.getDate(5);
			Date dtVal = rs.getDate(6);
			Date dtMod = rs.getDate(7);
			String usuario  = rs.getString(8);			
				
			animalMedicamento = new AnimalMedicamento(idAnimalMedicamento, idAnimalFicha, idMedicamento, nrLote, dtFab, dtVal, dtMod, usuario);
			
			
		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return animalMedicamento;
	}

	public List<AnimalMedicamento> listarAnimalMedicamento(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<AnimalMedicamento> list = null;
		
		try {
			String sql = "SELECT idAnimalMedicamento, idAnimalFicha, idMedicamento, nrLote, dtFab, dtVal, dtMod, usuario FROM tbanimalMedicamento ";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<AnimalMedicamento>();
			while (rs.next()) {
				
				int idAnimalMedicamento = rs.getInt(2);
				int idAnimalFicha = rs.getInt(2);
				int idMedicamento = rs.getInt(3);
				String nrLote  = rs.getString(4);
				Date dtFab = rs.getDate(5);
				Date dtVal = rs.getDate(6);
				Date dtMod = rs.getDate(7);
				String usuario  = rs.getString(8);	
								
				list.add(new AnimalMedicamento(idAnimalMedicamento, idAnimalFicha, idMedicamento, nrLote, dtFab, dtVal, dtMod, usuario ));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
}
