<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.PedidoSaida"%>
<%@page import="afero.model.Entrega"%>
<%@page import="afero.model.Colaborador"%>
<%@page import="afero.model.Loja"%>
<%@page import="afero.persistence.LojaDAO"%>
<%@page import="afero.persistence.EntregaDAO"%>
<%@page import="afero.persistence.PedidoSaidaDAO"%>
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
  document.forms[0].action="formPedido.jsp";
  document.forms[0].submit();
}
function redirecionar(id) {
  document.forms[0].action='exibirPedido.jsp?idPedidoSaida='+id;
  document.forms[0].submit();

}
</script>
</head>
<%
PedidoSaidaDAO daoPedidoSaida=null;
Loja loja = null;
Colaborador colaborador = null;
Entrega entrega = null;
double vlPed = 0;
String acao  = request.getParameter("acao");
String statusConsulta = request.getParameter("statusConsulta");
if (statusConsulta == null)statusConsulta="A";
String idPedidoSaida = request.getParameter("idPedidoSaida");
int numPedido = Integer.parseInt(idPedidoSaida);
String idLoja = request.getParameter("idLoja");
LojaDAO daoLoja = new LojaDAO(conn);
loja = daoLoja.procurarLoja(Integer.parseInt(idLoja));
String dsLoja = loja.getApelido() +  " / "  + loja.getRazaoSocial();
String cdEntidade = request.getParameter("cdEntidade");
if (cdEntidade == null) cdEntidade="1";
String idEntrega = request.getParameter("idEntrega");
EntregaDAO daoEntrega = new EntregaDAO(conn);
entrega = daoEntrega.procurarEntrega(Integer.parseInt(idEntrega));
String dsEntrega = entrega.getDsEntrega();
String cdCondPagto = request.getParameter("cdCondPagto");
if(cdCondPagto == null)cdCondPagto="0";
float txEntrega = entrega.getTxEntrega();
String idColaborador = (String)session.getAttribute("idColaborador");
ColaboradorDAO daoColaborador = new ColaboradorDAO(conn);
colaborador = daoColaborador.procurarColaborador(Integer.parseInt(idColaborador));
String dsColaborador = colaborador.getApelido() + " / " + colaborador.getNome(); 
String idVendedor = request.getParameter("idVendedor");
if (idVendedor == null) idVendedor = (String)session.getAttribute("idColaborador");
String observacao = request.getParameter("observacao");
if (observacao == null) observacao="";
String anotacao = request.getParameter("anotacao");
if (anotacao == null) anotacao="";
String status = request.getParameter("status");
if (status == null) status = "P";
String operacao = request.getParameter("operacao");
if (operacao == null) operacao = "S";
String dtEntrega = request.getParameter("dtEntrega");
String hrEntrega = request.getParameter("hrEntrega");
String usuario = request.getParameter("usuario");
if (usuario == null) usuario = "";
String statusPag = request.getParameter("statusPag");
if(statusPag == null)statusPag="N";
String tipoPedido = request.getParameter("tipoPedido");
if(tipoPedido == null)tipoPedido="T";
String dtPed = request.getParameter("dtPed");
String pessoaResponsavel = request.getParameter("pessoaResponsavel");
if (dtPed == null) dtPed="";
PedidoSaida pedidoSaida = new PedidoSaida();
pedidoSaida.setIdLoja(Integer.parseInt(idLoja));
pedidoSaida.setCdEntidade(Integer.parseInt(cdEntidade));
pedidoSaida.setIdEntrega(Integer.parseInt(idEntrega));
pedidoSaida.setIdColaborador(Integer.parseInt(idColaborador));
pedidoSaida.setObservacao(observacao);
pedidoSaida.setAnotacao(anotacao);
pedidoSaida.setCdCondPagto(Integer.parseInt(cdCondPagto));
pedidoSaida.setStatus(status);
pedidoSaida.setUsuario(usuario);
pedidoSaida.setDtEntrega(ConverteDate.stringToDate(dtEntrega));
pedidoSaida.setHrEntrega(hrEntrega);
pedidoSaida.setPessoaResponsavel(pessoaResponsavel);
pedidoSaida.setOperacao(operacao);
pedidoSaida.setStatusPag(statusPag);
pedidoSaida.setTipoPedido(tipoPedido);
pedidoSaida.setIdVendedor(Integer.parseInt(idVendedor));

daoPedidoSaida = new PedidoSaidaDAO(conn);
if (acao.equalsIgnoreCase("inc")) {
	daoPedidoSaida.incluir(pedidoSaida);
	numPedido = daoPedidoSaida.idPedidoSaida();
	idPedidoSaida = String.valueOf(numPedido);
	daoPedidoSaida.atualizarStatusPag(Integer.parseInt(idPedidoSaida), pedidoSaida.getStatusPag());
	daoPedidoSaida.atualizarTipoPedido(Integer.parseInt(idPedidoSaida), pedidoSaida.getTipoPedido());
	daoPedidoSaida.atualizarIdVendedor(Integer.parseInt(idVendedor), Integer.parseInt(idPedidoSaida));
	acao="listar";
} else if (acao.equalsIgnoreCase("atu")) {
	pedidoSaida.setIdPedidoSaida(Integer.parseInt(idPedidoSaida));
	daoPedidoSaida.atualizarCabecalho(pedidoSaida);
	numPedido = Integer.parseInt(idPedidoSaida);
	daoPedidoSaida.atualizarIdVendedor(Integer.parseInt(idVendedor), Integer.parseInt(idPedidoSaida));
	acao="listar";
}
%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Pedido</h1>
<hr>
<table border="0" width="100%">
   <tr>
    <th class="label">Número do Pedido</th>
    <td><input disabled type="text" name="numPedido" value="<%=numPedido%>" size="5" maxlength="5"></td>
  </tr>
</table><hr>
<table width="100%" border="0">
<tr>
 <th class="grid">Cadastrar Itens</th>
</tr>
<tr>
 <td><%@include file="../WEB-INF/jspf/grids/itensPedido.jspf"%>
 </td>
 </tr>
 <tr>
 <th class="grid">Itens Selecionados</th>
</tr>
<tr>
 <td>
  <iframe src="itensPedidoItem.jsp?idPedidoSaida=<%=idPedidoSaida%>" src2="" name="itensPedido" width="100%" height=300 scrolling="auto" align="top" frameborder="0" hspace="0" vspace="0" marginheight="0" marginwidth="0"></iframe>
 </td>
 </tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
    <br>
	<td><input class="button" type="button" value="Finalizar Pedido" onClick="javascript: redirecionar(<%=idPedidoSaida%>);" />
</tr>
</table>
<%@include file="../fimConexao.jsp"%>
