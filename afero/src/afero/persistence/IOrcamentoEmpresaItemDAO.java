package afero.persistence;

import java.util.List;

import afero.persistence.AferoDAOException;
import afero.model.OrcamentoEmpresaItem;


public interface IOrcamentoEmpresaItemDAO {
	
	public void incluir(OrcamentoEmpresaItem orcamentoEmpresaItem) throws AferoDAOException;

	public void atualizar(OrcamentoEmpresaItem orcamentoEmpresaItem) throws AferoDAOException;

	public void excluir(OrcamentoEmpresaItem orcamentoEmpresaItem) throws AferoDAOException;

	public List procurarOrcamentoEmpresaItem(int idOrcamentoEmpresa) throws AferoDAOException;

	public List listarOrcamentoEmpresaItem(String clausula) throws AferoDAOException;
	
	public OrcamentoEmpresaItem pesquisarOrcamentoEmpresaItem(int idOrcamentoEmpresaItem) throws AferoDAOException;
	
	public List listarOrcamentoEmpresaItem(int idOrcamentoEmpresa) throws AferoDAOException;
	
	public String dataAtual() throws AferoDAOException;
	
	public List listarCabecalhoFrame(int idOrcamentoEmpresa) throws AferoDAOException;
	
	public List listarRelatorioOrcamentoEmpresaItem(int idOrcamentoEmpresa) throws AferoDAOException;
	
	public List listarRelatorioMesAnual(int idOrcamentoEmpresa, int ano) throws AferoDAOException;

	public List listarRelatorioMes(int idOrcamentoEmpresa, int meses, int ano) throws AferoDAOException;

}
