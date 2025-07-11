package afero.model;

public class Estado {

	private int cdEstado;
	private int cdRegiao;
	private String siglaEstado;
	private String ufEstado;
	private String status;

	public Estado() {

	}

	public Estado(int cdEstado, int cdRegiao, String siglaEstado,
			String ufEstado, String status) {
		this.cdEstado = cdEstado;
		this.cdRegiao = cdRegiao;
		this.siglaEstado = siglaEstado;
		this.ufEstado = ufEstado;
		this.status = status;
	}

	public final int getCdEstado() {
		return cdEstado;
	}

	public final void setCdEstado(int cdEstado) {
		this.cdEstado = cdEstado;
	}

	public final int getCdRegiao() {
		return cdRegiao;
	}

	public final void setCdRegiao(int cdRegiao) {
		this.cdRegiao = cdRegiao;
	}

	public final String getSiglaEstado() {
		return siglaEstado;
	}

	public final void setSiglaEstado(String siglaEstado) {
		this.siglaEstado = siglaEstado;
	}

	public final String getUfEstado() {
		return ufEstado;
	}

	public final void setUfEstado(String ufEstado) {
		this.ufEstado = ufEstado;
	}

	public final String getStatus() {
		return status;
	}

	public final void setStatus(String status) {
		this.status = status;
	}
	
}
