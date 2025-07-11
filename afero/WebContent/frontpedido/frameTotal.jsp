<%@ page import="afero.persistence.PedidoSaidaSubDAO"%>
<%@ page import="afero.persistence.PedidoSaidaSubItemDAO"%>
<%@ page import="afero.model.PedidoSaidaSub"%>
<%@ page import="afero.model.PedidoSaidaSubItem"%>

<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<%@page import="afero.util.Utilitaria"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Iterator"%>
<script src="../js/common.js"/></script>
<%
List list = null;
PedidoSaidaSubDAO daoPedidoSaida = new PedidoSaidaSubDAO(conn);
PedidoSaidaSubItemDAO daoPedidoSaidaItem = new PedidoSaidaSubItemDAO(conn);
PedidoSaidaSub pedidoSaida = null;
PedidoSaidaSubItem pedidoSaidaItem = null;
String idPedidoSaida = request.getParameter("idPedidoSaida");
if(idPedidoSaida == null)idPedidoSaida = "0";
double valorTotal = 0;
double valorItem = 0;
if(!idPedidoSaida.equalsIgnoreCase("0") && !idPedidoSaida.equalsIgnoreCase("N")){
 pedidoSaida = daoPedidoSaida.procurarPedidoSaida(Integer.parseInt(idPedidoSaida));
 list = daoPedidoSaidaItem.procurarPedidoSaidaItem(pedidoSaida.getIdPedidoSaida());
 if(list != null){
  for ( Iterator it = list.iterator(); it.hasNext(); ) {
	pedidoSaidaItem = (PedidoSaidaSubItem) it.next();
	valorItem = pedidoSaidaItem.getValor() * pedidoSaidaItem.getQuant();
	valorTotal+=valorItem;
  }
 }
}else{
 valorTotal = 0;	
}


%>

<hr>
<table>
<th class="grid"><b><font size="3">TOTAL:</font></b></th>
<th class="grid"><font color="red" size="3"><%=Utilitaria.formatarNumero(valorTotal,2)%></font></th>
</table>

<%@include file="../fimConexao.jsp"%>