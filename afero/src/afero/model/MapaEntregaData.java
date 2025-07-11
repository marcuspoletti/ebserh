package afero.model;

import java.util.Date;

public class MapaEntregaData {

	private Date dataEntrega;
	private String hrEntrega;
	private int quantidade;
	
	public MapaEntregaData(Date dataEntrega, String hrEntrega, int quantidade) {
		
		this.dataEntrega = dataEntrega;
		this.hrEntrega = hrEntrega;
		this.quantidade = quantidade;
	}
	public Date getDataEntrega() {
		return dataEntrega;
	}
	public void setDataEntrega(Date dataEntrega) {
		this.dataEntrega = dataEntrega;
	}
	public String getHrEntrega() {
		return hrEntrega;
	}
	public void setHrEntrega(String hrEntrega) {
		this.hrEntrega = hrEntrega;
	}
	public int getQuantidade() {
		return quantidade;
	}
	public void setQuantidade(int quantidade) {
		this.quantidade = quantidade;
	}
	
	
}
