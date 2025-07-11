package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import afero.model.Cidade;

public class CidadeDAO implements ICidadeDAO {
	
	private Connection conn;

	public CidadeDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;
	}

	public void incluir(Cidade cidade) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (cidade == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbcidade (cdEstado, nmCidade, cdMunicipio, status) "
					+ "VALUES (?, ?, ?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cidade.getCdEstado());
			ps.setString(2, cidade.getNmCidade());
			if (cidade.getCdMunicipio() != null)
				ps.setString(3, cidade.getCdMunicipio());
			else
				ps.setString(3, null);
			ps.setString(4, cidade.getStatus());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} 
	}

	public void atualizar(Cidade cidade) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (cidade == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbcidade SET cdEstado=?, nmCidade=?, cdMunicipio=?, status=? "
					+ "WHERE idCidade=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cidade.getCdEstado());
			ps.setString(2, cidade.getNmCidade());
			if (cidade.getCdMunicipio() != null)
				ps.setString(3, cidade.getCdMunicipio());
			else
				ps.setString(3, null);
			ps.setString(4, cidade.getStatus());
			ps.setInt(5, cidade.getIdCidade());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		}
	}

	public void excluir(Cidade cidade) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (cidade == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbcidade WHERE idCidade=?");
			ps.setInt(1, cidade.getIdCidade());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		}

	}

	public Cidade procurarCidade(int idCidade) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		Cidade cidade = null;

		try {
			String sql = "SELECT idCidade, cdEstado, nmCidade, cdMunicipio, status FROM tbcidade "
				+ "WHERE idCidade=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idCidade);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + idCidade);
			}
            
			int cdEstado = rs.getInt(2);
			String nmCidade  = rs.getString(3);
			String cdMunicipio = rs.getString(4);
			String status = rs.getString(5);

			cidade = new Cidade(idCidade, cdEstado, nmCidade, cdMunicipio, status);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return cidade;
	}

	public Cidade procurarMunicipio(String cdMunicipio) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		Cidade cidade = null;

		try {
			String sql = "SELECT idCidade, cdEstado, nmCidade, cdMunicipio, status FROM tbcidade "
				+ "WHERE cdMunicipio=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, cdMunicipio);
			rs = ps.executeQuery();
			if (rs.next()) {
				int idCidade = rs.getInt(1);
				int cdEstado = rs.getInt(2);
				String nmCidade  = rs.getString(3);
				//String cdMunicipio = rs.getString(4);
				String status = rs.getString(5);

				cidade = new Cidade(idCidade, cdEstado, nmCidade, cdMunicipio, status);
			}            

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return cidade;
	}

	public List listarCidade(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<Cidade> list = null;
		
		try {
			String sql = "SELECT idCidade, cdEstado, nmCidade, cdMunicipio, status FROM tbcidade ";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<Cidade>();
			while (rs.next()) {
				int idCidade = rs.getInt(1);
				int cdEstado = rs.getInt(2);
				String nmCidade = rs.getString(3);
				String cdMunicipio = rs.getString(4);
				String status = rs.getString(5);
				
				list.add(new Cidade(idCidade, cdEstado, nmCidade, cdMunicipio, status));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		}
		return list;
	}
	public boolean exclusaoIdCidade(int idCidade) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = true;
		try {
			String sql = "select idCidade from tbentidadeendereco where idCidade = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idCidade);
			rs = ps.executeQuery();
			if(rs.next()) {
			   ok=true;
			}else{
				ok=false;
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return ok;
		
	}
	public Cidade procurarCidadeString(String nomeCidade) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		Cidade cidade = null;

		try {
			String sql = "SELECT idCidade, cdEstado, nmCidade, cdMunicipio, status FROM tbcidade "
				+ "WHERE UCASE(nmCidade) = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, nomeCidade);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o nome: " + nomeCidade);
			}
            
			int idCidade = rs.getInt(1);
			int cdEstado = rs.getInt(2);
			String nmCidade  = rs.getString(3);
			String cdMunicipio = rs.getString(4);
			String status = rs.getString(5);

			cidade = new Cidade(idCidade, cdEstado, nmCidade, cdMunicipio, status);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		}
		return cidade;
	}

}
