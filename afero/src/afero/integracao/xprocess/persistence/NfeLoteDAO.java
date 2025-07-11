package afero.integracao.xprocess.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import afero.integracao.xprocess.NfeLote;

import afero.persistence.AferoDAOException;
public class NfeLoteDAO {
	
	private Connection conn;

	public NfeLoteDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;
	}
	public void incluir(NfeLote nfeLote) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (nfeLote == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbnfelote (idNfe, tpamb, veraplic, cstat, xmotivo, cuf, nrec, dhrecbto, tmed, in_status, nm_usuario, " +
					                                "dt_registro, ds_xml, ds_xml_recebido) " +
													"VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setString(1, nfeLote.getIdNfe());
			ps.setString(2, nfeLote.getTpamb());
			ps.setString(3, nfeLote.getVeraplic());
			ps.setString(4, nfeLote.getCstat());
			ps.setString(5, nfeLote.getXmotivo());
			ps.setString(6, nfeLote.getCuf());
			ps.setString(7, nfeLote.getNrec());
			ps.setString(8, nfeLote.getDhrecbto());
			ps.setString(9, nfeLote.getTmed());
			ps.setString(10, nfeLote.getIn_status());
			ps.setString(11, nfeLote.getNm_usuario());
			ps.setString(12, nfeLote.getDt_registro());
			ps.setString(13, nfeLote.getDs_xml());
			ps.setString(14, nfeLote.getDs_xml_recebido());
				
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} 
	}

}
