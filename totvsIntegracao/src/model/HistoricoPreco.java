package model;

public class HistoricoPreco {
	
	private String produto="";
	private double precoAtual= 0;
	private double ultimoPrecoVendido= 0;
	private String dataUltimoPrecoVendido="";
	private double penultimoPreçoVendido= 0;
	private String dataPenultimoPreçoVendido="";

	
	public HistoricoPreco() {
		
	}
	
	

	public HistoricoPreco(String produto, double precoAtual, double ultimoPrecoVendido, String dataUltimoPrecoVendido, double penultimoPreçoVendido, String dataPenultimoPreçoVendido){
		super();
		this.produto = produto;
		this.precoAtual = precoAtual;
		this.ultimoPrecoVendido = ultimoPrecoVendido;
		this.dataUltimoPrecoVendido = dataUltimoPrecoVendido;
		this.penultimoPreçoVendido = penultimoPreçoVendido;
		this.dataPenultimoPreçoVendido = dataPenultimoPreçoVendido;

	}
	
	public String getProduto() {
		return produto;
	}

	public void setProduto(String produto) {
		this.produto = produto;
	}
	

	
	public double getPrecoAtual() {
		return precoAtual;
	}

	public void setPrecoAtual(float precoAtual) {
		this.precoAtual = precoAtual;
	}
	
	
	
	public double getUltimoPrecoVendido() {
		return ultimoPrecoVendido;
	}

	public void setUltimoPrecoVendido(float ultimoPrecoVendido) {
		this.ultimoPrecoVendido = ultimoPrecoVendido;
	}
	
	
	
	public String getDataUltimoPrecoVendido() {
		return dataUltimoPrecoVendido;
	}

	public void setDataUltimoPrecoVendido(String dataUltimoPrecoVendido) {
		this.dataUltimoPrecoVendido = dataUltimoPrecoVendido;
	}

	

	public double getPenultimoPreçoVendido() {
		return penultimoPreçoVendido;
	}

	public void setPenultimoPreçoVendido(float penultimoPreçoVendido) {
		this.penultimoPreçoVendido = penultimoPreçoVendido;
	}
	
	
	
	public String getDataPenultimoPreçoVendido() {
		return dataPenultimoPreçoVendido;
	}

	public void setDataPenultimoPreçoVendido(String dataPenultimoPreçoVendido) {
		this.dataPenultimoPreçoVendido = dataPenultimoPreçoVendido;
	}


}
