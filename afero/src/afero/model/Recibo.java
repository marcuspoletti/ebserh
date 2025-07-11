package afero.model;

import java.util.*;

public class Recibo {
	
	private int idRecibo = 0;
	private int idLoja = 0;
	private int cdEntidade = 0;
	private String favorecido = "";
	private double valor = 0;
	private String referente = "";
	private String observacao = "";
	private String emitente = "";
	private String endereco = "";
	private String cpfCnpj = "";
	private String cidade = "";
	private Date dtEmissao = null;
	private Date dtMov = null;
	private String usuario = "";
	
	
	
	public Recibo() {
		
		// TODO Auto-generated constructor stub
	}
	public Recibo(int idRecibo, int idLoja, int cdEntidade, String favorecido,
			double valor, String referente, String observacao, String emitente,
			String endereco, String cpfCnpj, String cidade, Date dtEmissao,
			Date dtMov, String usuario) {
		this.idRecibo = idRecibo;
		this.idLoja = idLoja;
		this.cdEntidade = cdEntidade;
		this.favorecido = favorecido;
		this.valor = valor;
		this.referente = referente;
		this.observacao = observacao;
		this.emitente = emitente;
		this.endereco = endereco;
		this.cpfCnpj = cpfCnpj;
		this.cidade = cidade;
		this.dtEmissao = dtEmissao;
		this.dtMov = dtMov;
		this.usuario = usuario;
	}
	public int getIdRecibo() {
		return idRecibo;
	}
	public void setIdRecibo(int idRecibo) {
		this.idRecibo = idRecibo;
	}
	public int getIdLoja() {
		return idLoja;
	}
	public void setIdLoja(int idLoja) {
		this.idLoja = idLoja;
	}
	public int getCdEntidade() {
		return cdEntidade;
	}
	public void setCdEntidade(int cdEntidade) {
		this.cdEntidade = cdEntidade;
	}
	public String getFavorecido() {
		return favorecido;
	}
	public void setFavorecido(String favorecido) {
		this.favorecido = favorecido;
	}
	public double getValor() {
		return valor;
	}
	public void setValor(double valor) {
		this.valor = valor;
	}
	public String getReferente() {
		return referente;
	}
	public void setReferente(String referente) {
		this.referente = referente;
	}
	public String getObservacao() {
		return observacao;
	}
	public void setObservacao(String observacao) {
		this.observacao = observacao;
	}
	public String getEmitente() {
		return emitente;
	}
	public void setEmitente(String emitente) {
		this.emitente = emitente;
	}
	public String getEndereco() {
		return endereco;
	}
	public void setEndereco(String endereco) {
		this.endereco = endereco;
	}
	public String getCpfCnpj() {
		return cpfCnpj;
	}
	public void setCpfCnpj(String cpfCnpj) {
		this.cpfCnpj = cpfCnpj;
	}
	public String getCidade() {
		return cidade;
	}
	public void setCidade(String cidade) {
		this.cidade = cidade;
	}
	public Date getDtEmissao() {
		return dtEmissao;
	}
	public void setDtEmissao(Date dtEmissao) {
		this.dtEmissao = dtEmissao;
	}
	public Date getDtMov() {
		return dtMov;
	}
	public void setDtMov(Date dtMov) {
		this.dtMov = dtMov;
	}
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}

}
