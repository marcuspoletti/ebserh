package model;

public class ComboTipoProduto {
	
	
	private String tipoProduto="";
	private String codTipoProduto="";
	
	
	
	public ComboTipoProduto() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ComboTipoProduto(String tipoProduto, String codTipoProduto) {
		
		this.tipoProduto = tipoProduto;
		this.codTipoProduto = codTipoProduto;
	}
	
	public String getTipoProduto() {
		return tipoProduto;
	}
	
	public void setTipoProduto(String tipoProduto) {
		this.tipoProduto = tipoProduto;
	}
	
	public String getCodTipoProduto() {
		return codTipoProduto;
	}
	
	public void setCodTipoProduto(String codTipoProduto) {
		this.codTipoProduto = codTipoProduto;
	}
	
	

}
