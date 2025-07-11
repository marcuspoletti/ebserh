package afero.persistence;

import java.util.List;
import afero.model.CotacaoEntidade;

public interface ICotacaoEntidadeDAO {
	public void incluir(CotacaoEntidade cotacaoEntidade) throws AferoDAOException;

	public void atualizar(CotacaoEntidade cotacaoEntidade) throws AferoDAOException;

	public void excluir(CotacaoEntidade cotacaoEntidade) throws AferoDAOException;

	public CotacaoEntidade procurarCotacaoEntidade(int idCotacaoEntidade ) throws AferoDAOException;

	public List<CotacaoEntidade> listarCotacaoEntidade(String clausula) throws AferoDAOException;

}
