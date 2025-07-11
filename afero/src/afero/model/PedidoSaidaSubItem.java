package afero.model;

import java.util.Date;

public class PedidoSaidaSubItem {

	private int idPedidoSaidaItem;
	private int idPedidoSaida;
	private int idProduto;
	private int idUnidade;
	private int idAgrupamento;
	private String dsCompProduto;
	private float comp;
	private float larg;
	private float quant;
	private float valor;
	private Date dtMod;
	private String usuario;
	private float pDesc;
	private float vlUni;
    //Comandas
	private String impProducao;
	//Comandas
	public PedidoSaidaSubItem() {
	}

	public PedidoSaidaSubItem(int idPedidoSaidaItem, int idPedidoSaida,
			int idProduto, int idUnidade, int idAgrupamento,
			String dsCompProduto, float comp, float larg, float quant,
			float valor, Date dtMod, String usuario, float pDesc, float vlUni) {
		super();
		this.idPedidoSaidaItem = idPedidoSaidaItem;
		this.idPedidoSaida = idPedidoSaida;
		this.idProduto = idProduto;
		this.idUnidade = idUnidade;
		this.idAgrupamento = idAgrupamento;
		this.dsCompProduto = dsCompProduto;
		this.comp = comp;
		this.larg = larg;
		this.quant = quant;
		this.valor = valor;
		this.dtMod = dtMod;
		this.usuario = usuario;
		this.pDesc = pDesc;
		this.vlUni = vlUni;
	}

	public PedidoSaidaSubItem(int idPedidoSaidaItem, int idPedidoSaida,
			int idProduto, int idUnidade, int idAgrupamento,
			String dsCompProduto, float comp, float larg, float quant,
			float valor, Date dtMod, String usuario, float pDesc, float vlUni,
			String impProducao) {
		
		this.idPedidoSaidaItem = idPedidoSaidaItem;
		this.idPedidoSaida = idPedidoSaida;
		this.idProduto = idProduto;
		this.idUnidade = idUnidade;
		this.idAgrupamento = idAgrupamento;
		this.dsCompProduto = dsCompProduto;
		this.comp = comp;
		this.larg = larg;
		this.quant = quant;
		this.valor = valor;
		this.dtMod = dtMod;
		this.usuario = usuario;
		this.pDesc = pDesc;
		this.vlUni = vlUni;
		this.impProducao = impProducao;
	}

	public String getImpProducao() {
		return impProducao;
	}

	public void setImpProducao(String impProducao) {
		this.impProducao = impProducao;
	}

	public int getIdPedidoSaidaItem() {
		return idPedidoSaidaItem;
	}

	public void setIdPedidoSaidaItem(int idPedidoSaidaItem) {
		this.idPedidoSaidaItem = idPedidoSaidaItem;
	}

	public int getIdPedidoSaida() {
		return idPedidoSaida;
	}

	public void setIdPedidoSaida(int idPedidoSaida) {
		this.idPedidoSaida = idPedidoSaida;
	}

	public int getIdProduto() {
		return idProduto;
	}

	public void setIdProduto(int idProduto) {
		this.idProduto = idProduto;
	}

	public int getIdUnidade() {
		return idUnidade;
	}

	public void setIdUnidade(int idUnidade) {
		this.idUnidade = idUnidade;
	}

	public int getIdAgrupamento() {
		return idAgrupamento;
	}

	public void setIdAgrupamento(int idAgrupamento) {
		this.idAgrupamento = idAgrupamento;
	}

	public String getDsCompProduto() {
		return dsCompProduto;
	}

	public void setDsCompProduto(String dsCompProduto) {
		this.dsCompProduto = dsCompProduto;
	}

	public float getComp() {
		return comp;
	}

	public void setComp(float comp) {
		this.comp = comp;
	}

	public float getLarg() {
		return larg;
	}

	public void setLarg(float larg) {
		this.larg = larg;
	}

	public float getQuant() {
		return quant;
	}

	public void setQuant(float quant) {
		this.quant = quant;
	}

	public float getValor() {
		return valor;
	}

	public void setValor(float valor) {
		this.valor = valor;
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

	public float getpDesc() {
		return pDesc;
	}

	public void setpDesc(float pDesc) {
		this.pDesc = pDesc;
	}

	public float getVlUni() {
		return vlUni;
	}

	public void setVlUni(float vlUni) {
		this.vlUni = vlUni;
	}
	public final float getVDesc() {
		double d = valor*pDesc;
		return (float) (Math.round(d)/100.0); 
	}
}
