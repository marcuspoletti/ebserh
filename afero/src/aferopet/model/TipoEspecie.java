package aferopet.model;

public class TipoEspecie {

	public int cdTipoEspecie;
	public String dsTipoEspecie;
	public String Status;
	
	public TipoEspecie() {
	}

	public TipoEspecie(int cdTipoEspecie, String dsTipoEspecie, String status) {
		super();
		this.cdTipoEspecie = cdTipoEspecie;
		this.dsTipoEspecie = dsTipoEspecie;
		Status = status;
	}

	public int getCdTipoEspecie() {
		return cdTipoEspecie;
	}

	public void setCdTipoEspecie(int cdTipoEspecie) {
		this.cdTipoEspecie = cdTipoEspecie;
	}

	public String getDsTipoEspecie() {
		return dsTipoEspecie;
	}

	public void setDsTipoEspecie(String dsTipoEspecie) {
		this.dsTipoEspecie = dsTipoEspecie;
	}

	public String getStatus() {
		return Status;
	}

	public void setStatus(String status) {
		Status = status;
	}
	
}
