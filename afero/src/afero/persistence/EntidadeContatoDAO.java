package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import afero.model.EntidadeContato;
import afero.util.ConverteDate;

public class EntidadeContatoDAO implements IEntidadeContatoDAO {
	
	private Connection conn;

	public EntidadeContatoDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;
	}

	public void incluir(EntidadeContato entidadeContato) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (entidadeContato == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbentidadecontato (cdEntidade, cdTipoNivel, nmContato, dtNascimento, " +
							"cargo, departamento, sexo, telefone1, ramal1, "+
							"telefone2, ramal2, fax, celular, "+
							"email, hobby, time, "+
							"status, dtMod, usuario) "+
							"VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now(), ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, entidadeContato.getCdEntidade());
			ps.setInt(2, entidadeContato.getCdTipoNivel());
			ps.setString(3, entidadeContato.getNmContato());
			ps.setDate(4, ConverteDate.DateToDateSql(entidadeContato.getDtNascimento()));
			ps.setString(5, entidadeContato.getCargo());
			ps.setString(6, entidadeContato.getDepartamento());
			ps.setString(7, entidadeContato.getSexo());
			ps.setString(8, entidadeContato.getTelefone1());
			ps.setString(9, entidadeContato.getRamal1());
			ps.setString(10, entidadeContato.getTelefone2());
			ps.setString(11, entidadeContato.getRamal2());
			ps.setString(12, entidadeContato.getFax());
			ps.setString(13, entidadeContato.getCelular());
			ps.setString(14, entidadeContato.getEmail());
			ps.setString(15, entidadeContato.getHobby());
			ps.setString(16, entidadeContato.getTime());
			ps.setString(17, entidadeContato.getStatus());
			ps.setString(18, entidadeContato.getUsuario());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}
	}

	public void atualizar(EntidadeContato entidadeContato) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (entidadeContato == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbentidadecontato SET cdEntidade = ?, cdTipoNivel = ?, nmContato = ?, dtNascimento = ?, " +
							"cargo = ?, departamento = ?, sexo = ?, telefone1 = ?, ramal1 = ?, "+
							"telefone2 = ?, ramal2 = ?, fax = ?, celular = ?, "+
							"email = ?, hobby = ?, time = ?, "+
							"status = ?, dtMod = now(), usuario = ? Where idEntidadeContato = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, entidadeContato.getCdEntidade());
			ps.setInt(2, entidadeContato.getCdTipoNivel());
			ps.setString(3, entidadeContato.getNmContato());
			ps.setDate(4, ConverteDate.DateToDateSql(entidadeContato.getDtNascimento()));
			ps.setString(5, entidadeContato.getCargo());
			ps.setString(6, entidadeContato.getDepartamento());
			ps.setString(7, entidadeContato.getSexo());
			ps.setString(8, entidadeContato.getTelefone1());
			ps.setString(9, entidadeContato.getRamal1());
			ps.setString(10, entidadeContato.getTelefone2());
			ps.setString(11, entidadeContato.getRamal2());
			ps.setString(12, entidadeContato.getFax());
			ps.setString(13, entidadeContato.getCelular());
			ps.setString(14, entidadeContato.getEmail());
			ps.setString(15, entidadeContato.getHobby());
			ps.setString(16, entidadeContato.getTime());
			ps.setString(17, entidadeContato.getStatus());
			ps.setString(18, entidadeContato.getUsuario());
			ps.setInt(19, entidadeContato.getIdEntidadeContato());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao atualizar dados: " + e);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}
	}

	public void excluir(EntidadeContato entidadeContato) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (entidadeContato == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbentidadecontato WHERE idEntidadeContato = ?");
			ps.setInt(1, entidadeContato.getIdEntidadeContato());
			ps.executeUpdate();

		}catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		}finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}
	}

	public EntidadeContato procurarEntidadeContato(int cdEntidade) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		EntidadeContato entidadeContato= null;

		try {
			String sql = "SELECT idEntidadeContato, cdEntidade, cdTipoNivel, nmContato, dtNascimento, " +
							"cargo, departamento, sexo, telefone1, ramal1, "+
							"telefone2, ramal2, fax, celular, "+
							"email, hobby, time, "+
							"status, dtMod, usuario FROM tbentidadecontato " +
							"WHERE cdEntidade=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cdEntidade);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + cdEntidade);
			}
            
			int idEntidadeContato = rs.getInt(1);
			cdEntidade = rs.getInt(2);
			int cdTipoNivel = rs.getInt(3);
			String nmContato = rs.getString(4);
			Date dtNascimento = rs.getDate(5);
			String cargo = rs.getString(6);
			String departamento = rs.getString(7);
			String sexo = rs.getString(8);
			String telefone1 = rs.getString(9);
			String ramal1 = rs.getString(10);
			String telefone2 = rs.getString(11);
			String ramal2 = rs.getString(12);
			String fax = rs.getString(13);
			String celular = rs.getString(14);
			String email = rs.getString(15);
			String hobby = rs.getString(16);
			String time = rs.getString(17);
			String status = rs.getString(18);
			Date dtMod = rs.getDate(19);
			String usuario = rs.getString(20);

		    entidadeContato = new EntidadeContato(idEntidadeContato, cdEntidade, cdTipoNivel, nmContato, dtNascimento,
		    		cargo, departamento, sexo, telefone1, ramal1, 
		    		telefone2, ramal2, fax, celular,
		    		email, hobby, time,
		    		status, dtMod, usuario);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return entidadeContato;
	}
	public List listarEntidadeContato(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<EntidadeContato> list = null;
		
		try {
			String sql = "SELECT ec.idEntidadeContato, ec.cdEntidade, ec.cdTipoNivel, ec.nmContato, ec.dtNascimento, " +
							"ec.cargo, ec.departamento, ec.sexo, ec.telefone1, ec.ramal1, " +
							"ec.telefone2, ec.ramal2, ec.fax, ec.celular, " +
							"ec.email, ec.hobby, ec.time, " +
							"ec.status, ec.dtMod, ec.usuario " +
							"FROM tbentidadecontato ec " +
						"JOIN tbtiponivel tn on (tn.cdTipoNivel = ec.cdTiponivel) " +
						"JOIN tbentidade e on (e.cdEntidade = ec.cdEntidade) ";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<EntidadeContato>();
			while (rs.next()) {
				
				int idEntidadeContato = rs.getInt(1);
				int cdEntidade = rs.getInt(2);
				int cdTipoNivel = rs.getInt(3);
				String nmContato = rs.getString(4);
				Date dtNascimento = rs.getDate(5);
				String cargo = rs.getString(6);
				String departamento = rs.getString(7);
				String sexo = rs.getString(8);
				String telefone1 = rs.getString(9);
				String ramal1 = rs.getString(10);
				String telefone2 = rs.getString(11);
				String ramal2 = rs.getString(12);
				String fax = rs.getString(13);
				String celular = rs.getString(14);
				String email = rs.getString(15);
				String hobby = rs.getString(16);
				String time = rs.getString(17);
				String status = rs.getString(18);
				Date dtMod = rs.getDate(19);
				String usuario = rs.getString(20);
				
				list.add(new EntidadeContato(idEntidadeContato, cdEntidade, cdTipoNivel, nmContato, dtNascimento, 
			    		cargo, departamento, sexo, telefone1, ramal1, 
			    		telefone2, ramal2, fax, celular,
			    		email, hobby, time,
						status, dtMod, usuario));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	public boolean pesquisarEntidadeContato(int cdEntidade) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		EntidadeContato entidadeContato= null;
		boolean ok = true;

		try {
			String sql = "SELECT idEntidadeContato, cdEntidade, cdTipoNivel, nmContato, dtNascimento, " +
							"cargo, departamento, sexo, telefone1, ramal1, "+
							"telefone2, ramal2, fax, celular, "+
							"email, hobby, time, "+
							"status, dtMod, usuario FROM tbentidadecontato " +
							"WHERE cdEntidade=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cdEntidade);
			rs = ps.executeQuery();
			if (!rs.next()) {
				ok=false;
			}
          

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return ok;
	}

}
