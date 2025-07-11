package afero.model;

import java.util.Date;

public class CotacaoItem {
	
	private int idCotacaoItem;
	private int idCotacao;
	private int idProduto;
	private int idUnidade;
	private float quant;
	private Date dtMod;
	private String usuario;
	
	
	
	public CotacaoItem(){}
	
	public CotacaoItem(int idCotacaoItem, int idCotacao, int idProduto,
			int idUnidade, float quant, Date dtMod, String usuario) {
	
		this.idCotacaoItem = idCotacaoItem;
		this.idCotacao = idCotacao;
		this.idProduto = idProduto;
		this.idUnidade = idUnidade;
		this.quant = quant;
		this.dtMod = dtMod;
		this.usuario = usuario;
	}

	public int getIdCotacaoItem() {
		return idCotacaoItem;
	}
	
	public void setIdCotacaoItem(int idCotacaoItem) {
		this.idCotacaoItem = idCotacaoItem;
	}
	
	public int getIdCotacao() {
		return idCotacao;
	}
	
	public void setIdCotacao(int idCotacao) {
		this.idCotacao = idCotacao;
	}
	
	public int getIdProduto() {
		return idProduto;
	}
	
	public void setIdProduto(int idProduto) {
		this.idProduto = idProduto;
	}
	
	public int getIdUnidade() {
		return idUnidade;
	}
	
	public void setIdUnidade(int idUnidade) {
		this.idUnidade = idUnidade;
	}
	
	public float getQuant() {
		return quant;
	}
	
	public void setQuant(float quant) {
		this.quant = quant;
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

}
