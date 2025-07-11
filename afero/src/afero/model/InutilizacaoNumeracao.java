package afero.model;

import java.util.Date;

public class InutilizacaoNumeracao {
	private Integer idInutilizacaoNumeracao;
	private String cnpj;
	private String serie;
	private String numeroInicial;
	private String numeroFinal;
	private String justificativa;
	private Date dtRegistro;
	private String usuarios;
	
	
	
	public InutilizacaoNumeracao() {
		super();
		// TODO Auto-generated constructor stub
	}
	public InutilizacaoNumeracao(Integer idInutilizacaoNumeracao, String cnpj,
			String serie, String numeroInicial, String numeroFinal,
			String justificativa, Date dtRegistro, String usuarios) {
		super();
		this.idInutilizacaoNumeracao = idInutilizacaoNumeracao;
		this.cnpj = cnpj;
		this.serie = serie;
		this.numeroInicial = numeroInicial;
		this.numeroFinal = numeroFinal;
		this.justificativa = justificativa;
		this.dtRegistro = dtRegistro;
		this.usuarios = usuarios;
	}
	public Integer getIdInutilizacaoNumeracao() {
		return idInutilizacaoNumeracao;
	}
	public void setIdInutilizacaoNumeracao(Integer idInutilizacaoNumeracao) {
		this.idInutilizacaoNumeracao = idInutilizacaoNumeracao;
	}
	public String getCnpj() {
		return cnpj;
	}
	public void setCnpj(String cnpj) {
		this.cnpj = cnpj;
	}
	public String getSerie() {
		return serie;
	}
	public void setSerie(String serie) {
		this.serie = serie;
	}
	public String getNumeroInicial() {
		return numeroInicial;
	}
	public void setNumeroInicial(String numeroInicial) {
		this.numeroInicial = numeroInicial;
	}
	public String getNumeroFinal() {
		return numeroFinal;
	}
	public void setNumeroFinal(String numeroFinal) {
		this.numeroFinal = numeroFinal;
	}
	public String getJustificativa() {
		return justificativa;
	}
	public void setJustificativa(String justificativa) {
		this.justificativa = justificativa;
	}
	public Date getDtRegistro() {
		return dtRegistro;
	}
	public void setDtRegistro(Date dtRegistro) {
		this.dtRegistro = dtRegistro;
	}
	public String getUsuarios() {
		return usuarios;
	}
	public void setUsuarios(String usuarios) {
		this.usuarios = usuarios;
	}
	
	
	
	
	
	
	
	
}
