package afero.persistence;

import java.util.List;
import afero.model.Cidade;

public interface ICidadeDAO {
	
	public void incluir(Cidade cidade) throws AferoDAOException;

	public void atualizar(Cidade cidade) throws AferoDAOException;

	public void excluir(Cidade cidade) throws AferoDAOException;

	public Cidade procurarCidade(int idCidade) throws AferoDAOException;

	public List<Cidade> listarCidade(String clausula) throws AferoDAOException;
	
	public boolean exclusaoIdCidade(int idCidade) throws AferoDAOException;

}
