<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.PedidoSaida" %>
<%@ page import="afero.model.Entrega" %>
<%@ page import="afero.model.Orcamento" %>
<%@ page import="afero.model.Entidade" %>
<%@ page import="afero.persistence.OrcamentoDAO" %>
<%@ page import="afero.persistence.EntregaDAO" %>
<%@ page import="afero.persistence.EntidadeDAO" %>
<%@ page import="afero.persistence.OrdemServicoDAO" %>
<%@ page import="afero.persistence.PedidoSaidaDAO" %>
<%@page import="afero.util.Utilitaria"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Date" %>
<%@ page import="afero.util.ConverteDate" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>


function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.nomeEntidade.value = '';
  document.all.status.value = ''; //não está limpando
  document.forms[0].submit();
}  
</script>

<%
String idLoja = request.getParameter("idLoja");
ConverteDate converte = new ConverteDate();
PedidoSaidaDAO daoPresencial = null;
PedidoSaidaDAO daoRapido = null;
PedidoSaidaDAO daoTelefonista = null;
String nomeEntidade = request.getParameter("nomeEntidade");
String acao = request.getParameter("acao");
String dataIni = request.getParameter("dataIni");
String dataFim = request.getParameter("dataFim");
String tipoPedido =request.getParameter("tipoPedido");
String status =request.getParameter("status");
String clausula = "";
double valorPresencial = 0;
double valorPresencialEntrega = 0;
int quantPresencial = 0;
int quantPresencialEntrega = 0;
double valorRapido = 0;
double valorRapidoEntrega = 0;
int quantRapido = 0;
int quantRapidoEntrega = 0;
double valorTelefonista = 0;
double valorTelefonistaEntrega = 0;
int quantTelefonista = 0;
int quantTelefonistaEntrega = 0;
double valorTotal = 0;
int quantTotal = 0;
//-----------------PEDIDO PRESENCIAL
tipoPedido = "P";
clausula = " WHERE ps.status = '"+status+"' AND ps.tipoPedido = 'P' AND ps.dtPed BETWEEN '"+converte.DMYToYMDI(dataIni)+" 00:00:00' AND '"+converte.DMYToYMDI(dataFim)+" 23:59:59'"; 
    
if(!idLoja.equalsIgnoreCase("0")){
	clausula = clausula + " AND ps.idLoja = " + Integer.parseInt(idLoja);
}
daoPresencial = new PedidoSaidaDAO(conn);
valorPresencial = daoPresencial.valorTotalPedido(clausula);
quantPresencial  = daoPresencial.quantPedidos(clausula);
quantPresencialEntrega = daoPresencial.quantPedidosEntrega(clausula);
valorPresencialEntrega = daoPresencial.valorTotalPedidoEntrega(clausula);

//---------------------PEDIDO RAPIDO
tipoPedido = "R";
clausula = " WHERE ps.status = '"+status+"' AND ps.tipoPedido = 'R' AND ps.dtPed BETWEEN '"+converte.DMYToYMDI(dataIni)+" 00:00:00' AND '"+converte.DMYToYMDI(dataFim)+" 23:59:59'"; 

if(!idLoja.equalsIgnoreCase("0")){
	clausula = clausula + " AND ps.idLoja = " + Integer.parseInt(idLoja);
}
daoRapido = new PedidoSaidaDAO(conn);
valorRapido = daoRapido.valorTotalPedido(clausula);
quantRapido = daoRapido.quantPedidos(clausula);
quantRapidoEntrega = daoRapido.quantPedidosEntrega(clausula);
valorRapidoEntrega = daoRapido.valorTotalPedidoEntrega(clausula);
//-----------------PEDIDO TELEFONISTA
tipoPedido = "T";
clausula = " WHERE ps.status = '"+status+"' AND ps.tipoPedido = 'T' AND ps.dtPed BETWEEN '"+converte.DMYToYMDI(dataIni)+" 00:00:00' AND '"+converte.DMYToYMDI(dataFim)+" 23:59:59'"; 

