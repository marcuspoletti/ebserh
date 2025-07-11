package afero.persistence;

import java.util.List;
import afero.model.Escolaridade;

public interface IEscolaridadeDAO {
	
	public void incluir(Escolaridade Escolaridade) throws AferoDAOException;

	public void atualizar(Escolaridade escolaridade) throws AferoDAOException;

	public void excluir(Escolaridade escolaridade) throws AferoDAOException;

	public Escolaridade procurarEscolaridade(int cdEscolaridade) throws AferoDAOException;

	public List<Escolaridade> listarEscolaridade(String clausula) throws AferoDAOException;
	

}
