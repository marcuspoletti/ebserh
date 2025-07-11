package afero.persistence;

import java.util.List;

import afero.model.SubGrupo;

public interface ISubGrupoDAO {
	public void incluir(SubGrupo subGrupo) throws AferoDAOException;

	public void atualizar(SubGrupo subGrupo) throws AferoDAOException;

	public void excluir(SubGrupo subGrupo) throws AferoDAOException;

	public SubGrupo procurarSubGrupo(int idSubGrupo) throws AferoDAOException;

	public List<SubGrupo> listarSubGrupo(String clausula) throws AferoDAOException;
	
	public boolean exclusaoIdSubGrupo(int idSubGrupo) throws AferoDAOException;
	
	public boolean AtualizarIdSubGrupo(int idSubGrupo, int idGrupo) throws AferoDAOException;
}
