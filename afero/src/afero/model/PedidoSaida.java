package afero.model;

import java.util.Date;

public class PedidoSaida {

	private int idPedidoSaida;
	private int idLoja;
	private int cdEntidade;
	private int idColaborador;
	private int idEntrega;
	private String operacao;
	private Date dtPed;
	private double vlPed;
	private String observacao;
	private String anotacao;
	private String status;
	private Date dtMod;
	private String usuario;
	private Date dtEntrega;
	private String hrEntrega;
	private Date dtMov;
	private String pessoaResponsavel;
	private float vlDesc;	
	private String statusPag;
	private String tipoPedido;
	private int cdCondPagto;
	private Date dtPed2 = null;
	
	//Motorista
	//Entregador
	private int idMotorista = 0;
	private int idEntregador = 0;
	private Integer idVendedor = 0;
	
	
	public PedidoSaida(int idPedidoSaida, int idLoja, int cdEntidade,
			int idColaborador, int idEntrega, String operacao, Date dtPed,
			double vlPed, String observacao, String anotacao, String status, Date dtMod, String usuario, 
			Date dtEntrega, String hrEntrega, Date dtMov, String pessoaResponsavel, float vlDesc, int cdCondPagto){
		
		this.idPedidoSaida = idPedidoSaida;
		this.idLoja = idLoja;
		this.cdEntidade = cdEntidade;
		this.idColaborador = idColaborador;
		this.idEntrega  = idEntrega;
		this.operacao = operacao;
		this.dtPed = dtPed;
		this.vlPed = vlPed;
		this.observacao = observacao;
		this.anotacao = anotacao;
		this.status = status;
		this.dtMod = dtMod;
		this.usuario = usuario;
		this.dtEntrega = dtEntrega;
		this.hrEntrega = hrEntrega;
		this.dtMov = dtMov;
		this.pessoaResponsavel = pessoaResponsavel;
		this.vlDesc = vlDesc;
		this.cdCondPagto = cdCondPagto;
		
		
		
	}
	public PedidoSaida(int idPedidoSaida, int idLoja, int cdEntidade,
			int idColaborador, int idEntrega, String operacao, Date dtPed,
			double vlPed, String observacao, String anotacao, String status, Date dtMod, String usuario, 
			Date dtEntrega, String hrEntrega, Date dtMov, String pessoaResponsavel, float vlDesc, int cdCondPagto, String tipoPedido){
		
		this.idPedidoSaida = idPedidoSaida;
		this.idLoja = idLoja;
		this.cdEntidade = cdEntidade;
		this.idColaborador = idColaborador;
		this.idEntrega  = idEntrega;
		this.operacao = operacao;
		this.dtPed = dtPed;
		this.vlPed = vlPed;
		this.observacao = observacao;
		this.anotacao = anotacao;
		this.status = status;
		this.dtMod = dtMod;
		this.usuario = usuario;
		this.dtEntrega = dtEntrega;
		this.hrEntrega = hrEntrega;
		this.dtMov = dtMov;
		this.pessoaResponsavel = pessoaResponsavel;
		this.vlDesc = vlDesc;
		this.cdCondPagto = cdCondPagto;
		this.tipoPedido = tipoPedido;
		
		
		
	}
	public PedidoSaida(int idPedidoSaida, int idLoja, int cdEntidade,
			int idColaborador, int idEntrega, String operacao, Date dtPed,
			double vlPed, String observacao, String anotacao, String status,
			Date dtMod, String usuario, Date dtEntrega, String hrEntrega,
			Date dtMov, String pessoaResponsavel) {
		this.idPedidoSaida = idPedidoSaida;
		this.idLoja = idLoja;
		this.cdEntidade = cdEntidade;
		this.idColaborador = idColaborador;
		this.idEntrega = idEntrega;
		this.operacao = operacao;
		this.dtPed = dtPed;
		this.vlPed = vlPed;
		this.observacao = observacao;
		this.anotacao = anotacao;
		this.status = status;
		this.dtMod = dtMod;
		this.usuario = usuario;
		this.dtEntrega = dtEntrega;
		this.hrEntrega = hrEntrega;
		this.dtMov = dtMov;
		this.pessoaResponsavel = pessoaResponsavel;
	}
	public PedidoSaida(int idPedidoSaida, int idLoja, int cdEntidade,
			int idColaborador, int idEntrega, String operacao, Date dtPed,
			double vlPed, String observacao, String anotacao, String status,
			Date dtMod, String usuario, Date dtEntrega, String hrEntrega,
			Date dtMov, String pessoaResponsavel, int cdCondPagto) {
		this.idPedidoSaida = idPedidoSaida;
		this.idLoja = idLoja;
		this.cdEntidade = cdEntidade;
		this.idColaborador = idColaborador;
		this.idEntrega = idEntrega;
		this.operacao = operacao;
		this.dtPed = dtPed;
		this.vlPed = vlPed;
		this.observacao = observacao;
		this.anotacao = anotacao;
		this.status = status;
		this.dtMod = dtMod;
		this.usuario = usuario;
		this.dtEntrega = dtEntrega;
		this.hrEntrega = hrEntrega;
		this.dtMov = dtMov;
		this.pessoaResponsavel = pessoaResponsavel;
		this.cdCondPagto = cdCondPagto;
	}
	public PedidoSaida(int idPedidoSaida, int idLoja, int cdEntidade,
			int idColaborador, int idEntrega, String operacao, Date dtPed,
			double vlPed, String observacao, String anotacao, String status,
			Date dtMod, String usuario, Date dtEntrega, String hrEntrega,
			Date dtMov, String pessoaResponsavel, int cdCondPagto, String tipoPedido) {
		this.idPedidoSaida = idPedidoSaida;
		this.idLoja = idLoja;
		this.cdEntidade = cdEntidade;
		this.idColaborador = idColaborador;
		this.idEntrega = idEntrega;
		this.operacao = operacao;
		this.dtPed = dtPed;
		this.vlPed = vlPed;
		this.observacao = observacao;
		this.anotacao = anotacao;
		this.status = status;
		this.dtMod = dtMod;
		this.usuario = usuario;
		this.dtEntrega = dtEntrega;
		this.hrEntrega = hrEntrega;
		this.dtMov = dtMov;
		this.pessoaResponsavel = pessoaResponsavel;
		this.cdCondPagto = cdCondPagto;
		this.tipoPedido = tipoPedido;
	}
	public PedidoSaida(int idPedidoSaida, int idLoja, int cdEntidade,
			int idColaborador, int idEntrega, String operacao, Date dtPed,
			double vlPed, String observacao, String anotacao, String status,
			Date dtMod, String usuario, Date dtEntrega, String hrEntrega,
			Date dtMov, String pessoaResponsavel, float vlDesc) {
		this.idPedidoSaida = idPedidoSaida;
		this.idLoja = idLoja;
		this.cdEntidade = cdEntidade;
		this.idColaborador = idColaborador;
		this.idEntrega = idEntrega;
		this.operacao = operacao;
		this.dtPed = dtPed;
		this.vlPed = vlPed;
		this.observacao = observacao;
		this.anotacao = anotacao;
		this.status = status;
		this.dtMod = dtMod;
		this.usuario = usuario;
		this.dtEntrega = dtEntrega;
		this.hrEntrega = hrEntrega;
		this.dtMov = dtMov;
		this.pessoaResponsavel = pessoaResponsavel;
		this.vlDesc = vlDesc;
	}
	public PedidoSaida(int idPedidoSaida, int idLoja, int cdEntidade,
			int idColaborador, int idEntrega, String operacao, Date dtPed,
			double vlPed, String observacao, String anotacao, String status,
			Date dtMod, String usuario, Date dtEntrega, String hrEntrega,
			Date dtMov, String pessoaResponsavel, String statusPag, String tipoPedido) {
		this.idPedidoSaida = idPedidoSaida;
		this.idLoja = idLoja;
		this.cdEntidade = cdEntidade;
		this.idColaborador = idColaborador;
		this.idEntrega = idEntrega;
		this.operacao = operacao;
		this.dtPed = dtPed;
		this.vlPed = vlPed;
		this.observacao = observacao;
		this.anotacao = anotacao;
		this.status = status;
		this.dtMod = dtMod;
		this.usuario = usuario;
		this.dtEntrega = dtEntrega;
		this.hrEntrega = hrEntrega;
		this.dtMov = dtMov;
		this.pessoaResponsavel = pessoaResponsavel;
		this.statusPag = statusPag;
		this.tipoPedido = tipoPedido;
	}
	public PedidoSaida(int idPedidoSaida, int idLoja, int cdEntidade,
			int idColaborador, int idEntrega, String operacao, Date dtPed,
			double vlPed, String observacao, String anotacao, String status,
			Date dtMod, String usuario, Date dtEntrega, String hrEntrega,
			Date dtMov, String pessoaResponsavel, float vlDesc, String statusPag, String tipoPedido) {
		this.idPedidoSaida = idPedidoSaida;
		this.idLoja = idLoja;
		this.cdEntidade = cdEntidade;
		this.idColaborador = idColaborador;
		this.idEntrega = idEntrega;
		this.operacao = operacao;
		this.dtPed = dtPed;
		this.vlPed = vlPed;
		this.observacao = observacao;
		this.anotacao = anotacao;
		this.status = status;
		this.dtMod = dtMod;
		this.usuario = usuario;
		this.dtEntrega = dtEntrega;
		this.hrEntrega = hrEntrega;
		this.dtMov = dtMov;
		this.pessoaResponsavel = pessoaResponsavel;
		this.vlDesc = vlDesc;
		this.statusPag = statusPag;
		this.tipoPedido = tipoPedido;
	}
	
	
	public PedidoSaida() {

	}
	
	

