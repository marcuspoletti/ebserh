package afero.persistence;

import java.util.List;

import afero.model.CotacaoPedidoEntrada;

public interface ICotacaoPedidoEntradaDAO {
	
	public void incluir(CotacaoPedidoEntrada cotacaoPedidoEntrada) throws AferoDAOException;

	public void atualizar(CotacaoPedidoEntrada cotacaoPedidoEntrada) throws AferoDAOException;

	public void excluir(CotacaoPedidoEntrada cotacaoPedidoEntrada) throws AferoDAOException;

	public CotacaoPedidoEntrada procurarCotacaoPedidoEntrada(int idCotacao) throws AferoDAOException;
	
	public CotacaoPedidoEntrada procurarCotacaoPedidoEntradaIdPedidoEntrada(int idPedidoEntrada) throws AferoDAOException;

	public List<CotacaoPedidoEntrada> listarCotacaoPedidoEntrada(String clausula) throws AferoDAOException;

}
