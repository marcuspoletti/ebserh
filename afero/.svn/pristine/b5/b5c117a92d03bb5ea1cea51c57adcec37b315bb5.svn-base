<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.FormaPagto" %>
<%@ page import="afero.persistence.FormaPagtoDAO" %>
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
       location.href = 'listarFormaPagto.jsp?acao=exc&cdFormaPagto=' + id;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.dsFormaPagto.value = '';
  document.all.status.value = ''; //não está limpando
  document.forms[0].submit();
}  
</script>

<%
FormaPagtoDAO dao;
FormaPagtoDAO daoExclusao;
ConverteDate conDate = new ConverteDate();
String mensagem = request.getParameter("mensagem");
if(mensagem == null)mensagem = "";
String acao = request.getParameter("acao");
if (acao == null) acao = "listar";
String dsFormaPagto = "";
String status ="A";
String clausula = "";
String cdFormaPagto = "";


if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
	
	cdFormaPagto = request.getParameter("cdFormaPagto");
	dsFormaPagto = request.getParameter("dsFormaPagto");
    status =request.getParameter("status");
    if(cdFormaPagto == null)cdFormaPagto = "0";
    if(dsFormaPagto == null)dsFormaPagto = "";
    if(status == null)status = "A";
    FormaPagto formaPagto = new FormaPagto();
  
	try {
	  if (!acao.equalsIgnoreCase("inc")){
		  formaPagto.setCdFormaPagto(Integer.parseInt(cdFormaPagto));
	  }
	  
	  formaPagto.setDsFormaPagto(dsFormaPagto);
	  formaPagto.setStatus(status);
      if (!acao.equalsIgnoreCase("exc")){
    	  formaPagto.setCdFormaPagto(Integer.parseInt(cdFormaPagto)); 
      }
      
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}


  dao = new FormaPagtoDAO(conn);
  daoExclusao = new FormaPagtoDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {  
	  //inclui no banco de dados
  	dao.incluir(formaPagto);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
    	 dao.atualizar(formaPagto);
  }else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  if(!daoExclusao.exclusaoCdFormaPagto(Integer.parseInt(cdFormaPagto))){
		  dao.excluir(formaPagto);
	  }else{
		  response.sendRedirect("listarFormaPagto.jsp?mensagem=Exclusão Inválida! Item já possui lançamentos.&acao=listar");
	  }
	  
  }
} else {
 if (!acao.equalsIgnoreCase("voltar")) {
	 dsFormaPagto = request.getParameter("dsFormaPagto");
     status = request.getParameter("status");
     if (status == null) status = "";
  }

  if (dsFormaPagto!= null) {
    clausula = " WHERE dsFormaPagto LIKE '"+dsFormaPagto+"%'";
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
dao = new FormaPagtoDAO(conn);
clausula = clausula+" ORDER BY dsFormaPagto ";
list = dao.listarFormaPagto(clausula);

int cont = 0;
%>
<h1 class="cabecalho_pagina">Cadastro de Forma de Pagamento</h1>

|<a class="button" href="formFormaPagto.jsp?acao=inc">Novo Cadastro</a>|<br>

<body onload="document.forms[0].elements[0].focus();" >
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<form action="listarFormaPagto.jsp">
<table colspan="2">
  <tr>
    <th class='label'>Descrição Forma Pagto</th>
    <td><input type="text" name="dsFormaPagto" <%if (dsFormaPagto != null) { %>value="<%=dsFormaPagto %>"<% }%>  size="40" maxlength="40"></td>
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
      <th class="grid"><center>Descrição da Forma de Pagamento</center></th>
      <th class="grid">Status</th>
      <th class="grid">Excluir</th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
String msgStatus = "";
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	FormaPagto formaPagto = (FormaPagto) it.next();
	if(formaPagto.getStatus().equals("I")){
		msgStatus = "INATIVO";
	}else{
		msgStatus = "ATIVO";
	}
    cont++;

%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid"><center><a href="formFormaPagto.jsp?acao=atu&cdFormaPagto=<%=formaPagto.getCdFormaPagto()%>"><%=formaPagto.getDsFormaPagto()%> </a></center></td>
      <td class = "grid" width="5%"><center><%=msgStatus%></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=formaPagto.getCdFormaPagto()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
  	</tr>
<%
}
%>   
</table>
</form>
<p align="right">|<a class="button" href="formFormaPagto.jsp?acao=inc">Novo Cadastro</a>|