package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import afero.model.Cidade;
import afero.model.ContaMovto;
import afero.model.ContaMovtoDivisao;
import afero.util.ConverteDate;



public class ContaMovtoDivisaoDAO {
	
	private Connection conn;

	public ContaMovtoDivisaoDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;
	}

	public void incluir(ContaMovtoDivisao contaMovtoDivisao) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (contaMovtoDivisao == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbcontamovtodivisao(idContaMovto, idPlanoConta, idCentroCusto, observacao, valor, cdFormaPagto, dtMod, usuario) "+
					     " VALUES (?, ?, ?, ?, ?, ?, now(), ?) ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, contaMovtoDivisao.getIdContaMovto());
			ps.setInt(2, contaMovtoDivisao.getIdPlanoConta());
			ps.setInt(3, contaMovtoDivisao.getIdCentroCusto());
			ps.setString(4, contaMovtoDivisao.getObservacao());
			ps.setFloat(5, contaMovtoDivisao.getValor());
			ps.setInt(6, contaMovtoDivisao.getCdFormaPagto());
            ps.setString(7, contaMovtoDivisao.getUsuario());
			
			
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		}finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(ContaMovtoDivisao contaMovtoDivisao) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (contaMovtoDivisao == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbcontamovtodivisao SET idContaMovto = ?, idPlanoConta = ?, idCentroCusto = ?, observacao = ?, valor = ?, cdFormaPagto = ?, dtMod = now(), usuario = ? " +
					     " WHERE idContaMovtoDivisao = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, contaMovtoDivisao.getIdContaMovto());
			ps.setInt(2, contaMovtoDivisao.getIdPlanoConta());
			ps.setInt(3, contaMovtoDivisao.getIdCentroCusto());
			ps.setString(5, contaMovtoDivisao.getObservacao());
			ps.setFloat(6, contaMovtoDivisao.getValor());
			ps.setInt(7, contaMovtoDivisao.getCdFormaPagto());
            ps.setString(8, contaMovtoDivisao.getUsuario());
			ps.setInt(9, contaMovtoDivisao.getIdContaMovtoDivisao());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		}catch (Exception e) {
		throw new AferoDAOException("Erro ao inserir dados: " + e);
		}finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void excluir(ContaMovtoDivisao contaMovtoDivisao) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (contaMovtoDivisao == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbcontamovtodivisao WHERE idContaMovtoDivisao = ? ");
			ps.setInt(1, contaMovtoDivisao.getIdContaMovtoDivisao());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}

	}

	public ContaMovtoDivisao procurarContaMovtoDivisao(int idContaMovtoDivisao) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		ContaMovtoDivisao contaMovtoDivisao = null;

		try {
			String sql = " SELECT idContaMovto, idPlanoConta, idCentroCusto, observacao, valor, cdFormaPagto, dtMod, usuario from tbcontamovtodivisao "+
			             " Where idContaMovtoDivisao = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idContaMovtoDivisao);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + idContaMovtoDivisao);
			}
            
			int idContaMovto = rs.getInt(1);
			int idPlanoConta = rs.getInt(2);
			int idCentroCusto= rs.getInt(3);
			String observacao= rs.getString(4);
			float valor      = rs.getFloat(5);
			int cdFormaPagto = rs.getInt(6);
			Date dtMod       = rs.getDate(7);
			String usuario   = rs.getString(8);
			contaMovtoDivisao = new ContaMovtoDivisao(idContaMovtoDivisao, idContaMovto,
					idPlanoConta, idCentroCusto, observacao,
					valor, cdFormaPagto, dtMod, usuario);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return contaMovtoDivisao;
	}

	public List listarContaMovtoDivisao(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<ContaMovtoDivisao> list = null;
		
		try {
			String sql = " SELECT cmd.idContaMovto, cmd.idPlanoConta, cmd.idCentroCusto, cmd.observacao, cmd.valor, cmd.cdFormaPagto, cmd.dtMod, cmd.usuario, cmd.idContaMovtoDivisao from tbcontamovtodivisao cmd ";
			              
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<ContaMovtoDivisao>();
			while (rs.next()) {
				
				int idContaMovto = rs.getInt(1);
				int idPlanoConta = rs.getInt(2);
				int idCentroCusto= rs.getInt(3);
				String observacao= rs.getString(4);
				float valor      = rs.getFloat(5);
				int cdFormaPagto = rs.getInt(6);
				Date dtMod       = rs.getDate(7);
				String usuario   = rs.getString(8);
				int idContaMovtoDivisao = rs.getInt(9);

				list.add(new ContaMovtoDivisao(idContaMovtoDivisao, idContaMovto,
						idPlanoConta, idCentroCusto, observacao,
						valor, cdFormaPagto, dtMod, usuario));
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}

	
	
	

}
