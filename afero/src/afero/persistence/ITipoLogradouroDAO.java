package afero.persistence;

import java.util.List;


import afero.model.TipoLogradouro;

public interface ITipoLogradouroDAO {
	
	public void incluir(TipoLogradouro tipoLogradouro) throws AferoDAOException;

	public void atualizar(TipoLogradouro tipoLogradouro) throws AferoDAOException;

	public void excluir(TipoLogradouro tipoLogradouro) throws AferoDAOException;

	public TipoLogradouro procurarTipoLogradouro(int idTipoLogradouro) throws AferoDAOException;

	public List<TipoLogradouro> listarTipoLogradouro(String clausula) throws AferoDAOException;

}
