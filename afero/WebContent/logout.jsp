<%@include file="../iniConexao.jsp"%>
<%@page import="afero.model.LogUsuario"%>
<%@page import="afero.persistence.LogUsuarioDAO"%>
<%
  LogUsuario logUsuario = new LogUsuario();
  LogUsuarioDAO logUsuarioDao = new LogUsuarioDAO(conn);
  String usuario = (String)session.getAttribute("Login");
  if(usuario != null){
  	int idLoja = Integer.parseInt((String)session.getAttribute("idLoja"));
  	logUsuario.setUsuario(usuario);
  	logUsuario.setIdLoja(idLoja);
  	logUsuarioDao.incluir(logUsuario);
  }
  session.invalidate();
%>
<jsp:forward page="index.jsp?msg=Sessão encerrada."/>