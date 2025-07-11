package aferopet.persistence;

import java.util.List;

import afero.persistence.AferoDAOException;
import aferopet.model.AnimalRetorno;


public interface IAnimalRetornoDAO {

	public void incluir(AnimalRetorno animalRetorno) throws AferoDAOException;
	
	public void atualizar(AnimalRetorno animalRetorno) throws AferoDAOException;

	public void excluir(AnimalRetorno animalRetorno) throws AferoDAOException;

	public AnimalRetorno procurarAnimalRetorno(int idAnimalFicha) throws AferoDAOException;

	public List<AnimalRetorno> listarAnimalRetorno(String clausula) throws AferoDAOException;
}