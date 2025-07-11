package afero.integracao.xprocess.persistence;


import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import afero.integracao.xprocess.NfeProdutoServico;
import afero.integracao.xprocess.RelatorioCupom;

import afero.model.Estoque;
import afero.model.PedidoSaida;
import afero.persistence.AferoDAOException;
public class NfeProdutoServicoDAO {
	
	private Connection conn;

	public NfeProdutoServicoDAO(Connection conn) throws AferoDAOException {
		this.conn = conn;
	}
	public void incluir(NfeProdutoServico nfeProdutoServico) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		if (nfeProdutoServico == null)
			throw new AferoDAOException(
					"O valor passado não pode ser nulo");

		try {
			String sql = "INSERT INTO tbnfeproduto (idNfe, tp_registro, tp_produto_especifico, nitem, cprod, cean, xprod, ncm, extipi, genero, cfop, "+
													"ucom, qcom, vuncom, vprod, utrib, qtrib, vuntrib, vfrete, vseg, vdesc, imposto_orig, imposto_cst, "+
													"imposto_modbc, imposto_predbc, imposto_vbc, imposto_picms, imposto_vicms, imposto_modbcst, imposto_pmvast, "+
													"imposto_predbcst, imposto_vbcst, imposto_picmsst, imposto_vicmsst, importacao_vbc, importacao_vdespadu, "+
													"importacao_vii, importacao_viof, pis_cst, pis_vbc, pis_ppis, pis_qbcprod, pis_valiqprod, pis_vpis, pisst_vbc, " +
													"pisst_ppis, pisst_qbcprod, pisst_valiqprod, pisst_vpis, cofins_cst, cofins_vbc, cofins_pcofins, cofins_qbcprod, " +
													"cofins_valiqprod, cofins_vcofins, cofinsst_vbc, cofinsst_pcofins, cofinsst_qbcprod, cofinsst_valiqprod, cofinsst_vcofins, " +
													"ipi_cenq, ipi_cst, ipi_vbc, ipi_qunid, ipi_vunid, ipi_pipi, ipi_vipi, voutro, indtot, imposto_motdesicms, imposto_pcredsn, "+
													"imposto_vcredicmssn, cprod_alternativo, ii_vbc, ii_vdespadu, ii_vii, ii_viof, vtottrib, nfci, idPedidoSaida, serie) " +
													"VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, " +
													"?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, " +
													"?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, nfeProdutoServico.getIdNfe());
			ps.setString(2, nfeProdutoServico.getTp_registro());
			ps.setString(3, nfeProdutoServico.getTp_produto_especifico());
			ps.setString(4, nfeProdutoServico.getNitem());
			ps.setString(5, nfeProdutoServico.getCprod());
			ps.setString(6, nfeProdutoServico.getCean());
			ps.setString(7, nfeProdutoServico.getXprod());
			ps.setString(8, nfeProdutoServico.getNcm());
			ps.setString(9, nfeProdutoServico.getExtipi());
			ps.setString(10, nfeProdutoServico.getGenero());
			ps.setString(11, nfeProdutoServico.getCfop());
			ps.setString(12, nfeProdutoServico.getUcom());
			ps.setString(13, nfeProdutoServico.getQcom());
			ps.setString(14, nfeProdutoServico.getVuncom());
			ps.setString(15, nfeProdutoServico.getVprod());
			ps.setString(16, nfeProdutoServico.getUtrib());
			ps.setString(17, nfeProdutoServico.getQtrib());
			ps.setString(18, nfeProdutoServico.getVuntrib());
			ps.setString(19, nfeProdutoServico.getVfrete());
			ps.setString(20, nfeProdutoServico.getVseg());
			ps.setString(21, nfeProdutoServico.getVdesc());
			ps.setString(22, nfeProdutoServico.getImposto_orig());
			ps.setString(23, nfeProdutoServico.getImposto_cst());
			ps.setString(24, nfeProdutoServico.getImposto_modbc());
			ps.setString(25, nfeProdutoServico.getImposto_predbc());
			ps.setString(26, nfeProdutoServico.getImposto_vbc());
			ps.setString(27, nfeProdutoServico.getImposto_picms());
			ps.setString(28, nfeProdutoServico.getImposto_vicms());
			ps.setString(29, nfeProdutoServico.getImposto_modbcst());
			ps.setString(30, nfeProdutoServico.getImposto_pmvast());
			ps.setString(31, nfeProdutoServico.getImposto_predbcst());
			ps.setString(32, nfeProdutoServico.getImposto_vbcst());
			ps.setString(33, nfeProdutoServico.getImposto_picmsst());
			ps.setString(34, nfeProdutoServico.getImposto_vicmsst());
			ps.setString(35, nfeProdutoServico.getImportacao_vbc());
			ps.setString(36, nfeProdutoServico.getImportacao_vdespadu());
			ps.setString(37, nfeProdutoServico.getImportacao_vii());
			ps.setString(38, nfeProdutoServico.getImportacao_viof());
			ps.setString(39, nfeProdutoServico.getPis_cst());
			ps.setString(40, nfeProdutoServico.getPis_vbc());
			ps.setString(41, nfeProdutoServico.getPis_ppis());
			ps.setString(42, nfeProdutoServico.getPis_qbcprod());
			ps.setString(43, nfeProdutoServico.getPis_valiqprod());
			ps.setString(44, nfeProdutoServico.getPis_vpis());
			ps.setString(45, nfeProdutoServico.getPisst_vbc());
			ps.setString(46, nfeProdutoServico.getPisst_ppis());
			ps.setString(47, nfeProdutoServico.getPisst_qbcprod());
			ps.setString(48, nfeProdutoServico.getPisst_valiqprod());
			ps.setString(49, nfeProdutoServico.getPisst_vpis());
			ps.setString(50, nfeProdutoServico.getCofins_cst());
			ps.setString(51, nfeProdutoServico.getCofins_vbc());
			ps.setString(52, nfeProdutoServico.getCofins_pcofins());
			ps.setString(53, nfeProdutoServico.getCofins_qbcprod());
			ps.setString(54, nfeProdutoServico.getCofins_valiqprod());
			ps.setString(55, nfeProdutoServico.getCofins_vcofins());
			ps.setString(56, nfeProdutoServico.getCofinsst_vbc());
			ps.setString(57, nfeProdutoServico.getCofinsst_pcofins());
			ps.setString(58, nfeProdutoServico.getCofinsst_qbcprod());
			ps.setString(59, nfeProdutoServico.getCofinsst_valiqprod());
			ps.setString(60, nfeProdutoServico.getCofinsst_vcofins());
			ps.setString(61, nfeProdutoServico.getIpi_cenq());
			ps.setString(62, nfeProdutoServico.getIpi_cst());
			ps.setString(63, nfeProdutoServico.getIpi_vbc());
			ps.setString(64, nfeProdutoServico.getIpi_qunid());
			ps.setString(65, nfeProdutoServico.getIpi_vunid());
			ps.setString(66, nfeProdutoServico.getIpi_pipi());
			ps.setString(67, nfeProdutoServico.getIpi_vipi());
			ps.setString(68, nfeProdutoServico.getVoutro());
			ps.setString(69, nfeProdutoServico.getIndtot());
			ps.setString(70, nfeProdutoServico.getImposto_motdesicms());
			ps.setString(71, nfeProdutoServico.getImposto_pcredsn());
			ps.setString(72, nfeProdutoServico.getImposto_vcredicmssn());
			ps.setString(73, nfeProdutoServico.getCprod_alternativo());
			ps.setString(74, nfeProdutoServico.getIi_vbc());
			ps.setString(75, nfeProdutoServico.getIi_vdespadu());
			ps.setString(76, nfeProdutoServico.getIi_vii());
			ps.setString(77, nfeProdutoServico.getIi_viof());
			ps.setString(78, nfeProdutoServico.getVtottrib());
			ps.setString(79, nfeProdutoServico.getNfci());	
			ps.setInt(80, nfeProdutoServico.getIdPedidoSaida());
			ps.setInt(81, nfeProdutoServico.getSerie());
			ps.executeUpdate();

		} catch (SQLException sqle) {
			throw new AferoDAOException("Erro ao inserir dados: " + sqle);
		} 
	}
	
	public Integer procurarPedidoSaida(int idNfe) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		Integer nr_pedido = 0;
		
		
		try {
			String sql = "SELECT idNfe, idPedidoSaida " +
		     "FROM tbnfeproduto WHERE idNfe = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idNfe);
			rs = ps.executeQuery();
			
			while (rs.next()) {
				nr_pedido = rs.getInt(2);
			}
		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return nr_pedido;
	}
	
	public List listarProdutosNfe(int idNfe) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<NfeProdutoServico> list = null;
		NfeProdutoServico nfeProdutoServico = new NfeProdutoServico();
		
		try {
			String sql = "SELECT  idNfe, tp_registro, tp_produto_especifico, nitem, cprod, cean, xprod, ncm, extipi, genero, cfop, "+
													"ucom, qcom, vuncom, vprod, utrib, qtrib, vuntrib, vfrete, vseg, vdesc, imposto_orig, imposto_cst, "+
													"imposto_modbc, imposto_predbc, imposto_vbc, imposto_picms, imposto_vicms, imposto_modbcst, imposto_pmvast, "+
													"imposto_predbcst, imposto_vbcst, imposto_picmsst, imposto_vicmsst, importacao_vbc, importacao_vdespadu, "+
													"importacao_vii, importacao_viof, pis_cst, pis_vbc, pis_ppis, pis_qbcprod, pis_valiqprod, pis_vpis, pisst_vbc, " +
													"pisst_ppis, pisst_qbcprod, pisst_valiqprod, pisst_vpis, cofins_cst, cofins_vbc, cofins_pcofins, cofins_qbcprod, " +
													"cofins_valiqprod, cofins_vcofins, cofinsst_vbc, cofinsst_pcofins, cofinsst_qbcprod, cofinsst_valiqprod, cofinsst_vcofins, " +
													"ipi_cenq, ipi_cst, ipi_vbc, ipi_qunid, ipi_vunid, ipi_pipi, ipi_vipi, voutro, indtot, imposto_motdesicms, imposto_pcredsn, "+
													"imposto_vcredicmssn, cprod_alternativo, ii_vbc, ii_vdespadu, ii_vii, ii_viof, vtottrib, nfci, idPedidoSaida, serie " +
													"FROM tbnfeproduto WHERE idNfe = ? ";
			
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idNfe);
			rs = ps.executeQuery();
			list = new ArrayList<NfeProdutoServico>();
			while (rs.next()) {
				nfeProdutoServico.setIdNfe(idNfe);
				nfeProdutoServico.setTp_registro(rs.getString(2));
				nfeProdutoServico.setTp_produto_especifico(rs.getString(3));
				nfeProdutoServico.setNitem(rs.getString(4));
				nfeProdutoServico.setCprod(rs.getString(5));
				nfeProdutoServico.setCean(rs.getString(6));
				nfeProdutoServico.setXprod(rs.getString(7));
				nfeProdutoServico.setNcm(rs.getString(8));
				nfeProdutoServico.setExtipi(rs.getString(9));
				nfeProdutoServico.setGenero(rs.getString(10));
				nfeProdutoServico.setCfop(rs.getString(11));
				nfeProdutoServico.setUcom(rs.getString(12));
				nfeProdutoServico.setQcom(rs.getString(13));
				nfeProdutoServico.setVuncom(rs.getString(14));
				nfeProdutoServico.setVprod(rs.getString(15));
				nfeProdutoServico.setUtrib(rs.getString(16));
				nfeProdutoServico.setQtrib(rs.getString(17));
				nfeProdutoServico.setVuntrib(rs.getString(18));
				nfeProdutoServico.setVfrete(rs.getString(19));
				nfeProdutoServico.setVseg(rs.getString(20));
				nfeProdutoServico.setVdesc(rs.getString(21));
				nfeProdutoServico.setImposto_orig(rs.getString(22));
				nfeProdutoServico.setImposto_cst(rs.getString(23));
				nfeProdutoServico.setImposto_modbc(rs.getString(24));
				nfeProdutoServico.setImposto_predbc(rs.getString(25));
				nfeProdutoServico.setImposto_vbc(rs.getString(26));
				nfeProdutoServico.setImposto_picms(rs.getString(27));
				nfeProdutoServico.setImposto_vicms(rs.getString(28));
				nfeProdutoServico.setImposto_modbcst(rs.getString(29));
				nfeProdutoServico.setImposto_pmvast(rs.getString(30));
				nfeProdutoServico.setImposto_predbcst(rs.getString(31));
				nfeProdutoServico.setImposto_vbcst(rs.getString(32));
				nfeProdutoServico.setImposto_picmsst(rs.getString(33));
				nfeProdutoServico.setImposto_vicmsst(rs.getString(34));
				nfeProdutoServico.setImportacao_vbc(rs.getString(35));
				nfeProdutoServico.setImportacao_vdespadu(rs.getString(36));
				nfeProdutoServico.setImportacao_vii(rs.getString(37));
				nfeProdutoServico.setImportacao_viof(rs.getString(38));
				nfeProdutoServico.setPis_cst(rs.getString(39));
				nfeProdutoServico.setPis_vbc(rs.getString(40));
				nfeProdutoServico.setPis_ppis(rs.getString(41));
				nfeProdutoServico.setPis_qbcprod(rs.getString(42));
				nfeProdutoServico.setPis_valiqprod(rs.getString(43));
				nfeProdutoServico.setPis_vpis(rs.getString(44));
				nfeProdutoServico.setPisst_vbc(rs.getString(45));
				nfeProdutoServico.setPisst_ppis(rs.getString(46));
				nfeProdutoServico.setPisst_qbcprod(rs.getString(47));
				nfeProdutoServico.setPisst_valiqprod(rs.getString(48));
				nfeProdutoServico.setPisst_vpis(rs.getString(49));
				nfeProdutoServico.setCofins_cst(rs.getString(50));
				nfeProdutoServico.setCofins_vbc(rs.getString(51));
				nfeProdutoServico.setCofins_pcofins(rs.getString(52));
				nfeProdutoServico.setCofins_qbcprod(rs.getString(53));
				nfeProdutoServico.setCofins_valiqprod(rs.getString(54));
				nfeProdutoServico.setCofins_vcofins(rs.getString(55));
				nfeProdutoServico.setCofinsst_vbc(rs.getString(56));
				nfeProdutoServico.setCofinsst_pcofins(rs.getString(57));
				nfeProdutoServico.setCofinsst_qbcprod(rs.getString(58));
				nfeProdutoServico.setCofinsst_valiqprod(rs.getString(59));
				nfeProdutoServico.setCofinsst_vcofins(rs.getString(60));
				nfeProdutoServico.setIpi_cenq(rs.getString(61));
				nfeProdutoServico.setIpi_cst(rs.getString(62));
				nfeProdutoServico.setIpi_vbc(rs.getString(63));
				nfeProdutoServico.setIpi_qunid(rs.getString(64));
				nfeProdutoServico.setIpi_vunid(rs.getString(65));
				nfeProdutoServico.setIpi_pipi(rs.getString(66));
				nfeProdutoServico.setIpi_vipi(rs.getString(67));
				nfeProdutoServico.setVoutro(rs.getString(68));
				nfeProdutoServico.setIndtot(rs.getString(69));
				nfeProdutoServico.setImposto_motdesicms(rs.getString(70));
				nfeProdutoServico.setImposto_pcredsn(rs.getString(71));
				nfeProdutoServico.setImposto_vcredicmssn(rs.getString(72));
				nfeProdutoServico.setCprod_alternativo(rs.getString(73));
				nfeProdutoServico.setIi_vbc(rs.getString(74));
				nfeProdutoServico.setIi_vdespadu(rs.getString(75));
				nfeProdutoServico.setIi_vii(rs.getString(76));
				nfeProdutoServico.setIi_viof(rs.getString(77));
				nfeProdutoServico.setVtottrib(rs.getString(78));
				nfeProdutoServico.setNfci(rs.getString(79));	
				nfeProdutoServico.setIdPedidoSaida(rs.getInt(80));
				nfeProdutoServico.setSerie(rs.getInt(81));
				
				
				list.add(new NfeProdutoServico(nfeProdutoServico.getIdNfe(), nfeProdutoServico.getTp_registro(), nfeProdutoServico.getTp_produto_especifico(),
				nfeProdutoServico.getNitem(), nfeProdutoServico.getCprod(), nfeProdutoServico.getCean(), nfeProdutoServico.getXprod(), nfeProdutoServico.getNcm(),
				nfeProdutoServico.getExtipi(), nfeProdutoServico.getGenero(), nfeProdutoServico.getCfop(), nfeProdutoServico.getUcom(), nfeProdutoServico.getQcom(),
				nfeProdutoServico.getVuncom(), nfeProdutoServico.getVprod(), nfeProdutoServico.getUtrib(), nfeProdutoServico.getQtrib(), nfeProdutoServico.getVuntrib(),
				nfeProdutoServico.getVfrete(), nfeProdutoServico.getVseg(), nfeProdutoServico.getVdesc(), nfeProdutoServico.getImposto_orig(), nfeProdutoServico.getImposto_cst(),
				nfeProdutoServico.getImposto_modbc(), nfeProdutoServico.getImposto_predbc(), nfeProdutoServico.getImposto_vbc(), nfeProdutoServico.getImposto_picms(),
				nfeProdutoServico.getImposto_vicms(), nfeProdutoServico.getImposto_modbcst(), nfeProdutoServico.getImposto_pmvast(), nfeProdutoServico.getImposto_predbcst(),
				nfeProdutoServico.getImposto_vbcst(), nfeProdutoServico.getImposto_picmsst(), nfeProdutoServico.getImposto_vicmsst(), nfeProdutoServico.getImportacao_vbc(),
				nfeProdutoServico.getImportacao_vdespadu(), nfeProdutoServico.getImportacao_vii(), nfeProdutoServico.getImportacao_viof(), nfeProdutoServico.getPis_cst(),
				nfeProdutoServico.getPis_vbc(), nfeProdutoServico.getPis_ppis(), nfeProdutoServico.getPis_qbcprod(),nfeProdutoServico.getPis_valiqprod(),
				nfeProdutoServico.getPis_vpis(), nfeProdutoServico.getPisst_vbc(), nfeProdutoServico.getPisst_ppis(),nfeProdutoServico.getPisst_qbcprod(),
				nfeProdutoServico.getPisst_valiqprod(), nfeProdutoServico.getPisst_vpis(), nfeProdutoServico.getCofins_cst(), nfeProdutoServico.getCofins_vbc(),
				nfeProdutoServico.getCofins_pcofins(), nfeProdutoServico.getCofins_qbcprod(), nfeProdutoServico.getCofins_valiqprod(), nfeProdutoServico.getCofins_vcofins(),
				nfeProdutoServico.getCofinsst_vbc(), nfeProdutoServico.getCofinsst_pcofins(), nfeProdutoServico.getCofinsst_qbcprod(), nfeProdutoServico.getCofinsst_valiqprod(), nfeProdutoServico.getCofinsst_vcofins(),
				nfeProdutoServico.getIpi_cenq(), nfeProdutoServico.getIpi_cst(), nfeProdutoServico.getIpi_vbc(), nfeProdutoServico.getIpi_qunid(), nfeProdutoServico.getIpi_vunid(), nfeProdutoServico.getIpi_pipi(),
				nfeProdutoServico.getIpi_vipi(), nfeProdutoServico.getVoutro(), nfeProdutoServico.getIndtot(), nfeProdutoServico.getImposto_motdesicms(), nfeProdutoServico.getImposto_pcredsn(),nfeProdutoServico.getImposto_vcredicmssn(),
				nfeProdutoServico.getCprod_alternativo(),nfeProdutoServico.getIi_vbc(), nfeProdutoServico.getIi_vdespadu(),nfeProdutoServico.getIi_vii(),
				nfeProdutoServico.getIi_viof(),nfeProdutoServico.getVtottrib(), nfeProdutoServico.getNfci(),nfeProdutoServico.getIdPedidoSaida(), nfeProdutoServico.getSerie()));			
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return list;
	}
	
	public List RelatorioProdutosNfe(String clausula) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		List<RelatorioCupom> list = null;
		RelatorioCupom relatorioCupom = new RelatorioCupom();
		
		try {
			String sql = "SELECT p.idNfe, p.tp_registro, p.tp_produto_especifico, p.nitem, p.cprod, p.cean, p.xprod, p.ncm, p.extipi, p.genero, p.cfop, "+
													"p.ucom, p.qcom, p.vuncom, p.vprod, p.utrib, p.qtrib, p.vuntrib, p.vfrete, p.vseg, p.vdesc, p.imposto_orig, p.imposto_cst, "+
													"p.imposto_modbc, p.imposto_predbc, p.imposto_vbc, p.imposto_picms, p.imposto_vicms, p.imposto_modbcst, p.imposto_pmvast, "+
													"p.imposto_predbcst, p.imposto_vbcst, p.imposto_picmsst, p.imposto_vicmsst, p.importacao_vbc, p.importacao_vdespadu, "+
													"p.importacao_vii, p.importacao_viof, p.pis_cst, p.pis_vbc, p.pis_ppis, p.pis_qbcprod, p.pis_valiqprod, p.pis_vpis, p.pisst_vbc, " +
													"p.pisst_ppis, p.pisst_qbcprod, p.pisst_valiqprod, p.pisst_vpis, p.cofins_cst, p.cofins_vbc, p.cofins_pcofins, p.cofins_qbcprod, " +
													"p.cofins_valiqprod, p.cofins_vcofins, p.cofinsst_vbc, p.cofinsst_pcofins, p.cofinsst_qbcprod, p.cofinsst_valiqprod, p.cofinsst_vcofins, " +
													"p.ipi_cenq, ipi_cst, p.ipi_vbc, p.ipi_qunid, p.ipi_vunid, p.ipi_pipi, p.ipi_vipi, p.voutro, p.indtot, p.imposto_motdesicms, p.imposto_pcredsn, "+
													"p.imposto_vcredicmssn, p.cprod_alternativo, p.ii_vbc, p.ii_vdespadu, p.ii_vii, p.ii_viof, p.vtottrib, p.nfci, p.idPedidoSaida, n.nnf, n.demi, n.serie " +
													"FROM tbnfeproduto p "+
													"JOIN tbnfe n on p.idNfe = n.nnf AND p.serie = n.serie ";
		    if (clausula != null) sql = sql + clausula;	
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<RelatorioCupom>();
			while (rs.next()) {
				relatorioCupom.setIdNfe(1);
				relatorioCupom.setTp_registro(rs.getString(2));
				relatorioCupom.setTp_produto_especifico(rs.getString(3));
				relatorioCupom.setNitem(rs.getString(4));
				relatorioCupom.setCprod(rs.getString(5));
				relatorioCupom.setCean(rs.getString(6));
				relatorioCupom.setXprod(rs.getString(7));
				relatorioCupom.setNcm(rs.getString(8));
				relatorioCupom.setExtipi(rs.getString(9));
				relatorioCupom.setGenero(rs.getString(10));
				relatorioCupom.setCfop(rs.getString(11));
				relatorioCupom.setUcom(rs.getString(12));
				relatorioCupom.setQcom(rs.getString(13));
				relatorioCupom.setVuncom(rs.getString(14));
				relatorioCupom.setVprod(rs.getString(15));
				relatorioCupom.setUtrib(rs.getString(16));
				relatorioCupom.setQtrib(rs.getString(17));
				relatorioCupom.setVuntrib(rs.getString(18));
				relatorioCupom.setVfrete(rs.getString(19));
				relatorioCupom.setVseg(rs.getString(20));
				relatorioCupom.setVdesc(rs.getString(21));
				relatorioCupom.setImposto_orig(rs.getString(22));
				relatorioCupom.setImposto_cst(rs.getString(23));
				relatorioCupom.setImposto_modbc(rs.getString(24));
				relatorioCupom.setImposto_predbc(rs.getString(25));
				relatorioCupom.setImposto_vbc(rs.getString(26));
				relatorioCupom.setImposto_picms(rs.getString(27));
				relatorioCupom.setImposto_vicms(rs.getString(28));
				relatorioCupom.setImposto_modbcst(rs.getString(29));
				relatorioCupom.setImposto_pmvast(rs.getString(30));
				relatorioCupom.setImposto_predbcst(rs.getString(31));
				relatorioCupom.setImposto_vbcst(rs.getString(32));
				relatorioCupom.setImposto_picmsst(rs.getString(33));
				relatorioCupom.setImposto_vicmsst(rs.getString(34));
				relatorioCupom.setImportacao_vbc(rs.getString(35));
				relatorioCupom.setImportacao_vdespadu(rs.getString(36));
				relatorioCupom.setImportacao_vii(rs.getString(37));
				relatorioCupom.setImportacao_viof(rs.getString(38));
				relatorioCupom.setPis_cst(rs.getString(39));
				relatorioCupom.setPis_vbc(rs.getString(40));
				relatorioCupom.setPis_ppis(rs.getString(41));
				relatorioCupom.setPis_qbcprod(rs.getString(42));
				relatorioCupom.setPis_valiqprod(rs.getString(43));
				relatorioCupom.setPis_vpis(rs.getString(44));
				relatorioCupom.setPisst_vbc(rs.getString(45));
				relatorioCupom.setPisst_ppis(rs.getString(46));
				relatorioCupom.setPisst_qbcprod(rs.getString(47));
				relatorioCupom.setPisst_valiqprod(rs.getString(48));
				relatorioCupom.setPisst_vpis(rs.getString(49));
				relatorioCupom.setCofins_cst(rs.getString(50));
				relatorioCupom.setCofins_vbc(rs.getString(51));
				relatorioCupom.setCofins_pcofins(rs.getString(52));
				relatorioCupom.setCofins_qbcprod(rs.getString(53));
				relatorioCupom.setCofins_valiqprod(rs.getString(54));
				relatorioCupom.setCofins_vcofins(rs.getString(55));
				relatorioCupom.setCofinsst_vbc(rs.getString(56));
				relatorioCupom.setCofinsst_pcofins(rs.getString(57));
				relatorioCupom.setCofinsst_qbcprod(rs.getString(58));
				relatorioCupom.setCofinsst_valiqprod(rs.getString(59));
				relatorioCupom.setCofinsst_vcofins(rs.getString(60));
				relatorioCupom.setIpi_cenq(rs.getString(61));
				relatorioCupom.setIpi_cst(rs.getString(62));
				relatorioCupom.setIpi_vbc(rs.getString(63));
				relatorioCupom.setIpi_qunid(rs.getString(64));
				relatorioCupom.setIpi_vunid(rs.getString(65));
				relatorioCupom.setIpi_pipi(rs.getString(66));
				relatorioCupom.setIpi_vipi(rs.getString(67));
				relatorioCupom.setVoutro(rs.getString(68));
				relatorioCupom.setIndtot(rs.getString(69));
				relatorioCupom.setImposto_motdesicms(rs.getString(70));
				relatorioCupom.setImposto_pcredsn(rs.getString(71));
				relatorioCupom.setImposto_vcredicmssn(rs.getString(72));
				relatorioCupom.setCprod_alternativo(rs.getString(73));
				relatorioCupom.setIi_vbc(rs.getString(74));
				relatorioCupom.setIi_vdespadu(rs.getString(75));
				relatorioCupom.setIi_vii(rs.getString(76));
				relatorioCupom.setIi_viof(rs.getString(77));
				relatorioCupom.setVtottrib(rs.getString(78));
				relatorioCupom.setNfci(rs.getString(79));	
				relatorioCupom.setIdPedidoSaida(rs.getInt(80));
				relatorioCupom.setNnf(rs.getString(81));
				relatorioCupom.setDataEmissao(rs.getString(82));
				relatorioCupom.setSerie(rs.getString(83));
				
				
				list.add(new RelatorioCupom(relatorioCupom.getSerie(), relatorioCupom.getDataEmissao(), relatorioCupom.getIdNfe(), relatorioCupom.getTp_registro(), relatorioCupom.getTp_produto_especifico(),
						relatorioCupom.getNitem(), relatorioCupom.getCprod(), relatorioCupom.getCean(), relatorioCupom.getXprod(), relatorioCupom.getNcm(),
						relatorioCupom.getExtipi(), relatorioCupom.getGenero(), relatorioCupom.getCfop(), relatorioCupom.getUcom(), relatorioCupom.getQcom(),
						relatorioCupom.getVuncom(), relatorioCupom.getVprod(), relatorioCupom.getUtrib(), relatorioCupom.getQtrib(), relatorioCupom.getVuntrib(),
						relatorioCupom.getVfrete(), relatorioCupom.getVseg(), relatorioCupom.getVdesc(), relatorioCupom.getImposto_orig(), relatorioCupom.getImposto_cst(),
						relatorioCupom.getImposto_modbc(), relatorioCupom.getImposto_predbc(), relatorioCupom.getImposto_vbc(), relatorioCupom.getImposto_picms(),
						relatorioCupom.getImposto_vicms(), relatorioCupom.getImposto_modbcst(), relatorioCupom.getImposto_pmvast(), relatorioCupom.getImposto_predbcst(),
						relatorioCupom.getImposto_vbcst(), relatorioCupom.getImposto_picmsst(), relatorioCupom.getImposto_vicmsst(), relatorioCupom.getImportacao_vbc(),
						relatorioCupom.getImportacao_vdespadu(), relatorioCupom.getImportacao_vii(), relatorioCupom.getImportacao_viof(), relatorioCupom.getPis_cst(),
						relatorioCupom.getPis_vbc(), relatorioCupom.getPis_ppis(), relatorioCupom.getPis_qbcprod(),relatorioCupom.getPis_valiqprod(),
						relatorioCupom.getPis_vpis(), relatorioCupom.getPisst_vbc(), relatorioCupom.getPisst_ppis(),relatorioCupom.getPisst_qbcprod(),
						relatorioCupom.getPisst_valiqprod(), relatorioCupom.getPisst_vpis(), relatorioCupom.getCofins_cst(), relatorioCupom.getCofins_vbc(),
						relatorioCupom.getCofins_pcofins(), relatorioCupom.getCofins_qbcprod(), relatorioCupom.getCofins_valiqprod(), relatorioCupom.getCofins_vcofins(),
						relatorioCupom.getCofinsst_vbc(), relatorioCupom.getCofinsst_pcofins(), relatorioCupom.getCofinsst_qbcprod(), relatorioCupom.getCofinsst_valiqprod(), relatorioCupom.getCofinsst_vcofins(),
						relatorioCupom.getIpi_cenq(), relatorioCupom.getIpi_cst(), relatorioCupom.getIpi_vbc(), relatorioCupom.getIpi_qunid(), relatorioCupom.getIpi_vunid(), relatorioCupom.getIpi_pipi(),
						relatorioCupom.getIpi_vipi(), relatorioCupom.getVoutro(), relatorioCupom.getIndtot(), relatorioCupom.getImposto_motdesicms(), relatorioCupom.getImposto_pcredsn(),relatorioCupom.getImposto_vcredicmssn(),
						relatorioCupom.getCprod_alternativo(),relatorioCupom.getIi_vbc(), relatorioCupom.getIi_vdespadu(),relatorioCupom.getIi_vii(),
						relatorioCupom.getIi_viof(),relatorioCupom.getVtottrib(), relatorioCupom.getNfci(),relatorioCupom.getIdPedidoSaida(), relatorioCupom.getNnf()));			
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return list;
	}
	
	public boolean existeProduto(Integer idNfe, String CodigoProduto, String Cfop, String nitem, String idPedido) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		boolean id = false;
		
		try {
			String sql = " select pr.idNfeProduto "+ 
                         "from tbnfeproduto pr "+
                         "where pr.idNfe = ? AND pr.nitem = ? AND pr.cprod = ? AND pr.cfop = ? AND pr.idPedidoSaida = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idNfe);
			ps.setString(2, nitem);
			ps.setString(3, CodigoProduto);
			ps.setString(4, Cfop);
			ps.setString(5, idPedido);
			rs = ps.executeQuery();
			if (rs.next()) {
				id =true;
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return id;
	}
	
	public Integer getSerie(Integer idNfe, Integer idPedido) throws AferoDAOException {
		PreparedStatement ps = null;
		Connection conn = null;
		ResultSet rs = null;
		Integer serie = 0;
		
		try {
			String sql = " select pr.serie "+ 
                         "from tbnfe pr "+
                         "where pr.nnf = ? AND pr.idPedidoSaida = ? ";
			conn = this.conn;
			ps = conn.prepareStatement(sql);
			ps.setInt(1, idNfe);
			ps.setInt(2, idPedido);
			rs = ps.executeQuery();
			if (rs.next()) {
				serie = rs.getInt(1);
			}

		} catch (SQLException sqle) {
			throw new AferoDAOException(sqle);
		} 
		return serie;
	}

	
	
}
