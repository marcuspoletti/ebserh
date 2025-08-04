package model;

public class AtendimentoAmbulatorial {
	
	
	private String siglaEsp;
	private String profissional;
	private Integer codPaciente;
	private String dtNascimento;
	private String sexo;
	private String uf;
	private String cidade;
	private Integer numConsulta;
	private String marcacaoMedica;
	private String iniConMed;
	private String fimConMed;
	private Integer pacProntuario;
	private Integer pacCodigo;
	private String paciente;
	private String tempoEspera;
	private String tempoAtendimento;
	

	public AtendimentoAmbulatorial() {
		// TODO Auto-generated constructor stub
	}


	public AtendimentoAmbulatorial(String siglaEsp, String profissional, Integer codPaciente, String dtNascimento,
			String sexo, String uf, String cidade, Integer numConsulta, String marcacaoMedica, String iniConMed,
			String fimConMed, Integer pacProntuario, Integer pacCodigo, String paciente, String tempoEspera,
			String tempoAtendimento) {
		super();
		this.siglaEsp = siglaEsp;
		this.profissional = profissional;
		this.codPaciente = codPaciente;
		this.dtNascimento = dtNascimento;
		this.sexo = sexo;
		this.uf = uf;
		this.cidade = cidade;
		this.numConsulta = numConsulta;
		this.marcacaoMedica = marcacaoMedica;
		this.iniConMed = iniConMed;
		this.fimConMed = fimConMed;
		this.pacProntuario = pacProntuario;
		this.pacCodigo = pacCodigo;
		this.paciente = paciente;
		this.tempoEspera = tempoEspera;
		this.tempoAtendimento = tempoAtendimento;
	}


	public String getSiglaEsp() {
		return siglaEsp;
	}


	public void setSiglaEsp(String siglaEsp) {
		this.siglaEsp = siglaEsp;
	}


	public String getProfissional() {
		return profissional;
	}


	public void setProfissional(String profissional) {
		this.profissional = profissional;
	}


	public Integer getCodPaciente() {
		return codPaciente;
	}


	public void setCodPaciente(Integer codPaciente) {
		this.codPaciente = codPaciente;
	}


	public String getDtNascimento() {
		return dtNascimento;
	}


	public void setDtNascimento(String dtNascimento) {
		this.dtNascimento = dtNascimento;
	}


	public String getSexo() {
		return sexo;
	}


	public void setSexo(String sexo) {
		this.sexo = sexo;
	}


	public String getUf() {
		return uf;
	}


	public void setUf(String uf) {
		this.uf = uf;
	}


	public String getCidade() {
		return cidade;
	}


	public void setCidade(String cidade) {
		this.cidade = cidade;
	}


	public Integer getNumConsulta() {
		return numConsulta;
	}


	public void setNumConsulta(Integer numConsulta) {
		this.numConsulta = numConsulta;
	}


	public String getMarcacaoMedica() {
		return marcacaoMedica;
	}


	public void setMarcacaoMedica(String marcacaoMedica) {
		this.marcacaoMedica = marcacaoMedica;
	}


	public String getIniConMed() {
		return iniConMed;
	}


	public void setIniConMed(String iniConMed) {
		this.iniConMed = iniConMed;
	}


	public String getFimConMed() {
		return fimConMed;
	}


	public void setFimConMed(String fimConMed) {
		this.fimConMed = fimConMed;
	}


	public Integer getPacProntuario() {
		return pacProntuario;
	}


	public void setPacProntuario(Integer pacProntuario) {
		this.pacProntuario = pacProntuario;
	}


	public Integer getPacCodigo() {
		return pacCodigo;
	}


	public void setPacCodigo(Integer pacCodigo) {
		this.pacCodigo = pacCodigo;
	}


	public String getPaciente() {
		return paciente;
	}


	public void setPaciente(String paciente) {
		this.paciente = paciente;
	}


	public String getTempoEspera() {
		return tempoEspera;
	}


	public void setTempoEspera(String tempoEspera) {
		this.tempoEspera = tempoEspera;
	}


	public String getTempoAtendimento() {
		return tempoAtendimento;
	}


	public void setTempoAtendimento(String tempoAtendimento) {
		this.tempoAtendimento = tempoAtendimento;
	}
	
	
	
	
	
	

}
