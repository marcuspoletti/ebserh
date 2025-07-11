package afero.model;

import java.util.Date;

public class PedidoSaidaItem {

	private int idPedidoSaidaItem;
	private int idPedidoSaida;
	private int idProduto;
	private int idUnidade;
	private float quant;
	private float valor;
	private Date dtMod;
	private String usuario;
	private float pDesc;
	private float vlUni;
	private String dsCompProduto;

	public PedidoSaidaItem() {
	}

	public PedidoSaidaItem(int idPedidoSaidaItem, int idPedidoSaida,
			int idProduto, int idUnidade, float quant, float valor, Date dtMod,
			String usuario, float pDesc, float vlUni) {
		this.idPedidoSaidaItem = idPedidoSaidaItem;
		this.idPedidoSaida = idPedidoSaida;
		this.idProduto = idProduto;
		this.idUnidade = idUnidade;
		this.quant = quant;
		this.valor = valor;
		this.dtMod = dtMod;
		this.usuario = usuario;
		this.pDesc = pDesc;
		this.vlUni = vlUni;
	}

	public PedidoSaidaItem(int idPedidoSaidaItem, int idPedidoSaida,
			int idProduto, int idUnidade, float quant, float valor, Date dtMod,
			String usuario, float pDesc, float vlUni, String dsCompProduto) {
		this.idPedidoSaidaItem = idPedidoSaidaItem;
		this.idPedidoSaida = idPedidoSaida;
		this.idProduto = idProduto;
		this.idUnidade = idUnidade;
		this.quant = quant;
		this.valor = valor;
		this.dtMod = dtMod;
		this.usuario = usuario;
		this.pDesc = pDesc;
		this.vlUni = vlUni;
		this.dsCompProduto = dsCompProduto;
	}

	public float getpDesc() {
		return pDesc;
	}

	public void setpDesc(float pDesc) {
		this.pDesc = pDesc;
	}

	public String getDsCompProduto() {
		return dsCompProduto;
	}

	public void setDsCompProduto(String dsCompProduto) {
		this.dsCompProduto = dsCompProduto;
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

	public final float getPDesc() {
		return pDesc;
	}

	public final void setPDesc(float desc) {
		pDesc = desc;
	}

	public final float getVlUni() {
		return vlUni;
	}

	public final void setVlUni(float vlUni) {
		this.vlUni = vlUni;
	}
	
	public final float getVDesc() {
		double d = (this.valor);
		double v = (this.pDesc / 100);
		return (float) (d*v);//(Math.round(d)/100.0); 
	}
	
	public final float getVlTot() {
		return quant*vlUni; 
	}
//	public final float calcularDesc(){
//		float valorDescUnit = (this.quant * this.valor);
//		return (float)valorDescUnit
//	}
	
}
