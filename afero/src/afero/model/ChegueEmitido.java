package afero.model;

import java.util.Date;

public class ChegueEmitido {
	
	private int idChegueEmitido = 0;
	private int idLoja = 0;
	private int idConta = 0;
	private int nrChegue = 0;
	private double valor = 0;
	private Date dtEmissao = null;
	private Date dtVenc = null;
	private String favorecido = "";
	private String cpfCnpj = "";
	private Date dtPagto = null;
	private int idContaMovto = 0;
	private String status = "";
	private Date dtCad = null;
	private Date dtMod = null;
	private String usuario = "";
	
	
	public ChegueEmitido() {
		
		// TODO Auto-generated constructor stub
	}
	public ChegueEmitido(int idChegueEmitido, int idLoja, int idConta, int nrChegue,
			double valor, Date dtEmissao, Date dtVenc, String favorecido,
			String cpfCnpj, Date dtPagto, int idContaMovto, String status,
			Date dtCad, Date dtMod, String usuario) {
		
		this.idChegueEmitido = idChegueEmitido;
		this.idLoja = idLoja;
		this.idConta = idConta;
		this.nrChegue = nrChegue;
		this.valor = valor;
		this.dtEmissao = dtEmissao;
		this.dtVenc = dtVenc;
		this.favorecido = favorecido;
		this.cpfCnpj = cpfCnpj;
		this.dtPagto = dtPagto;
		this.idContaMovto = idContaMovto;
		this.status = status;
		this.dtCad = dtCad;
		this.dtMod = dtMod;
		this.usuario = usuario;
	}
	public int getIdChegueEmitido() {
		return idChegueEmitido;
	}
	public void setIdChegueEmitido(int idChegueEmitido) {
		this.idChegueEmitido = idChegueEmitido;
	}	
	public int getIdLoja() {
		return idLoja;
	}
	public void setIdLoja(int idLoja) {
		this.idLoja = idLoja;
	}
	public int getIdConta() {
		return idConta;
	}
	public void setIdConta(int idConta) {
		this.idConta = idConta;
	}
	public int getNrChegue() {
		return nrChegue;
	}
	public void setNrChegue(int nrChegue) {
		this.nrChegue = nrChegue;
	}
	public double getValor() {
		return valor;
	}
	public void setValor(double valor) {
		this.valor = valor;
	}
	public Date getDtEmissao() {
		return dtEmissao;
	}
	public void setDtEmissao(Date dtEmissao) {
		this.dtEmissao = dtEmissao;
	}
	public Date getDtVenc() {
		return dtVenc;
	}
	public void setDtVenc(Date dtVenc) {
		this.dtVenc = dtVenc;
	}
	public String getFavorecido() {
		return favorecido;
	}
	public void setFavorecido(String favorecido) {
		this.favorecido = favorecido;
	}
	public String getCpfCnpj() {
		return cpfCnpj;
	}
	public void setCpfCnpj(String cpfCnpj) {
		this.cpfCnpj = cpfCnpj;
	}
	public Date getDtPagto() {
		return dtPagto;
	}
	public void setDtPagto(Date dtPagto) {
		this.dtPagto = dtPagto;
	}
	public int getIdContaMovto() {
		return idContaMovto;
	}
	public void setIdContaMovto(int idContaMovto) {
		this.idContaMovto = idContaMovto;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Date getDtCad() {
		return dtCad;
	}
	public void setDtCad(Date dtCad) {
		this.dtCad = dtCad;
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
