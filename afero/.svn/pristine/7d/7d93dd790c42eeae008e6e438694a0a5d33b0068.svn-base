package aferopet.persistence;

import java.util.List;

import afero.persistence.AferoDAOException;
import aferopet.model.Medicamento;


public interface IMedicamentoDAO {

	public void incluir(Medicamento medicamento) throws AferoDAOException;
	
	public void atualizar(Medicamento medicamento) throws AferoDAOException;

	public void excluir(Medicamento medicamento) throws AferoDAOException;

	public Medicamento procurarMedicamento(int idMedicamento) throws AferoDAOException;

	public List<Medicamento> listarMedicamento(String clausula) throws AferoDAOException;
}