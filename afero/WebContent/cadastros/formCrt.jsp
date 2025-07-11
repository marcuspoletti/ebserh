<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.Crt"%>
<%@page import="afero.persistence.CrtDAO"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script>
function salvar() {
  if (document.all.codigo.value == '') {
    window.alert("O campo Código é obrigatório.");
    document.all.codigo.focus();
   } else if (document.all.descricao.value == ''){
      window.alert("O campo Descrição é obrigatório.");
      document.all.descricao.focus();
   } else {
  	document.forms[0].submit();
  }
}

function cancelar() {
  document.forms[0].action="formCrt.jsp";
  document.forms[0].submit();
}

function voltar() {
  document.forms[0].action = 'listarCrt.jsp?acao=voltar'
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
String idCrt = request.getParameter("idCrt");

if (acao == null) acao = "inc";
if (idCrt == null) idCrt = "";
String codigo = "";
String descricao = "";


//verifica se acao foi atualizar
if (acao.equalsIgnoreCase("atu")) {
  CrtDAO dao = new CrtDAO(conn);
  Crt crt = dao.procurarCrt(Integer.parseInt(idCrt));
	codigo  = crt.getCodigo().toString();
	descricao = crt.getDescricao();
}
%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Cadastro de CRT</h1>
<form method="post" action="listarCrt.jsp?acao=<%=acao%>&idCrt=<%=idCrt%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="idCrt" value="<%=idCrt%>"/>

<table border="0" width="100%">
  <tr>
    <th class="label">Codigo*</th>
    <td><input type="text" name="codigo" <%if (codigo != null) { %>value="<%=codigo%>"<% }%>  size="40" maxlength="40"></td>
  </tr>
  <tr>
    <th class="label">Descrição*</th>
    <td><input type="text" name="descricao" <%if (descricao != null) { %>value="<%=descricao%>"<% }%>  size="60" maxlength="60"></td>
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