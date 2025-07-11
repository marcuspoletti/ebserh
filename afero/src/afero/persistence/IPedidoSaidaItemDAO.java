package afero.persistence;

import java.util.List;
import afero.model.PedidoSaidaItem;

public interface IPedidoSaidaItemDAO {
	public void incluir(PedidoSaidaItem pedidoSaidaItem) throws AferoDAOException;

	public void atualizar(PedidoSaidaItem pedidoSaidaItem) throws AferoDAOException;

	public void excluir(PedidoSaidaItem pedidoSaidaItem) throws AferoDAOException;

	public List<PedidoSaidaItem> procurarPedidoSaidaItem(int idPedidoSaidaItem) throws AferoDAOException;

	public List<PedidoSaidaItem> listarPedidoSaidaItem(String clausula) throws AferoDAOException;
	
	public List listarSaidaItem(String clausula) throws AferoDAOException;
	
	public float quantDeSaidaPorItem(int idProduto, int idLoja) throws AferoDAOException;
	
	public List maisVendidos(String clausula) throws AferoDAOException;
	
}
