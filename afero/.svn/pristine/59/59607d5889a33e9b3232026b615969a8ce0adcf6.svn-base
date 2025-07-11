<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.OrcamentoSubItens"%>
<%@page import="afero.model.Entrega"%>
<%@page import="afero.model.Colaborador"%>
<%@page import="afero.model.Loja"%>
<%@page import="afero.persistence.LojaDAO"%>
<%@page import="afero.persistence.EntregaDAO"%>
<%@page import="afero.persistence.OrcamentoSubItensDAO"%>
<%@page import="afero.persistence.ColaboradorDAO"%>
<%@ page import="afero.util.ConverteDate" %>
<%@ page import="afero.util.Utilitaria" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/>"</script>
<script>
function salvar() {
  	document.forms[0].submit();
}
function redirecionar(id) {
  document.forms[0].action='exibirOrcamento.jsp?idOrcamento='+id;
  document.forms[0].submit();

}
</script>
</head>
<%
OrcamentoSubItensDAO daoOrcamento=null;
Loja loja = null;
Colaborador colaborador = null;
Entrega entrega = null;
double vlOrc = 0;
int numOrcamento = 0;
String acao  = request.getParameter("acao");
String statusConsulta = request.getParameter("statusConsulta");
if(statusConsulta == null)statusConsulta="A";
String idOrcamentoItem = request.getParameter("idOrcamentoItem");
numOrcamento = Integer.parseInt(idOrcamentoItem);
String idLoja = request.getParameter("idLoja");
LojaDAO daoLoja = new LojaDAO(conn);
loja = daoLoja.procurarLoja(Integer.parseInt(idLoja));
String dsLoja = loja.getApelido() +  " / "  + loja.getRazaoSocial();
String usuario = (String)session.getAttribute("Login");
String idColaborador = request.getParameter("idColaborador");
if(idColaborador == null)idColaborador="0";
%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Sub Itens</h1>
<hr>
<table border="0" width="100%">
   <tr>
    <th class="label">Número do Item</th>
    <td><input disabled type="text" name="numOrcamento" value="<%=numOrcamento%>" size="5" maxlength="5"></td>
  </tr>
</table><hr>
<table width="100%" border="0">
<tr>
 <th class="grid">Cadastrar Itens</th>
</tr>
<tr>
 <td><%@include file="../WEB-INF/jspf/grids/OrcamentoSubItens.jspf"%>
 </td>
 </tr>
 <tr>
 <th class="grid">Sub Itens Selecionados</th>
</tr>
<tr>
 <td>
  <iframe src="itensOrcamentoSubItens.jsp?idOrcamentoItem=<%=idOrcamentoItem%>" src2="" name="itensOrcamentoSubItens" width="100%" height=200 scrolling="auto" align="top" frameborder="0" hspace="0" vspace="0" marginheight="0" marginwidth="0"></iframe>
 </td>
 </tr>
</table>
<%--
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
	<td><input class="button" type="button" value="Finalizar Orçamento" onClick="javascript: redirecionar(<%=idOrcamentoItem%>);" />
</tr>
 --%>
<tr><td><br>
</td></tr>
</table>
<%@include file="../fimConexao.jsp"%>
</html>