<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.PedidosItens" %>
<%@ page import="afero.model.Entrega" %>
<%@ page import="afero.persistence.EntregaDAO" %>
<%@ page import="afero.persistence.PedidoItensDAO" %>
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
String idDivisao = request.getParameter("idDivisao");
if(idDivisao == null)idDivisao="0";
String idLoja = request.getParameter("idLoja");
ConverteDate converte = new ConverteDate();
PedidoItensDAO dao = null;
String dataIni = request.getParameter("dataIni");
String dataFim = request.getParameter("dataFim");
String clausula = "";

clausula = " WHERE ps.dtEntrega BETWEEN '"+converte.DMYToYMDI(dataIni)+" 00:00:00' AND '"+converte.DMYToYMDI(dataFim)+" 23:59:59'"; 
    
if(!idLoja.equalsIgnoreCase("0")){
	clausula = clausula + " AND ps.status <> 'C' AND ps.idLoja = " + Integer.parseInt(idLoja)+" AND p.idDivisao = "+Integer.parseInt(idDivisao);
}

//seleciona todos os registros do banco de dados
List list;
dao = new PedidoItensDAO(conn);
clausula = clausula+" ORDER BY ps.hrEntrega, ps.dtPed ";
list = dao.listarPedidoItens(clausula);

int cont = 0;
%>
<body onload="document.forms[0].elements[0].focus();" >

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr>
      <th class="grid" width="2%">&nbsp;</th>
      <th class="grid" width="2%"><center>Pedido</center></th>
      <th class="grid" width="5%"><center>Dt. Pedido</center></th>
      <th class="grid" width="5%"><center>Produto</center></th>
      <th class="grid" width="2%">Quant</th>
      <th class="grid" width="2%">Entrega</th>
      <th class="grid" width="2%">Hr. Entrega</th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	PedidosItens pedidosItens = (PedidosItens) it.next();
	Entrega entrega = new Entrega();
	EntregaDAO daoEntrega = new EntregaDAO(conn);
	entrega = daoEntrega.procurarEntrega(pedidosItens.getIdEntrega());
	cont++;
%>
    
   <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid" width="2%"><center><%="00"+pedidosItens.getIdPedido()%></center></td>
      <td class = "grid" width="5%"><center><%=ConverteDate.dateToString(pedidosItens.getDataPedido())%></center></td>
      <%if(pedidosItens.getDsCompProduto() != null){ %>
        <td class = "grid" width="5%"><center><%=pedidosItens.getDsProduto()+". "+pedidosItens.getDsCompProduto()%></center></td>
      <%}else{ %>
      <td class = "grid" width="5%"><center><%=pedidosItens.getDsProduto()%></center></td>
      <%} %>
      <td class = "grid" width="5%"><center><%=Utilitaria.formatarNumero(pedidosItens.getQuantPedido(),2)%></center></td>
      <td class = "grid" width="5%"><center><%=entrega.getDsEntrega()%></center></td>
      <td class = "grid" width="5%"><center><%=pedidosItens.getHrEntrega()%></center></td>
  </tr>
<%
}
%>      
</table>
<%@include file="../fimConexao.jsp"%>