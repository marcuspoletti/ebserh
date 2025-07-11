<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.PedidoSaida" %>
<%@ page import="afero.model.Orcamento" %>
<%@ page import="afero.model.Entidade" %>
<%@ page import="afero.persistence.OrcamentoDAO" %>
<%@ page import="afero.persistence.EntidadeDAO" %>
<%@ page import="afero.persistence.OrdemServicoDAO" %>
<%@ page import="afero.persistence.PedidoSaidaDAO" %>
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
  document.all.numPedido.value = '';
  document.forms[0].submit();
}  
</script>

<%
PedidoSaidaDAO daoPedidoSaida = new PedidoSaidaDAO(conn);
ConverteDate converte = new ConverteDate();
String idLojaUsuario = (String)session.getAttribute("idLoja");
PedidoSaidaDAO dao = null;
String dataIni = request.getParameter("dataIni");
String dataFim = request.getParameter("dataFim");
String status = request.getParameter("status");
if(status == null)status = "";
String nomeEntidade = request.getParameter("nomeEntidade");
String acao = request.getParameter("acao");
if(acao == null)acao="listar";
int numPedido;
if (dataIni == null) {
	   dataIni = daoPedidoSaida.dataAtualPedido();
    }
if (dataFim == null) {
	    dataFim = daoPedidoSaida.dataAtualPedido();
}
if(request.getParameter("numPedido") == null || request.getParameter("numPedido") == ""){
	numPedido = 0;
}else{
	numPedido = Integer.parseInt(request.getParameter("numPedido"));
}
String clausula = "";
 if (!acao.equalsIgnoreCase("voltar")) {
	 nomeEntidade = request.getParameter("nomeEntidade");
    status = request.getParameter("status");
    if (status == null) status = "";
  }

  if (nomeEntidade!= null) {
    clausula = " WHERE e.nome LIKE '"+nomeEntidade+"%'";
  } 
  if (!status.isEmpty()) {
    if (clausula.isEmpty()) {
      clausula = " WHERE ps.status='"+status+"'";
    } else {
      clausula = clausula+" AND ps.status='"+status+"'";
    }
  }
  if(numPedido!= 0){ 
		 clausula = clausula+" AND ps.idPedidoSaida = "+numPedido;
	 }
  clausula = clausula+" AND ps.dtPed BETWEEN '"+converte.DMYToYMDI(dataIni)+" 00:00:00' AND '"+converte.DMYToYMDI(dataFim)+" 23:59:59' AND ps.operacao='T' AND ps.idLoja = "+Integer.parseInt(idLojaUsuario);
//seleciona todos os registros do banco de dados
List list;
dao = new PedidoSaidaDAO(conn);
clausula = clausula+" ORDER BY ps.dtPed desc";
list = dao.listarPedidoSaida(clausula);

int cont = 0;
%>
<h1 class="cabecalho_pagina">Consulta de Movimentação de Saída</h1>
<body onload="document.forms[0].elements[0].focus();" >
<form method="post" action="consultarPedidoSaida.jsp">
<iframe width=174 height=189 name="gToday:normal:"../js/calendar/agenda.js"
            id="gToday:normal:"../js/calendar/agenda.js" src="../js/calendar/ipopeng.htm"
            scrolling="no" frameborder="0" style="visibility:visible; z-index:999; 
    position:absolute; top:-500px; left:-500px;">
</iframe>
<table border="0" width="100%">
    <tr>
      <td class='grid'>Data Inicial 
	<input type="text" name="dataIni" size="15" value="<%= dataIni %>" onblur="chkData(this,'dd/MM/yyyy')" maxlength="10" class="inputs"><a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dataIni);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
      </td>
      <td class='grid'>Data Final 
	<input type="text"  name="dataFim" size="15" value="<%= dataFim %>" maxlength="10" onblur="chkData(this,'dd/MM/yyyy')" class="inputs"><a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dataFim);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
      </td>
