package afero.persistence;

import java.util.List;

import afero.model.Entidade;

public interface IEntidadeDAO {

	public int incluir(Entidade entidade) throws AferoDAOException;

	public void atualizar(Entidade entidade) throws AferoDAOException;

	public void excluir(Entidade entidade) throws AferoDAOException;

	public Entidade procurarEntidade(int cdEntidade) throws AferoDAOException;

	public List<Entidade> listarEntidade(String clausula) throws AferoDAOException;
	
}

