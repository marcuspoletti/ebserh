package afero.model;

import java.util.Date;

public class Loja {
	
	
	private int idLoja;
	private String apelido;
	private String razaoSocial;
	private String cnpj;
	private String inscEstadual;
	private String endereco;
	private String cmpEndereco;
	private String cep;
	private String bairro;
	private String cidade;
	private String estado;
	private String nroTelefone;
	private String nroFax;
	private String pessoaResponsavel;
	private Date dtMod;
	private Date dtCad;
	private String status;	
	private String usuario;
	
	
	private Integer idCrt ;
	private Integer idCnae;
	private Integer idCidade;
	private String inscMunicipal;
	private String nro ; 
	
	public Loja() {}
	
	public Loja(int idLoja, String apelido, String razaoSocial, String cnpj,
			String inscEstadual, String endereco, String cmpEndereco,
			String cep, String bairro, String cidade, String estado,
			String nroTelefone, String nroFax, String pessoaResponsavel,
			Date dtMod, Date dtCad, String status, String usuario) {
	
		this.idLoja = idLoja;
		this.apelido = apelido;
		this.razaoSocial = razaoSocial;
		this.cnpj = cnpj;
		this.inscEstadual = inscEstadual;
		this.endereco = endereco;
		this.cmpEndereco = cmpEndereco;
		this.cep = cep;
		this.bairro = bairro;
		this.cidade = cidade;
		this.estado = estado;
		this.nroTelefone = nroTelefone;
		this.nroFax = nroFax;
		this.pessoaResponsavel = pessoaResponsavel;
		this.dtMod = dtMod;
		this.dtCad = dtCad;
		this.status = status;
		this.usuario = usuario;
	}
	
	
	
	public Loja(int idLoja, String apelido, String razaoSocial, String cnpj,
			String inscEstadual, String endereco, String cmpEndereco,
			String cep, String bairro, String cidade, String estado,
			String nroTelefone, String nroFax, String pessoaResponsavel,
			Date dtMod, Date dtCad, String status, String usuario,
			Integer idCrt, Integer idCnae) {
	
		this.idLoja = idLoja;
		this.apelido = apelido;
		this.razaoSocial = razaoSocial;
		this.cnpj = cnpj;
		this.inscEstadual = inscEstadual;
		this.endereco = endereco;
		this.cmpEndereco = cmpEndereco;
		this.cep = cep;
		this.bairro = bairro;
		this.cidade = cidade;
		this.estado = estado;
		this.nroTelefone = nroTelefone;
		this.nroFax = nroFax;
		this.pessoaResponsavel = pessoaResponsavel;
		this.dtMod = dtMod;
		this.dtCad = dtCad;
		this.status = status;
		this.usuario = usuario;
		this.idCrt = idCrt;
		this.idCnae = idCnae;
	}

	
	
	public Loja(int idLoja, String apelido, String razaoSocial, String cnpj,
			String inscEstadual, String endereco, String cmpEndereco,
			String cep, String bairro, String estado,
			String nroTelefone, String nroFax, String pessoaResponsavel,
			Date dtMod, Date dtCad, String status, String usuario,
			Integer idCrt, Integer idCnae, Integer idCidade) {
		super();
		this.idLoja = idLoja;
		this.apelido = apelido;
		this.razaoSocial = razaoSocial;
		this.cnpj = cnpj;
		this.inscEstadual = inscEstadual;
		this.endereco = endereco;
		this.cmpEndereco = cmpEndereco;
		this.cep = cep;
		this.bairro = bairro;
		this.estado = estado;
		this.nroTelefone = nroTelefone;
		this.nroFax = nroFax;
		this.pessoaResponsavel = pessoaResponsavel;
		this.dtMod = dtMod;
		this.dtCad = dtCad;
		this.status = status;
		this.usuario = usuario;
		this.idCrt = idCrt;
		this.idCnae = idCnae;
		this.idCidade = idCidade;
	}

