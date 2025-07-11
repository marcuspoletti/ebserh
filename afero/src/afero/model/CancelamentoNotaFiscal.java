package afero.model;

import java.util.Date;

public class CancelamentoNotaFiscal {
	
	private Integer idRetornoNotaFiscalCanc;
	private Integer idRetornoNotaFiscal;
	private Integer idPedidoSaida;
	private String mensagemRetorno;
	private String justificativa;
	private Date dtRegistro;
	private String usuario;
	
	
	
	public CancelamentoNotaFiscal(Integer idRetornoNotaFiscalCanc,
			Integer idRetornoNotaFiscal, Integer idPedidoSaida,
			String mensagemRetorno, Date dtRegistro, String usuario) {
		super();
		this.idRetornoNotaFiscalCanc = idRetornoNotaFiscalCanc;
		this.idRetornoNotaFiscal = idRetornoNotaFiscal;
		this.idPedidoSaida = idPedidoSaida;
		this.mensagemRetorno = mensagemRetorno;
		this.dtRegistro = dtRegistro;
		this.usuario = usuario;
	}
	
	
	public CancelamentoNotaFiscal() {
		super();
		// TODO Auto-generated constructor stub
	}


	public CancelamentoNotaFiscal(Integer idRetornoNotaFiscalCanc,
			Integer idRetornoNotaFiscal, Integer idPedidoSaida,
			String mensagemRetorno, String justificativa, Date dtRegistro,
			String usuario) {
		super();
		this.idRetornoNotaFiscalCanc = idRetornoNotaFiscalCanc;
		this.idRetornoNotaFiscal = idRetornoNotaFiscal;
		this.idPedidoSaida = idPedidoSaida;
		this.mensagemRetorno = mensagemRetorno;
		this.justificativa = justificativa;
		this.dtRegistro = dtRegistro;
		this.usuario = usuario;
	}


	public String getJustificativa() {
		return justificativa;
	}


	public void setJustificativa(String justificativa) {
		this.justificativa = justificativa;
	}


	public Integer getIdRetornoNotaFiscalCanc() {
		return idRetornoNotaFiscalCanc;
	}
	public void setIdRetornoNotaFiscalCanc(Integer idRetornoNotaFiscalCanc) {
		this.idRetornoNotaFiscalCanc = idRetornoNotaFiscalCanc;
	}
	public Integer getIdRetornoNotaFiscal() {
		return idRetornoNotaFiscal;
	}
	public void setIdRetornoNotaFiscal(Integer idRetornoNotaFiscal) {
		this.idRetornoNotaFiscal = idRetornoNotaFiscal;
	}
	public Integer getIdPedidoSaida() {
		return idPedidoSaida;
	}
	public void setIdPedidoSaida(Integer idPedidoSaida) {
		this.idPedidoSaida = idPedidoSaida;
	}
	public String getMensagemRetorno() {
		return mensagemRetorno;
	}
	public void setMensagemRetorno(String mensagemRetorno) {
		this.mensagemRetorno = mensagemRetorno;
	}
	public Date getDtRegistro() {
		return dtRegistro;
	}
	public void setDtRegistro(Date dtRegistro) {
		this.dtRegistro = dtRegistro;
	}
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}

	
	
	
	
	
	
}
