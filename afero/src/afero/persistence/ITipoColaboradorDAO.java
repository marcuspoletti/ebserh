package afero.persistence;
import java.util.List;
import afero.model.TipoColaborador;

public interface ITipoColaboradorDAO {
	
	public void incluir(TipoColaborador tipoColaborador) throws AferoDAOException;

	public void atualizar(TipoColaborador tipoColaborador) throws AferoDAOException;

	public void excluir(TipoColaborador tipoColaborador) throws AferoDAOException;

	public TipoColaborador procurarTipoColaborador(int idTipoColaborador) throws AferoDAOException;

	public List<TipoColaborador> listarTipoColaborador(String clausula) throws AferoDAOException;
	
	public boolean exclusaoIdColaborador(int idTipoColaborador) throws AferoDAOException;

}
