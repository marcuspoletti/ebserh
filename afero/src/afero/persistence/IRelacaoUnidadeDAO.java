package afero.persistence;

import java.util.List;

import afero.model.RelacaoUnidade;


public interface IRelacaoUnidadeDAO {
	
	public void incluir(RelacaoUnidade relacaoUnidade) throws AferoDAOException;

	public void atualizar(RelacaoUnidade relacaoUnidade) throws AferoDAOException;

	public void excluir(RelacaoUnidade relacaoUnidade) throws AferoDAOException;

	public RelacaoUnidade procurarRelacaoUnidade(int idRelacaoUnidade) throws AferoDAOException;
	
	public String procurarFatorConversao(int idRelacaoUnidade) throws AferoDAOException;
	
	public List<RelacaoUnidade> listarRelacaoUnidade(String clausula) throws AferoDAOException;
}
