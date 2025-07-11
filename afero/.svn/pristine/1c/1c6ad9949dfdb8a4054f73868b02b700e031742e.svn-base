<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.TipoDependente"%>
<%@page import="afero.persistence.TipoDependenteDAO"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function salvar() {
  if (document.all.descricao.value == '') {
    window.alert("O campo descrição é obrigatório.");
    document.all.descricao.focus();
   } else {
  	document.forms[0].submit();
  }
}

function cancelar() {
  document.forms[0].action="formTipoDependente.jsp";
  document.forms[0].submit();
}

function voltar() {
  document.forms[0].action = 'listarTipoDependente.jsp?acao=voltar'
	document.forms[0].submit();
}  
</script>
</head>
<%
//variáveis capturadas da página listarTipoDependente.jsp
String acao = request.getParameter("acao");
String idTipoDependente = request.getParameter("idTipoDependente");

if (acao == null) acao = "inc";
if (idTipoDependente == null) idTipoDependente = "";
String descricao = "";
String status ="A";

//verifica se acao foi atualizar
if (acao.equalsIgnoreCase("atu")) {
  TipoDependenteDAO dao = new TipoDependenteDAO(conn);
  TipoDependente tipoDependente = dao.procurarTipoDependente(Integer.parseInt(idTipoDependente));
	descricao  = tipoDependente.getDsTipoDependente();
	status = tipoDependente.getStatus();
}
%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Tipo Dependente</h1>
<form method="post" action="listarTipoDependente.jsp?acao=<%=acao%>&idTipoDependente=<%=idTipoDependente%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="idTipoDependente" value="<%=idTipoDependente%>"/>

<table border="0" width="100%">
  <tr>
    <th class="label">Descricão*</th>
    <td><input type="text" id="descricao" name="descricao" <%if (descricao != null) { %>value="<%=descricao%>"<% }%>  size="20" maxlength="20"></td>
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