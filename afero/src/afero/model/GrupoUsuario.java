package afero.model;


public class GrupoUsuario {
	
	private int idGrupoUsuario = 0;
	private String dsGrupoUsuario = "";
	private String status = "";
	
	public GrupoUsuario(){}
	
	public GrupoUsuario(int idGrupoUsuario, String dsGrupoUsuario, String status) {
	
		this.idGrupoUsuario = idGrupoUsuario;
		this.dsGrupoUsuario = dsGrupoUsuario;
	
		this.status = status;
	}
	public int getIdGrupoUsuario() {
		return idGrupoUsuario;
	}
	public void setIdGrupoUsuario(int idGrupoUsuario) {
		this.idGrupoUsuario = idGrupoUsuario;
	}
	public String getDsGrupoUsuario() {
		return dsGrupoUsuario;
	}
	public void setDsGrupoUsuario(String dsGrupoUsuario) {
		this.dsGrupoUsuario = dsGrupoUsuario;
	}

	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	

}
