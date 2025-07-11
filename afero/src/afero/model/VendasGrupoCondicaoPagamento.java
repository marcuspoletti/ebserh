package afero.model;

public class VendasGrupoCondicaoPagamento {
	
	private int cdCondicaoPagamento = 0;
	private String dsCondicaoPagamento = "";
	private double valorCondicaoPagamento = 0;
	
	
	
	public VendasGrupoCondicaoPagamento(int cdCondicaoPagamento,
			String dsCondicaoPagamento, double valorCondicaoPagamento) {
		
		this.cdCondicaoPagamento = cdCondicaoPagamento;
		this.dsCondicaoPagamento = dsCondicaoPagamento;
		this.valorCondicaoPagamento = valorCondicaoPagamento;
	}



	public VendasGrupoCondicaoPagamento() {
		
		// TODO Auto-generated constructor stub
	}



	public int getCdCondicaoPagamento() {
		return cdCondicaoPagamento;
	}



	public void setCdCondicaoPagamento(int cdCondicaoPagamento) {
		this.cdCondicaoPagamento = cdCondicaoPagamento;
	}



	public String getDsCondicaoPagamento() {
		return dsCondicaoPagamento;
	}



	public void setDsCondicaoPagamento(String dsCondicaoPagamento) {
		this.dsCondicaoPagamento = dsCondicaoPagamento;
	}



	public double getValorCondicaoPagamento() {
		return valorCondicaoPagamento;
	}



	public void setValorCondicaoPagamento(double valorCondicaoPagamento) {
		this.valorCondicaoPagamento = valorCondicaoPagamento;
	}
	
	
	

}
