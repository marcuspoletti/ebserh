package afero.persistence;
import java.util.List;
import afero.model.Entrega;
public interface IEntregaDAO {
	
	public void incluir(Entrega entrega) throws AferoDAOException;

	public void atualizar(Entrega entrega) throws AferoDAOException;

	public void excluir(Entrega entrega) throws AferoDAOException;

	public Entrega procurarEntrega(int idEntrega) throws AferoDAOException;

	public List<Entrega> listarEntrega(String clausula) throws AferoDAOException;
	
	public boolean exclusaoIdEntrega(int idEntrega) throws AferoDAOException;

}
