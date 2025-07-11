<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.PlanoConta"%>
<%@page import="afero.persistence.PlanoContaDAO"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script>
function salvar() {
  if (document.all.cdPlanoConta.value == '') {
    window.alert("O campo Código Plano Conta é obrigatório.");
    document.all.cdPlanoConta.focus();
   } else if (document.all.nmPlanoConta.value == ''){
      window.alert("O campo Descrição Plano Conta é obrigatório.");
      document.all.nmPlanoConta.focus();
   } else {
  	document.forms[0].submit();
  }
}

function cancelar() {
  document.forms[0].action="formPlanoConta.jsp";
  document.forms[0].submit();
}

function voltar() {
  document.forms[0].action = 'listarPlanoConta.jsp?acao=voltar'
	document.forms[0].submit();
}
function comboSelect(combo, key) {
  var err = window.onerror; 
  window.onerror = new Function('return true'); 
  if (!combo) return; 
  combo.selectedIndex=-1; 
  for (var i = 0; i < combo.options.length; i++) {
    if (combo.multiple) {
      combo.options[i].selected=((","+key+",").indexOf(","+combo.options[i].value+",") != -1); 
    } else {
      combo.options[i].selected=(combo.options[i].value == key);
    }
  }
  window.onerror = err;
}  
</script>
</head>
<%
//variáveis capturadas da página listarCidade.jsp
String acao = request.getParameter("acao");
String idPlanoConta = request.getParameter("idPlanoConta");

if (acao == null) acao = "inc";
if (idPlanoConta == null) idPlanoConta = "0";
int idPlanoContaPai = 0;
String cdPlanoConta = "";
String nmPlanoConta = "";
String dc = "C";
String status ="A";


//verifica se acao foi atualizar
if (acao.equalsIgnoreCase("atu")) {
    PlanoContaDAO dao = new PlanoContaDAO(conn);
    PlanoConta planoConta = dao.procurarPlanoConta(Integer.parseInt(idPlanoConta));
    idPlanoContaPai = planoConta.getIdPlanoContaPai();
		cdPlanoConta = planoConta.getCdPlanoConta();
    nmPlanoConta =  planoConta.getNmPlanoConta();
    dc = planoConta.getDc();
    status = planoConta.getStatus();
}
%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Plano Conta</h1>
<form method="post" action="listarPlanoConta.jsp?acao=<%=acao%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="idPlanoConta" value="<%=idPlanoConta%>"/>

<table border="0" width="100%">
  <tr>
    <th class="label">Código Plano Conta*</th>
    <td><input type="text" name="cdPlanoConta" <%if (cdPlanoConta != null) { %>value="<%=cdPlanoConta%>"<% }%>  size="20" maxlength="20"></td>
  </tr>
  <tr>
    <th class="label">Descrição Plano Conta*</th>
    <td><input type="text" name="nmPlanoConta" <%if (nmPlanoConta != null) { %>value="<%=nmPlanoConta%>"<% }%>  size="60" maxlength="50"></td>
  </tr>
  <tr>
      <th class="label">Sub-Plano Conta de</th>
      <td><select name="idPlanoContaPai">
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboPlanoContaPai.jspf" %></select>
          <script>comboSelect(document.forms[0].idPlanoContaPai, '<%= idPlanoContaPai %>');</script>
      </td>
  </tr>
  
  <tr>
    <th class="label">Crédito / Débito</th>
      <td class="label_radio"><input type="radio" class="radio" name="dc" value="C" <%= (dc.equals("C")? "checked": "") %>>Crédito
      <input type="radio" class="radio" name="dc" value="D" <%= (dc.equals("D")? "checked": "") %>>Débito</td>
    
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