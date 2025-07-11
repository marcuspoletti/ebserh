package afero.model;

import java.util.Date;

public class SaidaProduto {
	
	private String cdProduto;
	private String dsProduto;
	private String numPedido;
	private Date dtPed;
	private float quant;
	private float prUnit;
	private float custo;
	
	
	
	public SaidaProduto(String cdProduto, String dsProduto, String numPedido,
			Date dtPed, float quant, float prUnit, float custo) {
	
		this.cdProduto = cdProduto;
		this.dsProduto = dsProduto;
		this.numPedido = numPedido;
		this.dtPed = dtPed;
		this.quant = quant;
		this.prUnit = prUnit;
		this.custo = custo;
	}
	public SaidaProduto(String cdProduto, String numPedido, Date dtPed,
			float quant, float prUnit, float custo) {
		
		this.cdProduto = cdProduto;
		this.numPedido = numPedido;
		this.dtPed = dtPed;
		this.quant = quant;
		this.prUnit = prUnit;
		this.custo = custo;
	}
	public SaidaProduto() {
		
		// TODO Auto-generated constructor stub
	}
	
	
	public String getDsProduto() {
		return dsProduto;
	}
	public void setDsProduto(String dsProduto) {
		this.dsProduto = dsProduto;
	}
	public String getCdProduto() {
		return cdProduto;
	}
	public void setCdProduto(String cdProduto) {
		this.cdProduto = cdProduto;
	}
	public String getNumPedido() {
		return numPedido;
	}
	public void setNumPedido(String numPedido) {
		this.numPedido = numPedido;
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
	public float getPrUnit() {
		return prUnit;
	}
	public void setPrUnit(float prUnit) {
		this.prUnit = prUnit;
	}
	public float getCusto() {
		return this.quant * this.prUnit;
	}
	public void setCusto(float custo) {
		this.custo = custo;
	}
	
	

}
