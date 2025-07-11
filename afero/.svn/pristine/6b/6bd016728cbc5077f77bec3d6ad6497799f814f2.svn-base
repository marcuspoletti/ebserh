<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.CentroCusto"%>
<%@page import="afero.persistence.CentroCustoDAO"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script>
function salvar() {
  if (document.all.cdCentroCusto.value == '') {
    window.alert("O campo Código Centro Custo é obrigatório.");
    document.all.cdCentroCusto.focus();
   } else if (document.all.nmCentroCusto.value == ''){
      window.alert("O campo Descrição Centro Custo é obrigatório.");
      document.all.nmCentroCusto.focus();
   } else {
  	document.forms[0].submit();
  }
}

function cancelar() {
  document.forms[0].action="formCentroCusto.jsp";
  document.forms[0].submit();
}

function voltar() {
  document.forms[0].action = 'listarCentroCusto.jsp?acao=voltar'
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
String idCentroCusto = request.getParameter("idCentroCusto");

if (acao == null) acao = "inc";
if (idCentroCusto == null) idCentroCusto = "0";
int  idCentroCustoPai = 0;
String cdCentroCusto = "";
String nmCentroCusto = "";
String pessoaResponsavel = "";
String nrTelefone = "";
String status ="A";


//verifica se acao foi atualizar
if (acao.equalsIgnoreCase("atu")) {
    CentroCustoDAO dao = new CentroCustoDAO(conn);
    CentroCusto centroCusto = dao.procurarCentroCusto(Integer.parseInt(idCentroCusto));
    idCentroCustoPai = centroCusto.getIdCentroCustoPai();
		cdCentroCusto = centroCusto.getCdCentroCusto();
    nmCentroCusto =  centroCusto.getNmCentroCusto();
    pessoaResponsavel = centroCusto.getPessoaResponsavel();
    nrTelefone = centroCusto.getNroTelefone();
    status = centroCusto.getStatus();
}
%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Centro Custo</h1>
<form method="post" action="listarCentroCusto.jsp?acao=<%=acao%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="idCentroCusto" value="<%=idCentroCusto%>"/>

<table border="0" width="100%">
  <tr>
    <th class="label">Código Centro Custo*</th>
    <td><input type="text" name="cdCentroCusto" <%if (cdCentroCusto != null) { %>value="<%=cdCentroCusto%>"<% }%>  size="20" maxlength="20"></td>
  </tr>
  <tr>
    <th class="label">Descrição Centro Custo*</th>
    <td><input type="text" name="nmCentroCusto" <%if (nmCentroCusto != null) { %>value="<%=nmCentroCusto%>"<% }%>  size="60" maxlength="50"></td>
  </tr>
  <tr>
      <th class="label">Sub-Centro Custo de</th>
      <td><select name="idCentroCustoPai">
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboCentroCustoPai.jspf" %></select>
          <script>comboSelect(document.forms[0].idCentroCustoPai, '<%= idCentroCustoPai %>');</script>
      </td>
  </tr>
  
  <tr>
    <th class="label">Pessoa Responsável</th>
    <td><input type="text" name="pessoaResponsavel" <%if (pessoaResponsavel != null) { %>value="<%=pessoaResponsavel%>"<% }%>  size="60" maxlength="60"></td>
  </tr>
  <tr>
    <th class="label">Número do Telefone</th>
    <td><input type="text" name="nrTelefone" <%if (nrTelefone != null) { %>value="<%=nrTelefone%>"<% }%>  size="20" maxlength="15"></td>
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