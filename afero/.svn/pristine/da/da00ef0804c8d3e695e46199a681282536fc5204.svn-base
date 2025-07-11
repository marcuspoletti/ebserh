<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.PedidoSaida"%>
<%@page import="afero.persistence.PedidoSaidaDAO"%>
<%@ page import="afero.util.ConverteDate"%>
<%@page import="java.util.Calendar" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script language=JavaScript src="../js/abas.js" type=text/javascript></script>
<script src="../js/common.js"/></script>
<script>

function localizar() {
  
  document.forms[0].submit();
}  

function atualizar(){
	  document.forms[0].submit();
}
</script>
<%
String idVendedor = request.getParameter("idVendedor");
if(idVendedor == null)idVendedor="0";
String cdLoja = request.getParameter("idLoja");
int idLoja = 0;
if (cdLoja == null) {
	idLoja = Integer.parseInt((String)session.getAttribute("idLoja"));
} else {
	idLoja = Integer.parseInt(cdLoja);
}
  String tipo = "os" ;
  int secs           = 120;
  Calendar dataAtual = Calendar.getInstance();
  ConverteDate converte = new ConverteDate();
  try {
    secs = Integer.parseInt("120");
  }
  catch (Exception e) {}
  PedidoSaidaDAO daoPedidoSaida = new PedidoSaidaDAO(conn);
  String dataIni = request.getParameter("dataIni");
  String dataFim = request.getParameter("dataFim");
  String statusPag = request.getParameter("statusPag");
  if(statusPag == null)statusPag="N";
  String tipoPedido = "T";
  String cdCondPagto = request.getParameter("cdCondPagto");
  if(cdCondPagto == null)cdCondPagto = "0";
  int mes        = dataAtual.get(Calendar.MONTH) + 1;

  if (dataIni == null) {
   dataIni = daoPedidoSaida.dataAtualPedido();
  }
  if (dataFim == null) {
    dataFim = daoPedidoSaida.dataAtualPedido();
  }
  
  String framePendente = "?dataIni="+dataIni+"&dataFim="+dataFim+"&status=P&idLoja="+idLoja+"&tipoPedido="+tipoPedido+"&statusPag="+statusPag+"&cdCondPagto="+Integer.parseInt(cdCondPagto)+"&idVendedor="+Integer.parseInt(idVendedor);
  String frameAtendido = "?dataIni="+dataIni+"&dataFim="+dataFim+"&status=A&idLoja="+idLoja+"&tipoPedido="+tipoPedido+"&statusPag="+statusPag+"&cdCondPagto="+Integer.parseInt(cdCondPagto)+"&idVendedor="+Integer.parseInt(idVendedor);
  String frameCancelado = "?dataIni="+dataIni+"&dataFim="+dataFim+"&status=C&idLoja="+idLoja+"&tipoPedido="+tipoPedido+"&statusPag="+statusPag+"&cdCondPagto="+Integer.parseInt(cdCondPagto)+"&idVendedor="+Integer.parseInt(idVendedor);
  String continua = "";
%>
<%-- Início do Conteúdo da Página --%>
<div class="cabecalho_pagina">Painel de Pedido Telefonista</div>
<hr>
<form action="painelPedidoTelefonista.jsp">
<iframe width=174 height=189 name="gToday:normal:"../js/calendar/agenda.js"
            id="gToday:normal:"../js/calendar/agenda.js" src="../js/calendar/ipopeng.htm"
            scrolling="no" frameborder="0" style="visibility:visible; z-index:999; 
    position:absolute; top:-500px; left:-500px;">
    </iframe>

<table border="0" width="100%">
<tr>
      <th class="label">Loja</th>
      <td><select id="idLoja"name="idLoja" onchange="recarregar();" >
          <option value='0'>Todos...</option>
          <%@include file="../WEB-INF/jspf/combo/comboLoja.jspf" %></select>
          <script>comboSelect(document.forms[0].idLoja, '<%= idLoja %>');</script>
      </td>
  </tr>
    <tr>
    <th class="label" colspan="1">Pago</th>
    <td class="label_radio">
      <input type="radio" class="radio" name="statusPag" value="P" <%= (statusPag.equals("P")? "checked": "") %>>Sim
      <input  type="radio" class="radio" name="statusPag" value="N" <%= (statusPag.equals("N")? "checked": "") %>>Não
    </td>
  </tr>
    <tr>
      <th class="label">Condição de Pagto*</th>
      <td><select name="cdCondPagto" onchange="recarregar();">
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboCondicaoPagto.jspf"%></select>
          <script>comboSelect(document.forms[0].cdCondPagto, '<%=cdCondPagto%>');</script>
      </td>
  </tr>
  <tr>
      <th class="label">Vendedor*</th>
      <td><select name="idVendedor" onchange="recarregar();">
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboVendedor.jspf"%></select>
          <script>comboSelect(document.forms[0].idVendedor, '<%= idVendedor %>');</script>
      </td>
  </tr>
 </table>
<table border="0" width="100%">
    <tr>
      <td class='grid'>Data Inicial 
	<input type="text" name="dataIni" size="15" value="<%= dataIni %>" onblur="chkData(this,'dd/MM/yyyy')" maxlength="10" class="inputs"><a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dataIni);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
      </td>
      <td class='grid'>Data Final 
	<input type="text"  name="dataFim" size="15" value="<%= dataFim %>" maxlength="10" onblur="chkData(this,'dd/MM/yyyy')" class="inputs"><a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dataFim);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
      </td>

     
    <td align="center">
        <input type="button" value="Atualizar" class="botao" onclick="atualizar();">
        <input type="button" value="Imprimir" class="botao" onclick="print();">
    </td>
    </tr>

</table>
</form>
<table width="100%" border="0">
<tr>
 <th class="grid" colspan="2">PEDIDO PENDENTE</th>
</tr>
<tr>
 <td colspan="2">
  <iframe src="framePedidoTelefonista.jsp<%= framePendente %>" src2="" name="frame_pedido" width="100%" height=200 scrolling="auto" align="top" frameborder="0" hspace="0" vspace="0" marginheight="0" marginwidth="0"></iframe>
 </td>
</tr>
<tr>
 <th class="grid" colspan="2">PEDIDO ATENDIDO</th> 
</tr>
<tr>
 <td colspan="2">
  <iframe src="framePedidoTelefonista.jsp<%= frameAtendido %>" src2="" name="frame_pedido" width="100%" height=200 scrolling="auto" align="top" frameborder="0" hspace="0" vspace="0" marginheight="0" marginwidth="0"></iframe>
 </td>
</tr>
<tr>
 <th class="grid" colspan="2">PEDIDO CANCELADO</th> 
</tr>
<tr>
 <td colspan="2">
  <iframe src="framePedidoTelefonista.jsp<%= frameCancelado %>" src2="" name="frame_pedido" width="100%" height=200 scrolling="auto" align="top" frameborder="0" hspace="0" vspace="0" marginheight="0" marginwidth="0"></iframe>
 </td>
</tr>
</table>
<br><br>
<%@include file="../fimConexao.jsp"%>
