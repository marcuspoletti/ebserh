package afero.persistence;

import java.util.List;
import afero.model.EntidadeContato;

public interface IEntidadeContatoDAO {
	public void incluir(EntidadeContato entidadeContato) throws AferoDAOException;

	public void atualizar(EntidadeContato entidadeContato) throws AferoDAOException;

	public void excluir(EntidadeContato entidadeContato) throws AferoDAOException;

	public EntidadeContato procurarEntidadeContato(int idEntidadeContato) throws AferoDAOException;

	public List<EntidadeContato> listarEntidadeContato(String clausula) throws AferoDAOException;

}
