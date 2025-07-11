<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.ListaTarefa" %>
<%@ page import="afero.persistence.ListaTarefaDAO" %>
<%@ page import="afero.util.Utilitaria" %>
<%@ page import="afero.util.ConverteDate" %>

<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function confirmaExcluir(cont, id) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarListaTarefa.jsp?acao=exc&idListaTarefa=' + id;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.dsPesquisaTarefaTarefa.value = '';
  document.all.status.value = ''; //não está limpando
  document.forms[0].submit();
}  
</script>

<%
ListaTarefaDAO dao;
ListaTarefaDAO daoExclusao;

String mensagem = request.getParameter("mensagem");
if(mensagem == null)mensagem = "";
String acao = request.getParameter("acao");
if (acao == null) acao = "listar";
String dsPesquisaTarefa = request.getParameter("dsPesquisaTarefa");
String clausula = "";

String idListaTarefa;
String idLoja;
String dsListaTarefa;
String preco;
String idUnidade;
String status = "";
String dtCad;
String dtMod;
String usuario;


if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
	
	idListaTarefa = request.getParameter("idListaTarefa");
	idLoja = request.getParameter("idLoja");
	dsListaTarefa = request.getParameter("dsListaTarefa");
	preco = request.getParameter("preco");
	idUnidade = request.getParameter("idUnidade");
	status = request.getParameter("status");
	dtCad = request.getParameter("dtCad");
	dtMod = request.getParameter("dtMod");
	usuario = (String) session.getAttribute("Login");
	
	if(idListaTarefa == null) idListaTarefa = "0";
	if(idLoja == null) idLoja = "0";
	if(dsListaTarefa == null) dsListaTarefa = "";
	if(preco == null) preco = "0";
	if(idUnidade == null) idUnidade = "0";
	if(status == null) status = "A";
	if(dtCad == null) dtCad = "";
	if(dtMod == null) dtMod = "";

	ListaTarefa listaTarefa = new ListaTarefa();
  
	try {
	  if (!acao.equalsIgnoreCase("inc")){
		listaTarefa.setIdListaTarefa(Integer.parseInt(idListaTarefa));
	  }
	  	listaTarefa.setIdLoja(Integer.parseInt(idLoja));
		listaTarefa.setDsListaTarefa(dsListaTarefa);
		listaTarefa.setPreco(Utilitaria.toNumber(preco).floatValue());
		listaTarefa.setIdUnidade(Integer.parseInt(idUnidade));
		listaTarefa.setStatus(status);
		listaTarefa.setUsuario(usuario);    
      
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}

	dao = new ListaTarefaDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {  
	  //inclui no banco de dados
  	dao.incluir(listaTarefa);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
    	 dao.atualiza(listaTarefa);
  }else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
		  dao.excluir(listaTarefa);
  }
}else {
 if (!acao.equalsIgnoreCase("voltar")) {
	 dsPesquisaTarefa = request.getParameter("dsPesquisaTarefa");
    status = request.getParameter("status");
    if (status == null) status = "";
  }
 if(dsPesquisaTarefa != null){
	 clausula = " WHERE dsListaTarefa LIKE '"+dsPesquisaTarefa+"%'";
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
dao = new ListaTarefaDAO(conn);
clausula = clausula +" ORDER BY dsListaTarefa ";
list = dao.listarTarefa(clausula);
int cont = 0;
%>
<h1 class="cabecalho_pagina">Lista de Tarefa</h1>

|<a class="button" href="formListaTarefa.jsp?acao=inc">Novo Cadastro</a>|<br>

<body onload="document.forms[0].elements[0].focus();" >
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<form action="listarListaTarefa.jsp">
<table colspan="2">
  <tr>
    <th class='label'>Descrição Serviços</th>
    <td><input type="text" name="dsPesquisaTarefa" <%if (dsPesquisaTarefa != null) { %>value="<%=dsPesquisaTarefa %>"<% }%>  size="40" maxlength="40"></td>
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
    <tr>
      <th class="grid">&nbsp;</th>
      <th class="grid"><center>Descrição</center></th>
            <th class="grid">Preço</th>
      <th class="grid">Status</th>
      <th class="grid">Excluir</th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
String msgStatus = "";
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	ListaTarefa listaTarefa = (ListaTarefa) it.next();
	if(listaTarefa.getStatus().equalsIgnoreCase("I")){
		msgStatus = "INATIVO";
	}else{
		msgStatus = "ATIVO";
	}
    cont++;

%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid"><center><a href="formListaTarefa.jsp?acao=atu&idListaTarefa=<%=listaTarefa.getIdListaTarefa() %>"><%=listaTarefa.getDsListaTarefa()%> </a></center></td>
      <td class = "grid" width="5%"><center><%=listaTarefa.getPreco()%></center></td>
      <td class = "grid" width="5%"><center><%=msgStatus%></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=listaTarefa.getIdListaTarefa() %>);"><img border = "0" src="../images/delete.gif"></a></center></td>
  	</tr>
<%
}
%>   
</table>
</form>
<p align="right">|<a class="button" href="formListaTarefa.jsp?acao=inc">Novo Cadastro</a>|