package afero.model;

public class OrcamentoPedidoSaida {
	
	private int idOrcamento;
	private int idPedidoSaida;
	
	
	public OrcamentoPedidoSaida() {
	
		// TODO Auto-generated constructor stub
	}
	public OrcamentoPedidoSaida(int idOrcamento, int idPedidoSaida) {
		
		this.idOrcamento = idOrcamento;
		this.idPedidoSaida = idPedidoSaida;
	}
	public int getIdOrcamento() {
		return idOrcamento;
	}
	public void setIdOrcamento(int idOrcamento) {
		this.idOrcamento = idOrcamento;
	}
	public int getIdPedidoSaida() {
		return idPedidoSaida;
	}
	public void setIdPedidoSaida(int idPedidoSaida) {
		this.idPedidoSaida = idPedidoSaida;
	}

}
