package afero.model;

public class CentroCusto {
	
	private int idCentroCusto = 0;
	private int idCentroCustoPai = 0;
	private String cdCentroCusto = "";
	private String nmCentroCusto = "";
	private String pessoaResponsavel = "";
	private String nroTelefone = "";
	private String status = "";
	
	
	
	public CentroCusto() {
		
		// TODO Auto-generated constructor stub
	}
	public CentroCusto(int idCentroCusto, int idCentroCustoPai,
			String cdCentroCusto, String nmCentroCusto,
			String pessoaResponsavel, String nroTelefone, String status) {
		this.idCentroCusto = idCentroCusto;
		this.idCentroCustoPai = idCentroCustoPai;
		this.cdCentroCusto = cdCentroCusto;
		this.nmCentroCusto = nmCentroCusto;
		this.pessoaResponsavel = pessoaResponsavel;
		this.nroTelefone = nroTelefone;
		this.status = status;
	}
	public int getIdCentroCusto() {
		return idCentroCusto;
	}
	public void setIdCentroCusto(int idCentroCusto) {
		this.idCentroCusto = idCentroCusto;
	}
	public int getIdCentroCustoPai() {
		return idCentroCustoPai;
	}
	public void setIdCentroCustoPai(int idCentroCustoPai) {
		this.idCentroCustoPai = idCentroCustoPai;
	}
	public String getCdCentroCusto() {
		return cdCentroCusto;
	}
	public void setCdCentroCusto(String cdCentroCusto) {
		this.cdCentroCusto = cdCentroCusto;
	}
	public String getNmCentroCusto() {
		return nmCentroCusto;
	}
	public void setNmCentroCusto(String nmCentroCusto) {
		this.nmCentroCusto = nmCentroCusto;
	}
	public String getPessoaResponsavel() {
		return pessoaResponsavel;
	}
	public void setPessoaResponsavel(String pessoaResponsavel) {
		this.pessoaResponsavel = pessoaResponsavel;
	}
	public String getNroTelefone() {
		return nroTelefone;
	}
	public void setNroTelefone(String nroTelefone) {
		this.nroTelefone = nroTelefone;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}

}
