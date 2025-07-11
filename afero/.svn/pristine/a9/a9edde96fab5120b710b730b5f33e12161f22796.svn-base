<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.TipoDocumento"%>
<%@page import="afero.util.ConverteDate"%>
<%@page import="afero.persistence.TipoDocumentoDAO"%>
<%@page import ="java.util.*" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/>"></script>

<script>
function salvar() {
  if (document.all.dsTipoDocumento.value == '') {
    window.alert("O campo Descrição Tipo do Documento é obrigatório.");
    document.all.dsTipoDocumento.focus();
//   }if (document.all.cdTipoDocumento.value == '') {
//    window.alert("O campo Código do Tipo do Documento é obrigatório.");
//    document.all.cdTipoDocumento.focus();
   }else {
  	document.forms[0].submit();
  }
}

function cancelar() {
  document.forms[0].action="formTipoDocumento.jsp";
  document.forms[0].submit();
}

function recarregar(acao) {
  document.forms[0].action='formTipoDocumento.jsp?acao='+acao;
  document.forms[0].submit();
}


function voltar() {
  document.forms[0].action = 'listarTipoDocumento.jsp?acao=voltar'
	document.forms[0].submit();
}  
</script>
</head>
<%
String idTipoDocumento = request.getParameter("idTipoDocumento");
String dsTipoDocumento = request.getParameter("dsTipoDocumento");
String cdTipoDocumento = request.getParameter("cdTipoDocumento");
String status = request.getParameter("status");
String acao = request.getParameter("acao");
ConverteDate converte = new ConverteDate();
if (acao == null) acao = "inc";
if(idTipoDocumento == null) idTipoDocumento = "0";
if(dsTipoDocumento == null) dsTipoDocumento = "";
if(cdTipoDocumento == null) cdTipoDocumento = "";
if(status == null)status = "A";

if (acao.equalsIgnoreCase("atu")){
	TipoDocumentoDAO dao = new TipoDocumentoDAO(conn);
	TipoDocumento tipoDocumento = dao.procurarTipoDocumento(Integer.parseInt(idTipoDocumento));
	dsTipoDocumento = tipoDocumento.getDsTipoDocumento();
	cdTipoDocumento = tipoDocumento.getCdTipoDocumento();
	status          = tipoDocumento.getStatus();
	}

%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Tipo de Documento</h1>
<form method="post" action="listarTipoDocumento.jsp?acao=<%=acao%>&idTipoDocumento=<%=idTipoDocumento%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="idTipoDocumento" value="<%=idTipoDocumento%>"/>



<table border="0" width="100%">

   <tr>
    <th class="label">Descrição Tipo de Documento*</th>
    <td><input type="text" id="dsTipoDocumento" name="dsTipoDocumento" <%if (dsTipoDocumento != null) { %>value="<%=dsTipoDocumento%>"<% }%>  size="40" maxlength="40"></td>
  </tr>

  <tr>
    <th class="label">Código Tipo de Documento*</th>
    <td><input type="text" id="cdTipoDocumento" name="cdTipoDocumento" <%if (cdTipoDocumento != null) { %>value="<%=cdTipoDocumento%>"<% }%>  size="10" maxlength="10"></td>
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