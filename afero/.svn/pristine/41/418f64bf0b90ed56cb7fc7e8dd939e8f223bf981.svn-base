package aferopet.persistence;

import java.util.List;

import afero.persistence.AferoDAOException;
import aferopet.model.Animal;


public interface IAnimalDAO {

	public void incluir(Animal animal) throws AferoDAOException;
	
	public void atualizar(Animal animal) throws AferoDAOException;

	public void excluir(Animal animal) throws AferoDAOException;

	public Animal procurarAnimal(int idAnimal) throws AferoDAOException;

	public List<Animal> listarAnimal(String clausula) throws AferoDAOException;
}