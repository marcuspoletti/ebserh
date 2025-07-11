package afero.model;

public class TipoConta {
	
	private int idTipoConta = 0;
	private String dsTipoConta = "";
	private String status = "";
	
	public TipoConta(int idTipoConta, String dsTipoConta, String status){
		this.idTipoConta = idTipoConta;
		this.dsTipoConta = dsTipoConta;
		this.status = status;
	}

	public TipoConta(){}

	public int getIdTipoConta() {
		return idTipoConta;
	}

	public void setIdTipoConta(int idTipoConta) {
		this.idTipoConta = idTipoConta;
	}

	public String getDsTipoConta() {
		return dsTipoConta;
	}

	public void setDsTipoConta(String dsTipoConta) {
		this.dsTipoConta = dsTipoConta;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
}
