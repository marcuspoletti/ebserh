package model;

public class ExtratoPaciente {
	
	private String grauInstrucao;
	private String cor;
	private String estado_civil;
	private String cidPrimario;
	private String cid;
	private String nomeEspecialidade;
	private String unidadeFuncional;
	private String unidadeAnterior;
	private String tpMovimentoInternacao;
	private Integer prontuario;
	private String nome;
	private String sexo;
	
	
	private String dtNascimento;
	private String dtLancamento;
	private String dtInternacao;
	private String dtAltaMedica;
	private String motAlta;
	private String dtHrLancamento;
	private String ltoLtoId;
	
	
	private Integer intSeq;
	private Integer seq;
	private String dtHrInternacao;
	
	private String dthaltamedica;
	private String dtSaidaPaciente;
	private Integer codProcedimento;
	
	private String procedimento;
	private String idade;
	private String cidade;
	
	private String estado;

	public ExtratoPaciente(String grauInstrucao, String cor, String estado_civil, String cidPrimario, String cid,
			String nomeEspecialidade, String unidadeFuncional, String unidadeAnterior, String tpMovimentoInternacao,
			Integer prontuario, String nome, String sexo, String dtNascimento, String dtLancamento, String dtInternacao,
			String dtAltaMedica, String motAlta2, String dtHrLancamento, String ltoLtoId, Integer intSeq, Integer seq,
			String dtHrInternacao, String dthaltamedica, String dtSaidaPaciente, Integer codProcedimento,
			String procedimento, String idade2, String cidade, String estado) {
		super();
		this.grauInstrucao = grauInstrucao;
		this.cor = cor;
		this.estado_civil = estado_civil;
		this.cidPrimario = cidPrimario;
		this.cid = cid;
		this.nomeEspecialidade = nomeEspecialidade;
		this.unidadeFuncional = unidadeFuncional;
		this.unidadeAnterior = unidadeAnterior;
		this.tpMovimentoInternacao = tpMovimentoInternacao;
		this.prontuario = prontuario;
		this.nome = nome;
		this.sexo = sexo;
		this.dtNascimento = dtNascimento;
		this.dtLancamento = dtLancamento;
		this.dtInternacao = dtInternacao;
		this.dtAltaMedica = dtAltaMedica;
		this.motAlta = motAlta2;
		this.dtHrLancamento = dtHrLancamento;
		this.ltoLtoId = ltoLtoId;
		this.intSeq = intSeq;
		this.seq = seq;
		this.dtHrInternacao = dtHrInternacao;
		this.dthaltamedica = dthaltamedica;
		this.dtSaidaPaciente = dtSaidaPaciente;
		this.codProcedimento = codProcedimento;
		this.procedimento = procedimento;
		this.idade = idade2;
		this.cidade = cidade;
		this.estado = estado;
	}

	@Override
	public String toString() {
		return "ExtratoPaciente [grauInstrucao=" + grauInstrucao + ", cor=" + cor + ", estado_civil=" + estado_civil
				+ ", cidPrimario=" + cidPrimario + ", cid=" + cid + ", nomeEspecialidade=" + nomeEspecialidade
				+ ", unidadeFuncional=" + unidadeFuncional + ", unidadeAnterior=" + unidadeAnterior
				+ ", tpMovimentoInternacao=" + tpMovimentoInternacao + ", prontuario=" + prontuario + ", nome=" + nome
				+ ", sexo=" + sexo + ", dtNascimento=" + dtNascimento + ", dtLancamento=" + dtLancamento
				+ ", dtInternacao=" + dtInternacao + ", dtAltaMedica=" + dtAltaMedica + ", motAlta=" + motAlta
				+ ", dtHrLancamento=" + dtHrLancamento + ", ltoLtoId=" + ltoLtoId + ", intSeq=" + intSeq + ", seq="
				+ seq + ", dtHrInternacao=" + dtHrInternacao + ", dthaltamedica=" + dthaltamedica + ", dtSaidaPaciente="
				+ dtSaidaPaciente + ", codProcedimento=" + codProcedimento + ", procedimento=" + procedimento
				+ ", idade=" + idade + ", cidade=" + cidade + ", estado=" + estado + "]";
	}

	public ExtratoPaciente() {
		super();
		// TODO Auto-generated constructor stub
	}

	public String getGrauInstrucao() {
		return grauInstrucao;
	}

