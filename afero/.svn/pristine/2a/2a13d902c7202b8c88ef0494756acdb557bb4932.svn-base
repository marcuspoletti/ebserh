package afero.persistence;

import java.util.List;

import afero.model.Divisao;


public interface IDivisaoDAO {
	
	public void incluir(Divisao divisao) throws AferoDAOException;

	public void atualizar(Divisao divisao) throws AferoDAOException;

	public void excluir(Divisao divisao) throws AferoDAOException;

	public Divisao procurarDivisao(int idDivisao) throws AferoDAOException;
	
	public int retornarIdGrupo(int cdGrupo)throws AferoDAOException;
	
	public List<Divisao> listarDivisao(String clausula) throws AferoDAOException;
	
	public boolean exclusaoIdDivisao(int idDivisao) throws AferoDAOException;
	
	public boolean AtualizarIdDivisao(int idDivisao, int idGrupo, int idSubGrupo) throws AferoDAOException;

}
