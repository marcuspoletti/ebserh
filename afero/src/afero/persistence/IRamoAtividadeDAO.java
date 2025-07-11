package afero.persistence;

import java.util.List;
import afero.model.RamoAtividade;

public interface IRamoAtividadeDAO {
	
	public void incluir(RamoAtividade ramoAtividade) throws AferoDAOException;

	public void atualizar(RamoAtividade ramoAtividade) throws AferoDAOException;

	public void excluir(RamoAtividade ramoAtividade) throws AferoDAOException;

	public RamoAtividade procurarRamoAtividade(int idRamoAtividade) throws AferoDAOException;

	public List<RamoAtividade> listarRamoAtividade(String clausula) throws AferoDAOException;

}
