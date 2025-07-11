package afero.persistence;

import java.util.List;

import afero.model.Classificacao;

public interface IClassificacao {

	public void incluir(Classificacao classificacao) throws AferoDAOException;

	public void excluir(Classificacao classificacao) throws AferoDAOException;

	public Classificacao procurarClassificacao(int idEntidade, int idTipoEntidade)
			throws AferoDAOException;

	public List<Classificacao> listarClassificacao(String clausula)
			throws AferoDAOException;

}
