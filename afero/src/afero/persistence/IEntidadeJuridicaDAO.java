package afero.persistence;


import java.util.List;
import afero.model.EntidadeJuridica;

public interface IEntidadeJuridicaDAO {
	
	void incluir(EntidadeJuridica entidadeJuridica) throws AferoDAOException;

	public void atualizar(EntidadeJuridica entidadeJuridica) throws AferoDAOException;

	public void excluir(EntidadeJuridica entidadeJuridica) throws AferoDAOException;

	public EntidadeJuridica procurarEntidadeJuridica(int cdEntidade) throws AferoDAOException;

	public List<EntidadeJuridica> listarEntidadesJuridica(String clausula) throws AferoDAOException;

}
