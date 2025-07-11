<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.Mesa"%>
<%@page import="afero.persistence.MesaDAO"%>
<%@include file="../../seguranca.jsp"%>
<%@include file="../../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../../css/afero.css" />
<script>
function salvar() {
  if (document.all.dsMesa.value == '') {
    window.alert("O campo Mesa é obrigatório.");
    document.all.dsMesa.focus();
   }else {
  	document.forms[0].submit();
  }
}

function cancelar() {
  document.forms[0].action="formMesa.jsp";
  document.forms[0].submit();
}

function voltar() {
  document.forms[0].action = 'listarMesa.jsp?acao=voltar'
	document.forms[0].submit();
}
</script>
</head>
<%
//variáveis capturadas da página listarCidade.jsp
String acao = request.getParameter("acao");
String idMesa = request.getParameter("idMesa");

if (acao == null) acao = "inc";
if (idMesa == null) idMesa = "";
String dsMesa = "";
String status ="L";


//verifica se acao foi atualizar
if (acao.equalsIgnoreCase("atu")) {
  MesaDAO dao = new MesaDAO(conn);
  Mesa mesa = dao.procurarMesa(Integer.parseInt(idMesa));
  dsMesa  = mesa.getDsMesa();
  status = mesa.getStatus(); 
}
%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Mesa</h1>
<form method="post" action="listarMesa.jsp?acao=<%=acao%>&idMesa=<%=idMesa%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="idMesa" value="<%=idMesa%>"/>

<table border="0" width="100%">
  <tr>
    <th class="label">Mesa*</th>
    <td><input type="text" name="dsMesa" <%if (dsMesa != null) { %>value="<%=dsMesa%>"<% }%>  size="40" maxlength="40"></td>
  <tr>
    <th class="label">Ativo</th>
      <td class="label_radio">
      <input type="radio" class="radio" name="status" value="L" <%= (status.equals("L")? "checked": "") %>>Livre
      <input disabled type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Aberta
      <input disabled type="radio" class="radio" name="status" value="C" <%= (status.equals("C")? "checked": "") %>>Consumindo
      <input disabled type="radio" class="radio" name="status" value="F" <%= (status.equals("F")? "checked": "") %>>Fechada
      <input disabled type="radio" class="radio" name="status" value="R" <%= (status.equals("R")? "checked": "") %>>Reservada
      <input type="radio" class="radio" name="status" value="I" <%= (status.equals("I")? "checked": "") %>>Indisponível</td>
    
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
<%@include file="../../fimConexao.jsp"%>
</body>
</html>