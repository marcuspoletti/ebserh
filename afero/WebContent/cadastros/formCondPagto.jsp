<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.CondPagto" %>
<%@page import="afero.util.ConverteDate"%>
<%@page import="afero.persistence.CondPagtoDAO" %>
<%@page import ="java.util.*" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/></script>
<script>
function salvar() {
  if (document.all.dsCondPagto.value == '') {
    window.alert("O campo Descrição de Tipo de Atendimento é obrigatório.");
    document.all.dsCondPagto.focus();
   }else {
  	document.forms[0].submit();
  }
}

function cancelar() {
  document.forms[0].action="formCondPagto.jsp";
  document.forms[0].submit();
}

function recarregar(acao) {
  document.forms[0].action='formCondPagto.jsp?acao='+acao;
  document.forms[0].submit();
}


function voltar() {
  document.forms[0].action = 'listarCondPagto.jsp?acao=voltar'
	document.forms[0].submit();
}  
</script>
</head>
<%
String cdCondPagto = request.getParameter("cdCondPagto");
String dsCondPagto = request.getParameter("dsCondPagto");
String status = request.getParameter("status");
String acao = request.getParameter("acao");
ConverteDate converte = new ConverteDate();
if (acao == null) acao = "inc";
if(cdCondPagto == null) cdCondPagto = "0";
if(dsCondPagto == null)dsCondPagto = "";
if(status == null)status = "A";
if (acao.equalsIgnoreCase("atu")){
	
	CondPagtoDAO dao = new CondPagtoDAO(conn);
	CondPagto tipoAtendimento = dao.procurarCondPagto(" WHERE cdCondPagto = " +Integer.parseInt(cdCondPagto)+ ";");
	dsCondPagto = tipoAtendimento.getDsCondPagto();
	status = tipoAtendimento.getStatus();
	}

%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Condição de Pagamento</h1>
<form method="post" action="listarCondPagto.jsp?acao=<%=acao%>&cdCondPagto=<%=cdCondPagto%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="cdCondPagto" value="<%=cdCondPagto%>"/>

<table border="0" width="100%">
	<tr>
		<th class="label">Descrição Condição de Pagamento*</th>
		<td><input type="text" id="dsCondPagto" name="dsCondPagto" <%if (dsCondPagto != null) { %>value="<%=dsCondPagto%>"<% }%>  size="50" maxlength="50"></td>
	</tr>
	<tr>
		<th class="label">Status</th>
		<td class="label_radio">
			<input type="radio" class="radio" name="status" value="A" <%=(status.equals("A")? "checked": "") %>/>Ativo
			<input type="radio" class="radio" name="status" value="I" <%=(status.equals("I")? "checked": "") %>/>Inativo
		</td>
	</tr>
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