	public PedidoSaida(int idPedidoSaida, int idLoja, int cdEntidade,
			int idColaborador, int idEntrega, String operacao, Date dtPed,
			double vlPed, String observacao, String anotacao, String status,
			Date dtMod, String usuario, Date dtEntrega, String hrEntrega,
			Date dtMov, String pessoaResponsavel, float vlDesc,
			String statusPag, String tipoPedido, int cdCondPagto,
			int idMotorista, int idEntregador, Integer idVendedor) {
		super();
		this.idPedidoSaida = idPedidoSaida;
		this.idLoja = idLoja;
		this.cdEntidade = cdEntidade;
		this.idColaborador = idColaborador;
		this.idEntrega = idEntrega;
		this.operacao = operacao;
		this.dtPed = dtPed;
		this.vlPed = vlPed;
		this.observacao = observacao;
		this.anotacao = anotacao;
		this.status = status;
		this.dtMod = dtMod;
		this.usuario = usuario;
		this.dtEntrega = dtEntrega;
		this.hrEntrega = hrEntrega;
		this.dtMov = dtMov;
		this.pessoaResponsavel = pessoaResponsavel;
		this.vlDesc = vlDesc;
		this.statusPag = statusPag;
		this.tipoPedido = tipoPedido;
		this.cdCondPagto = cdCondPagto;
		this.idMotorista = idMotorista;
		this.idEntregador = idEntregador;
		this.idVendedor = idVendedor;
	}
	
	
	public PedidoSaida(int idPedidoSaida, int idLoja, int cdEntidade,
			int idColaborador, int idEntrega, String operacao, Date dtPed,
			double vlPed, String observacao, String anotacao, String status,
			Date dtMod, String usuario, Date dtEntrega, String hrEntrega,
			Date dtMov, String pessoaResponsavel, float vlDesc,
			String statusPag, String tipoPedido, int cdCondPagto, Date dtPed2,
			int idMotorista, int idEntregador, Integer idVendedor) {
		super();
		this.idPedidoSaida = idPedidoSaida;
		this.idLoja = idLoja;
		this.cdEntidade = cdEntidade;
		this.idColaborador = idColaborador;
		this.idEntrega = idEntrega;
		this.operacao = operacao;
		this.dtPed = dtPed;
		this.vlPed = vlPed;
		this.observacao = observacao;
		this.anotacao = anotacao;
		this.status = status;
		this.dtMod = dtMod;
		this.usuario = usuario;
		this.dtEntrega = dtEntrega;
		this.hrEntrega = hrEntrega;
		this.dtMov = dtMov;
		this.pessoaResponsavel = pessoaResponsavel;
		this.vlDesc = vlDesc;
		this.statusPag = statusPag;
		this.tipoPedido = tipoPedido;
		this.cdCondPagto = cdCondPagto;
		this.dtPed2 = dtPed2;
		this.idMotorista = idMotorista;
		this.idEntregador = idEntregador;
		this.idVendedor = idVendedor;
	}
	public Date getDtPed2() {
		return dtPed2;
	}
	public void setDtPed2(Date dtPed2) {
		this.dtPed2 = dtPed2;
	}
	public Integer getIdVendedor() {
		return idVendedor;
	}
	public void setIdVendedor(Integer idVendedor) {
		this.idVendedor = idVendedor;
	}
	public int getIdPedidoSaida() {
		return idPedidoSaida;
	}
	
