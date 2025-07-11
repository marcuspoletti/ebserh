<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.PedidosItens" %>
<%@ page import="afero.model.RelatorioAglutinados" %>
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
	clausula += " AND ps.status <> 'C' AND ps.idLoja = " + Integer.parseInt(idLoja)+" AND p.idDivisao = "+Integer.parseInt(idDivisao);
}

//seleciona todos os registros do banco de dados
List list;
dao = new PedidoItensDAO(conn);
clausula += " GROUP BY psi.idProduto ";
clausula += " ORDER BY psi.quant desc ";
list = dao.listarPedidoItensAgulinados(clausula);

int cont = 0;
%>
<body onload="document.forms[0].elements[0].focus();" >

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr>
      <th class="grid" width="2%">&nbsp;</th>
      <th class="grid" width="5%"><center>Produto</center></th>
      <th class="grid" width="2%">Quant</th>
      <th class="grid" width="5%"><center>Cód.Produto</center></th>
      <th class="grid" width="5%"><center>Cód.Barra</center></th>
      <th class="grid" width="5%"><center>Status</center></th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
String statusProduto = "";
float totalQuant = 0;
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	RelatorioAglutinados relatorioAglutinados = (RelatorioAglutinados) it.next();
	if(relatorioAglutinados.getStatus().equalsIgnoreCase("A")){
		statusProduto = "Ativo";	
	}else{
		statusProduto = "Inativo";	
	}
	cont++;
	totalQuant += relatorioAglutinados.getQuant();
%>
    
   <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid" width="5%"><center><%=relatorioAglutinados.getDsProduto()%></center></td>
      <td class = "grid" width="5%"><center><%=Utilitaria.formatarNumero(relatorioAglutinados.getQuant(), 2)%></center></td>
      <%if(relatorioAglutinados.getCdProduto()== null){ %>
      	<td class = "grid" width="5%"><center><%=" - "%></center></td>
      <%}else{ %>
      	<td class = "grid" width="5%"><center><%=relatorioAglutinados.getCdProduto()%></center></td>
      <%} %>
      <td class = "grid" width="5%"><center><%=relatorioAglutinados.getCdBarra()%></center></td>
      <td class = "grid" width="5%"><center><%=statusProduto%></center></td>
      
  </tr>
<%
}
%>      
</table>
<hr>
<table>
 <tr>
      <th class="grid" width="20%">Total de Quant.:</th>
      <td class="grid" width="15%"><center><%=Utilitaria.formatarNumero(totalQuant,0)%></center></td>
      </tr>
</table>
<%@include file="../fimConexao.jsp"%>