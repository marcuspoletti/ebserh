package afero.persistence;

import java.util.List;
import afero.model.Orcamento;

public interface IOrcamentoDAO {
	
	public void incluir(Orcamento orcamento) throws AferoDAOException;

	public void atualizar(Orcamento orcamento) throws AferoDAOException;
	
	public void atualizarItem(Orcamento orcamento) throws AferoDAOException;
	
	public void atualizarCabecalho(Orcamento orcamento) throws AferoDAOException;

	public void excluir(Orcamento orcamento) throws AferoDAOException;

	public Orcamento procurarOrcamento(int idOrcamento) throws AferoDAOException;
	
	public Orcamento procurarOrcamentoItem(int idOrcamento)throws AferoDAOException;

	public List<Orcamento> listarOrcamento(String clausula) throws AferoDAOException;
	
	public void aprovarOrcamento(Orcamento orcamento)throws AferoDAOException;
	
	public int idOrcamentoCorrente() throws AferoDAOException;
	
	

}
