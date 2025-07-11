package afero.persistence;

import java.util.List;

import afero.model.Banco;

public interface IBancoDAO {
	public void incluir(Banco banco) throws AferoDAOException;

	public void atualizar(Banco banco) throws AferoDAOException;

	public void excluir(Banco banco) throws AferoDAOException;

	public Banco procurarBanco(int idBanco) throws AferoDAOException;

	public List<Banco> listarBanco(String clausula) throws AferoDAOException;
	
	public boolean exclusaoIdBanco(int idBanco) throws AferoDAOException;
}
