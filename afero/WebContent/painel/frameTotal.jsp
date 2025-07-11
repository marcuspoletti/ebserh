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
PedidoSaidaDAO dao = null;
String nomeEntidade = request.getParameter("nomeEntidade");
String acao = request.getParameter("acao");
String dataIni = request.getParameter("dataIni");
String dataFim = request.getParameter("dataFim");
String tipoPedido =request.getParameter("tipoPedido");
String status =request.getParameter("status");
String clausula = "";

double valorTotal = 0;
int quantTotal = 0;
//-----------------PEDIDO TELEFONISTA
tipoPedido = "T";
clausula = " WHERE ps.tipoPedido in ('P', 'T', 'R') AND ps.dtPed BETWEEN '"+converte.DMYToYMDI(dataIni)+" 00:00:00' AND '"+converte.DMYToYMDI(dataFim)+" 23:59:59'";


if(!idLoja.equalsIgnoreCase("0")){
	clausula = clausula + " AND ps.idLoja = " + Integer.parseInt(idLoja);
}
dao = new PedidoSaidaDAO(conn);
valorTotal = dao.valorTotalPedido(clausula);
quantTotal = dao.quantPedidos(clausula);
%>
<body onload="document.forms[0].elements[0].focus();" >

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr>
      <th class="grid" width="2%"><center><font color="red">TOTAL:</font></center></th>
    
      
    </tr>
   <tr>
     <td class = "grid" width="2%"><center><%=Utilitaria.formatarNumero(valorTotal,2)%></center></td>
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