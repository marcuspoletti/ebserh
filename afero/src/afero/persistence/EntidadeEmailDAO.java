package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import afero.model.EntidadeEmail;

public class EntidadeEmailDAO implements IEntidadeEmailDAO {
	
	private Connection conn;

	// private ConverteDate converteDate = new ConverteDate();

	public EntidadeEmailDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;
	}

	public void incluir(EntidadeEmail entidadeEmail)
			throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (entidadeEmail == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			String sql;
			if (entidadeEmail.getPadrao().equals("S")) {
				sql = "UPDATE tbentidadeemail SET padrao = 'N' "+
	             "WHERE cdEntidade = ?";
				conn = this.conn;
				ps = conn.prepareStatement(sql);
				ps.setInt(1, entidadeEmail.getCdEntidade());
				ps.executeUpdate();				
			}
			sql = "INSERT INTO tbentidadeemail (cdEntidade, cdTipoEmail, dsEmail, padrao, dtMod, usuario) values(?, ?, ?, ?, now(), ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, entidadeEmail.getCdEntidade());
			ps.setInt(2, entidadeEmail.getCdTipoEmail());
			ps.setString(3, entidadeEmail.getDsEmail());
			ps.setString(4, entidadeEmail.getPadrao());
			ps.setString(5, entidadeEmail.getUsuario());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(EntidadeEmail entidadeEmail)
			throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (entidadeEmail == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbentidadeemail SET cdEntidade = ?, cdTipoEmail = ?, dsEmail = ?, padrao = ?, dtMod = now(), usuario = ? " +
			                                            "WHERE idEntidadeEmail = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, entidadeEmail.getCdEntidade());
			ps.setInt(2, entidadeEmail.getCdTipoEmail());
			ps.setString(3, entidadeEmail.getDsEmail());
			ps.setString(4, entidadeEmail.getPadrao());
			ps.setString(5, entidadeEmail.getUsuario());
			ps.setInt(6, entidadeEmail.getIdEntidadeEmail());
			ps.executeUpdate();
			if (entidadeEmail.getPadrao().equals("S")) {
				sql = "UPDATE tbentidadeemail SET padrao = 'N' "+
	             "WHERE cdEntidade = ? and idEntidadeEmail <> ?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, entidadeEmail.getCdEntidade());
				ps.setInt(2, entidadeEmail.getIdEntidadeEmail());
				ps.executeUpdate();				
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}
	}

	public void excluir(EntidadeEmail entidadeEmail)
			throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (entidadeEmail == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");
		try {
			conn = this.conn;
			ps = conn
					.prepareStatement("DELETE FROM tbentidadeemail WHERE idEntidadeEmail = ?");
			ps.setInt(1, entidadeEmail.getIdEntidadeEmail());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}
	}

	public EntidadeEmail procurarEntidadeEmail(int idEntidadeEmail) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		EntidadeEmail entidadeEmail = null;

		try {
			String sql = "SELECT idEntidadeEmail, cdEntidade, cdTipoEmail, dsEmail, padrao, dtMod, usuario "+
	               "FROM tbentidadeemail "+
	              "WHERE idEntidadeEmail = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idEntidadeEmail);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + idEntidadeEmail);
			}

			int cdEntidade = rs.getInt(2);
			int cdTipoEmail = rs.getInt(3);
			String dsEmail = rs.getString(4);
			String padrao = rs.getString(5);
			Date dtMod = rs.getDate(6);
			String usuario = rs.getString(7);
			
			entidadeEmail = new EntidadeEmail(idEntidadeEmail, cdEntidade, cdTipoEmail, dsEmail, padrao, dtMod, usuario);
			
		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return entidadeEmail;

	}

	public List listarEntidadeEmail(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<EntidadeEmail> list = null;

		try {
			String sql = "SELECT  en.idEntidadeEmail, en.cdEntidade, en.cdTipoEmail, en.dsEmail, en.padrao, en.dtMod, en.usuario " +
			             	"FROM tbentidadeemail en " +
            				"JOIN tbtipoemail te on (te.cdTipoEmail = en.cdTipoEmail) " +
            				"JOIN tbentidade e on (e.cdEntidade = en.cdEntidade) ";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<EntidadeEmail>();
			while (rs.next()) {
				
				int idEntidadeEmail = rs.getInt(1);
				int cdEntidade = rs.getInt(2);
				int cdTipoEmail = rs.getInt(3);
				String dsEmail = rs.getString(4);
				String padrao = rs.getString(5);
				Date dtMod = rs.getDate(6);
				String usuario = rs.getString(7);
				
				
				list.add(new EntidadeEmail(idEntidadeEmail, cdEntidade, cdTipoEmail, dsEmail, padrao, dtMod, usuario));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	
	public EntidadeEmail procurarEntidadeEmailPadrao(int cdEntidade) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		EntidadeEmail entidadeEmail = null;

		try {
			String sql = "SELECT idEntidadeEmail, cdEntidade, cdTipoEmail, " +
			             "dsEmail, padrao, dtMod, usuario " +
	               "FROM tbentidadeemail " +
	              "WHERE (cdEntidade = ?) and (padrao = 'S')";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cdEntidade);
			rs = ps.executeQuery();
			if (!rs.next()) {
				entidadeEmail = new EntidadeEmail();
				entidadeEmail.setCdEntidade(cdEntidade);
				entidadeEmail.setCdTipoEmail(1);
				entidadeEmail.setPadrao("S");
				entidadeEmail.setUsuario("afero");
				//throw new AferoDAOException("Não foi encontrado nenhum "
				//		+ "registro com o código: " + cdEntidade);
			} else {
			
			  int idEntidadeEmail = rs.getInt(1);
			  int cdTipoEmail = rs.getInt(3);
              String dsEmail = rs.getString(4);
              String padrao = rs.getString(5);
              Date dtMod = rs.getDate(6);
              String usuario = rs.getString(7);
			
			  entidadeEmail = new EntidadeEmail(idEntidadeEmail, cdEntidade, cdTipoEmail, 
		             							dsEmail, padrao, dtMod, usuario);
			}
			
		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return entidadeEmail;

	}

}
