<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.EntidadeDependente" %>
<%@ page import="afero.persistence.EntidadeDependenteDAO" %>
<%@page import="afero.util.ConverteDate"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script src="../js/common.js" /></script>
<script>
function salvar() {
  if (document.all.nmDependente.value == '') {
    window.alert("O campo Dependente é obrigatório.");
    document.all.nmDependente.focus();
   } else {
  	document.forms[0].submit();
  }
}

function cancelar() {
  document.forms[0].action="formEntidadeDependente.jsp";
  document.forms[0].submit();
}

function voltar(cdEntidade) {
  document.forms[0].action = 'listarEntidadeDependente.jsp?acao=voltar&cdEntidade='+cdEntidade;
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
//variáveis capturadas da página listarEntidadeDependente.jsp
String acao = request.getParameter("acao");
String cdEntidade = request.getParameter("cdEntidade");
String idEntidadeDependente = request.getParameter("idEntidadeDependente");
String selectAba = request.getParameter("selectAba");
String acaoAnterior = request.getParameter("acaoAnterior");
if (acao == null) acao = "inc";
if (cdEntidade == null) cdEntidade = "";
if (idEntidadeDependente == null) idEntidadeDependente = "";
if (selectAba == null) selectAba = "5";
if (acaoAnterior == null) acaoAnterior = "atu";

int idTipoDependente = 0;
String nmDependente = "";
String dtNascimento = "";
String sexo = "M";
String status ="A";

String mensagem = request.getParameter("mensagem");

//verifica se acao foi atualizar
if (acao.equalsIgnoreCase("atu")) {
  EntidadeDependenteDAO dao = new EntidadeDependenteDAO(conn);
  EntidadeDependente entidadeDependente = dao.procurarEntidadeDependente(Integer.parseInt(idEntidadeDependente));
  cdEntidade = String.valueOf(entidadeDependente.getCdEntidade());
  idTipoDependente = entidadeDependente.getIdTipoDependente();
  nmDependente  = entidadeDependente.getNmDependente();
  sexo = entidadeDependente.getSexo();
  dtNascimento = ConverteDate.dateToStr(entidadeDependente.getDtNascimento(),"dd/MM/yyyy");
  if (dtNascimento == null) dtNascimento = "";
  status = entidadeDependente.getStatus();
}
%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Dependente - Entidade</h1>
<hr><% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<form method="post" action="listarEntidadeDependente.jsp?cdEntidade=<%=cdEntidade%>&acao=<%=acao%>&idEntidadeDependente=<%=idEntidadeDependente%>&acaoAnterior=<%=acaoAnterior%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="cdEntidade" value="<%=cdEntidade%>"/>
<input type="hidden" name="idEntidadeDependente" value="<%=idEntidadeDependente%>"/>
<input type="hidden" name="selectAba" value="<%=selectAba%>"/>
<input type="hidden" name="acaoAnterior" value="<%=acaoAnterior%>"/>

<table border="0" width="100%">
  <tr>
    <th class="label">Tipo Dependente</th>
    <td><select name="idTipoDependente" style="width: 172px">
        <option value='1'>Selecione...</option>
        <%@include file="../WEB-INF/jspf/combo/comboTipoDependente.jspf" %></select>
        <script>comboSelect(document.forms[0].idTipoDependente, '<%= idTipoDependente %>');</script>
    </td>
  </tr>
  <tr>
    <th class="label">Dependente*</th>
    <td><input type="text" id="nmDependente" name="nmDependente" <%if (nmDependente != null) { %>value="<%=nmDependente%>"<% }%>  size="60" maxlength="60"></td>
  </tr>
 	<tr>
		<th class="label">Data de nascimento</th>
      		<td>
          	<input type="text" name="dtNascimento" size="15" value="<%= dtNascimento %>" onblur="chkData(this,'dd/MM/yyyy')" maxlength="10" class="inputs">
           	<a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dtNascimento);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
      		</td>
	</tr>
  <tr>
	<th class="label">Sexo</th>
	<td class="label_radio">
	  <input type="radio" class="radio" name="sexo" value="M" <%=(sexo.equals("M")? "checked": "") %>>Masculino 
		<input type="radio" class="radio" name="sexo" value="F"	<%=(sexo.equals("F")? "checked": "") %>>Feminino</td>
  </tr>
	<tr>
		<th class="label">Ativo</th>
		<td class="label_radio">
		  <input type="radio" class="radio" name="status" value="A" <%=(status.equals("A")? "checked": "") %>>Sim 
			<input type="radio" class="radio" name="status" value="I"	<%=(status.equals("I")? "checked": "") %>>Não</td>
	</tr>
</table><hr>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
	<td><input class="button" type="button" value="Salvar" onClick="javascript: salvar();" />
	<input class="button" type="button" value="Cancelar" onClick="javascript: cancelar();" />
	<input class="button" type="button" value="Voltar" onClick="javascript:history.go(-1);" /></td>
	<td class="campo_obrigatorio">* Campos Obrigatórios</td>
</tr>
</table>
</form>
<%@include file="../fimConexao.jsp"%>

</body>
</html>