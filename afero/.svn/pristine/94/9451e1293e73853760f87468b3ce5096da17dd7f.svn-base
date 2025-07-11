package aferopet.persistence;

import java.util.List;

import afero.persistence.AferoDAOException;
import aferopet.model.GrupoMedicamento;


public interface IGrupoMedicamentoDAO {

	public void incluir(GrupoMedicamento grupoMedicamento) throws AferoDAOException;
	
	public void atualizar(GrupoMedicamento grupoMedicamento) throws AferoDAOException;

	public void excluir(GrupoMedicamento grupoMedicamento) throws AferoDAOException;

	public GrupoMedicamento procurarGrupoMedicamento(int idGrupoMedicamento) throws AferoDAOException;

	public List<GrupoMedicamento> listarGrupoMedicamento(String clausula) throws AferoDAOException;
}