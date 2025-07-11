<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.CstCofins"%>
<%@page import="afero.persistence.CstCofinsDAO"%>
<%@page import="afero.util.ConverteDate"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script>
function salvar() {
   if (document.all.cdCstCofins.value == '') {
     window.alert("O campo Código do CST COFINS é obrigatório.");
     document.all.cdCstCofins.focus();
   }else if (document.all.dsCstCofins.value == '') {
    window.alert("O campo Descrição do CST COFINS é obrigatório.");
    document.all.dsCstCofins.focus();
   } else {
  	document.forms[0].submit();
  }
}

function cancelar() {
  document.forms[0].action="formCstCofins.jsp";
  document.forms[0].submit();
}

function voltar() {
  document.forms[0].action = 'listarCstCofins.jsp?acao=voltar'
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
String cdCstCofins = request.getParameter("cdCstCofins");
if (acao == null) acao = "inc";
if (cdCstCofins == null)cdCstCofins= "";
String dsCstCofins = "";

//verifica se acao foi atualizar
if (acao.equalsIgnoreCase("atu")) {
  CstCofinsDAO dao = new CstCofinsDAO(conn);
  CstCofins cstConfins = dao.procurarCstCofins(Integer.parseInt(cdCstCofins));
  dsCstCofins  = cstConfins.getDsCstCofins();
}
%>
<body onload="document.forms[0].elements[0].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Cst Cofins</h1>
<form method="post" action="listarCstCofins.jsp?acao=<%=acao%>">


<table border="0" width="100%">
  <tr>
    <th class="label">Cod. do CST Cofins*</th>
    <td><input type="text" name="cdCstCofins" <%if (cdCstCofins != null) { %>value="<%=cdCstCofins%>"<% }%>  size="4" maxlength="4" onkeypress="return SomenteNumero(event);"></td>
  </tr>
  <tr>
    <th class="label">Desc. do CST Cofins*</th>
    <td><input type="text" name="dsCstCofins" <%if (dsCstCofins != null) { %>value="<%=dsCstCofins%>"<% }%>  size="40" maxlength="40"></td>
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