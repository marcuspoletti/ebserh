package aferopet.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import afero.persistence.AferoDAOException;
import aferopet.model.Medicamento;

public class MedicamentoDAO implements IMedicamentoDAO {
	
	private Connection conn;

	public MedicamentoDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;		
	}

	public void incluir(Medicamento medicamento) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (medicamento == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbmedicamento (idMedicamento, idGrupoMedicamento, nmMedicamento, principioAtivo, apresentacao, dosePAtivo, doseApresentacao, uso, indicacao, fabricante, observacao, idProduto, status, dtCad, dtMod, usuario) "
					+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now(),now(), ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, medicamento.getIdMedicamento());
			ps.setInt(2, medicamento.getIdGrupoMedicamento());
			ps.setString(3, medicamento.getNmMedicamento());
			ps.setString(4, medicamento.getPrincipioAtivo());
			ps.setString(5, medicamento.getApresentacao());
			ps.setString(6, medicamento.getDosePAtivo());
			ps.setString(7, medicamento.getDoseApresentacao());
			ps.setString(8, medicamento.getUso());
			ps.setString(9, medicamento.getIndicacao());
			ps.setString(10, medicamento.getFabricante());
			ps.setString(11, medicamento.getObservacao());
			if (medicamento.getIdProduto() > 0){
				ps.setInt(12, medicamento.getIdProduto());
			} else {
				ps.setNull(12, 0);
			}
			ps.setString(13, medicamento.getStatus());
			ps.setString(14, medicamento.getUsuario());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao atualizar dados: " + e);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}
	}

	public void atualizar(Medicamento medicamento) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (medicamento == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbmedicamento SET idMedicamento = ?, idGrupoMedicamento = ?, nmMedicamento = ?, principioAtivo = ?, apresentacao = ?, dosePAtivo = ?, doseApresentacao = ?, uso = ?, indicacao = ?, fabricante = ?, observacao = ?, idProduto = ?, status = ?, dtMod = now(), usuario = ? "
					+ "WHERE idmedicamento=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, medicamento.getIdMedicamento());
			ps.setInt(2, medicamento.getIdGrupoMedicamento());
			ps.setString(3, medicamento.getNmMedicamento());
			ps.setString(4, medicamento.getPrincipioAtivo());
			ps.setString(5, medicamento.getApresentacao());
			ps.setString(6, medicamento.getDosePAtivo());
			ps.setString(7, medicamento.getDoseApresentacao());
			ps.setString(8, medicamento.getUso());
			ps.setString(9, medicamento.getIndicacao());
			ps.setString(10, medicamento.getFabricante());
			ps.setString(11, medicamento.getObservacao());
			if (medicamento.getIdProduto() > 0){
				ps.setInt(12, medicamento.getIdProduto());
			} else {
				ps.setNull(12, 0);
			}
			ps.setString(13, medicamento.getStatus());
			ps.setString(14, medicamento.getUsuario());
			ps.setInt(15, medicamento.getIdMedicamento());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao atualizar dados: " + e);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps);
		}
	}

	public void excluir(Medicamento medicamento) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (medicamento == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbmedicamento WHERE idMedicamento = ?");
			ps.setInt(1, medicamento.getIdMedicamento());
			ps.executeUpdate();

		}catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		}finally {
			//ConnectionFactory.closeConnection(conn, ps);

		}
	}	
	
	public Medicamento procurarMedicamento(int idMedicamento) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		Medicamento medicamento = null;

		try {
			String sql = "SELECT idMedicamento, idGrupoMedicamento, nmMedicamento, principioAtivo, apresentacao, dosePAtivo, doseApresentacao, uso, indicacao, fabricante, observacao, idProduto, status, dtCad, dtMod, usuario FROM tbmedicamento "
				+ "WHERE idMedicamento=?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idMedicamento);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + idMedicamento);
			}
            
			int idGrupoMedicamento = rs.getInt(2);
			String nmMedicamento  = rs.getString(3);
			String principioAtivo  = rs.getString(4);
			String apresentacao  = rs.getString(5);
			String dosePAtivo  = rs.getString(6);
			String doseApresentacao  = rs.getString(7);
			String uso  = rs.getString(8);
			String indicacao  = rs.getString(9);
			String fabricante  = rs.getString(10);
			String observacao  = rs.getString(11);			
			int idProduto = rs.getInt(12);
			String status  = rs.getString(13);			
			Date dtCad = rs.getDate(14);
			Date dtMod = rs.getDate(15);
			String usuario  = rs.getString(16);
			
			medicamento = new Medicamento(idMedicamento, idGrupoMedicamento, nmMedicamento, principioAtivo, apresentacao, dosePAtivo, doseApresentacao, uso, indicacao, fabricante, observacao, idProduto, status, dtCad, dtMod, usuario);
			
		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return medicamento;
	}

	public List<Medicamento> listarMedicamento(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<Medicamento> list = null;
		
		try {
			String sql = "SELECT idMedicamento, idGrupoMedicamento, nmMedicamento, principioAtivo, apresentacao, dosePAtivo, doseApresentacao, uso, indicacao, fabricante, observacao, idProduto, status, dtCad, dtMod, usuario FROM tbmedicamento ";
			if (clausula != null) sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<Medicamento>();
			while (rs.next()) {
				
				int idMedicamento = rs.getInt(1);
				int idGrupoMedicamento = rs.getInt(2);
				String nmMedicamento  = rs.getString(3);
				String principioAtivo  = rs.getString(4);
				String apresentacao  = rs.getString(5);
				String dosePAtivo  = rs.getString(6);
				String doseApresentacao  = rs.getString(7);
				String uso  = rs.getString(8);
				String indicacao  = rs.getString(9);
				String fabricante  = rs.getString(10);
				String observacao  = rs.getString(11);			
				int idProduto = rs.getInt(12);
				String status  = rs.getString(13);			
				Date dtCad = rs.getDate(14);
				Date dtMod = rs.getDate(15);
				String usuario  = rs.getString(16);
				
				list.add(new Medicamento(idMedicamento, idGrupoMedicamento, nmMedicamento, principioAtivo, apresentacao, dosePAtivo, doseApresentacao, uso, indicacao, fabricante, observacao, idProduto, status, dtCad, dtMod, usuario));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}

	public boolean exclusaoIdMedicamento(int idMedicamento) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean ok = true;

		try {
			String sql = "select m.idMedicamento from tbmedicamento m " +
                         "join tbanimalmedicamento am on(m.idMedicamento = am.idMedicamento) " +
                         "where m.idMedicamento = ?";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idMedicamento);
			rs = ps.executeQuery();
			if (rs.next()) {
				ok = true;
			}else{
				ok = false;
			}
            
		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			//ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return ok;
	}

}
