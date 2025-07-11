package afero.model;

import java.util.Date;


public class ContaMovto {

	private int idContaMovto = 0;
	private int idConta = 0;
	private String dc = "";
	private double valor = 0;
	private String formaMovto = "";
	private Date dtLanc = null;
	private Date dtComp = null;
	private int idTransferencia = 0;
	private String nrDoc = "";
	private int idPlanoConta = 0;
	private int idCentroCusto = 0;
	private String historico = "";
	private String divideValor = "";
	private int idColaborador = 0;
	private double vlSaldoAnterior = 0;
	private double vlSaldoAtual = 0;
	private String conciliado = "";
	private String status = "";
	private Date dtCad = null;
	private Date dtMod = null;
	private String usuario = "";
	

	// RETIRADAS
	
	//private int cdEntidade = 0;
	//private String favorecido = "";
	//private int idContaDe = 0;
	//private String observacao = "";
	//private int cdFormaPagto = 0;
	//private int idColaborador = 0;
	//private int idRecibo = 0;

	public ContaMovto(){
	}


	public ContaMovto(int idContaMovto, int idConta, String dc, double valor,
			String formaMovto, Date dtLanc, Date dtComp, int idTransferencia,
			String nrDoc, int idPlanoConta, int idCentroCusto,
			String historico, String divideValor, int idColaborador,
			double vlSaldoAnterior, double vlSaldoAtual, String conciliado,
			String status, Date dtCad, Date dtMod, String usuario) {
		super();
		this.idContaMovto = idContaMovto;
		this.idConta = idConta;
		this.dc = dc;
		this.valor = valor;
		this.formaMovto = formaMovto;
		this.dtLanc = dtLanc;
		this.dtComp = dtComp;
		this.idTransferencia = idTransferencia;
		this.nrDoc = nrDoc;
		this.idPlanoConta = idPlanoConta;
		this.idCentroCusto = idCentroCusto;
		this.historico = historico;
		this.divideValor = divideValor;
		this.idColaborador = idColaborador;
		this.vlSaldoAnterior = vlSaldoAnterior;
		this.vlSaldoAtual = vlSaldoAtual;
		this.conciliado = conciliado;
		this.status = status;
		this.dtCad = dtCad;
		this.dtMod = dtMod;
		this.usuario = usuario;
	}


	public int getIdContaMovto() {
		return idContaMovto;
	}


	public void setIdContaMovto(int idContaMovto) {
		this.idContaMovto = idContaMovto;
	}


	public int getIdConta() {
		return idConta;
	}


	public void setIdConta(int idConta) {
		this.idConta = idConta;
	}


	public String getDc() {
		return dc;
	}


	public void setDc(String dc) {
		this.dc = dc;
	}


	public double getValor() {
		return valor;
	}


	public void setValor(double valor) {
		this.valor = valor;
	}


	public String getFormaMovto() {
		return formaMovto;
	}


	public void setFormaMovto(String formaMovto) {
		this.formaMovto = formaMovto;
	}


	public Date getDtLanc() {
		return dtLanc;
	}


	public void setDtLanc(Date dtLanc) {
		this.dtLanc = dtLanc;
	}


	public Date getDtComp() {
		return dtComp;
	}


	public void setDtComp(Date dtComp) {
		this.dtComp = dtComp;
	}


	public int getIdTransferencia() {
		return idTransferencia;
	}


	public void setIdTransferencia(int idTransferencia) {
		this.idTransferencia = idTransferencia;
	}


	public String getNrDoc() {
		return nrDoc;
	}


	public void setNrDoc(String nrDoc) {
		this.nrDoc = nrDoc;
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


	public String getHistorico() {
		return historico;
	}


	public void setHistorico(String historico) {
		this.historico = historico;
	}


	public String getDivideValor() {
		return divideValor;
	}


	public void setDivideValor(String divideValor) {
		this.divideValor = divideValor;
	}


	public int getIdColaborador() {
		return idColaborador;
	}


	public void setIdColaborador(int idColaborador) {
		this.idColaborador = idColaborador;
	}


	public double getVlSaldoAnterior() {
		return vlSaldoAnterior;
	}


	public void setVlSaldoAnterior(double vlSaldoAnterior) {
		this.vlSaldoAnterior = vlSaldoAnterior;
	}


	public double getVlSaldoAtual() {
		return vlSaldoAtual;
	}


	public void setVlSaldoAtual(double vlSaldoAtual) {
		this.vlSaldoAtual = vlSaldoAtual;
	}


	public String getConciliado() {
		return conciliado;
	}


	public void setConciliado(String conciliado) {
		this.conciliado = conciliado;
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


