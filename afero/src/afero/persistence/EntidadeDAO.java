package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;
import java.util.ArrayList;

import afero.model.ClienteMaiorQuantVenda;
import afero.model.Entidade;
import afero.model.Aniversariantes;
import afero.util.ConverteDate;

public class EntidadeDAO {
	
	private Connection conn;

	public EntidadeDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;
	}

	public int incluir(Entidade entidade) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		int cdEntidade = 0;
		if (entidade == null)
			throw new AferoDAOException("O valor passado n�o pode ser nulo");
		
		if (entidade.getCdEntidade() == 0)
			cdEntidade = proximoCdEntidade();
		entidade.setCdEntidade(cdEntidade);
		
		try {
			String sql = "INSERT INTO tbEntidade (cdEntidade, nome, tpInsc, site, status, observacao, bloqueio, dtMod, dtCad, usuario) "
					+ "VALUES (?, ?, ?, ?, ?, ?, ?, now(), now(), ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, entidade.getCdEntidade());
			ps.setString(2, entidade.getNome());
			ps.setString(3, entidade.getTpInsc());
			ps.setString(4, entidade.getSite());
			ps.setString(5, entidade.getStatus());
			ps.setString(6, entidade.getObservacao());
			ps.setString(7, entidade.getBloqueio());
			ps.setString(8, entidade.getUsuario());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}
		return cdEntidade;
	}

	public void atualizar(Entidade entidade) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (entidade == null)
			throw new AferoDAOException(
					"O valor passado n�o pode ser nulo");

		try {
			String sql = "UPDATE tbEntidade SET nome = ?, tpInsc = ?, site = ? , status = ?, "+
							"observacao = ?, bloqueio = ?, usuario = ?, dtMod = now() WHERE cdEntidade = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, entidade.getNome());
			ps.setString(2, entidade.getTpInsc());;
			ps.setString(3, entidade.getSite());;
			ps.setString(4, entidade.getStatus());
			ps.setString(5, entidade.getObservacao());
			ps.setString(6, entidade.getBloqueio());
			ps.setString(7, entidade.getUsuario());
			ps.setInt(8, entidade.getCdEntidade());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}
	}

	public void excluir(Entidade entidade) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (entidade == null)
			throw new AferoDAOException(
					"O valor passado n�o pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbEntidade WHERE cdEntidade=?");
			ps.setInt(1, entidade.getCdEntidade());
			ps.executeUpdate();

		}catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		}finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}
	}

	public Entidade procurarEntidade(int cdEntidade) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		Entidade entidade = null;

		try {
			String sql = "SELECT cdEntidade, nome, tpInsc, site, status, "
				+ "observacao, bloqueio, dtMod, dtCad, usuario FROM tbentidade "
				+ "WHERE cdEntidade=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cdEntidade);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("N�o foi encontrado nenhum "
						+ "registro com o c�digo: " + cdEntidade);
			}
		    String nome = rs.getString(2);
		    String tpInsc = rs.getString(3);
		    String site = rs.getString(4);
		    String status = rs.getString(5);
		    String observacao = rs.getString(6);
		    String bloqueio = rs.getString(7);
		    Date dtMod = rs.getDate(8);
		    Date dtCad = rs.getDate(9);
		    String usuario = rs.getString(10);

			entidade = new Entidade(cdEntidade, nome, tpInsc, site, status, observacao, bloqueio, dtMod, dtCad, usuario);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return entidade;
	}

	public List listarEntidade(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<Entidade> list = null;
		
		try {
			String sql = "SELECT cdEntidade, nome, tpInsc, site, status,"+
							"observacao, bloqueio, dtMod, dtCad, usuario FROM tbentidade ";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<Entidade>();
			while (rs.next()) {
				int cdEntidade = rs.getInt(1);
			    String nome = rs.getString(2);
			    String tpInsc = rs.getString(3);
			    String site = rs.getString(4);
			    String status = rs.getString(5);
			    String observacao = rs.getString(6);
			    String bloqueio = rs.getString(7);
			    Date dtMod = rs.getDate(8);
			    Date dtCad = rs.getDate(9);
			    String usuario = rs.getString(10);
				
				list.add(new Entidade(cdEntidade, nome, tpInsc, site, status, 
						observacao, bloqueio, dtMod, dtCad, usuario));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}

	private int proximoCdEntidade() throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		int cdEntidade = 0;

		try {
			String sql = "SELECT MAX(cdEntidade) FROM tbentidade ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("N�o foi encontrado nenhum registro");
			}
            
			cdEntidade = rs.getInt(1);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return cdEntidade+1;
	}
	
	public List listarAniversariantesFisica(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<Aniversariantes> list = null;
		
		try {
			String sql = "SELECT e.cdEntidade, e.nome, ef.dtNascimento" +
					     " FROM tbentidadefisica ef"+
                         " JOIN tbentidade e on ef.cdEntidade = e.cdEntidade ";
			if (clausula != null) sql = sql + clausula;			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<Aniversariantes>();
			while (rs.next()) {
				int cdEntidade     = rs.getInt(1);
				String nomeCliente  = rs.getString(2);
				Date dataNascimento  = rs.getDate(3);
				String email = null;
				
				list.add(new Aniversariantes(cdEntidade, nomeCliente, dataNascimento, email));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return list;
	}
	public List listarAniversariantesJuridica(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<Aniversariantes> list = null;
		
		try {
			String sql = "SELECT e.cdEntidade, e.nome, ej.dtAbertura" +
					     " FROM tbentidadejuridica ej"+
                         " JOIN tbentidade e on ej.cdEntidade = e.cdEntidade ";
			if (clausula != null) sql = sql + clausula;			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<Aniversariantes>();
			while (rs.next()) {
				int cdEntidade     = rs.getInt(1);
				String nomeCliente  = rs.getString(2);
				Date dataNascimento  = rs.getDate(3);
				String email = null;
				
				list.add(new Aniversariantes(cdEntidade, nomeCliente, dataNascimento, email));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return list;
	}
	public String dataAtual() throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		String dataAtual = "";
		
		try {
			String sql = "select now();";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if (rs.next()) {
				dataAtual = ConverteDate.dateToString(rs.getDate(1));
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return dataAtual;
	}
	
}



