package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import afero.model.Preco;

public class PrecoDAO implements IPrecoDAO{
	private Connection conn;

	public PrecoDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;		
	}

	public void incluir(Preco preco) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (preco == null)
			throw new AferoDAOException(
					"O valor passado n�o pode ser nulo");

		try {
			String sql = "INSERT INTO tbpreco (idEstoque, idUnidade, preco, dtInicioPreco, dtMod, custoReal, custoDireto, custoMedioGeral, usuario) "
					+ "VALUES (?, ?, ?, now(), now(), ?, ?, ?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, preco.getIdEstoque());
			ps.setInt(2, preco.getIdUnidade());
			ps.setFloat(3, preco.getPreco());
			ps.setFloat(4, preco.getCustoReal());
			ps.setFloat(5, preco.getCustoDireto());
			ps.setFloat(6, preco.getCustoMedioGeral());
			ps.setString(7, preco.getUsuario());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}
	public void incluirEntrada(Preco preco) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (preco == null)
			throw new AferoDAOException(
					"O valor passado n�o pode ser nulo");

		try {
			String sql = "INSERT INTO tbpreco (idEstoque, idUnidade, preco, dtInicioPreco, dtMod, custoReal, custoDireto, custoMedioGeral, ultimoCustoCompra, usuario) "
					+ "VALUES (?, ?, ?, now(), now(), ?, ?, ?, ?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, preco.getIdEstoque());
			ps.setInt(2, preco.getIdUnidade());
			ps.setFloat(3, preco.getPreco());
			ps.setFloat(4, preco.getCustoReal());
			ps.setFloat(5, preco.getCustoDireto());
			ps.setFloat(6, preco.getCustoMedioGeral());
			ps.setFloat(7, preco.getUltimoCustoCompra());
			ps.setString(8, preco.getUsuario());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(Preco preco) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (preco == null)
			throw new AferoDAOException(
					"O valor passado n�o pode ser nulo");

		try {
			String sql = "UPDATE tbpreco SET idEstoque = ?, idUnidade = ?, preco = ?, dtMod = now(), usuario = ?, custoReal = ?, custoDireto = ?, custoMedioGeral = ? WHERE idPreco = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, preco.getIdEstoque());
			ps.setInt(2, preco.getIdUnidade());
			ps.setFloat(3, preco.getPreco());
			ps.setString(4, preco.getUsuario());
			ps.setFloat(5, preco.getCustoReal());
			ps.setFloat(6, preco.getCustoDireto());
			ps.setFloat(7, preco.getCustoMedioGeral());
			ps.setInt(8, preco.getIdPreco());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}
	
	public void atualizarPreco(Preco preco) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (preco == null)
			throw new AferoDAOException(
					"O valor passado n�o pode ser nulo");

		try {
			String sql = "UPDATE tbpreco SET dtFimPreco = now(), preco = ?, dtMod = now(), usuario = ?, custoReal = ?, custoDireto = ?, custoMedioGeral = ? WHERE idPreco = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setFloat(1, preco.getPreco());
			ps.setString(2, preco.getUsuario());
			ps.setFloat(3, preco.getCustoReal());
			ps.setFloat(4, preco.getCustoDireto());
			ps.setFloat(5, preco.getCustoMedioGeral());
			ps.setInt(6, preco.getIdPreco());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}
	public void atualizarPrecoCustos(Preco preco) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (preco == null)
			throw new AferoDAOException(
					"O valor passado n�o pode ser nulo");

		try {
			String sql = "UPDATE tbpreco SET  ultimoCustoCompra = ?, dtMod = now(), usuario = ?, custoReal = ?, custoDireto = ?, custoMedioGeral = ? WHERE idPreco = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setFloat(1, preco.getUltimoCustoCompra());
			ps.setString(2, preco.getUsuario());
			ps.setFloat(3, preco.getCustoReal());
			ps.setFloat(4, preco.getCustoDireto());
			ps.setFloat(5, preco.getCustoMedioGeral());
			ps.setInt(6, preco.getIdPreco());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}
	public void atualizarPrecoEntradaFinalizar(int idEstoque, String usuario) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		try {
			String sql = "UPDATE tbpreco SET dtFimPreco = now(), dtMod = now(), usuario = ?, precoPadrao = 'N' WHERE precoPadrao='S' AND idEstoque = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, usuario);
			ps.setInt(2, idEstoque);
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		}
	}
	public void excluir(Preco preco) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (preco == null)
			throw new AferoDAOException(
					"O valor passado n�o pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbpreco WHERE idPreco=?");
			ps.setInt(1, preco.getIdPreco());
			ps.executeUpdate();

		}catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		}finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}
	}

	public Preco procurarPreco(int idPreco) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		Preco preco = null;

		try {
			String sql = "SELECT pr.idPreco, pr.idEstoque, pr.idUnidade, pr.dtInicioPreco, pr.dtFimPreco, pr.preco, pr.dtMod, pr.usuario, pr.custoReal, pr.custoDireto, pr.custoMedioGeral FROM tbpreco pr"
				+ "WHERE pr.precoPadrao = 'S' AND pr.idPreco=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idPreco);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("N�o foi encontrado nenhum "
						+ "registro com o c�d.setor: " + idPreco);
			}
            
			int idEstoque = rs.getInt(2);
			int idUnidade = rs.getInt(3);
			Date dtInicioPreco = rs.getDate(4);
			Date dtFimPreco = rs.getDate(5);
			float precoUni = rs.getFloat(6);
			Date dtMod = rs.getDate(7);
			String usuario = rs.getString(8);
			float custoReal = rs.getFloat(9);
			float custoDireto = rs.getFloat(10);
			float custoMedioGeral = rs.getFloat(11);
			preco = new Preco(idPreco, idEstoque, idUnidade, dtInicioPreco,
					dtFimPreco, precoUni, custoDireto, custoReal,custoMedioGeral, usuario);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return preco;
	}
	public List listarPreco(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<Preco> list = null;
		
		try {
			String sql = "SELECT pr.idPreco, pr.idEstoque, pr.idUnidade, pr.dtInicioPreco, pr.dtFimPreco, pr.preco, pr.dtMod, pr.usuario, pr.custoReal, pr.custoDireto, pr.custoMedioGeral " +
					     "FROM tbpreco pr " +
			             "JOIN tbestoque e on (pr.idEstoque = e.idEstoque)";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<Preco>();
			while (rs.next()) {
				int idPreco = rs.getInt(1);
				int idEstoque = rs.getInt(2);
				int idUnidade = rs.getInt(3);
				Date dtInicioPreco = rs.getDate(4);
				Date dtFimPreco = rs.getDate(5);
				float precoUni = rs.getFloat(6);
				Date dtMod = rs.getDate(7);
				String usuario = rs.getString(8);
				float custoReal = rs.getFloat(9);
				float custoDireto = rs.getFloat(10);
				float custoMedioGeral = rs.getFloat(11);
				list.add(new Preco(idPreco, idEstoque, idUnidade, dtInicioPreco,
						dtFimPreco, precoUni, custoDireto, custoReal,custoMedioGeral, usuario));
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	public List procurarPrecoEstoqueList(int idEstoque) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<Preco> list = null;

		try {
			String sql = "SELECT pr.idPreco, pr.idEstoque, pr.idUnidade, pr.dtInicioPreco, pr.dtFimPreco, pr.preco, pr.dtMod, pr.usuario, pr.custoReal, pr.custoDireto, pr.custoMedioGeral " +
					     "FROM tbpreco pr " +
			             "JOIN tbestoque e on (pr.idEstoque = e.idEstoque) "+
				         "WHERE pr.precoPadrao = 'S' AND pr.idEstoque = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idEstoque);
			rs = ps.executeQuery();
			list = new ArrayList<Preco>();
			while (rs.next()) {
				int idUnidade = rs.getInt(3);
				int idPreco = rs.getInt(1);
				Date dtInicioPreco = rs.getDate(4);
				Date dtFimPreco = rs.getDate(5);
				float precoUni = rs.getFloat(6);
				Date dtMod = rs.getDate(7);
				String usuario = rs.getString(8);
				float custoReal = rs.getFloat(9);
				float custoDireto = rs.getFloat(10);
				float custoMedioGeral = rs.getFloat(11);
				list.add(new Preco(idPreco, idEstoque, idUnidade, dtInicioPreco,
						dtFimPreco, precoUni, custoDireto, custoReal,custoMedioGeral, usuario));
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	public Preco procurarPrecoEstoque(int idEstoque) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		Preco preco = null;

		try {
			String sql = "SELECT pr.idPreco, pr.idEstoque, pr.idUnidade, pr.dtInicioPreco, pr.dtFimPreco, pr.preco, pr.dtMod, pr.usuario, pr.custoReal, pr.custoDireto, pr.custoMedioGeral " +
					     "FROM tbpreco pr " +
			             "JOIN tbestoque e on (pr.idEstoque = e.idEstoque) "+
				         "WHERE pr.precoPadrao = 'S' AND pr.idEstoque = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idEstoque);
			rs = ps.executeQuery();
			
			while (rs.next()) {
				int idUnidade = rs.getInt(3);
				int idPreco = rs.getInt(1);
				Date dtInicioPreco = rs.getDate(4);
				Date dtFimPreco = rs.getDate(5);
				float precoUni = rs.getFloat(6);
				Date dtMod = rs.getDate(7);
				String usuario = rs.getString(8);
				float custoReal = rs.getFloat(9);
				float custoDireto = rs.getFloat(10);
				float custoMedioGeral = rs.getFloat(11);
				preco = new Preco(idPreco, idEstoque, idUnidade, dtInicioPreco,
						dtFimPreco, precoUni, custoDireto, custoReal,custoMedioGeral, usuario);
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return preco;
	}
	public Preco procurarListarPreco(int idEstoque) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		Preco preco = null;

		try {
			String sql = "SELECT pr.idPreco, pr.idEstoque, pr.idUnidade, pr.dtInicioPreco, pr.dtFimPreco, pr.preco, pr.dtMod, pr.usuario, pr.custoReal, pr.custoDireto, pr.custoMedioGeral " +
					     "FROM tbpreco pr " +
			             "JOIN tbestoque e on (pr.idEstoque = e.idEstoque) "+
				         "WHERE e.status = 'A' AND e.idEstoque = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idEstoque);
			rs = ps.executeQuery();
			
			while (rs.next()) {
				int idUnidade = rs.getInt(3);
				int idPreco = rs.getInt(1);
				Date dtInicioPreco = rs.getDate(4);
				Date dtFimPreco = rs.getDate(5);
				float precoUni = rs.getFloat(6);
				Date dtMod = rs.getDate(7);
				String usuario = rs.getString(8);
				float custoReal = rs.getFloat(9);
				float custoDireto = rs.getFloat(10);
				float custoMedioGeral = rs.getFloat(11);
				preco = new Preco(idPreco, idEstoque, idUnidade, dtInicioPreco,
						dtFimPreco, precoUni, custoDireto, custoReal,custoMedioGeral, usuario);
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return preco;
	}
	public Preco procurarPrecoEstoqueLoja(int idEstoque, int idLoja) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		Preco preco = null;

		try {
			String sql = "SELECT pr.idPreco, pr.idEstoque, pr.idUnidade, pr.dtInicioPreco, pr.dtFimPreco, pr.preco, pr.dtMod, pr.usuario, pr.custoReal, pr.custoDireto, pr.custoMedioGeral, pr.ultimoCustoCompra " +
					     "FROM tbpreco pr " +
			             "JOIN tbestoque e on (pr.idEstoque = e.idEstoque) "+
				         "WHERE pr.precoPadrao = 'S' AND pr.idEstoque = ? AND e.idLoja = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idEstoque);
			ps.setInt(2, idLoja);
			rs = ps.executeQuery();
			
			while (rs.next()) {
				int idUnidade = rs.getInt(3);
				int idPreco = rs.getInt(1);
				Date dtInicioPreco = rs.getDate(4);
				Date dtFimPreco = rs.getDate(5);
				float precoUni = rs.getFloat(6);
				Date dtMod = rs.getDate(7);
				String usuario = rs.getString(8);
				float custoReal = rs.getFloat(9);
				float custoDireto = rs.getFloat(10);
				float custoMedioGeral = rs.getFloat(11);
				float ultimoCustoCompra = rs.getFloat(12);
				preco = new Preco(idPreco, idEstoque, idUnidade, dtInicioPreco,
						dtFimPreco, precoUni, custoDireto, custoReal,custoMedioGeral, ultimoCustoCompra, usuario);
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return preco;
	}

	public Preco procurarPrecoList(int idEstoque, int idProduto) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		Preco preco = null;

		try {
			String sql = "SELECT pr.idPreco, pr.idEstoque, pr.idUnidade, pr.dtInicioPreco, pr.dtFimPreco, pr.preco, pr.dtMod, pr.usuario, pr.custoReal, pr.custoDireto, pr.custoMedioGeral " +
					     "FROM tbpreco pr " +
			             "JOIN tbestoque e on (pr.idEstoque = e.idEstoque) "+
				         "WHERE pr.precoPadrao = 'S' AND pr.idEstoque = ? and e.idProduto = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idEstoque);
			ps.setInt(2, idProduto);
			rs = ps.executeQuery();
			
			while (rs.next()) {
				int idUnidade = rs.getInt(3);
				int idPreco = rs.getInt(1);
				Date dtInicioPreco = rs.getDate(4);
				Date dtFimPreco = rs.getDate(5);
				float precoUni = rs.getFloat(6);
				Date dtMod = rs.getDate(7);
				String usuario = rs.getString(8);
				float custoReal = rs.getFloat(9);
				float custoDireto = rs.getFloat(10);
				float custoMedioGeral = rs.getFloat(11);
				preco = new Preco(idPreco, idEstoque, idUnidade, dtInicioPreco,
						dtFimPreco, precoUni, custoDireto, custoReal,custoMedioGeral, usuario);
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return preco;
	}
	public List procurarPrecoListagemDataPreco(int idEstoque, int idProduto) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<Preco> list = null;

		try {
			String sql = "SELECT pr.idPreco, pr.idEstoque, pr.idUnidade, pr.dtInicioPreco, pr.dtFimPreco, pr.preco, pr.dtMod, pr.usuario, pr.custoReal, pr.custoDireto, pr.custoMedioGeral " +
					     "FROM tbpreco pr " +
			             "JOIN tbestoque e on (pr.idEstoque = e.idEstoque) "+
				         "WHERE pr.precoPadrao = 'S' AND pr.idEstoque = ? and e.idProduto = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idEstoque);
			ps.setInt(2, idProduto);
			rs = ps.executeQuery();
			list = new ArrayList<Preco>();
			while (rs.next()) {
				int idUnidade = rs.getInt(3);
				int idPreco = rs.getInt(1);
				Date dtInicioPreco = rs.getDate(4);
				Date dtFimPreco = rs.getDate(5);
				float precoUni = rs.getFloat(6);
				Date dtMod = rs.getDate(7);
				String usuario = rs.getString(8);
				float custoReal = rs.getFloat(9);
				float custoDireto = rs.getFloat(10);
				float custoMedioGeral = rs.getFloat(11);
				list.add(new Preco(idPreco, idEstoque, idUnidade, dtInicioPreco,
						dtFimPreco, precoUni, custoDireto, custoReal,custoMedioGeral, usuario));
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	public List procurarPrecoListagem(int idEstoque, int idProduto) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<Preco> list = null;

		try {
			String sql = "SELECT pr.idPreco, pr.idEstoque, pr.idUnidade, pr.dtInicioPreco, pr.dtFimPreco, pr.preco, pr.dtMod, pr.usuario, pr.custoReal, pr.custoDireto, pr.custoMedioGeral " +
					     "FROM tbpreco pr " +
			             "JOIN tbestoque e on (pr.idEstoque = e.idEstoque) "+
				         "WHERE pr.precoPadrao = 'S' AND pr.idEstoque = ? and e.idProduto = ? and dtFimPreco is null";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idEstoque);
			ps.setInt(2, idProduto);
			rs = ps.executeQuery();
			list = new ArrayList<Preco>();
			while (rs.next()) {
				int idUnidade = rs.getInt(3);
				int idPreco = rs.getInt(1);
				Date dtInicioPreco = rs.getDate(4);
				Date dtFimPreco = rs.getDate(5);
				float precoUni = rs.getFloat(6);
				Date dtMod = rs.getDate(7);
				String usuario = rs.getString(8);
				float custoReal = rs.getFloat(9);
				float custoDireto = rs.getFloat(10);
				float custoMedioGeral = rs.getFloat(11);
				list.add(new Preco(idPreco, idEstoque, idUnidade, dtInicioPreco,
						dtFimPreco, precoUni, custoDireto, custoReal,custoMedioGeral, usuario));
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	
	public Preco procurarPrecoLis(int idEstoque, int idProduto) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		Preco preco = null;

		try {
			String sql = "SELECT pr.idPreco, pr.idEstoque, pr.idUnidade, pr.dtInicioPreco, pr.dtFimPreco, pr.preco, pr.dtMod, pr.usuario, pr.custoReal, pr.custoDireto, pr.custoMedioGeral " +
					     "FROM tbpreco pr " +
			             "JOIN tbestoque e on (pr.idEstoque = e.idEstoque) "+
				         "WHERE pr.precoPadrao = 'S' AND pr.idEstoque = ? and e.idProduto = ? and pr.dtFimPreco is null";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idEstoque);
			ps.setInt(2, idProduto);
			rs = ps.executeQuery();
			
			while (rs.next()) {
				int idUnidade = rs.getInt(3);
				int idPreco = rs.getInt(1);
				Date dtInicioPreco = rs.getDate(4);
				Date dtFimPreco = rs.getDate(5);
				float precoUni = rs.getFloat(6);
				Date dtMod = rs.getDate(7);
				String usuario = rs.getString(8);
				float custoReal = rs.getFloat(9);
				float custoDireto = rs.getFloat(10);
				float custoMedioGeral = rs.getFloat(11);
				preco = new Preco(idPreco, idEstoque, idUnidade, dtInicioPreco,
						dtFimPreco, precoUni, custoDireto, custoReal,custoMedioGeral, usuario);
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return preco;
	}
	public Preco procurarPrecoIdProduto(int idProduto) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		Preco preco = null;

		try {
			String sql = "SELECT pr.idPreco, pr.idEstoque, pr.idUnidade, pr.dtInicioPreco, pr.dtFimPreco, pr.preco, pr.dtMod, pr.usuario, pr.custoReal, pr.custoDireto, pr.custoMedioGeral " +
					     "FROM tbpreco pr " +
			             "JOIN tbestoque e on (pr.idEstoque = e.idEstoque) "+
				         "WHERE pr.precoPadrao = 'S' AND e.idProduto = ? and pr.dtFimPreco is null";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idProduto);
			rs = ps.executeQuery();
			
			while (rs.next()) {
				int idPreco = rs.getInt(1);
				int idEstoque = rs.getInt(2);
				int idUnidade = rs.getInt(3);
				Date dtInicioPreco = rs.getDate(4);
				Date dtFimPreco = rs.getDate(5);
				float precoUni = rs.getFloat(6);
				Date dtMod = rs.getDate(7);
				String usuario = rs.getString(8);
				float custoReal = rs.getFloat(9);
				float custoDireto = rs.getFloat(10);
				float custoMedioGeral = rs.getFloat(11);
				preco = new Preco(idPreco, idEstoque, idUnidade, dtInicioPreco,
						dtFimPreco, precoUni, custoDireto, custoReal,custoMedioGeral, usuario);
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return preco;
	}
	public Preco procurarPrecoPedidoItemIdProduto(int idProduto, int idPedidoSaida) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		Preco preco = null;

		try {
			String sql = "SELECT pr.idPreco, pr.idEstoque, pr.idUnidade, pr.dtInicioPreco, pr.dtFimPreco, pi.valor, pr.dtMod, pr.usuario, pr.custoReal, pr.custoDireto, pr.custoMedioGeral " +
					     "FROM tbpreco pr " +
			             "JOIN tbestoque e on (pr.idEstoque = e.idEstoque) "+
			             "JOIN tbpedidosaidaitem pi on (e.idProduto = pi.idProduto) "+
			             "JOIN tbpedidosaida ps on (pi.idPedidoSaida = ps.idPedidoSaida) "+
				         "WHERE pr.precoPadrao = 'S' AND e.idProduto = ? and pr.dtFimPreco is null AND ps.idPedidoSaida = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idProduto);
			ps.setInt(2, idPedidoSaida);
			rs = ps.executeQuery();
			
			while (rs.next()) {
				int idPreco = rs.getInt(1);
				int idEstoque = rs.getInt(2);
				int idUnidade = rs.getInt(3);
				Date dtInicioPreco = rs.getDate(4);
				Date dtFimPreco = rs.getDate(5);
				float precoUni = rs.getFloat(6);
				Date dtMod = rs.getDate(7);
				String usuario = rs.getString(8);
				float custoReal = rs.getFloat(9);
				float custoDireto = rs.getFloat(10);
				float custoMedioGeral = rs.getFloat(11);
				preco = new Preco(idPreco, idEstoque, idUnidade, dtInicioPreco,
						dtFimPreco, precoUni, custoDireto, custoReal,custoMedioGeral, usuario);
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return preco;
	}
	public Preco procurarListarPrecoDeletados(int idEstoque) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		Preco preco = null;

		try {
			String sql = "SELECT pr.idPreco, pr.idEstoque, pr.idUnidade, pr.dtInicioPreco, pr.dtFimPreco, pr.preco, pr.dtMod, pr.usuario, pr.custoReal, pr.custoDireto, pr.custoMedioGeral " +
					     "FROM tbpreco pr " +
			             "JOIN tbestoque e on (pr.idEstoque = e.idEstoque) "+
				         "WHERE e.idEstoque = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idEstoque);
			rs = ps.executeQuery();
			
			while (rs.next()) {
				int idUnidade = rs.getInt(3);
				int idPreco = rs.getInt(1);
				Date dtInicioPreco = rs.getDate(4);
				Date dtFimPreco = rs.getDate(5);
				float precoUni = rs.getFloat(6);
				Date dtMod = rs.getDate(7);
				String usuario = rs.getString(8);
				float custoReal = rs.getFloat(9);
				float custoDireto = rs.getFloat(10);
				float custoMedioGeral = rs.getFloat(11);
				preco = new Preco(idPreco, idEstoque, idUnidade, dtInicioPreco,
						dtFimPreco, precoUni, custoDireto, custoReal,custoMedioGeral, usuario);
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return preco;
	}
	public void atualizarPrecoUltimoCusto(float ultimoPrecoCusto, String usuario, int idPreco) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (idPreco < 0)
			throw new AferoDAOException(
					"O valor passado n�o pode ser nulo");

		try {
			String sql = "UPDATE tbpreco SET ultimoCustoCompra = ?, dtMod = now(), usuario = ? WHERE idPreco = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setFloat(1, ultimoPrecoCusto);
			ps.setString(2, usuario);
			ps.setInt(3, idPreco);
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		}
	}
	public void atualizarPrecoVenda(float precoVenda, String usuario, int idPreco) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (idPreco < 0)
			throw new AferoDAOException(
					"O valor passado n�o pode ser nulo");

		try {
			String sql = "UPDATE tbpreco SET preco = ?, dtMod = now(), usuario = ? WHERE idPreco = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setFloat(1, precoVenda);
			ps.setString(2, usuario);
			ps.setInt(3, idPreco);
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		}
	}
	public void atualizarPrecoCustoDireto(float precoCustoDireto, String usuario, int idPreco) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (idPreco < 0)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbpreco SET custoDireto = ?, dtMod = now(), usuario = ? WHERE idPreco = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setFloat(1, precoCustoDireto);
			ps.setString(2, usuario);
			ps.setInt(3, idPreco);
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		}
	}
}
