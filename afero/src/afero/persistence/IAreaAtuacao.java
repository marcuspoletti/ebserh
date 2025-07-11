package afero.persistence;

import java.util.List;
import afero.model.AreaAtuacao;

public interface IAreaAtuacao {

	public void incluir(AreaAtuacao areaAtuacao) throws AferoDAOException;

	public void excluir(AreaAtuacao areaAtuacao) throws AferoDAOException;

	public AreaAtuacao procurarAreaAtuacao(int idEntidade, int idRamoAtividade)
			throws AferoDAOException;

	public List<AreaAtuacao> listarAreaAtuacao(String clausula)
			throws AferoDAOException;

}
