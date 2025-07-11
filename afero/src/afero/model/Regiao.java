package afero.model;

public class Regiao {

	private int cdRegiao;
	private String nmRegiao;
	private String status;

	public Regiao() {

	}
	public Regiao(int cdRegiao, String nmRegiao, String status) {
		this.cdRegiao = cdRegiao;
		this.nmRegiao = nmRegiao;
		this.status = status;
	}

	public final int getCdRegiao() {
		return cdRegiao;
	}
	
	public final void setCdRegiao(int cdRegiao) {
		this.cdRegiao = cdRegiao;
	}
	
	public final String getNmRegiao() {
		return nmRegiao;
	}
	
	public final void setNmRegiao(String nmRegiao) {
		this.nmRegiao = nmRegiao;
	}
	
	public final String getStatus() {
		return status;
	}
	
	public final void setStatus(String status) {
		this.status = status;
	}
		
}
