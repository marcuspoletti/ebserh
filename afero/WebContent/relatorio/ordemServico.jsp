<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link type="text/css" rel="Stylesheet" href="../../style/style.css" />
<script type="text/javascript">
function submit(){
	document.forms[0].submit();
}
function fechar(){
	window.close();
}

</script>

</head>
<%
String idOrdemServico = request.getParameter("idOrdemServico");
String idLoja = request.getParameter("idLoja");
String idCliente = request.getParameter("idCliente");

%>
<h1>Ordem Servico</h1>
<form name="ordemServico" method="post"
	action="OrdemServicoServlet">

<input type='hidden' name="idOrdemServico" value="<%=idOrdemServico%>">
<input type='hidden' name="idLoja" value="<%=idLoja%>">
<input type='hidden' name="idCliente" value="<%=idCliente%>">
<input type="submit" name="gerar" value="Gerar Relatório">
</form>

</body>
<script type="text/javascript">
window.onload = submit();
window.close();
</script>



</html>