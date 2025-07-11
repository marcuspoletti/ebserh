
<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.FormaPagto"%>
<%@page import="afero.util.ConverteDate"%>
<%@page import="afero.persistence.FormaPagtoDAO"%>
<%@page import ="java.util.*" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/>"></script>

<script>
function salvar() {
  if (document.all.dsFormaPagto.value == '') {
    window.alert("O campo Descrição da Forma de Pagamento é obrigatório.");
    document.all.dsFormaPagto.focus();
   }else {
  	document.forms[0].submit();
  }
}

function cancelar() {
  document.forms[0].action="formFormaPagto.jsp";
  document.forms[0].submit();
}

function recarregar(acao) {
  document.forms[0].action='formFormaPagto.jsp?acao='+acao;
  document.forms[0].submit();
}


function voltar() {
  document.forms[0].action = 'listarFormaPagto.jsp?acao=voltar'
	document.forms[0].submit();
}  
</script>
</head>
<%
String cdFormaPagto = request.getParameter("cdFormaPagto");
String dsFormaPagto = request.getParameter("dsFormaPagto");
String status = request.getParameter("status");
String acao = request.getParameter("acao");
ConverteDate converte = new ConverteDate();
if (acao == null) acao = "inc";
if(cdFormaPagto == null) cdFormaPagto = "0";
if(dsFormaPagto == null)dsFormaPagto = "";
if(status == null)status = "A";
if (acao.equalsIgnoreCase("atu")){
	    FormaPagtoDAO dao = new FormaPagtoDAO(conn);
	    FormaPagto formaPagto = dao.procurarFormaPagto(Integer.parseInt(cdFormaPagto));
	    dsFormaPagto = formaPagto.getDsFormaPagto();
		status = formaPagto.getStatus();
	}

%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Forma de Pagamento</h1>
<form method="post" action="listarFormaPagto.jsp?acao=<%=acao%>&cdFormaPagto=<%=cdFormaPagto%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="cdFormaPagto" value="<%=cdFormaPagto%>"/>


<table border="0" width="100%">

   <tr>
    <th class="label">Descrição Forma de Pagamento*</th>
    <td><input type="text" id="dsFormaPagto" name="dsFormaPagto" <%if (dsFormaPagto != null) { %>value="<%=dsFormaPagto%>"<% }%>  size="50" maxlength="50"></td>
  </tr>
  <tr>
    <th class="label">Ativo</th>
      <td class="label_radio"><input type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Sim
      <input type="radio" class="radio" name="status" value="I" <%= (status.equals("I")? "checked": "") %>>Não</td>    
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