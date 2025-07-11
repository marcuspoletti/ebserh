<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.Banco"%>
<%@page import="afero.util.ConverteDate"%>
<%@page import="afero.persistence.BancoDAO"%>
<%@page import ="java.util.*" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/>"></script>

<script>
function salvar() {
  if (document.all.nmBanco.value == '') {
    window.alert("O campo Nome Banco é obrigatório.");
    document.all.nmBanco.focus();
   } else if (document.all.nrBanco.value == '') {
    window.alert("O campo Número do Banco é obrigatório.");
    document.all.nrBanco.focus();
   } else {
  	document.forms[0].submit();
  }
}

function cancelar() {
  document.forms[0].action="formBanco.jsp";
  document.forms[0].submit();
}

function recarregar(acao) {
  document.forms[0].action='formBanco.jsp?acao='+acao;
  document.forms[0].submit();
}


function voltar() {
  document.forms[0].action = 'listarBanco.jsp?acao=voltar'
	document.forms[0].submit();
}  
</script>
</head>
<%
String idBanco = request.getParameter("idBanco");
String acao = request.getParameter("acao");

if (acao == null) acao = "inc";
if(idBanco == null) idBanco = "0";
String nmBanco = "";
String nrBanco = "";
String status = "A";

if (acao.equalsIgnoreCase("atu")){
	  BancoDAO dao = new BancoDAO(conn);
	  Banco banco = dao.procurarBanco(Integer.parseInt(idBanco));
		nmBanco = banco.getNmBanco();
		nrBanco = banco.getNrBanco();
		status = banco.getStatus();
	}

%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Banco</h1>
<form method="post" action="listarBanco.jsp?acao=<%=acao%>&idBanco=<%=idBanco%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="idBanco" value="<%=idBanco%>"/>


<table border="0" width="100%">

   <tr>
    <th class="label">Nome do Banco*</th>
    <td><input type="text" id="nmBanco" name="nmBanco" <%if (nmBanco != null) { %>value="<%=nmBanco%>"<% }%>  size="50" maxlength="50"></td>
  </tr>

  <tr>
    <th class="label">Número do Banco*</th>
    <td><input type="text" id="nrBanco" name="nrBanco" <%if (nrBanco != null) { %>value="<%=nrBanco%>"<% }%>  size="10" maxlength="10"></td>
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