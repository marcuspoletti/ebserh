package aferopet.persistence;

import java.util.List;

import afero.persistence.AferoDAOException;
import aferopet.model.TipoEspecie;


public interface ITipoEspecieDAO {

	public void incluir(TipoEspecie tipoEspecie) throws AferoDAOException;
	
	public void atualizar(TipoEspecie tipoEspecie) throws AferoDAOException;

	public void excluir(TipoEspecie tipoEspecie) throws AferoDAOException;

	public TipoEspecie procurarTipoEspecie(int cdTipoEspecie) throws AferoDAOException;

	public List<TipoEspecie> listarTipoEspecie(String clausula) throws AferoDAOException;
}