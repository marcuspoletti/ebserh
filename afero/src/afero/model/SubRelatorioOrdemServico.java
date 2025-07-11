package afero.model;

public class SubRelatorioOrdemServico {
	
	private String dsCompServico = "";
	private float quant = 0;
	private float desconto = 0;
	private float vlUni = 0;
	private float valor = 0;
	private String dsServico = "";
	private Integer codigo = 0;
	
	public SubRelatorioOrdemServico() {
		
	}
	
	public SubRelatorioOrdemServico(String dsCompServico, float quant,
			float desconto, float vlUni, float valor, String dsServico,
			Integer codigo) {
	
		this.dsCompServico = dsCompServico;
		this.quant = quant;
		this.desconto = desconto;
		this.vlUni = vlUni;
		this.valor = valor;
		this.dsServico = dsServico;
		this.codigo = codigo;
	}

	public float getDesconto() {
		return desconto;
	}

	public void setDesconto(float desconto) {
		this.desconto = desconto;
	}

	public String getDsCompServico() {
		return dsCompServico;
	}
	public void setDsCompServico(String dsCompServico) {
		this.dsCompServico = dsCompServico;
	}
	public float getQuant() {
		return quant;
	}
	public void setQuant(float quant) {
		this.quant = quant;
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
	public String getDsServico() {
		return dsServico;
	}
	public void setDsServico(String dsServico) {
		this.dsServico = dsServico;
	}
	public Integer getCodigo() {
		return codigo;
	}
	public void setCodigo(Integer codigo) {
		this.codigo = codigo;
	}
	
	

}
