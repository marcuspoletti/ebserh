package afero.model;

import java.util.Date;

public class EntidadeContato {

	private int idEntidadeContato;
	private int cdEntidade;
	private int cdTipoNivel;
	private String nmContato;
	private Date dtNascimento;
	private String cargo;
	private String departamento;
	private String sexo;
	private String telefone1;
	private String ramal1;
	private String telefone2;
	private String ramal2;
	private String fax;
	private String celular;
	private String email;
	private String hobby;
	private String time;
	private String status;
	private Date dtMod;
	private String Usuario;

	public EntidadeContato() {
		
	}
	
	public EntidadeContato(int idEntidadeContato, int cdEntidade,
			int cdTipoNivel, String nmContato, Date dtNascimento, String cargo,
			String departamento, String sexo, String telefone1, String ramal1,
			String telefone2, String ramal2, String fax, String celular,
			String email, String hobby, String time, String status, Date dtMod,
			String usuario) {
		this.idEntidadeContato = idEntidadeContato;
		this.cdEntidade = cdEntidade;
		this.cdTipoNivel = cdTipoNivel;
		this.nmContato = nmContato;
		this.dtNascimento = dtNascimento;
		this.cargo = cargo;
		this.departamento = departamento;
		this.sexo = sexo;
		this.telefone1 = telefone1;
		this.ramal1 = ramal1;
		this.telefone2 = telefone2;
		this.ramal2 = ramal2;
		this.fax = fax;
		this.celular = celular;
		this.email = email;
		this.hobby = hobby;
		this.time = time;
		this.status = status;
		this.dtMod = dtMod;
		Usuario = usuario;
	}

	public final int getIdEntidadeContato() {
		return idEntidadeContato;
	}

	public final void setIdEntidadeContato(int idEntidadeContato) {
		this.idEntidadeContato = idEntidadeContato;
	}

	public final int getCdEntidade() {
		return cdEntidade;
	}

	public final void setCdEntidade(int cdEntidade) {
		this.cdEntidade = cdEntidade;
	}

	public final int getCdTipoNivel() {
		return cdTipoNivel;
	}

	public final void setCdTipoNivel(int cdTipoNivel) {
		this.cdTipoNivel = cdTipoNivel;
	}

	public final String getNmContato() {
		return nmContato;
	}

	public final void setNmContato(String nmContato) {
		this.nmContato = nmContato;
	}

	public final Date getDtNascimento() {
		return dtNascimento;
	}

	public final void setDtNascimento(Date dtNascimento) {
		this.dtNascimento = dtNascimento;
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

	public final String getSexo() {
		return sexo;
	}

	public final void setSexo(String sexo) {
		this.sexo = sexo;
	}

	public final String getTelefone1() {
		return telefone1;
	}

	public final void setTelefone1(String telefone1) {
		this.telefone1 = telefone1;
	}

	public final String getRamal1() {
		return ramal1;
	}

	public final void setRamal1(String ramal1) {
		this.ramal1 = ramal1;
	}

	public final String getTelefone2() {
		return telefone2;
	}

	public final void setTelefone2(String telefone2) {
		this.telefone2 = telefone2;
	}

	public final String getRamal2() {
		return ramal2;
	}

	public final void setRamal2(String ramal2) {
		this.ramal2 = ramal2;
	}

	public final String getFax() {
		return fax;
	}

	public final void setFax(String fax) {
		this.fax = fax;
	}

	public final String getCelular() {
		return celular;
	}

	public final void setCelular(String celular) {
		this.celular = celular;
	}

	public final String getEmail() {
		return email;
	}

	public final void setEmail(String email) {
		this.email = email;
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

	public final String getStatus() {
		return status;
	}

	public final void setStatus(String status) {
		this.status = status;
	}

	public final Date getDtMod() {
		return dtMod;
	}

	public final void setDtMod(Date dtMod) {
		this.dtMod = dtMod;
	}

	public final String getUsuario() {
		return Usuario;
	}

	public final void setUsuario(String usuario) {
		Usuario = usuario;
	}

}
