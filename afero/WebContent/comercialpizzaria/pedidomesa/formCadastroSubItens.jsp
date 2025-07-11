<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.PedidoSaidaSubItens"%>
<%@page import="afero.model.Entrega"%>
<%@page import="afero.model.Colaborador"%>
<%@page import="afero.model.Loja"%>
<%@page import="afero.persistence.LojaDAO"%>
<%@page import="afero.persistence.EntregaDAO"%>
<%@page import="afero.persistence.PedidoSaidaSubItensDAO"%>
<%@page import="afero.persistence.ColaboradorDAO"%>
<%@ page import="afero.util.ConverteDate" %>
<%@ page import="afero.util.Utilitaria" %>
<%@include file="../../seguranca.jsp"%>
<%@include file="../../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../../css/afero.css" />
<script src="../../js/common.js"/></script>
<script>
function salvar() {
  	document.forms[0].submit();
}
function cancelar() {
  document.forms[0].action="formPedido.jsp";
  document.forms[0].submit();
}
function redirecionar(id) {
  document.forms[0].action='exibirPedido.jsp?idPedidoSaida='+id;
  document.forms[0].submit();

}
function fechar(){
opener.location.reload();//Atualiza a página de origem que abriu esse pop-up
window.close();
}
</script>
</head>
<%
PedidoSaidaSubItensDAO daoPedidoSaida=null;
Loja loja = null;
Colaborador colaborador = null;
Entrega entrega = null;
double vlPed = 0;
String acao  = request.getParameter("acao");
String statusConsulta = request.getParameter("statusConsulta");
if (statusConsulta == null)statusConsulta="A";
String idPedidoSaida = request.getParameter("idPedidoSaida");
int numPedido = Integer.parseInt(idPedidoSaida);
String idPedidoSaidaItem = request.getParameter("idPedidoSaidaItem");
String usuario = (String)session.getAttribute("Login");
String idColaborador = request.getParameter("idColaborador");
if(idColaborador == null)idColaborador="0";
String idLoja = request.getParameter("idLoja");
LojaDAO daoLoja = new LojaDAO(conn);
loja = daoLoja.procurarLoja(Integer.parseInt(idLoja));
String dsLoja = loja.getApelido() +  " / "  + loja.getRazaoSocial();


%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Fatias</h1>
<hr>
<table border="0" width="100%">
   <tr>
    <th class="label">Número do Pedido</th>
    <td><input disabled type="text" name="numPedido" value="<%=numPedido%>" size="5" maxlength="5"></td>
    <td align="right"><a href="javaScript:fechar();">Fechar</a></td>
  </tr>
</table><hr>
<table width="100%" border="0">
<tr>
 <th class="grid">Cadastrar Itens</th>
</tr>
<tr>
 <td><%@include file="../../WEB-INF/jspf/grids/itensPedidoSubItensPizzaria.jspf"%>
 </td>
 </tr>
 <tr>
 <th class="grid">Itens Selecionados</th>
</tr>
<tr>
 <td>
  <iframe src="itensPedidoItemSubItens.jsp?idPedidoSaidaItem=<%=idPedidoSaidaItem%>&idPedidoSaida=<%=idPedidoSaida%>" src2="" name="itensPedido" width="100%" height=300 scrolling="auto" align="top" frameborder="0" hspace="0" vspace="0" marginheight="0" marginwidth="0"></iframe>
 </td>
 <td align="right"><a href="javaScript:fechar();">Fechar</a></td>
 </tr>
</table>
<%@include file="../../fimConexao.jsp"%>
