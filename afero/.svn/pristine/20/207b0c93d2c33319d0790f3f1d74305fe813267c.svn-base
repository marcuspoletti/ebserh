<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>

<%@ page import="afero.model.Usuario" %>
<%@ page import="afero.persistence.UsuarioDAO" %>
<%@ page import="afero.auxiliar.Seguranca" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@page import="afero.util.Utilitaria"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/></script>

<script>

function atualizar() {
 document.forms[0].action='gerarSenhaUsuarios.jsp';
 document.forms[0].submit();
}  


</script>

<%
String mensagem = "";
String senhaCode = "";
Seguranca seguranca = new Seguranca();
String acao = null;
if(request.getParameter("acao")!= null){
	acao = request.getParameter("acao");
}else{
	acao = "N";
}

if(acao.equalsIgnoreCase("ok")){
try {
	UsuarioDAO daoUsuario = new UsuarioDAO(conn);
	List list = daoUsuario.listarUsuario(" ORDER BY login ");
	for ( Iterator it = list.iterator(); it.hasNext(); ) {
		Usuario usuario = (Usuario) it.next();
		//seguranca
		seguranca.setUsuario(usuario.getLogin());
		seguranca.setSenha(usuario.getSenha());
		senhaCode = seguranca.md5(seguranca.getUsuario()+seguranca.getSenha());
		//fim seguranca
		usuario.setSenha(senhaCode);
		usuario.setStatus(usuario.getStatus());
		usuario.setIdGrupoUsuario(usuario.getIdGrupoUsuario());
		usuario.setUsuario(usuario.getUsuario());
		if(!usuario.getLogin().equalsIgnoreCase("afero")){
		   daoUsuario.atualizar(usuario);
		   mensagem += "Sucesso na rotina..." + " "+ usuario.getLogin() + " " + "Criptografia Md5 criada na senha... \n";
		}
		
	}

} catch (Exception e) {
	throw new AferoDAOException("Erro: " + ":\n" + e.getMessage());
	
}
}

%>

<h1 class="cabecalho_pagina">Gerar Senha Criptografada (MD5)</h1>

<hr>

<body onload="document.forms[0].elements[0].focus();" >
<form method="get" action="gerarSenhaUsuarios.jsp">
  <table border="0" width="100%">
     <tr>
    <td align="center">
        <input type="button" value="Gerar Senha" class="botao" onclick="atualizar();">
        <input type="hidden" name="acao" value="<%="ok"%>">
    </td>
    </tr>
    </table>
    <br>
    <br>
    <br>
    <table border="0" width="100%" align="center">
    <tr colspan = "5">
		<td  align="center" class="grid_erro"><font size="5" ><center><%=" (POR FAVOR FAÇA BACKUP ANTES DA TABELA USUÁRIO......(tbusuario) )Vai ser gerado Senha criptografada MD5 para todos os usuários na BASE DE DADOS..."%></center></font></td>
    </tr>
    <tr colspan = "5">
		<td  align="center" class="grid_erro"><font size="5" ><center><%=mensagem%></center></font></td>
    </tr>
    </table>
<hr>
</form>
<%@include file="../fimConexao.jsp"%>