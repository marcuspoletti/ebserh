package afero.persistence;

import java.util.List;

import afero.model.TipoConta;

public interface ITipoContaDAO {
	public void incluir(TipoConta tipoConta) throws AferoDAOException;

	public void atualizar(TipoConta tipoConta) throws AferoDAOException;

	public void excluir(TipoConta tipoConta) throws AferoDAOException;

	public TipoConta procurarTipoConta(int idTipoConta) throws AferoDAOException;
	
	public List<TipoConta> listarTipoConta(String clausula) throws AferoDAOException;
	
	public boolean exclusaoIdTipoConta(int idTipoConta) throws AferoDAOException;
	
	

}
