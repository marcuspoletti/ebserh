<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%--@ page import="br.com.ajusoft.ecartorio.util.ConverteDate" --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@include file="../seguranca.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<title>Importar Arquivo Cliente</title>
</head>
<%
//  String dataAviso = ConverteDate.dateToStr(new java.util.Date());
String usuario = (String)session.getAttribute("Login");
%>

<body>
<form name="receberArquivoCliente" enctype="multipart/form-data" action="UploadCliente?usuario=<%=usuario%>" target="_blank"
	method=POST><br>
<br>
<br>
<center>
<table class="crud" style="border:2px">
	<tr>
		<td colspan="2">
			<p align="center"><B>IMPORTAR ARQUIVO DO CLIENTE</B>
		</td>
	</tr>
	<tr>
		<th>Arquivo</th>
		<td><INPUT NAME="nomeArquivo" ID="nomeArquivo" TYPE="file" SIZE="60"></td>
	</tr>
	<tr>
		<td colspan="2">
			<p align="center"><INPUT TYPE="submit" VALUE="Importar">
			<input type="button" value="Voltar" onclick="location.href='../cadastros/listarEntidadeFisica.jsp'"></p>
		</td>
	</tr>
</table>
</center>
</form>
</body>
</html>