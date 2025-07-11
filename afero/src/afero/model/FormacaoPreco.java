package afero.model;

import java.util.Date;


public class FormacaoPreco {
	
	private int idFormacaoPreco;
	private String dsFormacapPreco;
	private float pFrete;
	private float pIpi;
	private float pOutrasDespesas;
	private float pIcmsEntrada;
	private float pIcmsSaida;
	private float pCustoOperacional;
	private float pOutrosImpostos;
	private float pComissao;
	private float pLucro;
	private String status;
	private Date dtMod;
	private String usuario;
	
	
	
	public FormacaoPreco() {
		
	}



	public FormacaoPreco(int idFormacaoPreco, String dsFormacapPreco,
			float pFrete, float pIpi, float pOutrasDespesas,
			float pIcmsEntrada, float pIcmsSaida, float pCustoOperacional,
			float pOutrosImpostos, float pComissao, float pLucro,
			String status, Date dtMod, String usuario) {
		
		this.idFormacaoPreco = idFormacaoPreco;
		this.dsFormacapPreco = dsFormacapPreco;
		this.pFrete = pFrete;
		this.pIpi = pIpi;
		this.pOutrasDespesas = pOutrasDespesas;
		this.pIcmsEntrada = pIcmsEntrada;
		this.pIcmsSaida = pIcmsSaida;
		this.pCustoOperacional = pCustoOperacional;
		this.pOutrosImpostos = pOutrosImpostos;
		this.pComissao = pComissao;
		this.pLucro = pLucro;
		this.status = status;
		this.dtMod = dtMod;
		this.usuario = usuario;
	}



	public int getIdFormacaoPreco() {
		return idFormacaoPreco;
	}



	public void setIdFormacaoPreco(int idFormacaoPreco) {
		this.idFormacaoPreco = idFormacaoPreco;
	}



	public String getDsFormacapPreco() {
		return dsFormacapPreco;
	}



	public void setDsFormacapPreco(String dsFormacapPreco) {
		this.dsFormacapPreco = dsFormacapPreco;
	}



	public float getpFrete() {
		return pFrete;
	}



	public void setpFrete(float pFrete) {
		this.pFrete = pFrete;
	}



	public float getpIpi() {
		return pIpi;
	}



	public void setpIpi(float pIpi) {
		this.pIpi = pIpi;
	}



	public float getpOutrasDespesas() {
		return pOutrasDespesas;
	}



	public void setpOutrasDespesas(float pOutrasDespesas) {
		this.pOutrasDespesas = pOutrasDespesas;
	}



	public float getpIcmsEntrada() {
		return pIcmsEntrada;
	}



	public void setpIcmsEntrada(float pIcmsEntrada) {
		this.pIcmsEntrada = pIcmsEntrada;
	}



	public float getpIcmsSaida() {
		return pIcmsSaida;
	}



	public void setpIcmsSaida(float pIcmsSaida) {
		this.pIcmsSaida = pIcmsSaida;
	}



	public float getpCustoOperacional() {
		return pCustoOperacional;
	}



	public void setpCustoOperacional(float pCustoOperacional) {
		this.pCustoOperacional = pCustoOperacional;
	}



	public float getpOutrosImpostos() {
		return pOutrosImpostos;
	}



	public void setpOutrosImpostos(float pOutrosImpostos) {
		this.pOutrosImpostos = pOutrosImpostos;
	}



	public float getpComissao() {
		return pComissao;
	}



	public void setpComissao(float pComissao) {
		this.pComissao = pComissao;
	}



	public float getpLucro() {
		return pLucro;
	}



	public void setpLucro(float pLucro) {
		this.pLucro = pLucro;
	}



	public String getStatus() {
		return status;
	}



	public void setStatus(String status) {
		this.status = status;
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
