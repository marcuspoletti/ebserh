<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.Unidade" %>
<%@ page import="afero.persistence.UnidadeDAO" %>
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
       location.href = 'listarUnidade.jsp?acao=exc&idUnidade=' + id;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.nomeUnidade.value = '';
  document.all.status.value = ''; //não está limpando
  document.forms[0].submit();
}  
</script>

<%
UnidadeDAO dao;
UnidadeDAO daoExclusao;
ConverteDate conDate = new ConverteDate();
String mensagem = request.getParameter("mensagem");
if(mensagem == null)mensagem = "";
String acao = request.getParameter("acao");
if (acao == null) acao = "listar";

String dsUnidade = "";
String status ="A";
String dtCad = "";
String dtMod = "";
String nomeUnidade = "";
String clausula = "";
String idUnidade = "";
String usuario = "";

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
	idUnidade = request.getParameter("idUnidade");
	dsUnidade = request.getParameter("dsUnidade");
    status =request.getParameter("status");
    nomeUnidade = request.getParameter("nomeUnidade");
    if(idUnidade == null)idUnidade = "0";
    if(dsUnidade == null)dsUnidade = "";
    if(status == null)status = "A";
    if(nomeUnidade == null)nomeUnidade ="";
   
  
   usuario = (String)session.getAttribute("Login");
   Unidade unidade = new Unidade();

	try {
	  if (!acao.equalsIgnoreCase("inc")){
		 unidade.setIdUnidade(Integer.parseInt(idUnidade));
	  }
      unidade.setDsUnidade(dsUnidade);
      unidade.setStatus(status);
      unidade.setUsuario(usuario);
	  
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}

  dao = new UnidadeDAO(conn);
  daoExclusao = new UnidadeDAO(conn);
  if (acao.equalsIgnoreCase("inc")) {
	  //inclui no banco de dados
  	dao.incluir(unidade);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
	  dao.atualizar(unidade);

  } else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  if(!daoExclusao.exclusaIdUnidade(Integer.parseInt(idUnidade))){
		  dao.excluir(unidade);
	  }else{
		  response.sendRedirect("listarUnidade.jsp?mensagem=Exclusão Inválida! Item já possui lançamentos.&acao=listar");
	  }
	  
  }
} else {
 if (!acao.equalsIgnoreCase("voltar")) {
    nomeUnidade = request.getParameter("nomeUnidade");
    status = request.getParameter("status");
    if (status == null) status = "";
  }

  if (nomeUnidade!= null) {
    clausula = " WHERE dsUnidade LIKE '"+nomeUnidade+"%'";
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
dao = new UnidadeDAO(conn);
clausula = clausula+" ORDER BY dsUnidade ";
list = dao.listarUnidade(clausula);

int cont = 0;
%>
<h1 class="cabecalho_pagina">Cadastro de Grupo</h1>
|<a class="button" href="formUnidade.jsp?acao=inc">Novo Cadastro</a>|<br>
<body onload="document.forms[0].elements[0].focus();" >
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<form action="listarUnidade.jsp">
<table colspan="2">
  <tr>
    <th class='label'>Descrição do Grupo</th>
    <td><input type="text" name="nomeGrupo" <%if (nomeUnidade != null) { %>value="<%=nomeUnidade %>"<% }%>  size="40" maxlength="40"></td>
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
      <th class="grid"><center>Descrição da Unidade</center></th>
      <th class="grid">Status</th>
      <th class="grid">Excluir</th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	Unidade unidade = (Unidade) it.next();
	cont++;

%>
   <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid"><center><a href="formUnidade.jsp?acao=atu&idUnidade=<%=unidade.getIdUnidade()%>"><%=unidade.getDsUnidade()%></a></center></td>
      <td class = "grid" width="5%"><center><%=unidade.getStatus()%></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=unidade.getIdUnidade()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
  	</tr>
<%
}
%>      
</table>
</form>
<p align="right">|<a class="button" href="formUnidade.jsp?acao=inc">Novo Cadastro</a>|
<%@include file="../fimConexao.jsp"%>