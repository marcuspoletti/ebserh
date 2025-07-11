package afero.model;

import java.util.Date;

public class ChegueRecebido {
	
	private int idChegueRecebido = 0;
	private int idLoja = 0;
	private int cdEntidade = 0;
	private int idBanco = 0;
	private String agencia = "";
	private String dvAgencia = "";
	private String contaCorrente = "";
	private String dvConta = "";
	private int nrChegue = 0;
	private double valor = 0;
	private Date dtEmissao = null;
	private Date dtVenc = null;
	private String correntista = "";
	private String cpfCnpj = "";
	private String destino = "";
	private String observacao = "";
	private Date dtReceb = null;
	private int idContaMovto = 0;
	private String status = "";
	private Date dtCad = null;
	private Date dtMod = null;
	private String usuario = "";
	
	
	public ChegueRecebido() {
		
		// TODO Auto-generated constructor stub
	}


	public ChegueRecebido(int idChegueRecebido, int idLoja, int cdEntidade, int idBanco,
			String agencia, String dvAgencia, String contaCorrente,
			String dvConta, int nrChegue, double valor, Date dtEmissao,
			Date dtVenc, String correntista, String cpfCnpj, String destino,
			String observacao, Date dtReceb, int idContaMovto,
			String status, Date dtCad, Date dtMod, String usuario) {
		
		this.idChegueRecebido = idChegueRecebido;
		this.idLoja = idLoja;
		this.cdEntidade = cdEntidade;
		this.idBanco = idBanco;
		this.agencia = agencia;
		this.dvAgencia = dvAgencia;
		this.contaCorrente = contaCorrente;
		this.dvConta = dvConta;
		this.nrChegue = nrChegue;
		this.valor = valor;
		this.dtEmissao = dtEmissao;
		this.dtVenc = dtVenc;
		this.correntista = correntista;
		this.cpfCnpj = cpfCnpj;
		this.destino = destino;
		this.observacao = observacao;
		this.dtReceb = dtReceb;
		this.idContaMovto = idContaMovto;
		this.status = status;
		this.dtCad = dtCad;
		this.dtMod = dtMod;
		this.usuario = usuario;
	}


	public int getIdChegueRecebido() {
		return idChegueRecebido;
	}


	public void setIdChegueRecebido(int idChegueRecebido) {
		this.idChegueRecebido = idChegueRecebido;
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


	public int getIdBanco() {
		return idBanco;
	}


	public void setIdBanco(int idBanco) {
		this.idBanco = idBanco;
	}


	public String getAgencia() {
		return agencia;
	}


	public void setAgencia(String agencia) {
		this.agencia = agencia;
	}


	public String getDvAgencia() {
		return dvAgencia;
	}


	public void setDvAgencia(String dvAgencia) {
		this.dvAgencia = dvAgencia;
	}


	public String getContaCorrente() {
		return contaCorrente;
	}


	public void setContaCorrente(String contaCorrente) {
		this.contaCorrente = contaCorrente;
	}


	public String getDvConta() {
		return dvConta;
	}


	public void setDvConta(String dvConta) {
		this.dvConta = dvConta;
	}


	public int getNrChegue() {
		return nrChegue;
	}


	public void setNrChegue(int nrChegue) {
		this.nrChegue = nrChegue;
	}


	public double getValor() {
		return valor;
	}


	public void setValor(double valor) {
		this.valor = valor;
	}


	public Date getDtEmissao() {
		return dtEmissao;
	}


	public void setDtEmissao(Date dtEmissao) {
		this.dtEmissao = dtEmissao;
	}


	public Date getDtVenc() {
		return dtVenc;
	}


	public void setDtVenc(Date dtVenc) {
		this.dtVenc = dtVenc;
	}


	public String getCorrentista() {
		return correntista;
	}


	public void setCorrentista(String correntista) {
		this.correntista = correntista;
	}


	public String getCpfCnpj() {
		return cpfCnpj;
	}


	public void setCpfCnpj(String cpfCnpj) {
		this.cpfCnpj = cpfCnpj;
	}


	public String getDestino() {
		return destino;
	}


	public void setDestino(String destino) {
		this.destino = destino;
	}


	public String getObservacao() {
		return observacao;
	}


	public void setObservacao(String observacao) {
		this.observacao = observacao;
	}


	public Date getDtReceb() {
		return dtReceb;
	}


	public void setDtReceb(Date dtReceb) {
		this.dtReceb = dtReceb;
	}


	public int getIdContaMovto() {
		return idContaMovto;
	}


	public void setIdContaMovto(int idContaMovto) {
		this.idContaMovto = idContaMovto;
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
