package afero.persistence;

import java.util.List;

import afero.model.OrcamentoEmpresa;

public interface IOrcamentoEmpresaDAO {
	public void incluir(OrcamentoEmpresa orcamentoEmpresa) throws AferoDAOException;

	public void atualizar(OrcamentoEmpresa orcamentoEmpresa) throws AferoDAOException;

	public void excluir(OrcamentoEmpresa orcamentoEmpresa) throws AferoDAOException;

	public OrcamentoEmpresa procurarOrcamentoEmpresa(int idOrcamentoEmpresa) throws AferoDAOException;

	public List<OrcamentoEmpresa> listarOrcamentoEmpresa(String clausula) throws AferoDAOException;
	
	public boolean exclusaoIdOrcamentoEmpresa(int idOrcamentoEmpresa) throws AferoDAOException;
}
