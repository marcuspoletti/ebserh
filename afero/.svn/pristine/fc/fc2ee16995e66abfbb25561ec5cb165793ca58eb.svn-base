package afero.persistence;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import afero.model.Colaborador;

public class ColaboradorDAO implements IColaboradorDAO{
	private Connection conn;

	public ColaboradorDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;
	}

	public void incluir(Colaborador colaborador) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (colaborador == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbcolaborador(idLoja, idTipoColaborador, idUsuario, nome, apelido, endereco, cep, bairro, cidade, estado, cmpEndereco, " +
					"nroRg, cpf, orgRg, ufRg, telefone, celular, email, dtCad, dtMod, status, usuario) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now(), now(), ?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, colaborador.getIdLoja());
			ps.setInt(2, colaborador.getIdTipoColaborador());
			ps.setInt(3, colaborador.getIdUsuario());
			ps.setString(4, colaborador.getNome());
			ps.setString(5, colaborador.getApelido());
			ps.setString(6, colaborador.getEndereco());
			ps.setString(7, colaborador.getCep());
			ps.setString(8, colaborador.getBairro());
			ps.setString(9, colaborador.getCidade());
			ps.setString(10, colaborador.getEstado());
			ps.setString(11, colaborador.getCmpEndereco());
			ps.setString(12, colaborador.getNroRg());
			ps.setString(13, colaborador.getCpf());
			ps.setString(14, colaborador.getOrgRg());
			ps.setString(15, colaborador.getUfRg());
			ps.setString(16, colaborador.getTelefone());
			ps.setString(17, colaborador.getCelular());
			ps.setString(18, colaborador.getEmail());
			ps.setString(19, colaborador.getStatus());
			ps.setString(20, colaborador.getUsuario());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(Colaborador colaborador) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (colaborador == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbcolaborador SET idLoja = ?, idTipoColaborador = ? , nome = ?, apelido = ?, endereco = ?, cep = ?, bairro = ?, cidade = ?, estado = ?, cmpEndereco = ?, " +
					"nroRg = ?, cpf = ?, orgRg = ?, ufRg = ?, telefone = ?, celular = ?, email = ?, dtMod = now(), status = ?, usuario = ? WHERE idColaborador = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, colaborador.getIdLoja());
			ps.setInt(2, colaborador.getIdTipoColaborador());
			//ps.setInt(3, colaborador.getIdUsuario());
			ps.setString(3, colaborador.getNome());
			ps.setString(4, colaborador.getApelido());
			ps.setString(5, colaborador.getEndereco());
			ps.setString(6, colaborador.getCep());
			ps.setString(7, colaborador.getBairro());
			ps.setString(8, colaborador.getCidade());
			ps.setString(9, colaborador.getEstado());
			ps.setString(10, colaborador.getCmpEndereco());
			ps.setString(11, colaborador.getNroRg());
			ps.setString(12, colaborador.getCpf());
			ps.setString(13, colaborador.getOrgRg());
			ps.setString(14, colaborador.getUfRg());
			ps.setString(15, colaborador.getTelefone());
			ps.setString(16, colaborador.getCelular());
			ps.setString(17, colaborador.getEmail());
			ps.setString(18, colaborador.getStatus());
			ps.setString(19, colaborador.getUsuario());
			ps.setInt(20, colaborador.getIdColaborador());
			
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void excluir(Colaborador colaborador) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (colaborador == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbcolaborador WHERE idColaborador=?");
			ps.setInt(1, colaborador.getIdColaborador());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public Colaborador procurarColaborador(int idColaborador) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		Colaborador colaborador = null;

		try {
			String sql = "SELECT idLoja, idTipoColaborador, idUsuario, nome, apelido, endereco, cep, bairro, cidade, estado, cmpEndereco, " +
					"nroRg, cpf, orgRg, ufRg, telefone, celular, email, dtCad, dtMod, status, usuario FROM tbcolaborador WHERE idColaborador = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idColaborador);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o cód.colaborador: " + idColaborador);
			}

			int idLoja = rs.getInt("idLoja");
			int idTipoColaborador = rs.getInt("idTipoColaborador");
			int idUsuario = rs.getInt("idUsuario");
			String nome = rs.getString("nome");
			String apelido = rs.getString("apelido");
			String endereco = rs.getString("endereco");
			String cep = rs.getString("cep");
			String bairro = rs.getString("bairro");
			String cidade = rs.getString("cidade");
			String estado = rs.getString("estado");
			String cmpEndereco = rs.getString("cmpEndereco");
			String nroRg = rs.getString("nroRg");
			String cpf = rs.getString("cpf");
			String orgRg = rs.getString("orgRg");
			String ufRg = rs.getString("ufRg");
			String telefone = rs.getString("telefone");
			String celular = rs.getString("celular");
			String email = rs.getString("email");
			Date dtCad = rs.getDate("dtCad");
			Date dtMod = rs.getDate("dtMod");
			String status = rs.getString("status");
			String usuario = rs.getString("usuario");

			colaborador = new Colaborador(idColaborador, idLoja, idTipoColaborador,
					idUsuario, nome, apelido, cpf, nroRg, endereco, bairro, cep,
					cidade, estado, cmpEndereco, status, ufRg, telefone, celular, email,
					dtMod, dtCad, orgRg, usuario);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return colaborador;
	}

	public List listarColaborador(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<Colaborador> list = null;
		
		try {
			String sql = "SELECT idColaborador, idLoja, idTipoColaborador, idUsuario, nome, apelido, endereco, cep, bairro, cidade, estado, cmpEndereco, " +
					"nroRg, cpf, orgRg, ufRg, telefone, celular, email, dtCad, dtMod, status, usuario FROM tbcolaborador";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<Colaborador>();
			while (rs.next()) {
				
				int idColaborador = rs.getInt("idColaborador");
				int idLoja = rs.getInt("idLoja");
				int idTipoColaborador = rs.getInt("idTipoColaborador");
				int idUsuario = rs.getInt("idUsuario");
				String nome = rs.getString("nome");
				String apelido = rs.getString("apelido");
				String endereco = rs.getString("endereco");
				String cep = rs.getString("cep");
				String bairro = rs.getString("bairro");
				String cidade = rs.getString("cidade");
				String estado = rs.getString("estado");
				String cmpEndereco = rs.getString("cmpEndereco");
				String nroRg = rs.getString("nroRg");
				String cpf = rs.getString("cpf");
				String orgRg = rs.getString("orgRg");
				String ufRg = rs.getString("ufRg");
				String telefone = rs.getString("telefone");
				String celular = rs.getString("celular");
				String email = rs.getString("email");
				Date dtCad = rs.getDate("dtCad");
				Date dtMod = rs.getDate("dtMod");
				String status = rs.getString("status");
				String usuario = rs.getString("usuario");
				
				list.add(new Colaborador(idColaborador, idLoja, idTipoColaborador,
						idUsuario, nome, apelido, cpf, nroRg, endereco, bairro, cep,
						cidade, estado, cmpEndereco, status, ufRg, telefone, celular, email,
						dtMod, dtCad, orgRg, usuario));
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}
	
	public boolean exclusaoIdColaboradorOrcamento(int idColaborador) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = true;
		try {
			String sql = "select idColaborador from tborcamento where idColaborador =?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idColaborador);
			rs = ps.executeQuery();
			if(rs.next()) {
			   ok=true;
			}else{
				ok=false;
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return ok;
		
	}
	
	public boolean exclusaoIdColaboradorPedido(int idColaborador) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = true;
		try {
			String sql = "select idColaborador from tbpedidosaida where idColaborador =?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idColaborador);
			rs = ps.executeQuery();
			if(rs.next()) {
			   ok=true;
			}else{
				ok=false;
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return ok;
		
	}
	
	public boolean exclusaoIdColaboradorCompra(int idColaborador) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = true;
		try {
			String sql = "select idColaborador from tbpedidoentrada where idColaborador =?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idColaborador);
			rs = ps.executeQuery();
			if(rs.next()) {
			   ok=true;
			}else{
				ok=false;
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return ok;
		
	}
	
	public Colaborador procurarColaboradorUsuario(int idUsuario) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		Colaborador colaborador = null;

		try {
			String sql = "SELECT idColaborador, idLoja, idTipoColaborador, idUsuario, nome, apelido, endereco, cep, bairro, cidade, estado, cmpEndereco, " +
					"nroRg, cpf, orgRg, ufRg, telefone, celular, email, dtCad, dtMod, status, usuario FROM tbcolaborador WHERE idUsuario = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idUsuario);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o cód.colaborador: " + idUsuario);
			}
            int idColaborador = rs.getInt("idColaborador");
			int idLoja = rs.getInt("idLoja");
			int idTipoColaborador = rs.getInt("idTipoColaborador");
			String nome = rs.getString("nome");
			String apelido = rs.getString("apelido");
			String endereco = rs.getString("endereco");
			String cep = rs.getString("cep");
			String bairro = rs.getString("bairro");
			String cidade = rs.getString("cidade");
			String estado = rs.getString("estado");
			String cmpEndereco = rs.getString("cmpEndereco");
			String nroRg = rs.getString("nroRg");
			String cpf = rs.getString("cpf");
			String orgRg = rs.getString("orgRg");
			String ufRg = rs.getString("ufRg");
			String telefone = rs.getString("telefone");
			String celular = rs.getString("celular");
			String email = rs.getString("email");
			Date dtCad = rs.getDate("dtCad");
			Date dtMod = rs.getDate("dtMod");
			String status = rs.getString("status");
			String usuario = rs.getString("usuario");

			colaborador = new Colaborador(idColaborador, idLoja, idTipoColaborador,
					idUsuario, nome, apelido, cpf, nroRg, endereco, bairro, cep,
					cidade, estado, cmpEndereco, status, ufRg, telefone, celular, email,
					dtMod, dtCad, orgRg, usuario);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return colaborador;
	}
	public boolean existeIdColaboradorPedido(int idColaborador) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = true;
		try {
			String sql = "select idColaborador from tbcolaborador where idColaborador = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idColaborador);
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

}
