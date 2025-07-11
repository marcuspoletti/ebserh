<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.Cnae"%>
<%@page import="afero.persistence.CnaeDAO"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script>
function salvar() {
  	document.forms[0].submit();
}

function cancelar() {
  document.forms[0].action="formCnae.jsp";
  document.forms[0].submit();
}

function voltar() {
  document.forms[0].action = 'listarCnae.jsp?acao=voltar'
	document.forms[0].submit();
}
function comboSelect(combo, key) {
  var err = window.onerror; 
  window.onerror = new Function('return true'); 
  if (!combo) return; 
  combo.selectedIndex=-1; 
  for (var i = 0; i < combo.options.length; i++) {
    if (combo.multiple) {
      combo.options[i].selected=((","+key+",").indexOf(","+combo.options[i].value+",") != -1); 
    } else {
      combo.options[i].selected=(combo.options[i].value == key);
    }
  }
  window.onerror = err;
}  
</script>
</head>
<%

String acao = request.getParameter("acao");
String idCnae = request.getParameter("idCnae");

if (acao == null) acao = "inc";
if (idCnae == null) idCnae = "0";
String secao = "";
String divisao = "";
String grupo = "";
String classe = "";
String subclasse = "";
String denominacao = "";


//verifica se acao foi atualizar
if (acao.equalsIgnoreCase("atu")) {
  CnaeDAO dao = new CnaeDAO(conn);
  Cnae cnae = dao.procurarCnae(Integer.parseInt(idCnae));
  secao = cnae.getSecao();
  divisao = cnae.getDivisao();
  grupo = cnae.getGrupo();
  classe = cnae.getClasse();
  subclasse = cnae.getSubclasse();
  denominacao = cnae.getDenominacao();
}
%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Cadastro de CNAE</h1>
<form method="post" action="listarCnae.jsp?acao=<%=acao%>&idCnae=<%=idCnae%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="idCnae" value="<%=idCnae%>"/>

<table border="0" width="100%">
  <tr>
    <th class="label">Seção*</th>
    <td><input type="text" name="secao" <%if (secao != null) { %>value="<%=secao%>"<% }%>  size="60" maxlength="300"></td>
  </tr>
  <tr>
    <th class="label">Divisão*</th>
    <td><input type="text" name="divisao" <%if (divisao != null) { %>value="<%=divisao%>"<% }%>  size="60" maxlength="300"></td>
  </tr> 
  <tr>
    <th class="label">Grupo*</th>
    <td><input type="text" name="grupo" <%if (grupo != null) { %>value="<%=grupo%>"<% }%>  size="60" maxlength="300"></td>
  </tr>
   <tr>
    <th class="label">Classe*</th>
    <td><input type="text" name="classe" <%if (classe != null) { %>value="<%=classe%>"<% }%>  size="60" maxlength="300"></td>
  </tr>
  <tr>
    <th class="label">SubClasse*</th>
    <td><input type="text" name="subclasse" <%if (subclasse != null) { %>value="<%=subclasse%>"<% }%>  size="60" maxlength="300"></td>
  </tr>
    <tr>
    <th class="label">Denominação*</th>
    <td><input type="text" name="denominacao" <%if (denominacao != null) { %>value="<%=denominacao%>"<% }%>  size="60" maxlength="300"></td>
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