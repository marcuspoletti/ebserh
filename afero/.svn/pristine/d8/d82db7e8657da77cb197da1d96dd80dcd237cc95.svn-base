<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.CstIpi"%>
<%@page import="afero.persistence.CstIpiDAO"%>
<%@page import="afero.util.ConverteDate"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script>
function salvar() {
   if (document.all.cdCstIpi.value == '') {
     window.alert("O campo Código do CST IPI é obrigatório.");
     document.all.cdCstIpi.focus();
   }else if (document.all.dsCstIpi.value == '') {
    window.alert("O campo Descrição do CST IPI é obrigatório.");
    document.all.dsCstIpi.focus();
   } else {
  	document.forms[0].submit();
  }
}

function cancelar() {
  document.forms[0].action="formCstIpi.jsp";
  document.forms[0].submit();
}

function voltar() {
  document.forms[0].action = 'listarCstIpi.jsp?acao=voltar'
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
String cdCstIpi = request.getParameter("cdCstIpi");
if (acao == null) acao = "inc";
if (cdCstIpi == null)cdCstIpi= "";
String dsCstIpi = "";

//verifica se acao foi atualizar
if (acao.equalsIgnoreCase("atu")) {
  CstIpiDAO dao = new CstIpiDAO(conn);
  CstIpi cstIpi = dao.procurarCstIpi(Integer.parseInt(cdCstIpi));
  dsCstIpi  = cstIpi.getDsCstIpi();
}
%>
<body onload="document.forms[0].elements[0].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Cst Ipi</h1>
<form method="post" action="listarCstIpi.jsp?acao=<%=acao%>">


<table border="0" width="100%">
  <tr>
    <th class="label">Cod. do CST Ipi*</th>
    <td><input type="text" name="cdCstIpi" <%if (cdCstIpi != null) { %>value="<%=cdCstIpi%>"<% }%>  size="4" maxlength="4" onkeypress="return SomenteNumero(event);"></td>
  </tr>
  <tr>
    <th class="label">Desc. do CST Ipi*</th>
    <td><input type="text" name="dsCstIpi" <%if (dsCstIpi != null) { %>value="<%=dsCstIpi%>"<% }%>  size="40" maxlength="40"></td>
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