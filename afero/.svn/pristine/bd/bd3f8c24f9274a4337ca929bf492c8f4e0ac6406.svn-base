<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.EntidadeTelefone" %>
<%@ page import="afero.persistence.EntidadeTelefoneDAO" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function salvar() {
  if (document.all.nroTelefone.value == '') {
    window.alert("O campo Telefone é obrigatório.");
    document.all.nroTelefone.focus();
   } else {
  	document.forms[0].submit();
  }
}

function cancelar() {
  document.forms[0].action="formEntidadeTelefoneSimplificado.jsp";
  document.forms[0].submit();
}

function voltar(cdEntidade) {
  document.forms[0].action = 'listarEntidadeTelefoneSimplificado.jsp?acao=voltar&cdEntidade='+cdEntidade;
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
//variáveis capturadas da página listarEntidadeTelefoneSimplificado.jsp
String acao = request.getParameter("acao");
String cdEntidade = request.getParameter("cdEntidade");
String idEntidadeTelefone = request.getParameter("idEntidadeTelefone");
String selectAba = request.getParameter("selectAba");
String acaoAnterior = request.getParameter("acaoAnterior");
if (acao == null) acao = "inc";
if (cdEntidade == null) cdEntidade = "";
if (idEntidadeTelefone == null) idEntidadeTelefone = "";
if (selectAba == null) selectAba = "1";
if (acaoAnterior == null) acaoAnterior = "atu";

String tpInsc = request.getParameter("tpInsc");
if (tpInsc == null) tpInsc = "F";
int cdTipoTelefone;
if (!tpInsc.equals("F")) cdTipoTelefone = 1; else cdTipoTelefone = 3;
String nroTelefone = "";
String ramTelefone = "";
String telefonePadrao ="N";

String mensagem = request.getParameter("mensagem");

//verifica se acao foi atualizar
if (acao.equalsIgnoreCase("atu")) {
  EntidadeTelefoneDAO dao = new EntidadeTelefoneDAO(conn);
  EntidadeTelefone entidadeTelefone = dao.procurarEntidadeTelefone(Integer.parseInt(idEntidadeTelefone));
  cdEntidade = String.valueOf(entidadeTelefone.getCdEntidade());
  cdTipoTelefone = entidadeTelefone.getCdTipoTelefone();
	nroTelefone  = entidadeTelefone.getNroTelefone();
	ramTelefone  = entidadeTelefone.getRamTelefone();
	telefonePadrao = entidadeTelefone.getPadrao();
}
%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Telefone - Entidade</h1>
<hr><% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<form method="post" action="listarEntidadeTelefoneSimplificado.jsp?cdEntidade=<%=cdEntidade%>&acao=<%=acao%>&idEntidadeTelefone=<%=idEntidadeTelefone%>&acaoAnterior=<%=acaoAnterior%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="cdEntidade" value="<%=cdEntidade%>"/>
<input type="hidden" name="idEntidadeTelefone" value="<%=idEntidadeTelefone%>"/>
<input type="hidden" name="selectAba" value="<%=selectAba%>"/>
<input type="hidden" name="acaoAnterior" value="<%=acaoAnterior%>"/>

<table border="0" width="100%">
  <tr>
    <th class="label">Tipo Telefone</th>
    <td><select name="cdTipoTelefone" style="width: 172px">
        <option value='1'>Selecione...</option>
        <%@include file="../WEB-INF/jspf/combo/comboTipoTelefone.jspf" %></select>
        <script>comboSelect(document.forms[0].cdTipoTelefone, '<%= cdTipoTelefone %>');</script>
    </td>
  </tr>
  <tr>
    <th class="label">Telefone*</th>
    <td><input type="text" id="nroTelefone" name="nroTelefone" <%if (nroTelefone != null) { %>value="<%=nroTelefone%>"<% }%>  size="15" maxlength="15"></td>
  </tr>
  <tr>
    <th class="label">Ramal</th>
    <td><input type="text" id="ramTelefone" name="ramTelefone" <%if (ramTelefone != null) { %>value="<%=ramTelefone%>"<% }%>  size="5" maxlength="5"></td>
  </tr>
  <tr>
    <th class="label">Padrão</th>
      <td class="label_radio"><input type="radio" class="radio" name="telefonePadrao" value="S" <%= (telefonePadrao.equals("S")? "checked": "") %>>Sim
      <input type="radio" class="radio" name="telefonePadrao" value="N" <%= (telefonePadrao.equals("N")? "checked": "") %>>Não</td>    
  </tr>
</table><hr>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
	<td><input class="button" type="button" value="Salvar" onClick="javascript: salvar();" />
	<input class="button" type="button" value="Cancelar" onClick="javascript: cancelar();" />
	<input class="button" type="button" value="Voltar" onClick="javascript:history.go(-1);" /></td>
	<td class="campo_obrigatorio">* Campos Obrigatórios</td>
</tr>
</table>
</form>
<%@include file="../fimConexao.jsp"%>

</body>
</html>