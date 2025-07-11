package afero.model;

import java.util.Date;


public class ContaMovtoDivisao {
	
	private int idContaMovtoDivisao = 0;
	private int idContaMovto = 0;
	private int idPlanoConta = 0;
	private int idCentroCusto = 0;
	private String observacao = "";
	private float valor = 0;
	private int cdFormaPagto = 0;
	private Date dtMod = null;
	private String usuario = "";
	public ContaMovtoDivisao(int idContaMovtoDivisao, int idContaMovto,
			int idPlanoConta, int idCentroCusto, String observacao,
			float valor, int cdFormaPagto, Date dtMod, String usuario) {
		this.idContaMovtoDivisao = idContaMovtoDivisao;
		this.idContaMovto = idContaMovto;
		this.idPlanoConta = idPlanoConta;
		this.idCentroCusto = idCentroCusto;
		this.observacao = observacao;
		this.valor = valor;
		this.cdFormaPagto = cdFormaPagto;
		this.dtMod = dtMod;
		this.usuario = usuario;
	}
	public ContaMovtoDivisao() {
		super();
		// TODO Auto-generated constructor stub
	}
	public int getIdContaMovtoDivisao() {
		return idContaMovtoDivisao;
	}
	public void setIdContaMovtoDivisao(int idContaMovtoDivisao) {
		this.idContaMovtoDivisao = idContaMovtoDivisao;
	}
	public int getIdContaMovto() {
		return idContaMovto;
	}
	public void setIdContaMovto(int idContaMovto) {
		this.idContaMovto = idContaMovto;
	}
	public int getIdPlanoConta() {
		return idPlanoConta;
	}
	public void setIdPlanoConta(int idPlanoConta) {
		this.idPlanoConta = idPlanoConta;
	}
	public int getIdCentroCusto() {
		return idCentroCusto;
	}
	public void setIdCentroCusto(int idCentroCusto) {
		this.idCentroCusto = idCentroCusto;
	}
	public String getObservacao() {
		return observacao;
	}
	public void setObservacao(String observacao) {
		this.observacao = observacao;
	}
	public float getValor() {
		return valor;
	}
	public void setValor(float valor) {
		this.valor = valor;
	}
	public int getCdFormaPagto() {
		return cdFormaPagto;
	}
	public void setCdFormaPagto(int cdFormaPagto) {
		this.cdFormaPagto = cdFormaPagto;
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
