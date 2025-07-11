package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import afero.model.EntidadeJuridica;
import afero.util.ConverteDate;

public class EntidadeJuridicaDAO implements IEntidadeJuridicaDAO {

	private Connection conn;

	public EntidadeJuridicaDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;
	}

	public void incluir(EntidadeJuridica entidadeJuridica)
			throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (entidadeJuridica == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbentidadejuridica (cdEntidade, cnpj, razaoSocial, dtAbertura, inscEstadual, codCnae) values(?, ?, ?, ?, ?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, entidadeJuridica.getCdEntidade());
			ps.setString(2, entidadeJuridica.getCnpj());
			ps.setString(3, entidadeJuridica.getRazaoSocial());
			ps.setDate(4, ConverteDate.DateToDateSql(entidadeJuridica.getDtAbertura()));
			ps.setString(5, entidadeJuridica.getInscEstadual());
			ps.setString(6, entidadeJuridica.getCodCnae());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(EntidadeJuridica entidadeJuridica)
			throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (entidadeJuridica == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbentidadejuridica SET cdEntidade = ?, cnpj = ?, razaoSocial = ?, dtAbertura = ?, inscEstadual = ?, codCnae = ? "+
			                                            "WHERE cdEntidade = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, entidadeJuridica.getCdEntidade());
			ps.setString(2, entidadeJuridica.getCnpj());
			ps.setString(3, entidadeJuridica.getRazaoSocial());
			ps.setDate(4, ConverteDate.DateToDateSql(entidadeJuridica.getDtAbertura()));
			ps.setString(5, entidadeJuridica.getInscEstadual());
			ps.setString(6, entidadeJuridica.getCodCnae());
			ps.setInt(7, entidadeJuridica.getCdEntidade());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao atualizar dados: " + e);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}
	}

	public void excluir(EntidadeJuridica entidadeJuridica)
			throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (entidadeJuridica == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");
		try {
			conn = this.conn;
			ps = conn
					.prepareStatement("DELETE FROM tbentidadejuridica WHERE cdEntidade = ?");
			ps.setString(1, entidadeJuridica.getCnpj());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}
	}

	public EntidadeJuridica procurarEntidadeJuridica(int cdEntidade) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		EntidadeJuridica entidadeJuridica = null;

		try {
			String sql = "SELECT cdEntidade, cnpj, razaoSocial, dtAbertura, inscEstadual, codCnae "+
	               			"FROM tbentidadejuridica "+
	               			"WHERE cdEntidade = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cdEntidade);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + cdEntidade);
			}

			String cnpj = rs.getString(2);
			String razaoSocial = rs.getString(3);
			Date dtAbertura = rs.getDate(4);
			String inscEstadual = rs.getString(5);
			String codCnae = rs.getString(6);
			
			entidadeJuridica = new EntidadeJuridica(cdEntidade, cnpj, razaoSocial, dtAbertura, inscEstadual, codCnae);
			
		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return entidadeJuridica;

	}

	public List listarEntidadesJuridica(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<EntidadeJuridica> list = null;

		try {
			String sql = "SELECT distinct(j.cdEntidade), j.cnpj, j.razaoSocial, j.dtabertura, j.inscEstadual, j.codCnae, "+
            	                "e.nome, e.tpInsc, e.site, e.status, "+
            	                "e.observacao, e.bloqueio, "+
            	                "e.dtMod, e.dtCad, e.usuario "+
                            "FROM tbentidadejuridica j "+
					        "JOIN tbentidade e ON j.cdEntidade = e.cdEntidade "+
			                "JOIN tbentidadeendereco end ON e.cdEntidade = end.cdEntidade ";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<EntidadeJuridica>();
			while (rs.next()) {
				int cdEntidade = rs.getInt(1);
				String cnpj = rs.getString(2);
				String razaoSocial = rs.getString(3);
				Date dtAbertura = rs.getDate(4);
				String inscEstadual = rs.getString(5);
				String codCnae = rs.getString(6);
			    String nome = rs.getString(7);
			    String tpInsc = rs.getString(8);
			    String site = rs.getString(9);
			    String status = rs.getString(10);
			    String observacao = rs.getString(11);
			    String bloqueio = rs.getString(12);
			    Date dtMod = rs.getDate(13);
			    Date dtCad = rs.getDate(14);
			    String usuario = rs.getString(15);
				
				list.add(new EntidadeJuridica(cdEntidade, nome,
						tpInsc, site, status, observacao, bloqueio,
						dtMod, dtCad, usuario, 
						cnpj, razaoSocial, dtAbertura, 
						inscEstadual, codCnae));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}

	public int procurarCnpj(String cnpj) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		int cdEntidade = 0;

		try {
			String sql = "SELECT cdEntidade FROM tbentidadejuridica WHERE cnpj = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, cnpj);
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