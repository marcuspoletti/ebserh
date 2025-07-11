package afero.model;

public class Banco {
	
	private int idBanco = 0;
	private String nmBanco = "";
	private String nrBanco = "";
	private String status = "";
	
	
	public Banco(int idBanco, String nmBanco, String nrBanco, String status){
		this.idBanco = idBanco;
		this.nmBanco = nmBanco;
		this.nrBanco = nrBanco;
		this.status = status;
	}

	public Banco(){}

	public int getIdBanco() {
		return idBanco;
	}

	public void setIdBanco(int idBanco) {
		this.idBanco = idBanco;
	}

	public String getNmBanco() {
		return nmBanco;
	}

	public void setNmBanco(String nmBanco) {
		this.nmBanco = nmBanco;
	}

	public String getNrBanco() {
		return nrBanco;
	}

	public void setNrBanco(String nrBanco) {
		this.nrBanco = nrBanco;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
}
