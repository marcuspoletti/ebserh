package afero.persistence;

import java.util.List;
import afero.model.TipoDependente;

public interface ITipoDependenteDAO {
	
	public void incluir(TipoDependente dependente) throws AferoDAOException;

	public void atualizar(TipoDependente dependente) throws AferoDAOException;

	public void excluir(TipoDependente dependente) throws AferoDAOException;

	public TipoDependente procurarTipoDependente(int idDep) throws AferoDAOException;

	public List<TipoDependente> listarTipoDependente(String clausula) throws AferoDAOException;

}
