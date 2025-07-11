package afero.persistence;

import java.util.List;
import afero.model.OrdemServico;

public interface IOrdemServicoDAO {
	
	public void incluir(OrdemServico ordemServico) throws AferoDAOException;

	public void atualizar(OrdemServico ordemServico) throws AferoDAOException;

	public void excluir(OrdemServico ordemServico) throws AferoDAOException;

	public OrdemServico procurarOrdemServico(int idOrdemServico) throws AferoDAOException;

	public List<OrdemServico> listarOrdemServico(String clausula) throws AferoDAOException;
	
	public int idOrdemServicoCorrente() throws AferoDAOException;
	
	public int getPedidoSaida(int id) throws AferoDAOException;
	
	public boolean getOrdemServico(int idOrdemServico) throws AferoDAOException;
}
