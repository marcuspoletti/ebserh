package afero.auxiliar;

import afero.model.Usuario;
import afero.persistence.UsuarioDAO;
import afero.auxiliar.Seguranca;
import java.sql.Connection;
import java.util.Iterator;
import java.util.List;
import afero.util.ConnectionFactory;
import afero.persistence.AferoDAOException;

public class GerarSenha {

	
	
	
	public static void main(String[] args) throws Exception{
		String senhaCode = "";
		Seguranca seguranca = new Seguranca();
		try {
			Connection conn = ConnectionFactory.getConnection();
			UsuarioDAO daoUsuario = new UsuarioDAO(conn);
			List list = daoUsuario.listarUsuario(" ORDER BY login ");
			for ( Iterator it = list.iterator(); it.hasNext(); ) {
				Usuario usuario = (Usuario) it.next();
				//seguranca
				seguranca.setUsuario(usuario.getLogin());
				seguranca.setSenha(usuario.getSenha());
				senhaCode = seguranca.md5(seguranca.getUsuario()+seguranca.getSenha());
				//fim seguranca
				usuario.setSenha(senhaCode);
				usuario.setStatus(usuario.getStatus());
				usuario.setIdGrupoUsuario(usuario.getIdGrupoUsuario());
				usuario.setUsuario(usuario.getUsuario());
				daoUsuario.atualizar(usuario);
				System.out.println("Sucesso na rotina..." + " "+ usuario.getLogin() + " " + "Criptografia Md5 criada na senha..." );
				
			}

		} catch (Exception e) {
			throw new AferoDAOException("Erro: " + ":\n" + e.getMessage());
		}
		
		
		
		

	}

}