	public void setGrauInstrucao(String grauInstrucao) {
		this.grauInstrucao = grauInstrucao;
	}

	public String getCor() {
		return cor;
	}

	public void setCor(String cor) {
		this.cor = cor;
	}

	public String getEstado_civil() {
		return estado_civil;
	}

	public void setEstado_civil(String estado_civil) {
		this.estado_civil = estado_civil;
	}

	public String getCidPrimario() {
		return cidPrimario;
	}

	public void setCidPrimario(String cidPrimario) {
		this.cidPrimario = cidPrimario;
	}

	public String getCid() {
		return cid;
	}

	public void setCid(String cid) {
		this.cid = cid;
	}

	public String getNomeEspecialidade() {
		return nomeEspecialidade;
	}

	public void setNomeEspecialidade(String nomeEspecialidade) {
		this.nomeEspecialidade = nomeEspecialidade;
	}

	public String getUnidadeFuncional() {
		return unidadeFuncional;
	}

	public void setUnidadeFuncional(String unidadeFuncional) {
		this.unidadeFuncional = unidadeFuncional;
	}

	public String getUnidadeAnterior() {
		return unidadeAnterior;
	}

	public void setUnidadeAnterior(String unidadeAnterior) {
		this.unidadeAnterior = unidadeAnterior;
	}

	public String getTpMovimentoInternacao() {
		return tpMovimentoInternacao;
	}

	public void setTpMovimentoInternacao(String tpMovimentoInternacao) {
		this.tpMovimentoInternacao = tpMovimentoInternacao;
	}

	public Integer getProntuario() {
		return prontuario;
	}

	public void setProntuario(Integer prontuario) {
		this.prontuario = prontuario;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getSexo() {
		return sexo;
	}

	public void setSexo(String sexo) {
		this.sexo = sexo;
	}

	public String getDtNascimento() {
		return dtNascimento;
	}

	public void setDtNascimento(String dtNascimento) {
		this.dtNascimento = dtNascimento;
	}

	public String getDtLancamento() {
		return dtLancamento;
	}

	public void setDtLancamento(String dtLancamento) {
		this.dtLancamento = dtLancamento;
	}

	public String getDtInternacao() {
		return dtInternacao;
	}

	public void setDtInternacao(String dtInternacao) {
		this.dtInternacao = dtInternacao;
	}

	public String getDtAltaMedica() {
		return dtAltaMedica;
	}

	public void setDtAltaMedica(String dtAltaMedica) {
		this.dtAltaMedica = dtAltaMedica;
	}

	public String getMotAlta() {
		return motAlta;
	}

	public void setMotAlta(String motAlta) {
		this.motAlta = motAlta;
	}

	public String getDtHrLancamento() {
		return dtHrLancamento;
	}

	public void setDtHrLancamento(String dtHrLancamento) {
		this.dtHrLancamento = dtHrLancamento;
	}

	public String getLtoLtoId() {
		return ltoLtoId;
	}

	public void setLtoLtoId(String ltoLtoId) {
		this.ltoLtoId = ltoLtoId;
	}

	public Integer getIntSeq() {
		return intSeq;
	}

	public void setIntSeq(Integer intSeq) {
		this.intSeq = intSeq;
	}

	public Integer getSeq() {
		return seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
	}

	public String getDtHrInternacao() {
		return dtHrInternacao;
	}

	public void setDtHrInternacao(String dtHrInternacao) {
		this.dtHrInternacao = dtHrInternacao;
	}

	public String getDthaltamedica() {
		return dthaltamedica;
	}

	public void setDthaltamedica(String dthaltamedica) {
		this.dthaltamedica = dthaltamedica;
	}

	public String getDtSaidaPaciente() {
		return dtSaidaPaciente;
	}

	public void setDtSaidaPaciente(String dtSaidaPaciente) {
		this.dtSaidaPaciente = dtSaidaPaciente;
	}

	public Integer getCodProcedimento() {
		return codProcedimento;
	}

	public void setCodProcedimento(Integer codProcedimento) {
		this.codProcedimento = codProcedimento;
	}

	public String getProcedimento() {
		return procedimento;
	}

	public void setProcedimento(String procedimento) {
		this.procedimento = procedimento;
	}

	public String getIdade() {
		return idade;
	}

	public void setIdade(String idade) {
		this.idade = idade;
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
	
	
	
	
	
	
}


