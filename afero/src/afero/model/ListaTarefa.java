package afero.model;

import java.util.Date;

public class ListaTarefa {
	
	private int idListaTarefa;
	private int idLoja;
	private String dsListaTarefa;
	private float preco;
	private int idUnidade;
	private String status;
	private Date dtCad;
	private Date dtMod;
	private String usuario;

	public ListaTarefa() {
	}
	
	public ListaTarefa(int idListaTarefa, int idLoja, String dsListaTarefa,
			float preco, int idUnidade, String status, Date dtCad2, Date dtMod2,
			String usuario) {
		super();
		this.idListaTarefa = idListaTarefa;
		this.idLoja = idLoja;
		this.dsListaTarefa = dsListaTarefa;
		this.preco = preco;
		this.idUnidade = idUnidade;
		this.status = status;
		this.dtCad = dtCad2;
		this.dtMod = dtMod2;
		this.usuario = usuario;
	}

	public int getIdListaTarefa() {
		return idListaTarefa;
	}

	public void setIdListaTarefa(int idListaTarefa) {
		this.idListaTarefa = idListaTarefa;
	}

	public int getIdLoja() {
		return idLoja;
	}

	public void setIdLoja(int idLoja) {
		this.idLoja = idLoja;
	}

	public String getDsListaTarefa() {
		return dsListaTarefa;
	}

	public void setDsListaTarefa(String dsListaTarefa) {
		this.dsListaTarefa = dsListaTarefa;
	}

	public float getPreco() {
		return preco;
	}

	public void setPreco(float preco) {
		this.preco = preco;
	}

	public int getIdUnidade() {
		return idUnidade;
	}

	public void setIdUnidade(int idUnidade) {
		this.idUnidade = idUnidade;
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
	
	
}
