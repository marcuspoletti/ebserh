<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.Cnae" %>
<%@ page import="afero.persistence.CnaeDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function confirmaExcluir(cont, id) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarCnae.jsp?acao=exc&idCnae=' + id;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.descricao.value = '';
  document.forms[0].submit();
}  
</script>

<%
CnaeDAO dao;
String descricao = "";;
String clausula = "";
String acao = request.getParameter("acao");
if (acao == null) acao = "listar";
String mensagem = request.getParameter("mensagem");
if(mensagem == null) mensagem="";
String secao = "";
String divisao = "";
String grupo = "";
String classe = "";
String subclasse = "";
String denominacao = "";

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
  String idCnae = request.getParameter("idCnae");
  secao = request.getParameter("secao");
  divisao = request.getParameter("divisao");
  grupo = request.getParameter("grupo");
  classe = request.getParameter("classe");
  subclasse = request.getParameter("subclasse");
  denominacao = request.getParameter("denominacao");
  
  if (idCnae == null) idCnae = "0";
  if (secao == null)secao = "";
  if (divisao == null) divisao = "";
  if (grupo == null) grupo = "";
  if (classe == null) classe = "";
  if (subclasse == null) subclasse = "";
  if (denominacao == null) denominacao = "";

  Cnae cnae = new Cnae();

	try {
	  if (!acao.equalsIgnoreCase("inc")){
		  cnae.setIdCnae(Integer.parseInt(idCnae));
	  }
	  cnae.setSecao(secao);
	  cnae.setDivisao(divisao);
	  cnae.setGrupo(grupo);
	  cnae.setClasse(classe);
	  cnae.setSubclasse(subclasse);
	  cnae.setDenominacao(denominacao);
	  
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}

  dao = new CnaeDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {
	  //inclui no banco de dados
  	dao.incluir(cnae);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
	  dao.atualizar(cnae);

  } else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  if(!dao.exclusaoIdCnae(Integer.parseInt(idCnae))){
		  dao.excluir(cnae);
	  }else{
		  response.sendRedirect("listarCrt.jsp?mensagem=Exclusão Inválida! Item já possui lançamentos.&acao=listar");
	  }
  }
} else {
  if (!acao.equalsIgnoreCase("voltar")) {
	descricao = request.getParameter("descricao");
  }

  if (descricao != null) {
    clausula = " WHERE denominacao LIKE '%"+descricao+"%'";
  } 
}
//seleciona todos os registros do banco de dados
List list;
dao = new CnaeDAO(conn);
clausula = clausula+" ORDER BY denominacao";
list = dao.listarCnae(clausula);

int cont = 0;
%>
<h1 class="cabecalho_pagina">Cadastro de CRT</h1>

|<a class="button" href="formCnae.jsp?acao=inc">Novo Cadastro</a>|<br>
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<body onload="document.forms[0].elements[0].focus();" >
<form action="listarCnae.jsp">
<table colspan="2">
  <tr>
    <th class='label'>Descrição</th>
    <td><input type="text" name="descricao" <%if (descricao != null) { %>value="<%=descricao%>"<% }%>  size="40" maxlength="40"></td>
    <td><input class="button" type="button" value="Localizar" onClick="javascript: localizar();" /></td>
    <td><input class="button" type="button" value="Nova pesquisa" onClick="javascript: novaPesquisa();" /></td>
  </tr>
  
</table>
<hr>

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr>
      <th class="grid">&nbsp;</th>
      <th class="grid"><center>Classe</center></th>
      <th class="grid"><center>SubClasse</center></th>
      <th class="grid">Descrição</th>
      <th class="grid">Excluir</th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	Cnae cnaeListar = (Cnae) it.next();
	cont++;
%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <%if(cnaeListar.getClasse() != null){%>
      	<td class = "grid" width="2%"><center><%=cnaeListar.getClasse()%></center></td>
      <%}else{ %>
      <td class = "grid" width="3%"><center><%=" - "%></center></td>
      <%} %>
      <%if(cnaeListar.getSubclasse() != null){ %>
      	<td class = "grid" width="3%"><center><%=cnaeListar.getSubclasse()%></center></td>
      	<%}else{ %>
      	<td class = "grid" width="3%"><center><%=" - "%></center></td>
      	<%} %>
      <td class = "grid"><center><a href="formCnae.jsp?acao=atu&idCnae=<%=cnaeListar.getIdCnae()%>"><%=cnaeListar.getDenominacao()%></a></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=cnaeListar.getIdCnae()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
  	</tr>
<%
}
%>   
</table>
</form>
<%@include file="../fimConexao.jsp"%>
<p align="right">|<a class="button" href="formCnae.jsp?acao=inc">Novo Cadastro</a>|