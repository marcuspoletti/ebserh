package aferopet.persistence;

import java.util.List;

import afero.persistence.AferoDAOException;
import aferopet.model.TipoRaca;


public interface ITipoRacaDAO {

	public void incluir(TipoRaca tipoRaca) throws AferoDAOException;
	
	public void atualizar(TipoRaca tipoRaca) throws AferoDAOException;

	public void excluir(TipoRaca tipoRaca) throws AferoDAOException;

	public TipoRaca procurarTipoRaca(int idTipoRaca) throws AferoDAOException;

	public List<TipoRaca> listarTipoRaca(String clausula) throws AferoDAOException;
}