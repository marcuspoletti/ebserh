package afero.model;

import java.util.Date;

public class ListarEntradasProduto {
	
	//Produtos
	private int idProduto = 0;
	private int idDivisao = 0;
	private int idSubGrupo = 0;
	private int idGrupo = 0;
	private String nmProduto = "";
	private String dsProduto = "";
	private String tipoProduto = "";
	private String status = "";
	private Date dtCad;
	private Date dtMod;
	private String usuario = "";
	private String cdBarra = "";
	private String nrDoc = "";
	private Date dtPed;
	private float quant = 0;
	private String operacao = "";
	private String statusPedido = "";
	private int idPedidoEntrada = 0;
	private float valor = 0;
	private float custo = 0;
	
	
	
	
	public ListarEntradasProduto() {
		
		// TODO Auto-generated constructor stub
	}
	public ListarEntradasProduto(int idProduto, int idDivisao, int idSubGrupo,
			int idGrupo, String nmProduto, String dsProduto,
			String tipoProduto, String status, Date dtCad, Date dtMod,
			String usuario, String cdBarra, String nrDoc, Date dtPed,
			float quant, String operacao, String statusPedido,
			int idPedidoEntrada, float valor, float custo) {
		
		this.idProduto = idProduto;
		this.idDivisao = idDivisao;
		this.idSubGrupo = idSubGrupo;
		this.idGrupo = idGrupo;
		this.nmProduto = nmProduto;
		this.dsProduto = dsProduto;
		this.tipoProduto = tipoProduto;
		this.status = status;
		this.dtCad = dtCad;
		this.dtMod = dtMod;
		this.usuario = usuario;
		this.cdBarra = cdBarra;
		this.nrDoc = nrDoc;
		this.dtPed = dtPed;
		this.quant = quant;
		this.operacao = operacao;
		this.statusPedido = statusPedido;
		this.idPedidoEntrada = idPedidoEntrada;
		this.valor = valor;
		this.custo = custo;
	}
	public int getIdProduto() {
		return idProduto;
	}
	public void setIdProduto(int idProduto) {
		this.idProduto = idProduto;
	}
	public int getIdDivisao() {
		return idDivisao;
	}
	public void setIdDivisao(int idDivisao) {
		this.idDivisao = idDivisao;
	}
	public int getIdSubGrupo() {
		return idSubGrupo;
	}
	public void setIdSubGrupo(int idSubGrupo) {
		this.idSubGrupo = idSubGrupo;
	}
	public int getIdGrupo() {
		return idGrupo;
	}
	public void setIdGrupo(int idGrupo) {
		this.idGrupo = idGrupo;
	}
	public String getNmProduto() {
		return nmProduto;
	}
	public void setNmProduto(String nmProduto) {
		this.nmProduto = nmProduto;
	}
	public String getDsProduto() {
		return dsProduto;
	}
	public void setDsProduto(String dsProduto) {
		this.dsProduto = dsProduto;
	}
	public String getTipoProduto() {
		return tipoProduto;
	}
	public void setTipoProduto(String tipoProduto) {
		this.tipoProduto = tipoProduto;
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
	public String getCdBarra() {
		return cdBarra;
	}
	public void setCdBarra(String cdBarra) {
		this.cdBarra = cdBarra;
	}
	public String getNrDoc() {
		return nrDoc;
	}
	public void setNrDoc(String nrDoc) {
		this.nrDoc = nrDoc;
	}
	public Date getDtPed() {
		return dtPed;
	}
	public void setDtPed(Date dtPed) {
		this.dtPed = dtPed;
	}
	public float getQuant() {
		return quant;
	}
	public void setQuant(float quant) {
		this.quant = quant;
	}
	public String getOperacao() {
		return operacao;
	}
	public void setOperacao(String operacao) {
		this.operacao = operacao;
	}
	public String getStatusPedido() {
		return statusPedido;
	}
	public void setStatusPedido(String statusPedido) {
		this.statusPedido = statusPedido;
	}
	public int getIdPedidoEntrada() {
		return idPedidoEntrada;
	}
	public void setIdPedidoEntrada(int idPedidoEntrada) {
		this.idPedidoEntrada = idPedidoEntrada;
	}
	public float getValor() {
		return valor;
	}
	public void setValor(float valor) {
		this.valor = valor;
	}
	public float getCusto() {
		return custo;
	}
	public void setCusto(float custo) {
		this.custo = custo;
	}
	
	

}
