package afero.model;

public class RelatorioAglutinados {

   Integer idProduto = 0;
   String dsProduto = "";
   float quant = 0;
   String cdProduto = "";
   String cdBarra = "";
   String status = "";
   
   
   
public RelatorioAglutinados() {
	super();
	// TODO Auto-generated constructor stub
}



public RelatorioAglutinados(Integer idProduto, String dsProduto, float quant,
		String cdProduto, String cdBarra, String status) {
	super();
	this.idProduto = idProduto;
	this.dsProduto = dsProduto;
	this.quant = quant;
	this.cdProduto = cdProduto;
	this.cdBarra = cdBarra;
	this.status = status;
}



public Integer getIdProduto() {
	return idProduto;
}



public void setIdProduto(Integer idProduto) {
	this.idProduto = idProduto;
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



public String getCdProduto() {
	return cdProduto;
}



public void setCdProduto(String cdProduto) {
	this.cdProduto = cdProduto;
}



public String getCdBarra() {
	return cdBarra;
}



public void setCdBarra(String cdBarra) {
	this.cdBarra = cdBarra;
}



public String getStatus() {
	return status;
}



public void setStatus(String status) {
	this.status = status;
}
   
   

}
