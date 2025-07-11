<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.VendasGrupoCondicaoPagamento" %>
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
String idGrupo = request.getParameter("idGrupo");
if(idGrupo == null)idGrupo = "0";
String idLoja = request.getParameter("idLoja");
ConverteDate converte = new ConverteDate();
PedidoSaidaDAO dao = null;
String acao = request.getParameter("acao");
String dataIni = request.getParameter("dataIni");
String dataFim = request.getParameter("dataFim");
//HORA
String horaIni = "00:00:00";
String horaFim = "23:59:59";
if(request.getParameter("horaIni") != null){
	horaIni = request.getParameter("horaIni");
}
if(request.getParameter("horaFim") != null){
	horaFim = request.getParameter("horaFim");
}
//
String clausula = "";

clausula = " WHERE ps.tipoPedido in ('R') AND ps.status='A' AND ps.tipoPedido is not null AND ps.dtPag BETWEEN '"+converte.DMYToYMDI(dataIni)+" "+horaIni+"' AND '"+converte.DMYToYMDI(dataFim)+" "+horaFim+"'"; 
    
if(!idLoja.equalsIgnoreCase("0")){
	clausula = clausula + " AND ps.idLoja = " + Integer.parseInt(idLoja);
}
if(!idGrupo.equalsIgnoreCase("0")){
	clausula += " AND g.idGrupo = " + Integer.parseInt(idGrupo);
}

//seleciona todos os registros do banco de dados
List list;
dao = new PedidoSaidaDAO(conn);
clausula = clausula + " GROUP BY ps.cdCondPagto";
list = dao.vendasGruposCondicaoPagamento(clausula);

int cont = 0;
%>
<body onload="document.forms[0].elements[0].focus();" >

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr>
      <th class="grid" width="2%">&nbsp;</th>
      <th class="grid" width="10%"><center>Condição Pagamento</center></th>
      <th class="grid" width="2%"><center>Valor R$</center></th>
    </tr>
<%
float valorTotal = 0;


//Utiliza o ResultSet para trazer os registros do banco de dados
for ( Iterator it = list.iterator(); it.hasNext(); ) {
    VendasGrupoCondicaoPagamento vendas = (VendasGrupoCondicaoPagamento)it.next();
    valorTotal += vendas.getValorCondicaoPagamento();
    cont++;
    
%>
    
   <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid" width="10%"><center><%=vendas.getDsCondicaoPagamento()%></center></td>
      <td class = "grid" width="2%"><center><%=Utilitaria.formatarNumero(vendas.getValorCondicaoPagamento(),2)%></center></td>
  </tr>
<%
}
%>      
</table>
<table border="0" width="100%">
<tr>
<th class="grid"><center>Valor Total (R$)</center></th>
<td class="grid"><center><font color="red"><b><%=Utilitaria.formatarNumero(valorTotal,2)%></b></font></center></td>
</tr>
</table>
<%@include file="../fimConexao.jsp"%>