if(!idLoja.equalsIgnoreCase("0")){
	clausula = clausula + " AND ps.idLoja = " + Integer.parseInt(idLoja);
}
daoTelefonista = new PedidoSaidaDAO(conn);
valorTelefonista = daoTelefonista.valorTotalPedido(clausula);
quantTelefonista = daoTelefonista.quantPedidos(clausula);
quantTelefonistaEntrega = daoTelefonista.quantPedidosEntrega(clausula);
valorTelefonistaEntrega = daoTelefonista.valorTotalPedidoEntrega(clausula);
valorTotal = valorPresencial + valorRapido + valorTelefonista;
quantTotal = quantTelefonista + quantRapido + quantPresencial;

%>
<body onload="document.forms[0].elements[0].focus();" >

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr>
      <th class="grid" width="2%" colspan="4"><center>Pedido Presencial</center></th>
      <th class="grid" width="2%" colspan="4"><center>Pedido Rápido</center></th>
      <th class="grid" width="2%" colspan="4"><center>Pedido Telefonista</center></th>  
    </tr>
    <tr>
      <th class="grid" width="2%"><center>Ped. Pres. (R$)</center></th>
      <th class="grid" width="2%"><center>Qt. Pres.</center></th>
      <th class="grid" width="2%"><center>Qt. Pres. Ent.</center></th>
      <th class="grid" width="2%"><center>Vl. Pres. Ent. (R$)</center></th>
      <th class="grid" width="2%"><center>Ped. Ráp. (R$)</center></th>
      <th class="grid" width="2%"><center>Qt. Ráp.</center></th>
      <th class="grid" width="2%"><center>Qt. Ráp. Ent.</center></th>
      <th class="grid" width="2%"><center>Vl. Ráp. Ent. (R$)</center></th>
      <th class="grid" width="2%"><center>Ped. Tel. (R$)</center></th>
      <th class="grid" width="2%"><center>Qt. Tel.</center></th>
      <th class="grid" width="2%"><center>Qt. Tel. Ent.</center></th>
      <th class="grid" width="2%"><center>Vl. Tel. Ent. (R$)</center></th>
      
    </tr>
   <tr>
     <td class = "grid" width="2%"><center><%=Utilitaria.formatarNumero(valorPresencial,2)%></center></td>
     <td class = "grid" width="2%"><center><%=quantPresencial%></center></td>
     <td class = "grid" width="2%"><center><%=quantPresencialEntrega%></center></td>
     <td class = "grid" width="2%"><center><%=Utilitaria.formatarNumero(valorPresencialEntrega,2)%></center></td>
     <td class = "grid" width="2%"><center><%=Utilitaria.formatarNumero(valorRapido,2)%></center></td>
     <td class = "grid" width="2%"><center><%=quantRapido%></center></td>
     <td class = "grid" width="2%"><center><%=quantRapidoEntrega%></center></td>
     <td class = "grid" width="2%"><center><%=Utilitaria.formatarNumero(valorRapidoEntrega,2)%></center></td>
     <td class = "grid" width="2%"><center><%=Utilitaria.formatarNumero(valorTelefonista,2)%></center></td>
     <td class = "grid" width="2%"><center><%=quantTelefonista%></center></td>
     <td class = "grid" width="2%"><center><%=quantTelefonistaEntrega%></center></td>
     <td class = "grid" width="2%"><center><%=Utilitaria.formatarNumero(valorTelefonistaEntrega,2)%></center></td>
     
  </tr>
      
</table>
<table border="0" width="100%">
<tr>
<th class="grid"><center>Valor Total</center></th>
<td class="grid"><center><font color="red"><b><%=Utilitaria.formatarNumero(valorTotal,2)%></b></font></center></td>
<th class="grid"><center>Quant. Total</center></th>
<td class="grid"><center><font color="red"><b><%=quantTotal%></b></font></center></td>
</tr>
</table>
<%@include file="../fimConexao.jsp"%>