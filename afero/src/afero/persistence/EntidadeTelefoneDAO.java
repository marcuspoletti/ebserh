package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import afero.model.EntidadeTelefone;

public class EntidadeTelefoneDAO implements IEntidadeTelefoneDAO {
	
	private Connection conn;

	public EntidadeTelefoneDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;
	}

	public void incluir(EntidadeTelefone entidadeTelefone) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (entidadeTelefone == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql;
			if (entidadeTelefone.getPadrao().equals("S")) {
				sql = "UPDATE tbentidadetelefone SET padrao = 'N' "+
	             "WHERE cdEntidade = ?";
				conn = this.conn;
				ps = conn.prepareStatement(sql);
				ps.setInt(1, entidadeTelefone.getCdEntidade());
				ps.executeUpdate();				
			}
			sql = "INSERT INTO tbentidadetelefone (cdEntidade, cdTipoTelefone, nroTelefone, ramTelefone, padrao, dtMod, usuario) "
					+ "VALUES (?, ?, ?, ?, ?, now(), ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, entidadeTelefone.getCdEntidade());
			ps.setInt(2, entidadeTelefone.getCdTipoTelefone());
			ps.setString(3, entidadeTelefone.getNroTelefone());
			ps.setString(4, entidadeTelefone.getRamTelefone());
			ps.setString(5, entidadeTelefone.getPadrao());
			ps.setString(6, entidadeTelefone.getUsuario());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(EntidadeTelefone entidadeTelefone) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (entidadeTelefone == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbentidadetelefone SET cdEntidade = ?, cdTipoTelefone = ?, nroTelefone = ?, ramTelefone = ?, padrao = ?, dtMod = now(), usuario = ? "
					+ "WHERE idEntidadeTelefone = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, entidadeTelefone.getCdEntidade());
			ps.setInt(2, entidadeTelefone.getCdTipoTelefone());
			ps.setString(3, entidadeTelefone.getNroTelefone());
			ps.setString(4, entidadeTelefone.getRamTelefone());
			ps.setString(5, entidadeTelefone.getPadrao());
			ps.setString(6, entidadeTelefone.getUsuario());
			ps.setInt(7, entidadeTelefone.getIdEntidadeTelefone());
			ps.executeUpdate();
			if (entidadeTelefone.getPadrao().equals("S")) {
				sql = "UPDATE tbentidadetelefone SET padrao = 'N' "+
	             "WHERE cdEntidade = ? and idEntidadeTelefone <> ?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, entidadeTelefone.getCdEntidade());
				ps.setInt(2, entidadeTelefone.getIdEntidadeTelefone());
				ps.executeUpdate();				
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void excluir(EntidadeTelefone entidadeTelefone) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (entidadeTelefone == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbentidadetelefone WHERE idEntidadeTelefone = ?");
			ps.setInt(1, entidadeTelefone.getIdEntidadeTelefone());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public EntidadeTelefone procurarEntidadeTelefone(int idEntidadeTelefone) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		EntidadeTelefone entidadeTelefone = null;

		try {
			String sql = "SELECT idEntidadeTelefone, cdEntidade, cdTipoTelefone, nroTelefone, ramTelefone, padrao, dtMod, usuario FROM tbentidadetelefone "
				+ "WHERE idEntidadeTelefone = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idEntidadeTelefone);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + idEntidadeTelefone);
			}
			int cdEntidade = rs.getInt(2);
			int cdTipoTelefone = rs.getInt(3);
		    String nroTelefone = rs.getString(4);
		    String ramTelefone = rs.getString(5);
		    String padrao      = rs.getString(6);
		    Date dtMod         = rs.getDate(7);
		    String usuario     = rs.getString(8);
			
			entidadeTelefone = new EntidadeTelefone(idEntidadeTelefone, cdEntidade, cdTipoTelefone, nroTelefone, ramTelefone, padrao, dtMod, usuario);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return entidadeTelefone;
	}

	public List listarEntidadeTelefone(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<EntidadeTelefone> list = null;
		
		try {
			String sql = "SELECT et.idEntidadeTelefone, et.cdEntidade, et.cdTipoTelefone, et.nroTelefone, et.ramTelefone, et.padrao, et.dtMod, et.usuario " +
					        "FROM tbentidadetelefone et " +
							"JOIN tbtipotelefone tt on (tt.cdTipoTelefone = et.cdTipoTelefone) " +
							"JOIN tbentidade e on (e.cdEntidade = et.cdEntidade) ";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<EntidadeTelefone>();
			while (rs.next()) {
				int idEntidadeTelefone = rs.getInt(1);
				int cdEntidade = rs.getInt(2);
				int cdTipoTelefone = rs.getInt(3);
			    String nroTelefone = rs.getString(4);
			    String ramTelefone = rs.getString(5);
			    String padrao      = rs.getString(6);
			    Date dtMod         = rs.getDate(7);
			    String usuario     = rs.getString(8);
				
				list.add(new EntidadeTelefone(idEntidadeTelefone, cdEntidade, cdTipoTelefone, nroTelefone, ramTelefone, padrao, dtMod, usuario));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}

	public EntidadeTelefone procurarEntidadeTelefonePadrao(int cdEntidade) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		EntidadeTelefone entidadeTelefone = null;

		try {
			String sql = "SELECT idEntidadeTelefone, cdEntidade, cdTipoTelefone, " +
			             "nroTelefone, ramTelefone, padrao, dtMod, usuario " +
			             "FROM tbentidadetelefone " +
			             "WHERE (cdEntidade = ?) and (padrao = 'S')";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cdEntidade);
			rs = ps.executeQuery();
			if (!rs.next()) {
				entidadeTelefone = new EntidadeTelefone();
				entidadeTelefone.setCdEntidade(cdEntidade);
				entidadeTelefone.setCdTipoTelefone(1);
				entidadeTelefone.setPadrao("S");
				entidadeTelefone.setUsuario("afero");
				incluir(entidadeTelefone);
				//throw new AferoDAOException("Não foi encontrado nenhum "
				//		+ "registro com o código: " + cdEntidade);
			} else {
			
			  int idEntidadeTelefone = rs.getInt(1);
			  int cdTipoTelefone = rs.getInt(3);
              String nroTelefone = rs.getString(4);
              String ramTelefone = rs.getString(5);
              String padrao = rs.getString(6);
              Date dtMod = rs.getDate(7);
              String usuario = rs.getString(8);

			  entidadeTelefone = new EntidadeTelefone(idEntidadeTelefone, cdEntidade, cdTipoTelefone, nroTelefone, ramTelefone, padrao, dtMod, usuario);
			}
			
		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return entidadeTelefone;

	}

	public List listarTelefone(int idEntidade) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<EntidadeTelefone> list = null;
		
		try {
			String sql = "SELECT idEntidadeTelefone, cdEntidade, cdTipoTelefone, nroTelefone, ramTelefone, padrao, dtMod, usuario FROM tbentidadetelefone "+
				         "WHERE cdEntidade = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idEntidade);
			rs = ps.executeQuery();
			list = new ArrayList<EntidadeTelefone>();
			while (rs.next()) {
				int idEntidadeTelefone = rs.getInt(1);
				int cdEntidade = rs.getInt(2);
				int cdTipoTelefone = rs.getInt(3);
			    String nroTelefone = rs.getString(4);
			    String ramTelefone = rs.getString(5);
			    String padrao      = rs.getString(6);
			    Date dtMod         = rs.getDate(7);
			    String usuario     = rs.getString(8);
				
				list.add(new EntidadeTelefone(idEntidadeTelefone, cdEntidade, cdTipoTelefone, nroTelefone, ramTelefone, padrao, dtMod, usuario));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	
	public List listarTresUltimosTelefones(int idEntidade) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<EntidadeTelefone> list = null;
		
		try {
			String sql = "SELECT idEntidadeTelefone, cdEntidade, cdTipoTelefone, nroTelefone, ramTelefone, padrao, dtMod, usuario FROM tbentidadetelefone "+
				         "WHERE cdEntidade = ? Order by dtMod desc limit 3";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idEntidade);
			rs = ps.executeQuery();
			list = new ArrayList<EntidadeTelefone>();
			while (rs.next()) {
				int idEntidadeTelefone = rs.getInt(1);
				int cdEntidade = rs.getInt(2);
				int cdTipoTelefone = rs.getInt(3);
			    String nroTelefone = rs.getString(4);
			    String ramTelefone = rs.getString(5);
			    String padrao      = rs.getString(6);
			    Date dtMod         = rs.getDate(7);
			    String usuario     = rs.getString(8);
				
				list.add(new EntidadeTelefone(idEntidadeTelefone, cdEntidade, cdTipoTelefone, nroTelefone, ramTelefone, padrao, dtMod, usuario));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}

}
