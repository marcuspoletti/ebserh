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
<script src="../js/common.js"/></script>

<script>

function recarregar(id) {
	  document.forms[0].action="frameMapaPedido.jsp?idPedidoSaida="+id;
	  document.forms[0].submit();
}

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
String idPedidoSaida = request.getParameter("idPedidoSaida");
if(idPedidoSaida == null)idPedidoSaida="0";
ConverteDate converte = new ConverteDate();
PedidoSaidaDAO dao = null;
String nomeEntidade = request.getParameter("nomeEntidade");
String acao = request.getParameter("acao");
String dataIni = request.getParameter("dataIni");
String status =request.getParameter("status");
String dsEntrega = request.getParameter("dsEntrega");
String hrEntrega = request.getParameter("hrEntrega");
String clausula = "";
String idMotorista = request.getParameter("idMotorista_"+idPedidoSaida);
if(idMotorista == null)idMotorista="0";
String idEntregador = request.getParameter("idEntregador_"+idPedidoSaida);
if(idEntregador == null)idEntregador="0";



clausula = " WHERE ps.idEntrega<>1 AND ps.status in ('P','A') AND ps.dtEntrega='"+converte.DMYToYMDI(dataIni)+"' AND ps.hrEntrega='"+hrEntrega+"' AND en.dsEntrega='"+dsEntrega+"'";
    
if(!idLoja.equalsIgnoreCase("0")){
	clausula = clausula + " AND ps.idLoja = " + Integer.parseInt(idLoja);
}

//seleciona todos os registros do banco de dados
List list;
dao = new PedidoSaidaDAO(conn);
//ATUALIZAÇÂO DO MOTORISTA
if(!idMotorista.equalsIgnoreCase("0")){
	if(!idPedidoSaida.equalsIgnoreCase("0")){
		dao.atualizarMotorista(Integer.parseInt(idPedidoSaida), Integer.parseInt(idMotorista));
	}
}else if(!idPedidoSaida.equalsIgnoreCase("0")){
	dao.atualizarMotoristaNull(Integer.parseInt(idPedidoSaida));
}
//ATUALIZAÇÃO DO ENTREGADOR
if(!idEntregador.equalsIgnoreCase("0")){
	if(!idPedidoSaida.equalsIgnoreCase("0")){
		dao.atualizarEntregador(Integer.parseInt(idPedidoSaida), Integer.parseInt(idEntregador));
	}
}else if(!idPedidoSaida.equalsIgnoreCase("0")){
	dao.atualizarEntregadorNull(Integer.parseInt(idPedidoSaida));
}
clausula = clausula+" ORDER BY ps.dtPed desc";
list = dao.listarPedidoSaidaMapaPedido(clausula);

int cont = 0;
%>
<body onload="document.forms[0].elements[0].focus();" >
<form action="frameMapaPedido.jsp" method="post">
<input type="hidden" name="idLoja" value="<%=idLoja%>"/>
<input type="hidden" name="nomeEntidade" value="<%=nomeEntidade%>"/>
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="dataIni" value="<%=dataIni%>"/>
<input type="hidden" name="status" value="<%=status%>"/>
<input type="hidden" name="dsEntrega" value="<%=dsEntrega%>"/>
<input type="hidden" name="hrEntrega" value="<%=hrEntrega%>"/>
<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr>
      <th class="grid" width="2%">&nbsp;</th>
      <th class="grid" width="2%"><center>Número do Orçamento</center></th>
      <th class="grid" width="2%"><center>Pedido</center></th>
      <th class="grid" width="5%"><center>Nome do Cliente</center></th>
      <th class="grid" width="5%"><center>Valor R$</center></th>
      <th class="grid" width="2%">Status</th>
      <th class="grid" width="5%"><center>Motorista</center></th>
      <th class="grid" width="5%"><center>Entregador</center></th>
    </tr>
<%
int numOrcamento = 0;
String dsStatus = "";
double valorTotal = 0.0;
//Utiliza o ResultSet para trazer os registros do banco de dados
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	PedidoSaida pedidoSaida = (PedidoSaida) it.next();;
	PedidoSaida pedSaida = dao.procurarPedidoSaida(pedidoSaida.getIdPedidoSaida());
	numOrcamento = dao.getIdOrcamento(pedidoSaida.getIdPedidoSaida());
	EntidadeDAO daoEntidade = new EntidadeDAO(conn);
	Entrega entrega = new Entrega();
	EntregaDAO daoEntrega = new EntregaDAO(conn);
	entrega = daoEntrega.procurarEntrega(pedSaida.getIdEntrega());
	Entidade entidade = null;
	entidade = daoEntidade.procurarEntidade(pedSaida.getCdEntidade());
	cont++;
	if(pedSaida.getStatus().equalsIgnoreCase("A")){
		dsStatus="Atendido";
	}else if(pedSaida.getStatus().equalsIgnoreCase("P")){
		dsStatus="Pendente";
	}else if(pedSaida.getStatus().equalsIgnoreCase("F")){
		dsStatus="Faturado";
	}else if(pedSaida.getStatus().equalsIgnoreCase("C")){
		dsStatus="Cancelado";
	}
	pedSaida.setIdMotorista(dao.getIdMotorista(pedSaida.getIdPedidoSaida()));
	pedSaida.setIdEntregador(dao.getIdEntregador(pedSaida.getIdPedidoSaida()));
    valorTotal = valorTotal + (pedSaida.getVlPed()+entrega.getTxEntrega());
%>
    
   <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <%if(numOrcamento == 0){ %>
      	<td class = "grid" width="2%"><font color="red"><center><%="PEDIDO"%></center></font></td>
      <%}else{ %>
      	 <td class = "grid" width="2%"><center><%=numOrcamento%></center></td>
      <%} %>
      <td class = "grid" width="2%"><center><%=pedSaida.getIdPedidoSaida()%></center></td>
      <td class = "grid" width="30%"><center><%=entidade.getNome()%></center></td>
      <td class = "grid" width="5%"><center><%=Utilitaria.formatarNumero(pedSaida.getVlPed()+entrega.getTxEntrega(),2)%></center></td>
      <td class = "grid" width="3%"><font color="red"><center><%=dsStatus%></center></font></td>
      <td><select name="idMotorista_<%=pedSaida.getIdPedidoSaida()%>" onchange="recarregar('<%=pedSaida.getIdPedidoSaida() %>');">
	 <option value='0'>Selecione...</option>
	<%@include file="../WEB-INF/jspf/combo/comboMotorista.jspf" %></select>
	<script>comboSelect(document.forms[0].idMotorista_<%=pedSaida.getIdPedidoSaida()%>, '<%=pedSaida.getIdMotorista()%>');</script>
      </td>
       <td><select name="idEntregador_<%=pedSaida.getIdPedidoSaida()%>" onchange="recarregar('<%=pedSaida.getIdPedidoSaida() %>');">
	 <option value='0'>Selecione...</option>
	<%@include file="../WEB-INF/jspf/combo/comboEntregador.jspf" %></select>
	<script>comboSelect(document.forms[0].idEntregador_<%=pedSaida.getIdPedidoSaida()%>, '<%=pedSaida.getIdEntregador()%>');</script>
      </td>
      <input type="hidden" name="idPedidoSaida" value="<%=pedSaida.getIdPedidoSaida()%>"/>  		 
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
</form>
<%@include file="../fimConexao.jsp"%>