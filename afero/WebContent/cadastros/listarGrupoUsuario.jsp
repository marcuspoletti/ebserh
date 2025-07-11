<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.GrupoUsuario" %>
<%@ page import="afero.persistence.GrupoUsuarioDAO" %>
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
       location.href = 'listarGrupoUsuario.jsp?acao=exc&idGrupoUsuario=' + id;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.nomeGrupoUsuario.value = '';
  document.all.status.value = ''; //não está limpando
  document.forms[0].submit();
}  
</script>

<%
GrupoUsuarioDAO dao;
ConverteDate conDate = new ConverteDate();

String acao = request.getParameter("acao");
if (acao == null) acao = "listar";

String idGrupoUsuario = "";
String dsGrupoUsuario= "";
String status = "A";
String nomeGrupoUsuario = "";
String clausula = "";

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
	idGrupoUsuario = request.getParameter("idGrupoUsuario");
    status =request.getParameter("status");
    dsGrupoUsuario = request.getParameter("dsGrupoUsuario");
    nomeGrupoUsuario = request.getParameter("nomeGrupoUsuario");
    if(idGrupoUsuario == null)idGrupoUsuario = "0";
    if(dsGrupoUsuario == null)dsGrupoUsuario = "";
    if(status == null)status = "A";
    if(nomeGrupoUsuario == null)nomeGrupoUsuario ="";
   
  
    GrupoUsuario grupoUsuario = new GrupoUsuario();

	try {
	  if (!acao.equalsIgnoreCase("inc")){
		  grupoUsuario.setIdGrupoUsuario(Integer.parseInt(idGrupoUsuario));
	  }
	  grupoUsuario.setDsGrupoUsuario(dsGrupoUsuario);
	  grupoUsuario.setStatus(status);
	  
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}

  dao = new GrupoUsuarioDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {
	  //inclui no banco de dados
  	dao.incluir(grupoUsuario);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
	  dao.atualizar(grupoUsuario);

  } else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  dao.excluir(grupoUsuario);
  }
} else {
 if (!acao.equalsIgnoreCase("voltar")) {
    nomeGrupoUsuario = request.getParameter("nomeGrupoUsuario");
    status = request.getParameter("status");
    if (status == null) status = "";
  }

  if (nomeGrupoUsuario!= null) {
    clausula = " WHERE login LIKE '"+nomeGrupoUsuario+"%'";
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
dao = new GrupoUsuarioDAO(conn);
clausula = clausula+" ORDER BY dsGrupoUsuario";
list = dao.listarGrupoUsuario(clausula);

int cont = 0;
%>
<h1 class="cabecalho_pagina">Cadastro de Grupo Usuário</h1>

|<a class="button" href="formGrupoUsuario.jsp?acao=inc">Novo Cadastro</a>|<br>
<hr>
<body onload="document.forms[0].elements[0].focus();" >
<form action="listarGrupoUsuario.jsp">
<table colspan="2">
  <tr>
    <th class='label'>Grupo de Usuario</th>
    <td><input type="text" name="nomeLogin" <%if (nomeGrupoUsuario != null) { %>value="<%=nomeGrupoUsuario %>"<% }%>  size="40" maxlength="40"></td>
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
      <th class="grid"><center>Grupo de Usuario</center></th>
      <th class="grid">Status</th>
      <th class="grid">Excluir</th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	GrupoUsuario grupoUsuario = (GrupoUsuario) it.next();
	cont++;

%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid"><center><a href="formGrupoUsuario.jsp?acao=atu&idGrupoUsuario=<%=grupoUsuario.getIdGrupoUsuario()%>"><%=grupoUsuario.getDsGrupoUsuario() %></a></center></td>
      <td class = "grid" width="5%"><center><%=grupoUsuario.getStatus()%></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=grupoUsuario.getIdGrupoUsuario()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
  	</tr>
<%
}
%>   
</table>
</form>
<p align="right">|<a class="button" href="formGrupoUsuario.jsp?acao=inc">Novo Cadastro</a>|
<%@include file="../fimConexao.jsp"%>