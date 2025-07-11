package afero.integracao.xprocess.persistence;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import afero.integracao.xprocess.NfeFormaPagamento;

import afero.persistence.AferoDAOException;
public class NfeFormaPagamentoDAO {
	
	
	private Connection conn;

	public NfeFormaPagamentoDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;
	}
	public void incluir(NfeFormaPagamento nfeFormaPagamento) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (nfeFormaPagamento == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbnfeformapagamento (idNfe, tpag, vpag, cnpj, tband, caut, dt_registro, ds_descricao_comercial_midas, nr_banco, " +
					     "nr_cheque, nr_conta, nr_agencia, id_modalidade_pagamento, dt_vencimento) " +
						 "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, nfeFormaPagamento.getIdNfe());
			ps.setString(2, nfeFormaPagamento.getTpag());
			ps.setString(3, nfeFormaPagamento.getVpag());
			ps.setString(4, nfeFormaPagamento.getCnpj());
			ps.setString(5, nfeFormaPagamento.getTband());
			ps.setString(6, nfeFormaPagamento.getCaut());
			ps.setString(7, nfeFormaPagamento.getDt_registro());
			ps.setString(8, nfeFormaPagamento.getDs_descricao_comercial_midas());
			ps.setString(9, nfeFormaPagamento.getNr_banco());
			ps.setString(10, nfeFormaPagamento.getNr_cheque());
			ps.setString(11, nfeFormaPagamento.getNr_conta());
			ps.setString(12, nfeFormaPagamento.getNr_agencia());
			ps.setString(13, nfeFormaPagamento.getId_modalidade_pagamento());
			ps.setString(14, nfeFormaPagamento.getDt_vencimento());
				
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} 
	}
	


}
