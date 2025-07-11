package afero.model;

import java.util.Date;

public class EntidadeFisica extends Entidade {

	private String cpf;
	private Date dtNascimento;
	private Date dtCasamento;
	private String cargo;
	private String departamento;
	private String empresa;
	private String sexo;
	private int cdEstadoCivil;
	private int cdEscolaridade;
	private String cpfConjuge;
	private String conjuge;
	private String mae;
	private String pai;
	private String nroRg;
	private String orgRg;
	private String ufRg;
	private Date dtRg;
	private String hobby;
	private String time;

	public EntidadeFisica() {

	}
	
	public EntidadeFisica(int cdEntidade, String cpf, Date dtNascimento, Date dtCasamento,
			String cargo, String departamento, String empresa, String sexo,
			int cdEstadoCivil, int cdEscolaridade, String cpfConjuge,
			String conjuge, String mae, String pai, String nroRg, String orgRg,
			String ufRg, Date dtRg, String hobby, String time) {
		super.setCdEntidade(cdEntidade);
		this.cpf = cpf;
		this.dtNascimento = dtNascimento;
		this.dtCasamento = dtCasamento;
		this.cargo = cargo;
		this.departamento = departamento;
		this.empresa = empresa;
		this.sexo = sexo;
		this.cdEstadoCivil = cdEstadoCivil;
		this.cdEscolaridade = cdEscolaridade;
		this.cpfConjuge = cpfConjuge;
		this.conjuge = conjuge;
		this.mae = mae;
		this.pai = pai;
		this.nroRg = nroRg;
		this.orgRg = orgRg;
		this.ufRg = ufRg;
		this.dtRg = dtRg;
		this.hobby = hobby;
		this.time = time;
	}

	public EntidadeFisica(int cdEntidade, 
			String nome, String tpInsc, String site, String status,
			String observacao, String bloqueio,
			Date dtMod, Date dtCad, String usuario,
			String cpf, Date dtNascimento, Date dtCasamento,
			String cargo, String departamento, String empresa, String sexo,
			int cdEstadoCivil, int cdEscolaridade, String cpfConjuge,
			String conjuge, String mae, String pai, String nroRg, String orgRg,
			String ufRg, Date dtRg, String hobby, String time) {
		super(cdEntidade, nome, tpInsc, site, status, observacao, bloqueio, 
				dtMod, dtCad, usuario);
		this.cpf = cpf;
		this.dtNascimento = dtNascimento;
		this.dtCasamento = dtCasamento;
		this.cargo = cargo;
		this.departamento = departamento;
		this.empresa = empresa;
		this.sexo = sexo;
		this.cdEstadoCivil = cdEstadoCivil;
		this.cdEscolaridade = cdEscolaridade;
		this.cpfConjuge = cpfConjuge;
		this.conjuge = conjuge;
		this.mae = mae;
		this.pai = pai;
		this.nroRg = nroRg;
		this.orgRg = orgRg;
		this.ufRg = ufRg;
		this.dtRg = dtRg;
		this.hobby = hobby;
		this.time = time;
	}

	public final String getCpf() {
		return cpf;
	}

	public final void setCpf(String cpf) {
		this.cpf = cpf;
	}

	public final Date getDtNascimento() {
		return dtNascimento;
	}

	public final void setDtNascimento(Date dtNascimento) {
		this.dtNascimento = dtNascimento;
	}

	public final Date getDtCasamento() {
		return dtCasamento;
	}

	public final void setDtCasamento(Date dtCasamento) {
		this.dtCasamento = dtCasamento;
	}

	public final String getCargo() {
		return cargo;
	}

	public final void setCargo(String cargo) {
		this.cargo = cargo;
	}

	public final String getDepartamento() {
		return departamento;
	}

	public final void setDepartamento(String departamento) {
		this.departamento = departamento;
	}

	public final String getEmpresa() {
		return empresa;
	}

	public final void setEmpresa(String empresa) {
		this.empresa = empresa;
	}

	public final String getSexo() {
		return sexo;
	}

	public final void setSexo(String sexo) {
		this.sexo = sexo;
	}

	public final int getCdEstadoCivil() {
		return cdEstadoCivil;
	}

	public final void setCdEstadoCivil(int cdEstadoCivil) {
		this.cdEstadoCivil = cdEstadoCivil;
	}

	public final int getCdEscolaridade() {
		return cdEscolaridade;
	}

	public final void setCdEscolaridade(int cdEscolaridade) {
		this.cdEscolaridade = cdEscolaridade;
	}

	public final String getCpfConjuge() {
		return cpfConjuge;
	}

	public final void setCpfConjuge(String cpfConjuge) {
		this.cpfConjuge = cpfConjuge;
	}

	public final String getConjuge() {
		return conjuge;
	}

	public final void setConjuge(String conjuge) {
		this.conjuge = conjuge;
	}

	public final String getMae() {
		return mae;
	}

	public final void setMae(String mae) {
		this.mae = mae;
	}

	public final String getPai() {
		return pai;
	}

	public final void setPai(String pai) {
		this.pai = pai;
	}

	public final String getNroRg() {
		return nroRg;
	}

	public final void setNroRg(String nroRg) {
		this.nroRg = nroRg;
	}

	public final String getOrgRg() {
		return orgRg;
	}

	public final void setOrgRg(String orgRg) {
		this.orgRg = orgRg;
	}

	public final String getUfRg() {
		return ufRg;
	}

	public final void setUfRg(String ufRg) {
		this.ufRg = ufRg;
	}

	public final Date getDtRg() {
		return dtRg;
	}

	public final void setDtRg(Date dtRg) {
		this.dtRg = dtRg;
	}

	public final String getHobby() {
		return hobby;
	}

	public final void setHobby(String hobby) {
		this.hobby = hobby;
	}

	public final String getTime() {
		return time;
	}

	public final void setTime(String time) {
		this.time = time;
	}
	
}
