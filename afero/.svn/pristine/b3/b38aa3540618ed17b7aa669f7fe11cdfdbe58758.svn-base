package afero.model;

import java.util.Date;

public class EntidadeJuridica extends Entidade {

	private String cnpj;
	private String razaoSocial;
	private Date dtAbertura;
	private String inscEstadual;
	private String codCnae;

	public EntidadeJuridica() {

	}

	public EntidadeJuridica(int cdEntidade, String cnpj, String razaoSocial,
			Date dtAbertura, String inscEstadual, String codCnae) {
		super.setCdEntidade(cdEntidade);
		this.cnpj = cnpj;
		this.razaoSocial = razaoSocial;
		this.dtAbertura = dtAbertura;
		this.inscEstadual = inscEstadual;
		this.codCnae = codCnae;
	}

	public EntidadeJuridica(int cdEntidade,
			String nome, String tpInsc, String site, String status, 
			String observacao, String bloqueio,
			Date dtMod, Date dtCad, String usuario, 
			String cnpj, String razaoSocial,
			Date dtAbertura, String inscEstadual, String codCnae) {
		super(cdEntidade, nome, tpInsc, site, status, observacao, bloqueio, 
				dtMod, dtCad, usuario);
		this.cnpj = cnpj;
		this.razaoSocial = razaoSocial;
		this.dtAbertura = dtAbertura;
		this.inscEstadual = inscEstadual;
		this.codCnae = codCnae;
	}

	public final String getCnpj() {
		return cnpj;
	}

	public final void setCnpj(String cnpj) {
		this.cnpj = cnpj;
	}

	public final String getRazaoSocial() {
		return razaoSocial;
	}

	public final void setRazaoSocial(String razaoSocial) {
		this.razaoSocial = razaoSocial;
	}

	public final Date getDtAbertura() {
		return dtAbertura;
	}

	public final void setDtAbertura(Date dtAbertura) {
		this.dtAbertura = dtAbertura;
	}

	public final String getInscEstadual() {
		return inscEstadual;
	}

	public final void setInscEstadual(String inscEstadual) {
		this.inscEstadual = inscEstadual;
	}

	public final String getCodCnae() {
		return codCnae;
	}

	public final void setCodCnae(String codCnae) {
		this.codCnae = codCnae;
	}
	
}
