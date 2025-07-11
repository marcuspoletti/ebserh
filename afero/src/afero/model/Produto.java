package afero.model;

import java.util.Date;

public class Produto {
	
	
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
	private String cdCest = "";
	private int cdCfopSaidaDentro = 0;
	private int cdCfopSaidaFora = 0;
	private String cdBarraTrib = "";
	private String cdExTipi = "";
	private String cdGenero = "";


	public Produto(int idProduto, int idDivisao, int idSubGrupo, int idGrupo,
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
	
	

	public Produto(int idProduto, int idDivisao, int idSubGrupo, int idGrupo,
			String nmProduto, String dsProduto, String tipoProduto,
			String status, Date dtCad, Date dtMod, String usuario,
			String cdBarra, int quantFatias, String impProducao) {
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
		this.quantFatias = quantFatias;
		this.impProducao = impProducao;
	}



	public Produto(int idProduto, int idDivisao, int idSubGrupo, int idGrupo,
			String nmProduto, String dsProduto, String tipoProduto,
			String status, Date dtCad, Date dtMod, String usuario,
			String cdBarra, int quantFatias, String impProducao,
			int idCatTributaria, String cdNcm) {
		
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
		this.quantFatias = quantFatias;
		this.impProducao = impProducao;
		this.idCatTributaria = idCatTributaria;
		this.cdNcm = cdNcm;
	}



	public Produto(){}
	
	
	
	
	public Produto(int idProduto, int idDivisao, int idSubGrupo, int idGrupo,
			String nmProduto, String dsProduto, String tipoProduto,
			String status, Date dtCad, Date dtMod, String usuario,
			String cdBarra, int quantFatias, String impProducao,
			int idCatTributaria, String cdNcm, int cdCfopSaidaDentro,
			int cdCfopSaidaFora) {
		
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
		this.quantFatias = quantFatias;
		this.impProducao = impProducao;
		this.idCatTributaria = idCatTributaria;
		this.cdNcm = cdNcm;
		this.cdCfopSaidaDentro = cdCfopSaidaDentro;
		this.cdCfopSaidaFora = cdCfopSaidaFora;
	}



	public Produto(int idProduto, int idDivisao, int idSubGrupo, int idGrupo,
			String nmProduto, String dsProduto, String tipoProduto,
			String status, Date dtCad, Date dtMod, String usuario,
			String cdBarra, int quantFatias, String impProducao,
			int idCatTributaria, String cdNcm, int cdCfopSaidaDentro,
			int cdCfopSaidaFora, String cdBarraTrib, String cdExTipi,
			String cdGenero) {
		
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
		this.quantFatias = quantFatias;
		this.impProducao = impProducao;
		this.idCatTributaria = idCatTributaria;
		this.cdNcm = cdNcm;
		this.cdCfopSaidaDentro = cdCfopSaidaDentro;
		this.cdCfopSaidaFora = cdCfopSaidaFora;
		this.cdBarraTrib = cdBarraTrib;
		this.cdExTipi = cdExTipi;
		this.cdGenero = cdGenero;
	}
	public Produto(int idProduto, int idDivisao, int idSubGrupo, int idGrupo,
			String nmProduto, String dsProduto, String tipoProduto,
			String status, Date dtCad, Date dtMod, String usuario,
			String cdBarra, int quantFatias, String impProducao,
			int idCatTributaria, String cdNcm, int cdCfopSaidaDentro,
			int cdCfopSaidaFora, String cdBarraTrib, String cdExTipi,
			String cdGenero, String cdCest) {
		
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
		this.quantFatias = quantFatias;
		this.impProducao = impProducao;
		this.idCatTributaria = idCatTributaria;
		this.cdNcm = cdNcm;
		this.cdCfopSaidaDentro = cdCfopSaidaDentro;
		this.cdCfopSaidaFora = cdCfopSaidaFora;
		this.cdBarraTrib = cdBarraTrib;
		this.cdExTipi = cdExTipi;
		this.cdGenero = cdGenero;
		this.cdCest = cdCest;
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



	public String getCdCest() {
		return cdCest;
	}



	public void setCdCest(String cdCest) {
		this.cdCest = cdCest;
	}
	
	

}
