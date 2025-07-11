<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.CancelamentoNotaFiscal" %>
<%@ page import="afero.persistence.RetornoNotaFiscalCancelamentoDAO" %>
<%@page import="afero.auxiliar.IntegracaoWS"%>
<%@page import="afero.auxiliar.IUrls"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="afero.util.ConverteDate" %>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONException"%>
<%@page import="com.sun.jersey.api.client.Client"%>
<%@page import="com.sun.jersey.api.client.ClientResponse"%>
<%@page import="com.sun.jersey.api.client.WebResource"%>

<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />


<%
ConverteDate converte = new ConverteDate();
CancelamentoNotaFiscal cancelamentoNotaFiscal = new CancelamentoNotaFiscal();
RetornoNotaFiscalCancelamentoDAO retornoNotaFiscalCancelamentoDAO = new RetornoNotaFiscalCancelamentoDAO(conn);
String descricao = "";
String clausula = "";
String acao = request.getParameter("acao");
if (acao == null) acao = "listar";
String dsCancelamento = request.getParameter("dsCancelamento");
if(dsCancelamento == null) dsCancelamento=null;
String mensagem = request.getParameter("mensagem");
if(mensagem == null) mensagem="";
String mensagemRetorno = request.getParameter("mensagemRetorno");
if(mensagemRetorno == null) mensagemRetorno="";

String referencia = request.getParameter("referencia");
if(referencia == null) referencia="0";

String idRetornoNotaFiscal = request.getParameter("idRetornoNotaFiscal");
if(idRetornoNotaFiscal == null) idRetornoNotaFiscal="0";

String justificativa = ""; 
if(request.getParameter("dsCancelamento") != null){
	
	justificativa = java.net.URLEncoder.encode(request.getParameter("dsCancelamento"), "UTF-8");

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {


	try {
	  
	  cancelamentoNotaFiscal.setIdRetornoNotaFiscal(Integer.parseInt(idRetornoNotaFiscal));
	  cancelamentoNotaFiscal.setIdPedidoSaida(Integer.parseInt(referencia));
	  cancelamentoNotaFiscal.setJustificativa(request.getParameter("dsCancelamento"));
	  String usuario = (String)session.getAttribute("Login");
	  cancelamentoNotaFiscal.setUsuario(usuario);
	  
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}


  if (acao.equalsIgnoreCase("inc") && !referencia.equalsIgnoreCase("0") && dsCancelamento != null) {
	  //inclui no banco de dados
	
	
         IntegracaoWS integracao = new IntegracaoWS();
	String cancelamento = IUrls.urlCancelamento+referencia+"&justificativa="+justificativa;
	cancelamentoNotaFiscal.setJustificativa(request.getParameter("dsCancelamento"));
	mensagem += integracao.cancelamentoNotaFiscal(cancelamento);
         System.out.println(mensagem);
	cancelamentoNotaFiscal.setMensagemRetorno(mensagem);
	System.out.println("Log Cancelamento ---------->");
	System.out.println("\n");
	System.out.println(mensagem);
	System.out.println("\n");
	System.out.println("Fim log Cancelamento ---------->");
	if(dsCancelamento != null){
		retornoNotaFiscalCancelamentoDAO.incluir(cancelamentoNotaFiscal);	
	}
  	

  }
} else {
  if (!acao.equalsIgnoreCase("voltar")) {
	descricao = request.getParameter("dsCancelamento");
  }
}
}
//seleciona todos os registros do banco de dados
List list;
clausula = clausula+" WHERE idRetornoNotaFiscal= "+idRetornoNotaFiscal+" AND idPedidoSaida= "+Integer.parseInt(referencia)+" ORDER BY dtRegistro desc ";
list = retornoNotaFiscalCancelamentoDAO.listarRetornoNotaFiscal(clausula);
int cont = 0;
%>
<h1 class="cabecalho_pagina">Listagem de Cancelamento da Nota Fiscal</h1>

|<a class="button" href="formCancelamento.jsp?acao=inc&referencia=<%=referencia%>&idRetornoNotaFiscal=<%=idRetornoNotaFiscal%>">Novo Cadastro</a>|<br>
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<body onload="document.forms[0].elements[0].focus();" >


<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr>
      <th class="grid">&nbsp;</th>
      <th class="grid">&nbsp;</th>
      <th class="grid"><center>Referencia</center></th>
      <th class="grid"><center>Justificativa</center></th>
      <th class="grid"><center>Mensagem Retorno</center></th>
      <th class="grid"><center>Data do Registro</center></th>
      <th class="grid"><center>Usuario</center></th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	CancelamentoNotaFiscal listaCancelamentoNotaFiscal = (CancelamentoNotaFiscal) it.next();
	cont++;
%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid" width="4%"><center><%=listaCancelamentoNotaFiscal.getIdRetornoNotaFiscal()%></center></td>
      <td class = "grid" width="4%"><center><%=listaCancelamentoNotaFiscal.getIdPedidoSaida()%></center></td>
      <td class = "grid"><center><%=listaCancelamentoNotaFiscal.getJustificativa()%></center></td>
      <td class = "grid"><center><%=listaCancelamentoNotaFiscal.getMensagemRetorno()%></center></td>
      <td class = "grid"><center><%=converte.dateToString(listaCancelamentoNotaFiscal.getDtRegistro())%></center></td>
      <td class = "grid"><center><%=listaCancelamentoNotaFiscal.getUsuario()%></center></td>
      
  </tr>
<%
}
%>   
</table>
<%@include file="../fimConexao.jsp"%>
<p align="right">|<a class="button" href="formCancelamento.jsp?acao=inc&referencia=<%=referencia%>&idRetornoNotaFiscal=<%=idRetornoNotaFiscal%>">Novo Cadastro</a>|

<p align="right">|<a class="button" href="javascript:void()" onclick="window.close()">Fechar</a>|