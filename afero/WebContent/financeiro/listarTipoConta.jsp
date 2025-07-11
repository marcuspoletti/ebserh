<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.TipoConta" %>
<%@ page import="afero.persistence.TipoContaDAO" %>
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
       location.href = 'listarTipoConta.jsp?acao=exc&idTipoConta=' + id;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.dsTipoConta.value = '';
  document.all.status.value = ''; //não está limpando
  document.forms[0].submit();
}  
</script>

<%
TipoContaDAO dao;
TipoContaDAO daoExclusao;
ConverteDate conDate = new ConverteDate();
String mensagem = request.getParameter("mensagem");
if(mensagem == null)mensagem = "";
String acao = request.getParameter("acao");
if (acao == null) acao = "listar";
String dsTipoConta = "";
String status ="A";
String clausula = "";
String idTipoConta = "";


if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
	
	idTipoConta = request.getParameter("idTipoConta");
	dsTipoConta = request.getParameter("dsTipoConta");
  status =request.getParameter("status");
  if(idTipoConta == null)idTipoConta = "0";
  if(dsTipoConta == null)dsTipoConta = "";
  if(status == null)status = "A";
  TipoConta tipoConta = new TipoConta();
  
	try {
	  if (!acao.equalsIgnoreCase("inc")){
		  tipoConta.setIdTipoConta(Integer.parseInt(idTipoConta));
	  }
	  
      tipoConta.setDsTipoConta(dsTipoConta);
      tipoConta.setStatus(status);
      if (!acao.equalsIgnoreCase("exc")){
    	  tipoConta.setIdTipoConta(Integer.parseInt(idTipoConta));
      }
      
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}


  dao = new TipoContaDAO(conn);
  daoExclusao = new TipoContaDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {  
	  //inclui no banco de dados
  	dao.incluir(tipoConta);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
    	 dao.atualizar(tipoConta);
  }else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  if(!daoExclusao.exclusaoIdTipoConta(Integer.parseInt(idTipoConta))){
		  dao.excluir(tipoConta);
	  }else{
		  response.sendRedirect("listarBanco.jsp?mensagem=Exclusão Inválida! Item já possui lançamentos.&acao=listar");
	  }
	  
  }
} else {
 if (!acao.equalsIgnoreCase("voltar")) {
    dsTipoConta = request.getParameter("dsTipoConta");
    status = request.getParameter("status");
    if (status == null) status = "";
  }

  if (dsTipoConta!= null) {
    clausula = " WHERE dsTipoConta LIKE '"+dsTipoConta+"%'";
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
dao = new TipoContaDAO(conn);
clausula = clausula+" ORDER BY dsTipoConta ";
list = dao.listarTipoConta(clausula);

int cont = 0;
%>
<h1 class="cabecalho_pagina">Cadastro de Tipo de Conta</h1>

|<a class="button" href="formTipoConta.jsp?acao=inc">Novo Cadastro</a>|<br>

<body onload="document.forms[0].elements[0].focus();" >
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<form action="listarTipoConta.jsp">
<table colspan="2">
  <tr>
    <th class='label'>Descrição Tipo Conta</th>
    <td><input type="text" name="dsTipoConta" <%if (dsTipoConta != null) { %>value="<%=dsTipoConta %>"<% }%>  size="40" maxlength="40"></td>
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
      <th class="grid"><center>Descrição do Tipo de Conta</center></th>
      <th class="grid">Status</th>
      <th class="grid">Excluir</th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
String msgStatus = "";
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	TipoConta tipoConta = (TipoConta) it.next();
	if(tipoConta.getStatus().equals("I")){
		msgStatus = "INATIVO";
	}else{
		msgStatus = "ATIVO";
	}
    cont++;

%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid"><center><a href="formTipoConta.jsp?acao=atu&idTipoConta=<%=tipoConta.getIdTipoConta()%>"><%=tipoConta.getDsTipoConta()%> </a></center></td>
      <td class = "grid" width="5%"><center><%=msgStatus%></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=tipoConta.getIdTipoConta()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
  	</tr>
<%
}
%>   
</table>
</form>
<p align="right">|<a class="button" href="formTipoConta.jsp?acao=inc">Novo Cadastro</a>|
