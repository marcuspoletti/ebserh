<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.Grupo" %>
<%@ page import="afero.persistence.GrupoDAO" %>
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
       location.href = 'listarGrupo.jsp?acao=exc&idGrupo=' + id;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.nomeGrupo.value = '';
  document.all.status.value = ''; //não está limpando
  document.forms[0].submit();
}  
</script>

<%
GrupoDAO dao;
GrupoDAO daoExclusao;
ConverteDate conDate = new ConverteDate();

String acao = request.getParameter("acao");
if (acao == null) acao = "listar";

String dsGrupo = "";
String status ="A";
String dtCad = "";
String dtMod = "";
String nomeGrupo = "";
String clausula = "";
String idGrupo = "";
String usuario = (String)session.getAttribute("Login");
String mensagem = request.getParameter("mensagem");
if(mensagem == null)mensagem="";

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
	idGrupo = request.getParameter("idGrupo");
	dsGrupo = request.getParameter("dsGrupo");
    status =request.getParameter("status");
    nomeGrupo = request.getParameter("nomeGrupo");
    if(idGrupo == null)idGrupo = "0";
    if(dsGrupo == null)dsGrupo = "";
    if(status == null)status = "A";
    if(nomeGrupo == null)nomeGrupo ="";
   
  

   Grupo grupo = new Grupo();

	try {
	  if (!acao.equalsIgnoreCase("inc")){
		  grupo.setIdGrupo(Integer.parseInt(idGrupo));
	  }
      grupo.setDsGrupo(dsGrupo);
      grupo.setStatus(status);
      grupo.setUsuario(usuario);
	  
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}

  dao = new GrupoDAO(conn);
  daoExclusao = new GrupoDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {
	  //inclui no banco de dados
  	dao.incluir(grupo);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
	  dao.atualizar(grupo);

  } else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  if(!daoExclusao.exclusaoIdGrupo(Integer.parseInt(idGrupo))){
		  dao.excluir(grupo);
	  }else{
		  response.sendRedirect("listarGrupo.jsp?mensagem=Exclusão Inválida! Item já possui lançamentos.&acao=listar");
	  }
	  
  }
} else {
 if (!acao.equalsIgnoreCase("voltar")) {
    nomeGrupo = request.getParameter("nomeGrupo");
    status = request.getParameter("status");
    if (status == null) status = "";
  }

  if (nomeGrupo!= null) {
    clausula = " WHERE dsGrupo LIKE '"+nomeGrupo+"%'";
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
dao = new GrupoDAO(conn);
clausula = clausula+" ORDER BY dsGrupo ";
list = dao.listarGrupo(clausula);

int cont = 0;
%>
<h1 class="cabecalho_pagina">Cadastro de Grupo</h1>
|<a class="button" href="formGrupo.jsp?acao=inc">Novo Cadastro</a>|<br>
<body onload="document.forms[0].elements[0].focus();" >
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<form action="listarGrupo.jsp">
<table colspan="2">
  <tr>
    <th class='label'>Descrição do Grupo</th>
    <td><input type="text" name="nomeGrupo" <%if (nomeGrupo != null) { %>value="<%=nomeGrupo %>"<% }%>  size="40" maxlength="40"></td>
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
      <th class="grid"><center>Descrição do Grupo</center></th>
      <th class="grid">Status</th>
      <th class="grid">Excluir</th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	Grupo grupo = (Grupo) it.next();
	cont++;

%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid"><center><a href="formGrupo.jsp?acao=atu&idGrupo=<%=grupo.getIdGrupo()%>"><%=grupo.getDsGrupo()%></a></center></td>
      <td class = "grid" width="5%"><center><%=grupo.getStatus()%></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=grupo.getIdGrupo()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
  	</tr>
<%
}
%>   
</table>
</form>
<p align="right">|<a class="button" href="formGrupo.jsp?acao=inc">Novo Cadastro</a>|
<%@include file="../fimConexao.jsp"%>