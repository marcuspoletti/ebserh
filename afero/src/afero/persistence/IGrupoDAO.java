package afero.persistence;

import java.util.List;

import afero.model.Grupo;

public interface IGrupoDAO {
	public void incluir(Grupo grupo) throws AferoDAOException;

	public void atualizar(Grupo grupo) throws AferoDAOException;

	public void excluir(Grupo grupo) throws AferoDAOException;

	public Grupo procurarGrupo(int idGrupo) throws AferoDAOException;

	public List<Grupo> listarGrupo(String clausula) throws AferoDAOException;
	
	public boolean exclusaoIdGrupo(int idGrupo) throws AferoDAOException;
}
