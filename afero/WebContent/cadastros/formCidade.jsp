<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.Cidade"%>
<%@page import="afero.persistence.CidadeDAO"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script>
function salvar() {
  if (document.all.nmCidade.value == '') {
    window.alert("O campo Cidade é obrigatório.");
    document.all.nmCidade.focus();
   } else if (document.all.cdEstado.value == 0){
      window.alert("O campo Estado é obrigatório.");
      document.all.cdEstado.focus();
   } else {
  	document.forms[0].submit();
  }
}

function cancelar() {
  document.forms[0].action="formCidade.jsp";
  document.forms[0].submit();
}

function voltar() {
  document.forms[0].action = 'listarCidade.jsp?acao=voltar'
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
//variáveis capturadas da página listarCidade.jsp
String acao = request.getParameter("acao");
String idCidade = request.getParameter("idCidade");

if (acao == null) acao = "inc";
if (idCidade == null) idCidade = "";
String nmCidade = "";
String cdMunicipio = "";
String status ="A";
int cdEstado = 0;

//verifica se acao foi atualizar
if (acao.equalsIgnoreCase("atu")) {
  CidadeDAO dao = new CidadeDAO(conn);
  Cidade cidade = dao.procurarCidade(Integer.parseInt(idCidade));
	nmCidade  = cidade.getNmCidade();
	cdMunicipio = cidade.getCdMunicipio();
	status = cidade.getStatus();
	cdEstado = cidade.getCdEstado(); 
}
%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Cidade</h1>
<form method="post" action="listarCidade.jsp?acao=<%=acao%>&idCidade=<%=idCidade%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="idCidade" value="<%=idCidade%>"/>

<table border="0" width="100%">
  <tr>
    <th class="label">Cidade*</th>
    <td><input type="text" name="nmCidade" <%if (nmCidade != null) { %>value="<%=nmCidade%>"<% }%>  size="40" maxlength="40"></td>
  </tr>
  <tr>
      <th class="label">Estado</th>
      <td><select name="cdEstado" style="width: 172px">
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboEstado.jspf" %></select>
          <script>comboSelect(document.forms[0].cdEstado, '<%= cdEstado %>');</script>
      </td>
  </tr>
  <tr>
    <th class="label">Cód.Municipio</th>
    <td><input type="text" name="cdMunicipio" <%if (cdMunicipio != null) { %>value="<%=cdMunicipio%>"<% }%>  size="7" maxlength="7"></td>
  </tr>
  <tr>
    <th class="label">Ativo</th>
      <td class="label_radio"><input type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Sim
      <input type="radio" class="radio" name="status" value="I" <%= (status.equals("I")? "checked": "") %>>Não</td>
    
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