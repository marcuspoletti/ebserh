<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.Cotacao"%>
<%@page import="afero.persistence.CotacaoDAO"%>
<%@ page import="afero.util.ConverteDate" %>
<%@include file="../seguranca.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script language=JavaScript src="../js/abas.js" type=text/javascript></script>
<script src="../js/common.js" /></script>
<script>
function salvar() {
  if (document.all.idLoja.value == '0') {
    window.alert("O campo Loja é obrigatório.");
    document.all.idLoja.focus();
   }else if (document.all.idColaborador.value == '0') {
    window.alert("O campo Colaborador é obrigatório.");
    document.all.idColaborador.focus();
   }else {
  	document.forms[0].submit();
  }
}
function cancelar() {
  document.forms[0].action="formCotacao.jsp";
  document.forms[0].submit();
}

</script>
</head>
<%

String acao = request.getParameter("acao");
String idCotacao = request.getParameter("idCotacao");
CotacaoDAO daoCotacao = new CotacaoDAO(conn); 
ConverteDate converte = new ConverteDate();
if (acao == null) acao = "inc";
if (idCotacao == null) idCotacao = "0";
String idLoja = "0";
String idColaborador = "0";
String dtCotacao = daoCotacao.dataAtualCotacao();
String observacao = "";
String status = "NA";
String dtMod = "";
String usuario = (String)session.getAttribute("Login");
%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Abertura de Cotação</h1>
<form method="post" action="formCadastroItensCotacao.jsp?acao=<%=acao%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="idCotacao" value="<%=idCotacao%>"/>
<input type="hidden" name="usuario" value="<%=usuario%>"/>
<input type="hidden" name="dtCotacao" value="<%=dtCotacao%>"/>

<table border="0" width="100%">
  <tr>
      <th class="label">Loja*</th>
      <td><select name="idLoja">
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboLoja.jspf"%></select>
          <script>comboSelect(document.forms[0].idLoja, '<%= idLoja %>');</script>
      </td>
  </tr>
    <tr>
      <th class="label">Colaborador*</th>
      <td><select name="idColaborador">
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboColaborador.jspf"%></select>
          <script>comboSelect(document.forms[0].idColaborador, '<%= idColaborador %>');</script>
      </td>
  </tr>    
  <tr>
    <th class="label">Data da Cotação</th>
    <td><input disabled type="text" name="dtOrc" <%if (dtCotacao != null) { %>value="<%=dtCotacao%>"<% }%>  size="10" maxlength="10"></td>
  </tr>
  <tr>
      <th class="label">Observação</th>
      <td><textarea name="observacao" cols="60" rows="5"><%=observacao%></textarea></td>
  </tr>
  <tr>
    <th class="label">Status</th>
    <td class="label_radio">
      <input disabled type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Aprovado
      <input type="radio" class="radio" name="status" value="R" <%= (status.equals("N")? "checked": "") %>>Recusado<br>
      <input type="radio" class="radio" name="status" value="NA" <%= (status.equals("NA")? "checked": "") %>>Não Avaliado</td>
  </tr>
</table><hr>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
	<td><input class="button" type="button" value="Proximo" onClick="javascript: salvar();" />
	<input class="button" type="button" value="Cancelar" onClick="javascript: cancelar();" />
	<td class="campo_obrigatorio">* Campos Obrigatórios</td>
</tr>
</table>
</form>
</body>
</html>