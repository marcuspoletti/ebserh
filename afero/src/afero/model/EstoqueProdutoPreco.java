package afero.model;

import java.util.Date;

public class EstoqueProdutoPreco {
	
	//Produto
	
	private int idProduto = 0;
	private int idDivisao = 0;
	private int idSubGrupo = 0;
	private int idGrupo = 0;
	private String nmProduto = "";
	private String dsProduto = "";
	private String tipoProduto = "";
	private Date dtCad;
	private Date dtMod;
	private String cdBarra = "";
	
	//Estoque
	
	private int idEstoque;
	private int idLoja;
	private double qtEstoque;
	private double qtMinimo;
	private double qtMaximo;

	
	//Preço
	
	private int idPreco;
	
	
	//
	private String apelidoLoja;
	private String dsUnidade;
	
	public EstoqueProdutoPreco() {
		
		// TODO Auto-generated constructor stub
	}

	
	public EstoqueProdutoPreco(int idProduto, int idDivisao, int idSubGrupo,
			int idGrupo, String nmProduto, String dsProduto,
			String tipoProduto, Date dtCad, Date dtMod, String cdBarra,
			int idEstoque, int idLoja, double qtEstoque, double qtMinimo,
			double qtMaximo, int idPreco, int idUnidade, Date dtInicioPreco,
			Date dtFimPreco, float preco, String usuario, String status, String apelidoLoja, String dsUnidade) {
		
		this.idProduto = idProduto;
		this.idDivisao = idDivisao;
		this.idSubGrupo = idSubGrupo;
		this.idGrupo = idGrupo;
		this.nmProduto = nmProduto;
		this.dsProduto = dsProduto;
		this.tipoProduto = tipoProduto;
		this.dtCad = dtCad;
		this.dtMod = dtMod;
		this.cdBarra = cdBarra;
		this.idEstoque = idEstoque;
		this.idLoja = idLoja;
		this.qtEstoque = qtEstoque;
		this.qtMinimo = qtMinimo;
		this.qtMaximo = qtMaximo;
		this.idPreco = idPreco;
		this.idUnidade = idUnidade;
		this.dtInicioPreco = dtInicioPreco;
		this.dtFimPreco = dtFimPreco;
		this.preco = preco;
		this.usuario = usuario;
		this.status = status;
		this.apelidoLoja = apelidoLoja;
		this.dsUnidade = dsUnidade;
	}


	public String getApelidoLoja() {
		return apelidoLoja;
	}


	public void setApelidoLoja(String apelidoLoja) {
		this.apelidoLoja = apelidoLoja;
	}


	public String getDsUnidade() {
		return dsUnidade;
	}


	public void setDsUnidade(String dsUnidade) {
		this.dsUnidade = dsUnidade;
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

	public String getCdBarra() {
		return cdBarra;
	}

	public void setCdBarra(String cdBarra) {
		this.cdBarra = cdBarra;
	}

	public int getIdEstoque() {
		return idEstoque;
	}

	public void setIdEstoque(int idEstoque) {
		this.idEstoque = idEstoque;
	}

	public int getIdLoja() {
		return idLoja;
	}

	public void setIdLoja(int idLoja) {
		this.idLoja = idLoja;
	}

	public double getQtEstoque() {
		return qtEstoque;
	}

	public void setQtEstoque(double qtEstoque) {
		this.qtEstoque = qtEstoque;
	}

	public double getQtMinimo() {
		return qtMinimo;
	}

	public void setQtMinimo(double qtMinimo) {
		this.qtMinimo = qtMinimo;
	}

	public double getQtMaximo() {
		return qtMaximo;
	}

	public void setQtMaximo(double qtMaximo) {
		this.qtMaximo = qtMaximo;
	}

	
	public int getIdPreco() {
		return idPreco;
	}

	public void setIdPreco(int idPreco) {
		this.idPreco = idPreco;
	}

	public int getIdUnidade() {
		return idUnidade;
	}

	public void setIdUnidade(int idUnidade) {
		this.idUnidade = idUnidade;
	}

	public Date getDtInicioPreco() {
		return dtInicioPreco;
	}

	public void setDtInicioPreco(Date dtInicioPreco) {
		this.dtInicioPreco = dtInicioPreco;
	}

	public Date getDtFimPreco() {
		return dtFimPreco;
	}

	public void setDtFimPreco(Date dtFimPreco) {
		this.dtFimPreco = dtFimPreco;
	}

	public float getPreco() {
		return preco;
	}

	public void setPreco(float preco) {
		this.preco = preco;
	}

	public String getUsuario() {
		return usuario;
	}

	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	private int idUnidade;
	private Date dtInicioPreco;
	private Date dtFimPreco;
	private float preco;
	
	
	//Usuario do Cadastro de Produto
	private String usuario;
	
	//Status do Estoque
	
	private String status;
	

}
