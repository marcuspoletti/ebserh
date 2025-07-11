<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.PedidoSaida" %>
<%@ page import="afero.model.Orcamento" %>
<%@ page import="afero.model.Entidade" %>
<%@ page import="afero.util.Utilitaria" %>
<%@ page import="afero.persistence.OrcamentoDAO" %>
<%@ page import="afero.persistence.EntidadeDAO" %>
<%@ page import="afero.persistence.OrdemServicoDAO" %>
<%@ page import="afero.persistence.PedidoSaidaDAO" %>
<%@ page import="afero.persistence.PedidoSaidaSubDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Date" %>
<%@ page import="afero.util.ConverteDate" %>
<%@include file="../../seguranca.jsp"%>
<%@include file="../../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<%
String cdEntidade = request.getParameter("cdEntidade");
if(cdEntidade == null)cdEntidade = "0";
String idLojaUsuario = (String)session.getAttribute("idLoja");
PedidoSaidaDAO dao = null;
PedidoSaidaSubDAO daoSub = null;
String clausula = "";

clausula += "WHERE ps.cdEntidade = "+Integer.parseInt(cdEntidade)+" AND ps.tipoPedido='PZ' AND ps.operacao='S' AND ps.idLoja = "+Integer.parseInt(idLojaUsuario);

//seleciona todos os registros do banco de dados
List list;
dao = new PedidoSaidaDAO(conn);
clausula = clausula+" ORDER BY ps.dtPed desc limit 10";
list = dao.listarPedidoSaida(clausula);

%>
<h1 class="cabecalho_pagina">Listagem de Pedidos</h1>
<body onload="document.forms[0].elements[0].focus();" >
<form method="post" action="consultarPedidoSaida.jsp">
<hr>

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr>
      <th class="grid" width="2%">&nbsp;</th>
      <th class="grid" width="2%"><center>Núm. do Orç.</center></th>
      <th class="grid" width="2%"><center>Núm. do Ped.</center></th>
      <th class="grid" width="2%"><center>Data do Ped.</center></th>
      <th class="grid" width="2%"><center>Bobina</center></th>
      <th class="grid" width="5%"><center>Nome do Cliente</center></th>
      <th class="grid" width="5%"><center>Vl. Ped.</center></th>
      <th class="grid" width="2%">Status</th>
    </tr>
<%
int cont = 0;


//Utiliza o ResultSet para trazer os registros do banco de dados
String dsStatus = "";
String impressao = "";
int numOrcamento = 0;
float valorEntrega = 0;
for ( Iterator it = list.iterator();it.hasNext();) {
	PedidoSaida pedidoSaida = (PedidoSaida) it.next();;
	PedidoSaida pedSaida = dao.procurarPedidoSaida(pedidoSaida.getIdPedidoSaida());
	impressao = dao.statusImpressao(pedidoSaida.getIdPedidoSaida());
	numOrcamento = dao.getIdOrcamento(pedidoSaida.getIdPedidoSaida());
	EntidadeDAO daoEntidade = new EntidadeDAO(conn);
	Entidade entidade = null;
	entidade = daoEntidade.procurarEntidade(pedSaida.getCdEntidade());
	cont++;
	daoSub = new PedidoSaidaSubDAO(conn);
	valorEntrega = daoSub.mostrarVlFrete(pedidoSaida.getIdPedidoSaida());
	if(pedSaida.getStatus().equalsIgnoreCase("A")){
		dsStatus="Atendido";
	}else if(pedSaida.getStatus().equalsIgnoreCase("P")){
		dsStatus="Pendente";
	}else if(pedSaida.getStatus().equalsIgnoreCase("F")){
		dsStatus="Faturado";
	}else if(pedSaida.getStatus().equalsIgnoreCase("C")){
		dsStatus="Cancelado";
	}
	if(impressao.equalsIgnoreCase("S")){
		impressao="SIM";
		
	}else{
		impressao = "NÃO";
	}

%>
  
   <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <%if(numOrcamento == 0){ %>
      	<td class = "grid" width="2%"><font color="red"><center><%="PEDIDO"%></center></font></td>
      <%}else{ %>
      	 <td class = "grid" width="2%"><center><%=numOrcamento%></center></td>
      <%} %>
      <td class = "grid" width="2%"><center><a target="_blank" href="exibirPedido.jsp?idPedidoSaida=<%=pedSaida.getIdPedidoSaida()%>"><%=pedSaida.getIdPedidoSaida()%></a></center></td>
      <td class = "grid" width="5%"><center><%=ConverteDate.dateToString(pedSaida.getDtPed())%></center></td>
      <td class = "grid" width="2%"><center><a href="javaScript:void(window.open('impressaoBobina.jsp?idPedidoSaida=<%=pedSaida.getIdPedidoSaida()%>','endeavour','width=420,height=420,scrollbars=yes'));"><img border = "0" src="../images/imprimir.gif"></a></center></td>
      <td class = "grid" width="30%"><center><%=entidade.getNome()%></center></td>
      <td class = "grid" width="1%"><center><%=Utilitaria.formatarNumero(pedSaida.getVlPed()+valorEntrega,2)%></center></td>
      <td class = "grid" width="3%"><font color="red"><center><%=dsStatus%></center></font></td>
  	</tr>
<%
}
%>      
</table>
</form>
<%@include file="../../fimConexao.jsp"%>