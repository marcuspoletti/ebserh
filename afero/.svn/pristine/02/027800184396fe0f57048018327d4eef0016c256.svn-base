<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.PedidoEntrada"%>
<%@page import="afero.persistence.PedidoEntradaDAO"%>
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
  document.forms[0].action='painelGrupoVendasPedido.jsp';
  document.forms[0].submit();
}
function dois_pontos(tempo){
    if(event.keyCode<48 || event.keyCode>57){
      event.returnValue=false;}
    if(tempo.value.length==2 || tempo.value.length==5){
      tempo.value+=":";}
}
function valida_horas(tempo){
horario = tempo.value.split(":");
var horas = horario[0];
var minutos = horario[1];
var segundos = horario[2];
if(horas > 24){ //para relógio de 12 horas altere o valor aqui
alert("Hora inválida"); event.returnValue=false;relogio.focus()}
if(minutos > 59){
alert("MINUTOS inválidos"); event.returnValue=false;relogio.focus()}
if(segundos > 59){
alert("Segundos inválidos"); event.returnValue=false;relogio.focus()}
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
  PedidoEntradaDAO daoPedidoSaida = new PedidoEntradaDAO(conn);
  String horaIni = request.getParameter("horaIni");
  String dataIni = request.getParameter("dataIni");
  String dataFim = request.getParameter("dataFim");
  String horaFim = request.getParameter("horaFim");
  int mes        = dataAtual.get(Calendar.MONTH) + 1;

  if (dataIni == null) {
   dataIni = daoPedidoSaida.dataAtualPedido();
  }
  if (dataFim == null) {
    dataFim = daoPedidoSaida.dataAtualPedido();
  }
  if(horaIni == null){
	  horaIni = "00:00:00";
  }
  if(horaFim == null){
	  horaFim = "23:59:59";
  }
  String frame = "?dataIni="+dataIni+"&dataFim="+dataFim+"&status=P&idLoja="+idLoja+"&horaIni="+horaIni+"&horaFim="+horaFim;
%>
<script>
function atualizar() {
  document.forms[0].submit();
}
setTimeout("atualizar()", <%= secs %> * 1000);
</script>

<%-- Início do Conteúdo da Página --%>
<div class="cabecalho_pagina">Painel de Vendas por Grupo Pedido</div>
<hr>
<form action="painelGrupoVendasPedido.jsp">
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
      <td class='grid'>Hora Inicial
        <input type="text" name="horaIni" maxlength="8" value="<%= horaIni %>"onkeypress="dois_pontos(this)" onBlur="valida_horas(this)">
      </td>
      <td class='grid'>Data Final 
	   <input type="text"  name="dataFim" size="15" value="<%= dataFim %>" maxlength="10" onblur="chkData(this,'dd/MM/yyyy')" class="inputs"><a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dataFim);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
	  <td class='grid'>Hora Final
        <input type="text" name="horaFim" maxlength="8" value="<%= horaFim %>"onkeypress="dois_pontos(this)" onBlur="valida_horas(this)">
      </td>
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
 <th class="grid" colspan="2">Vendas de Grupos</th>
</tr>
<tr>
 <td colspan="2">
  <iframe src="frameVendasGruposPedido.jsp<%=frame%>" src2="" name="frame_pedido" width="100%" height=200 scrolling="auto" align="top" frameborder="0" hspace="0" vspace="0" marginheight="0" marginwidth="0"></iframe>
 </td>
</tr>
<tr>
 <th class="grid" colspan="2">Condição de Pagto por Grupos</th>
</tr>
<tr>
 <td colspan="2">
  <iframe src="frameVendasGrupoCondicaoPagamentoPedido.jsp<%=frame%>" src2="" name="frameCondPagto" width="100%" height=200 scrolling="auto" align="top" frameborder="0" hspace="0" vspace="0" marginheight="0" marginwidth="0"></iframe>
 </td>
</tr>
</table>
<br><br>
<%@include file="../fimConexao.jsp"%>