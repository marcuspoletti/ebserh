package afero.model;

import java.util.Date;

public class EntidadeEmail {

	private int idEntidadeEmail;
	private int cdEntidade;
	private int cdTipoEmail;
	private String dsEmail;
	private String padrao;
	private Date dtMod;
	private String usuario;

	public EntidadeEmail() {

	}

	public EntidadeEmail(int idEntidadeEmail, int cdEntidade, int cdTipoEmail, String dsEmail,
			String padrao, Date dtMod, String usuario) {
		this.idEntidadeEmail = idEntidadeEmail;
		this.cdEntidade = cdEntidade;
		this.cdTipoEmail = cdTipoEmail;
		this.dsEmail = dsEmail;
		this.padrao = padrao;
		this.dtMod = dtMod;
		this.usuario = usuario;
	}

	public final int getIdEntidadeEmail() {
		return idEntidadeEmail;
	}

	public final void setIdEntidadeEmail(int idEntidadeEmail) {
		this.idEntidadeEmail = idEntidadeEmail;
	}

	public final int getCdEntidade() {
		return cdEntidade;
	}

	public final void setCdEntidade(int cdEntidade) {
		this.cdEntidade = cdEntidade;
	}

	public final int getCdTipoEmail() {
		return cdTipoEmail;
	}

	public final void setCdTipoEmail(int cdTipoEmail) {
		this.cdTipoEmail = cdTipoEmail;
	}

	public final String getDsEmail() {
		return dsEmail;
	}

	public final void setDsEmail(String dsEmail) {
		this.dsEmail = dsEmail;
	}

	public final String getPadrao() {
		return padrao;
	}

	public final void setPadrao(String padrao) {
		this.padrao = padrao;
	}

	public final Date getDtMod() {
		return dtMod;
	}

	public final void setDtMod(Date dtMod) {
		this.dtMod = dtMod;
	}

	public final String getUsuario() {
		return usuario;
	}

	public final void setUsuario(String usuario) {
		this.usuario = usuario;
	}

}
