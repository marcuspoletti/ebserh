package afero.persistence;

import java.util.List;

import afero.model.PedidoSaida;

public interface IPedidoSaidaDAO {
	
	public void incluir(PedidoSaida pedidoSaida) throws AferoDAOException;
	
	public void incluirDesconto(PedidoSaida pedidoSaida) throws AferoDAOException;
	
	public void atualizar(PedidoSaida pedidoSaida) throws AferoDAOException;
	
	public void atualizarCabecalho(PedidoSaida pedidoSaida) throws AferoDAOException;

	public void excluir(PedidoSaida pedidoSaida) throws AferoDAOException;

	public PedidoSaida procurarPedidoSaida(int idPedidoSaida) throws AferoDAOException;
	
	public PedidoSaida procurarPedidoSaidaItem(int idPedidoSaida) throws AferoDAOException;

	public List<PedidoSaida> listarPedidoSaida(String clausula) throws AferoDAOException;
	
	public int idPedidoSaida() throws AferoDAOException;
    
	public boolean respPedidoSaida(int idOrcamento) throws AferoDAOException;
	
	public String dataAtualPedido() throws AferoDAOException;
	
	public int getIdOrcamento(int id) throws AferoDAOException;
	
	public boolean confirmarPedido(int idPedidoSaida) throws AferoDAOException;
	
	public List listarMapaEntragaData(String clausula) throws AferoDAOException;
	
	public List listarMapaEntragaBairro(String clausula) throws AferoDAOException;
	
	public List listarPedidoSaidaMapaPedido(String clausula) throws AferoDAOException;
	
	public void atualizarImpressaoPedido(int idPedidoSaida) throws AferoDAOException;
	
	public String statusImpressao(int idPedidoSaida) throws AferoDAOException;
}
