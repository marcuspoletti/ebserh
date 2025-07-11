package afero.model;

import java.util.Date;

public class PedidoEntrada {
	
	private int idPedidoEntrada;
	private int idLoja;
	private int cdEntidade;
	private int idColaborador;
	private int idOrdemServico;
	private Date dtPed;
	private String operacao;
	private double vlPed;
	private String observacao;
	private String status;
	private String nrDoc;
	private Date dtMov;
	private Date dtMod;
	private Date dtEmissao;
	private String usuario;
	private int idPedidoEntradaOrigem;
	

	public PedidoEntrada(int idPedidoEntrada, int idLoja, int cdEntidade,
			int idColaborador, int idOrdemServico, Date dtPed, String operacao,
			double vlPed, String observacao, String status, String nrDoc,
			Date dtMov, Date dtMod, Date dtEmissao, String usuario,
			int idPedidoEntradaOrigem) {
		super();
		this.idPedidoEntrada = idPedidoEntrada;
		this.idLoja = idLoja;
		this.cdEntidade = cdEntidade;
		this.idColaborador = idColaborador;
		this.idOrdemServico = idOrdemServico;
		this.dtPed = dtPed;
		this.operacao = operacao;
		this.vlPed = vlPed;
		this.observacao = observacao;
		this.status = status;
		this.nrDoc = nrDoc;
		this.dtMov = dtMov;
		this.dtMod = dtMod;
		this.dtEmissao = dtEmissao;
		this.usuario = usuario;
		this.idPedidoEntradaOrigem = idPedidoEntradaOrigem;
	}


	public PedidoEntrada(){}
	
	
	public static void Imprimir(){
		System.out.println("teste");
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

	public int getIdColaborador() {
		return idColaborador;
	}

	public void setIdColaborador(int idColaborador) {
		this.idColaborador = idColaborador;
	}

	public int getIdOrdemServico() {
		return idOrdemServico;
	}

	public void setIdOrdemServico(int idOrdemServico) {
		this.idOrdemServico = idOrdemServico;
	}

	public void setIdPedidoEntrada(int idPedidoEntrada) {
		this.idPedidoEntrada = idPedidoEntrada;
	}


	public Date getDtPed() {
		return dtPed;
	}


	public void setDtPed(Date dtPed) {
		this.dtPed = dtPed;
	}


	public String getOperacao() {
		return operacao;
	}


	public void setOperacao(String operacao) {
		this.operacao = operacao;
	}


	public double getVlPed() {
		return vlPed;
	}


	public void setVlPed(double vlPed) {
		this.vlPed = vlPed;
	}


	public String getObservacao() {
		return observacao;
	}


	public void setObservacao(String observacao) {
		this.observacao = observacao;
	}


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public String getNrDoc() {
		return nrDoc;
	}


	public void setNrDoc(String nrDoc) {
		this.nrDoc = nrDoc;
	}


	public Date getDtMov() {
		return dtMov;
	}


	public void setDtMov(Date dtMov) {
		this.dtMov = dtMov;
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


	public int getIdPedidoEntradaOrigem() {
		return idPedidoEntradaOrigem;
	}


	public void setIdPedidoEntradaOrigem(int idPedidoEntradaOrigem) {
		this.idPedidoEntradaOrigem = idPedidoEntradaOrigem;
	}


	public int getIdPedidoEntrada() {
		return idPedidoEntrada;
	}


	public Date getDtEmissao() {
		return dtEmissao;
	}


	public void setDtEmissao(Date dtEmissao) {
		this.dtEmissao = dtEmissao;
	}

}
