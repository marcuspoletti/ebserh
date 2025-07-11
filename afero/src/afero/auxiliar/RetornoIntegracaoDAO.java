package afero.auxiliar;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import afero.persistence.AferoDAOException;
import afero.util.ConverteDate;
import afero.auxiliar.RetornoIntegracao;



public class RetornoIntegracaoDAO {
	
	
	private Connection conn;

	public RetornoIntegracaoDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;		
	}

	public void incluir(RetornoIntegracao retornoIntegracao) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (retornoIntegracao == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");
		try {
			String sql = "INSERT INTO tbretornointegracao (status, status_sefaz, mensagem_sefaz, chave_nfe, numero, serie, caminho_xml_nota_fiscal, caminho_danfe, " +
					     "requisicao_nota_fiscal, protocolo_nota_fiscal, versao, ambiente, versao_aplicativo, data_recebimento, numero_protocolo, digest_value, statusValue, " +
					     "chave_nfe_value, motivo, qrcode_url, url_consulta_nf, idPedidoSaida) "+
					     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, retornoIntegracao.getStatus());
			ps.setString(2, retornoIntegracao.getStatus_sefaz());
			ps.setString(3, retornoIntegracao.getMensagem_sefaz());
			ps.setString(4, retornoIntegracao.getChave_nfe());
			ps.setString(5, retornoIntegracao.getNumero());
			ps.setString(6, retornoIntegracao.getSerie());
			ps.setString(7, retornoIntegracao.getCaminho_xml_nota_fiscal());
			ps.setString(8, retornoIntegracao.getCaminho_danfe());
			ps.setString(9, retornoIntegracao.getRequisicao_nota_fiscal());
			ps.setString(10, retornoIntegracao.getProtocolo_nota_fiscal());
			ps.setString(11, retornoIntegracao.getVersao());
			ps.setString(12, retornoIntegracao.getAmbiente());
			ps.setString(13, retornoIntegracao.getVersao_aplicativo());
			ps.setString(14, retornoIntegracao.getData_recebimento());
			ps.setString(15, retornoIntegracao.getNumero_protocolo());
			ps.setString(16, retornoIntegracao.getDigest_value());
			ps.setString(17, retornoIntegracao.getStatusValue());
			ps.setString(18, retornoIntegracao.getChave_nfe_value());
			ps.setString(19, retornoIntegracao.getMotivo());
			ps.setString(20, retornoIntegracao.getQrcode_url());
			ps.setString(21, retornoIntegracao.getUrl_consulta_nf());
			ps.setString(22, retornoIntegracao.getIdPedidoSaida());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao atualizar dados: " + e);
		}
	}

	public void atualizar(RetornoIntegracao retornoIntegracao) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (retornoIntegracao == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "UPDATE tbretornointegracao SET status = ?, status_sefaz = ?, mensagem_sefaz = ?, chave_nfe = ?, numero = ?, serie = ?, caminho_xml_nota_fiscal = ?, caminho_danfe = ?, " +
					     "requisicao_nota_fiscal = ?, protocolo_nota_fiscal = ?, versao = ?, ambiente = ?, versao_aplicativo = ?, data_recebimento = ?, numero_protocolo = ?, digest_value = ?, statusValue = ?, " +
					     "chave_nfe_value = ?, motivo = ?, qrcode_url = ?, url_consulta_nf = ?, idPedidoSaida = ? "+
					     "WHERE idRetornoIntegracao = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, retornoIntegracao.getStatus());
			ps.setString(2, retornoIntegracao.getStatus_sefaz());
			ps.setString(3, retornoIntegracao.getMensagem_sefaz());
			ps.setString(4, retornoIntegracao.getChave_nfe());
			ps.setString(5, retornoIntegracao.getNumero());
			ps.setString(6, retornoIntegracao.getSerie());
			ps.setString(7, retornoIntegracao.getCaminho_xml_nota_fiscal());
			ps.setString(8, retornoIntegracao.getCaminho_danfe());
			ps.setString(9, retornoIntegracao.getRequisicao_nota_fiscal());
			ps.setString(10, retornoIntegracao.getProtocolo_nota_fiscal());
			ps.setString(11, retornoIntegracao.getVersao());
			ps.setString(12, retornoIntegracao.getAmbiente());
			ps.setString(13, retornoIntegracao.getVersao_aplicativo());
			ps.setString(14, retornoIntegracao.getData_recebimento());
			ps.setString(15, retornoIntegracao.getNumero_protocolo());
			ps.setString(16, retornoIntegracao.getDigest_value());
			ps.setString(17, retornoIntegracao.getStatusValue());
			ps.setString(18, retornoIntegracao.getChave_nfe_value());
			ps.setString(19, retornoIntegracao.getMotivo());
			ps.setString(20, retornoIntegracao.getQrcode_url());
			ps.setString(21, retornoIntegracao.getUrl_consulta_nf());
			ps.setString(22, retornoIntegracao.getIdPedidoSaida());
			ps.setInt(23, retornoIntegracao.getIdRetornoIntegracao());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao atualizar dados: " + sqle);
		} catch (Exception e) {
			throw new AferoDAOException("Erro ao atualizar dados: " + e);
		} 
	}

	public void excluir(RetornoIntegracao retornoIntegracao) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;

		if (retornoIntegracao == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			conn = this.conn;
			ps = conn.prepareStatement("DELETE FROM tbretornointegracao WHERE idRetornoIntegracao = ?");
			ps.setInt(1, retornoIntegracao.getIdRetornoIntegracao());
			ps.executeUpdate();

		}catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao excluir dados:" + sqle);

		}
	}
	
	public RetornoIntegracao procurarRetornoIntegracao(int idRetornoIntegracao) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		RetornoIntegracao retornoIntegracao = null;

		try {
			String sql = "SELECT idRetornoIntegracao, status, status_sefaz, mensagem_sefaz, chave_nfe, "+
						 "numero, serie, caminho_xml_nota_fiscal, caminho_danfe, requisicao_nota_fiscal, protocolo_nota_fiscal, " +
						 "versao, ambiente, versao_aplicativo, data_recebimento, numero_protocolo, digest_value, statusValue, "+
			             "chave_nfe_value, motivo, qrcode_url, url_consulta_nf, idPedidoSaida "+
				         "WHERE idRetornoIntegracao = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idRetornoIntegracao);
			rs = ps.executeQuery();
			if (!rs.next()) {
				throw new AferoDAOException("Não foi encontrado nenhum "
						+ "registro com o código: " + idRetornoIntegracao);
			}
            
			String status = rs.getString(2);
			String status_sefaz = rs.getString(3);
			String mensagem_sefaz = rs.getString(4);
			String chave_nfe = rs.getString(5);
			String numero = rs.getString(6);
			String serie = rs.getString(7);
			String caminho_xml_nota_fiscal = rs.getString(8);
			String caminho_danfe = rs.getString(9);
			String requisicao_nota_fiscal = rs.getString(10);
			String protocolo_nota_fiscal = rs.getString(11);
			String versao = rs.getString(12);
			String ambiente = rs.getString(13);
			String versao_aplicativo = rs.getString(14);
			String data_recebimento = rs.getString(15);
			String numero_protocolo = rs.getString(16);
			String digest_value = rs.getString(17);
			String statusValue = rs.getString(18);
			String chave_nfe_value = rs.getString(19);
			String motivo = rs.getString(20);
			String qrcode_url = rs.getString(21);
			String url_consulta_nf = rs.getString(22);
			String idPedidoSaida = rs.getString(23);
			
			retornoIntegracao = new RetornoIntegracao(idRetornoIntegracao, status,
					status_sefaz, mensagem_sefaz, chave_nfe,
					numero, serie, caminho_xml_nota_fiscal,
					caminho_danfe, requisicao_nota_fiscal,
					protocolo_nota_fiscal, versao, ambiente,
					versao_aplicativo, data_recebimento,
					numero_protocolo, digest_value, statusValue,
					chave_nfe_value, motivo, qrcode_url,
					url_consulta_nf, idPedidoSaida);
			
		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return retornoIntegracao;
	}
}
