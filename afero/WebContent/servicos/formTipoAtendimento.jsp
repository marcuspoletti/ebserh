<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.TipoAtendimento" %>
<%@page import="afero.util.ConverteDate"%>
<%@page import="afero.persistence.TipoAtendimentoDAO" %>
<%@page import ="java.util.*" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/></script>

<script>
function salvar() {
  if (document.all.dsTipoAtendimento.value == '') {
    window.alert("O campo Descrição de Tipo de Atendimento é obrigatório.");
    document.all.dsTipoAtendimento.focus();
   }else {
  	document.forms[0].submit();
  }
}

function cancelar() {
  document.forms[0].action="formTipoAtendimento.jsp";
  document.forms[0].submit();
}

function recarregar(acao) {
  document.forms[0].action='formTipoAtendimento.jsp?acao='+acao;
  document.forms[0].submit();
}


function voltar() {
  document.forms[0].action = 'listarTipoAtendimento.jsp?acao=voltar'
	document.forms[0].submit();
}  
</script>
</head>
<%
String cdTipoAtendimento = request.getParameter("cdTipoAtendimento");
String dsTipoAtendimento = request.getParameter("dsTipoAtendimento");
String status = request.getParameter("status");
String acao = request.getParameter("acao");
ConverteDate converte = new ConverteDate();
if (acao == null) acao = "inc";
if(cdTipoAtendimento == null) cdTipoAtendimento = "0";
if(dsTipoAtendimento == null)dsTipoAtendimento = "";
if(status == null)status = "A";
if (acao.equalsIgnoreCase("atu")){
	
	TipoAtendimentoDAO dao = new TipoAtendimentoDAO(conn);
	TipoAtendimento tipoAtendimento = dao.procurarTipoAtendimento(" WHERE cdTipoAtendimento = " +Integer.parseInt(cdTipoAtendimento)+ ";");
	dsTipoAtendimento = tipoAtendimento.getDsTipoAtendimento();
	status = tipoAtendimento.getStatus();
	}

%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Tipo de Atendimento</h1>
<form method="post" action="listarTipoAtendimento.jsp?acao=<%=acao%>&cdTipoAtendiimento=<%=cdTipoAtendimento%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="cdTipoAtendimento" value="<%=cdTipoAtendimento%>"/>


<table border="0" width="100%">
   <tr>
    <th class="label">Descrição Tipo de Atendimento*</th>
    <td><input type="text" id="dsTipoAtendimento" name="dsTipoAtendimento" <%if (dsTipoAtendimento != null) { %>value="<%=dsTipoAtendimento%>"<% }%>  size="50" maxlength="50"></td>
  </tr>
  <tr>
    <th class="label">Status</th>
      <td class="label_radio"><input type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Ativo
      <input type="radio" class="radio" name="status" value="I" <%= (status.equals("I")? "checked": "") %>>Inativo</td>    
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