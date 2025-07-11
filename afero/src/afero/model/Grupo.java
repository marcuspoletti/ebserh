package afero.model;


import java.util.Date;
public class Grupo {
	
	private int idGrupo;
	private String dsGrupo;
	private Date dtCad;
	private Date dtMod;
	private String status;
	private String usuario = "";

	
	public Grupo(){}
	
	public Grupo(int idGrupo, String dsGrupo, Date dtCad, Date dtMod,
			String status, String usuario) {
		this.idGrupo = idGrupo;
		this.dsGrupo = dsGrupo;
		this.dtCad = dtCad;
		this.dtMod = dtMod;
		this.status = status;
		this.usuario = usuario;
	}

	public String getUsuario() {
		return usuario;
	}

	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}

	public int getIdGrupo() {
		return idGrupo;
	}
	public void setIdGrupo(int idGrupo) {
		this.idGrupo = idGrupo;
	}
	public String getDsGrupo() {
		return dsGrupo;
	}
	public void setDsGrupo(String dsGrupo) {
		this.dsGrupo = dsGrupo;
	}
	public Date getDtCad() {
		return dtCad;
	}
	public void setDtCad(Date dtCad) {
		this.dtCad = dtCad;
	}
	public Date getDtMod() {
		return dtMod;
	}
	public void setDtMod(Date dtMod) {
		this.dtMod = dtMod;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	

}
