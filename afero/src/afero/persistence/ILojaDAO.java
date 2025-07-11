package afero.persistence;
import java.util.List;
import afero.model.Loja;

public interface ILojaDAO {
	
	public void incluir(Loja loja) throws AferoDAOException;

	public void atualizar(Loja loja) throws AferoDAOException;

	public void excluir(Loja loja) throws AferoDAOException;

	public Loja procurarLoja(int idLoja) throws AferoDAOException;

	public List<Loja> listarLoja(String clausula) throws AferoDAOException;
	

}
