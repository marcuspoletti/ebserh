package afero.persistence;

import java.util.List;
import afero.model.Recibo;

public interface IReciboDAO {
	
	public void incluir(Recibo recibo) throws AferoDAOException;
	public void atualizar(Recibo recibo) throws AferoDAOException;
	public void excluir(Recibo recibo) throws AferoDAOException;
	public Recibo procurarRecibo(int idRecibo)throws AferoDAOException;
	public List listarRecibo(String clausula) throws AferoDAOException;

}
