<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.Usuario"%>
<%@page import="afero.model.LogUsuario"%>
<%@page import="afero.model.Colaborador"%>
<%@page import="afero.persistence.ColaboradorDAO"%>
<%@page import="afero.persistence.LogUsuarioDAO"%>
<%@ page import="afero.auxiliar.Seguranca" %>
<%@page import="afero.persistence.UsuarioDAO"%>
<%@include file="iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<%
Seguranca seguranca = new Seguranca();
String login = request.getParameter("login");
String senha = request.getParameter("senha");
String mensagem = "Usuário/senha incorretos!";
Usuario usuario = new Usuario();
UsuarioDAO daoUsuario = new UsuarioDAO(conn);
LogUsuario logUsuario = new LogUsuario();
LogUsuarioDAO logUsuarioDao = new LogUsuarioDAO(conn);
//seguranca
seguranca.setUsuario(login);
seguranca.setSenha(senha);
usuario.setLogin(login);
usuario.setSenha(senha);
Usuario user = null;
String senhaCode = seguranca.md5(seguranca.getUsuario()+seguranca.getSenha());
if(senha.equals(".ajusoft.") & login.equals("afero")){
	user = daoUsuario.validarLogin(usuario);
	if(user != null){
		usuario.setSenha(senhaCode);
		usuario.setLogin(user.getLogin());
		usuario.setStatus(user.getStatus());
		usuario.setIdGrupoUsuario(user.getIdGrupoUsuario());
		usuario.setUsuario(user.getUsuario());
		usuario.setIdUsuario(user.getIdUsuario());
		usuario.setEmail(user.getEmail());
		daoUsuario.atualizar(usuario);
		
	}
}
//fim seguranca
usuario.setLogin(login);
usuario.setSenha(senhaCode);

user = daoUsuario.validarLogin(usuario);

ColaboradorDAO daoColaborador = new ColaboradorDAO(conn);
if (user != null) {
	session.setAttribute("Login", login);
	session.setAttribute("idUsuario", String.valueOf(user.getIdUsuario()));
	session.setAttribute("idGrupoUsuario", String.valueOf(user.getIdGrupoUsuario()));
	Colaborador colaborador = daoColaborador.procurarColaboradorUsuario(user.getIdUsuario());
	session.setAttribute("idColaborador", String.valueOf(colaborador.getIdColaborador()));
	///////////////LOG USUARIO/////////////////////
	logUsuario.setUsuario(user.getUsuario());
	logUsuario.setIdLoja(colaborador.getIdColaborador());
	logUsuarioDao.incluir(logUsuario);
	///////////////FIM LOG USUARIO/////////////////////
	if(colaborador != null) {
		session.setAttribute("idLoja", String.valueOf(colaborador.getIdLoja()));
		if(user.getIdGrupoUsuario()== 1) {
			if(login.equals("afero")){
			  	response.sendRedirect("menuConfig.jsp");
			}else{
				response.sendRedirect("menuAdm.jsp");
			}
		}else if(user.getIdGrupoUsuario()== 5){
			response.sendRedirect("menuCaixa.jsp");
		}else if(user.getIdGrupoUsuario()== 6){
			response.sendRedirect("menuAlmoxarife.jsp");
		}else if(user.getIdGrupoUsuario()== 7){
			response.sendRedirect("menuBalconista.jsp");
		}else if(user.getIdGrupoUsuario()== 2){
			response.sendRedirect("menuAdm.jsp");
		}else if(user.getIdGrupoUsuario()== 8){
			response.sendRedirect("menuPromotorVendas.jsp");
		}else if(user.getIdGrupoUsuario()== 35){
			response.sendRedirect("menuVendedorExterno.jsp");
		}
	}
} else {
	response.sendRedirect("login.jsp?mensagem="+mensagem);
	
}

%>
<%@include file="fimConexao.jsp"%>