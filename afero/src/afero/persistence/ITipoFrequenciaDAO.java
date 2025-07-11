package afero.persistence;

import java.util.List;

import afero.model.TipoFrequencia;

public interface ITipoFrequenciaDAO {
	public void incluir(TipoFrequencia tipoFrequencia) throws AferoDAOException;

	public void atualizar(TipoFrequencia tipoFrequencia) throws AferoDAOException;

	public void excluir(TipoFrequencia tipoFrequencia) throws AferoDAOException;

	public TipoFrequencia procurarTipoFrequencia(int cdTipoFrequencia) throws AferoDAOException;

	public List<TipoFrequencia> listarTipoFrequencia(String clausula) throws AferoDAOException;
	
	public boolean exclusaoCdTipoFrequencia(int cdTipoFrequencia) throws AferoDAOException;
}
