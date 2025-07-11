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
import aferopet.model.AnimalFicha;

public class AnimalFichaDAO implements IAnimalFichaDAO {
	
	private Connection conn;

	public AnimalFichaDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;		
	}

	public void incluir(AnimalFicha animalFicha) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (animalFicha == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbanimalFicha (idAnimalFicha, idAnimal, dtAtend, descricao, peso, altura, observacao, exame, tipoAtividade, dtMod, usuario) "
					+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, now(), ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, animalFicha.getIdAnimalFicha());
			ps.setInt(2, animalFicha.getIdAnimal());
			ps.setDate(3, ConverteDate.DateToDateSql(animalFicha.getDtAtend()));
			ps.setString(4, animalFicha.getDescricao());
			ps.setInt(5, animalFicha.getPeso());
			ps.setInt(6, animalFicha.getAltura());
			ps.setString(7, animalFicha.getObservacao());
			ps.setString(8, animalFicha.getExame());
			ps.setString(9, animalFicha.getTipoAtividade());
			ps.setString(10, animalFicha.getUsuario());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao atualizar dados: " + e);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}
	}

	public void atualizar(AnimalFicha animalFicha) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (animalFicha == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbanimalFicha SET idAnimalFicha = ?, idAnimal = ?, dtAtend = ?, descricao = ?, peso = ?, altura = ?, observacao = ?, exame = ?, tipoAtividade = ?, dtMod = now(), usuario = ? "
					+ "WHERE idanimalFicha = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, animalFicha.getIdAnimalFicha());
			ps.setInt(2, animalFicha.getIdAnimal());
			ps.setDate(3, ConverteDate.DateToDateSql(animalFicha.getDtAtend()));
			ps.setString(4, animalFicha.getDescricao());
			ps.setInt(5, animalFicha.getPeso());
			ps.setInt(6, animalFicha.getAltura());
			ps.setString(7, animalFicha.getObservacao());
			ps.setString(8, animalFicha.getExame());
			ps.setString(9, animalFicha.getTipoAtividade());
			ps.setString(10, animalFicha.getUsuario());
			ps.setInt(11, animalFicha.getIdAnimalFicha());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao atualizar dados: " + e);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}
	}

	public void excluir(AnimalFicha animalFicha) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (animalFicha == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbanimalFicha WHERE idAnimalFicha = ?");
			ps.setInt(1, animalFicha.getIdAnimalFicha());
			ps.executeUpdate();

		}catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		}finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}
	
	public AnimalFicha procurarAnimalFicha(int idAnimalFicha) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		AnimalFicha animalFicha = null;

		try {
			String sql = "SELECT idAnimalFicha, idAnimal, dtAtend, descricao, peso, altura, observacao, exame, tipoAtividade, dtMod, usuario FROM tbanimalficha "
				+ "WHERE idAnimalFicha=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idAnimalFicha);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + idAnimalFicha);
			}
            
			int idAnimal = rs.getInt(2);
			Date dtAtend = rs.getDate(3);
			String descricao  = rs.getString(4);
			int peso = rs.getInt(5);
			int altura = rs.getInt(6);
			String observacao  = rs.getString(7);
			String exame  = rs.getString(8);
			String tipoAtividade  = rs.getString(9);
			Date dtMod = rs.getDate(10);
			String usuario  = rs.getString(11);
			
			animalFicha = new AnimalFicha(idAnimalFicha, idAnimal, dtAtend, descricao, peso, altura, observacao, exame, tipoAtividade, dtMod, usuario);
			
			
		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return animalFicha;
	}

	public List<AnimalFicha> listarAnimalFicha(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<AnimalFicha> list = null;
		
		try {
			String sql = "SELECT idAnimalFicha, idAnimal, dtAtend, descricao, peso, altura, observacao, exame, tipoAtividade, dtMod, usuario FROM tbanimalficha ";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<AnimalFicha>();
			while (rs.next()) {
				
				int idAnimalFicha = rs.getInt(1);
				int idAnimal = rs.getInt(2);
				Date dtAtend = rs.getDate(3);
				String descricao  = rs.getString(4);
				int peso = rs.getInt(5);
				int altura = rs.getInt(6);
				String observacao  = rs.getString(7);
				String exame  = rs.getString(8);
				String tipoAtividade  = rs.getString(9);
				Date dtMod = rs.getDate(10);
				String usuario  = rs.getString(11);
				
				list.add(new AnimalFicha(idAnimalFicha, idAnimal, dtAtend, descricao, peso, altura, observacao, exame, tipoAtividade, dtMod, usuario));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	
	public boolean exclusaoIdAnimalFicha(int idAnimalFicha) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = true;

		try {
			String sql = "select af.idAnimalficha from tbanimalficha af " +
                         "join tbanimalmedicamento am on(af.idAnimalficha = am.idAnimalficha) " +
                         "where af.idAnimalficha = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idAnimalFicha);
			rs = ps.executeQuery();
			if (rs.next()) {
				ok = true;
			}else{
				ok = false;
			}
            
		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return ok;
	}

}
