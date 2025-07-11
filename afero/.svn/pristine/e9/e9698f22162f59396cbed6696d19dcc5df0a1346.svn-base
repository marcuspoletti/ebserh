package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import afero.model.EntidadeEndereco;

public class EntidadeEnderecoDAO implements IEntidadeEnderecoDAO {
	
	private Connection conn;

	public EntidadeEnderecoDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;
	}

	public void incluir(EntidadeEndereco entidadeEndereco)
			throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (entidadeEndereco == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			String sql;
			if (entidadeEndereco.getPadrao().equals("S")) {
				sql = "UPDATE tbentidadeendereco SET padrao = 'N' "+
	             "WHERE cdEntidade = ?";
				conn = this.conn;
				ps = conn.prepareStatement(sql);
				ps.setInt(1, entidadeEndereco.getCdEntidade());
				ps.executeUpdate();				
			}
			sql = "INSERT INTO tbentidadeendereco (cdEntidade, cdTipoEndereco, " +
			             "cdTipoLogradouro, idCidade, dsEndereco, nroEndereco, cmpEndereco, baiEndereco, " +
			             "cepEndereco, cxpEndereco, refEndereco, "+
			             "padrao, dtMod, usuario) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now(), ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, entidadeEndereco.getCdEntidade());
			ps.setInt(2, entidadeEndereco.getCdTipoEndereco());
			ps.setInt(3, entidadeEndereco.getCdTipoLogradouro());
			ps.setInt(4, entidadeEndereco.getIdCidade());
			ps.setString(5, entidadeEndereco.getDsEndereco());
			ps.setString(6, entidadeEndereco.getNroEndereco());
			ps.setString(7, entidadeEndereco.getCmpEndereco());
			ps.setString(8, entidadeEndereco.getBaiEndereco());
			ps.setString(9, entidadeEndereco.getCepEndereco());
			ps.setString(10,entidadeEndereco.getCxpEndereco());
			ps.setString(11,entidadeEndereco.getRefEndereco());
			ps.setString(12,entidadeEndereco.getPadrao());
			ps.setString(13,entidadeEndereco.getUsuario());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}
	public void incluirPizzaria(EntidadeEndereco entidadeEndereco)throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (entidadeEndereco == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			String sql;
			if (entidadeEndereco.getPadrao().equals("S")) {
				sql = "UPDATE tbentidadeendereco SET padrao = 'N' "+
				"WHERE cdEntidade = ?";
				conn = this.conn;
				ps = conn.prepareStatement(sql);
				ps.setInt(1, entidadeEndereco.getCdEntidade());
				ps.executeUpdate();				
			}
			sql = "INSERT INTO tbentidadeendereco (cdEntidade, cdTipoEndereco, " +
	             "cdTipoLogradouro, idCidade, dsEndereco, nroEndereco, cmpEndereco, baiEndereco, " +
	             "cepEndereco, cxpEndereco, refEndereco, "+
	             "padrao, dtMod, usuario, idEntrega) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now(), ?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, entidadeEndereco.getCdEntidade());
			ps.setInt(2, entidadeEndereco.getCdTipoEndereco());
			ps.setInt(3, entidadeEndereco.getCdTipoLogradouro());
			ps.setInt(4, entidadeEndereco.getIdCidade());
			ps.setString(5, entidadeEndereco.getDsEndereco());
			ps.setString(6, entidadeEndereco.getNroEndereco());
			ps.setString(7, entidadeEndereco.getCmpEndereco());
			ps.setString(8, entidadeEndereco.getBaiEndereco());
			ps.setString(9, entidadeEndereco.getCepEndereco());
			ps.setString(10,entidadeEndereco.getCxpEndereco());
			ps.setString(11,entidadeEndereco.getRefEndereco());
			ps.setString(12,entidadeEndereco.getPadrao());
			ps.setString(13,entidadeEndereco.getUsuario());
			ps.setInt(14,entidadeEndereco.getIdEntrega());
			ps.executeUpdate();
		}catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} finally {
	//ConnectionFactory.closeConnection(conn, ps);
		}
	}

	public void atualizar(EntidadeEndereco entidadeEndereco)
			throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (entidadeEndereco == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbentidadeendereco SET cdEntidade = ?, cdTipoEndereco = ?, " +
			             "cdTipoLogradouro = ?, idCidade = ?, dsEndereco = ?, nroEndereco = ?, cmpEndereco = ?, baiEndereco = ?, " +
			             "cepEndereco = ?, cxpEndereco = ?, refEndereco = ?, "+
			             "padrao = ?, dtMod = now(), usuario = ? "+
			             "WHERE idEntidadeEndereco = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, entidadeEndereco.getCdEntidade());
			ps.setInt(2, entidadeEndereco.getCdTipoEndereco());
			ps.setInt(3, entidadeEndereco.getCdTipoLogradouro());
			ps.setInt(4, entidadeEndereco.getIdCidade());
			ps.setString(5, entidadeEndereco.getDsEndereco());
			ps.setString(6, entidadeEndereco.getNroEndereco());
			ps.setString(7, entidadeEndereco.getCmpEndereco());
			ps.setString(8, entidadeEndereco.getBaiEndereco());
			ps.setString(9, entidadeEndereco.getCepEndereco());
			ps.setString(10,entidadeEndereco.getCxpEndereco());
			ps.setString(11,entidadeEndereco.getRefEndereco());
			ps.setString(12,entidadeEndereco.getPadrao());
			ps.setString(13,entidadeEndereco.getUsuario());
			ps.setInt(14, entidadeEndereco.getIdEntidadeEndereco());
			ps.executeUpdate();
			if (entidadeEndereco.getPadrao().equals("S")) {
				sql = "UPDATE tbentidadeendereco SET padrao = 'N' "+
	             "WHERE cdEntidade = ? and idEntidadeEndereco <> ?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, entidadeEndereco.getCdEntidade());
				ps.setInt(2, entidadeEndereco.getIdEntidadeEndereco());
				ps.executeUpdate();				
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}
	}

	public void atualizarPizzaria(EntidadeEndereco entidadeEndereco)
			throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (entidadeEndereco == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbentidadeendereco SET cdEntidade = ?, cdTipoEndereco = ?, " +
			             "cdTipoLogradouro = ?, idCidade = ?, dsEndereco = ?, nroEndereco = ?, cmpEndereco = ?, baiEndereco = ?, " +
			             "cepEndereco = ?, cxpEndereco = ?, refEndereco = ?, "+
			             "padrao = ?, dtMod = now(), usuario = ?, idEntrega = ? "+
			             "WHERE idEntidadeEndereco = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, entidadeEndereco.getCdEntidade());
			ps.setInt(2, entidadeEndereco.getCdTipoEndereco());
			ps.setInt(3, entidadeEndereco.getCdTipoLogradouro());
			ps.setInt(4, entidadeEndereco.getIdCidade());
			ps.setString(5, entidadeEndereco.getDsEndereco());
			ps.setString(6, entidadeEndereco.getNroEndereco());
			ps.setString(7, entidadeEndereco.getCmpEndereco());
			ps.setString(8, entidadeEndereco.getBaiEndereco());
			ps.setString(9, entidadeEndereco.getCepEndereco());
			ps.setString(10,entidadeEndereco.getCxpEndereco());
			ps.setString(11,entidadeEndereco.getRefEndereco());
			ps.setString(12,entidadeEndereco.getPadrao());
			ps.setString(13,entidadeEndereco.getUsuario());
			ps.setInt(14,entidadeEndereco.getIdEntrega());
			ps.setInt(15, entidadeEndereco.getIdEntidadeEndereco());
			ps.executeUpdate();
			if (entidadeEndereco.getPadrao().equals("S")) {
				sql = "UPDATE tbentidadeendereco SET padrao = 'N' "+
	             "WHERE cdEntidade = ? and idEntidadeEndereco <> ?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, entidadeEndereco.getCdEntidade());
				ps.setInt(2, entidadeEndereco.getIdEntidadeEndereco());
				ps.executeUpdate();				
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}
	}
	public void excluir(EntidadeEndereco entidadeEndereco)
			throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (entidadeEndereco == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");
		try {
			conn = this.conn;
			ps = conn
					.prepareStatement("DELETE FROM tbentidadeendereco WHERE idEntidadeEndereco = ?");
			ps.setInt(1, entidadeEndereco.getIdEntidadeEndereco());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}
	}

	public EntidadeEndereco procurarEntidadeEndereco(int idEntidadeEndereco) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		EntidadeEndereco entidadeEndereco = null;

		try {
			String sql = "SELECT idEntidadeEndereco, cdEntidade, cdTipoEndereco, " +
			             "cdTipoLogradouro, idCidade, dsEndereco, nroEndereco, cmpEndereco, baiEndereco, " +
			             "cepEndereco, cxpEndereco, refEndereco, "+
			             "padrao, dtMod, usuario " +
	               "FROM tbentidadeendereco " +
	              "WHERE idEntidadeEndereco = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idEntidadeEndereco);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + idEntidadeEndereco);
			}
			
			int cdEntidade = rs.getInt(2);
			int cdTipoEndereco = rs.getInt(3);
            int cdTipoLogradouro = rs.getInt(4);
            int idCidade = rs.getInt(5);
            String dsEndereco = rs.getString(6);
            String nroEndereco = rs.getString(7);
            String cmpEndereco = rs.getString(8);
            String baiEndereco = rs.getString(9);
            String cepEndereco = rs.getString(10);
            String cxPostal = rs.getString(11);
            String referencia = rs.getString(12);
            String padrao = rs.getString(13);
            Date dtMod = rs.getDate(14);
            String usuario = rs.getString(15);
			
			entidadeEndereco = new EntidadeEndereco(idEntidadeEndereco, cdEntidade, cdTipoEndereco, 
		             cdTipoLogradouro, idCidade, dsEndereco, nroEndereco, cmpEndereco, baiEndereco, 
		             cepEndereco, cxPostal, referencia, 
		             padrao, dtMod, usuario);
			
		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return entidadeEndereco;

	}

	public List listarEntidadeEndereco(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<EntidadeEndereco> list = null;

		try {
			String sql = "SELECT ed.idEntidadeEndereco, ed.cdEntidade, ed.cdTipoEndereco, ed.cdTipoLogradouro, ed.idCidade, ed.dsEndereco, ed.nroEndereco, ed.cmpEndereco, ed.baiEndereco, "+ 
			             	"ed.cepEndereco, ed.cxpEndereco, ed.refEndereco, " +
			             	"ed.padrao, ed.dtMod, ed.usuario " +
			             	"FROM tbentidadeendereco ed " +
			             	"JOIN tbtipoendereco te on (te.cdTipoEndereco = ed.cdTipoEndereco) " +
			             	"JOIN tbentidade e on (e.cdEntidade = ed.cdEntidade) ";
			if (clausula != null) sql = sql + clausula;
			/*
			sql +=		 " JOIN tbentidade e on (ed.cdEntidade = e.cdEntidade) " +
					     "JOIN tbtipoendereco en on (en.cdTipoEndereco = ed.cdTipoEndereco) " +
					     "JOIN tbtipologradouro tl on (ed.cdTipoLogradouro = tl.cdTipoLogradouro)";
			*/
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<EntidadeEndereco>();
			while (rs.next()) {
				int idEntidadeEndereco = rs.getInt(1);
				int cdEntidade = rs.getInt(2);
				int cdTipoEndereco = rs.getInt(3);
	            int cdTipoLogradouro = rs.getInt(4);
	            int idCidade = rs.getInt(5);
	            String dsEndereco = rs.getString(6);
	            String nroEndereco = rs.getString(7);
	            String cmpEndereco = rs.getString(8);
	            String baiEndereco = rs.getString(9);
	            String cepEndereco = rs.getString(10);
	            String cxPostal = rs.getString(11);
	            String referencia = rs.getString(12);
	            String padrao = rs.getString(13);
	            Date dtMod = rs.getDate(14);
	            String usuario = rs.getString(15);
				
				list.add(new EntidadeEndereco(idEntidadeEndereco, cdEntidade, cdTipoEndereco, 
			             cdTipoLogradouro, idCidade, dsEndereco, nroEndereco, cmpEndereco, baiEndereco, 
			             cepEndereco, cxPostal, referencia, 
			             padrao, dtMod, usuario));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}

	public List listarEntidadeEnderecoPizzaria(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<EntidadeEndereco> list = null;

		try {
			String sql = "SELECT ed.idEntidadeEndereco, ed.cdEntidade, ed.cdTipoEndereco, ed.cdTipoLogradouro, ed.idCidade, ed.dsEndereco, ed.nroEndereco, ed.cmpEndereco, ed.baiEndereco, "+ 
			             	"ed.cepEndereco, ed.cxpEndereco, ed.refEndereco, " +
			             	"ed.padrao, ed.dtMod, ed.usuario, ed.idEntrega " +
			             	"FROM tbentidadeendereco ed " +
			             	"JOIN tbtipoendereco te on (te.cdTipoEndereco = ed.cdTipoEndereco) " +
			             	"JOIN tbentidade e on (e.cdEntidade = ed.cdEntidade) ";
			if (clausula != null) sql = sql + clausula;
			/*
			sql +=		 " JOIN tbentidade e on (ed.cdEntidade = e.cdEntidade) " +
					     "JOIN tbtipoendereco en on (en.cdTipoEndereco = ed.cdTipoEndereco) " +
					     "JOIN tbtipologradouro tl on (ed.cdTipoLogradouro = tl.cdTipoLogradouro)";
			*/
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<EntidadeEndereco>();
			while (rs.next()) {
				int idEntidadeEndereco = rs.getInt(1);
				int cdEntidade = rs.getInt(2);
				int cdTipoEndereco = rs.getInt(3);
	            int cdTipoLogradouro = rs.getInt(4);
	            int idCidade = rs.getInt(5);
	            String dsEndereco = rs.getString(6);
	            String nroEndereco = rs.getString(7);
	            String cmpEndereco = rs.getString(8);
	            String baiEndereco = rs.getString(9);
	            String cepEndereco = rs.getString(10);
	            String cxPostal = rs.getString(11);
	            String referencia = rs.getString(12);
	            String padrao = rs.getString(13);
	            Date dtMod = rs.getDate(14);
	            String usuario = rs.getString(15);
	            int idEntrega = rs.getInt(16);
				
				list.add(new EntidadeEndereco(idEntidadeEndereco, cdEntidade, cdTipoEndereco, 
			             cdTipoLogradouro, idCidade, dsEndereco, nroEndereco, cmpEndereco, baiEndereco, 
			             cepEndereco, cxPostal, referencia, 
			             padrao, dtMod, usuario, idEntrega));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}

	public EntidadeEndereco procurarEntidadeEnderecoPadrao(int cdEntidade) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		EntidadeEndereco entidadeEndereco = null;

		try {
			String sql = "SELECT idEntidadeEndereco, cdEntidade, cdTipoEndereco, " +
			             "cdTipoLogradouro, idCidade, dsEndereco, nroEndereco, cmpEndereco, baiEndereco, " +
			             "cepEndereco, cxpEndereco, refEndereco, "+
			             "padrao, dtMod, usuario " +
	               "FROM tbentidadeendereco " +
	              "WHERE (cdEntidade = ?) and (padrao = 'S')";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cdEntidade);
			rs = ps.executeQuery();
			if (!rs.next()) {
				entidadeEndereco  = new EntidadeEndereco();
				entidadeEndereco.setCdEntidade(cdEntidade);
				entidadeEndereco.setCdTipoEndereco(1);
				entidadeEndereco.setCdTipoLogradouro(34);
				entidadeEndereco.setIdCidade(1);
				entidadeEndereco.setDsEndereco(" ");
				entidadeEndereco.setPadrao("S");
				entidadeEndereco.setUsuario("afero");
				incluir(entidadeEndereco);
				//throw new AferoDAOException("Não foi encontrado nenhum "
				//		+ "registro com o código: " + cdEntidade);
			} else {
			
			  int idEntidadeEndereco = rs.getInt(1);
			  int cdTipoEndereco = rs.getInt(3);
              int cdTipoLogradouro = rs.getInt(4);
              int idCidade = rs.getInt(5);
              String dsEndereco = rs.getString(6);
              String nroEndereco = rs.getString(7);
              String cmpEndereco = rs.getString(8);
              String baiEndereco = rs.getString(9);
              String cepEndereco = rs.getString(10);
              String cxPostal = rs.getString(11);
              String referencia = rs.getString(12);
              String padrao = rs.getString(13);
              Date dtMod = rs.getDate(14);
              String usuario = rs.getString(15);
			
			  entidadeEndereco = new EntidadeEndereco(idEntidadeEndereco, cdEntidade, cdTipoEndereco, 
		             cdTipoLogradouro, idCidade, dsEndereco, nroEndereco, cmpEndereco, baiEndereco, 
		             cepEndereco, cxPostal, referencia, 
		             padrao, dtMod, usuario);
			}
			
		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return entidadeEndereco;

	}
	public EntidadeEndereco procurarEntidadeEnderecoPadraoPizzaria(int cdEntidade) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		EntidadeEndereco entidadeEndereco = null;

		try {
			String sql = "SELECT idEntidadeEndereco, cdEntidade, cdTipoEndereco, " +
			             "cdTipoLogradouro, idCidade, dsEndereco, nroEndereco, cmpEndereco, baiEndereco, " +
			             "cepEndereco, cxpEndereco, refEndereco, "+
			             "padrao, dtMod, usuario, idEntrega " +
	               "FROM tbentidadeendereco " +
	              "WHERE (cdEntidade = ?) and (padrao = 'S')";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cdEntidade);
			rs = ps.executeQuery();
			if (!rs.next()) {
				entidadeEndereco  = new EntidadeEndereco();
				entidadeEndereco.setCdEntidade(cdEntidade);
				entidadeEndereco.setCdTipoEndereco(1);
				entidadeEndereco.setCdTipoLogradouro(34);
				entidadeEndereco.setIdCidade(1);
				entidadeEndereco.setDsEndereco(" ");
				entidadeEndereco.setPadrao("S");
				entidadeEndereco.setUsuario("afero");
				incluir(entidadeEndereco);
				//throw new AferoDAOException("Não foi encontrado nenhum "
				//		+ "registro com o código: " + cdEntidade);
			} else {
			
			  int idEntidadeEndereco = rs.getInt(1);
			  int cdTipoEndereco = rs.getInt(3);
              int cdTipoLogradouro = rs.getInt(4);
              int idCidade = rs.getInt(5);
              String dsEndereco = rs.getString(6);
              String nroEndereco = rs.getString(7);
              String cmpEndereco = rs.getString(8);
              String baiEndereco = rs.getString(9);
              String cepEndereco = rs.getString(10);
              String cxPostal = rs.getString(11);
              String referencia = rs.getString(12);
              String padrao = rs.getString(13);
              Date dtMod = rs.getDate(14);
              String usuario = rs.getString(15);
              int idEntrega = rs.getInt(16);
			
			  entidadeEndereco = new EntidadeEndereco(idEntidadeEndereco, cdEntidade, cdTipoEndereco, 
		             cdTipoLogradouro, idCidade, dsEndereco, nroEndereco, cmpEndereco, baiEndereco, 
		             cepEndereco, cxPostal, referencia, 
		             padrao, dtMod, usuario, idEntrega);
			}
			
		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return entidadeEndereco;

	}

}
