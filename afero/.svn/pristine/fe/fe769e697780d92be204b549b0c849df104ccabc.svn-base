package afero.persistence;

import java.util.List;

import afero.model.PlanoConta;

public interface IPlanoContaDAO {

	public void incluir(PlanoConta planoConta) throws AferoDAOException;

	public void atualizar(PlanoConta planoConta) throws AferoDAOException;

	public void excluir(PlanoConta planoConta) throws AferoDAOException;

	public PlanoConta procurarPlanoConta(int idPlanoConta) throws AferoDAOException;

	public List<PlanoConta> listarPlanoConta(String clausula) throws AferoDAOException;
	
	public boolean exclusaoIdPlanoConta(int idPlanoConta) throws AferoDAOException;
}
