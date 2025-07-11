package afero.persistence;

import java.util.List;


import afero.model.Unidade;

public interface IUnidadeDAO {
	
	public void incluir(Unidade unidade) throws AferoDAOException;

	public void atualizar(Unidade unidade) throws AferoDAOException;

	public void excluir(Unidade unidade) throws AferoDAOException;

	public Unidade procurarUnidade(int idUnidade) throws AferoDAOException;
	
	
	public List<Unidade> listarUnidade(String clausula) throws AferoDAOException;
	
	public boolean exclusaIdUnidade(int idUnidade) throws AferoDAOException ;

}
