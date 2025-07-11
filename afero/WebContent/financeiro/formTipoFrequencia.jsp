<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.TipoFrequencia"%>
<%@page import="afero.util.ConverteDate"%>
<%@page import="afero.persistence.TipoFrequenciaDAO"%>
<%@page import ="java.util.*" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/>"></script>

<script>
function salvar() {
  if (document.all.dsTipoFrequencia.value == '') {
    window.alert("O campo Descrição da Frequencia é obrigatório.");
    document.all.dsTipoFrequencia.focus();
   }else {
  	document.forms[0].submit();
  }
}

function cancelar() {
  document.forms[0].action="formTipoFrequencia.jsp";
  document.forms[0].submit();
}

function recarregar(acao) {
  document.forms[0].action='formTipoFrequencia.jsp?acao='+acao;
  document.forms[0].submit();
}


function voltar() {
  document.forms[0].action = 'listarTipoFrequencia.jsp?acao=voltar'
	document.forms[0].submit();
}  
</script>
</head>
<%
String cdTipoFrequencia = request.getParameter("cdTipoFrequencia");
String dsTipoFrequencia = request.getParameter("dsTipoFrequencia");
String status = request.getParameter("status");
String acao = request.getParameter("acao");
ConverteDate converte = new ConverteDate();
if (acao == null) acao = "inc";
if(cdTipoFrequencia == null) cdTipoFrequencia = "0";
if(dsTipoFrequencia == null)dsTipoFrequencia = "";
if(status == null)status = "A";
if (acao.equalsIgnoreCase("atu")){
	    TipoFrequenciaDAO dao = new TipoFrequenciaDAO(conn);
	    TipoFrequencia tipoFrequencia = dao.procurarTipoFrequencia(Integer.parseInt(cdTipoFrequencia));
	    dsTipoFrequencia = tipoFrequencia.getDsTipoFrequencia();
		status = tipoFrequencia.getStatus();
	}

%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Tipo de Frequência</h1>
<form method="post" action="listarTipoFrequencia.jsp?acao=<%=acao%>&cdTipoFrequencia=<%=cdTipoFrequencia%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="cdTipoFrequencia" value="<%=cdTipoFrequencia%>"/>


<table border="0" width="100%">

   <tr>
    <th class="label">Descrição Tipo de Frequência*</th>
    <td><input type="text" id="dsTipoFrequencia" name="dsTipoFrequencia" <%if (dsTipoFrequencia != null) { %>value="<%=dsTipoFrequencia%>"<% }%>  size="50" maxlength="50"></td>
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