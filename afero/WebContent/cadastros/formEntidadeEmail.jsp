<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.EntidadeEmail" %>
<%@ page import="afero.persistence.EntidadeEmailDAO" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function salvar() {
  if (document.all.dsEmail.value == '') {
    window.alert("O campo Email é obrigatório.");
    document.all.dsEmail.focus();
   } else {
  	document.forms[0].submit();
  }
}

function cancelar() {
  document.forms[0].action="formEntidadeEmail.jsp";
  document.forms[0].submit();
}

function voltar(cdEntidade) {
  document.forms[0].action = 'listarEntidadeEmail.jsp?acao=voltar&cdEntidade='+cdEntidade;
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
//variáveis capturadas da página listarEntidadeEmail.jsp
String acao = request.getParameter("acao");
String cdEntidade = request.getParameter("cdEntidade");
String idEntidadeEmail = request.getParameter("idEntidadeEmail");
String selectAba = request.getParameter("selectAba");
String acaoAnterior = request.getParameter("acaoAnterior");
if (acao == null) acao = "inc";
if (cdEntidade == null) cdEntidade = "";
if (idEntidadeEmail == null) idEntidadeEmail = "";
if (selectAba == null) selectAba = "5";
if (acaoAnterior == null) acaoAnterior = "atu";

String tpInsc = request.getParameter("tpInsc");
if (tpInsc == null) tpInsc = "F";
int cdTipoEmail;
if (!tpInsc.equals("F")) cdTipoEmail = 1; else cdTipoEmail = 3;
String dsEmail = "";
String emailPadrao ="N";

String mensagem = request.getParameter("mensagem");

//verifica se acao foi atualizar
if (acao.equalsIgnoreCase("atu")) {
  EntidadeEmailDAO dao = new EntidadeEmailDAO(conn);
  EntidadeEmail entidadeEmail = dao.procurarEntidadeEmail(Integer.parseInt(idEntidadeEmail));
  cdEntidade = String.valueOf(entidadeEmail.getCdEntidade());
  cdTipoEmail = entidadeEmail.getCdTipoEmail();
	dsEmail  = entidadeEmail.getDsEmail();
	emailPadrao = entidadeEmail.getPadrao();
}
%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Email - Entidade</h1>
<hr><% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<form method="post" action="listarEntidadeEmail.jsp?cdEntidade=<%=cdEntidade%>&acao=<%=acao%>&idEntidadeEmail=<%=idEntidadeEmail%>&acaoAnterior=<%=acaoAnterior%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="cdEntidade" value="<%=cdEntidade%>"/>
<input type="hidden" name="idEntidadeEmail" value="<%=idEntidadeEmail%>"/>
<input type="hidden" name="selectAba" value="<%=selectAba%>"/>
<input type="hidden" name="acaoAnterior" value="<%=acaoAnterior%>"/>

<table border="0" width="100%">
  <tr>
    <th class="label">Tipo Email</th>
    <td><select name="cdTipoEmail" style="width: 172px">
        <option value='1'>Selecione...</option>
        <%@include file="../WEB-INF/jspf/combo/comboTipoEmail.jspf" %></select>
        <script>comboSelect(document.forms[0].cdTipoEmail, '<%= cdTipoEmail %>');</script>
    </td>
  </tr>
  <tr>
    <th class="label">Email*</th>
    <td><input type="text" id="dsEmail" name="dsEmail" <%if (dsEmail != null) { %>value="<%=dsEmail%>"<% }%>  size="40" maxlength="40"></td>
  </tr>
  <tr>
    <th class="label">Padrão</th>
      <td class="label_radio"><input type="radio" class="radio" name="emailPadrao" value="S" <%= (emailPadrao.equals("S")? "checked": "") %>>Sim
      <input type="radio" class="radio" name="emailPadrao" value="N" <%= (emailPadrao.equals("N")? "checked": "") %>>Não</td>    
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