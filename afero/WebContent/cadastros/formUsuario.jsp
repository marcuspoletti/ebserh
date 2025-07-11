<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.Usuario"%>
<%@page import="afero.util.ConverteDate"%>
<%@page import="afero.persistence.UsuarioDAO"%>
<%@page import ="java.util.*" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/></script>

<script>
function salvar() {
   if (document.all.idGrupoUsuario.value == '0') {
    window.alert("O campo Grupo é obrigatório.");
    document.all.idGrupoUsuario.focus();
  } else if (document.all.login.value == '') {
    window.alert("O campo Login é obrigatório.");
    document.all.login.focus();
  } else if (document.all.senha.value == '') {
    window.alert("O campo Senha é obrigatório.");
    document.all.senha.focus();
   } else if (document.all.senha.value != document.all.confSenha.value) {
    window.alert("O campo Senha e Confirmar Senha de ser igual.");
    document.all.senha.focus();
  } else {
  	document.forms[0].submit();
  }
}

function cancelar() {
  document.forms[0].action="formUsuario.jsp";
  document.forms[0].submit();
}

function voltar() {
  document.forms[0].action = 'listarUsuario.jsp?acao=voltar'
	document.forms[0].submit();
}  
</script>
</head>
<%

String acao = request.getParameter("acao");
String idUsuario = request.getParameter("idUsuario");
ConverteDate converte = new ConverteDate();

if (acao == null) acao = "inc";
if(idUsuario == null) idUsuario = "";
int idGrupoUsuario = 0;
String email = "";
String login = "";
String senha = "";
String confSenha = "";
String status = "A";
String dtCad = "";
String dtMod = "";


//verifica se acao foi atualizar
if (acao.equalsIgnoreCase("atu")){
  UsuarioDAO dao = new UsuarioDAO(conn);
	Usuario usuario = dao.procurarUsuario(Integer.parseInt(idUsuario));
	idGrupoUsuario = usuario.getIdGrupoUsuario();
	email = usuario.getEmail();
	dtMod = usuario.getDtMod().toString();
	dtCad = usuario.getDtCad().toString();
	status = usuario.getStatus();
	//senha = usuario.getSenha();
	login = usuario.getLogin();
	//confSenha = senha;
				
}
%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Usuário</h1>
<form method="post" action="listarUsuario.jsp?acao=<%=acao%>&idUsuario=<%=idUsuario%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="idUsuario" value="<%=idUsuario%>"/>

<table border="0" width="100%">
  <tr>
      <th class="label">Grupo de Usuário</th>
      <td><select name="idGrupoUsuario" style="width: 172px">
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboGrupoUsuario.jspf"%></select>
          <script>comboSelect(document.forms[0].idGrupoUsuario, '<%=idGrupoUsuario%>');</script>
      </td>
  </tr>
  <tr>
    <th class="label">E-Mail</th>
    <td><input type="text" id="email" name="email" <%if (email!= null) { %>value="<%=email%>"<% }%>  size="60" maxlength="100" ></td>
  </tr>
  <tr>
    <th class="label">Login*</th>
    <td><input type="text" id="login" name="login" <%if (login != null) { %>value="<%=login%>"<% }%>  size="60" maxlength="60"></td>
  </tr>
  <tr>
    <th class="label">Senha*</th>
    <td><input type="password" id="senha" name="senha" <%if (senha != null) { %>value="<%=senha%>"<% }%>  size="60" maxlength="60"></td>
  </tr>
  <tr>
    <th class="label">Confirmar Senha*</th>
    <td><input type="password" id="confSenha" name="confSenha" <%if (confSenha != null) { %>value="<%=confSenha%>"<% }%>  size="60" maxlength="60"></td>
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