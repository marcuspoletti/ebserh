<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.OrcamentoEmpresaItem"%>
<%@page import="afero.util.ConverteDate"%>
<%@page import="afero.persistence.OrcamentoEmpresaItemDAO"%>
<%@page import ="java.util.*" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/>"></script>
<script>
function salvar() {
     if (document.all.idPlanoConta.value == '0') {
     	 window.alert("O campo Plano Conta é obrigatório.");
     	 document.all.idPlanoConta.focus();
     }else{
        document.forms[0].submit();
     }
}
function cancelar() {
  document.forms[0].action="formOrcamentoEmpresaItem.jsp";
  document.forms[0].submit();
}
function recarregar(acao) {
  document.forms[0].action='formOrcamentoEmpresaItem.jsp?acao='+acao;
  document.forms[0].submit();
}
function voltar() {
  document.forms[0].action = 'listarOrcamentoEmpresaItem.jsp?acao=voltar';
	document.forms[0].submit();
}  
function checaData() {
  var valor = document.getElementById('data').value;
  if (valor.length == 2)
    document.getElementById('data').value = document.getElementById('data').value + "/";
}
</script>
</head>
<%
OrcamentoEmpresaItemDAO daoOrc = new OrcamentoEmpresaItemDAO(conn);
String idOrcamentoEmpresaItem = request.getParameter("idOrcamentoEmpresaItem");
String idOrcamentoEmpresa = request.getParameter("idOrcamentoEmpresa");
String idPlanoConta = request.getParameter("idPlanoConta");
String dtComp = request.getParameter("dtComp");
String valor = request.getParameter("valor");
String dtMov = request.getParameter("dtMov");
String usuario = request.getParameter("usuario");
String acao = request.getParameter("acao");
ConverteDate converte = new ConverteDate();
if (acao == null) acao = "inc";
if(idOrcamentoEmpresaItem == null)idOrcamentoEmpresaItem = "0";
if(idOrcamentoEmpresa == null)idOrcamentoEmpresa = "0";
if(idPlanoConta == null)idPlanoConta = "0";
if(dtComp == null)dtComp = daoOrc.dataAtual();
if(valor == null)valor="0";
if(dtMov == null)dtMov = "";
if(usuario == null)usuario = (String)session.getAttribute("Login");
if (acao.equalsIgnoreCase("atu")){
	    OrcamentoEmpresaItemDAO dao = new OrcamentoEmpresaItemDAO(conn);
	    OrcamentoEmpresaItem orcEmpItem = dao.pesquisarOrcamentoEmpresaItem(Integer.parseInt(idOrcamentoEmpresaItem));
	    idOrcamentoEmpresa = "".valueOf(orcEmpItem.getIdOrcamentoEmpresa());
	    idPlanoConta = "".valueOf(orcEmpItem.getIdPlanoConta());
	    dtMov = orcEmpItem.getDtMov().toString();
	    valor = "".valueOf(orcEmpItem.getValor());
	    usuario = orcEmpItem.getUsuario();
	}

%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Orçamento Item</h1>
<form method="post" action="listarOrcamentoEmpresaItem.jsp?acao=<%=acao%>&idOrcamentoEmpresaItem=<%=idOrcamentoEmpresaItem%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="idOrcamentoEmpresaItem" value="<%=idOrcamentoEmpresaItem%>"/>
<input type="hidden" name="idOrcamentoEmpresa" value="<%=idOrcamentoEmpresa%>"/>
<iframe width=174 height=189 name="gToday:normal:"../js/calendar/agenda.js"
            id="gToday:normal:"../js/calendar/agenda.js" src="../js/calendar/ipopeng.htm"
            scrolling="no" frameborder="0" style="visibility:visible; z-index:999; 
    position:absolute; top:-500px; left:-500px;">
</iframe>


<table border="0" width="100%">

   <tr>
    <th class="label">Plano de Conta</th>
      <td><select name="idPlanoConta" onchange="recarregar('<%=acao%>');">
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboPlanoConta.jspf" %></select>
          <script>comboSelect(document.forms[0].idPlanoConta, '<%= idPlanoConta %>');</script>
      </td>
  </tr>
    <tr>
    <th class="label">Valor*</th>
    <td><input type="text" id="valor" name="valor" <%if (valor != null) { %>value="<%=valor%>"<% }%>  onkeyup="FormataValor(this,event)" size="10" maxlength="10" ></td>
  </tr>
  <tr>
		<th class="label">Data de Competência</th>
     <td>
	               	<input type="text" name="dtComp" size="15" value="<%=dtComp%>" onblur="chkData(this,'dd/MM/yyyy')" maxlength="10" class="inputs">
		               	<a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dtComp);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
            		</td>
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