<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.OrcamentoEmpresaItem" %>
<%@ page import="afero.model.PlanoConta" %>
<%@ page import="afero.model.OrcamentoEmpresa" %>
<%@ page import="afero.persistence.OrcamentoEmpresaItemDAO" %>
<%@ page import="afero.persistence.OrcamentoEmpresaDAO" %>
<%@page import="afero.util.Utilitaria"%>
<%@ page import="afero.persistence.PlanoContaDAO" %>
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
       location.href = 'listarOrcamentoEmpresaItem.jsp?acao=exc&idOrcamentoEmpresaItem=' + id;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

</script>

<%

int contCredito = 0;
OrcamentoEmpresaItemDAO daoOrc = new OrcamentoEmpresaItemDAO(conn);
OrcamentoEmpresaItemDAO dao;
OrcamentoEmpresaItemDAO daoExclusao;
String frameDebito = "";
String frameCredito = "";
ConverteDate conDate = new ConverteDate();
String mensagem = request.getParameter("mensagem");
if(mensagem == null)mensagem = "";
String acao = request.getParameter("acao");
if (acao == null) acao = "listar";
String idOrcamentoEmpresaItem = "0";
String idOrcamentoEmpresa = request.getParameter("idOrcamentoEmpresa");
String idPlanoConta = "0";
String dtMov ="";
String dtComp = daoOrc.dataAtual();
String clausula = "";
String usuario = (String) session.getAttribute("Login");
double valor = 0;

idOrcamentoEmpresa = request.getParameter("idOrcamentoEmpresa");
if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
	
	idOrcamentoEmpresaItem = request.getParameter("idOrcamentoEmpresaItem");
	idOrcamentoEmpresa = request.getParameter("idOrcamentoEmpresa");
	idPlanoConta =request.getParameter("idPlanoConta");
	if(request.getParameter("valor") != null){
		valor = Utilitaria.toNumber(request.getParameter("valor")).doubleValue();	
	}
	dtComp = request.getParameter("dtComp");
    if(idOrcamentoEmpresaItem == null)idOrcamentoEmpresaItem = "0";
    if(idOrcamentoEmpresa == null)idOrcamentoEmpresa = "0";
    if(idPlanoConta == null)idPlanoConta = "0";
    if(dtComp == null)dtComp = daoOrc.dataAtual();
    OrcamentoEmpresaItem orcEmpItem = new OrcamentoEmpresaItem(); 
  
	try {
	  if (!acao.equalsIgnoreCase("inc")){
		  orcEmpItem.setIdOrcamentoEmpresaItem(Integer.parseInt(idOrcamentoEmpresaItem));
	  }
	  
	  orcEmpItem.setIdOrcamentoEmpresa(Integer.parseInt(idOrcamentoEmpresa));
	  orcEmpItem.setIdPlanoConta(Integer.parseInt(idPlanoConta));
	  orcEmpItem.setDtComp(ConverteDate.stringToDate(dtComp));
	  orcEmpItem.setUsuario(usuario);
	  orcEmpItem.setValor(valor);
	  //orcEmpItem.setDtMov(ConverteDate.stringToDate(dtMov));
      if (!acao.equalsIgnoreCase("exc")){
    	  orcEmpItem.setIdOrcamentoEmpresaItem(Integer.parseInt(idOrcamentoEmpresaItem)); 
      }
      
	}catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}


  dao = new OrcamentoEmpresaItemDAO(conn);
  daoExclusao = new OrcamentoEmpresaItemDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {  
	  //inclui no banco de dados
  	dao.incluir(orcEmpItem);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
    	 dao.atualizar(orcEmpItem);
  }else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  //if(!daoExclusao.exclusaoIdBanco(Integer.parseInt(idBanco))){
          dao.excluir(orcEmpItem);
	  //}else{
		//  response.sendRedirect("listarOrcamentoEmpresaItem.jsp?mensagem=Exclusão Inválida! Item já possui lançamentos.&acao=listar");
  }
	  
}
frameDebito="?idOrcamentoEmpresa="+idOrcamentoEmpresa;
frameCredito="?idOrcamentoEmpresa="+idOrcamentoEmpresa;

%>
<h1 class="cabecalho_pagina">Cadastro de Orçamento Item</h1>

|<a class="button" href="formOrcamentoEmpresaItem.jsp?acao=inc&idOrcamentoEmpresa=<%=idOrcamentoEmpresa%>">Novo Cadastro</a>|<br>

<body onload="document.forms[0].elements[0].focus();" >
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>

<table width="100%" border="0">
<tr>
 <th class="grid" colspan="2">DÉBITO</th>
</tr>
<tr>
 <td colspan="2">
  <iframe src="frameOrcamentoItemDebito.jsp<%=frameDebito%>" src2="" name="frameOrcamento" width="100%" height=200 scrolling="auto" align="top" frameborder="0" hspace="0" vspace="0" marginheight="0" marginwidth="0"></iframe>
 </td>
</tr>
<tr>
 <th class="grid" colspan="2">CREDITO</th>
</tr>
<tr>
 <td colspan="2">
  <iframe src="frameOrcamentoItemCredito.jsp<%=frameCredito%>" src2="" name="frameOrcamento" width="100%" height=200 scrolling="auto" align="top" frameborder="0" hspace="0" vspace="0" marginheight="0" marginwidth="0"></iframe>
 </td>
</tr>
</table>

<p align="right">|<a class="button" href="formOrcamentoEmpresaItem.jsp?acao=inc&idOrcamentoEmpresa=<%=idOrcamentoEmpresa%>">Novo Cadastro</a>|