	public Loja(int idLoja, String apelido, String razaoSocial, String cnpj,
			String inscEstadual, String endereco, String cmpEndereco,
			String cep, String bairro, String estado, String nroTelefone,
			String nroFax, String pessoaResponsavel, Date dtMod, Date dtCad,
			String status, String usuario, Integer idCrt, Integer idCnae,
			Integer idCidade, String inscMunicipal) {
		
		this.idLoja = idLoja;
		this.apelido = apelido;
		this.razaoSocial = razaoSocial;
		this.cnpj = cnpj;
		this.inscEstadual = inscEstadual;
		this.endereco = endereco;
		this.cmpEndereco = cmpEndereco;
		this.cep = cep;
		this.bairro = bairro;
		this.estado = estado;
		this.nroTelefone = nroTelefone;
		this.nroFax = nroFax;
		this.pessoaResponsavel = pessoaResponsavel;
		this.dtMod = dtMod;
		this.dtCad = dtCad;
		this.status = status;
		this.usuario = usuario;
		this.idCrt = idCrt;
		this.idCnae = idCnae;
		this.idCidade = idCidade;
		this.inscMunicipal = inscMunicipal;
	}

	public Loja(int idLoja, String apelido, String razaoSocial, String cnpj,
			String inscEstadual, String endereco, String cmpEndereco,
			String cep, String bairro, String estado,
			String nroTelefone, String nroFax, String pessoaResponsavel,
			Date dtMod, Date dtCad, String status, String usuario,
			Integer idCrt, Integer idCnae, Integer idCidade,
			String inscMunicipal, String nro) {
		
		this.idLoja = idLoja;
		this.apelido = apelido;
		this.razaoSocial = razaoSocial;
		this.cnpj = cnpj;
		this.inscEstadual = inscEstadual;
		this.endereco = endereco;
		this.cmpEndereco = cmpEndereco;
		this.cep = cep;
		this.bairro = bairro;
		this.estado = estado;
		this.nroTelefone = nroTelefone;
		this.nroFax = nroFax;
		this.pessoaResponsavel = pessoaResponsavel;
		this.dtMod = dtMod;
		this.dtCad = dtCad;
		this.status = status;
		this.usuario = usuario;
		this.idCrt = idCrt;
		this.idCnae = idCnae;
		this.idCidade = idCidade;
		this.inscMunicipal = inscMunicipal;
		this.nro = nro;
	}

	public String getInscMunicipal() {
		return inscMunicipal;
	}

	public void setInscMunicipal(String inscMunicipal) {
		this.inscMunicipal = inscMunicipal;
	}

	public Integer getIdCidade() {
		return idCidade;
	}

	public void setIdCidade(Integer idCidade) {
		this.idCidade = idCidade;
	}

	public int getIdLoja() {
		return idLoja;
	}
	public void setIdLoja(int idLoja) {
		this.idLoja = idLoja;
	}
	public String getApelido() {
		return apelido;
	}
	public void setApelido(String apelido) {
		this.apelido = apelido;
	}
	public String getRazaoSocial() {
		return razaoSocial;
	}
	public void setRazaoSocial(String razaoSocial) {
		this.razaoSocial = razaoSocial;
	}
	public String getCnpj() {
		return cnpj;
	}
	public void setCnpj(String cnpj) {
		this.cnpj = cnpj;
	}
	public String getInscEstadual() {
		return inscEstadual;
	}
	public void setInscEstadual(String inscEstadual) {
		this.inscEstadual = inscEstadual;
	}
	public String getEndereco() {
		return endereco;
	}
	public void setEndereco(String endereco) {
		this.endereco = endereco;
	}
	public String getCmpEndereco() {
		return cmpEndereco;
	}
	public void setCmpEndereco(String cmpEndereco) {
		this.cmpEndereco = cmpEndereco;
	}
	public String getCep() {
		return cep;
	}
	public void setCep(String cep) {
		this.cep = cep;
	}
	public String getBairro() {
		return bairro;
	}
	public void setBairro(String bairro) {
		this.bairro = bairro;
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
	public String getNroTelefone() {
		return nroTelefone;
	}
	public void setNroTelefone(String nroTelefone) {
		this.nroTelefone = nroTelefone;
	}
	public String getNroFax() {
		return nroFax;
	}
	public void setNroFax(String nroFax) {
		this.nroFax = nroFax;
	}
	public String getPessoaResponsavel() {
		return pessoaResponsavel;
	}
	public void setPessoaResponsavel(String pessoaResponsavel) {
		this.pessoaResponsavel = pessoaResponsavel;
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
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}

	public String getUsuario() {
		return usuario;
	}

	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}

	public Integer getIdCrt() {
		return idCrt;
	}

	public void setIdCrt(Integer idCrt) {
		this.idCrt = idCrt;
	}

	public Integer getIdCnae() {
		return idCnae;
	}

	public void setIdCnae(Integer idCnae) {
		this.idCnae = idCnae;
	}

	public String getNro() {
		return nro;
	}

	public void setNro(String nro) {
		this.nro = nro;
	}
	
}
