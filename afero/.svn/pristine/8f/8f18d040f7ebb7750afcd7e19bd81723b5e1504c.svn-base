package afero.model;

import java.util.Date;

public class OrcamentoItem {

	private int idOrcamentoItem;
	private int idOrcamento;
	private int idProduto;
	private int idUnidade;
	private float quant;
	private float valor;
	private String aprovado;
	private float valorAprov;
	private Date dtMod;
	private String usuario;
	private float pDesc;
	private float vlUni;

	public OrcamentoItem(int idOrcamentoItem, int idOrcamento, int idProduto,
			int idUnidade, float quant, float valor, String aprovado,
			float valorAprov, Date dtMod, String usuario, float pDesc,
			float vlUni) {
		this.idOrcamentoItem = idOrcamentoItem;
		this.idOrcamento = idOrcamento;
		this.idProduto = idProduto;
		this.idUnidade = idUnidade;
		this.quant = quant;
		this.valor = valor;
		this.aprovado = aprovado;
		this.valorAprov = valorAprov;
		this.dtMod = dtMod;
		this.usuario = usuario;
		this.pDesc = pDesc;
		this.vlUni = vlUni;
	}

	public OrcamentoItem() {
	}

	public int getIdOrcamentoItem() {
		return idOrcamentoItem;
	}

	public void setIdOrcamentoItem(int idOrcamentoItem) {
		this.idOrcamentoItem = idOrcamentoItem;
	}

	public int getIdOrcamento() {
		return idOrcamento;
	}

	public void setIdOrcamento(int idOrcamento) {
		this.idOrcamento = idOrcamento;
	}

	public int getIdProduto() {
		return idProduto;
	}

	public void setIdProduto(int idProduto) {
		this.idProduto = idProduto;
	}

	public float getQuant() {
		return quant;
	}

	public void setQuant(float quant) {
		this.quant = quant;
	}

	public float getValor() {
		return valor;
	}

	public void setValor(float valor) {
		this.valor = valor;
	}

	public String getAprovado() {
		return aprovado;
	}

	public void setAprovado(String aprovado) {
		this.aprovado = aprovado;
	}

	public float getValorAprov() {
		return valorAprov;
	}

	public void setValorAprov(float valorAprov) {
		this.valorAprov = valorAprov;
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

	public int getIdUnidade() {
		return idUnidade;
	}

	public void setIdUnidade(int idUnidade) {
		this.idUnidade = idUnidade;
	}

	public final float getPDesc() {
		return pDesc;
	}

	public final void setPDesc(float desc) {
		pDesc = desc;
	}

	public final float getVlUni() {
		return vlUni;
	}

	public final void setVlUni(float vlUni) {
		this.vlUni = vlUni;
	}

	public final float getVDesc() {
		double d = valor*pDesc;
		return (float) (Math.round(d)/100.0); 
	}
	
	public final float getVlTot() {
		return quant*vlUni; 
	}
	
}
