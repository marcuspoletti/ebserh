<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.EntidadeFisica"%>
<%@page import="afero.util.ConverteDate"%>
<%@page import="afero.persistence.EntidadeFisicaDAO"%>
<%@page import="java.util.Date"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/>"></script>
<script language="javascript">
function salvar(acao) {
  	document.forms[0].submit();
}
// chkData(this,'dd/MM/yyyy')
function chkData(obj, mask, msg) {
   if (!obj || obj.value=="") return;
   if (!mask || mask== "") mask = "dd/MM/yyyy"; 
   var st = cData(obj.value, mask);
   if (!msg) msg = "";
   if (st == -1) return msgErr(obj, msg + " Deve conter 6 ou 8 números");
   if (st == -2) return msgErr(obj, msg + " Mês inválido");
   if (st == -3) return msgErr(obj, msg + " Dia inválido");
   obj.value =  st;
}
function voltar() {
  document.forms[0].action = 'listarEntidadeFisica.jsp?acao=voltar'
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
//variáveis capturadas da página listarTiposAtendimento.jsp
String acao = request.getParameter("acao");
String idEntidade = request.getParameter("idEntidade");
ConverteDate converte = new ConverteDate();


if (acao == null) acao = "inc";
if (idEntidade == null) idEntidade = "0";
String cpf = "";
String dtNascimento ="";
String dtCasamento = "";
String Cargo = "";
String departamento =""; 
String empresa = "";
String sexo = "M";
int cdEstadoCivil = 0;
int cdEscolaridade = 0;
String cpfConjuge = "";
String conjuge = "";
String mae = "";
String pai = "";
String nroRg = "";
String orgRg = "";
String ufRg = "";


//verifica se acao foi atualizar
if (acao.equalsIgnoreCase("atu")) {
  EntidadeFisicaDAO dao = new EntidadeFisicaDAO(conn);
  EntidadeFisica entidadeFisica = dao.procurarEntidadeFisica(Integer.parseInt(idEntidade));
  cpf = entidadeFisica.getCpf();
  dtNascimento = entidadeFisica.getDtNascimento().toString();
  dtCasamento = entidadeFisica.getDtCasamento().toString();
  Cargo = entidadeFisica.getCargo();
  departamento = entidadeFisica.getDepartamento(); 
  empresa = entidadeFisica.getEmpresa();
  sexo = entidadeFisica.getSexo(); 
  cdEstadoCivil = entidadeFisica.getCdEstadoCivil();
  cdEscolaridade = entidadeFisica.getCdEscolaridade();
  cpfConjuge = entidadeFisica.getCpfConjuge();
  conjuge = entidadeFisica.getConjuge();
  mae = entidadeFisica.getMae();
  pai = entidadeFisica.getPai();
  nroRg = entidadeFisica.getNroRg();
  orgRg = entidadeFisica.getOrgRg();
  ufRg = entidadeFisica.getUfRg();
}
%>
<body onload="document.forms[0].elements[0].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Entidade Fisica</h1>
<form method="post" action="listarEntidadeFisica.jsp?acao=<%=acao%>&idEntidade=<%=idEntidade%>">

<table border="0" width="100%">
  <tr>
    <th class="label">Nome da Entidade*</th>
     <td><select name="idEntidade" style="width: 172px">
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboEntidade.jspf" %></select>
          <script>comboSelect(document.forms[0].idEntidade, '<%= idEntidade %>');</script>
      </td>
  </tr>
  <tr>
      <th class="label">Cpf*</th>
     <td><input type="text" name="cpf" value="<%=cpf%>"  size="40" maxlength="40" onblur="chkCPFCNPJ(this)"></td>
  </tr>
  <tr>
    <th class="label">Data de Nascimento*</th>
    <td><input type="text" name="dtNascimento" value="<%=dtNascimento%>"  size="40" maxlength="40" onblur="chkData(this,'dd/MM/yyyy')"></td>
  </tr>
  <tr>
   	 <th class="label">Data de Casamento</th>
  	  <td><input type="text"  name="dtCasamento" value="<%=dtCasamento%>"  size="40" maxlength="40" onblur="chkData(this,'dd/MM/yyyy')"></td>
 </tr>
 <tr>
  	  <th class="label">Cargo</th>
  	  <td><input  type="text" name="Cargo" <%if (Cargo != null) { %>value="<%=Cargo%>"<% }%>  size="40" maxlength="40" ></td>
 </tr>
 <tr>
    	<th class="label">Departamento</th>
  	    <td><input type="text" name="departamento" <%if (departamento != null) { %>value="<%=departamento%>"<% }%>  size="40" maxlength="40"></td>
 </tr>
  <tr>
    	<th class="label">Empresa</th>
  	    <td><input type="text" name="empresa" <%if (empresa != null) { %>value="<%=empresa%>"<% }%>  size="40" maxlength="40"></td>
  </tr>
   <tr>
    <th class="label">Estado Civil*</th>
     <td><select name="cdEstadoCivil" style="width: 172px">
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboEstadoCivil.jspf" %></select>
          <script>comboSelect(document.forms[0].cdEstadoCivil, '<%= cdEstadoCivil %>');</script>
      </td>
  </tr>
     <tr>
    <th class="label">Escolaridade*</th>
     <td><select name="cdEscolaridade" style="width: 172px">
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboEscolaridade.jspf" %></select>
          <script>comboSelect(document.forms[0].cdEscolaridade, '<%= cdEscolaridade%>');</script>
      </td>
  </tr>
   <tr>
    	<th class="label">Cpf Conjugue</th>
  	    <td><input type="text" name="empresa" <%if (cpfConjuge != null) { %>value="<%=cpfConjuge%>"<% }%>  size="40" maxlength="40" onblur="chkCPFCNPJ(this)"></td>
  </tr>
   <tr>
    	<th class="label">Conjugue</th>
  	    <td><input type="text" name="conjuge" <%if (conjuge != null) { %>value="<%=conjuge%>"<% }%>  size="40" maxlength="40"></td>
  </tr>
   <tr>
    	<th class="label">Mãe</th>
  	    <td><input type="text" name="mae" <%if (mae != null) { %>value="<%=mae%>"<% }%>  size="40" maxlength="40"></td>
  </tr>
   <tr>
    	<th class="label">Pai</th>
  	    <td><input type="text" name="pai" <%if (pai != null) { %>value="<%=pai%>"<% }%>  size="40" maxlength="40"></td>
  </tr>
   <tr>
    	<th class="label">Número Rg</th>
  	    <td><input type="text" name="nroRg" <%if (nroRg != null) { %>value="<%=nroRg%>"<% }%>  size="40" maxlength="40"></td>
  </tr>
   <tr>
    	<th class="label">Origem do Rg</th>
  	    <td><input type="text" name="orgRg" <%if (orgRg != null) { %>value="<%=orgRg%>"<% }%>  size="40" maxlength="40"></td>
  </tr>
  <tr>
    	<th class="label">Uf do Rg</th>
  	    <td><input type="text" name="ufRg" <%if (ufRg != null) { %>value="<%=ufRg%>"<% }%>  size="40" maxlength="40"></td>
  </tr>
  <tr>
    <th class="label">Sexo</th>
      <td class="label_radio"><input type="radio" class="radio" name="sexo" value="M" <%=(sexo.equals("M")? "checked": "") %>>Masculino
      <input type="radio" class="radio" name="sexo" value="F" <%=(sexo.equals("F")? "checked": "") %>>Feminino</td>
    
  </tr>
</table><hr>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
	<td><input class="button" type="button" value="Salvar" onClick="javascript: salvar();" />
	<input class="button" type="reset" value="Cancelar" />
	<input class="button" type="button" value="Voltar" onClick="javascript: voltar();" /></td>
	<td class="label">* Campos Obrigatórios</td>
</tr>
</table>
</form>
<%@include file="../fimConexao.jsp"%>

</body>
</html>