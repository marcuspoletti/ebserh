<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.PedidoSaida"%>
<%@page import="afero.persistence.PedidoSaidaDAO"%>
<%@ page import="afero.util.ConverteDate" %>
<%@page import="java.util.Calendar" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script language=JavaScript src="../js/abas.js" type=text/javascript></script>
<script src="../js/common.js" /></script>
<script>

function localizar() {
  
  document.forms[0].submit();
}  


function recarregar() {
  document.forms[0].action='painelEntregaBalcao.jsp';
  document.forms[0].submit();
}
</script>
<%
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
  int mes        = dataAtual.get(Calendar.MONTH) + 1;

  if (dataIni == null) {
   dataIni = daoPedidoSaida.dataAtualPedido();
  }
  if (dataFim == null) {
    dataFim = daoPedidoSaida.dataAtualPedido();
  }
  
  String framePendente = "?dataIni="+dataIni+"&dataFim="+dataFim+"&status=P&idLoja="+idLoja;
  String frameAtendido = "?dataIni="+dataIni+"&dataFim="+dataFim+"&status=A&idLoja="+idLoja;
  String frameCancelado = "?dataIni="+dataIni+"&dataFim="+dataFim+"&status=C&idLoja="+idLoja;
  String frameFaturada = "?dataIni="+dataIni+"&dataFim="+dataFim+"&status=F&idLoja="+idLoja;
  String continua = "";
%>
<script>
function atualizar() {
  document.forms[0].submit();
}
setTimeout("atualizar()", <%= secs %> * 1000);
</script>

<%-- Início do Conteúdo da Página --%>
<div class="cabecalho_pagina">Painel de Entregas Balcão</div>
<hr>
<form action="painelEntregaBalcao.jsp">
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
 <th class="grid" colspan="2">ENTREGA PENDENTE</th>
</tr>
<tr>
 <td colspan="2">
  <iframe src="frameEntregaBalcao.jsp<%= framePendente %>" src2="" name="frame_pedido" width="100%" height=200 scrolling="auto" align="top" frameborder="0" hspace="0" vspace="0" marginheight="0" marginwidth="0"></iframe>
 </td>
</tr>
<tr>
 <th class="grid" colspan="2">ENTREGA ATENDIDA</th> 
</tr>
<tr>
 <td colspan="2">
  <iframe src="frameEntregaBalcao.jsp<%= frameAtendido %>" src2="" name="frame_pedido" width="100%" height=200 scrolling="auto" align="top" frameborder="0" hspace="0" vspace="0" marginheight="0" marginwidth="0"></iframe>
 </td>
</tr>
<tr>
 <th class="grid" colspan="2">ENTREGA CANCELADA</th> 
</tr>
<tr>
 <td colspan="2">
  <iframe src="frameEntregaBalcao.jsp<%= frameCancelado %>" src2="" name="frame_pedido" width="100%" height=200 scrolling="auto" align="top" frameborder="0" hspace="0" vspace="0" marginheight="0" marginwidth="0"></iframe>
 </td>
</tr>
<tr>
 <th class="grid" colspan="2">ENTREGA FATURADA</th> 
</tr>
<tr>
 <td colspan="2">
  <iframe src="frameEntregaBalcao.jsp<%= frameFaturada %>" src2="" name="frame_pedido" width="100%" height=200 scrolling="auto" align="top" frameborder="0" hspace="0" vspace="0" marginheight="0" marginwidth="0"></iframe>
 </td>
</tr>
</table>
<br><br>
<%@include file="../fimConexao.jsp"%>
