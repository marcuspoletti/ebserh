package afero.persistence;


import java.util.List;
import afero.model.Estoque;



public interface IEstoqueDAO {
	
	
	public void incluir(Estoque estoque) throws AferoDAOException;
	
	public int incluirProduto(Estoque estoque) throws AferoDAOException;
	
	public int atualizarEstoque(Estoque estoque) throws AferoDAOException;

	public void atualizar(Estoque estoque) throws AferoDAOException;
	
	public void atualizarQuantMaxMin(Estoque estoque) throws AferoDAOException;

	public void excluir(Estoque estoque) throws AferoDAOException;

	public Estoque procurarEstoque(int idEstoque) throws AferoDAOException;

	public List<Estoque> listarEstoque() throws AferoDAOException;
	
	public List procurarEstoquePreco(int idProduto, int idLoja) throws AferoDAOException;
	
	public List procurarEstoquePrecoSemStatus(int idProduto, int idLoja) throws AferoDAOException;
	
	public boolean exclusaoIdEstoque(int idEstoque) throws AferoDAOException;
	
	public Estoque procurarEstoque(int idProduto, int idLoja) throws AferoDAOException;
	
	public List procurarEstoqueLoja(int idLoja) throws AferoDAOException;
	
	public Estoque procurarEstoqueLojaProdutoSstatus(int idLoja, int idProduto) throws AferoDAOException;
	
	public Estoque procurarEstoqueLojaProduto(int idLoja, int idProduto) throws AferoDAOException;
	
	public int getIdEstoque(int idLoja, int idProduto) throws AferoDAOException;
	
	public List procurarEstoqueList(int idProduto) throws AferoDAOException;
	
	public List procurarEstoquePrecoLoja(int idProduto, int idLoja) throws AferoDAOException;
	
	public void atualizarQuantidade(int idProduto, int idLoja, float quant) throws AferoDAOException;
	
	public List procurarEstoquePrecoQuantidades(int idProduto, int idLoja) throws AferoDAOException;

}
