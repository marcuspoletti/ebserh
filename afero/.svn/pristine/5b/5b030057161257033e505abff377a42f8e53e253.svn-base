<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.Grupo"%>
<%@page import="afero.persistence.GrupoDAO"%>
<%@page import="afero.util.ConverteDate"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script>
function salvar() {
  if (document.all.dsGrupo.value == '') {
    window.alert("O campo Descrição do Grupo é obrigatório.");
    document.all.dsGrupo.focus();
   } else {
  	document.forms[0].submit();
  }
}

function cancelar() {
  document.forms[0].action="formGrupo.jsp";
  document.forms[0].submit();
}

function voltar() {
  document.forms[0].action = 'listarGrupo.jsp?acao=voltar'
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
String idGrupo = request.getParameter("idGrupo");
ConverteDate converte = new ConverteDate();
if (acao == null) acao = "inc";
if (idGrupo == null) idGrupo = "";
String dsGrupo = "";
String status ="A";
String dtCad = "";
String dtMod = "";
String usuario = (String)session.getAttribute("Login");

//verifica se acao foi atualizar
if (acao.equalsIgnoreCase("atu")) {
  GrupoDAO dao = new GrupoDAO(conn);
  Grupo grupo = dao.procurarGrupo(Integer.parseInt(idGrupo));
  dsGrupo  = grupo.getDsGrupo();
  status = grupo.getStatus(); 
  dtMod = grupo.getDtMod().toString();
  dtCad = grupo.getDtCad().toString();
}
%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Grupo</h1>
<form method="post" action="listarGrupo.jsp?acao=<%=acao%>&idGrupo=<%=idGrupo%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="idGrupo" value="<%=idGrupo%>"/>
<input type="hidden" name="usuario" value="<%=usuario%>"/>

<table border="0" width="100%">
  <tr>
    <th class="label">Descricao*</th>
    <td><input type="text" name="dsGrupo" <%if (dsGrupo != null) { %>value="<%=dsGrupo%>"<% }%>  size="40" maxlength="40"></td>
  </tr>
  <tr>
    <th class="label">Ativo</th>
      <td class="label_radio"><input type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Sim
      <input type="radio" class="radio" name="status" value="I" <%= (status.equals("I")? "checked": "") %>>Não</td>
  </tr>
   <%if(acao.equals("atu")){%>
  
  	<tr>
   	 	<td class="label_menor"><center>&nbsp Registro: <%if (dtCad != null) { %><%=converte.DMYToYMD(dtCad)%><% }%>&nbsp</center></td>
  	    <td class="label_menor"><center>&nbsp Modificação: <%if (dtMod != null) { %><%=converte.DMYToYMD(dtMod)%><% }%>&nbsp</center></td>
	</tr>

  <% }%>
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