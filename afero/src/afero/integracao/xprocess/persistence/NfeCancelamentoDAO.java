package afero.integracao.xprocess.persistence;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import afero.integracao.xprocess.NfeCancelamento;


import afero.persistence.AferoDAOException;
public class NfeCancelamentoDAO {
	
	private Connection conn;

	public NfeCancelamentoDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;
	}
	public void incluir(NfeCancelamento nfeCancelamento) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (nfeCancelamento == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbnfecancelamento (id_empresa, chnfe, xjust, tpamb, veraplic, cstat, " +
					                                "xmotivo, cuf, nprotcanc, dhrecbto, nm_usuario, dt_registro, id, " +
					                                "dhrevento, tpevento, nseqevento, descevento, nprot, ds_xml, ds_xml_recebido, idNfe) " +
						                            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, nfeCancelamento.getId_empresa());
			ps.setString(2, nfeCancelamento.getChnfe());
			ps.setString(3, nfeCancelamento.getXjust());
			ps.setString(4, nfeCancelamento.getTpamb());
			ps.setString(5, nfeCancelamento.getVeraplic());
			ps.setString(6, nfeCancelamento.getCstat());
			ps.setString(7, nfeCancelamento.getXmotivo());
			ps.setString(8, nfeCancelamento.getCuf());
			ps.setString(9, nfeCancelamento.getNprotcanc());
			ps.setString(10, nfeCancelamento.getDhrecbto());
			ps.setString(11, nfeCancelamento.getNm_usuario());
			ps.setString(12, nfeCancelamento.getDt_registro());
			ps.setString(13, nfeCancelamento.getId());
			ps.setString(14, nfeCancelamento.getDhrevento());
			ps.setString(15, nfeCancelamento.getTpevento());
			ps.setString(16, nfeCancelamento.getNseqevento());
			ps.setString(17, nfeCancelamento.getDescevento());
			ps.setString(18, nfeCancelamento.getNprot());
			ps.setString(19, nfeCancelamento.getDs_xml());
			ps.setString(20, nfeCancelamento.getDs_xml_recebido());
			ps.setString(21, nfeCancelamento.getIdNfe());
				
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} 
	}

}
