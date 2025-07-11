package afero.persistence;
import java.util.List;

import afero.model.FormaPagto;
public interface IFormaPagtoDAO {
	public void incluir(FormaPagto formaPagto) throws AferoDAOException;

	public void atualizar(FormaPagto formaPagto) throws AferoDAOException;

	public void excluir(FormaPagto formaPagto) throws AferoDAOException;

	public FormaPagto procurarFormaPagto(int cdFormaPagto) throws AferoDAOException;

	public List<FormaPagto> listarFormaPagto(String clausula) throws AferoDAOException;
	
	public boolean exclusaoCdFormaPagto(int cdFormaPagto) throws AferoDAOException;
}
