package afero.model;

public class TipoEntidade {
	
	private int idTipoEntidade;
	private String dsTipoEntidade;
	private String status;
	
	public TipoEntidade() {
		
	}
	
	public TipoEntidade(int idTipoEntidade, String dsTipoEntidade, String status) {
		this.idTipoEntidade = idTipoEntidade;
		this.dsTipoEntidade = dsTipoEntidade;
		this.status = status;
		
	}

	public final int getIdTipoEntidade() {
		return idTipoEntidade;
	}

	public final void setIdTipoEntidade(int idTipoEntidade) {
		this.idTipoEntidade = idTipoEntidade;
	}

	public final String getDsTipoEntidade() {
		return dsTipoEntidade;
	}

	public final void setDsTipoEntidade(String dsTipoEntidade) {
		this.dsTipoEntidade = dsTipoEntidade;
	}

	public final String getStatus() {
		return status;
	}

	public final void setStatus(String status) {
		this.status = status;
	}
	
}
