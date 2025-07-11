<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.PedidoSaida" %>
<%@ page import="afero.model.MapaEntregaData" %>
<%@ page import="afero.model.Entrega" %>
<%@ page import="afero.model.Orcamento" %>
<%@ page import="afero.model.EntradaProdutos" %>
<%@ page import="afero.model.Entidade" %>
<%@ page import="afero.persistence.OrcamentoDAO" %>
<%@ page import="afero.persistence.EntregaDAO" %>
<%@ page import="afero.persistence.EntidadeDAO" %>
<%@ page import="afero.persistence.OrdemServicoDAO" %>
<%@ page import="afero.persistence.PedidoSaidaDAO" %>
<%@ page import="afero.persistence.PedidoEntradaItemDAO" %>
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
String idProduto = request.getParameter("idProduto");
ConverteDate converte = new ConverteDate();
PedidoEntradaItemDAO dao = null;
String nomeEntidade = request.getParameter("nomeEntidade");
String acao = request.getParameter("acao");
String dataIni = request.getParameter("dataIni");
String dataFim = request.getParameter("dataFim");
String status =request.getParameter("status");
String clausula = "";

clausula = " WHERE  p.idProduto = "+Integer.parseInt(idProduto)+" AND pe.dtPed BETWEEN '"+converte.DMYToYMDI(dataIni)+" 00:00:00' AND '"+converte.DMYToYMDI(dataFim)+" 23:59:59'"; 
    
if(!idLoja.equalsIgnoreCase("0")){
	clausula = clausula + " AND pe.idLoja= " + Integer.parseInt(idLoja);
}
clausula = clausula + " order by pe.dtPed ";
//seleciona todos os registros do banco de dados
List list;
dao = new PedidoEntradaItemDAO(conn);
list = dao.listarEntrada(clausula);

int cont = 0;
%>
<body onload="document.forms[0].elements[0].focus();" >

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr">
      <th class="grid" width="2%">&nbsp;</th>
      <th class="grid" width="3%"><center>Número Doc.</center></th>
      <th class="grid" width="2%"><center>Data de Entrada</center></th>
      <th class="grid" width="2%"><center>Quantidade</center></th>
      <th class="grid" width="2%"><center>Status</center></th>
    </tr>
<%
String dsStatus = "";
float total = 0;
//Utiliza o ResultSet para trazer os registros do banco de dados
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	EntradaProdutos entradaProd = (EntradaProdutos) it.next();
	cont++;
	if(entradaProd.getStatus().equalsIgnoreCase("A")){
    	dsStatus="Atendido";
    }if(entradaProd.getStatus().equalsIgnoreCase("P")){
    	dsStatus="Pendente";
    }else if(entradaProd.getStatus().equalsIgnoreCase("F")){
    	dsStatus = "Faturado";
    }else if(entradaProd.getStatus().equalsIgnoreCase("C")){
    	dsStatus="Cancelado";
    }
%>
    
   <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid" width="2%"><center><a target='_blank' href="compras.jsp?idPedidoEntrada=<%=entradaProd.getIdPedidoEntrada()%>&idLoja=<%=idLoja%>"><%=entradaProd.getNrDoc()%></a></center></td>
      <td class = "grid" width="2%"><center><font color="red"><b><%=ConverteDate.dateToString(entradaProd.getDataEntrada())%></b></font></center></td>
      <td class = "grid" width="2%"><center><b><%=Utilitaria.formatarNumero(entradaProd.getQuant(),2)%></b></center></td>
      <td class = "grid" width="2%"><center><b><%=dsStatus%></b></center></td>
  	</tr>
<%
if(entradaProd.getStatus().equalsIgnoreCase("A")){
  total+=entradaProd.getQuant();
}else if(entradaProd.getStatus().equalsIgnoreCase("F")){
	total+=entradaProd.getQuant();
}
}
%>
<tr>
  <td class = "grid" width="2%" colspan="4"><center><font color='red'><b>Total</b></font></center></td>
   <td class = "grid" width="2%"><center><font color='red'><b><%=Utilitaria.formatarNumero(total,2)%></b></font></center></td>
</tr>      
</table>
<%@include file="../fimConexao.jsp"%>