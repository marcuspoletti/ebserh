package afero.persistence;

import java.util.List;
import afero.model.CotacaoItem;

public interface ICotacaoItemDAO {
	public void incluir(CotacaoItem cotacaoItem) throws AferoDAOException;

	public void atualizar(CotacaoItem cotacaoItem) throws AferoDAOException;

	public void excluir(CotacaoItem cotacaoItem) throws AferoDAOException;

	public CotacaoItem procurarCotacaoItem(int idCotacaoItem ) throws AferoDAOException;

	public List<CotacaoItem> listarCotacaoItem(String clausula) throws AferoDAOException;
	
	public String dataAtualCotacaoItem() throws AferoDAOException;
	
	public int idCotacaoItemCorrente() throws AferoDAOException;

}
