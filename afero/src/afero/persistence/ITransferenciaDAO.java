package afero.persistence;

import java.util.List;

import afero.model.Transferencia;

public interface ITransferenciaDAO {
	
	public void incluir(Transferencia transferencia) throws AferoDAOException;
	public void atualizar(Transferencia transferencia) throws AferoDAOException;
	public void excluir(Transferencia transferencia) throws AferoDAOException;
	public Transferencia procurarTransferencia(int idTransferencia)throws AferoDAOException;
	public List listarTransferencia(String clausula) throws AferoDAOException;

}
