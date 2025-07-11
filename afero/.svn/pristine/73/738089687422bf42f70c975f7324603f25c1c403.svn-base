package afero.persistence;

import java.util.List;
import afero.model.OrcamentoItem;

public interface IOrcamentoItemDAO {
	
	public void incluir(OrcamentoItem orcamentoItem) throws AferoDAOException;

	public void atualizar(OrcamentoItem orcamentoItem) throws AferoDAOException;

	public void excluir(OrcamentoItem orcamentoItem) throws AferoDAOException;

	public List<OrcamentoItem> procurarOrcamentoItem(int idOrcamentoItem) throws AferoDAOException;

	public List<OrcamentoItem> listarOrcamentoItem(String clausula) throws AferoDAOException;
	
	public void aprovarOrcamentoItem(OrcamentoItem orcamentoItem)throws AferoDAOException;
	
	public List listarOrcamento(int idOrcamento) throws AferoDAOException;

}
