<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.Grupo" %>
<%@ page import="afero.model.SubGrupo" %>
<%@ page import="afero.persistence.GrupoDAO" %>
<%@ page import="afero.persistence.SubGrupoDAO" %>
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
       location.href = 'listarSubGrupo.jsp?acao=exc&idSubGrupo=' + id;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.nomeSubGrupo.value = '';
  document.all.status.value = ''; //não está limpando
  document.forms[0].submit();
}  
</script>

<%
SubGrupoDAO dao;
SubGrupoDAO daoExclusao;
GrupoDAO dao1;
ConverteDate conDate = new ConverteDate();

String acao = request.getParameter("acao");
if (acao == null) acao = "listar";

String idSubGrupo = "";
String idGrupo = "";
String nomeSubGrupo = "";
String status = "A";
String clausula = "";
String dsSubGrupo = "";
String usuario = (String)session.getAttribute("Login");
String mensagem = request.getParameter("mensagem");
if(mensagem == null) mensagem="";

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
	nomeSubGrupo = request.getParameter("nomeSubGrupo");
	idSubGrupo = request.getParameter("idSubGrupo");
	idGrupo = request.getParameter("idGrupo");
	dsSubGrupo = request.getParameter("dsSubGrupo");
    status =request.getParameter("status");
    if (idGrupo == null)idGrupo = "0";
    if (idSubGrupo == null) idSubGrupo = "0";
    if (dsSubGrupo == null) dsSubGrupo = "";
    if (nomeSubGrupo == null) nomeSubGrupo = "";
    if (status == null) status = "A";  

    SubGrupo subGrupo = new SubGrupo();

	try {
	  if (!acao.equalsIgnoreCase("inc")){
		  subGrupo.setIdSubGrupo(Integer.parseInt(idSubGrupo));
	  }
	  subGrupo.setDsSubGrupo(dsSubGrupo);
      subGrupo.setStatus(status);
      subGrupo.setIdGrupo(Integer.parseInt(idGrupo));
      subGrupo.setUsuario(usuario);
	  
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}

  dao = new SubGrupoDAO(conn);
  daoExclusao = new SubGrupoDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {
	  //inclui no banco de dados
  	dao.incluir(subGrupo);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
	  if(!dao.AtualizarIdSubGrupo(Integer.parseInt(idSubGrupo), Integer.parseInt(idGrupo))){
		  dao.atualizar(subGrupo);
	  }else{
		  response.sendRedirect("listarSubGrupo.jsp?mensagem=Atualização Inválida! Item já possui lançamentos.&acao=listar");
	  }
	 

  } else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  if(!daoExclusao.exclusaoIdSubGrupo(Integer.parseInt(idSubGrupo))){
		  dao.excluir(subGrupo);
	  }else{
		  response.sendRedirect("listarSubGrupo.jsp?mensagem=Exclusão Inválida! Item já possui lançamentos.&acao=listar");
	  }
	  
  }
} else {
 if (!acao.equalsIgnoreCase("voltar")) {
    nomeSubGrupo = request.getParameter("nomeSubGrupo");
    status = request.getParameter("status");
    if (status == null) status = "";
  }

  if (nomeSubGrupo!= null) {
    clausula = " WHERE dsSubGrupo LIKE '"+nomeSubGrupo+"%'";
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
dao = new SubGrupoDAO(conn);
clausula = clausula+" ORDER BY idGrupo, dsSubGrupo ";
list = dao.listarSubGrupo(clausula);

int cont = 0;
%>
<h1 class="cabecalho_pagina">Cadastro de Subgrupo</h1>

|<a class="button" href="formSubGrupo.jsp?acao=inc">Novo Cadastro</a>|<br>

<body onload="document.forms[0].elements[0].focus();" >
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<form action="listarSubGrupo.jsp">
<table colspan="2">
  <tr>
    <th class='label'>Descrição Subgrupo</th>
    <td><input type="text" name="nomeSubGrupo" <%if (nomeSubGrupo != null) { %>value="<%=nomeSubGrupo %>"<% }%>  size="40" maxlength="40"></td>
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
      <th class="grid"><center>Descrição Subgrupo</center></th>
      <th class="grid"><center>Descrição Grupo</center></th>
      <th class="grid">Status</th>
      <th class="grid">Excluir</th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	SubGrupo subGrupo = (SubGrupo) it.next();
  dao1 = new GrupoDAO(conn);
	Grupo grupo = dao1.procurarGrupo(subGrupo.getIdGrupo());
	cont++;

%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid"><center><a href="formSubGrupo.jsp?acao=atu&idSubGrupo=<%=subGrupo.getIdSubGrupo()%>"><%=subGrupo.getDsSubGrupo()%> </a></center></td>
      <td class = "grid"><center><%=grupo.getDsGrupo()%></center></td>
      <td class = "grid" width="5%"><center><%=subGrupo.getStatus()%></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=subGrupo.getIdSubGrupo()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
  	</tr>
<%
}
%>   
</table>
</form>
<p align="right">|<a class="button" href="formSubGrupo.jsp?acao=inc">Novo Cadastro</a>|
<%@include file="../fimConexao.jsp"%>