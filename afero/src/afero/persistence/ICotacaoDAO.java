package afero.persistence;

import java.util.List;

import afero.model.Cotacao;

public interface ICotacaoDAO {
	
	public void incluir(Cotacao cotacao) throws AferoDAOException;

	public void atualizar(Cotacao cotacao) throws AferoDAOException;

	public void excluir(Cotacao cotacao) throws AferoDAOException;

	public Cotacao procurarCotacao(int idCotacao ) throws AferoDAOException;

	public List<Cotacao> listarCotacao(String clausula) throws AferoDAOException;
	
	public String dataAtualCotacao() throws AferoDAOException;
	
	public int idCotacaoCorrente() throws AferoDAOException;
}
