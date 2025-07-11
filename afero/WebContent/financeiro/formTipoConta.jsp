<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.TipoConta"%>
<%@page import="afero.util.ConverteDate"%>
<%@page import="afero.persistence.TipoContaDAO"%>
<%@page import ="java.util.*" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/></script>

<script>
function salvar() {
  if (document.all.dsTipoConta.value == '') {
    window.alert("O campo Descrição Tipo Conta é obrigatório.");
    document.all.dsTipoConta.focus();
   } else {
  	document.forms[0].submit();
  }
}

function cancelar() {
  document.forms[0].action="formTipoConta.jsp";
  document.forms[0].submit();
}

function recarregar(acao) {
  document.forms[0].action='formTipoConta.jsp?acao='+acao;
  document.forms[0].submit();
}


function voltar() {
  document.forms[0].action = 'listarTipoConta.jsp?acao=voltar'
	document.forms[0].submit();
}  
</script>
</head>
<%
String idTipoConta = request.getParameter("idTipoConta");
String dsTipoConta = request.getParameter("dsTipoConta");
String status = request.getParameter("status");
String acao = request.getParameter("acao");
ConverteDate converte = new ConverteDate();
if (acao == null) acao = "inc";
if(idTipoConta == null) idTipoConta = "0";
if(dsTipoConta == null) dsTipoConta = "";
if(status == null)status = "A";
if (acao.equalsIgnoreCase("atu")){
	    TipoContaDAO dao = new TipoContaDAO(conn);
	    TipoConta tipoConta = dao.procurarTipoConta(Integer.parseInt(idTipoConta));
		dsTipoConta = tipoConta.getDsTipoConta();
		status = tipoConta.getStatus();
	}

%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Tipo de Conta</h1>
<form method="post" action="listarTipoConta.jsp?acao=<%=acao%>&idTipoConta=<%=idTipoConta%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="idTipoConta" value="<%=idTipoConta%>"/>


<table border="0" width="100%">

   <tr>
    <th class="label">Descrição Tipo Conta*</th>
    <td><input type="text" id="dsTipoConta" name="dsTipoConta" <%if (dsTipoConta != null) { %>value="<%=dsTipoConta%>"<% }%>  size="40" maxlength="40"></td>
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