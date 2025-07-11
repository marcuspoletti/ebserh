<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.Usuario" %>
<%@ page import="afero.auxiliar.Seguranca" %>
<%@ page import="afero.persistence.UsuarioDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Date" %>
<%@ page import="afero.util.ConverteDate" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function confirmaExcluir(cont, id) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarUsuario.jsp?acao=exc&idUsuario=' + id;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.nomeUsuario.value = '';
  document.all.status.value = ''; //não está limpando
  document.forms[0].submit();
}  
</script>

<%
Seguranca seguranca = new Seguranca();
UsuarioDAO dao;
ConverteDate conDate = new ConverteDate();
String mensagem = request.getParameter("mensagem");
if(mensagem == null) mensagem="";
String acao = request.getParameter("acao");
if (acao == null) acao = "listar";

String idGrupoUsuario = "";
String email = "";
String login = "";
String senha = "";
String dtCad = "";
String dtMod = "";
String status = "A";
String idUsuario = "";
String nomeUsuario = "";
String clausula = "";

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
	idGrupoUsuario = request.getParameter("idGrupoUsuario");
	login = request.getParameter("login");
	senha = request.getParameter("senha");
  status =request.getParameter("status");
  idUsuario = request.getParameter("idUsuario");
  nomeUsuario = request.getParameter("nomeUsuario");
  if(idGrupoUsuario == null)idGrupoUsuario = "0";
  if(email == null) email = "";
  if(login == null) login = "";
  if(senha == null) senha = "";
  if(status == null) status = "A";
  if(nomeUsuario == null) nomeUsuario ="";
   
  String user = (String)session.getAttribute("Login");
  if(user == null) user ="";
  
  Usuario usuario = new Usuario();

	try {
	  if (!acao.equalsIgnoreCase("inc")){
		  usuario.setIdUsuario(Integer.parseInt(idUsuario));
	  }
  usuario.setEmail(email);
  usuario.setLogin(login);
  //seguranca
  seguranca.setUsuario(login);
  seguranca.setSenha(senha);
  String senhaCode = seguranca.md5(seguranca.getUsuario()+seguranca.getSenha());
  //fim seguranca
  usuario.setSenha(senhaCode);
  usuario.setStatus(status);
  usuario.setIdGrupoUsuario(Integer.parseInt(idGrupoUsuario));
  usuario.setUsuario(user);
	  
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}

  dao = new UsuarioDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {
	  //inclui no banco de dados
  	dao.incluir(usuario);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
	  dao.atualizar(usuario);

  } else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  if(!dao.exclusaoIdUsuario(Integer.parseInt(idUsuario))){
		  dao.excluir(usuario);
	  }else{
		  response.sendRedirect("listarUsuario.jsp?mensagem=Exclusão Inválida! Item já possui lançamentos.&acao=listar");
	  }
  }
} else {
 if (!acao.equalsIgnoreCase("voltar")) {
    nomeUsuario = request.getParameter("nomeUsuario");
    status = request.getParameter("status");
    if (status == null) status = "";
  }

  if (nomeUsuario!= null) {
    clausula = " WHERE login LIKE '"+nomeUsuario+"%'";
  } 
  if (!status.isEmpty()) {
    if (clausula.isEmpty()) {
      clausula = " WHERE status='"+status+"'";
    } else {
      clausula = clausula+" AND status='"+status+"'";
    }
  }
}

//seleciona todos os registros do banco de dados
List list;
dao = new UsuarioDAO(conn);
clausula = clausula+" ORDER BY login ";
list = dao.listarUsuario(clausula);

int cont = 0;
%>
<h1 class="cabecalho_pagina">Cadastro de Usuário</h1>
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<body onload="document.forms[0].elements[0].focus();" >
<form action="listarUsuario.jsp">
<table colspan="2">
  <tr>
    <th class='label'>Login</th>
    <td><input type="text" name="nomeUsuario" <%if (nomeUsuario!= null) { %>value="<%=nomeUsuario %>"<% }%>  size="40" maxlength="40"></td>
    <td><input class="button" type="button" value="Localizar" onClick="javascript: localizar();" /></td>
    <td><input class="button" type="button" value="Nova pesquisa" onClick="javascript: novaPesquisa();" /></td>
  </tr>
  <tr>
    <th class="label">Status</th>
    <td class="label_radio">
      <input type="radio" class="radio" name="status" value="" <%= (status.equals("")? "checked": "") %>>Todos
      <input type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Ativo
      <input type="radio" class="radio" name="status" value="I" <%= (status.equals("I")? "checked": "") %>>Inativo</td>
  </tr>
</table>
<hr>

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr">
      <th class="grid">&nbsp;</th>
      <th class="grid"><center>Login</center></th>
      <th class="grid">Status</th>
      <th class="grid">Excluir</th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	Usuario usuario = (Usuario) it.next();
	cont++;

%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid"><center><a href="formUsuario.jsp?acao=atu&idUsuario=<%=usuario.getIdUsuario()%>"><%=usuario.getLogin() %></a></center></td>
      <td class = "grid" width="5%"><center><%=usuario.getStatus()%></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=usuario.getIdUsuario()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
  	</tr>
<%
}
%>   
</table>
</form>
<%@include file="../fimConexao.jsp"%>