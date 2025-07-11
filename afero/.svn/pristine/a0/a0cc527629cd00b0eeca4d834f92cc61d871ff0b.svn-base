<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.TipoEntidade"%>
<%@page import="afero.persistence.TipoEntidadeDAO"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function salvar() {
  if (document.all.descricao.value == '') {
    window.alert("O campo descricão é obrigatório.");
    document.all.descricao.focus();
   } else {
  	document.forms[0].submit();
  }
}

function cancelar() {
  document.forms[0].action="formTipoEntidade.jsp";
  document.forms[0].submit();
}

function voltar() {
  document.forms[0].action = 'listarTipoEntidade.jsp?acao=voltar'
	document.forms[0].submit();
}  
</script>
</head>
<%
//variáveis capturadas da página listarTipoEntidae.jsp
String acao = request.getParameter("acao");
String idTipoEntidade = request.getParameter("idTipoEntidade");

if (acao == null) acao = "inc";
if (idTipoEntidade == null) idTipoEntidade = "";
String descricao = "";
String status ="A";

//verifica se acao foi atualizar
if (acao.equalsIgnoreCase("atu")) {
  TipoEntidadeDAO dao = new TipoEntidadeDAO(conn);
  TipoEntidade tipoEntidade = dao.procurarTipoEntidade(Integer.parseInt(idTipoEntidade));
	descricao  = tipoEntidade.getDsTipoEntidade();
	status = tipoEntidade.getStatus();
}
%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Tipo de Entidade</h1>
<form method="post" action="listarTipoEntidade.jsp?acao=<%=acao%>&idTipoEntidade=<%=idTipoEntidade%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="idTipoEntidade" value="<%=idTipoEntidade%>"/>

<table border="0" width="100%">
  <tr>
    <th class="label">Descrição*</th>
    <td><input type="text" id="descricao" name="descricao" <%if (descricao != null) { %>value="<%=descricao%>"<% }%>  size="30" maxlength="30"></td>
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