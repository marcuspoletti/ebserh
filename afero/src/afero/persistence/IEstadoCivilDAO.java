package afero.persistence;

import java.util.List;
import afero.model.EstadoCivil;

public interface IEstadoCivilDAO {
	
	public void incluir(EstadoCivil estadoCivil) throws AferoDAOException;

	public void atualizar(EstadoCivil estadoCivil) throws AferoDAOException;

	public void excluir(EstadoCivil estadoCivil) throws AferoDAOException;

	public EstadoCivil procurarEstadoCivil(int cdEstadoCivil) throws AferoDAOException;

	public List<EstadoCivil> listarEstadoCivil(String clausula) throws AferoDAOException;

}
