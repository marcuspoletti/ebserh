<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.Ncm"%>
<%@page import="afero.persistence.NcmDAO"%>
<%@page import="afero.util.ConverteDate"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script>
function salvar() {
   if (document.all.cdNcm.value == '') {
     window.alert("O campo Código do NCM é obrigatório.");
     document.all.cdNcm.focus();
   }else if (document.all.dsNcm.value == '') {
    window.alert("O campo Descrição do NCM é obrigatório.");
    document.all.dsNcm.focus();
   } else {
  	document.forms[0].submit();
  }
}

function cancelar() {
  document.forms[0].action="formNcm.jsp";
  document.forms[0].submit();
}

function voltar() {
  document.forms[0].action = 'listarNcm.jsp?acao=voltar'
	document.forms[0].submit();
}
</script>
</head>
<%
//variáveis capturadas da página listarCidade.jsp
String acao = request.getParameter("acao");
String cdNcm = request.getParameter("cdNcm");
if (acao == null) acao = "inc";
if (cdNcm == null) cdNcm= "";
String dsNcm = "";

//verifica se acao foi atualizar
if (acao.equalsIgnoreCase("atu")) {
  NcmDAO dao = new NcmDAO(conn);
  Ncm ncm = dao.procurarNcm(cdNcm);
  dsNcm  = ncm.getDsNcm();
}
%>
<body onload="document.forms[0].elements[0].focus();" >
<h1 class="cabecalho_pagina">Cadastro de NCM</h1>
<form method="post" action="listarNcm.jsp?acao=<%=acao%>">

<table border="0" width="100%">
  <tr>
    <th class="label">Cod. do NCM*</th>
    <td><input type="text" name="cdNcm" <%if (cdNcm != null) { %>value="<%=cdNcm%>"<% }%>  size="40" maxlength="40"></td>
  </tr>
  <tr>
    <th class="label">Desc. do NCM*</th>
    <td><input type="text" name="dsNcm" <%if (dsNcm != null) { %>value="<%=dsNcm%>"<% }%>  size="40" maxlength="40"></td>
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