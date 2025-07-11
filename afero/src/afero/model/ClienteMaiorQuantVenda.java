package afero.model;

import java.util.Date;

public class ClienteMaiorQuantVenda {
	
	private int codClient=0;
	private String nomeCliente = "";
	private int quantPedido = 0;
	private double vlPed = 0;
	private Date dataCadastro = null;
	private Date ultimoPedido = null;
	private double totalPed = 0;
	
	
	
	public ClienteMaiorQuantVenda(int codClient, String nomeCliente,
			int quantPedido, double vlPed, Date dataCadastro,
			Date ultimoPedido, double totalPed) {
		
		this.codClient = codClient;
		this.nomeCliente = nomeCliente;
		this.quantPedido = quantPedido;
		this.vlPed = vlPed;
		this.dataCadastro = dataCadastro;
		this.ultimoPedido = ultimoPedido;
		this.totalPed = totalPed;
	}



	public ClienteMaiorQuantVenda(int codClient, String nomeCliente,
			int quantPedido, double vlPed, Date dataCadastro, Date ultimoPedido) {
		
		this.codClient = codClient;
		this.nomeCliente = nomeCliente;
		this.quantPedido = quantPedido;
		this.vlPed = vlPed;
		this.dataCadastro = dataCadastro;
		this.ultimoPedido = ultimoPedido;
	}



	public double getTotalPed() {
		return totalPed;
	}



	public void setTotalPed(double totalPed) {
		this.totalPed = totalPed;
	}



	public Date getUltimoPedido() {
		return ultimoPedido;
	}



	public void setUltimoPedido(Date ultimoPedido) {
		this.ultimoPedido = ultimoPedido;
	}



	public Date getDataCadastro() {
		return dataCadastro;
	}



	public void setDataCadastro(Date dataCadastro) {
		this.dataCadastro = dataCadastro;
	}



	public ClienteMaiorQuantVenda() {
		
	}



	public int getCodClient() {
		return codClient;
	}



	public void setCodClient(int codClient) {
		this.codClient = codClient;
	}



	public String getNomeCliente() {
		return nomeCliente;
	}



	public void setNomeCliente(String nomeCliente) {
		this.nomeCliente = nomeCliente;
	}



	public int getQuantPedido() {
		return quantPedido;
	}



	public void setQuantPedido(int quantPedido) {
		this.quantPedido = quantPedido;
	}



	public double getVlPed() {
		return vlPed;
	}



	public void setVlPed(double vlPed) {
		this.vlPed = vlPed;
	}
	
	

}
