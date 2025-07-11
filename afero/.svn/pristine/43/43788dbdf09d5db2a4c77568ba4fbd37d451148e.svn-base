package afero.integracao.xprocess.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import afero.integracao.xprocess.NfeLancamento;

import afero.persistence.AferoDAOException;

public class NfeLancamentoDAO {
	

	private Connection conn;

	public NfeLancamentoDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;
	}
	public void incluir(NfeLancamento nfeLancamento) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (nfeLancamento == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbnfelancamento (idNfe, dt_registro, id_modalidade_pagamento, ds_modalidade_pagamento, valor, " +
					                                "dt_vencimento, caut, nr_banco, nr_cheque, nr_conta, nr_agencia) " +
					                                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, nfeLancamento.getIdNfe());
			ps.setString(2, nfeLancamento.getDt_registro());
			ps.setString(3, nfeLancamento.getId_modalidade_pagamento());
			ps.setString(4, nfeLancamento.getDs_modalidade_pagamento());
			ps.setString(5, nfeLancamento.getValor());
			ps.setString(6, nfeLancamento.getDt_vencimento());
			ps.setString(7, nfeLancamento.getCaut());
			ps.setString(8, nfeLancamento.getNr_banco());
			ps.setString(9, nfeLancamento.getNr_cheque());
			ps.setString(10, nfeLancamento.getNr_conta());
			ps.setString(11, nfeLancamento.getNr_agencia());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} 
	}


}
