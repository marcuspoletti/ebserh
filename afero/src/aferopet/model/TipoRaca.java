package aferopet.model;

public class TipoRaca {

	private int idTipoRaca;
	private String dsTipoRaca;
	private String status;
	
	public TipoRaca() {
	}

	public TipoRaca(int idTipoRaca, String dsTipoRaca, String status) {
		super();
		this.idTipoRaca = idTipoRaca;
		this.dsTipoRaca = dsTipoRaca;
		this.status = status;
	}

	public int getIdTipoRaca() {
		return idTipoRaca;
	}

	public void setIdTipoRaca(int idTipoRaca) {
		this.idTipoRaca = idTipoRaca;
	}

	public String getDsTipoRaca() {
		return dsTipoRaca;
	}

	public void setDsTipoRaca(String dsTipoRaca) {
		this.dsTipoRaca = dsTipoRaca;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
}
