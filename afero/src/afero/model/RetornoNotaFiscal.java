package afero.model;

import java.util.Date;

public class RetornoNotaFiscal {

	private Integer id_retorno_nota_fiscal;
	private Integer id_pedido_saida;
	private String mensagem_retorno = "";
	private Date dt_registro;
	private String usuario; 
	
	
	
	
	
	public RetornoNotaFiscal() {
		
	}
	public RetornoNotaFiscal(Integer id_retorno_nota_fiscal,
			Integer id_pedido_saida, String mensagem_tretorno,
			Date dt_registro) {
		super();
		this.id_retorno_nota_fiscal = id_retorno_nota_fiscal;
		this.id_pedido_saida = id_pedido_saida;
		this.mensagem_retorno = mensagem_tretorno;
		this.dt_registro = dt_registro;
	}
	
	
	
	public RetornoNotaFiscal(Integer id_retorno_nota_fiscal,
			Integer id_pedido_saida, String mensagem_retorno,
			Date dt_registro, String usuario) {
		super();
		this.id_retorno_nota_fiscal = id_retorno_nota_fiscal;
		this.id_pedido_saida = id_pedido_saida;
		this.mensagem_retorno = mensagem_retorno;
		this.dt_registro = dt_registro;
		this.usuario = usuario;
	}
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	public void setDt_registro(Date dt_registro) {
		this.dt_registro = dt_registro;
	}
	public Integer getId_retorno_nota_fiscal() {
		return id_retorno_nota_fiscal;
	}
	public void setId_retorno_nota_fiscal(Integer id_retorno_nota_fiscal) {
		this.id_retorno_nota_fiscal = id_retorno_nota_fiscal;
	}
	public Integer getId_pedido_saida() {
		return id_pedido_saida;
	}
	public void setId_pedido_saida(Integer id_pedido_saida) {
		this.id_pedido_saida = id_pedido_saida;
	}
	public String getMensagem_retorno() {
		return mensagem_retorno;
	}
	public void setMensagem_retorno(String mensagem_tretorno) {
		this.mensagem_retorno = mensagem_tretorno;
	}
	public Date getDt_registro() {
		return dt_registro;
	}
	public void setData_registro(Date data_registro) {
		this.dt_registro = data_registro;
	}
	

	
}
