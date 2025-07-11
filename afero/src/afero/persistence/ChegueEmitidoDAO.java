package afero.persistence;

	import java.sql.Connection;
	import java.sql.PreparedStatement;
	import java.sql.ResultSet;
	import java.sql.SQLException;
	import java.util.ArrayList;
	import java.util.Date;
	import java.util.List;
	import afero.model.ChegueEmitido;
import afero.util.ConverteDate;

	public class ChegueEmitidoDAO {
		private Connection conn;

		public ChegueEmitidoDAO(Connection conn) {
			this.conn = conn;
		}

		public void incluir(ChegueEmitido chegueEmitido) throws AferoDAOException {
			PreparedStatement ps = null;
			Connection conn = null;
			String sql = "";
			if (chegueEmitido == null)
				throw new AferoDAOException("O valor passado não pode ser nulo");

			try {
				sql = "INSERT INTO tbchequeemitido(idLoja, idConta, nrCheque, valor, dtEmissao, dtVenc, favorecido, cpfCnpj, dtPagto, status, dtCad, dtMod, usuario) "+
				      "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now(), now(), ?);";
				
				conn = this.conn;
				ps = conn.prepareStatement(sql);
				
				ps.setInt(1, chegueEmitido.getIdLoja());
				ps.setInt(2, chegueEmitido.getIdConta());
				ps.setInt(3, chegueEmitido.getNrChegue());
				ps.setDouble(4, chegueEmitido.getValor());
				ps.setDate(5, ConverteDate.DateToDateSql(chegueEmitido.getDtEmissao()));
				if(chegueEmitido.getDtVenc() != null){
					ps.setDate(6, ConverteDate.DateToDateSql(chegueEmitido.getDtVenc()));
				}else{
					ps.setDate(6, null);
				}
				ps.setString(7, chegueEmitido.getFavorecido());
				ps.setString(8, chegueEmitido.getCpfCnpj());
				ps.setDate(9, ConverteDate.DateToDateSql(chegueEmitido.getDtPagto()));
				//ps.setInt(10, chegueEmitido.getIdContaMovto());
				ps.setString(10, chegueEmitido.getStatus());
				ps.setString(11, chegueEmitido.getUsuario());
				ps.executeUpdate();

			} catch (SQLException sqle) {
				throw new AferoDAOException("Erro ao inserir dados: " + sqle);
			} catch (Exception e) {
				throw new AferoDAOException("Erro ao inserir dados: " + e);
			} finally {
				// ConnectionFactory.closeConnection(conn, ps);

			}
		}

		public void atualizar(ChegueEmitido chegueEmitido) throws AferoDAOException {
			PreparedStatement ps = null;
			Connection conn = null;
			if (chegueEmitido == null)
				throw new AferoDAOException("O valor passado não pode ser nulo");

			try {

				String sql = "UPDATE tbchequeemitido set idLoja = ?, idConta = ?, nrCheque = ?, valor = ?, dtEmissao = ?, dtVenc = ?, favorecido = ?, cpfCnpj = ?, dtPagto = ?, status = ?, dtMod = now(), usuario = ? " +
				             "WHERE idChequeEmitido = ? ;";
				conn = this.conn;
				ps = conn.prepareStatement(sql);
				ps.setInt(1, chegueEmitido.getIdLoja());
				ps.setInt(2, chegueEmitido.getIdConta());
				ps.setInt(3, chegueEmitido.getNrChegue());
				ps.setDouble(4, chegueEmitido.getValor());
				ps.setDate(5, ConverteDate.DateToDateSql(chegueEmitido.getDtEmissao()));
				if(chegueEmitido.getDtVenc() != null){
					ps.setDate(6, ConverteDate.DateToDateSql(chegueEmitido.getDtVenc()));
				}else{
					ps.setDate(6, null);
				}
				ps.setString(7, chegueEmitido.getFavorecido());
				ps.setString(8, chegueEmitido.getCpfCnpj());
				ps.setDate(9, ConverteDate.DateToDateSql(chegueEmitido.getDtPagto()));
				//ps.setInt(10, chegueEmitido.getIdContaMovto());
				ps.setString(10, chegueEmitido.getStatus());
				ps.setString(11, chegueEmitido.getUsuario());
				ps.setInt(12, chegueEmitido.getIdChegueEmitido());
				ps.executeUpdate();

			} catch (SQLException sqle) {
				throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
			} catch (Exception e) {
				throw new AferoDAOException("Erro ao inserir dados: " + e);
			} finally {
				// ConnectionFactory.closeConnection(conn, ps);

			}
		}

		public void excluir(ChegueEmitido chegueEmitido) throws AferoDAOException {
			PreparedStatement ps = null;
			Connection conn = null;

			if (chegueEmitido == null)
				throw new AferoDAOException("O valor passado não pode ser nulo");

			try {
				conn = this.conn;
				ps = conn.prepareStatement("DELETE FROM tbchequeemitido WHERE idChequeEmitido = ? ");
				ps.setInt(1, chegueEmitido.getIdChegueEmitido());
				ps.executeUpdate();

			} catch (SQLException sqle) {
				throw new AferoDAOException("Erro ao excluir dados:" + sqle);

			} finally {
				// ConnectionFactory.closeConnection(conn, ps);
			}

		}

		public ChegueEmitido procurarChegueEmitido(int idChegueEmitido)
				throws AferoDAOException {
			PreparedStatement ps = null;
			Connection conn = null;
			ResultSet rs = null;
			ChegueEmitido chegueEmitido = null;

			try {
				String sql = "SELECT idLoja, idConta, nrCheque, valor, dtEmissao, dtVenc, favorecido, cpfCnpj, dtPagto, idContaMovto, status, dtCad, dtMod, usuario "+
						     "from tbchequeemitido Where idChequeEmitido = ?";
				conn = this.conn;
				ps = conn.prepareStatement(sql);
				ps.setInt(1, idChegueEmitido);
				rs = ps.executeQuery();
				if (!rs.next()) {
					throw new AferoDAOException("Não foi encontrado nenhum "
							+ "registro com o código: " + idChegueEmitido);
				}
				
				int idLoja = rs.getInt(1);
				int idConta = rs.getInt(2);
				int nrChegue = rs.getInt(3);
				double valor = rs.getDouble(4);
				Date dtEmissao = rs.getDate(5);
				Date dtVenc = rs.getDate(6);
				String favorecido = rs.getString(7);
				String cpfCnpj = rs.getString(8);
				Date dtPagto = rs.getDate(9);
				int idContaMovto = rs.getInt(10);
				String status = rs.getString(11);
				Date dtCad = rs.getDate(12);
				Date dtMod = rs.getDate(13);
				String usuario = rs.getString(14);
				chegueEmitido = new ChegueEmitido(idChegueEmitido, idLoja, idConta, nrChegue,
						valor, dtEmissao, dtVenc, favorecido,
						cpfCnpj, dtPagto, idContaMovto, status,
						dtCad, dtMod, usuario);

			} catch (SQLException sqle) {
				throw new AferoDAOException(sqle);
			} finally {
				// ConnectionFactory.closeConnection(conn, ps, rs);
			}
			return chegueEmitido;
		}

		public List listarChegueEmitido(String clausula) throws AferoDAOException {
			PreparedStatement ps = null;
			Connection conn = null;
			ResultSet rs = null;
			List<ChegueEmitido> list = null;

			try {
				String sql = "SELECT ch.idChequeEmitido, ch.idLoja, ch.idConta, ch.nrCheque, ch.valor, ch.dtEmissao, ch.dtVenc, ch.favorecido, ch.cpfCnpj, ch.dtPagto, ch.idContaMovto, ch.status, ch.dtCad, ch.dtMod, ch.usuario "+
						     "from tbchequeemitido ch ";
				if (clausula != null)
					sql = sql + clausula;
				conn = this.conn;
				ps = conn.prepareStatement(sql);
				rs = ps.executeQuery();
				list = new ArrayList<ChegueEmitido>();
				while (rs.next()) {
					
					int idChegueEmitido = rs.getInt(1);
					int idLoja = rs.getInt(2);
					int idConta = rs.getInt(3);
					int nrChegue = rs.getInt(4);
					double valor = rs.getDouble(5);
					Date dtEmissao = rs.getDate(6);
					Date dtVenc = rs.getDate(7);
					String favorecido = rs.getString(8);
					String cpfCnpj = rs.getString(9);
					Date dtPagto = rs.getDate(10);
					int idContaMovto = rs.getInt(11);
					String status = rs.getString(12);
					Date dtCad = rs.getDate(13);
					Date dtMod = rs.getDate(14);
					String usuario = rs.getString(15);
					list.add(new ChegueEmitido(idChegueEmitido, idLoja, idConta, nrChegue,
							valor, dtEmissao, dtVenc, favorecido,
							cpfCnpj, dtPagto, idContaMovto, status,
							dtCad, dtMod, usuario));

				}

			} catch (SQLException sqle) {
				throw new AferoDAOException(sqle);
			} finally {
				// ConnectionFactory.closeConnection(conn, ps, rs);
			}
			return list;
		}


}
