package model;

public class MovimentacaoPDVTipo {
	
	private String filial ="";
	private double quantidadeVendida = 0;
	private String tipo="";
	
	
	
	public MovimentacaoPDVTipo() {
		
	}
	
	public MovimentacaoPDVTipo(String filial, double quantidadeVendida, String tipo) {
		super();
		this.filial = filial;
		this.quantidadeVendida = quantidadeVendida;
		this.tipo = tipo;
	}
	
	
	public String getFilial() {
		return this.filial;
	}
	public void setFilial(String filial) {
		this.filial = filial;
	}
	
	
	
	public double getQuantidadeVendida() {
		return quantidadeVendida;
	}
	public void setQuantidadeVendida(double quantidadeVendida) {
		this.quantidadeVendida = quantidadeVendida;
	}

	
	
	public String getTipo() {
		return tipo;
	}
	public void setTipo(String tipo) {
		this.tipo = tipo;
	}
	
	
	
	public String getLojaDesc(String filial){
		
		String lojaLocal = "SEM LOJA";
		
		if(filial.equalsIgnoreCase("01")){
			lojaLocal="JARDINS";			
		}
		if(filial.equalsIgnoreCase("02")){
			lojaLocal="RIOMAR";
		}
		if(filial.equalsIgnoreCase("06")){
			lojaLocal="JORGE AMADO";
		}
		if(filial.equalsIgnoreCase("07")){
			lojaLocal="JORNALEIRO";
		}
		if(filial.equalsIgnoreCase("08")){
			lojaLocal="BARRA";
		}
		if(filial.equalsIgnoreCase("04")){
			lojaLocal="CMO";
		}
		if(filial.equalsIgnoreCase("05")){
			lojaLocal="UNIT";
		}
		if(filial.equalsIgnoreCase("")){
			lojaLocal = "SEM LOJA";
		}
		if(filial.equalsIgnoreCase("null")){
			lojaLocal = "SEM LOJA";
		}
		return lojaLocal;
		
		
	}


}
