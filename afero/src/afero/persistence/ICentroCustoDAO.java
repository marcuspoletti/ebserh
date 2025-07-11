package afero.persistence;

import java.util.List;

import afero.model.CentroCusto;

public interface ICentroCustoDAO {
	public void incluir(CentroCusto centroCusto) throws AferoDAOException;

	public void atualizar(CentroCusto centroCusto) throws AferoDAOException;

	public void excluir(CentroCusto centroCusto) throws AferoDAOException;

	public CentroCusto procurarCentroCusto(int idCentroCusto) throws AferoDAOException;

	public List<CentroCusto> listarCentroCusto(String clausula) throws AferoDAOException;
	
	public boolean exclusaoIdCentroCusto(int idCentroCusto) throws AferoDAOException;
}
