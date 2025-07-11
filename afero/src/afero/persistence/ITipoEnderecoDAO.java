package afero.persistence;

import java.util.List;
import afero.model.TipoEndereco;

public interface ITipoEnderecoDAO {
	
	public void incluir(TipoEndereco tipoEndereco) throws AferoDAOException;

	public void atualizar(TipoEndereco tipoEndereco) throws AferoDAOException;

	public void excluir(TipoEndereco tipoEndereco) throws AferoDAOException;

	public TipoEndereco procurarTipoEndereco(int cdTipoEndereco) throws AferoDAOException;

	public List<TipoEndereco> listarTipoEndereco(String clausula) throws AferoDAOException;
	

}