	public float getVlDesc(){
		return this.vlDesc;
	}
	
	public void setVlDesc(float vlDesc){
		this.vlDesc = vlDesc;
	}

	public void setIdPedidoSaida(int idPedidoSaida) {
		this.idPedidoSaida = idPedidoSaida;
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

	public int getIdColaborador() {
		return idColaborador;
	}

	public void setIdColaborador(int idColaborador) {
		this.idColaborador = idColaborador;
	}

	public int getIdEntrega() {
		return idEntrega;
	}

	public void setIdEntrega(int idEntrega) {
		this.idEntrega = idEntrega;
	}

	public Date getDtPed() {
		return dtPed;
	}

	public void setDtPed(Date dtPed) {
		this.dtPed = dtPed;
	}

	public double getVlPed() {
		return vlPed;
	}

	public void setVlPed(double vlPed) {
		this.vlPed = vlPed;
	}

	public String getObservacao() {
		return observacao;
	}

	public void setObservacao(String observacao) {
		this.observacao = observacao;
	}

	public String getAnotacao() {
		return anotacao;
	}

	public void setAnotacao(String anotacao) {
		this.anotacao = anotacao;
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

	public String getOperacao() {
		return operacao;
	}

	public void setOperacao(String operacao) {
		this.operacao = operacao;
	}

	public Date getDtEntrega() {
		return dtEntrega;
	}

	public void setDtEntrega(Date dtEntrega) {
		this.dtEntrega = dtEntrega;
	}

	public String getHrEntrega() {
		return hrEntrega;
	}

	public void setHrEntrega(String hrEntrega) {
		this.hrEntrega = hrEntrega;
	}

	public Date getDtMov() {
		return dtMov;
	}

	public void setDtMov(Date dtMov) {
		this.dtMov = dtMov;
	}

	public final String getPessoaResponsavel() {
		return pessoaResponsavel;
	}

	public final void setPessoaResponsavel(String pessoaResponsavel) {
		this.pessoaResponsavel = pessoaResponsavel;
	}
	public String getStatusPag() {
		return statusPag;
	}
	public void setStatusPag(String statusPag) {
		this.statusPag = statusPag;
	}
	public String getTipoPedido() {
		return tipoPedido;
	}
	public void setTipoPedido(String tipoPedido) {
		this.tipoPedido = tipoPedido;
	}
	public int getCdCondPagto() {
		return cdCondPagto;
	}
	public void setCdCondPagto(int cdCondPagto) {
		this.cdCondPagto = cdCondPagto;
	}
	public int getIdMotorista() {
		return idMotorista;
	}
	public void setIdMotorista(int idMotorista) {
		this.idMotorista = idMotorista;
	}
	public int getIdEntregador() {
		return idEntregador;
	}
	public void setIdEntregador(int idEntregador) {
		this.idEntregador = idEntregador;
	}

}
