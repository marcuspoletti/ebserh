package afero.model;

import java.util.Date;

public class Colaborador {
	
	
	private int idColaborador;
	private int idLoja;
	private int idTipoColaborador;
	private int idUsuario;
	private String nome;
	private String apelido;
	private String cpf;
	private String nroRg;
	private String endereco;
	private String bairro;
	private String cep;
	private String cidade;
	private String estado;
	private String cmpEndereco;
	private String status;
	private String ufRg;
	private String telefone;
	private String celular;
	private String email;
	private Date dtMod;
	private Date dtCad;
	private String orgRg;
	private String usuario;
	
	public Colaborador(int idColaborador, int idLoja, int idTipoColaborador,
			int idUsuario, String nome, String apelido, String cpf,
			String nroRg, String endereco, String bairro, String cep,
			String cidade, String estado, String cmpEndereco, String status,
			String ufRg, String telefone, String celular, String email,
			Date dtMod, Date dtCad, String orgRg, String usuario) {
		super();
		this.idColaborador = idColaborador;
		this.idLoja = idLoja;
		this.idTipoColaborador = idTipoColaborador;
		this.idUsuario = idUsuario;
		this.nome = nome;
		this.apelido = apelido;
		this.cpf = cpf;
		this.nroRg = nroRg;
		this.endereco = endereco;
		this.bairro = bairro;
		this.cep = cep;
		this.cidade = cidade;
		this.estado = estado;
		this.cmpEndereco = cmpEndereco;
		this.status = status;
		this.ufRg = ufRg;
		this.telefone = telefone;
		this.celular = celular;
		this.email = email;
		this.dtMod = dtMod;
		this.dtCad = dtCad;
		this.orgRg = orgRg;
		this.usuario = usuario;
	}

	
	public Colaborador(){}

	public int getIdColaborador() {
		return idColaborador;
	}
	public void setIdColaborador(int idColaborador) {
		this.idColaborador = idColaborador;
	}
	public int getIdLoja() {
		return idLoja;
	}
	public void setIdLoja(int idLoja) {
		this.idLoja = idLoja;
	}
	public int getIdTipoColaborador() {
		return idTipoColaborador;
	}
	public void setIdTipoColaborador(int idTipoColaborador) {
		this.idTipoColaborador = idTipoColaborador;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public String getApelido() {
		return apelido;
	}
	public void setApelido(String apelido) {
		this.apelido = apelido;
	}
	public String getCpf() {
		return cpf;
	}
	public void setCpf(String cpf) {
		this.cpf = cpf;
	}
	public String getNroRg() {
		return nroRg;
	}
	public void setNroRg(String nroRg) {
		this.nroRg = nroRg;
	}
	public String getEndereco() {
		return endereco;
	}
	public void setEndereco(String endereco) {
		this.endereco = endereco;
	}
	public String getBairro() {
		return bairro;
	}
	public void setBairro(String bairro) {
		this.bairro = bairro;
	}
	public String getCep() {
		return cep;
	}
	public void setCep(String cep) {
		this.cep = cep;
	}
	public String getCidade() {
		return cidade;
	}
	public void setCidade(String cidade) {
		this.cidade = cidade;
	}
	public String getEstado() {
		return estado;
	}
	public void setEstado(String estado) {
		this.estado = estado;
	}
	public String getCmpEndereco() {
		return cmpEndereco;
	}
	public void setCmpEndereco(String cmpEndereco) {
		this.cmpEndereco = cmpEndereco;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Date getDtMod() {
		return dtMod;
	}
	public void setDtMod(Date dtMod) {
		this.dtMod = dtMod;
	}
	public Date getDtCad() {
		return dtCad;
	}
	public void setDtCad(Date dtCad) {
		this.dtCad = dtCad;
	}
	public int getIdUsuario() {
		return idUsuario;
	}
	public void setIdUsuario(int idUsuario) {
		this.idUsuario = idUsuario;
	}
	public String getUfRg() {
		return ufRg;
	}
	public void setUfRg(String ufRg) {
		this.ufRg = ufRg;
	}
	public String getTelefone() {
		return telefone;
	}
	public void setTelefone(String telefone) {
		this.telefone = telefone;
	}
	public String getCelular() {
		return celular;
	}
	public void setCelular(String celular) {
		this.celular = celular;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}

	public String getOrgRg() {
		return orgRg;
	}

	public void setOrgRg(String orgRg) {
		this.orgRg = orgRg;
	}


	public String getUsuario() {
		return usuario;
	}


	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}

}
