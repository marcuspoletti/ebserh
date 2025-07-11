package aferopet.model;

public class GrupoMedicamento {
	
	private int idGrupoMedicamento;
	private String dsGrupoMedicamento;
	private String status;
	private int idDivisao;
	private int idSubGrupo;
	private int idGrupo;
	
	public GrupoMedicamento(){
	}

	public GrupoMedicamento(int idGrupoMedicamento, String dsGrupoMedicamento,
			String status, int idDivisao, int idSubGrupo, int idGrupo) {
		
		this.idGrupoMedicamento = idGrupoMedicamento;
		this.dsGrupoMedicamento = dsGrupoMedicamento;
		this.status = status;
		this.idDivisao = idDivisao;
		this.idSubGrupo = idSubGrupo;
		this.idGrupo = idGrupo;
	}

	public int getIdDivisao() {
		return idDivisao;
	}

	public void setIdDivisao(int idDivisao) {
		this.idDivisao = idDivisao;
	}

	public int getIdSubGrupo() {
		return idSubGrupo;
	}

	public void setIdSubGrupo(int idSubGrupo) {
		this.idSubGrupo = idSubGrupo;
	}

	public int getIdGrupo() {
		return idGrupo;
	}

	public void setIdGrupo(int idGrupo) {
		this.idGrupo = idGrupo;
	}

	public int getIdGrupoMedicamento() {
		return idGrupoMedicamento;
	}

	public void setIdGrupoMedicamento(int idGrupoMedicamento) {
		this.idGrupoMedicamento = idGrupoMedicamento;
	}

	public String getDsGrupoMedicamento() {
		return dsGrupoMedicamento;
	}

	public void setDsGrupoMedicamento(String dsGrupoMedicamento) {
		this.dsGrupoMedicamento = dsGrupoMedicamento;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

}
