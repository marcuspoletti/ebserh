<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.RetornoNotaFiscal" %>
<%@ page import="afero.persistence.RetornoNotaFiscalDAO" %>
<%@page import="afero.util.Utilitaria"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Date" %>
<%@ page import="afero.auxiliar.IUrls" %>
<%@ page import="afero.util.ConverteDate" %>
<%@ page import="afero.auxiliar.IntegracaoWS" %>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONException"%>
<%@page import ="com.google.gson.Gson"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>


function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.idPedidoLocalizar.value = ''; //não está limpando
  document.forms[0].submit();
}  
</script>




<%
String idPedidoLocalizar;
if(request.getParameter("idPedidoLocalizar") == null || request.getParameter("idPedidoLocalizar") == ""){
	idPedidoLocalizar = "0";
} else {
	idPedidoLocalizar = request.getParameter("idPedidoLocalizar");
}
ConverteDate converte = new ConverteDate();
String acao = request.getParameter("acao");
RetornoNotaFiscalDAO daoRetornoNotaFiscalDAO; 
String mensagem = "";
if(!idPedidoLocalizar.equalsIgnoreCase("0")){
IntegracaoWS integracao = new IntegracaoWS();
String urlConsultar = IUrls.urlConsulta+idPedidoLocalizar;
mensagem += integracao.consultaNotaFiscal(urlConsultar);
}
int cont = 1;

%>
<body onload="document.forms[0].elements[0].focus();" >
<form method="post" action="consultarReferencia.jsp">
<table colspan="2">
  <tr>
    <th class='label'>Número da Referencia da Autorização</th>
    <td><input type="text" name="idPedidoLocalizar" <%if (idPedidoLocalizar != "0") { %>value="<%=idPedidoLocalizar%>"<% }%>  size="20" maxlength="20"></td>
    <td><input class="button" type="button" value="Localizar" onClick="javascript: localizar();" /></td>
    <td><input class="button" type="button" value="Nova pesquisa" onClick="javascript: novaPesquisa();" /></td>
  </tr>

<table border="0" width="100%">
    <tr>
      <th class="grid" width="2%">&nbsp;</th>
      <th class="grid" width="2%"><center>Referência</center></th>
      <th class="grid" width="5%"><center>Mensagem</center></th>
      
    </tr>
   <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid" width="2%"><center><%=idPedidoLocalizar%></center></td>
      <td class = "grid" width="3%"><font color="red"><center><%=mensagem%></center></font></td>
  </tr>
<%
 cont++;
%>      
</table>
</form>
<%@include file="../fimConexao.jsp"%>