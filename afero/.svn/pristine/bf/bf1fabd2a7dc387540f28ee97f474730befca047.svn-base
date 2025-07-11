package afero.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import afero.model.Orcamento;
import afero.model.Transferencia;
import afero.util.ConverteDate;

public class TransferenciaDAO implements ITransferenciaDAO{
	
	private Connection conn;
	
	public TransferenciaDAO(Connection conn) {
		this.conn = conn;
	}

	public void incluir(Transferencia transferencia) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (transferencia == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbtransferencia (idContaDe, idContaPara, valor, formaMovto, dtLanc, LancaAutomatico, historico, " +
						" cdTipoFrequencia, informaParcelas, quantParcelas, dtUltimoLanc, idColaborador, status, dtCad, dtMod, usuario)" +
						" VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now(), now(), ?);";
			

			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, transferencia.getIdContaDe());
			ps.setInt(2, transferencia.getIdContaPara());
			ps.setDouble(3, transferencia.getValor());
			ps.setString(4, transferencia.getFormaMovto());
			if(transferencia.getDtLanc() != null){
				ps.setDate(5, ConverteDate.DateToDateSql(transferencia.getDtLanc()));
			}else{
				ps.setDate(5, null);
			}
			ps.setString(6, transferencia.getLancaAutomatico());
			ps.setString(7, transferencia.getHistorico());
			ps.setInt(8, transferencia.getCdTipoFrequencia());
			ps.setString(9, transferencia.getInformaParcelas());
			ps.setInt(10, transferencia.getQuantParcelas());
			if(transferencia.getDtUltimoLanc() != null){
				ps.setDate(11, ConverteDate.DateToDateSql(transferencia.getDtUltimoLanc()));				
			}else{
				ps.setDate(11, null);
			}
			ps.setInt(12, transferencia.getIdColaborador());
			ps.setString(13, transferencia.getStatus());			
			ps.setString(14, transferencia.getUsuario());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);

		}
	}

	public void atualizar(Transferencia transferencia) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (transferencia == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbtransferencia set idContaDe = ?, idContaPara = ?, valor = ?, formaMovto = ?, dtLanc = ?, LancaAutomatico = ?," +
						" historico = ?, cdTipoFrequencia = ?, informaParcelas = ?, quantParcelas = ?, dtUltimoLanc = ?, idColaborador = ?," +
						" status = ?, dtCad = ?, dtMod = now(), usuario = ? " +
					     " WHERE idTransferencia = ?";
			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, transferencia.getIdContaDe());
			ps.setInt(2, transferencia.getIdContaPara());
			ps.setDouble(3, transferencia.getValor());
			ps.setString(4, transferencia.getFormaMovto());
			if(transferencia.getDtLanc() != null){
				ps.setDate(5, ConverteDate.DateToDateSql(transferencia.getDtLanc()));
			}else{
				ps.setDate(5, null);
			}
			ps.setString(6, transferencia.getLancaAutomatico());
			ps.setString(7, transferencia.getHistorico());
			ps.setInt(8, transferencia.getCdTipoFrequencia());
			ps.setString(9, transferencia.getInformaParcelas());
			ps.setInt(10, transferencia.getQuantParcelas());
			if(transferencia.getDtUltimoLanc() != null){
				ps.setDate(11, ConverteDate.DateToDateSql(transferencia.getDtUltimoLanc()));				
			}else{
				ps.setDate(11, null);
			}
			ps.setInt(12, transferencia.getIdColaborador());
			ps.setString(13, transferencia.getStatus());
			ps.setDate(14, ConverteDate.DateToDateSql(transferencia.getDtCad()));
			ps.setString(15, transferencia.getUsuario());
			ps.setInt(16, transferencia.getIdTransferencia());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao inserir dados: " + e);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps);

		}
	}
	public void excluir(Transferencia transferencia) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (transferencia == null)
			throw new AferoDAOException("O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn
					.prepareStatement("DELETE FROM tbtransferencia WHERE idTransferencia=?");
			ps.setInt(1, transferencia.getIdTransferencia());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		} finally {
			// ConnectionFactory.closeConnection(conn, ps);
		}

	}

		public Transferencia procurarTransferencia(int idTransferencia)throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		Transferencia transferencia = null;

		try {
			String sql = " SELECT idTransferencia, idContaDe, idContaPara, valor, formaMovto, dtLanc, LancaAutomatico, historico, " +
						" cdTipoFrequencia, informaParcelas, quantParcelas, dtUltimoLanc, idColaborador, status, dtCad, dtMod, usuario " +
						" FROM tbtransferencia " +
						" WHERE idTransferencia = ? ";
			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idTransferencia);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + idTransferencia);
			}
			int idTransf = rs.getInt(1);
            int idContaDe = rs.getInt(2);
            int idContaPara = rs.getInt(3);
            double valor = rs.getDouble(4);
            String formaMovto = rs.getString(5);
            Date dtLanc = rs.getDate(6);
            String LancaAutomatico = rs.getString(7);
            String historico = rs.getString(8);
            int cdTipoFrequencia = rs.getInt(9);
            String informaParcelas = rs.getString(10);
            int quantParcelas = rs.getInt(11);
            Date dtUltimoLanc = rs.getDate(12);
            int idColaborador = rs.getInt(13);
            String status = rs.getString(14);
            Date dtCad = rs.getDate(15);
            Date dtMod = rs.getDate(16);
            String usuario = rs.getString(17);
                        
            
            transferencia = new Transferencia( idTransf, idContaDe, idContaPara, valor, formaMovto, dtLanc, LancaAutomatico, historico,
            		cdTipoFrequencia, informaParcelas, quantParcelas, dtUltimoLanc, idColaborador, status, dtCad, dtMod, usuario);

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return transferencia;
	}
	
	

	public List listarTransferencia(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<Transferencia> list = null;

		try {
			String sql = "SELECT t.idTransferencia, t.idContaDe, t.idContaPara, t.valor, t.formaMovto, t.dtLanc, t.LancaAutomatico, t.historico, " +
						" t.cdTipoFrequencia, t.informaParcelas, t.quantParcelas, t.dtUltimoLanc, t.idColaborador, t.status, t.dtCad, t.dtMod, t.usuario" +
						" FROM tbtransferencia t ";
			if (clausula != null)
				sql = sql + clausula;
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<Transferencia>();
			while (rs.next()) {
				
				int idTransf = rs.getInt(1);
	            int idContaDe = rs.getInt(2);
	            int idContaPara = rs.getInt(3);
	            double valor = rs.getDouble(4);
	            String formaMovto = rs.getString(5);
	            Date dtLanc = rs.getDate(6);
	            String LancaAutomatico = rs.getString(7);
	            String historico = rs.getString(8);
	            int cdTipoFrequencia = rs.getInt(9);
	            String informaParcelas = rs.getString(10);
	            int quantParcelas = rs.getInt(11);
	            Date dtUltimoLanc = rs.getDate(12);
	            int idColaborador = rs.getInt(13);
	            String status = rs.getString(14);
	            Date dtCad = rs.getDate(15);
	            Date dtMod = rs.getDate(16);
	            String usuario = rs.getString(17);

				list.add(new Transferencia( idTransf, idContaDe, idContaPara, valor, formaMovto, dtLanc, LancaAutomatico, historico,
	            		cdTipoFrequencia, informaParcelas, quantParcelas, dtUltimoLanc, idColaborador, status, dtCad, dtMod, usuario));

			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} finally {
			// ConnectionFactory.closeConnection(conn, ps, rs);
		}
		return list;
	}

	
	

	
}
