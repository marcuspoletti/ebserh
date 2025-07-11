package afero.model;

import java.util.Date;


public class SaidasProdutos {
  
	private int idPedidoSaida = 0;
	private Date dtPed;
	private float quant = 0;
	private String operacao = "";
	private String status = "";
	public SaidasProdutos(int idPedidoSaida, Date dtPed, float quant,
			String operacao, String status) {
		this.idPedidoSaida = idPedidoSaida;
		this.dtPed = dtPed;
		this.quant = quant;
		this.operacao = operacao;
		this.status = status;
	}

	public SaidasProdutos() {
	}
	
	public int getIdPedidoSaida() {
		return idPedidoSaida;
	}
	public void setIdPedidoSaida(int idPedidoSaida) {
		this.idPedidoSaida = idPedidoSaida;
	}
	public Date getDtPed() {
		return dtPed;
	}
	public void setDtPed(Date dtPed) {
		this.dtPed = dtPed;
	}
	public float getQuant() {
		return quant;
	}
	public void setQuant(float quant) {
		this.quant = quant;
	}

	public String getOperacao() {
		return operacao;
	}

	public void setOperacao(String operacao) {
		this.operacao = operacao;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	
	
}
