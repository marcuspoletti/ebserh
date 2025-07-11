<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.CstPis"%>
<%@page import="afero.persistence.CstPisDAO"%>
<%@page import="afero.util.ConverteDate"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script>
function salvar() {
   if (document.all.cdCstPis.value == '') {
     window.alert("O campo Código do CST PIS é obrigatório.");
     document.all.cdCstPis.focus();
   }else if (document.all.dsCstPis.value == '') {
    window.alert("O campo Descrição do CST PIS é obrigatório.");
    document.all.dsCstPis.focus();
   } else {
  	document.forms[0].submit();
  }
}

function cancelar() {
  document.forms[0].action="formCstPis.jsp";
  document.forms[0].submit();
}

function voltar() {
  document.forms[0].action = 'listarCstPis.jsp?acao=voltar'
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
String cdCstPis = request.getParameter("cdCstPis");
if (acao == null) acao = "inc";
if (cdCstPis == null)cdCstPis= "";
String dsCstPis = "";

//verifica se acao foi atualizar
if (acao.equalsIgnoreCase("atu")) {
  CstPisDAO dao = new CstPisDAO(conn);
  CstPis cstPis = dao.procurarCstPis(Integer.parseInt(cdCstPis));
  dsCstPis  = cstPis.getDsCstPis();
}
%>
<body onload="document.forms[0].elements[0].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Cst Pis</h1>
<form method="post" action="listarCstPis.jsp?acao=<%=acao%>">


<table border="0" width="100%">
  <tr>
    <th class="label">Cod. do CST Pis*</th>
    <td><input type="text" name="cdCstPis" <%if (cdCstPis != null) { %>value="<%=cdCstPis%>"<% }%>  size="4" maxlength="4" onkeypress="return SomenteNumero(event);"></td>
  </tr>
  <tr>
    <th class="label">Desc. do CST Pis*</th>
    <td><input type="text" name="dsCstPis" <%if (dsCstPis != null) { %>value="<%=dsCstPis%>"<% }%>  size="40" maxlength="40"></td>
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