package afero.model;

public class MaiorVenda {
	
	private int idProduto = 0;
	private String nmProduto = "";
	private float quant = 0;
	private float preco = 0;
	
	public MaiorVenda(){}
	
	public MaiorVenda(int idProduto, String nmProduto, float quant, float preco) {
		this.idProduto = idProduto;
		this.nmProduto = nmProduto;
		this.quant = quant;
		this.preco = preco;
	}
	
	
	
	public float getPreco() {
		return preco;
	}

	public void setPreco(float preco) {
		this.preco = preco;
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
