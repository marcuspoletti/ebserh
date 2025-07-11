package afero.model;

import java.util.Date;

public class Estoque {
	
	private int idEstoque;
	private int idLoja;
	private int idProduto;
	private double qtEstoque;
	private double qtMinimo;
	private double qtMaximo;
	private String status;
	private Date qtMod;
	private String usuario;
	
	
	
	public Estoque(){};
	
	public Estoque(int idEstoque, int idLoja, int idProduto, double qtEstoque,
			double qtMinimo, double qtMaximo, String status, Date qtMod, String usuario) {
		this.idEstoque = idEstoque;
		this.idLoja = idLoja;
		this.idProduto = idProduto;
		this.qtEstoque = qtEstoque;
		this.qtMinimo = qtMinimo;
		this.qtMaximo = qtMaximo;
		this.status = status;
		this.qtMod = qtMod;
		this.usuario = usuario;
	}

	public int getIdEstoque() {
		return idEstoque;
	}

	public void setIdEstoque(int idEstoque) {
		this.idEstoque = idEstoque;
	}

	public int getIdLoja() {
		return idLoja;
	}

	public void setIdLoja(int idLoja) {
		this.idLoja = idLoja;
	}

	public int getIdProduto() {
		return idProduto;
	}

	public void setIdProduto(int idProduto) {
		this.idProduto = idProduto;
	}

	public double getQtEstoque() {
		return qtEstoque;
	}

	public void setQtEstoque(double qtEstoque) {
		this.qtEstoque = qtEstoque;
	}

	public double getQtMinimo() {
		return qtMinimo;
	}

	public void setQtMinimo(double qtMinimo) {
		this.qtMinimo = qtMinimo;
	}

	public double getQtMaximo() {
		return qtMaximo;
	}

	public void setQtMaximo(double qtMaximo) {
		this.qtMaximo = qtMaximo;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getQtMod() {
		return qtMod;
	}

	public void setQtMod(Date qtMod) {
		this.qtMod = qtMod;
	}

	public String getUsuario() {
		return usuario;
	}

	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	
	public void estoqueCompra(double quantAtual, double quantAtualizar){
		if(quantAtual > 0){
			this.qtEstoque = quantAtual + quantAtualizar;
		}else{
			this.qtEstoque = quantAtual + quantAtualizar;
		}
		
	}
	public void estoqueSaida(double quantAtual, double quantAtualizar){
		if(quantAtual > 0){
			this.qtEstoque = (quantAtual) - (quantAtualizar);
		}else{
			this.qtEstoque = (quantAtual) - (quantAtualizar);
		}
		
	}

}
