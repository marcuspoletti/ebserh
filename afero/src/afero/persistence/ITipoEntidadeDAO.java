package afero.persistence;

import java.util.List;
import afero.model.TipoEntidade;

public interface ITipoEntidadeDAO {
	
	public void incluir(TipoEntidade tipoEntidade) throws AferoDAOException;

	public void atualizar(TipoEntidade tipoEntidade) throws AferoDAOException;

	public void excluir(TipoEntidade tipoEntidade) throws AferoDAOException;

	public TipoEntidade procurarTipoEntidade(int idEntidade) throws AferoDAOException;

	public List<TipoEntidade> listarTipoEntidade(String clausula) throws AferoDAOException;

}
