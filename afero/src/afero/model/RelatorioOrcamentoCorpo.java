package afero.model;

public class RelatorioOrcamentoCorpo {
	
	String dsProduto = "";
	float quant = 0;
	float pDesc = 0;
	float vlUni = 0;
	float valor = 0;
	String dsUnidade = "";
	
	
	public RelatorioOrcamentoCorpo() {
		
	}
	public RelatorioOrcamentoCorpo(String dsProduto, float quant, float pDesc,
			float vlUni, float valor, String dsUnidade) {
		
		this.dsProduto = dsProduto;
		this.quant = quant;
		this.pDesc = pDesc;
		this.vlUni = vlUni;
		this.valor = valor;
		this.dsUnidade = dsUnidade;
	}
	public String getDsProduto() {
		return dsProduto;
	}
	public void setDsProduto(String dsProduto) {
		this.dsProduto = dsProduto;
	}
	public float getQuant() {
		return quant;
	}
	public void setQuant(float quant) {
		this.quant = quant;
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
	public float getValor() {
		return valor;
	}
	public void setValor(float valor) {
		this.valor = valor;
	}
	public String getDsUnidade() {
		return dsUnidade;
	}
	public void setDsUnidade(String dsUnidade) {
		this.dsUnidade = dsUnidade;
	}
	
	
	 

}
