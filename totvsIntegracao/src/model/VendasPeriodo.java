package model;

public class VendasPeriodo {
	
	private String filial = "";
	private double valorVendas = 0;
	
	
	
	public VendasPeriodo() {
		
	}
	
	public VendasPeriodo(String filial, double valorVendas) {
		
		this.filial = filial;
		this.valorVendas = valorVendas;
	}
	
	public String getFilial() {
		return filial;
	}
	
	public void setFilial(String filial) {
		this.filial = filial;
	}
	
	
	
	public double getValorVendas() {
		return valorVendas;
	}

	public void setValorVendas(float valorVendas) {
		this.valorVendas = valorVendas;
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
