package afero.persistence;

import java.util.List;
import afero.model.PedidoEntrada;

public interface IPedidoEntradaDAO {
	
	public void incluir(PedidoEntrada pedidoEntrada) throws AferoDAOException;

	public void atualizar(PedidoEntrada pedidoEntrada) throws AferoDAOException;

	public void excluir(PedidoEntrada pedidoEntrada) throws AferoDAOException;

	public PedidoEntrada procurarPedidoEntrada(int idPedidoEntrada) throws AferoDAOException;

	public List<PedidoEntrada> listarPedidoEntrada(String clausula) throws AferoDAOException;
	
	public int getIdPedidoEntrada() throws AferoDAOException;
	
	public String dataAtualPedido() throws AferoDAOException;

}
