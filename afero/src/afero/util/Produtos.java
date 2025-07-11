package afero.util;

import java.util.Date;

public class Produtos {
	
	private String tipo = "";
	private String coddBarras = "";
	private String descProduto = "";
	private String qtdEstoque = "";
	private String valorVarejo = "";
	private String descontoMax = "";
	private String naoUsado1 = "";
	private String coddProduto = "";
	private String unidadeVenda = "";
	private String custo = "";
	private String custoMedio = "";
	private String markup = "";
	private String naoUsado2 = "";
	private String aliquotaICMS = "";
	private String valorComissão = "";
	private String CSTOrigMercadoria = "";
	private String CSTTribICMS = "";
	private String naoUsado3 = "";
	private String naoUsado4 = "";
    private String reducao = "";
    private String codCSTPIS;
    private String codCSTCOFINS;
    private String alquotaPIS;
    private String aliquotaCOFINS;
    private String naoUsado5;
    private String naoUsado6;
    private String naoUsado7;
    private String naoUsado8;
    private String codNCM;
    private String CFOPPFisica;
    private String CFOPPJuridica;
    private String percentualCargaTributária;
    private String naoUsado10;
    private String naoUsado11;
    private String idSecao;

    private String cProd;
	private String cEAN;
	private String xProd;
	private String NCM;
	private String NVE;
	private String EXTIPI;
	private String CFOP;
	private String uCom;
	private String qCom;
	private String vUnCom;
	private String vProd;
	private String cEANTrib;
	private String uTrib;
	private String qTrib;
	private String vUnTrib;
	private String vFrete;
	private String vSeg;
	private String vDesc;
	private String vOutro;
	private String indTot;
	
	private int idProduto = 0;
	private int idDivisao = 0;
	private int idSubGrupo = 0;
	private int idGrupo = 0;
	private String nmProduto = "";
	private String dsProduto = "";
	private String tipoProduto = "";
	private String status = "";
	private Date dtCad;
	private Date dtMod;
	private String usuario = "";
	private String cdBarra = "";
	
	
	//Modulo Comandas
	private int quantFatias = 0;
	private String impProducao = "";
	
	//Modulo Fiscal
	
	private int idCatTributaria = 0;
	private String cdNcm = "";
	private int cdCfopSaidaDentro = 0;
	private int cdCfopSaidaFora = 0;
	private String cdBarraTrib = "";
	private String cdExTipi = "";
	private String cdGenero = "";
	
	
	
	
	
