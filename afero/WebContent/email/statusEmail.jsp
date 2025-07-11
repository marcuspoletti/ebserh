<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<%@ page import="afero.util.SendMail" %>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/></script>
<script>
function fechar(){
	opener.location.reload();//Atualiza a página de origem que abriu esse pop-up
	window.close();
}
</script>
</head>
<%
String para = "";
String msg = "";
if(request.getParameter("para")!= null){
	para = request.getParameter("para");
}else{
	msg = "Email sem destinatário. ";
}
String assunto = "";
if(request.getParameter("assunto")!= null){
	assunto = request.getParameter("assunto");
}else{
	msg += "/Email sem Assunto. ";
}
String mensagem = "";
if(request.getParameter("mensagem")!= null){
	mensagem = request.getParameter("mensagem");
}else{
	msg += "/Email sem o corpo ";
}

try{
    SendMail send = new SendMail();
    send.sendMail("mvpoletti@yahoo.com.br",para, assunto, mensagem);
    msg = "SUCESSO DE ENVIO..........";
}catch(Exception e){
	msg += "/"+e.getMessage();
}

%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Email</h1>
<% if (msg != "") { %><div class="mensagem"><center><%= msg %></center></div><hr><% } %>
<form method="post" action="statusEmail.jsp">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
	<td><input class="button" type="button" value="Voltar" onClick="javascript:history.back(1);" />
	<input class="button" type="button" value="Sair" onClick="javaScript:fechar();" />
</tr>
</table>
</form>
<%@include file="../fimConexao.jsp"%>
</body>
</html>