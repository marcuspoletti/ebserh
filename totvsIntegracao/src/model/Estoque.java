package model;

public class Estoque {
	
	private String loja="";
	private float saldo= 0;
	private String codProduto="";
	private String codBarras="";
	private String nomeProduto="";
	private String autor="";
	private String editora="";
	private Float preco;
	private String promo="";
	private String bloqueado="";

	
	public Estoque() {
		
	}
	
	public Estoque(String loja, float saldo, String codProduto, String codBarras, String nomeProduto, String autor,
			String editora, Float preco, String promo, String bloqueado) {
		super();
		this.loja = loja;
		this.saldo = saldo;
		this.codProduto = codProduto;
		this.codBarras = codBarras;
		this.nomeProduto = nomeProduto;
		this.autor = autor;
		this.editora = editora;
		this.preco = preco;
		this.promo = promo;
		this.bloqueado = bloqueado;
	}



	public float getSaldo() {
		return saldo;
	}	
	public void setSaldo(float saldo) {
		this.saldo = saldo;
	}



	public String getLoja() {
		return this.loja;
	}
	public void setLoja(String loja) {
		this.loja = loja;
	}
	
	
	
	public String getCodProduto() {
		return codProduto;
	}
	public void setCodProduto(String codProduto) {
		this.codProduto = codProduto;
	}
	public String getCodBarras() {
		return codBarras;
	}
	public void setCodBarras(String codBarras) {
		this.codBarras = codBarras;
	}
	public String getNomeProduto() {
		return nomeProduto;
	}
	public void setNomeProduto(String nomeProduto) {
		this.nomeProduto = nomeProduto;
	}
	public String getAutor() {
		return autor;
	}
	public void setAutor(String autor) {
		this.autor = autor;
	}
	public String getEditora() {
		return editora;
	}
	public void setEditora(String editora) {
		this.editora = editora;
	}
	public Float getPreco() {
		return preco;
	}
	public void setPreco(Float preco) {
		this.preco = preco;
	}
	public String getPromo() {
		return promo;
	}
	public void setPromo(String promo) {
		this.promo = promo;
	}
	public String getBloqueado() {
		return bloqueado;
	}
	public void setBloqueado(String bloqueado) {
		this.bloqueado = bloqueado;
	}
	
	
	public String getLojaDesc(String loja){
		
		String lojaLocal = "SEM LOJA";
		
		if(loja.equalsIgnoreCase("01")){
			lojaLocal="JARDINS";
			
		}
		if(loja.equalsIgnoreCase("02")){
			lojaLocal="RIOMAR";
		}
		if(loja.equalsIgnoreCase("06")){
			lojaLocal="JORGE AMADO";
		}
		if(loja.equalsIgnoreCase("07")){
			lojaLocal="JORNALEIRO";
		}
		if(loja.equalsIgnoreCase("08")){
			lojaLocal="BARRA";
		}
		if(loja.equalsIgnoreCase("04")){
			lojaLocal="CMO";
		}
		if(loja.equalsIgnoreCase("05")){
			lojaLocal="UNIT";
		}
		if(loja.equalsIgnoreCase("")){
			lojaLocal = "SEM LOJA";
		}
		if(loja.equalsIgnoreCase("null")){
			lojaLocal = "SEM LOJA";
		}
		return lojaLocal;
		
		
	}

}
