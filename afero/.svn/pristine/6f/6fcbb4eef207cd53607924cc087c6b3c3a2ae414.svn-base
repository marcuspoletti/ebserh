package afero.persistence;

import java.util.List;

import afero.model.Usuario;

public interface IUsuarioDAO {
	public void incluir(Usuario usuario) throws AferoDAOException;

	public void atualizar(Usuario usuario) throws AferoDAOException;

	public void excluir(Usuario usuario) throws AferoDAOException;

	public Usuario procurarUsuario(int idLogin) throws AferoDAOException;

	public List<Usuario> listarUsuario(String clausula) throws AferoDAOException;
	
	public int procurarLogin(String login) throws AferoDAOException;
	
	public boolean procurarExisteLogin(String login) throws AferoDAOException;
	
	public Usuario validarLogin(Usuario usuario) throws AferoDAOException;
	
	public boolean exclusaoIdUsuario(int idUsuario) throws AferoDAOException;
}
