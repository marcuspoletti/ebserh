<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.GrupoUsuario"%>
<%@page import="afero.util.ConverteDate"%>
<%@page import="afero.persistence.GrupoUsuarioDAO"%>
<%@page import ="java.util.*" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/>"></script>

<script>
function salvar() {
  if (document.all.dsGrupoUsuario.value == '') {
    window.alert("O campo Grupo de Usuaário é obrigatório.");
    document.all.slogin.focus();
   } else {
  	document.forms[0].submit();
  }
}

function cancelar() {
  document.forms[0].action="formGrupoUsuario.jsp";
  document.forms[0].submit();
}

function voltar() {
  document.forms[0].action = 'listarGrupoUsuariojsp?acao=voltar'
	document.forms[0].submit();
}  
</script>
</head>
<%
//variáveis capturadas da página listarTipoEntidae.jsp
String acao = request.getParameter("acao");
String idGrupoUsuario = request.getParameter("idGrupoUsuario");
ConverteDate converte = new ConverteDate();

if (acao == null) acao = "inc";
if(idGrupoUsuario == null) idGrupoUsuario = "";
String dsGrupoUsuario = "";
String status = "A";


//verifica se acao foi atualizar
if (acao.equalsIgnoreCase("atu")){
	    GrupoUsuarioDAO dao = new GrupoUsuarioDAO(conn);
	    GrupoUsuario grupoUsuario = dao.procurarGrupoUsuario(Integer.parseInt(idGrupoUsuario));
	    dsGrupoUsuario = grupoUsuario.getDsGrupoUsuario();
	    status = grupoUsuario.getStatus();
		
		
}
%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Grupo Usuário</h1>
<form method="post" action="listarGrupoUsuario.jsp?acao=<%=acao%>&idGrupoUsuario=<%=idGrupoUsuario%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="idGrupoUsuario" value="<%=idGrupoUsuario%>"/>

<table border="0" width="100%">
  <tr>
    <th class="label">Grupo de Usuário*</th>
    <td><input type="text" id="dsGrupoUsuario" name="dsGrupoUsuario" <%if (dsGrupoUsuario != null) { %>value="<%=dsGrupoUsuario%>"<% }%>  size="60" maxlength="60"></td>
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