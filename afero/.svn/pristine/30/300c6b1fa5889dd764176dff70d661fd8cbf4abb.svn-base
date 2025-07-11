<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.PedidoSaida"%>
<%@page import="afero.model.Entidade"%>
<%@page import="afero.model.EntidadeEmail"%>
<%@page import="afero.persistence.EntidadeDAO"%>
<%@page import="afero.persistence.EntidadeEmailDAO"%>
<%@page import="afero.persistence.PedidoSaidaDAO"%>
<%@ page import="afero.util.ConverteDate" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/></script>
<script>
function enviar() {
	document.forms[0].submit();
}
function fechar(){
	opener.location.reload();//Atualiza a página de origem que abriu esse pop-up
	window.close();
}
</script>
</head>
<%
//Email
String para = "";
String mensagem = "";
String assunto = "";

//Email
String acao = request.getParameter("acao");
if (acao == null) acao = "inc";
String idPedidoSaida = request.getParameter("idPedidoSaida");
PedidoSaidaDAO daoPedidoSaida = new PedidoSaidaDAO(conn); 
ConverteDate converte = new ConverteDate();
if (idPedidoSaida == null) idPedidoSaida = "0";
String idLoja = request.getParameter("idLoja");
if(idLoja == null)idLoja="0";
String cdEntidade = request.getParameter("cdEntidade");
if(cdEntidade == null)cdEntidade="0";
String idEntrega =request.getParameter("idEntrega");
if(idEntrega == null)idEntrega="0";
String idColaborador = request.getParameter("idColaborador");
if(idColaborador == null)idColaborador="0";
String dsEntidade = request.getParameter("dsEntidade");
String statusPag= request.getParameter("statusPag");
if(statusPag == null)statusPag="N";
if(dsEntidade == null)dsEntidade="";
String dtPed = daoPedidoSaida.dataAtualPedido();
int cdCondPagto = 0;
double vlPed = 0;
String observacao = "";
String anotacao = "";
String status = "P";
String pessoaResponsavel = "";
String operacao = "S";
String dtMod = "";
String usuario = (String)session.getAttribute("Login");
String dtEntrega = daoPedidoSaida.dataAtualPedido();
String hrEntrega = "";

if (acao.equalsIgnoreCase("inc")){
	idPedidoSaida = "0";
	acao="inc";
}else if (acao.equalsIgnoreCase("atu")) {
	PedidoSaida pedidoSaida = daoPedidoSaida.procurarPedidoSaida(Integer.parseInt(idPedidoSaida));
	idLoja = "".valueOf(pedidoSaida.getIdLoja());
	cdEntidade = "".valueOf(pedidoSaida.getCdEntidade());
	EntidadeDAO daoEntidade = new EntidadeDAO(conn);
	Entidade entidade = daoEntidade.procurarEntidade(Integer.parseInt(cdEntidade));
	dsEntidade = entidade.getNome();
	idEntrega = "".valueOf(pedidoSaida.getIdEntrega());
    idColaborador = "".valueOf(pedidoSaida.getIdColaborador());
	observacao = pedidoSaida.getObservacao();
	anotacao = pedidoSaida.getAnotacao();
	if(anotacao == null)anotacao = "";
	status = pedidoSaida.getStatus();
	pessoaResponsavel=pedidoSaida.getPessoaResponsavel();
	operacao = pedidoSaida.getOperacao();
	if(pedidoSaida.getDtEntrega() != null){
		dtEntrega = ConverteDate.dateToString(pedidoSaida.getDtEntrega());
	}else{
		dtEntrega = "";
	}
	
	hrEntrega = pedidoSaida.getHrEntrega();
	dtPed = ConverteDate.dateToString(pedidoSaida.getDtPed());
	vlPed = pedidoSaida.getVlPed();
	cdCondPagto = pedidoSaida.getCdCondPagto();
	acao="atu";
	//Email
	EntidadeEmailDAO daoEmail = new EntidadeEmailDAO(conn);
	EntidadeEmail emailEntidade = daoEmail.procurarEntidadeEmailPadrao(Integer.parseInt(cdEntidade));
	if(emailEntidade.getDsEmail() != null){
		para = emailEntidade.getDsEmail();
	}else{
		para = "SEM EMAIL CADASTRADO.";
	}
	assunto = "PEDIDO nº "+idPedidoSaida;
	mensagem = "";
	//Email
}

%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Email</h1>
<form method="post" action="statusEmail.jsp">
<table border="0" width="100%">
    <tr>
      <th class="label" style="height: 22px">Para</th>
      <td style="height: 15px"><input type="text" name="para" <%if (para != null) { %>value="<%=para%>"<% }%>  size="60" maxlength="60"></td>
  </tr>
    <tr>
    <th class="label">Assunto</th>
    <td><input type="text" name="assunto" <%if (assunto != null) { %>value="<%=assunto%>"<% }%>  size="60" maxlength="60"></td>
  </tr>
  <tr>
      <th class="label">Mensagem</th>
      <td><textarea name="mensagem" cols="50" rows="2"><%=mensagem %></textarea></td>
  </tr>
</table><hr>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
	<td><input class="button" type="button" value="Enviar" onClick="javascript: enviar();" />
	<input class="button" type="button" value="Sair" onClick="javaScript:fechar();" />
</tr>
</table>
</form>
<%@include file="../fimConexao.jsp"%>
</body>
</html>