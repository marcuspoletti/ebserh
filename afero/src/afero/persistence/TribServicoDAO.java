package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import afero.model.TribServico;

public class TribServicoDAO {
	
	public Connection conn;
	
	public TribServicoDAO(Connection conn){
		this.conn = conn;
	}
	
	// INSERIR
	public void incluir(TribServico tribServico) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (tribServico == null)
			throw new AferoDAOException("O valor passado n�o pode ser nulo");
		
		try {
			String sql = "INSERT INTO tbtribservico(sigla, aliquota, pRetencao)" +
						"VALUES (?, ?)";
			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, tribServico.getSigla());
			ps.setFloat(2, tribServico.getAliquota());
			ps.setFloat(3, tribServico.getpRetencao());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} 
	}

	// ATUALIZAR 
	
	public void atualiza(TribServico tribServico) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (tribServico == null)
			throw new AferoDAOException("O valor passado n�o pode ser nulo");
		
		try {
			String sql = "UPDATE tbtribservico set sigla = ?, aliquota = ?, pRetencao = ? " +
						 "WHERE idTribServico = ?";
			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, tribServico.getSigla());
			ps.setFloat(2, tribServico.getAliquota());
			ps.setFloat(3, tribServico.getpRetencao());
			ps.setInt(4, tribServico.getIdTribServico());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao atualizar dados: " + e);
		} 
	}
	
	// EXCLUIR
	
	public void excluir(TribServico tribServico) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (tribServico == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbtribservico WHERE idTribServico = ?");
			ps.setInt(1, tribServico.getIdTribServico());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);
		} 
	}
	
	// BUSCAR
	
	public TribServico procurarTribServico(int idTribServico)throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		TribServico tribServico = null;

		try {
			String sql = "SELECT idTribServico, sigla, aliquota, pRetencao " +
					     "FROM tbtribservico Where idTribServico = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idTribServico);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + idTribServico);
			}

			
			String sigla = rs.getString(2);
			float aliquota = rs.getFloat(3);
			float pRetencao = rs.getFloat(4);

			tribServico = new TribServico(idTribServico, sigla, aliquota, pRetencao);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return tribServico;
	}
	// LISTAR
	
	public List<TribServico> listarTribServico(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<TribServico> list = null;

		try {
			String sql = "SELECT idTribServico, sigla, aliquota, pRetencao " +
						 "FROM tbtribservico";
			
			if (clausula != null)
				sql += clausula;
			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<TribServico>();
			
			while (rs.next()){
				
				int idTribServico = rs.getInt(1);
				String sigla = rs.getString(2);
				float aliquota = rs.getFloat(3);
				float pRetencao = rs.getFloat(4);
				
				list.add( new TribServico(idTribServico, sigla, aliquota, pRetencao));
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao listar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao listar dados: " + e);
		}
		return list;
	}	
}