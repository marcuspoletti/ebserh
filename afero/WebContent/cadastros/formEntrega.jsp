<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.Entrega"%>
<%@page import="afero.util.Utilitaria"%>
<%@page import="afero.persistence.EntregaDAO"%>
<%@page import="afero.util.ConverteDate"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/></script>

<script>
function salvar() {
 	if(document.all.dsEntrega.value == '') {
   	 	window.alert("O campo Descrição de Entrega é obrigatório.");
    	document.all.dsEntrega.focus();
   }if(document.all.txEntrega.value == '') {
   	 	window.alert("O campo Taxa de Entrega é obrigatório.");
    	document.all.txEntrega.focus();
   }else{
     document.forms[0].submit();
   }
}

function cancelar() {
  document.forms[0].action="formEntrega.jsp";
  document.forms[0].submit();
}

function voltar() {
  document.forms[0].action = 'listarEntrega.jsp?acao=voltar';
	document.forms[0].submit();
}
</script>
</head>
<%

String acao = request.getParameter("acao");
String idEntrega = request.getParameter("idEntrega");
ConverteDate converte = new ConverteDate();
if (acao == null) acao = "inc";
if (idEntrega == null) idEntrega = "";
String dsEntrega = "";
String usuario = (String)session.getAttribute("Login");
String dtCad = "";
String dtMod = "";
String txEntrega = "";
String habilitarTaxa = "ok";

//verifica se acao foi atualizar
if (acao.equalsIgnoreCase("atu")) {
  EntregaDAO dao = new EntregaDAO(conn);
  Entrega entrega = dao.procurarEntrega(Integer.parseInt(idEntrega));
  dsEntrega  = entrega.getDsEntrega();
  txEntrega = Utilitaria.formatarNumero(entrega.getTxEntrega(),2).toString();
  if(dao.getIdEntregaAtu(Integer.parseInt(idEntrega))){
	  habilitarTaxa = "not";
  }
  dtMod = entrega.getDtMod().toString();
  dtCad = entrega.getDtCad().toString();
}
%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Taxa de Entrega</h1>
<form method="post" action="listarEntrega.jsp?acao=<%=acao%>&idEntrega=<%=idEntrega%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="idEntrega" value="<%=idEntrega%>"/>
<input type="hidden" name="usuario" value="<%=usuario%>"/>

<table border="0" width="100%">
  <tr>
    <th class="label">Descricao da Entrega*</th>
    <td><input type="text" name="dsEntrega" <%if (dsEntrega != null) { %>value="<%=dsEntrega%>"<% }%>  size="40" maxlength="40"></td>
  </tr>
  <tr>
    <th class="label">Taxa de Entrega*</th>
    <td class="label" width="5%"><input  type="text"  name="txEntrega" value="<%=txEntrega%>" onkeyup="FormataValor(this,event)" size="10" maxlength="10"></td>
  </tr>
   <%if(acao.equals("atu")){%>
  
  	<tr>
   	 	<td class="label_menor"><center>&nbsp Registro: <%if (dtCad != null) { %><%=converte.DMYToYMD(dtCad)%><% }%>&nbsp</center></td>
  	    <td class="label_menor"><center>&nbsp Modificação: <%if (dtMod != null) { %><%=converte.DMYToYMD(dtMod)%><% }%>&nbsp</center></td>
	</tr>

  <% }%>
</table><hr>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
	<td><input class="button" type="button" value="Salvar" onClick="javascript: salvar();" />
	<input class="button" type="button" value="Cancelar" onClick="javascript: cancelar();" />
	<input class="button" type="button" value="Voltar" onClick="javascript: voltar();" /></td>
	<td class="campo_obrigatorio">* Campos Obrigatórios</td>
</tr>
</table>
</form>
<%@include file="../fimConexao.jsp"%>

</body>
</html>