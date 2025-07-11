package afero.model;

public class ProdutoEstoquePreco {
	
	private int idEstoque;
	private int idProduto;
	private int idPreco;
	private int idLoja;
	
	public ProdutoEstoquePreco(){}
	public ProdutoEstoquePreco(int idEstoque, int idProduto, int idPreco,
			int idLoja) {
	
		this.idEstoque = idEstoque;
		this.idProduto = idProduto;
		this.idPreco = idPreco;
		this.idLoja = idLoja;
	}
	public int getIdEstoque() {
		return idEstoque;
	}
	public void setIdEstoque(int idEstoque) {
		this.idEstoque = idEstoque;
	}
	public int getIdProduto() {
		return idProduto;
	}
	public void setIdProduto(int idProduto) {
		this.idProduto = idProduto;
	}
	public int getIdPreco() {
		return idPreco;
	}
	public void setIdPreco(int idPreco) {
		this.idPreco = idPreco;
	}
	public int getIdLoja() {
		return idLoja;
	}
	public void setIdLoja(int idLoja) {
		this.idLoja = idLoja;
	}

}
