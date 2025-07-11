package afero.model;

import java.util.Date;

public class Orcamento {

	private int idOrcamento;
	private int idLoja;
	private int cdEntidade;
	private int idEntrega;
	private int idColaborador;
	private Date dtOrc;
	private double vlOrc;
	private int prazoValidade;
	private String observacao;
	private String status;
	private double vlAprov;
	private Date dtAprov;
	private Date dtMod;
	private String usuario;
	private Date dtEntrega;
	private String hrEntrega;
	private String pessoaResponsavel;
	private float vlDesc;

	public Orcamento() {
	}

	public Orcamento(int idOrcamento, int idLoja, int cdEntidade,
			int idEntrega, int idColaborador, Date dtOrc, double vlOrc,
			int prazoValidade, String observacao, String status,
			double vlAprov, Date dtAprov, Date dtMod, String usuario,
			Date dtEntrega, String pessoaResponsavel) {
		this.idOrcamento = idOrcamento;
		this.idLoja = idLoja;
		this.cdEntidade = cdEntidade;
		this.idEntrega = idEntrega;
		this.idColaborador = idColaborador;
		this.dtOrc = dtOrc;
		this.vlOrc = vlOrc;
		this.prazoValidade = prazoValidade;
		this.observacao = observacao;
		this.status = status;
		this.vlAprov = vlAprov;
		this.dtAprov = dtAprov;
		this.dtMod = dtMod;
		this.usuario = usuario;
		this.dtEntrega = dtEntrega;
		this.pessoaResponsavel = pessoaResponsavel;
	}
	
	public Orcamento(int idOrcamento, int idLoja, int cdEntidade,
			int idEntrega, int idColaborador, Date dtOrc, double vlOrc,
			int prazoValidade, String observacao, String status,
			double vlAprov, Date dtAprov, Date dtMod, String usuario,
			Date dtEntrega, String pessoaResponsavel, float vlDesc) {
		this.idOrcamento = idOrcamento;
		this.idLoja = idLoja;
		this.cdEntidade = cdEntidade;
		this.idEntrega = idEntrega;
		this.idColaborador = idColaborador;
		this.dtOrc = dtOrc;
		this.vlOrc = vlOrc;
		this.prazoValidade = prazoValidade;
		this.observacao = observacao;
		this.status = status;
		this.vlAprov = vlAprov;
		this.dtAprov = dtAprov;
		this.dtMod = dtMod;
		this.usuario = usuario;
		this.dtEntrega = dtEntrega;
		this.pessoaResponsavel = pessoaResponsavel;
		this.vlDesc = vlDesc;
	}

	public Orcamento(int idOrcamento, int idLoja, int cdEntidade,
			int idEntrega, int idColaborador, Date dtOrc, double vlOrc,
			int prazoValidade, String observacao, String status,
			double vlAprov, Date dtAprov, Date dtMod, String usuario,
			Date dtEntrega, String hrEntrega, String pessoaResponsavel,
			float vlDesc) {
		
		this.idOrcamento = idOrcamento;
		this.idLoja = idLoja;
		this.cdEntidade = cdEntidade;
		this.idEntrega = idEntrega;
		this.idColaborador = idColaborador;
		this.dtOrc = dtOrc;
		this.vlOrc = vlOrc;
		this.prazoValidade = prazoValidade;
		this.observacao = observacao;
		this.status = status;
		this.vlAprov = vlAprov;
		this.dtAprov = dtAprov;
		this.dtMod = dtMod;
		this.usuario = usuario;
		this.dtEntrega = dtEntrega;
		this.hrEntrega = hrEntrega;
		this.pessoaResponsavel = pessoaResponsavel;
		this.vlDesc = vlDesc;
	}

	public int getIdOrcamento() {
		return idOrcamento;
	}

	public void setIdOrcamento(int idOrcamento) {
		this.idOrcamento = idOrcamento;
	}

	public int getIdLoja() {
		return idLoja;
	}

	public void setIdLoja(int idLoja) {
		this.idLoja = idLoja;
	}

	public int getCdEntidade() {
		return cdEntidade;
	}

	public void setCdEntidade(int cdEntidade) {
		this.cdEntidade = cdEntidade;
	}

	public int getIdEntrega() {
		return idEntrega;
	}

	public void setIdEntrega(int idEntrega) {
		this.idEntrega = idEntrega;
	}

	public int getIdColaborador() {
		return idColaborador;
	}

	public void setIdColaborador(int idColaborador) {
		this.idColaborador = idColaborador;
	}

	public Date getDtOrc() {
		return dtOrc;
	}

	public void setDtOrc(Date dtOrc) {
		this.dtOrc = dtOrc;
	}

	public String getObservacao() {
		return observacao;
	}

	public void setObservacao(String observacao) {
		this.observacao = observacao;
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

	public double getVlOrc() {
		return vlOrc;
	}

	public void setVlOrc(double vlOrc) {
		this.vlOrc = vlOrc;
	}

	public int getPrazoValidade() {
		return prazoValidade;
	}

	public void setPrazoValidade(int prazoValidade) {
		this.prazoValidade = prazoValidade;
	}

	public double getVlAprov() {
		return vlAprov;
	}

	public void setVlAprov(double vlAprov) {
		this.vlAprov = vlAprov;
	}

	public Date getDtAprov() {
		return dtAprov;
	}

	public void setDtAprov(Date dtAprov) {
		this.dtAprov = dtAprov;
	}

	public Date getDtEntrega() {
		return dtEntrega;
	}

	public void setDtEntrega(Date dtEntrega) {
		this.dtEntrega = dtEntrega;
	}

	public final String getPessoaResponsavel() {
		return pessoaResponsavel;
	}

	public final void setPessoaResponsavel(String pessoaResponsavel) {
		this.pessoaResponsavel = pessoaResponsavel;
	}

	public float getVlDesc() {
		return vlDesc;
	}

	public void setVlDesc(float vlDesc) {
		this.vlDesc = vlDesc;
	}

	public String getHrEntrega() {
		return hrEntrega;
	}

	public void setHrEntrega(String hrEntrega) {
		this.hrEntrega = hrEntrega;
	}

}
