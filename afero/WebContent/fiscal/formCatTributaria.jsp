<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.CatTributaria"%>
<%@page import="afero.persistence.CatTributariaDAO"%>
<%@page import="afero.util.ConverteDate"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js" /></script>
<script>
function salvar() {
   document.forms[0].submit();
}

function cancelar() {
  document.forms[0].action="formCatTributaria.jsp";
  document.forms[0].submit();
}

function voltar() {
  document.forms[0].action = 'listarCatTributaria.jsp?acao=voltar'
	document.forms[0].submit();
}
function SomenteNumero(e){
    var tecla=(window.event)?event.keyCode:e.which;
    if((tecla > 47 && tecla < 58)) return true;
    else{
    if (tecla != 8) return false;
    else return true;
    }
}
</script>
</head>
<%
//variáveis capturadas da página listarCidade.jsp
ConverteDate converte = new ConverteDate();
String acao = request.getParameter("acao");
String idCatTributaria = request.getParameter("idCatTributaria");
if (acao == null) acao = "inc";
if (idCatTributaria == null)idCatTributaria= "0";
String dsCatTributaria = "";
int cdCstIpi = 0;
float pIpi = 0;
String classeEnquadramento = "";
String codigoEnquadramento = "0";
String cnpjProdutor = "";
int cdCstPis = 0;
float pPis = 0;
int cdCstCofins = 0;
float pCofins = 0;
String status = "A";
String dtMod = "";
String usuario = (String)session.getAttribute("Login");

//verifica se acao foi atualizar
if (acao.equalsIgnoreCase("atu")) {
  CatTributariaDAO dao = new CatTributariaDAO(conn);
  CatTributaria catTributaria = dao.procurarCatTributaria(Integer.parseInt(idCatTributaria));
  dsCatTributaria  = catTributaria.getDsCatTributaria();
  cdCstIpi = catTributaria.getCdCstIpi();
  pIpi = catTributaria.getpIpi();
  classeEnquadramento = catTributaria.getClasseEnquadramento();
  codigoEnquadramento = catTributaria.getCodigoEnquadramento();
  cnpjProdutor = catTributaria.getCnpjProdutor();
  cdCstPis = catTributaria.getCdCstPis();
  pPis = catTributaria.getpPis();
  cdCstCofins = catTributaria.getCdCstCofins();
  pCofins = catTributaria.getpCofins();
  status = catTributaria.getStatus();
  dtMod = catTributaria.getDtMod().toString();
  usuario = catTributaria.getUsuario();
}
%>
<body onload="document.forms[0].elements[0].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Tributário</h1>
<form method="post" action="listarCatTributaria.jsp?acao=<%=acao%>">


<table border="0" width="100%">
  <tr>
    <th class="label">Desc. do Cat. Trib*</th>
    <td><input type="text" name="dsCatTributaria" <%if (dsCatTributaria != null) { %>value="<%=dsCatTributaria%>"<% }%>  size="40" maxlength="500"></td>
  </tr>
  <tr>
      <th class="label">Cst IPI*</th>
      <td><select name="cdCstIpi" onchange="recarregar('<%=acao%>');">
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboCstIpi.jspf"%></select>
          <script>comboSelect(document.forms[0].cdCstIpi, '<%= cdCstIpi %>');</script>
      </td>
  </tr>  
  <tr>
    <th class="label">Perc. IPI (%)</th>
    <td><input type="text" name="pIpi" value="<%=pIpi%>" onkeyup="FormataValor(this,event)" size="40" maxlength="100"></td>
  </tr>
    <tr>
    <th class="label">Classe Enquad.</th>
    <td><input type="text" name="classeEnquadramento" <%if (classeEnquadramento != null) { %>value="<%=classeEnquadramento%>"<% }%> size="40" maxlength="100"></td>
  </tr>
   <tr>
    <th class="label">Cod. Enquad.</th>
    <td><input type="text" name="codigoEnquadramento" <%if (codigoEnquadramento != null) { %>value="<%=codigoEnquadramento%>"<% }%> size="40" maxlength="100"></td>
  </tr>
  <tr>
    <th class="label">CNPJ Prod.*</th>
    <td><input type="text" id="cnpjProdutor" name="cnpjProdutor" <%if (cnpjProdutor != null) { %>value="<%=cnpjProdutor%>"<% }%>  size="20" maxlength="14" onblur="chkCPFCNPJ(this)"></td>
  </tr>
  <tr>
      <th class="label">Cst PIS*</th>
      <td><select name="cdCstPis" >
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboCstPis.jspf"%></select>
          <script>comboSelect(document.forms[0].cdCstPis, '<%= cdCstPis %>');</script>
      </td>
  </tr>
  <tr>
    <th class="label">Perc. PIS (%)</th>
    <td><input type="text" name="pPis" value="<%=pPis%>" onkeyup="FormataValor(this,event)" size="40" maxlength="100"></td>
  </tr>
  <tr>
      <th class="label">Cst Cofins*</th>
      <td><select name="cdCstCofins" >
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboCstCofins.jspf"%></select>
          <script>comboSelect(document.forms[0].cdCstCofins, '<%= cdCstCofins %>');</script>
      </td>
  </tr>
  <tr>
    <th class="label">Perc. Cofins (%)</th>
    <td><input type="text" name="pCofins" value="<%=pCofins%>" onkeyup="FormataValor(this,event)" size="40" maxlength="100"></td>
  </tr> 
  <tr>
    <th class="label">Ativo</th>
      <td class="label_radio"><input type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Sim
      <input type="radio" class="radio" name="status" value="I" <%= (status.equals("I")? "checked": "") %>>Não</td>    
  </tr> 
</table><hr>
<table border="0" width="100%">
  <%if(acao.equals("atu")){%>
  
  	<tr>
  	    <th class="label">Registros:</th>
  	    <td class="label_menor"><center>&nbsp Modificação: <%if (dtMod != null) { %><%=converte.DMYToYMD(dtMod)%><% }%>&nbsp</center></td>
	</tr>

  <% }%>
</table>
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