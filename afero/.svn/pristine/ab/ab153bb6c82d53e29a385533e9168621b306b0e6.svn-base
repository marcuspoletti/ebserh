package aferopet.persistence;

import java.util.List;

import afero.persistence.AferoDAOException;
import aferopet.model.AnimalMedicamento;


public interface IAnimalMedicamentoDAO {

	public void incluir(AnimalMedicamento animalMedicamento) throws AferoDAOException;
	
	public void atualizar(AnimalMedicamento animalMedicamento) throws AferoDAOException;

	public void excluir(AnimalMedicamento animalMedicamento) throws AferoDAOException;

	public AnimalMedicamento procurarAnimalMedicamento(int idAnimalMedicamento) throws AferoDAOException;

	public List<AnimalMedicamento> listarAnimalMedicamento(String clausula) throws AferoDAOException;
}