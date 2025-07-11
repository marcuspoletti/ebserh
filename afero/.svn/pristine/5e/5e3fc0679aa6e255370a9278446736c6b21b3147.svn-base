<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.Colaborador"%>
<%@page import="afero.model.Usuario"%>
<%@page import="afero.persistence.UsuarioDAO"%>
<%@page import="afero.util.ConverteDate"%>
<%@page import="afero.persistence.ColaboradorDAO"%>
<%@page import ="java.util.*" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css"/>
<script src="../js/common.js"/></script>

<script>
function salvar() {
  if (document.all.apelido.value == '') {
    window.alert("O campo Apelido é obrigatório.");
    document.all.apelido.focus();
   } else if (document.all.nome.value == '') {
    window.alert("O campo Nome é obrigatório.");
    document.all.nome.focus();
   } else if (document.all.idLoja.value == '0') {
	    window.alert("O campo Loja é obrigatório.");
	    document.all.idLoja.focus();
   } else if (document.all.idTipoColaborador.value == '0') {
	    window.alert("O campo Tipo Colaborador é obrigatório.");
	    document.all.idTipoColaborador.focus();
   } else if (document.all.cpf.value == '') {
    	    window.alert("O campo CPF é obrigatório.");
    	    document.all.cpf.focus();
   } else if (document.all.ufRg.value == '') {
	    window.alert("O campo UF RG é obrigatório.");
	    document.all.ufRg.focus();
   } else if (document.all.estado.value == '') {
	    window.alert("O campo Estado é obrigatório.");
	    document.all.estado.focus();
   } else if (document.all.email.value == '') {
    window.alert("O campo E-mail é obrigatório.");
    document.all.email.focus();
   } else if (document.all.login.value == '') {
    window.alert("O campo Login é obrigatório.");
    document.all.login.focus();
   } else if (document.all.senha.value == '') {
    window.alert("O campo Senha é obrigatório.");
    document.all.senha.focus();
   } else if (document.all.senha.value != document.all.confSenha.value) {
    window.alert("O campo Senha e Confirmar Senha de ser igual.");
    document.all.confSenha.focus();
   } else if (document.all.idGrupoUsuario.value == '0') {
	    window.alert("O campo Grupo é obrigatório.");
	    document.all.idGrupoUsuario.focus();
   } else {
  	document.forms[0].submit();
  }
}

function cancelar() {
  document.forms[0].action="formColaborador.jsp";
  document.forms[0].submit();
}

function voltar() {
  document.forms[0].action = 'listarColaborador.jsp?acao=voltar'
	document.forms[0].submit();
}  
</script>
</head>
<%
String acao = request.getParameter("acao");
String idColaborador = request.getParameter("idColaborador");
ConverteDate converte = new ConverteDate();

if (acao == null) acao = "inc";
if(idColaborador == null) idColaborador = "";
int idLoja = 0;
int idTipoColaborador = 0;
int idUsuario = 0;
int idGrupoUsuario = 2;
String nome = "";
String apelido = "";
String cpf = "";
String nroRg = "";
String endereco = "";
String bairro = "";
String cep = "";
String cidade = "";
String estado = "";
String cmpEndereco = "";
String status = "A";
String orgRg = "";
String ufRg = "";
String telefone = "";
String celular = "";
String email = "";
String login = "";
String senha = "";
String confSenha = "";
String mensagem = request.getParameter("mensagem");
String user = (String)session.getAttribute("Login");
String dtMod = "";
String dtCad = "";

//verifica se acao foi atualizar
if (acao.equalsIgnoreCase("atu")){
  ColaboradorDAO dao = new ColaboradorDAO(conn);
	Colaborador colaborador = dao.procurarColaborador(Integer.parseInt(idColaborador));
	idLoja = colaborador.getIdLoja();
	idTipoColaborador = colaborador.getIdTipoColaborador();
	idUsuario = colaborador.getIdUsuario();
	nome = colaborador.getNome();
	apelido = colaborador.getApelido();
	cpf = colaborador.getCpf();
	nroRg = colaborador.getNroRg();
	endereco = colaborador.getEndereco();
	bairro = colaborador.getBairro();
	cep = colaborador.getCep();
	cidade = colaborador.getCidade();
	estado = colaborador.getEstado();
	cmpEndereco = colaborador.getCmpEndereco();
	orgRg = colaborador.getOrgRg();
	ufRg = colaborador.getUfRg();
	telefone = colaborador.getTelefone();
	celular = colaborador.getCelular();
	email = colaborador.getEmail();
	UsuarioDAO usuarioDAO = new UsuarioDAO(conn);
	Usuario usuario = usuarioDAO.procurarUsuario(idUsuario);
	login = usuario.getLogin();
	senha = usuario.getSenha();
	idGrupoUsuario = usuario.getIdGrupoUsuario();
	status =  colaborador.getStatus();
	confSenha = senha;
	dtMod = colaborador.getDtMod().toString();
	dtCad = colaborador.getDtCad().toString();
		
}
UsuarioDAO daoUsuario = new UsuarioDAO(conn);
%>
<body onload="document.forms[0].elements[2].focus();">
<h1 class="cabecalho_pagina">Cadastro de Colaborador</h1>
<hr><% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<form method="post" action="listarColaborador.jsp?idColaborador=<%=idColaborador%>">
<input type="hidden" name="idColaborador" value="<%=idColaborador%>"/>
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="idUsuario" value="<%=idUsuario%>"/>
<input type="hidden" name="user" value="<%=user%>"/>
<%
if (acao.equalsIgnoreCase("atu")){ %>
  <input type="hidden" name="login" value="<%=login%>"/>
<% } %>

