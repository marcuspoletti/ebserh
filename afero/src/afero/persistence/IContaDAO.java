package afero.persistence;

import java.util.List;
import afero.model.Conta;

public interface IContaDAO {
	
	public void incluir(Conta conta) throws AferoDAOException;
	public void atualizar(Conta conta) throws AferoDAOException;
	public void excluir(Conta conta) throws AferoDAOException;
	public Conta procurarConta(int idConta)throws AferoDAOException;
	public List listarConta(String clausula) throws AferoDAOException;
	public boolean exclusaoIdConta(int idConta) throws AferoDAOException;

}
