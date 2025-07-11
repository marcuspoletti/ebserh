package afero.model;

public class AreaAtuacao {

	private int cdEntidade;
	private int idRamoAtividade;

	public AreaAtuacao(int cdEntidade, int idRamoAtividade) {
		this.cdEntidade = cdEntidade;
		this.idRamoAtividade = idRamoAtividade;
	}

	public final int getCdEntidade() {
		return cdEntidade;
	}

	public final void setCdEntidade(int cdEntidade) {
		this.cdEntidade = cdEntidade;
	}
	public final int getIdRamoAtividade() {
		return idRamoAtividade;
	}

	public final void setIdRamoAtividade(int idRamoAtividade) {
		this.idRamoAtividade = idRamoAtividade;
	}
		
}
