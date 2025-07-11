package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import afero.model.CotacaoItem;
import afero.util.ConverteDate;

public class CotacaoItemDAO implements ICotacaoItemDAO {

	private Connection conn;

	public CotacaoItemDAO(Connection conn) {
		this.conn = conn;
	}

	public void incluir(CotacaoItem cotacaoItem) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (cotacaoItem == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbcotacaoitem(idCotacao, idProduto, idUnidade, "
					+ "quant, dtMod, usuario) "
					+ "values(?, ?, ?, ?, now(), ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cotacaoItem.getIdCotacao());
			ps.setInt(2, cotacaoItem.getIdProduto());
			ps.setInt(3, cotacaoItem.getIdUnidade());
			ps.setFloat(4, cotacaoItem.getQuant());
			ps.setString(5, cotacaoItem.getUsuario());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(CotacaoItem cotacaoItem) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (cotacaoItem == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbcotacaoitem set idCotacao = ?, idProduto = ?, idUnidade = ?, "
					+ "quant = ?, dtMod = now(), usuario = ? "
					+ "where idCotacaoItem = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, cotacaoItem.getIdCotacao());
			ps.setInt(2, cotacaoItem.getIdProduto());
			ps.setInt(3, cotacaoItem.getIdUnidade());
			ps.setFloat(4, cotacaoItem.getQuant());
			ps.setString(5, cotacaoItem.getUsuario());
			ps.setInt(6, cotacaoItem.getIdCotacaoItem());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void excluir(CotacaoItem cotacaoItem) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (cotacaoItem == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbcotacaoitem WHERE idCotacaoItem=?");
			ps.setInt(1, cotacaoItem.getIdCotacaoItem());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			// ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public CotacaoItem procurarCotacaoItem(int idCotacaoItem)
			throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		CotacaoItem cotacaoItem = null;

		try {
			String sql = "SELECT idCotacao, idProduto, idUnidade, "
					+ "quant, dtMod, usuario " + "WHERE idCotacaoItem = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idCotacaoItem);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + idCotacaoItem);
			}

			int idCotacao = rs.getInt(1);
			int idProduto = rs.getInt(2);
			int idUnidade = rs.getInt(3);
			float quant = rs.getFloat(4);
			Date dtMod = rs.getDate(5);
			String usuario = rs.getString(6);

			cotacaoItem = new CotacaoItem(idCotacaoItem, idCotacao, idProduto,
					idUnidade, quant, dtMod, usuario);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return cotacaoItem;
	}

	public List listarCotacaoItem(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<CotacaoItem> list = null;

		try {
			String sql = "SELECT idCotacaoItem, idCotacao, idProduto, idUnidade, "
					+ "quant, dtMod, usuario " + "from tbcotacaoitem ";
			if (clausula != null)
				sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<CotacaoItem>();

			while (rs.next()) {

				int idCotacaoItem = rs.getInt(1);
				int idCotacao = rs.getInt(2);
				int idProduto = rs.getInt(3);
				int idUnidade = rs.getInt(4);
				float quant = rs.getFloat(5);
				Date dtMod = rs.getDate(6);
				String usuario = rs.getString(7);
				list.add(new CotacaoItem(idCotacaoItem, idCotacao, idProduto,
						idUnidade, quant, dtMod, usuario));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}

	public String dataAtualCotacaoItem() throws AferoDAOException {
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
			// ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return dataAtual;
	}

	public int idCotacaoItemCorrente() throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		int numCotacao = 0;

		try {
			String sql = "select max(idCotacaoItem) from tbcotacaoitem order by idCotacaoItem DESC LIMIT 1";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if (rs.next()) {
				numCotacao = rs.getInt(1);
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return numCotacao;
	}

}
