<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@include file="../seguranca.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script type="text/javascript">
	var xmlHttp;

	function loadXMLDoc(url, cfunc) {
		if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlHttp = new XMLHttpRequest();
		} else {// code for IE6, IE5
			xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlHttp.onreadystatechange = cfunc;
		xmlHttp.open("GET", url, true);
		xmlHttp.send();
	}

	function alltrim(str) {
		return str.replace(/^\s+|\s+$/g, "");
	}

	function processar() {
		var arquivo = document.getElementById('arquivo').value;
		document.getElementById("retorno").innerHTML = "";

		loadXMLDoc(
				"formGerarArquivoClienteProcessar.jsp?arquivo=" + arquivo,
				function() {
					if (xmlHttp.readyState == 1) {
						document.getElementById("retorno").innerHTML = "<p style=\"color:red\">Processando...</p>";
					}
					if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
						var retorno = alltrim(xmlHttp.responseText);
						document.getElementById("retorno").innerHTML = retorno;
					}
				});
	}
</script>
<title>Gerar Arquivo</title>
</head>
<%
	String acao = request.getParameter("acao");
	String arquivo = request.getParameter("arquivo");
	String msg = request.getParameter("msg");
	if (acao == null)
		acao = "";
	if (arquivo == null)
		arquivo = "cliente.txt";
	if (msg == null)
		msg = "";
%>
<body onload="document.forms[0].elements[2].focus();">
	<table style="border: 0px">
		<tr>
			<td><font color="red"><%=msg%></font></td>
		</tr>
	</table>
	<form name="formGerarArquivoCliente"
		action="formGerarArquivoCliente.jsp" method="post">
		<h1 class="cabecalho">Gerar Arquivo Cliente</h1>
		<table class="crud" style="border: 0px">
			<tr>
				<th>Arquivo:</th>
				<td><input type="text" name="arquivo" id="arquivo"
					value="<%=arquivo%>" size="12" maxlength="10" /></td>
				<td><input class="button"
					type="button" value="Processar" onclick="javascript:processar();" />
 					<input class="button" type="button" value="Voltar" onclick="location.href='../cadastros/listarEntidadeFisica.jsp';" />
				</td>
			</tr>
		</table>
		<div id="retorno"></div>

	</form>
</body>
</html>
