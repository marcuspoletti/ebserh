<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.PedidoSaida"%>
<%@page import="afero.persistence.PedidoSaidaDAO"%>
<%@ page import="afero.util.ConverteDate" %>
<%@page import="java.util.Calendar" %>
<%@include file="../../seguranca.jsp"%>
<%@include file="../../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../../css/afero.css" />
<script src="../../js/common.js" /></script>
<script>

function localizar() {
  
  document.forms[0].submit();
}  


function recarregar() {
  document.forms[0].action='selecaoMesas.jsp';
  document.forms[0].submit();
}

function atualizar() {
  document.forms[0].submit();
}
</script>

<%-- Início do Conteúdo da Página --%>
<div class="cabecalho_pagina">MESAS</div>
<hr>
<table border="1" width="100%">
<tr>
 <th class="grid" width="100%">SELECIONAR A MESA</th>
</tr>
<tr>
 <td >
  <iframe src="frameMesas.jsp" name="frameMesas.jsp"  name="frameMesas.jsp" width="102%" height="500" scrolling="auto" align="top" frameborder="0" hspace="0" vspace="0" marginheight="0" marginwidth="0"></iframe>
 </td>
</tr>
</table>
<br><br>
<%@include file="../../fimConexao.jsp"%>