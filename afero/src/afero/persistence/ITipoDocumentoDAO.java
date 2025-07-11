package afero.persistence;

import java.util.List;

import afero.model.TipoDocumento;

public interface ITipoDocumentoDAO {
	public void incluir(TipoDocumento tipoDocumento) throws AferoDAOException;

	public void atualizar(TipoDocumento tipoDocumento) throws AferoDAOException;

	public void excluir(TipoDocumento tipoDocumento) throws AferoDAOException;

	public TipoDocumento procurarTipoDocumento(int idTipoDocumento) throws AferoDAOException;

	public List<TipoDocumento> listarTipoDocumento(String clausula) throws AferoDAOException;
	
	public boolean exclusaoIdTipoDocumento(int idTipoDocumento) throws AferoDAOException;
}
