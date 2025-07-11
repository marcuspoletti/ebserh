package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import afero.model.RelacaoUnidade;
import afero.model.UnidadeRelacaoUnidade;
import afero.util.Utilitaria;


public class RelacaoUnidadeDAO implements IRelacaoUnidadeDAO{
	
	private Connection conn;

	public RelacaoUnidadeDAO(Connection conn)  throws AferoDAOException {
		this.conn = conn;		
	}

	public void incluir(RelacaoUnidade relacaoUnidade) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (relacaoUnidade == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbrelacaounidade(idUnidadeDe, idUnidadePara, fatorConversao) "
					+ "VALUES (?, ?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, relacaoUnidade.getIdUnidadeDe());
			ps.setInt(2, relacaoUnidade.getIdUnidadePara());
			ps.setFloat(3, relacaoUnidade.getFatorConversao());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(RelacaoUnidade relacaoUnidade) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (relacaoUnidade == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbrelacaounidade SET idUnidadeDe = ?, idUnidadePara = ?, fatorConversao = ? WHERE idRelacaoUnidade=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, relacaoUnidade.getIdUnidadeDe());
			ps.setInt(2, relacaoUnidade.getIdUnidadePara());
			ps.setFloat(3, relacaoUnidade.getFatorConversao());
			ps.setInt(4, relacaoUnidade.getIdRelacaoUnidade());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void excluir(RelacaoUnidade relacaoUnidade) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (relacaoUnidade == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbrelacaounidade WHERE idRelacaoUnidade = ?");
			ps.setInt(1, relacaoUnidade.getIdRelacaoUnidade());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public RelacaoUnidade procurarRelacaoUnidade(int idRelacaoUnidade) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		RelacaoUnidade relacaoUnidade = null;

		try {
			String sql = "SELECT idUnidadeDe, idUnidadePara, fatorConversao FROM tbrelacaounidade WHERE idRelacaoUnidade = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idRelacaoUnidade);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o cód.setor: " + idRelacaoUnidade );
			}
            int idUnidadeDe = rs.getInt(1);
            int idUnidadePara = rs.getInt(2);
			float fatorConversao = rs.getFloat(3);

			relacaoUnidade = new RelacaoUnidade(idRelacaoUnidade, idUnidadeDe, idUnidadePara, fatorConversao);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return relacaoUnidade;
	}
	public String procurarFatorConversao(int idRelacaoUnidade) throws AferoDAOException{
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		RelacaoUnidade relacaoUnidade = null;
		float fatorConversao = 0;
		Utilitaria util = null;
		try {
			String sql = "SELECT fatorConversao FROM tbrelacaounidade WHERE idRelacaoUnidade = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, relacaoUnidade.getIdRelacaoUnidade());
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o cód.setor: " + idRelacaoUnidade);
			}else{
            
			 fatorConversao = (float)rs.getDouble("fatorConversao");
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return util.formatarNumero(fatorConversao, 2);
	}
	public List listarRelacaoUnidade(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<RelacaoUnidade> list = null;
		UnidadeRelacaoUnidade unidRelacaoUnid = null;
		
		try {
			String sql = "SELECT idRelacaoUnidade, de.idUnidade as de, de.dsUnidade, para.idUnidade as para,  para.dsUnidade, fatorConversao "+ 
                         "FROM tbrelacaounidade  rlu " +
                         "join tbunidade de on rlu.idUnidadeDe = de.idUnidade "+
                         "join tbunidade para on rlu.idUnidadePara = para.idUnidade";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<RelacaoUnidade>();
			while (rs.next()) {
				int idRelacaoUnidade = rs.getInt(1);
				int idUnidadeDe = rs.getInt(2);
				String de = rs.getString(3);
				int idUnidadePara = rs.getInt(4);
				String para = rs.getString(5);
				float fatorConversao = rs.getFloat(6);
				RelacaoUnidade relacaoUnidade = new RelacaoUnidade(idRelacaoUnidade, idUnidadeDe, idUnidadePara, fatorConversao);
				unidRelacaoUnid = new UnidadeRelacaoUnidade( idUnidadeDe, idUnidadePara, de, para);
				relacaoUnidade.setUnidadeRelacaoUnidade(unidRelacaoUnid);
				list.add(relacaoUnidade);
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}

}
