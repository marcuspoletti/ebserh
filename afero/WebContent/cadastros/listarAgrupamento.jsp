<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.Agrupamento" %>
<%@ page import="afero.persistence.AgrupamentoDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function confirmaExcluir(cont, id) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarAgrupamento.jsp?acao=exc&idAgrupamento=' + id;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.nmCidade.value = '';
  document.all.status.value = ''; //não está limpando
  document.forms[0].submit();
}  
</script>

<%
AgrupamentoDAO dao;
String acao = request.getParameter("acao");
if (acao == null) acao = "listar";
String mensagem = request.getParameter("mensagem");
if(mensagem == null) mensagem="";
String nmAgrupamento = "";
String status = "A";
String clausula = "";

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
  String idAgrupamento = request.getParameter("idAgrupamento");
  String dsAgrupamento = request.getParameter("dsAgrupamento");
  status = request.getParameter("status");
  if (idAgrupamento == null) idAgrupamento = "";
  if (dsAgrupamento == null) dsAgrupamento = "";
  if (status == null) status = "A";

  Agrupamento agrupamento = new Agrupamento();

	try {
	  if (!acao.equalsIgnoreCase("inc")){
		  agrupamento.setIdAgrupamento(Integer.parseInt(idAgrupamento));
	  }
	  agrupamento.setDsAgrupamento(dsAgrupamento);
	  agrupamento.setStatus(status);
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}

  dao = new AgrupamentoDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {
	  //inclui no banco de dados
  	dao.incluir(agrupamento);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
	  dao.atualizar(agrupamento);

  } else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  if(!dao.exclusaoIdAgrupamento(Integer.parseInt(idAgrupamento))){
		  dao.excluir(agrupamento);
	  }else{
		  response.sendRedirect("listarAgrupamento.jsp?mensagem=Exclusão Inválida! Item já possui lançamentos.&acao=listar");
	  }
  }
} else {
  if (!acao.equalsIgnoreCase("voltar")) {
    nmAgrupamento = request.getParameter("nmAgrupamento");
    status = request.getParameter("status");
    if (status == null) status = "";
  }

  if (nmAgrupamento != null) {
    clausula = " WHERE dsAgrupamento LIKE '"+nmAgrupamento+"%'";
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
dao = new AgrupamentoDAO(conn);
clausula = clausula+" ORDER BY dsAgrupamento";
list = dao.listarAgrupamento(clausula);

int cont = 0;
%>
<h1 class="cabecalho_pagina">Cadastro de Agrupamento</h1>

|<a class="button" href="formAgrupamento.jsp?acao=inc">Novo Cadastro</a>|<br>
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<body onload="document.forms[0].elements[0].focus();" >
<form action="listarAgrupamento.jsp">
<table colspan="2">
  <tr>
    <th class='label'>Descrição do Agrupamento</th>
    <td><input type="text" name="nmAgrupamento" <%if (nmAgrupamento != null) { %>value="<%=nmAgrupamento%>"<% }%>  size="40" maxlength="40"></td>
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
      <th class="grid"><center>Descrição do Agrupamento</center></th>
      <th class="grid">Status</th>
      <th class="grid">Excluir</th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	Agrupamento agru = (Agrupamento) it.next();
	cont++;
%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid"><center><a href="formAgrupamento.jsp?acao=atu&idAgrupamento=<%=agru.getIdAgrupamento()%>"><%=agru.getDsAgrupamento()%></a></center></td>
      <td class = "grid" width="5%"><center><%=agru.getStatus()%></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=agru.getIdAgrupamento()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
  	</tr>
<%
}
%>   
</table>
</form>
<%@include file="../fimConexao.jsp"%>
<p align="right">|<a class="button" href="formAgrupamento.jsp?acao=inc">Novo Cadastro</a>|