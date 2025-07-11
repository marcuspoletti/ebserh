package afero.persistence;

import java.util.List;
import afero.model.Estado;

public interface IEstadoDAO {
	
	public void incluir(Estado estado) throws AferoDAOException;

	public void atualizar(Estado estado) throws AferoDAOException;

	public void excluir(Estado estado) throws AferoDAOException;

	public Estado procurarEstado(int idEstado) throws AferoDAOException;

	public List<Estado> listarEstado(String clausula) throws AferoDAOException;

}