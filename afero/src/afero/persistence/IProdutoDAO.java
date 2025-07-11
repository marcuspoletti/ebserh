package afero.persistence;

import java.util.List;

import afero.model.Produto;

public interface IProdutoDAO {
	
	public void incluir(Produto produto) throws AferoDAOException;
	
	public int incluirProd(Produto produto) throws AferoDAOException;

	public void atualizar(Produto produto) throws AferoDAOException;

	public void excluir(Produto produto) throws AferoDAOException;

	public Produto procurarProduto(int idProduto) throws AferoDAOException;

	public List<Produto> listarProduto(String clausula) throws AferoDAOException;
	
	public List listarProcurarProduto(int idProduto) throws AferoDAOException;
	
	public boolean exclusaoIdProduto(int idProduto) throws AferoDAOException ;
	
	public List listarProdutoPreco(String clausula) throws AferoDAOException;
	
	public List listarProdutoPrecoLoja(String clausula) throws AferoDAOException; 
	
	public List listarProdutoEstoquePreco(String clausula) throws AferoDAOException;

}
