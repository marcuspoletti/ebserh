package afero.model;

import java.util.Date;

public class PedidosItens {
	
	
	private int idPedido;
	private Date dataPedido;
	private String dsProduto;
	private float  quantPedido;
	private String anotacao;
	private int idEntrega;
	private String hrEntrega;
	private String dsCompProduto;
	
	
	
	public PedidosItens(int idPedido, Date dataPedido, String dsProduto, float quantPedido,
			String anotacao, int idEntrega, String hrEntrega) {
		this.idPedido  = idPedido;
		this.dataPedido = dataPedido;
		this.dsProduto = dsProduto;
		this.quantPedido = quantPedido;
		this.anotacao = anotacao;
		this.idEntrega = idEntrega;
		this.hrEntrega = hrEntrega;
	}
	public PedidosItens(int idPedido, Date dataPedido, String dsProduto, float quantPedido,
			String anotacao, int idEntrega, String hrEntrega, String dsCompProduto) {
		this.idPedido  = idPedido;
		this.dataPedido = dataPedido;
		this.dsProduto = dsProduto;
		this.quantPedido = quantPedido;
		this.anotacao = anotacao;
		this.idEntrega = idEntrega;
		this.hrEntrega = hrEntrega;
		this.dsCompProduto = dsCompProduto;
	}
	
	public PedidosItens() {
		
	}


	public String getDsCompProduto() {
		return dsCompProduto;
	}
	public void setDsCompProduto(String dsCompProduto) {
		this.dsCompProduto = dsCompProduto;
	}
	public int getIdPedido() {
		return idPedido;
	}


	public void setIdPedido(int idPedido) {
		this.idPedido = idPedido;
	}


	public Date getDataPedido() {
		return dataPedido;
	}
	public void setDataPedido(Date dataPedido) {
		this.dataPedido = dataPedido;
	}
	public String getDsProduto() {
		return dsProduto;
	}
	public void setDsProduto(String dsProduto) {
		this.dsProduto = dsProduto;
	}
	public float getQuantPedido() {
		return quantPedido;
	}
	public void setQuantPedido(int quantPedido) {
		this.quantPedido = quantPedido;
	}
	public String getAnotacao() {
		return anotacao;
	}
	public void setAnotacao(String anotacao) {
		this.anotacao = anotacao;
	}
	public int getIdEntrega() {
		return idEntrega;
	}
	public void setIdEntrega(int idEntrega) {
		this.idEntrega = idEntrega;
	}
	public String getHrEntrega() {
		return hrEntrega;
	}
	public void setHrEntrega(String hrEntrega) {
		this.hrEntrega = hrEntrega;
	}
	
	

}
