package afero.persistence;

import java.util.List;
import afero.model.EntidadeTelefone;

public interface IEntidadeTelefoneDAO {
	
	public void incluir(EntidadeTelefone entidadeTelefone) throws AferoDAOException;

	public void atualizar(EntidadeTelefone entidadeTelefone) throws AferoDAOException;

	public void excluir(EntidadeTelefone entidadeTelefone) throws AferoDAOException;

	public EntidadeTelefone procurarEntidadeTelefone(int idEntidadeTelefone) throws AferoDAOException;

	public List<EntidadeTelefone> listarEntidadeTelefone(String clausula) throws AferoDAOException;
	public List<EntidadeTelefone> listarTelefone(int idEntidade) throws AferoDAOException;

}
