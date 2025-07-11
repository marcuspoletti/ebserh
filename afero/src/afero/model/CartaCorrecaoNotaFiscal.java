package afero.model;

import java.util.Date;

public class CartaCorrecaoNotaFiscal {
	
	
	private Integer referencia = 0;
	private String correcao   =  "";
	private String codNota    = "";
	private String numeroSequencialEvento ="";
	private String justificativa = "";
	private Integer idRetornoNotaFiscal = 0;
	private String usuario = "";
	private Date dtRegistro ;
	private Integer idNotaFiscalCorrecao = 0;
	private String mensagemRetorno = "";
	
	
	
	public Integer getIdRetornoNotaFiscal() {
		return idRetornoNotaFiscal;
	}

	public void setIdRetornoNotaFiscal(Integer idRetornoNotaFiscal) {
		this.idRetornoNotaFiscal = idRetornoNotaFiscal;
	}

	public Integer getIdNotaFiscalCorrecao() {
		return idNotaFiscalCorrecao;
	}

	public void setIdNotaFiscalCorrecao(Integer idNotaFiscalCorrecao) {
		this.idNotaFiscalCorrecao = idNotaFiscalCorrecao;
	}

	public String getMensagemRetorno() {
		return mensagemRetorno;
	}

	public void setMensagemRetorno(String mensagemRetorno) {
		this.mensagemRetorno = mensagemRetorno;
	}

	public CartaCorrecaoNotaFiscal(Integer referencia, String correcao,
			String codNota, String numeroSequencialEvento) {
		super();
		this.referencia = referencia;
		this.correcao = correcao;
		this.codNota = codNota;
		this.numeroSequencialEvento = numeroSequencialEvento;
		
	}
	
	public CartaCorrecaoNotaFiscal(Integer idNotaFiscalCorrecao, Integer idRetornoNotaFiscal,
			Integer idPedidoSaida, String justificativa, String mensagemRetorno, Date dtRegistro, String usuario){
		this.idNotaFiscalCorrecao = idNotaFiscalCorrecao;
		this.idRetornoNotaFiscal = idRetornoNotaFiscal;
		this.referencia = idPedidoSaida;
		this.justificativa = justificativa;
		this.mensagemRetorno = mensagemRetorno;
		this.dtRegistro = dtRegistro;
		this.usuario = usuario;
	}
	
	public CartaCorrecaoNotaFiscal(Integer referencia, String correcao,
			String codNota, String numeroSequencialEvento, String justificativa) {
		super();
		this.referencia = referencia;
		this.correcao = correcao;
		this.codNota = codNota;
		this.numeroSequencialEvento = numeroSequencialEvento;
		this.justificativa = justificativa;
	}


	public CartaCorrecaoNotaFiscal(Integer referencia, String correcao,
			String codNota, String numeroSequencialEvento,
			String justificativa, Integer idRetornoNotaFiscal) {
		super();
		this.referencia = referencia;
		this.correcao = correcao;
		this.codNota = codNota;
		this.numeroSequencialEvento = numeroSequencialEvento;
		this.justificativa = justificativa;
		this.idRetornoNotaFiscal = idRetornoNotaFiscal;
	}


	public CartaCorrecaoNotaFiscal(Integer referencia, String correcao,
			String codNota, String numeroSequencialEvento,
			String justificativa, Integer idRetornoNotaFiscal, String usuario,
			Date dtRegistro, Integer idNotaFiscalCorrecao,
			String mensagemRetorno) {
		super();
		this.referencia = referencia;
		this.correcao = correcao;
		this.codNota = codNota;
		this.numeroSequencialEvento = numeroSequencialEvento;
		this.justificativa = justificativa;
		this.idRetornoNotaFiscal = idRetornoNotaFiscal;
		this.usuario = usuario;
		this.dtRegistro = dtRegistro;
		this.idNotaFiscalCorrecao = idNotaFiscalCorrecao;
		this.mensagemRetorno = mensagemRetorno;
	}

	


	public Date getDtRegistro() {
		return dtRegistro;
	}

	public void setDtRegistro(Date dtRegistro) {
		this.dtRegistro = dtRegistro;
	}

	public CartaCorrecaoNotaFiscal(Integer referencia, String correcao,
			String codNota, String numeroSequencialEvento,
			String justificativa, Integer idRetornoNotaFiscal, String usuario) {
		super();
		this.referencia = referencia;
		this.correcao = correcao;
		this.codNota = codNota;
		this.numeroSequencialEvento = numeroSequencialEvento;
		this.justificativa = justificativa;
		this.idRetornoNotaFiscal = idRetornoNotaFiscal;
		this.usuario = usuario;
	}


	public String getUsuario() {
		return usuario;
	}


	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}


	


	public CartaCorrecaoNotaFiscal() {
		super();
		// TODO Auto-generated constructor stub
	}

	public String getJustificativa() {
		return justificativa;
	}

	public void setJustificativa(String justificativa) {
		this.justificativa = justificativa;
	}

	public Integer getReferencia() {
		return referencia;
	}
	public void setReferencia(Integer referencia) {
		this.referencia = referencia;
	}
	public String getCorrecao() {
		return correcao;
	}
	public void setCorrecao(String correcao) {
		this.correcao = correcao;
	}
	public String getCodNota() {
		return codNota;
	}
	public void setCodNota(String codNota) {
		this.codNota = codNota;
	}
	public String getNumeroSequencialEvento() {
		return numeroSequencialEvento;
	}
	public void setNumeroSequencialEvento(String numeroSequencialEvento) {
		this.numeroSequencialEvento = numeroSequencialEvento;
	}
	
	

}
