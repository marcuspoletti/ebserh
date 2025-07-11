<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.PedidoEntrada" %>
<%@ page import="afero.model.Entrega" %>
<%@ page import="afero.model.Orcamento" %>
<%@ page import="afero.model.Entidade" %>
<%@ page import="afero.persistence.OrcamentoDAO" %>
<%@ page import="afero.persistence.EntregaDAO" %>
<%@ page import="afero.persistence.EntidadeDAO" %>
<%@ page import="afero.persistence.OrdemServicoDAO" %>
<%@ page import="afero.persistence.PedidoEntradaDAO" %>
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
PedidoEntradaDAO dao = null;
String nomeEntidade = request.getParameter("nomeEntidade");
String acao = request.getParameter("acao");
String dataIni = request.getParameter("dataIni");
String dataFim = request.getParameter("dataFim");
String status =request.getParameter("status");
String clausula = "";

clausula = " WHERE pe.status = '"+status+"' AND pe.dtPed BETWEEN '"+converte.DMYToYMDI(dataIni)+" 00:00:00' AND '"+converte.DMYToYMDI(dataFim)+" 23:59:59'"; 
    
if(!idLoja.equalsIgnoreCase("0")){
	clausula = clausula + " AND pe.idLoja = " + Integer.parseInt(idLoja);
}

//seleciona todos os registros do banco de dados
List list;
dao = new PedidoEntradaDAO(conn);
clausula = clausula+" ORDER BY pe.dtPed desc";
list = dao.listarPedidoEntrada(clausula);

int cont = 0;
%>
<body onload="document.forms[0].elements[0].focus();" >

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr">
      <th class="grid" width="2%">&nbsp;</th>
      <th class="grid" width="2%"><center>Ordem de Serviço</center></th>
      <th class="grid" width="2%"><center>Número do Doc.</center></th>
      <th class="grid" width="5%"><center>Fornecedor</center></th>
      <th class="grid" width="5%"><center>Valor R$</center></th>
      <th class="grid" width="2%">Status</th>
    </tr>
<%
int ordemServico = 0;
String dsStatus = "";
double valorTotal = 0.0;
//Utiliza o ResultSet para trazer os registros do banco de dados
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	PedidoEntrada pedidoEntrada = (PedidoEntrada) it.next();
	PedidoEntrada pedEntrada = dao.procurarPedidoEntrada(pedidoEntrada.getIdPedidoEntrada());
	ordemServico = pedEntrada.getIdOrdemServico();
	EntidadeDAO daoEntidade = new EntidadeDAO(conn);
	//Entrega entrega = new Entrega();
	//EntregaDAO daoEntrega = new EntregaDAO(conn);
	//entrega = daoEntrega.procurarEntrega(pedEntrada.getIdEntrega());
	Entidade entidade = null;
	entidade = daoEntidade.procurarEntidade(pedEntrada.getCdEntidade());
	cont++;
	if(pedEntrada.getStatus().equalsIgnoreCase("A")){
		dsStatus="Atendido";
	}else if(pedEntrada.getStatus().equalsIgnoreCase("P")){
		dsStatus="Pendente";
	}else if(pedEntrada.getStatus().equalsIgnoreCase("F")){
		dsStatus="Faturado";
	}else if(pedEntrada.getStatus().equalsIgnoreCase("C")){
		dsStatus="Cancelado";
	}
    valorTotal = valorTotal + (pedEntrada.getVlPed());
%>
    
   <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <%if(ordemServico == 0){ %>
      	<td class = "grid" width="2%"><font color="red"><center><%="COMPRA"%></center></font></td>
      <%}else{ %>
      	 <td class = "grid" width="2%"><center><%=ordemServico%></center></td>
      <%} %>
      <td class = "grid" width="2%"><center><a target="_blank" href="compras.jsp?idPedidoEntrada=<%=pedEntrada.getIdPedidoEntrada()%>"><%=pedEntrada.getIdPedidoEntrada()%></a></center></td>
      <td class = "grid" width="30%"><center><%=entidade.getNome()%></center></td>
      <td class = "grid" width="5%"><center><%=Utilitaria.formatarNumero(pedEntrada.getVlPed(),2)%></center></td>
      <td class = "grid" width="3%"><font color="red"><center><%=dsStatus%></center></font></td>
  	</tr>
<%
}
%>      
</table>
<table border="0" width="100%">
<tr>
<th class="grid"><center>Valor Total</center></th>
<td class="grid"><center><font color="red"><b><%=Utilitaria.formatarNumero(valorTotal,2)%></b></font></center></td>
</tr>
</table>
<%@include file="../fimConexao.jsp"%>