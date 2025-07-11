<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.PedidoSaida"%>
<%@page import="afero.persistence.PedidoSaidaDAO"%>
<%@ page import="afero.util.ConverteDate" %>
<%@page import="java.util.Calendar" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js" /></script>
<script>

function localizar() {
  
  document.forms[0].submit();
}  


function recarregar() {
  document.forms[0].action='front.jsp';
  document.forms[0].submit();
}

function atualizar() {
  document.forms[0].submit();
}
<%
boolean garcomOk;
if(request.getParameter("garcomOk")!= null){
	garcomOk = Boolean.parseBoolean(request.getParameter("garcomOk"));
}else{
  garcomOk = true;
}
boolean senhaGarcomOk;
if(request.getParameter("senhaGarcomOk") != null){
	senhaGarcomOk = Boolean.parseBoolean(request.getParameter("senhaGarcomOk"));
}else{
	senhaGarcomOk=false;
}
boolean mesaOk;
if(request.getParameter("mesaOk") != null){
	mesaOk = Boolean.parseBoolean(request.getParameter("mesaOk"));
}else{
	mesaOk=false;
}
boolean produtoOk;
if(request.getParameter("produtoOk") != null){
	produtoOk = Boolean.parseBoolean(request.getParameter("produtoOk"));
}else{
	produtoOk=false;
}
boolean quantOk;
if(request.getParameter("quantOk") != null){
	quantOk = Boolean.parseBoolean(request.getParameter("quantOk"));
}else{
	quantOk=false;
}
String mensagem = request.getParameter("mensagem");
if(mensagem == null)mensagem="";
String idPedidoSaida = request.getParameter("idPedidoSaida");
if(idPedidoSaida == null)idPedidoSaida="N";
String mesa = request.getParameter("mesa");
if(mesa == null)mesa="";
String garcom = request.getParameter("garcom");
if(garcom == null)garcom="";


String idProduto = request.getParameter("idProduto");
if(idProduto == null)idProduto="0";
String quantProduto = request.getParameter("quantProduto");
if(quantProduto == null)quantProduto="0";

String comandoGarcom = request.getParameter("comandoGarcom");
if(comandoGarcom == null)comandoGarcom="N";
String comandoGarcomSenha = request.getParameter("comandoGarcomSenha");
if(comandoGarcomSenha == null)comandoGarcomSenha="N";
String comandoMesa = request.getParameter("comandoMesa");
if(comandoMesa == null)comandoMesa="N";
String comandoProduto = request.getParameter("comandoProduto");

if(comandoProduto == null)comandoProduto="N";
String comandoQuant = request.getParameter("comandoQuant");
if(comandoQuant == null)comandoQuant="N";

String mesaDesc = request.getParameter("mesa");
if(mesaDesc == null)mesaDesc="";

String idMesa = request.getParameter("idMesa");
if(idMesa == null)idMesa="0";
String idGarcom = request.getParameter("idGarcom");
if(idGarcom == null)idGarcom="0";
//Implementação
String acao = "";
if(request.getParameter("acao") != null){
	acao = request.getParameter("acao");
}else{
	acao = "listar";
}
String idPedidoSaidaItem = request.getParameter("idPedidoSaidaItem");
if(idPedidoSaidaItem == null)idPedidoSaidaItem="0";
if(comandoProduto.equalsIgnoreCase("99")){
	garcomOk = true;
	senhaGarcomOk = false;
	mesaOk=false;
	produtoOk=false;
	quantOk=false;
	comandoGarcom="N";
	comandoGarcomSenha="N";
	comandoMesa="N";
	comandoProduto="N";
	quantProduto="0";
	idProduto="0";
	idMesa = "0";
	idGarcom="0";
	mesaDesc="";
	mesa="";
         garcom="";
}
if(comandoQuant.equalsIgnoreCase("99")){
	garcomOk = true;
	senhaGarcomOk = false;
	mesaOk=false;
	produtoOk=false;
	quantOk=false;
	comandoGarcom="N";
	comandoGarcomSenha="N";
	comandoMesa="N";
	comandoProduto="N";
	quantProduto="0";
	idProduto="0";
	idMesa = "0";
	idGarcom="0";
	mesaDesc="";
	mesa="";
         garcom="";
}
//Fim Implementação
String parametro = "";
%>
</script>
<%-- Início do Conteúdo da Página --%>
<div class="cabecalho_pagina">MESAS</div>
<hr>
<table border="2" width="100%">
<tr>
 <th class="grid" width="35%">COMANDOS</th>
 <th class="grid" width="100%">PEDIDOS</th>
</tr>
<tr>
 <td><%@include file="solicitacaoPedido.jsp"%>
 </td>
 <td>
  <iframe src="itensPedido.jsp?idPedidoSaida=<%=idPedidoSaida%>" name="framePedidos.jsp" width="100%" height="300" scrolling="auto" align="top" frameborder="0" hspace="0" vspace="0" marginheight="0" marginwidth="0"></iframe>
 </td>
</tr>
</table>
<br><br>
<%@include file="../fimConexao.jsp"%>