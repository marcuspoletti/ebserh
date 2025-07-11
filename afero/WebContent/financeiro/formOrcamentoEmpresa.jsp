
<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.OrcamentoEmpresa"%>
<%@page import="afero.util.ConverteDate"%>
<%@page import="afero.persistence.OrcamentoEmpresaDAO"%>
<%@page import ="java.util.*" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/>"></script>

<script>
function salvar() {
  if (document.all.nmOrcamentoEmpresa.value == '') {
    window.alert("O campo Descrição do Orçamento é obrigatório.");
    document.all.nmOrcamentoEmpresa.focus();
   }else {
  	document.forms[0].submit();
  }
}

function cancelar() {
  document.forms[0].action="formOrcamentoEmpresa.jsp";
  document.forms[0].submit();
}

function recarregar(acao) {
  document.forms[0].action='formOrcamentoEmpresa.jsp?acao='+acao;
  document.forms[0].submit();
}


function voltar() {
  document.forms[0].action = 'listarOrcamentoEmpresa.jsp?acao=voltar'
	document.forms[0].submit();
}  
</script>
</head>
<%
String idOrcamentoEmpresa = request.getParameter("idOrcamentoEmpresa");
String nmOrcamentoEmpresa = request.getParameter("nmOrcamentoEmpresa");
String status = request.getParameter("status");
String acao = request.getParameter("acao");
ConverteDate converte = new ConverteDate();
if (acao == null) acao = "inc";
if(idOrcamentoEmpresa == null) idOrcamentoEmpresa = "0";
if(nmOrcamentoEmpresa == null)nmOrcamentoEmpresa = "";
if(status == null)status = "A";
if (acao.equalsIgnoreCase("atu")){
	    OrcamentoEmpresaDAO dao = new OrcamentoEmpresaDAO(conn);
	    OrcamentoEmpresa orcamentoEmpresa = dao.procurarOrcamentoEmpresa(Integer.parseInt(idOrcamentoEmpresa));
	    nmOrcamentoEmpresa = orcamentoEmpresa.getNmOrcamentoEmpresa();
		status = orcamentoEmpresa.getStatus();
	}

%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Orçamento da Empresa</h1>
<form method="post" action="listarOrcamentoEmpresa.jsp?acao=<%=acao%>&idOrcamentoEmpresa=<%=idOrcamentoEmpresa%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="idOrcamentoEmpresa" value="<%=idOrcamentoEmpresa%>"/>


<table border="0" width="100%">

   <tr>
    <th class="label">Descrição do Orçamento*</th>
    <td><input type="text" id="nmOrcamentoEmpresa" name="nmOrcamentoEmpresa" <%if (nmOrcamentoEmpresa != null) { %>value="<%=nmOrcamentoEmpresa%>"<% }%>  size="50" maxlength="50"></td>
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