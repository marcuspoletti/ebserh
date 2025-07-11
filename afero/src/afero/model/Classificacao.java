package afero.model;

public class Classificacao {

	private int cdEntidade;
	private int idTipoEntidade;
	
	public Classificacao(int cdEntidade, int idTipoEntidade) {
		this.cdEntidade = cdEntidade;
		this.idTipoEntidade = idTipoEntidade;
	}

	public final int getCdEntidade() {
		return cdEntidade;
	}

	public final void setCdEntidade(int cdEntidade) {
		this.cdEntidade = cdEntidade;
	}
	
	public final int getIdTipoEntidade() {
		return idTipoEntidade;
	}

	public final void setIdTipoEntidade(int idTipoEntidade) {
		this.idTipoEntidade = idTipoEntidade;
	}

}
