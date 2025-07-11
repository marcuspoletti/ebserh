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
import aferopet.model.Animal;

public class AnimalDAO implements IAnimalDAO {
	
	private Connection conn;

	public AnimalDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;		
	}

	public void incluir(Animal animal) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (animal == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbanimal (idAnimal, cdEntidade, nmAnimal, cdTipoEspecie, idTipoRaca, dtNascimento, sexo, porte, cor, registro, microchip, passaporte, origem, estado, alergia, observacao, pedigree, obito, status, dtCad, dtMod, usuario) "
					+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now(), now(), ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, animal.getIdAnimal());
			ps.setInt(2, animal.getCdEntidade());
			ps.setString(3, animal.getNmAnimal());
			ps.setInt(4, animal.getCdTipoEspecie());
			ps.setInt(5, animal.getIdTipoRaca());
			ps.setDate(6, ConverteDate.DateToDateSql(animal.getDtNascimento()));
			ps.setString(7, animal.getSexo());
			ps.setString(8, animal.getPorte());
			ps.setString(9, animal.getCor());
			ps.setString(10, animal.getRegistro());
			ps.setString(11, animal.getMicrochip());
			ps.setString(12, animal.getPassaporte());
			ps.setString(13, animal.getOrigem());
			ps.setString(14, animal.getEstado());
			ps.setString(15, animal.getAlergia());
			ps.setString(16, animal.getObservacao());
			ps.setString(17, animal.getPedigree());
			ps.setString(18, animal.getObito());
			ps.setString(19, animal.getStatus());
			ps.setString(20, animal.getUsuario());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao atualizar dados: " + e);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}
	}

	public void atualizar(Animal animal) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (animal == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbanimal SET idAnimal = ?, cdEntidade = ?, nmAnimal = ?, cdTipoEspecie = ?, idTipoRaca = ?, dtNascimento = ?, sexo = ?, porte = ?, cor = ?, registro = ?, microchip = ?, passaporte = ?, origem = ?, estado = ?, alergia = ?, observacao = ?, pedigree = ?, obito = ?, status = ?, dtMod = now(), usuario = ? "
					+ "WHERE idanimal=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, animal.getIdAnimal());
			ps.setInt(2, animal.getCdEntidade());
			ps.setString(3, animal.getNmAnimal());
			ps.setInt(4, animal.getCdTipoEspecie());
			ps.setInt(5, animal.getIdTipoRaca());
			ps.setDate(6, ConverteDate.DateToDateSql(animal.getDtNascimento()));
			ps.setString(7, animal.getSexo());
			ps.setString(8, animal.getPorte());
			ps.setString(9, animal.getCor());
			ps.setString(10, animal.getRegistro());
			ps.setString(11, animal.getMicrochip());
			ps.setString(12, animal.getPassaporte());
			ps.setString(13, animal.getOrigem());
			ps.setString(14, animal.getEstado());
			ps.setString(15, animal.getAlergia());
			ps.setString(16, animal.getObservacao());
			ps.setString(17, animal.getPedigree());
			ps.setString(18, animal.getObito());
			ps.setString(19, animal.getStatus());
			ps.setString(20, animal.getUsuario());
			ps.setInt(21, animal.getIdAnimal());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao atualizar dados: " + e);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}
	}

	public void excluir(Animal animal) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (animal == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbanimal WHERE idAnimal = ?");
			ps.setInt(1, animal.getIdAnimal());
			ps.executeUpdate();

		}catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		}finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}
	
	public Animal procurarAnimal(int idAnimal) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		Animal animal = null;

		try {
			String sql = "SELECT idAnimal, cdEntidade, nmAnimal, cdTipoEspecie, idTipoRaca, dtNascimento, sexo, porte, cor, registro, microchip, passaporte, origem, estado, alergia, observacao, pedigree, obito, status, dtCad, dtMod, usuario FROM tbanimal "
				+ "WHERE idAnimal=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idAnimal);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + idAnimal);
			}
            
			int cdEntidade = rs.getInt(2);
			String nmAnimal  = rs.getString(3);
			int cdTipoEspecie = rs.getInt(4);
			int idTipoRaca = rs.getInt(5);
			Date dtNascimento= rs.getDate(6);
			String sexo  = rs.getString(7);
			String porte  = rs.getString(8);
			String cor  = rs.getString(9);
			String registro  = rs.getString(10);
			String microchip  = rs.getString(11);
			String passaporte  = rs.getString(12);
			String origem  = rs.getString(13);
			String estado  = rs.getString(14);
			String alergia  = rs.getString(15);
			String observacao  = rs.getString(16);
			String pedigree  = rs.getString(17);
			String obito  = rs.getString(18);
			String status  = rs.getString(19);
			Date dtCad = rs.getDate(20);
			Date dtMod = rs.getDate(21);			
			String usuario  = rs.getString(22);
			
			animal = new Animal(idAnimal, cdEntidade, nmAnimal, cdTipoEspecie, idTipoRaca, dtNascimento, sexo, porte, cor, registro, microchip, passaporte, origem, estado, alergia, observacao, pedigree, obito, status, dtCad, dtMod, usuario);
			
		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return animal;
	}

	public List<Animal> listarAnimal(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<Animal> list = null;
		
		try {
			String sql = "SELECT a.idAnimal, a.cdEntidade, a.nmAnimal, a.cdTipoEspecie, a.idTipoRaca, a.dtNascimento, a.sexo, a.porte, a.cor, a.registro, a.microchip, a.passaporte, a.origem, a.estado, a.alergia, a.observacao, a.pedigree, a.obito, a.status, a.dtCad, a.dtMod, a.usuario FROM tbanimal a " +
            "join tbentidade e on(a.cdEntidade = e.cdEntidade) ";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<Animal>();
			while (rs.next()) {
				
				int idAnimal = rs.getInt(1);
				int cdEntidade = rs.getInt(2);
				String nmAnimal  = rs.getString(3);
				int cdTipoEspecie = rs.getInt(4);
				int idTipoRaca = rs.getInt(5);
				Date dtNascimento= rs.getDate(6);
				String sexo  = rs.getString(7);
				String porte  = rs.getString(8);
				String cor  = rs.getString(9);
				String registro  = rs.getString(10);
				String microchip  = rs.getString(11);
				String passaporte  = rs.getString(12);
				String origem  = rs.getString(13);
				String estado  = rs.getString(14);
				String alergia  = rs.getString(15);
				String observacao  = rs.getString(16);
				String pedigree  = rs.getString(17);
				String obito  = rs.getString(18);
				String status  = rs.getString(19);
				Date dtCad = rs.getDate(20);
				Date dtMod = rs.getDate(21);			
				String usuario  = rs.getString(22);
				
				list.add(new Animal(idAnimal, cdEntidade, nmAnimal, cdTipoEspecie, idTipoRaca, dtNascimento, sexo, porte, cor, registro, microchip, passaporte, origem, estado, alergia, observacao, pedigree, obito, status, dtCad, dtMod, usuario));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}

	public boolean exclusaoIdAnimal(int idAnimal) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = true;

		try {
			String sql = "select a.idAnimal from tbanimal a " +
                         "join tbanimalficha af on(a.idAnimal = af.idAnimal) " +
                         "where a.idAnimal = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idAnimal);
			rs = ps.executeQuery();
			if (rs.next()) {
				ok = true;
			}else{
				ok = false;
				sql = "select a.idAnimal from tbanimal a " +
                "join tbanimalretorno ar on(a.idAnimal = ar.idAnimal) " +
                "where a.idAnimal = ?";
				//conn = this.conn;
				ps = conn.prepareStatement(sql);
				ps.setInt(1, idAnimal);
				rs = ps.executeQuery();
				if (rs.next()) {
					ok = true;
				}else{
					ok = false;
				}
			}
            
		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return ok;
	}

}
