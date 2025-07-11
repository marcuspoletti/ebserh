<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.CartaCorrecaoNotaFiscal" %>
<%@ page import="afero.persistence.RetornoCartaCorrecaoDAO" %>
<%@page import="afero.auxiliar.IntegracaoWS"%>
<%@page import="afero.auxiliar.IUrls"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="afero.util.ConverteDate" %>

<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />


<%
ConverteDate converte = new ConverteDate();
CartaCorrecaoNotaFiscal cartaCorrecaoNotaFiscal = new CartaCorrecaoNotaFiscal();
RetornoCartaCorrecaoDAO retornoCartaCorrecaoDAO = new RetornoCartaCorrecaoDAO(conn);
String descricao = "";;
String clausula = "";
String acao = request.getParameter("acao");
if (acao == null) acao = "listar";
String dsCorrecao = request.getParameter("dsCorrecao");
if(dsCorrecao == null) dsCorrecao=null;
String mensagem = request.getParameter("mensagem");
if(mensagem == null) mensagem="";
String mensagemRetorno = request.getParameter("mensagemRetorno");
if(mensagemRetorno == null) mensagemRetorno="";

String referencia = request.getParameter("referencia");
if(referencia == null) referencia="0";

String idRetornoNotaFiscal = request.getParameter("idRetornoNotaFiscal");
if(idRetornoNotaFiscal == null) idRetornoNotaFiscal="0";

String correcao = "";

if(request.getParameter("dsCorrecao") != null){
	
	correcao = java.net.URLEncoder.encode(request.getParameter("dsCorrecao"), "UTF-8");

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {


	try {
	  
	  cartaCorrecaoNotaFiscal.setIdRetornoNotaFiscal(Integer.parseInt(idRetornoNotaFiscal));
	  cartaCorrecaoNotaFiscal.setReferencia(Integer.parseInt(referencia));
	  cartaCorrecaoNotaFiscal.setJustificativa(request.getParameter("dsCorrecao"));
	  String usuario = (String)session.getAttribute("Login");
	  cartaCorrecaoNotaFiscal.setUsuario(usuario);
	  
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}


  if (acao.equalsIgnoreCase("inc") && !referencia.equalsIgnoreCase("0") && dsCorrecao != null) {
	  //inclui no banco de dados
	
         IntegracaoWS integracao = new IntegracaoWS();
	String cartaCorrecao = IUrls.urlCartaCorrecao+referencia+"&correcao="+correcao;
	mensagem += integracao.cartaCorrecaoNotaFiscal(cartaCorrecao);
	String consultaCartaCorrecao = IUrls.urlConsultaCartaCorrecao+referencia;
	mensagem += integracao.consultaNotaFiscal(consultaCartaCorrecao);
	cartaCorrecaoNotaFiscal.setMensagemRetorno(mensagem);
	if(dsCorrecao != null){
		retornoCartaCorrecaoDAO.incluir(cartaCorrecaoNotaFiscal);	
	}
  	

  }
} else {
  if (!acao.equalsIgnoreCase("voltar")) {
	descricao = request.getParameter("dsCorrecao");
  }
}
}
//seleciona todos os registros do banco de dados
List list;
clausula = clausula+" WHERE idRetornoNotaFiscal= "+idRetornoNotaFiscal+" AND idPedidoSaida= "+Integer.parseInt(referencia)+" ORDER BY dtRegistro desc ";
list = retornoCartaCorrecaoDAO.listarRetornoNotaFiscal(clausula);
int cont = 0;
%>
<h1 class="cabecalho_pagina">Cadastro de Carta de Correção</h1>

|<a class="button" href="formCartaCorrecao.jsp?acao=inc&referencia=<%=referencia%>&idRetornoNotaFiscal=<%=idRetornoNotaFiscal%>">Novo Cadastro</a>|<br>
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
	CartaCorrecaoNotaFiscal listaCartaCorrecaoNotaFiscal = (CartaCorrecaoNotaFiscal) it.next();
	cont++;
%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid" width="4%"><center><%=listaCartaCorrecaoNotaFiscal.getIdRetornoNotaFiscal()%></center></td>
      <td class = "grid" width="4%"><center><%=listaCartaCorrecaoNotaFiscal.getReferencia()%></center></td>
      <td class = "grid"><center><%=listaCartaCorrecaoNotaFiscal.getJustificativa()%></center></td>
      <td class = "grid"><center><%=listaCartaCorrecaoNotaFiscal.getMensagemRetorno()%></center></td>
      <td class = "grid"><center><%=converte.dateToString(listaCartaCorrecaoNotaFiscal.getDtRegistro())%></center></td>
      <td class = "grid"><center><%=listaCartaCorrecaoNotaFiscal.getUsuario()%></center></td>
      
  </tr>
<%
}
%>   
</table>
<%@include file="../fimConexao.jsp"%>
<p align="right">|<a class="button" href="formCartaCorrecao.jsp?acao=inc&referencia=<%=referencia%>&idRetornoNotaFiscal=<%=idRetornoNotaFiscal%>">Novo Cadastro</a>|

<p align="right">|<a class="button" href="javascript:void()" onclick="window.close()">Fechar</a>|