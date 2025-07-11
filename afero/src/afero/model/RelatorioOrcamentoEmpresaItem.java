package afero.model;

public class RelatorioOrcamentoEmpresaItem {

	private String dc = "";
	private double valor = 0;
	private int ano = 0;

	public RelatorioOrcamentoEmpresaItem() {
	}

	public RelatorioOrcamentoEmpresaItem(String dc, double valor, int ano) {
		this.dc = dc;
		this.valor = valor;
		this.ano = ano;
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

	public int getAno() {
		return ano;
	}

	public void setAno(int ano) {
		this.ano = ano;
	}

}
