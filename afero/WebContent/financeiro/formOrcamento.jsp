<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.persistence.PedidoSaidaDAO"%>
<%@ page import="afero.util.ConverteDate" %>
<%@page import="java.util.Calendar" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<%@page import="afero.model.OrcamentoEmpresa"%>
<%@page import="afero.model.OrcamentoEmpresaItem"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script language=JavaScript src="../js/abas.js" type=text/javascript></script>
<script src="../js/common.js" /></script>
<%  
  String frameOrcamentoAnual = "";
  String idOrcamentoEmpresa = request.getParameter("idOrcamentoEmpresa");
  if(idOrcamentoEmpresa == null)idOrcamentoEmpresa="0";
%>

<%-- Início do Conteúdo da Página --%>
<div class="cabecalho_pagina">Itens do Orçamento</div>
<hr>
<table width="100%" border="0">
<tr>
 <th class="grid">Orçamento Anual</th>
 <th class="grid">Meses</th>
</tr>
<tr>
 <td>
  <iframe src="frameOrcamentoAnual.jsp?idOrcamentoEmpresa=<%=idOrcamentoEmpresa %>" src2="" name="frameOrcamentoAnual" width="100%" height=200 scrolling="auto" align="top" frameborder="0" hspace="0" vspace="0" marginheight="0" marginwidth="0"></iframe>
 </td>
 <td>
  <iframe src="frameMesAnual.jsp" src2="" id="frameMes" name="frameMes" width="100%" height=200 scrolling="auto" align="top" frameborder="0" hspace="0" vspace="0" marginheight="0" marginwidth="0"></iframe>
 </td>
</tr>

<tr>
 <th class="grid" colspan="2">Discriminação de Meses</th>
</tr>
<tr>
 <td colspan="2">
  <iframe src="frameMeses.jsp" src2="" id="frameMes2" name="frameMes2" width="100%" height=200 scrolling="auto" align="top" frameborder="0" hspace="0" vspace="0" marginheight="0" marginwidth="0"></iframe>
 </td>
</tr>

</table>

<br><br>
<%@include file="../fimConexao.jsp"%>