</tr>
</table>
<table colspan="2">
  <tr>
    <th class='label'>Número do Pedido</th>
    <td><input type="text" name="numPedido" <%if (numPedido != 0) { %>value="<%=numPedido%>"<% }%>  size="20" maxlength="20"></td>
  </tr>
  <tr>
    <th class='label'>Nome do Cliente</th>
    <td><input type="text" name="nomeEntidade" <%if (nomeEntidade != null) { %>value="<%=nomeEntidade %>"<% }%>  size="40" maxlength="40"></td>
    <td><input class="button" type="button" value="Localizar" onClick="javascript: localizar();" /></td>
    <td><input class="button" type="button" value="Nova pesquisa" onClick="javascript: novaPesquisa();" /></td>
  </tr>
  <tr>
    <th class="label" colspan="1">Status</th>
    <td class="label_radio">
      <input type="radio" class="radio" name="status" value="" <%= (status.equals("")? "checked": "") %>>Todos
      <input type="radio" class="radio" name="status" value="P" <%= (status.equals("P")? "checked": "") %>>Pendente
      <input type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Atendido
      <input type="radio" class="radio" name="status" value="C" <%= (status.equals("C")? "checked": "") %>>Cancelado
    </td>
  </tr>
</table>
<hr>

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr">
      <th class="grid" width="2%">&nbsp;</th>
      <th class="grid" width="2%"><center>Núm. do Orçamento</center></th>
      <th class="grid" width="2%"><center>Núm. do Pedido</center></th>
      <th class="grid" width="2%"><center>Data do Ped. Saída</center></th>
      <th class="grid" width="5%"><center>Nome do Cliente</center></th>
      <th class="grid" width="2%"><center>Imprimir</center></th>
      <th class="grid" width="2%">Editar</th>
      <th class="grid" width="2%">Status</th>
    </tr>
<%
int numOrcamento = 0;
String dsStatus = "";
//Utiliza o ResultSet para trazer os registros do banco de dados
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	PedidoSaida pedidoSaida = (PedidoSaida) it.next();;
	PedidoSaida pedSaida = dao.procurarPedidoSaida(pedidoSaida.getIdPedidoSaida());
	numOrcamento = dao.getIdOrcamento(pedidoSaida.getIdPedidoSaida());
	EntidadeDAO daoEntidade = new EntidadeDAO(conn);
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

%>
  
   <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <%if(numOrcamento == 0){ %>
      	<td class = "grid" width="2%"><font color="red"><center><%="PEDIDO"%></center></font></td>
      <%}else{ %>
      	 <td class = "grid" width="2%"><center><%=numOrcamento%></center></td>
      <%} %>
      <td class = "grid" width="2%"><center><a target="_blank" href="exibirPedidoSaida.jsp?idPedidoSaida=<%=pedSaida.getIdPedidoSaida()%>"><%=pedSaida.getIdPedidoSaida()%></a></center></td>
      <td class = "grid" width="5%"><center><%=ConverteDate.dateToString(pedSaida.getDtPed())%></center></td>
      <td class = "grid" width="30%"><center><%=entidade.getNome()%></center></td>
      <%if(pedSaida.getStatus().equalsIgnoreCase("A") || pedSaida.getStatus().equalsIgnoreCase("P")){%>
        	<td class = "grid" width="2%"><center><a target="_blank" href="impPedidoSaida.jsp?idPedidoSaida=<%=pedSaida.getIdPedidoSaida()%>"><img border = "0" src="../images/imprimir.gif"></a></center></td>
      <%}else{ %>
           <td class = "grid" width="2%"><center>-</center></td>
      <%} %>
      <%if(pedSaida.getStatus().equalsIgnoreCase("A")){ %>
      <td class = "grid" width="2%"><center>-</center></td>
      <%}else{ %>
       <td class = "grid" width="2%"><a target="_blank" href="editarFormPedidoSaida.jsp?idPedidoSaida=<%=pedSaida.getIdPedidoSaida()%>&acao=<%="atu"%>"><img border="0"src="../images/edit.gif"></a></img></td>
      <%}%>
      <td class = "grid" width="3%"><font color="red"><center><%=dsStatus%></center></font></td>
  	</tr>
<%
}
%>      
</table>
</form>
<%@include file="../fimConexao.jsp"%>