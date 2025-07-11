<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.CstIcms"%>
<%@page import="afero.persistence.CstIcmsDAO"%>
<%@page import="afero.util.ConverteDate"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script>
function salvar() {
   if (document.all.cdCstIcms.value == '') {
     window.alert("O campo Código do CST é obrigatório.");
     document.all.cdCstIcms.focus();
   }else if (document.all.dsCstIcms.value == '') {
    window.alert("O campo Descrição do CST é obrigatório.");
    document.all.dsCstIcms.focus();
   } else {
  	document.forms[0].submit();
  }
}

function cancelar() {
  document.forms[0].action="formCstIcms.jsp";
  document.forms[0].submit();
}

function voltar() {
  document.forms[0].action = 'listarCstIcms.jsp?acao=voltar'
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
String cdCstIcms = request.getParameter("cdCstIcms");
if (acao == null) acao = "inc";
if (cdCstIcms == null)cdCstIcms= "";
String dsCstIcms = "";

//verifica se acao foi atualizar
if (acao.equalsIgnoreCase("atu")) {
  CstIcmsDAO dao = new CstIcmsDAO(conn);
  CstIcms cstIcms = dao.procurarCstIcms(Integer.parseInt(cdCstIcms));
  dsCstIcms  = cstIcms.getDsCstIcms();
}
%>
<body onload="document.forms[0].elements[0].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Cst Icms</h1>
<form method="post" action="listarCstIcms.jsp?acao=<%=acao%>">


<table border="0" width="100%">
  <tr>
    <th class="label">Cod. do CST Icms*</th>
    <td><input type="text" name="cdCstIcms" <%if (cdCstIcms != null) { %>value="<%=cdCstIcms%>"<% }%>  size="4" maxlength="4" onkeypress="return SomenteNumero(event);"></td>
  </tr>
  <tr>
    <th class="label">Desc. do CST Icms*</th>
    <td><input type="text" name="dsCstIcms" <%if (dsCstIcms != null) { %>value="<%=dsCstIcms%>"<% }%>  size="40" maxlength="40"></td>
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