package afero.persistence;

import java.util.List;
import afero.model.Regiao;

public interface IRegiaoDAO {
	
	public void incluir(Regiao regiao) throws AferoDAOException;

	public void atualizar(Regiao regiao) throws AferoDAOException;

	public void excluir(Regiao regiao) throws AferoDAOException;

	public Regiao procurarRegiao(int cdRegiao) throws AferoDAOException;

	public List<Regiao> listarRegiao(String clausula) throws AferoDAOException;


}
