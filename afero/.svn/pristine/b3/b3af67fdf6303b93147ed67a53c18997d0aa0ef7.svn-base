<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.RamoAtividade"%>
<%@page import="afero.persistence.RamoAtividadeDAO"%>
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
  document.forms[0].action="formRamoAtividade.jsp";
  document.forms[0].submit();
}

function voltar() {
  document.forms[0].action = 'listarRamoAtividade.jsp?acao=voltar'
	document.forms[0].submit();
}  
</script>
</head>
<%
//variáveis capturadas da página listarRamoAtividade.jsp
String acao = request.getParameter("acao");
String idRamoAtividade = request.getParameter("idRamoAtividade");

if (acao == null) acao = "inc";
if (idRamoAtividade == null) idRamoAtividade = "";
String descricao = "";
String status ="A";

//verifica se acao foi atualizar
if (acao.equalsIgnoreCase("atu")) {
  RamoAtividadeDAO dao = new RamoAtividadeDAO(conn);
  RamoAtividade tipoRamoAtividade = dao.procurarRamoAtividade(Integer.parseInt(idRamoAtividade));
	descricao  = tipoRamoAtividade.getDsRamoAtividade();
	status = tipoRamoAtividade.getStatus();
}
%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Ramo de Atividade</h1>
<form method="post" action="listarRamoAtividade.jsp?acao=<%=acao%>&idRamoAtividade=<%=idRamoAtividade%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="idRamoAtividade" value="<%=idRamoAtividade%>"/>

<table border="0" width="100%">
  <tr>
    <th class="label">Descrição*</th>
    <td><input type="text" id="descricao" name="descricao" <%if (descricao != null) { %>value="<%=descricao%>"<% }%>  size="40" maxlength="40"></td>
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