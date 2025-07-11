package afero.model;



public class Cidade {
	
	private int idCidade;
	private int cdEstado;
	private String nmCidade;
	private String cdMunicipio;
	private String status;
	
	public Cidade() {
		
	}
	
	public Cidade(int idCidade, int cdEstado, String nmCidade, String status) {
	 this.idCidade = idCidade;
	 this.cdEstado = cdEstado;
	 this.nmCidade = nmCidade;
	 this.status   = status;
	 
	}
	
	public Cidade(int idCidade, int cdEstado, String nmCidade,
			String cdMunicipio, String status) {
		super();
		this.idCidade = idCidade;
		this.cdEstado = cdEstado;
		this.nmCidade = nmCidade;
		this.cdMunicipio = cdMunicipio;
		this.status = status;
	}

	public final int getIdCidade() {
		return idCidade;
	}

	public final void setIdCidade(int idCidade) {
		this.idCidade = idCidade;
	}

	public final int getCdEstado() {
		return cdEstado;
	}

	public final void setCdEstado(int cdEstado) {
		this.cdEstado = cdEstado;
	}

	public final String getNmCidade() {
		return nmCidade;
	}

	public final void setNmCidade(String nmCidade) {
		this.nmCidade = nmCidade;
	}

	public String getCdMunicipio() {
		return cdMunicipio;
	}

	public void setCdMunicipio(String cdMunicipio) {
		this.cdMunicipio = cdMunicipio;
	}

	public final String getStatus() {
		return status;
	}

	public final void setStatus(String status) {
		this.status = status;
	}

}
