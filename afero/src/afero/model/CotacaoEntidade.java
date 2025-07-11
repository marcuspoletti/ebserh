package afero.model;

import java.util.Date;

public class CotacaoEntidade {
	
	private int idCotacaoEntidade;
	private int idCotacaoItem;
	private int cdEntidade;
	private float valor;
	private int prazoEntrega;
	private String aprovado;
	private float valorAprov;
	private Date dtMod;
	private String usuario;
	
	public CotacaoEntidade(){}
	
	public CotacaoEntidade(int idCotacaoEntidade, int idCotacaoItem,
			int cdEntidade, float valor, int prazoEntrega, String aprovado,
			float valorAprov, String usuario) {
		
		this.idCotacaoEntidade = idCotacaoEntidade;
		this.idCotacaoItem = idCotacaoItem;
		this.cdEntidade = cdEntidade;
		this.valor = valor;
		this.prazoEntrega = prazoEntrega;
		this.aprovado = aprovado;
		this.valorAprov = valorAprov;
		this.usuario = usuario;
	}
	public int getIdCotacaoEntidade() {
		return idCotacaoEntidade;
	}
	public void setIdCotacaoEntidade(int idCotacaoEntidade) {
		this.idCotacaoEntidade = idCotacaoEntidade;
	}
	public int getIdCotacaoItem() {
		return idCotacaoItem;
	}
	public void setIdCotacaoItem(int idCotacaoItem) {
		this.idCotacaoItem = idCotacaoItem;
	}
	public int getCdEntidade() {
		return cdEntidade;
	}
	public void setCdEntidade(int cdEntidade) {
		this.cdEntidade = cdEntidade;
	}
	public float getValor() {
		return valor;
	}
	public void setValor(float valor) {
		this.valor = valor;
	}
	public int getPrazoEntrega() {
		return prazoEntrega;
	}
	public void setPrazoValidade(int prazoEntrega) {
		this.prazoEntrega = prazoEntrega;
	}
	public String getAprovado() {
		return aprovado;
	}
	public void setAprovado(String aprovado) {
		this.aprovado = aprovado;
	}
	public float getValorAprov() {
		return valorAprov;
	}
	public void setValorAprov(float valorAprov) {
		this.valorAprov = valorAprov;
	}
	public Date getDtMod() {
		return dtMod;
	}
	public void setDtMod(Date dtMod) {
		this.dtMod = dtMod;
	}
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}

}
