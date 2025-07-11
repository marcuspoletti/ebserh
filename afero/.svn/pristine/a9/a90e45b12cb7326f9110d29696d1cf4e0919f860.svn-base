<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.PedidoSaida" %>
<%@ page import="afero.model.MapaEntregaData" %>
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
String status =request.getParameter("status");
String clausula = "";
String horaIni = "00:00:00";
String horaFim = "23:59:59";
if(request.getParameter("horaIni") != null){
	horaIni = request.getParameter("horaIni");
}
if(request.getParameter("horaFim") != null){
	horaFim = request.getParameter("horaFim");
}
clausula = " WHERE ps.idEntrega <> 1 AND ps.status in ('P','A') AND ps.dtEntrega BETWEEN '"+converte.DMYToYMDI(dataIni)+" "+horaIni+"' AND '"+converte.DMYToYMDI(dataFim)+" "+horaFim+"'"; 
    
if(!idLoja.equalsIgnoreCase("0")){
	clausula = clausula + " AND ps.idLoja = " + Integer.parseInt(idLoja);
}

//seleciona todos os registros do banco de dados
List list;
dao = new PedidoSaidaDAO(conn);
clausula = clausula+" group by dtEntrega, hrEntrega ORDER BY ps.dtEntrega ";
list = dao.listarMapaEntragaData(clausula);

int cont = 0;
%>
<body onload="document.forms[0].elements[0].focus();" >

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr>
      <th class="grid" width="2%">&nbsp;</th>
      <th class="grid" width="3%"><center>Data de Entrega</center></th>
      <th class="grid" width="2%"><center>Hora de Entrega</center></th>
      <th class="grid" width="2%"><center>Quantidade</center></th>
    </tr>
<%

//Utiliza o ResultSet para trazer os registros do banco de dados
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	MapaEntregaData mapaEntregaData = (MapaEntregaData) it.next();
	cont++;
%>
    
   <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid" width="2%"><center><a href="frameMapaEntregaBairro.jsp?hrEntrega=<%=mapaEntregaData.getHrEntrega()%>&dataIni=<%=ConverteDate.dateToString(mapaEntregaData.getDataEntrega())%>&status=<%="P"%>&idLoja=<%=idLoja%>" target="frame_mapa_bairro" ><%=ConverteDate.dateToString(mapaEntregaData.getDataEntrega())%></a></center></td>
      <td class = "grid" width="2%"><center><font color="red"><b><%=mapaEntregaData.getHrEntrega()%></b></font></center></td>
      <td class = "grid" width="2%"><center><b><%=mapaEntregaData.getQuantidade()%></b></center></td>
  	</tr>
<%
}
%>      
</table>
<%@include file="../fimConexao.jsp"%>