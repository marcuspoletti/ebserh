package afero.persistence;
import java.util.List;
import afero.model.Colaborador;

public interface IColaboradorDAO {
	public void incluir(Colaborador colaborador) throws AferoDAOException;

	public void atualizar(Colaborador colaborador) throws AferoDAOException;

	public void excluir(Colaborador colaborador) throws AferoDAOException;

	public Colaborador procurarColaborador(int idColaborador) throws AferoDAOException;

	public List<Colaborador> listarColaborador(String clausula) throws AferoDAOException;
	
	public boolean exclusaoIdColaboradorOrcamento(int idColaborador) throws AferoDAOException;
	
	public boolean exclusaoIdColaboradorPedido(int idColaborador) throws AferoDAOException;
	
	public boolean exclusaoIdColaboradorCompra(int idColaborador) throws AferoDAOException;
	
	public Colaborador procurarColaboradorUsuario(int idUsuario) throws AferoDAOException;
}
