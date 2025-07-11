<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.Banco" %>
<%@ page import="afero.persistence.BancoDAO" %>
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
       location.href = 'listarBanco.jsp?acao=exc&idBanco=' + id;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.nmBanco.value = '';
  document.all.status.value = ''; //não está limpando
  document.forms[0].submit();
}  
</script>

<%
BancoDAO dao;
BancoDAO daoExclusao;
ConverteDate conDate = new ConverteDate();

String acao = request.getParameter("acao");
if (acao == null) acao = "listar";
String mensagem = request.getParameter("mensagem");
if(mensagem == null) mensagem="";
String nmBanco = "";
String status ="A";
String nrBanco = "";
String clausula = "";
String idBanco = "";

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
	idBanco = request.getParameter("idBanco");
	nmBanco = request.getParameter("nmBanco");
  status =request.getParameter("status");
  nrBanco = request.getParameter("nrBanco");
  if(idBanco == null)idBanco = "0";
  if(nmBanco == null)nmBanco = "";
  if(status == null)status = "A";
  if(nrBanco == null)nrBanco ="";
  Banco banco = new Banco();
  
	try {
	  if (!acao.equalsIgnoreCase("inc")){
		  banco.setIdBanco(Integer.parseInt(idBanco));
	  }
	  
      banco.setNmBanco(nmBanco);
      banco.setNrBanco(nrBanco);
      banco.setStatus(status);
      if (!acao.equalsIgnoreCase("exc")){
       	  banco.setIdBanco(Integer.parseInt(idBanco)); 
      }
      
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}

  dao = new BancoDAO(conn);
  daoExclusao = new BancoDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {  
	  //inclui no banco de dados
  	dao.incluir(banco);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
    dao.atualizar(banco);
	  
  } else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  if(!daoExclusao.exclusaoIdBanco(Integer.parseInt(idBanco))){
		  dao.excluir(banco);
	  } else{
		  response.sendRedirect("listarBanco.jsp?mensagem=Exclusão Inválida! Item já possui lançamentos.&acao=listar");
	  }
	  
  }
} else {
  if (!acao.equalsIgnoreCase("voltar")) {
    nmBanco = request.getParameter("nmBanco");
    status = request.getParameter("status");
    if (status == null) status = "";
  }

  if (nmBanco!= null) {
    clausula = " WHERE nmBanco LIKE '"+nmBanco+"%'";
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
dao = new BancoDAO(conn);
clausula = clausula+" ORDER BY nmBanco ";
list = dao.listarBanco(clausula);

int cont = 0;
%>
<h1 class="cabecalho_pagina">Cadastro de Banco</h1>

|<a class="button" href="formBanco.jsp?acao=inc">Novo Cadastro</a>|<br>

<body onload="document.forms[0].elements[0].focus();" >
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<form action="listarBanco.jsp">
<table colspan="2">
  <tr>
    <th class='label'>Nome do Banco</th>
    <td><input type="text" name="nmBanco" <%if (nmBanco != null) { %>value="<%=nmBanco %>"<% }%>  size="40" maxlength="40"></td>
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
      <th class="grid"><center>Nome do Banco</center></th>
      <th class="grid"><center>Número do Banco</center></th>
      <th class="grid">Status</th>
      <th class="grid">Excluir</th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
String msgStatus = "";
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	Banco banco = (Banco) it.next();
	if(banco.getStatus().equals("I")){
		msgStatus = "INATIVO";
	}else{
		msgStatus = "ATIVO";
	}
    cont++;

%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid"><center><a href="formBanco.jsp?acao=atu&idBanco=<%=banco.getIdBanco()%>"><%=banco.getNmBanco()%> </a></center></td>
      <td class = "grid"><center><%=banco.getNrBanco()%></center></td>
      <td class = "grid" width="5%"><center><%=msgStatus%></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=banco.getIdBanco()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
  	</tr>
<%
}
%>   
</table>
</form>
<p align="right">|<a class="button" href="formBanco.jsp?acao=inc">Novo Cadastro</a>|

