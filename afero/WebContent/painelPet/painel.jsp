<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.PedidoEntrada"%>
<%@page import="afero.persistence.PedidoEntradaDAO"%>
<%@ page import="afero.util.ConverteDate" %>
<%@page import="java.util.Calendar" %>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
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
  document.forms[0].action='painelCompras.jsp';
  document.forms[0].submit();
}
</script>
<%
  String tipo = "os" ;
  int secs           = 120;
  Calendar dataAtual = Calendar.getInstance();
  ConverteDate converte = new ConverteDate();
  try {
    secs = Integer.parseInt("120");
  }
  catch (Exception e) {}
  PedidoEntradaDAO daoPedidoSaida = new PedidoEntradaDAO(conn);
  String dataIni = request.getParameter("dataIni");
  String dataFim = request.getParameter("dataFim");
  int mes        = dataAtual.get(Calendar.MONTH) + 1;

  if (dataIni == null) {
   //dataIni = daoPedidoSaida.dataAtualPedido();
    try {
	  	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");      
	  	dataIni = sdf.format(new Date());
	  } catch (NumberFormatException nfe) {
	  	throw new Exception("Data inválida");
	  } catch (Exception e) {
	  	throw new Exception(e.getMessage());
	  }
  }
  if (dataFim == null) {
    //dataFim = daoPedidoSaida.dataAtualPedido();
    try {
	  	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");      
	  	Calendar c = Calendar.getInstance();   
	  	c.setTime(new Date());   
	  	c.add(Calendar.DATE, 7);   
	  	Date d = c.getTime();   	
	  	dataFim = sdf.format(d);
	  } catch (NumberFormatException nfe) {
	  	throw new Exception("Data inválida");
	  } catch (Exception e) {
	  	throw new Exception(e.getMessage());
	  }
  }
  
  String frameAgendamento = "?dataIni="+dataIni+"&dataFim="+dataFim;
  String continua = "";
%>
<script>
function atualizar() {
  document.forms[0].submit();
}
setTimeout("atualizar()", <%= secs %> * 1000);
</script>

<%-- Início do Conteúdo da Página --%>
<div class="cabecalho_pagina">Painel Pet</div>
<hr>
<form action="painel.jsp">
<iframe width=174 height=189 name="gToday:normal:"../js/calendar/agenda.js"
            id="gToday:normal:"../js/calendar/agenda.js" src="../js/calendar/ipopeng.htm"
            scrolling="no" frameborder="0" style="visibility:visible; z-index:999; 
    position:absolute; top:-500px; left:-500px;">
</iframe>

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
 <th class="grid" colspan="2">AGENDAMENTO</th>
</tr>
<tr>
 <td colspan="2">
  <iframe src="frameAgendamento.jsp<%=frameAgendamento%>" src2="" name="frame_agendamento" width="100%" height=200 scrolling="auto" align="top" frameborder="0" hspace="0" vspace="0" marginheight="0" marginwidth="0"></iframe>
 </td>
</tr>
</table>
<br><br>
<%@include file="../fimConexao.jsp"%>