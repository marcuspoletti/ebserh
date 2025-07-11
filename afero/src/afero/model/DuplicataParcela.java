package afero.model;

import java.util.Date;


public class DuplicataParcela {
	
	private int idDuplicataParcela = 0;
	private int idDuplicata = 0;
	private int nrParcela = 0;
	private int idConta = 0;
	private Date dtVenc = null;
	private double valor = 0;
	private int cdFormaPagto = 0;
	private Date dtEmissao = null;
	private Date dtComp = null;
	private String nrDoc = "";
	private int idPlanoConta = 0;
	private int idCentroCusto = 0;
	private String historico = "";
	private String divideValor = "";
	private Date dtOperacao = null;
	private double vlOperacao = 0;
	private float vlJuros = 0;
	private float vlMulta = 0;
	private float vlDesc = 0;
	private String nossoNumero = "";
	private Date dtQuitacao = null;
	private String formaQuitacao = "";
	private int idColaborador = 0;
	private String atualizaFinanceiro = "";
	private int idContaMovto = 0;
	private String status = "";
	private Date dtMov = null;
	private String usuario = "";
	
	public DuplicataParcela(int idDuplicataParcela, int idDuplicata,
			int nrParcela, int idConta, Date dtVenc, double valor,
			int cdFormaPagto, Date dtEmissao, Date dtComp, String nrDoc,
			int idPlanoConta, int idCentroCusto, String historico,
			String divideValor, Date dtOperacao, double vlOperacao,
			float vlJuros, float vlMulta, float vlDesc, String nossoNumero,
			Date dtQuitacao, String formaQuitacao, int idColaborador,
			String atualizaFinanceiro, int idContaMovto, String status,
			Date dtMov, String usuario) {
		super();
		this.idDuplicataParcela = idDuplicataParcela;
		this.idDuplicata = idDuplicata;
		this.nrParcela = nrParcela;
		this.idConta = idConta;
		this.dtVenc = dtVenc;
		this.valor = valor;
		this.cdFormaPagto = cdFormaPagto;
		this.dtEmissao = dtEmissao;
		this.dtComp = dtComp;
		this.nrDoc = nrDoc;
		this.idPlanoConta = idPlanoConta;
		this.idCentroCusto = idCentroCusto;
		this.historico = historico;
		this.divideValor = divideValor;
		this.dtOperacao = dtOperacao;
		this.vlOperacao = vlOperacao;
		this.vlJuros = vlJuros;
		this.vlMulta = vlMulta;
		this.vlDesc = vlDesc;
		this.nossoNumero = nossoNumero;
		this.dtQuitacao = dtQuitacao;
		this.formaQuitacao = formaQuitacao;
		this.idColaborador = idColaborador;
		this.atualizaFinanceiro = atualizaFinanceiro;
		this.idContaMovto = idContaMovto;
		this.status = status;
		this.dtMov = dtMov;
		this.usuario = usuario;
	}

	public DuplicataParcela() {
		
		// TODO Auto-generated constructor stub
	}

	public int getIdDuplicataParcela() {
		return idDuplicataParcela;
	}

	public void setIdDuplicataParcela(int idDuplicataParcela) {
		this.idDuplicataParcela = idDuplicataParcela;
	}

	public int getIdDuplicata() {
		return idDuplicata;
	}

	public void setIdDuplicata(int idDuplicata) {
		this.idDuplicata = idDuplicata;
	}

	public int getNrParcela() {
		return nrParcela;
	}

	public void setNrParcela(int nrParcela) {
		this.nrParcela = nrParcela;
	}

	public int getIdConta() {
		return idConta;
	}

	public void setIdConta(int idConta) {
		this.idConta = idConta;
	}

	public Date getDtVenc() {
		return dtVenc;
	}

	public void setDtVenc(Date dtVenc) {
		this.dtVenc = dtVenc;
	}

	public double getValor() {
		return valor;
	}

	public void setValor(double valor) {
		this.valor = valor;
	}

	public int getCdFormaPagto() {
		return cdFormaPagto;
	}

	public void setCdFormaPagto(int cdFormaPagto) {
		this.cdFormaPagto = cdFormaPagto;
	}

	public Date getDtEmissao() {
		return dtEmissao;
	}

	public void setDtEmissao(Date dtEmissao) {
		this.dtEmissao = dtEmissao;
	}

	public Date getDtComp() {
		return dtComp;
	}

	public void setDtComp(Date dtComp) {
		this.dtComp = dtComp;
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

	public Date getDtOperacao() {
		return dtOperacao;
	}

	public void setDtOperacao(Date dtOperacao) {
		this.dtOperacao = dtOperacao;
	}

	public double getVlOperacao() {
		return vlOperacao;
	}

	public void setVlOperacao(double vlOperacao) {
		this.vlOperacao = vlOperacao;
	}

	public float getVlJuros() {
		return vlJuros;
	}

	public void setVlJuros(float vlJuros) {
		this.vlJuros = vlJuros;
	}

	public float getVlMulta() {
		return vlMulta;
	}

	public void setVlMulta(float vlMulta) {
		this.vlMulta = vlMulta;
	}

	public float getVlDesc() {
		return vlDesc;
	}

	public void setVlDesc(float vlDesc) {
		this.vlDesc = vlDesc;
	}

	public String getNossoNumero() {
		return nossoNumero;
	}

	public void setNossoNumero(String nossoNumero) {
		this.nossoNumero = nossoNumero;
	}

	public Date getDtQuitacao() {
		return dtQuitacao;
	}

	public void setDtQuitacao(Date dtQuitacao) {
		this.dtQuitacao = dtQuitacao;
	}

	public String getFormaQuitacao() {
		return formaQuitacao;
	}

	public void setFormaQuitacao(String formaQuitacao) {
		this.formaQuitacao = formaQuitacao;
	}

	public int getIdColaborador() {
		return idColaborador;
	}

	public void setIdColaborador(int idColaborador) {
		this.idColaborador = idColaborador;
	}

	public String getAtualizaFinanceiro() {
		return atualizaFinanceiro;
	}

	public void setAtualizaFinanceiro(String atualizaFinanceiro) {
		this.atualizaFinanceiro = atualizaFinanceiro;
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