<table border="0" width="100%">
  <tr>
    <th class="label">Apelido*</th>
    <td><input type="text" id="apelido" name="apelido" <%if (apelido != null) { %>value="<%=apelido%>"<% }%>  size="40" maxlength="25"></td>
  </tr>
  <tr>
    <th class="label">Nome*</th>
    <td><input type="text" id="nome" name="nome" <%if (nome != null) { %>value="<%=nome%>"<% }%>  size="60" maxlength="60"></td>
  </tr>
   <tr>
      <th class="label">Loja*</th>
      <td><select name="idLoja">
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboLoja.jspf" %></select>
          <script>comboSelect(document.forms[0].idLoja, '<%= idLoja %>');</script>
      </td>
  </tr>
     <tr>
      <th class="label">Tipo Colaborador*</th>
      <td><select name="idTipoColaborador">
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboTipoColaborador.jspf" %></select>
          <script>comboSelect(document.forms[0].idTipoColaborador, '<%= idTipoColaborador %>');</script>
      </td>
  </tr>
   <tr>
    <th class="label">CPF*</th>
    <td><input type="text" id="cpf" name="cpf" <%if (cpf != null) { %>value="<%=cpf%>"<% }%>  size="20" maxlength="14" onblur="chkCPFCNPJ(this)"></td>
  </tr>
   <tr>
    <th class="label">RG</th>
    <td><input type="text" id="nroRg" name="nroRg" <%if (nroRg!= null) { %>value="<%=nroRg%>"<% }%>  size="20" maxlength="15" ></td>
    <th class="label">Org. RG</th>
    <td><input type="text" id="orgRg" name="orgRg" <%if (orgRg!= null) { %>value="<%=orgRg%>"<% }%>  size="20" maxlength="20" ></td>
    <th class="label">Uf RG*</th>
      <td><select name="ufRg" >
          <option value=''>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboUf.jspf" %></select>
          <script>comboSelect(document.forms[0].ufRg, '<%= ufRg %>');</script>
      </td>
  </tr>
  <tr>
    <th class="label">Endereço</th>
    <td><input type="text" id="endereco" name="endereco" <%if (endereco!= null) { %>value="<%=endereco %>"<% }%>  size="40" maxlength="40" ></td>
  </tr>
  <tr>
    <th class="label">Complemento</th>
    <td><input type="text" id="cmpEndereco" name="cmpEndereco" <%if (cmpEndereco!= null) { %>value="<%=cmpEndereco%>"<% }%>  size="40" maxlength="20" ></td>
  </tr>
  <tr>
    <th class="label">Bairro</th>
    <td><input type="text" id="bairro" name="bairro" <%if (bairro!= null) { %>value="<%=bairro%>"<% }%>  size="40" maxlength="40" ></td>
    <th class="label">Cep</th>
    <td><input type="text" id="cep" name="cep" <%if (cep!= null) { %>value="<%=cep%>"<% }%>  size="20" maxlength="10" ></td>
  </tr>
   <tr>
    <th class="label">Cidade</th>
    <td><input type="text" id="cidade" name="cidade" <%if (cidade!= null) { %>value="<%=cidade%>"<% }%>  size="40" maxlength="40" ></td>
    <th class="label">Estado*</th>
    <td><select name="estado" >
          <option value=''>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboUf_2.jspf" %></select>
          <script>comboSelect(document.forms[0].estado, '<%= estado %>');</script>
   </td>
  </tr>
  <tr>
    <th class="label">Telefone</th>
    <td><input type="text" id="telefone" name="telefone" <%if (telefone!= null) { %>value="<%=telefone%>"<% }%>  size="20" maxlength="15" ></td>
    <th class="label">Celular</th>
    <td><input type="text" id="celular" name="celular" <%if (celular!= null) { %>value="<%=celular%>"<% }%>  size="20" maxlength="15" ></td>
  </tr>
  <tr>
    <th class="label">E-Mail*</th>
    <td><input type="text" id="email" name="email" <%if (email!= null) { %>value="<%=email%>"<% }%>  size="60" maxlength="100" ></td>
  </tr>
  
  <%if(acao.equalsIgnoreCase("inc")) { %>
  	 <tr>
  		  <th class="label">Login*</th>
  		  <td><input type="text" id="login" name="login" <%if (login != null) { %>value="<%=login%>"<% }%>  size="20" maxlength="20"></td>
 	 </tr>
  <%} else { %>
    <tr>
   		 <th class="label">Login*</th>
   		 <td><input disabled type="text" id="login" name="login" <%if (login != null) { %>value="<%=login%>"<% }%>  size="20" maxlength="20"></td>
  	</tr>
  <%} %>
  <tr>
    <th class="label">Senha*</th>
    <td><input type="password" id="senha" name="senha" <%if (senha != null) { %>value="<%=senha%>"<% }%>  size="20" maxlength="20"></td>
  </tr>
    <tr>
    <th class="label">Confirmar Senha*</th>
    <td><input type="password" id="confSenha" name="confSenha" <%if (confSenha != null) { %>value="<%=confSenha%>"<% }%>  size="20" maxlength="20"></td>
  </tr>
  <tr>
      <th class="label">Grupo de Usuário</th>
      <td><select id="idGrupoUsuario" name="idGrupoUsuario" style="width: 172px">
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboGrupoUsuario.jspf"%></select>
          <script>comboSelect(document.forms[0].idGrupoUsuario, '<%=idGrupoUsuario%>');</script>
      </td>
  </tr>
  <tr>
    <th class="label">Ativo</th>
      <td class="label_radio"><input type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Sim
      <input type="radio" class="radio" name="status" value="I" <%= (status.equals("I")? "checked": "") %>>Não</td>    
  </tr>
  </table>
 <table border="0" width="100%">
  <%if(acao.equals("atu")){%>
  
  	<tr>
  	    <th class="label">Registros:</th>
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