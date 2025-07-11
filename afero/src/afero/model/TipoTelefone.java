package afero.model;

public class TipoTelefone {

	private int cdTipoTelefone;
	private String dsTipoTelefone;
	private String status;
	
	public TipoTelefone() {

	}

	public TipoTelefone(int cdTipoTelefone, String dsTipoTelefone, String status) {
		this.cdTipoTelefone = cdTipoTelefone;
		this.dsTipoTelefone = dsTipoTelefone;
		this.status = status;
	}

	public final int getCdTipoTelefone() {
		return cdTipoTelefone;
	}

	public final void setCdTipoTelefone(int cdTipoTelefone) {
		this.cdTipoTelefone = cdTipoTelefone;
	}

	public final String getDsTipoTelefone() {
		return dsTipoTelefone;
	}

	public final void setDsTipoTelefone(String dsTipoTelefone) {
		this.dsTipoTelefone = dsTipoTelefone;
	}

	public final String getStatus() {
		return status;
	}

	public final void setStatus(String status) {
		this.status = status;
	}
	
}
