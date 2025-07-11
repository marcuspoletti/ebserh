<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.PedidoEntrada"%>
<%@page import="afero.model.Entrega"%>
<%@page import="afero.model.Colaborador"%>
<%@page import="afero.model.Loja"%>
<%@page import="afero.persistence.LojaDAO"%>
<%@page import="afero.persistence.EntregaDAO"%>
<%@page import="afero.persistence.PedidoEntradaDAO"%>
<%@page import="afero.persistence.ColaboradorDAO"%>
<%@ page import="afero.util.ConverteDate" %>
<%@ page import="afero.util.Utilitaria" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/></script>
<script>
function salvar() {
  	document.forms[0].submit();
}
function cancelar() {
  document.forms[0].action="formOrcamento.jsp";
  document.forms[0].submit();
}
function redirecionar(id) {
  document.forms[0].action='apresentacaoOrcamento.jsp?idOrcamento='+id;
  document.forms[0].submit();

}
</script>
</head>
<%
PedidoEntradaDAO daoPedidoEntrada= new PedidoEntradaDAO(conn);
Loja loja = null;
Colaborador colaborador = null;
Entrega entrega = null;
double vlPed = 0;
int numPedidoEntrada = 0;
String acao  = request.getParameter("acao");
String statusConsulta = request.getParameter("statusConsulta");
if(statusConsulta == null)statusConsulta="A";
String idPedidoEntrada = request.getParameter("idPedidoEntrada");
numPedidoEntrada = Integer.parseInt(idPedidoEntrada);
String idLoja = request.getParameter("idLoja");
LojaDAO daoLoja = new LojaDAO(conn);
loja = daoLoja.procurarLoja(Integer.parseInt(idLoja));
String dsLoja = loja.getApelido() +  " / "  + loja.getRazaoSocial();
String cdEntidade = request.getParameter("cdEntidade");
if(cdEntidade == null)cdEntidade="0";
String idColaborador = request.getParameter("idColaborador");
ColaboradorDAO daoColaborador = new ColaboradorDAO(conn);
colaborador = daoColaborador.procurarColaborador(Integer.parseInt(idColaborador));
String dsColaborador = colaborador.getApelido() + " / " + colaborador.getNome(); 
String observacao = request.getParameter("observacao");
String operacao = request.getParameter("operacao");
if(operacao == null)operacao = "E";
if(observacao == null)observacao="";
String status = request.getParameter("status");
if(status == null)status = "P";
String usuario = request.getParameter("usuario");
if(usuario == null)usuario = "";
String nrDoc = request.getParameter("nrDoc");
String dtEmissao = request.getParameter("dtCasamento");
if(acao.equalsIgnoreCase("inc")){
	PedidoEntrada pedidoEntrada = new PedidoEntrada();
	pedidoEntrada.setIdLoja(Integer.parseInt(idLoja));
	pedidoEntrada.setCdEntidade(Integer.parseInt(cdEntidade));
	pedidoEntrada.setIdColaborador(Integer.parseInt(idColaborador));
	pedidoEntrada.setObservacao(observacao);
	pedidoEntrada.setStatus(status);
	pedidoEntrada.setUsuario(usuario);
	pedidoEntrada.setDtEmissao(ConverteDate.stringToDate(dtEmissao));
	pedidoEntrada.setOperacao(operacao);
	pedidoEntrada.setIdOrdemServico(0);
	pedidoEntrada.setIdPedidoEntradaOrigem(0);
	pedidoEntrada.setNrDoc(nrDoc);
	daoPedidoEntrada.incluir(pedidoEntrada);
	numPedidoEntrada = daoPedidoEntrada.getIdPedidoEntrada();
	idPedidoEntrada = String.valueOf(numPedidoEntrada);
	acao="listar";
}else if(acao.equalsIgnoreCase("atu")){
	PedidoEntrada pedidoEntrada = new PedidoEntrada();
	pedidoEntrada.setIdPedidoEntrada(Integer.parseInt(idPedidoEntrada));
	pedidoEntrada.setIdLoja(Integer.parseInt(idLoja));
	pedidoEntrada.setCdEntidade(Integer.parseInt(cdEntidade));
	pedidoEntrada.setIdColaborador(Integer.parseInt(idColaborador));
	pedidoEntrada.setObservacao(observacao);
	pedidoEntrada.setStatus(status);
	pedidoEntrada.setDtEmissao(ConverteDate.stringToDate(dtEmissao));
	pedidoEntrada.setUsuario(usuario);
	pedidoEntrada.setOperacao(operacao);
	pedidoEntrada.setIdOrdemServico(0);
	pedidoEntrada.setIdPedidoEntradaOrigem(0);
	pedidoEntrada.setNrDoc(nrDoc);
	daoPedidoEntrada.atualizar(pedidoEntrada);
	numPedidoEntrada = Integer.parseInt(idPedidoEntrada);
	acao="listar";
}
%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Compras</h1>
<hr>
<table border="0" width="100%">
   <tr>
    <th class="label">Código de Entrada</th>
    <td><input disabled type="text" name="numPedidoEntrada" value="0<%=numPedidoEntrada%>" size="5" maxlength="5"></td>
  </tr>
</table><hr>
<table width="100%" border="0">
<tr>
 <th class="grid">Cadastrar Itens</th>
</tr>
<tr>
 <td><%@include file="../WEB-INF/jspf/grids/itensCompras.jspf"%>
 </td>
 </tr>
 <tr>
 <th class="grid">Itens Selecionados</th>
</tr>
<tr>
 <td>
  <iframe src="itensCompras.jsp?idPedidoEntrada=<%=idPedidoEntrada%>" src2="" name="itensOrcamento" width="100%" height=300 scrolling="auto" align="top" frameborder="0" hspace="0" vspace="0" marginheight="0" marginwidth="0"></iframe>
 </td>
 </tr>
</table>
<%@include file="../fimConexao.jsp"%>
</html>