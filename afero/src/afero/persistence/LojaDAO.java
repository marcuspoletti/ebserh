package afero.persistence;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import afero.model.Loja;

public class LojaDAO implements ILojaDAO{

	private Connection conn;

	public LojaDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;
	}

	public void incluir(Loja loja) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (loja == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbloja(apelido, razaoSocial, cnpj, inscEstadual, inscMunicipal, endereco, cmpEndereco, cep, bairro, idCidade, estado, nroTelefone, nroFax, pessoaResponsavel, " +
					     "dtMod, dtCad, status, usuario, idCrt, idCnae, nro)VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now(), now(), ?, ?, ?, ?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, loja.getApelido());
			ps.setString(2, loja.getRazaoSocial());
			ps.setString(3, loja.getCnpj());
			ps.setString(4, loja.getInscEstadual());
			ps.setString(5, loja.getInscMunicipal());
			ps.setString(6, loja.getEndereco());
			ps.setString(7, loja.getCmpEndereco());
			ps.setString(8, loja.getCep());
			ps.setString(9, loja.getBairro());
			ps.setInt(10, loja.getIdCidade());
			ps.setString(11, loja.getEstado());
			ps.setString(12, loja.getNroTelefone());
			ps.setString(13, loja.getNroFax());
			ps.setString(14, loja.getPessoaResponsavel());
			ps.setString(15, loja.getStatus());
			ps.setString(16, loja.getUsuario());
			ps.setInt(17, loja.getIdCrt());
			ps.setInt(18, loja.getIdCnae());
			ps.setString(19, loja.getNro());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados " + sqle);
		}
	}

	public void atualizar(Loja loja) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (loja == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbloja SET apelido = ?, razaoSocial = ?, cnpj = ?, inscEstadual = ?, inscMunicipal = ?, endereco = ?, cmpEndereco = ?, cep = ?, bairro = ?, idCidade = ?, estado = ?, nroTelefone = ?, nroFax = ?, pessoaResponsavel = ?, " +
					     "dtMod = now(), status = ?, dtMod = now(), usuario = ?, idCrt = ?, idCnae = ?, nro = ?  WHERE idLoja = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, loja.getApelido());
			ps.setString(2, loja.getRazaoSocial());
			ps.setString(3, loja.getCnpj());
			ps.setString(4, loja.getInscEstadual());
			ps.setString(5, loja.getInscMunicipal());
			ps.setString(6, loja.getEndereco());
			ps.setString(7, loja.getCmpEndereco());
			ps.setString(8, loja.getCep());
			ps.setString(9, loja.getBairro());
			ps.setInt(10, loja.getIdCidade());
			ps.setString(11, loja.getEstado());
			ps.setString(12, loja.getNroTelefone());
			ps.setString(13, loja.getNroFax());
			ps.setString(14, loja.getPessoaResponsavel());
			ps.setString(15, loja.getStatus());
			ps.setString(16, loja.getUsuario());
			ps.setInt(17, loja.getIdCrt());
			ps.setInt(18, loja.getIdCnae());
			ps.setString(19, loja.getNro());
			ps.setInt(20,loja.getIdLoja());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} 
	}

	public void excluir(Loja loja) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (loja == null)
			throw new AferoDAOException(
					"O valor passado n�o pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbloja WHERE idLoja=?");
			ps.setInt(1, loja.getIdLoja());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public Loja procurarLoja(int idLoja) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		Loja loja = null;

		try {
			String sql = "SELECT apelido, razaoSocial, cnpj, inscEstadual, inscMunicipal, endereco, cmpEndereco, cep, bairro, idCidade, estado, nroTelefone, nroFax, pessoaResponsavel, " +
					     "dtMod, dtCad, status, usuario, idCrt, idCnae, nro FROM tbloja ";
		    if(idLoja != 0){
		    	sql = sql + "WHERE idLoja = ?";
		    }else if(idLoja == 0){
		    	sql = sql + "WHERE idLoja != 0";
		    }
					     
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			if(idLoja != 0){
				ps.setInt(1, idLoja);
		    }
			
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o c�d.setor: " + idLoja);
			}

			String apelido = rs.getString(1);
			String razaoSocial = rs.getString(2);
			String cnpj = rs.getString(3);
			String inscEstadual = rs.getString(4);
			String inscMunicipal = rs.getString(5);
			String endereco = rs.getString(6);
			String cmpEndereco = rs.getString(7);
			String cep = rs.getString(8);
			String bairro = rs.getString(9);
			Integer idCidade = rs.getInt(10);
			String estado = rs.getString(11);
			String nroTelefone = rs.getString(12);
			String nroFax = rs.getString(13);
			String pessoaResponsavel = rs.getString(14);
		    Date dtMod = rs.getDate(15);
		    Date dtCad = rs.getDate(16);
		    String status = rs.getString(17);
		    String usuario = rs.getString(18);
		    Integer idCrt = rs.getInt(19);
		    Integer idCnae = rs.getInt(20);
		    String nro = rs.getString(21);

			loja = new Loja( idLoja,apelido, razaoSocial, cnpj, inscEstadual, endereco, cmpEndereco, cep, bairro, estado, nroTelefone, nroFax, pessoaResponsavel,
				     dtMod, dtCad, status, usuario, idCrt, idCnae, idCidade, inscMunicipal, nro);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return loja;
	}

	public List listarLoja(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<Loja> list = null;
		
		try {
			String sql = "SELECT idLoja, apelido, razaoSocial, cnpj, inscEstadual, endereco, cmpEndereco, cep, bairro, idCidade, estado, nroTelefone, nroFax, pessoaResponsavel, " +
					     "dtMod, dtCad, status, usuario, idCrt, idCnae, inscMunicipal, nro FROM tbloja";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<Loja>();
			while (rs.next()) {
				int idLoja = rs.getInt(1);
				String apelido = rs.getString(2);
				String razaoSocial = rs.getString(3);
				String cnpj = rs.getString(4);
				String inscEstadual = rs.getString(5);
				String endereco = rs.getString(6);
				String cmpEndereco = rs.getString(7);
				String cep = rs.getString(8);
				String bairro = rs.getString(9);
				Integer idCidade = rs.getInt(10);
				String estado = rs.getString(11);
				String nroTelefone = rs.getString(12);
				String nroFax = rs.getString(13);
				String pessoaResponsavel = rs.getString(14);
			    Date dtMod = rs.getDate(15);
			    Date dtCad = rs.getDate(16);
			    String status = rs.getString(17);
			    String usuario = rs.getString(18);
			    Integer idCrt = rs.getInt(19);
			    Integer idCnae = rs.getInt(20);
			    String inscMunicipal = rs.getString(21);
			    String nro = rs.getString(22);
				list.add(new Loja( idLoja,apelido, razaoSocial, cnpj, inscEstadual, endereco, cmpEndereco, cep, bairro, estado, nroTelefone, nroFax, pessoaResponsavel,
					     dtMod, dtCad, status, usuario, idCrt, idCnae, idCidade, inscMunicipal, nro));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return list;
	}
	public String getCidadeLoja(int idLoja) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		String cidade = null;

		try {
			String sql = "SELECT cidade FROM tbloja ";
		    if(idLoja != 0){
		    	sql = sql + "WHERE idLoja = ?";
		    }else if(idLoja == 0){
		    	sql = sql + "WHERE idLoja != 0";
		    }
					     
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			if(idLoja != 0){
				ps.setInt(1, idLoja);
		    }
			
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o c�d.setor: " + idLoja);
			}

			cidade = rs.getString(1);

			

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return cidade;
	}

}
