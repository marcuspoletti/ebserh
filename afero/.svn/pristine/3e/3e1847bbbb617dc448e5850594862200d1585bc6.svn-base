
<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.RelacaoUnidade"%>
<%@page import="afero.persistence.RelacaoUnidadeDAO"%>
<%@page import="afero.util.Utilitaria"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/>"></script>
<script>
function salvar() {
  if (document.all.idUnidadeDe.value == document.all.idUnidadePara.value ) {
    window.alert("Os campo Unidade De e Unidade Para não devem ser iguais.");
    document.all.idUnidadeDe.focus(); 
  }else if (document.all.idUnidadeDe.value == '0') {
    	window.alert("O campo descricão é obrigatório.");
    	document.all.idUnidadeDe.focus();
  }else if (document.all.idUnidadePara.value == '0') {
    window.alert("O campo descricão é obrigatório.");
    document.all.idUnidadePara.focus(); 
  }else {
  	document.forms[0].submit();
  }
}

function cancelar() {
  document.forms[0].action="formRelacaoUnidade.jsp";
  document.forms[0].submit();
}

function voltar() {
  document.forms[0].action = 'listarRelacaoUnidade.jsp?acao=voltar'
	document.forms[0].submit();
}  
</script>
</head>
<%
//variáveis capturadas da página listarRamoAtividade.jsp
Utilitaria util = new Utilitaria();
String acao = request.getParameter("acao");
String idRelacaoUnidade = request.getParameter("idRelacaoUnidade");

if (acao == null) acao = "inc";
if (idRelacaoUnidade == null) idRelacaoUnidade = "";
int idUnidadeDe = 0;
int idUnidadePara = 0;
String fatorConversao = "0";

//verifica se acao foi atualizar
if (acao.equalsIgnoreCase("atu")) {
  RelacaoUnidadeDAO dao = new RelacaoUnidadeDAO(conn);
  RelacaoUnidade relacaoUnidade = dao.procurarRelacaoUnidade(Integer.parseInt(idRelacaoUnidade));
  idUnidadeDe  = relacaoUnidade.getIdUnidadeDe();
  idUnidadePara= relacaoUnidade.getIdUnidadePara();
  fatorConversao = util.formatarNumero(relacaoUnidade.getFatorConversao(),2);
}
%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Relacao Unidade</h1>
<form method="post" action="listarRelacaoUnidade.jsp?acao=<%=acao%>&idRelacaoUnidade=<%=idRelacaoUnidade%>">

<table border="0" width="100%">
<tr>
      <th class="label">Unidade De *</th>
      <td><select name="idUnidadeDe" style="width: 172px">
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboUnidadeDe.jspf" %></select>
          <script>comboSelect(document.forms[0].idUnidadeDe, '<%= idUnidadeDe %>');</script>
      </td>
  </tr>
  
  <tr>
      <th class="label">Unidade Para *</th>
      <td><select name="idUnidadePara" style="width: 172px">
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboUnidadePara.jspf"%></select>
          <script>comboSelect(document.forms[0].idUnidadePara, '<%= idUnidadePara %>');</script>
      </td>
  </tr>
  
  <tr>
    <th class="label">Fator Conversão*</th>
    <td><input type="text" id="fatorConversao" name="fatorConversao" value="<%=fatorConversao%>" onkeyup="FormataValor(this,event)" size="40" maxlength="40"></td>
  </tr>
  
  
</table>
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