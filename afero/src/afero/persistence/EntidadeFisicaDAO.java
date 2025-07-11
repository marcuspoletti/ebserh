package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import afero.model.EntidadeFisica;
import afero.util.ConverteDate;

public class EntidadeFisicaDAO {
	
	private Connection conn;

	public EntidadeFisicaDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;
	}

	public void incluir(EntidadeFisica entidadeFisica) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (entidadeFisica == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbentidadefisica (cdEntidade, cpf, dtNascimento, dtCasamento, Cargo, "+
			                                           "departamento, empresa, sexo, cdEstadoCivil, cdEscolaridade, cpfConjuge, "+
			                                           "conjuge, mae, pai, nroRg, orgRg, ufRg, dtRg, hobby, time) "+
			                                           "values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, entidadeFisica.getCdEntidade());
			ps.setString(2, entidadeFisica.getCpf());
			ps.setDate(3, ConverteDate.DateToDateSql(entidadeFisica.getDtNascimento()));
			ps.setDate(4, ConverteDate.DateToDateSql(entidadeFisica.getDtCasamento()));
			ps.setString(5, entidadeFisica.getCargo());
			ps.setString(6, entidadeFisica.getDepartamento());
			ps.setString(7, entidadeFisica.getEmpresa());
			ps.setString(8, entidadeFisica.getSexo());
			ps.setInt(9, entidadeFisica.getCdEstadoCivil());
			ps.setInt(10, entidadeFisica.getCdEscolaridade());
			ps.setString(11, entidadeFisica.getCpfConjuge());
			ps.setString(12, entidadeFisica.getConjuge());
			ps.setString(13, entidadeFisica.getMae());
			ps.setString(14, entidadeFisica.getPai());
			ps.setString(15, entidadeFisica.getNroRg());
			ps.setString(16, entidadeFisica.getOrgRg());
			ps.setString(17, entidadeFisica.getUfRg());
			ps.setDate(18, ConverteDate.DateToDateSql(entidadeFisica.getDtRg()));
			ps.setString(19, entidadeFisica.getHobby());
			ps.setString(20, entidadeFisica.getTime());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(EntidadeFisica entidadeFisica) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (entidadeFisica == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbentidadefisica SET cdEntidade = ?, cpf = ?, dtNascimento = ?, dtCasamento = ?, cargo = ?, " +
			                                          "departamento = ?, empresa = ?, sexo = ?, cdEstadoCivil = ?, cdEscolaridade = ?, " +
			                                          "cpfConjuge = ?, conjuge = ?, mae = ?,  pai = ?, nroRg = ?, orgRg = ?, ufRg = ?, " +
			                                          "dtRg = ?, hobby = ?, time = ? " +
					                                  "WHERE cdEntidade = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, entidadeFisica.getCdEntidade());
			ps.setString(2, entidadeFisica.getCpf());
			ps.setDate(3, ConverteDate.DateToDateSql(entidadeFisica.getDtNascimento()));
			ps.setDate(4, ConverteDate.DateToDateSql(entidadeFisica.getDtCasamento()));
			ps.setString(5, entidadeFisica.getCargo());
			ps.setString(6, entidadeFisica.getDepartamento());
			ps.setString(7, entidadeFisica.getEmpresa());
			ps.setString(8, entidadeFisica.getSexo());
			ps.setInt(9, entidadeFisica.getCdEstadoCivil());
			ps.setInt(10, entidadeFisica.getCdEscolaridade());
			ps.setString(11, entidadeFisica.getCpfConjuge());
			ps.setString(12, entidadeFisica.getConjuge());
			ps.setString(13, entidadeFisica.getMae());
			ps.setString(14, entidadeFisica.getPai());
			ps.setString(15, entidadeFisica.getNroRg());
			ps.setString(16, entidadeFisica.getOrgRg());
			ps.setString(17, entidadeFisica.getUfRg());
			ps.setDate(18, ConverteDate.DateToDateSql(entidadeFisica.getDtRg()));
			ps.setString(19, entidadeFisica.getHobby());
			ps.setString(20, entidadeFisica.getTime());
			ps.setInt(21, entidadeFisica.getCdEntidade());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao atualizar dados: " + e);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void excluir(EntidadeFisica entidadeFisica) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (entidadeFisica == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbentidadefisica WHERE cdEntidade = ?");
			ps.setInt(1, entidadeFisica.getCdEntidade());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public EntidadeFisica procurarEntidadeFisica(int cdEntidade) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		EntidadeFisica entidadeFisica = null;

		try {
			String sql = "SELECT cdEntidade, cpf, dtNascimento, dtCasamento, Cargo, "+
			                    "departamento, empresa, sexo, cdEstadoCivil, cdEscolaridade, cpfConjuge, "+
			                    "conjuge, mae, pai, nroRg, orgRg, ufRg, dtRg, hobby, time "+
			               "FROM tbentidadefisica "+
			              "WHERE cdEntidade = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cdEntidade);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + cdEntidade);
			}
            
			String cpf = rs.getString(2);
			Date dtNascimento = rs.getDate(3);
			Date dtCasamento = rs.getDate(4);
			String Cargo = rs.getString(5);
			String departamento = rs.getString(6); 
			String empresa = rs.getString(7);
			String sexo = rs.getString(8);
			int cdEstadoCivil = rs.getInt(9);
			int cdEscolaridade = rs.getInt(10);
			String cpfConjuge = rs.getString(11);
			String conjuge = rs.getString(12);
			String mae = rs.getString(13);
			String pai = rs.getString(14);
			String nroRg = rs.getString(15);
			String orgRg = rs.getString(16);
			String ufRg = rs.getString(17);
			Date dtRg = rs.getDate(18);
			String hobby = rs.getString(19);
			String time = rs.getString(20);

			entidadeFisica = new EntidadeFisica(cdEntidade, cpf, dtNascimento, dtCasamento, Cargo,
                    departamento, empresa, sexo, cdEstadoCivil, cdEscolaridade, cpfConjuge,
                    conjuge, mae, pai, nroRg, orgRg, ufRg, dtRg, hobby, time);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return entidadeFisica;
	}

	public List listarEntidadeFisica(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<EntidadeFisica> list = null;
		
		try {
			String sql = "SELECT distinct(f.cdEntidade), f.cpf, f.dtNascimento, f.dtCasamento, f.Cargo, " + 
                         		"f.departamento, f.empresa, f.sexo, f.cdEstadoCivil, f.cdEscolaridade, f.cpfConjuge, " +
                         		"f.conjuge, f.mae, f.pai, f.nroRg, f.orgRg, f.ufRg, " +
                         		"f.dtRg, f.hobby, f.time, " +
                         		"e.nome, e.tpInsc, e.site, e.observacao, e.bloqueio, " +
                         		"e.dtMod, e.dtCad, e.status, e.usuario " + 
                         	"FROM tbentidadefisica f " +
                         	"JOIN tbentidade e ON f.cdEntidade = e.cdEntidade " +
                         	"JOIN tbentidadeendereco end ON e.cdEntidade = end.cdEntidade ";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<EntidadeFisica>();
			while (rs.next()) {
				int cdEntidade = rs.getInt(1);
				String cpf = rs.getString(2);
				Date dtNascimento = rs.getDate(3);
				Date dtCasamento = rs.getDate(4);
				String Cargo = rs.getString(5);
				String departamento = rs.getString(6); 
				String empresa = rs.getString(7);
				String sexo = rs.getString(8);
				int cdEstadoCivil = rs.getInt(9);
				int cdEscolaridade = rs.getInt(10);
				String cpfConjuge = rs.getString(11);
				String conjuge = rs.getString(12);
				String mae = rs.getString(13);
				String pai = rs.getString(14);
				String nroRg = rs.getString(15);
				String orgRg = rs.getString(16);
				String ufRg = rs.getString(17);
				Date dtRg = rs.getDate(18);
				String hobby = rs.getString(19);
				String time = rs.getString(20);
			    String nome = rs.getString(21);
			    String tpInsc = rs.getString(22);
			    String site = rs.getString(23);
			    String observacao = rs.getString(24);
			    String bloqueio = rs.getString(25);
			    Date dtMod = rs.getDate(26);
			    Date dtCad = rs.getDate(27);
			    String status = rs.getString(28);
			    String usuario = rs.getString(29);
				
				list.add(new EntidadeFisica(cdEntidade, 
						nome, tpInsc, site, status, observacao, bloqueio, 
						dtMod, dtCad, usuario, 
						cpf, dtNascimento, dtCasamento,
						Cargo, departamento, empresa, sexo, cdEstadoCivil, cdEscolaridade, cpfConjuge,
						conjuge, mae, pai, nroRg, orgRg, ufRg, dtRg, hobby, time));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}

	public int procurarCpf(String cpf) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		int cdEntidade = 0;

		try {
			String sql = "SELECT cdEntidade FROM tbentidadefisica WHERE cpf = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, cpf);
			rs = ps.executeQuery();
			if (!rs.next()) {
				cdEntidade = 0;
			} else {
				cdEntidade = rs.getInt(1);	
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return cdEntidade;
	}

}