	public Produtos() {
		
	}
	public Produtos(String tipo, String coddBarras, String descProduto,
			String qtdEstoque, String valorVarejo, String descontoMax,
			String naoUsado1, String coddProduto, String unidadeVenda,
			String custo, String custoMedio, String markup, String naoUsado2,
			String aliquotaICMS, String valorComissão,
			String cSTOrigMercadoria, String cSTTribICMS, String naoUsado3,
			String naoUsado4, String reducao, String codCSTPIS,
			String codCSTCOFINS, String alquotaPIS, String aliquotaCOFINS,
			String naoUsado5, String naoUsado6, String naoUsado7,
			String naoUsado8, String codNCM, String cFOPPFisica,
			String cFOPPJuridica, String percentualCargaTributária,
			String naoUsado10, String naoUsado11, String idSecao, String cProd,
			String cEAN, String xProd, String nCM, String nVE, String eXTIPI,
			String cFOP, String uCom, String qCom, String vUnCom, String vProd,
			String cEANTrib, String uTrib, String qTrib, String vUnTrib,
			String vFrete, String vSeg, String vDesc, String vOutro,
			String indTot) {
		super();
		this.tipo = tipo;
		this.coddBarras = coddBarras;
		this.descProduto = descProduto;
		this.qtdEstoque = qtdEstoque;
		this.valorVarejo = valorVarejo;
		this.descontoMax = descontoMax;
		this.naoUsado1 = naoUsado1;
		this.coddProduto = coddProduto;
		this.unidadeVenda = unidadeVenda;
		this.custo = custo;
		this.custoMedio = custoMedio;
		this.markup = markup;
		this.naoUsado2 = naoUsado2;
		this.aliquotaICMS = aliquotaICMS;
		this.valorComissão = valorComissão;
		CSTOrigMercadoria = cSTOrigMercadoria;
		CSTTribICMS = cSTTribICMS;
		this.naoUsado3 = naoUsado3;
		this.naoUsado4 = naoUsado4;
		this.reducao = reducao;
		this.codCSTPIS = codCSTPIS;
		this.codCSTCOFINS = codCSTCOFINS;
		this.alquotaPIS = alquotaPIS;
		this.aliquotaCOFINS = aliquotaCOFINS;
		this.naoUsado5 = naoUsado5;
		this.naoUsado6 = naoUsado6;
		this.naoUsado7 = naoUsado7;
		this.naoUsado8 = naoUsado8;
		this.codNCM = codNCM;
		CFOPPFisica = cFOPPFisica;
		CFOPPJuridica = cFOPPJuridica;
		this.percentualCargaTributária = percentualCargaTributária;
		this.naoUsado10 = naoUsado10;
		this.naoUsado11 = naoUsado11;
		this.idSecao = idSecao;
		this.cProd = cProd;
		this.cEAN = cEAN;
		this.xProd = xProd;
		NCM = nCM;
		NVE = nVE;
		EXTIPI = eXTIPI;
		CFOP = cFOP;
		this.uCom = uCom;
		this.qCom = qCom;
		this.vUnCom = vUnCom;
		this.vProd = vProd;
		this.cEANTrib = cEANTrib;
		this.uTrib = uTrib;
		this.qTrib = qTrib;
		this.vUnTrib = vUnTrib;
		this.vFrete = vFrete;
		this.vSeg = vSeg;
		this.vDesc = vDesc;
		this.vOutro = vOutro;
		this.indTot = indTot;
	}
	public Produtos(String tipo, String coddBarras, String descProduto,
			String qtdEstoque, String valorVarejo, String descontoMax,
			String naoUsado1, String coddProduto, String unidadeVenda,
			String custo, String custoMedio, String markup, String naoUsado2,
			String aliquotaICMS, String valorComissão,
			String cSTOrigMercadoria, String cSTTribICMS, String naoUsado3,
			String naoUsado4, String reducao, String codCSTPIS,
			String codCSTCOFINS, String alquotaPIS, String aliquotaCOFINS,
			String naoUsado5, String naoUsado6, String naoUsado7,
			String naoUsado8, String codNCM, String cFOPPFisica,
			String cFOPPJuridica, String percentualCargaTributária,
			String naoUsado10, String naoUsado11, String idSecao) {
		super();
		this.tipo = tipo;
		this.coddBarras = coddBarras;
		this.descProduto = descProduto;
		this.qtdEstoque = qtdEstoque;
		this.valorVarejo = valorVarejo;
		this.descontoMax = descontoMax;
		this.naoUsado1 = naoUsado1;
		this.coddProduto = coddProduto;
		this.unidadeVenda = unidadeVenda;
		this.custo = custo;
		this.custoMedio = custoMedio;
		this.markup = markup;
		this.naoUsado2 = naoUsado2;
		this.aliquotaICMS = aliquotaICMS;
		this.valorComissão = valorComissão;
		CSTOrigMercadoria = cSTOrigMercadoria;
		CSTTribICMS = cSTTribICMS;
		this.naoUsado3 = naoUsado3;
		this.naoUsado4 = naoUsado4;
		this.reducao = reducao;
		this.codCSTPIS = codCSTPIS;
		this.codCSTCOFINS = codCSTCOFINS;
		this.alquotaPIS = alquotaPIS;
		this.aliquotaCOFINS = aliquotaCOFINS;
		this.naoUsado5 = naoUsado5;
		this.naoUsado6 = naoUsado6;
		this.naoUsado7 = naoUsado7;
		this.naoUsado8 = naoUsado8;
		this.codNCM = codNCM;
		CFOPPFisica = cFOPPFisica;
		CFOPPJuridica = cFOPPJuridica;
		this.percentualCargaTributária = percentualCargaTributária;
		this.naoUsado10 = naoUsado10;
		this.naoUsado11 = naoUsado11;
		this.idSecao = idSecao;
	}
	public Produtos(int idProduto, int idDivisao, int idSubGrupo, int idGrupo,
			String nmProduto, String dsProduto, String tipoProduto,
			String status, Date dtCad, Date dtMod, String usuario,
			String cdBarra) {
		this.idProduto = idProduto;
		this.idDivisao = idDivisao;
		this.idSubGrupo = idSubGrupo;
		this.idGrupo = idGrupo;
		this.nmProduto = nmProduto;
		this.dsProduto = dsProduto;
		this.tipoProduto = tipoProduto;
		this.status = status;
		this.dtCad = dtCad;
		this.dtMod = dtMod;
		this.usuario = usuario;
		this.cdBarra = cdBarra;
	}
	public Produtos(int idProduto, int idDivisao, int idSubGrupo, int idGrupo,
			String nmProduto, String dsProduto, String tipoProduto,
			String status, Date dtCad, Date dtMod, String usuario,
			String cdBarra, String cdNCM) {
		this.idProduto = idProduto;
		this.idDivisao = idDivisao;
		this.idSubGrupo = idSubGrupo;
		this.idGrupo = idGrupo;
		this.nmProduto = nmProduto;
		this.dsProduto = dsProduto;
		this.tipoProduto = tipoProduto;
		this.status = status;
		this.dtCad = dtCad;
		this.dtMod = dtMod;
		this.usuario = usuario;
		this.cdBarra = cdBarra;
		this.cdNcm = cdNCM;
	}
	public int getIdProduto() {
		return idProduto;
	}
	public void setIdProduto(int idProduto) {
		this.idProduto = idProduto;
	}
	public int getIdDivisao() {
		return idDivisao;
	}
	public void setIdDivisao(int idDivisao) {
		this.idDivisao = idDivisao;
	}
	public int getIdSubGrupo() {
		return idSubGrupo;
	}
	public void setIdSubGrupo(int idSubGrupo) {
		this.idSubGrupo = idSubGrupo;
	}
	public int getIdGrupo() {
		return idGrupo;
	}
	public void setIdGrupo(int idGrupo) {
		this.idGrupo = idGrupo;
	}
	public String getNmProduto() {
		return nmProduto;
	}
	public void setNmProduto(String nmProduto) {
		this.nmProduto = nmProduto;
	}
	public String getDsProduto() {
		return dsProduto;
	}
	public void setDsProduto(String dsProduto) {
		this.dsProduto = dsProduto;
	}
	public String getTipoProduto() {
		return tipoProduto;
	}
	public void setTipoProduto(String tipoProduto) {
		this.tipoProduto = tipoProduto;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Date getDtCad() {
		return dtCad;
	}
	public void setDtCad(Date dtCad) {
		this.dtCad = dtCad;
	}
	public Date getDtMod() {
		return dtMod;
	}
	public void setDtMod(Date dtMod) {
		this.dtMod = dtMod;
	}
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	public String getCdBarra() {
		return cdBarra;
	}
	public void setCdBarra(String cdBarra) {
		this.cdBarra = cdBarra;
	}
	public int getQuantFatias() {
		return quantFatias;
	}
	public void setQuantFatias(int quantFatias) {
		this.quantFatias = quantFatias;
	}
	public String getImpProducao() {
		return impProducao;
	}
	public void setImpProducao(String impProducao) {
		this.impProducao = impProducao;
	}
	public int getIdCatTributaria() {
		return idCatTributaria;
	}
	public void setIdCatTributaria(int idCatTributaria) {
		this.idCatTributaria = idCatTributaria;
	}
	public String getCdNcm() {
		return cdNcm;
	}
	public void setCdNcm(String cdNcm) {
		this.cdNcm = cdNcm;
	}
	public int getCdCfopSaidaDentro() {
		return cdCfopSaidaDentro;
	}
	public void setCdCfopSaidaDentro(int cdCfopSaidaDentro) {
		this.cdCfopSaidaDentro = cdCfopSaidaDentro;
	}
	public int getCdCfopSaidaFora() {
		return cdCfopSaidaFora;
	}
	public void setCdCfopSaidaFora(int cdCfopSaidaFora) {
		this.cdCfopSaidaFora = cdCfopSaidaFora;
	}
	public String getCdBarraTrib() {
		return cdBarraTrib;
	}
	public void setCdBarraTrib(String cdBarraTrib) {
		this.cdBarraTrib = cdBarraTrib;
	}
	public String getCdExTipi() {
		return cdExTipi;
	}
	public void setCdExTipi(String cdExTipi) {
		this.cdExTipi = cdExTipi;
	}
	public String getCdGenero() {
		return cdGenero;
	}
	public void setCdGenero(String cdGenero) {
		this.cdGenero = cdGenero;
	}
	public String getTipo() {
		return tipo;
	}
	public void setTipo(String tipo) {
		this.tipo = tipo;
	}
	public String getCoddBarras() {
		return coddBarras;
	}
	public void setCoddBarras(String coddBarras) {
		this.coddBarras = coddBarras;
	}
	public String getDescProduto() {
		return descProduto;
	}
	public void setDescProduto(String descProduto) {
		this.descProduto = descProduto;
	}
	public String getQtdEstoque() {
		return qtdEstoque;
	}
	public void setQtdEstoque(String qtdEstoque) {
		this.qtdEstoque = qtdEstoque;
	}
	public String getValorVarejo() {
		return valorVarejo;
	}
	public void setValorVarejo(String valorVarejo) {
		this.valorVarejo = valorVarejo;
	}
	public String getDescontoMax() {
		return descontoMax;
	}
	public void setDescontoMax(String descontoMax) {
		this.descontoMax = descontoMax;
	}
	public String getNaoUsado1() {
		return naoUsado1;
	}
	public void setNaoUsado1(String naoUsado1) {
		this.naoUsado1 = naoUsado1;
	}
	public String getCoddProduto() {
		return coddProduto;
	}
	public void setCoddProduto(String coddProduto) {
		this.coddProduto = coddProduto;
	}
	public String getUnidadeVenda() {
		return unidadeVenda;
	}
	public void setUnidadeVenda(String unidadeVenda) {
		this.unidadeVenda = unidadeVenda;
	}
	public String getCusto() {
		return custo;
	}
	public void setCusto(String custo) {
		this.custo = custo;
	}
	public String getCustoMedio() {
		return custoMedio;
	}
	public void setCustoMedio(String custoMedio) {
		this.custoMedio = custoMedio;
	}
	public String getMarkup() {
		return markup;
	}
	public void setMarkup(String markup) {
		this.markup = markup;
	}
	public String getNaoUsado2() {
		return naoUsado2;
	}
	public void setNaoUsado2(String naoUsado2) {
		this.naoUsado2 = naoUsado2;
	}
	public String getAliquotaICMS() {
		return aliquotaICMS;
	}
	public void setAliquotaICMS(String aliquotaICMS) {
		this.aliquotaICMS = aliquotaICMS;
	}
	public String getValorComissão() {
		return valorComissão;
	}
	public void setValorComissão(String valorComissão) {
		this.valorComissão = valorComissão;
	}
	public String getCSTOrigMercadoria() {
		return CSTOrigMercadoria;
	}
	public void setCSTOrigMercadoria(String cSTOrigMercadoria) {
		CSTOrigMercadoria = cSTOrigMercadoria;
	}
	public String getCSTTribICMS() {
		return CSTTribICMS;
	}
	public void setCSTTribICMS(String cSTTribICMS) {
		CSTTribICMS = cSTTribICMS;
	}
	public String getNaoUsado3() {
		return naoUsado3;
	}
	public void setNaoUsado3(String naoUsado3) {
		this.naoUsado3 = naoUsado3;
	}
	public String getNaoUsado4() {
		return naoUsado4;
	}
	public void setNaoUsado4(String naoUsado4) {
		this.naoUsado4 = naoUsado4;
	}
	public String getReducao() {
		return reducao;
	}
	public void setReducao(String reducao) {
		this.reducao = reducao;
	}
	public String getCodCSTPIS() {
		return codCSTPIS;
	}
	public void setCodCSTPIS(String codCSTPIS) {
		this.codCSTPIS = codCSTPIS;
	}
	public String getCodCSTCOFINS() {
		return codCSTCOFINS;
	}
	public void setCodCSTCOFINS(String codCSTCOFINS) {
		this.codCSTCOFINS = codCSTCOFINS;
	}
	public String getAlquotaPIS() {
		return alquotaPIS;
	}
	public void setAlquotaPIS(String alquotaPIS) {
		this.alquotaPIS = alquotaPIS;
	}
	public String getAliquotaCOFINS() {
		return aliquotaCOFINS;
	}
	public void setAliquotaCOFINS(String aliquotaCOFINS) {
		this.aliquotaCOFINS = aliquotaCOFINS;
	}
	public String getNaoUsado5() {
		return naoUsado5;
	}
	public void setNaoUsado5(String naoUsado5) {
		this.naoUsado5 = naoUsado5;
	}
	public String getNaoUsado6() {
		return naoUsado6;
	}
	public void setNaoUsado6(String naoUsado6) {
		this.naoUsado6 = naoUsado6;
	}
	public String getNaoUsado7() {
		return naoUsado7;
	}
	public void setNaoUsado7(String naoUsado7) {
		this.naoUsado7 = naoUsado7;
	}
	public String getNaoUsado8() {
		return naoUsado8;
	}
	public void setNaoUsado8(String naoUsado8) {
		this.naoUsado8 = naoUsado8;
	}
	public String getCodNCM() {
		return codNCM;
	}
	public void setCodNCM(String codNCM) {
		this.codNCM = codNCM;
	}
	public String getCFOPPFisica() {
		return CFOPPFisica;
	}
	public void setCFOPPFisica(String cFOPPFisica) {
		CFOPPFisica = cFOPPFisica;
	}
	public String getCFOPPJuridica() {
		return CFOPPJuridica;
	}
	public void setCFOPPJuridica(String cFOPPJuridica) {
		CFOPPJuridica = cFOPPJuridica;
	}
	public String getPercentualCargaTributária() {
		return percentualCargaTributária;
	}
	public void setPercentualCargaTributária(String percentualCargaTributária) {
		this.percentualCargaTributária = percentualCargaTributária;
	}
	public String getNaoUsado10() {
		return naoUsado10;
	}
	public void setNaoUsado10(String naoUsado10) {
		this.naoUsado10 = naoUsado10;
	}
	public String getNaoUsado11() {
		return naoUsado11;
	}
	public void setNaoUsado11(String naoUsado11) {
		this.naoUsado11 = naoUsado11;
	}
	public String getIdSecao() {
		return idSecao;
	}
	public void setIdSecao(String idSecao) {
		this.idSecao = idSecao;
	}
	public String getcProd() {
		return cProd;
	}
	public void setcProd(String cProd) {
		this.cProd = cProd;
	}
	public String getcEAN() {
		return cEAN;
	}
	public void setcEAN(String cEAN) {
		this.cEAN = cEAN;
	}
	public String getxProd() {
		return xProd;
	}
	public void setxProd(String xProd) {
		this.xProd = xProd;
	}
	public String getNCM() {
		return NCM;
	}
	public void setNCM(String nCM) {
		NCM = nCM;
	}
	public String getNVE() {
		return NVE;
	}
	public void setNVE(String nVE) {
		NVE = nVE;
	}
	public String getEXTIPI() {
		return EXTIPI;
	}
	public void setEXTIPI(String eXTIPI) {
		EXTIPI = eXTIPI;
	}
	public String getCFOP() {
		return CFOP;
	}
	public void setCFOP(String cFOP) {
		CFOP = cFOP;
	}
	public String getuCom() {
		return uCom;
	}
	public void setuCom(String uCom) {
		this.uCom = uCom;
	}
	public String getqCom() {
		return qCom;
	}
	public void setqCom(String qCom) {
		this.qCom = qCom;
	}
	public String getvUnCom() {
		return vUnCom;
	}
	public void setvUnCom(String vUnCom) {
		this.vUnCom = vUnCom;
	}
	public String getvProd() {
		return vProd;
	}
	public void setvProd(String vProd) {
		this.vProd = vProd;
	}
	public String getcEANTrib() {
		return cEANTrib;
	}
	public void setcEANTrib(String cEANTrib) {
		this.cEANTrib = cEANTrib;
	}
	public String getuTrib() {
		return uTrib;
	}
	public void setuTrib(String uTrib) {
		this.uTrib = uTrib;
	}
	public String getqTrib() {
		return qTrib;
	}
	public void setqTrib(String qTrib) {
		this.qTrib = qTrib;
	}
	public String getvUnTrib() {
		return vUnTrib;
	}
	public void setvUnTrib(String vUnTrib) {
		this.vUnTrib = vUnTrib;
	}
	public String getvFrete() {
		return vFrete;
	}
	public void setvFrete(String vFrete) {
		this.vFrete = vFrete;
	}
	public String getvSeg() {
		return vSeg;
	}
	public void setvSeg(String vSeg) {
		this.vSeg = vSeg;
	}
	public String getvDesc() {
		return vDesc;
	}
	public void setvDesc(String vDesc) {
		this.vDesc = vDesc;
	}
	public String getvOutro() {
		return vOutro;
	}
	public void setvOutro(String vOutro) {
		this.vOutro = vOutro;
	}
	public String getIndTot() {
		return indTot;
	}
	public void setIndTot(String indTot) {
		this.indTot = indTot;
	}
	
	

}
