package afero.model;


import java.util.Date;
public class Entrega {
	
	private int idEntrega;
	private String dsEntrega;
	private float txEntrega;
	private Date dtCad;
	private Date dtMod;
	private String usuario;
	
	
	public Entrega(){}
	
	public Entrega(int idEntrega, String dsEntrega, float txEntrega,
			Date dtCad, Date dtMod, String usuario) {
		this.idEntrega = idEntrega;
		this.dsEntrega = dsEntrega;
		this.txEntrega = txEntrega;
		this.dtCad = dtCad;
		this.dtMod = dtMod;
		this.usuario = usuario;
	}
	public int getIdEntrega() {
		return idEntrega;
	}
	public void setIdEntrega(int idEntrega) {
		this.idEntrega = idEntrega;
	}
	public String getDsEntrega() {
		return dsEntrega;
	}
	public void setDsEntrega(String dsEntrega) {
		this.dsEntrega = dsEntrega;
	}
	public float getTxEntrega() {
		return txEntrega;
	}
	public void setTxEntrega(float txEntrega) {
		this.txEntrega = txEntrega;
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
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}

}
