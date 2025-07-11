<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.Unidade"%>
<%@page import="afero.persistence.UnidadeDAO"%>
<%@page import="afero.util.ConverteDate"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script>
function salvar() {
  if (document.all.dsUnidade.value == '') {
    window.alert("O campo Descrição da Unidade é obrigatório.");
    document.all.dsUnidade.focus();
   } else {
  	document.forms[0].submit();
  }
}

function cancelar() {
  document.forms[0].action="formUnidade.jsp";
  document.forms[0].submit();
}

function voltar() {
  document.forms[0].action = 'listarUnidade.jsp?acao=voltar'
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
String idUnidade = request.getParameter("idUnidade");
ConverteDate converte = new ConverteDate();
if (acao == null) acao = "inc";
if (idUnidade == null) idUnidade = "";
String dsUnidade = "";
String status ="A";
String dtCad = "";
String dtMod = "";

//verifica se acao foi atualizar
if (acao.equalsIgnoreCase("atu")) {
  UnidadeDAO dao = new UnidadeDAO(conn);
  Unidade unidade = dao.procurarUnidade(Integer.parseInt(idUnidade));
  dsUnidade  = unidade.getDsUnidade();
  status = unidade.getStatus(); 
  dtMod = unidade.getDtMod().toString();
  dtCad = unidade.getDtCad().toString();
}
%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Unidade</h1>
<form method="post" action="listarUnidade.jsp?acao=<%=acao%>&idUnidade=<%=idUnidade%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="idUnidade" value="<%=idUnidade%>"/>

<table border="0" width="100%">
  <tr>
    <th class="label">Descricao*</th>
    <td><input type="text" name="dsUnidade" <%if (dsUnidade != null) { %>value="<%=dsUnidade%>"<% }%>  size="40" maxlength="40"></td>
  </tr>
  <tr>
    <th class="label">Ativo</th>
      <td class="label_radio"><input type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Sim
      <input type="radio" class="radio" name="status" value="I" <%= (status.equals("I")? "checked": "") %>>Não</td>
  </tr>
   <%if(acao.equals("atu")){%>
  
  	<tr>
   	 	<td class="label_menor"><center>&nbsp Registro: <%if (dtCad != null) { %><%=converte.DMYToYMD(dtCad)%><% }%>&nbsp</center></td>
  	    <td class="label_menor"><center>&nbsp Modificação: <%if (dtMod != null) { %><%=converte.DMYToYMD(dtMod)%><% }%>&nbsp</center></td>
	</tr>

  <% }%>
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