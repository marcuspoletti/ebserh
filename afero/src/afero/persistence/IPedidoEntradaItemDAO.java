package afero.persistence;
import java.util.List;
import afero.model.PedidoEntradaItem;

public interface IPedidoEntradaItemDAO {
	
	public void incluir(PedidoEntradaItem pedidoEntradaItem) throws AferoDAOException;

	public void atualizar(PedidoEntradaItem pedidoEntradaItem) throws AferoDAOException;

	public void excluir(PedidoEntradaItem pedidoEntradaItem) throws AferoDAOException;

	public PedidoEntradaItem procurarPedidoEntradaItem(int idPedidoEntradaItem) throws AferoDAOException;

	public List<PedidoEntradaItem> listarPedidoEntradaItem(String clausula) throws AferoDAOException;
	
	public List listarProcurarPedidoEntradaItem(int idPedidoEntradaPesquisa) throws AferoDAOException;
	
	public List listarEntrada(String clausula) throws AferoDAOException;
	
	public float quantDeEntradaPorItem(int idProduto, int idLoja) throws AferoDAOException;
}