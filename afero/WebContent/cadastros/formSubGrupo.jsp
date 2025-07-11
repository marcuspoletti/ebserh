<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.SubGrupo"%>
<%@page import="afero.util.ConverteDate"%>
<%@page import="afero.persistence.SubGrupoDAO"%>
<%@page import ="java.util.*" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/>"></script>

<script>
function salvar() {
    if (document.all.idGrupo.value == 0) {
    window.alert("O campo Grupo é obrigatório.");
    document.all.idGrupo.focus();
    }else if (document.all.dsSubGrupo.value == '') {
    window.alert("O campo Descrição do Subgrupo é obrigatório.");
    document.all.dsSubGrupo.focus();
   }else {
  	document.forms[0].submit();
  }
}

function cancelar() {
  document.forms[0].action="formSubGrupo.jsp";
  document.forms[0].submit();
}

function voltar() {
  document.forms[0].action = 'listarSubGrupo.jsp?acao=voltar'
	document.forms[0].submit();
}  
</script>
</head>
<%
//variáveis capturadas da página listarTipoEntidae.jsp
String acao = request.getParameter("acao");
String idSubGrupo = request.getParameter("idSubGrupo");
ConverteDate converte = new ConverteDate();

if (acao == null) acao = "inc";
if(idSubGrupo == null) idSubGrupo = "";
int idGrupo = 0;
String dsSubGrupo = "";
String dtCad = "";
String dtMod = "";
String status = "A";
String usuario = (String)session.getAttribute("Login");


//verifica se acao foi atualizar
if (acao.equalsIgnoreCase("atu")){
	    SubGrupoDAO dao = new SubGrupoDAO(conn);
	    SubGrupo subGrupo = dao.procurarSubGrupo(Integer.parseInt(idSubGrupo));
		idGrupo = subGrupo.getIdGrupo();
		dtMod = subGrupo.getDtMod().toString();
		dtCad = subGrupo.getDtCad().toString();
		status = subGrupo.getStatus();
		dsSubGrupo =subGrupo.getDsSubGrupo();
		
		
}
%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Subgrupo</h1>
<form method="post" action="listarSubGrupo.jsp?acao=<%=acao%>&idSubGrupo=<%=idSubGrupo%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="idSubGrupo" value="<%=idSubGrupo%>"/>
<input type="hidden" name="usuario" value="<%=usuario%>"/>

<table border="0" width="100%">
  <tr>
      <th class="label">Grupo*</th>
      <td><select name="idGrupo" style="width: 172px">
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboGrupo.jspf"  %></select>
          <script>comboSelect(document.forms[0].idGrupo, '<%= idGrupo %>');</script>
      </td>
  </tr>
  <tr>
    <th class="label">Descrição SubGrupo*</th>
    <td><input type="text" id="dsSubGrupo" name="dsSubGrupo" <%if (dsSubGrupo != null) { %>value="<%=dsSubGrupo%>"<% }%>  size="60" maxlength="60"></td>
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