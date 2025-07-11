package afero.persistence;

import java.util.List;

import afero.model.ContaMovto;

public interface IContaMovtoDAO {
	public void incluir(ContaMovto contaMovto) throws AferoDAOException;
	public void atualizar(ContaMovto contaMovto) throws AferoDAOException;
	public void excluir(ContaMovto contaMovto) throws AferoDAOException;
	public ContaMovto procurarContaMovto(int idContaMovto) throws AferoDAOException;
	public List listarContaMovto(String clausula) throws AferoDAOException;
	
}
