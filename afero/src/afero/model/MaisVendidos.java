package afero.model;

public class MaisVendidos {
	
	private int idProduto = 0;
	private String nmProduto = "";
	private float quant = 0;
	
	public MaisVendidos(){}
	
	public MaisVendidos(int idProduto, String nmProduto, float quant) {
		this.idProduto = idProduto;
		this.nmProduto = nmProduto;
		this.quant = quant;
	}
	
	public int getIdProduto() {
		return idProduto;
	}
	
	public void setIdProduto(int idProduto) {
		this.idProduto = idProduto;
	}
	
	public String getNmProduto() {
		return nmProduto;
	}
	
	public void setNmProduto(String nmProduto) {
		this.nmProduto = nmProduto;
	}
	
	public float getQuant() {
		return quant;
	}
	
	public void setQuant(float quant) {
		this.quant = quant;
	}

}
