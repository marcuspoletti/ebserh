<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.Csosn"%>
<%@page import="afero.persistence.CsosnDAO"%>
<%@page import="afero.util.ConverteDate"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script>
function salvar() {
   if (document.all.cdCsosn.value == '') {
     window.alert("O campo Código do CSOSN é obrigatório. E só pode números!");
     document.all.cdCsosn.focus();
   }else if (document.all.dsCsosn.value == '') {
    window.alert("O campo Descrição do CSOSN é obrigatório.");
    document.all.dsCsosn.focus();
   } else {
  	document.forms[0].submit();
  }
}

function cancelar() {
  document.forms[0].action="formCsosn.jsp";
  document.forms[0].submit();
}

function voltar() {
  document.forms[0].action = 'listarCsosn.jsp?acao=voltar'
	document.forms[0].submit();
}
function SomenteNumero(e){
    var tecla=(window.event)?event.keyCode:e.which;
    if((tecla > 47 && tecla < 58)) return true;
    else{
    if (tecla != 8) return false;
    else return true;
    }
}
</script>
</head>
<%
//variáveis capturadas da página listarCidade.jsp
String acao = request.getParameter("acao");
String cdCsosn = request.getParameter("cdCsosn");
if (acao == null) acao = "inc";
if (cdCsosn == null)cdCsosn= "";
String dsCsosn = "";

//verifica se acao foi atualizar
if (acao.equalsIgnoreCase("atu")) {
  CsosnDAO dao = new CsosnDAO(conn);
  Csosn csosn = dao.procurarCsosn(Integer.parseInt(cdCsosn));
  dsCsosn  = csosn.getDsCsosn();
}
%>
<body onload="document.forms[0].elements[0].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Csosn</h1>
<form method="post" action="listarCsosn.jsp?acao=<%=acao%>">


<table border="0" width="100%">
  <tr>
    <th class="label">Cod. do CSOSN*</th>
    <td><input type="text" name="cdCsosn" <%if (cdCsosn != null) { %>value="<%=cdCsosn%>"<% }%>  size="4" maxlength="4" onkeypress="return SomenteNumero(event);"></td>
  </tr>
  <tr>
    <th class="label">Desc. do CSOSN*</th>
    <td><input type="text" name="dsCsosn" <%if (dsCsosn != null) { %>value="<%=dsCsosn%>"<% }%>  size="40" maxlength="40"></td>
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