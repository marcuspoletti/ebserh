package aferopet.persistence;

import java.util.List;

import afero.persistence.AferoDAOException;
import aferopet.model.AnimalFicha;


public interface IAnimalFichaDAO {

	public void incluir(AnimalFicha animalFicha) throws AferoDAOException;
	
	public void atualizar(AnimalFicha animalFicha) throws AferoDAOException;

	public void excluir(AnimalFicha animalFicha) throws AferoDAOException;

	public AnimalFicha procurarAnimalFicha(int idAnimalFicha) throws AferoDAOException;

	public List<AnimalFicha> listarAnimalFicha(String clausula) throws AferoDAOException;
}