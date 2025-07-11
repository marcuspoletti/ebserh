<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.Cfop"%>
<%@page import="afero.persistence.CfopDAO"%>
<%@page import="afero.util.ConverteDate"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script>
function salvar() {
   if (document.all.cdCfop.value == '') {
     window.alert("O campo Código do CFOP é obrigatório. E só pode números!");
     document.all.cdCfop.focus();
   }else if (document.all.dsCfop.value == '') {
    window.alert("O campo Descrição do CFOP é obrigatório.");
    document.all.dsCfop.focus();
   } else {
  	document.forms[0].submit();
  }
}

function cancelar() {
  document.forms[0].action="formCfop.jsp";
  document.forms[0].submit();
}

function voltar() {
  document.forms[0].action = 'listarCfop.jsp?acao=voltar'
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
String cdCfop = request.getParameter("cdCfop");
if (acao == null) acao = "inc";
if (cdCfop == null)cdCfop= "";
String dsCfop = "";
String descricao = "";
String aplicacao = "";

//verifica se acao foi atualizar
if (acao.equalsIgnoreCase("atu")) {
  CfopDAO dao = new CfopDAO(conn);
  Cfop cfop = dao.procurarCfop(Integer.parseInt(cdCfop));
  dsCfop  = cfop.getDsCfop();
  descricao = cfop.getDescricao();
  aplicacao = cfop.getAplicacao();
}
%>
<body onload="document.forms[0].elements[0].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Cfop</h1>
<form method="post" action="listarCfop.jsp?acao=<%=acao%>">


<table border="0" width="100%">
  <tr>
    <th class="label">Cod. do CFOP*</th>
    <td><input type="text" name="cdCfop" <%if (cdCfop != null) { %>value="<%=cdCfop%>"<% }%>  size="4" maxlength="4" onkeypress="return SomenteNumero(event);"></td>
  </tr>
  <tr>
    <th class="label">Desc. do CFOP*</th>
    <td><input type="text" name="dsCfop" <%if (dsCfop != null) { %>value="<%=dsCfop%>"<% }%>  size="40" maxlength="500"></td>
  </tr>
  <tr>
    <th class="label">Descrição</th>
    <td><input type="text" name="descricao" <%if (descricao != null) { %>value="<%=descricao%>"<% }%>  size="40" maxlength="100"></td>
  </tr>
  <tr>
    <th class="label">Aplicação</th>
    <td><input type="text" name="aplicacao" <%if (aplicacao != null) { %>value="<%=aplicacao%>"<% }%>  size="40" maxlength="500"></td>
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