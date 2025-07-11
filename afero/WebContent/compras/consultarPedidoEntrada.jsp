<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.PedidoSaida" %>
<%@ page import="afero.model.PedidoEntrada" %>
<%@ page import="afero.model.Orcamento" %>
<%@ page import="afero.model.Entidade" %>
<%@ page import="afero.persistence.OrcamentoDAO" %>
<%@ page import="afero.persistence.EntidadeDAO" %>
<%@ page import="afero.persistence.OrdemServicoDAO" %>
<%@ page import="afero.persistence.PedidoSaidaDAO" %>
<%@ page import="afero.persistence.PedidoEntradaDAO" %>
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
  document.all.numDoc.value='';
  document.forms[0].submit();
}  
</script>

<%
PedidoSaidaDAO daoPedidoSaida = new PedidoSaidaDAO(conn);
ConverteDate converte = new ConverteDate();
String dataIni = request.getParameter("dataIni");
String dataFim = request.getParameter("dataFim");
String idLojaUsuario = (String)session.getAttribute("idLoja");
PedidoEntradaDAO dao = null;
String status = request.getParameter("status");
if(status == null)status = "";
String nomeEntidade = request.getParameter("nomeEntidade");
String acao = request.getParameter("acao");
if(acao == null)acao="listar";
String clausula = "";
int numDoc;
if (dataIni == null) {
	   dataIni = daoPedidoSaida.dataAtualPedido();
	  }
	  if (dataFim == null) {
	    dataFim = daoPedidoSaida.dataAtualPedido();
	  }
if(request.getParameter("numDoc") == null || request.getParameter("numDoc") == ""){
	numDoc = 0;
}else{
	numDoc = Integer.parseInt(request.getParameter("numDoc"));
}
 if (!acao.equalsIgnoreCase("voltar")) {
	 nomeEntidade = request.getParameter("nomeEntidade");
	 if(nomeEntidade == null) nomeEntidade = "";
    status = request.getParameter("status");
    if (status == null) status = "";
  }

  if (nomeEntidade!= null) {
    clausula = " WHERE pe.dtPed BETWEEN '"+converte.DMYToYMDI(dataIni)+" 00:00:00' AND '"+converte.DMYToYMDI(dataFim)+" 23:59:59' AND e.nome LIKE '"+nomeEntidade+"%'";
  } 
  if (!status.isEmpty()) {
    if (clausula.isEmpty()) {
      clausula = " WHERE pe.dtPed BETWEEN '"+converte.DMYToYMDI(dataIni)+" 00:00:00' AND '"+converte.DMYToYMDI(dataFim)+" 23:59:59' AND pe.status='"+status+"'";
    } else {
      clausula = clausula+" AND pe.dtPed BETWEEN '"+converte.DMYToYMDI(dataIni)+" 00:00:00' AND '"+converte.DMYToYMDI(dataFim)+" 23:59:59' AND pe.status='"+status+"'";
    }
  }
  if(numDoc!= 0){ 
	  clausula = clausula+" AND pe.dtPed BETWEEN '"+converte.DMYToYMDI(dataIni)+" 00:00:00' AND '"+converte.DMYToYMDI(dataFim)+" 23:59:59' AND pe.nrDoc = "+numDoc;
  }

  clausula = clausula+" AND pe.idLoja = "+Integer.parseInt(idLojaUsuario);
//seleciona todos os registros do banco de dados
List list;
dao = new PedidoEntradaDAO(conn);
clausula = clausula+" ORDER BY pe.dtPed desc";
list = dao.listarPedidoEntrada(clausula);
%>
<h1 class="cabecalho_pagina">Consulta de Compras</h1>
<body onload="document.forms[0].elements[0].focus();" >
<iframe width=174 height=189 name="gToday:normal:"../js/calendar/agenda.js"
            id="gToday:normal:"../js/calendar/agenda.js" src="../js/calendar/ipopeng.htm"
            scrolling="no" frameborder="0" style="visibility:visible; z-index:999; 
    position:absolute; top:-500px; left:-500px;">
</iframe>
<form method="post" action="consultarPedidoEntrada.jsp">
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
    <th class='label'>Número do Doc.</th>
    <td><input type="text" name="numDoc" <%if (numDoc != 0) { %>value="<%=numDoc%>"<% }%>  size="20" maxlength="20"></td>
  </tr>
  <tr>
    <th class='label'>Distrib. / Fornecedor</th>
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
      <th class="grid" width="2%"><center>Número do Documento</center></th>
      <th class="grid" width="3%"><center>Ordem de Serviço</center></th>
      <th class="grid" width="3%"><center>Data do Ped.Compra</center></th>
      <th class="grid" width="5%"><center>Nome do Cliente</center></th>
      <th class="grid" width="3%"><center>Data da Emissão</center></th>
      <th class="grid" width="2%">Editar</th>
      <th class="grid" width="2%">Imprimir</th>
      <th class="grid" width="2%">Status</th>
      <th class="grid" width="3%">Contas a Pagar</th>
    </tr>
<%
int cont = 0;
int gridSize = 15;
String rowNumStr = request.getParameter("rowNum");
int rowNum = (rowNumStr == null ? 0: Integer.parseInt(rowNumStr));
if (rowNum < 0) rowNum = 0;
boolean hasNext = false;
int rowCount = list.size();
int rowLast = 0;
if (rowCount > 0) {
  if (rowCount > gridSize) {
    rowLast = rowNum+gridSize+1; 
    if (rowLast >= rowCount && rowCount > 0) rowLast = rowCount;
    if (rowNum > rowLast) rowNum = 0;
    list = list.subList(rowNum, rowLast);
  }
  hasNext = true;
}
String numDocumento = "";
//Utiliza o ResultSet para trazer os registros do banco de dados
String dsStatus = "";
String dsOrdemServico = "";
for ( Iterator it = list.iterator(); hasNext && cont < gridSize; hasNext = it.hasNext() ) {
	PedidoEntrada pedidoEntrada = (PedidoEntrada) it.next();;
	PedidoEntrada pedEntrada = dao.procurarPedidoEntrada(pedidoEntrada.getIdPedidoEntrada());
	numDocumento = pedEntrada.getNrDoc();
	EntidadeDAO daoEntidade = new EntidadeDAO(conn);
	Entidade entidade = null;
	entidade = daoEntidade.procurarEntidade(pedEntrada.getCdEntidade());
	if(pedEntrada.getIdOrdemServico() > 0){
		dsOrdemServico = String.valueOf(pedEntrada.getIdOrdemServico());
	}else{
		dsOrdemServico = "COMPRA";
	}
	cont++;
    if(pedEntrada.getStatus().equalsIgnoreCase("A")){
    	dsStatus="Atendido";
    }if(pedEntrada.getStatus().equalsIgnoreCase("P")){
    	dsStatus="Pendente";
    }else if(pedEntrada.getStatus().equalsIgnoreCase("F")){
    	dsStatus = "Faturado";
    }else if(pedEntrada.getStatus().equalsIgnoreCase("C")){
    	dsStatus="Cancelado";
    }
%>
  
   <tr>
      <td class = "grid" width="2%"><center><%=rowNum+cont%></center></td>
      <td class = "grid" width="2%"><center><a target="_blank" href="compras.jsp?idPedidoEntrada=<%=pedEntrada.getIdPedidoEntrada()%>"><%=numDocumento%></a></center></td>
       <td class = "grid" width="2%"><font color="red"><center><%= dsOrdemServico%></center></font></td>
       <td class = "grid" width="5%"><center><%=ConverteDate.dateToString(pedEntrada.getDtPed())%></center></td>
      <td class = "grid" width="30%"><center><%=entidade.getNome()%></center></td>
      <td class = "grid" width="5%"><center><%=ConverteDate.dateToString(pedEntrada.getDtEmissao())%></center></td>
      <%if(!pedEntrada.getStatus().equalsIgnoreCase("A")){%>
      	<td class = "grid" width="2%"><a target="_blank" href="editarFormCompras.jsp?idPedidoEntrada=<%=pedEntrada.getIdPedidoEntrada()%>"><img border="0"src="../images/edit.gif"></a></img></td>
      <%}else{%>
        <td class = "grid" width="2%">-</td>
      <%} %>
      <td class = "grid" width="2%"><center><a target="_blank" href="impCompras.jsp?idPedidoEntrada=<%=pedEntrada.getIdPedidoEntrada()%>"><img border = "0" src="../images/imprimir.gif"></a></center></td>
      <td class = "grid" width="3%"><font color="red"><center><%=dsStatus%></center></font></td>
      <%if(!pedEntrada.getStatus().equalsIgnoreCase("A")){%>
      	<td class = "grid" width="3%"><center><a target="_blank" href="../financeiro/listarDuplicataPagar.jsp"><img border = "0" src="../images/ficha.gif"></a></center></td>
      <%}else{%>
        <td class = "grid" width="2%">-</td>
      <%} %>
  	</tr>
<%
}
%>      
</table>
</form>
<%  if (rowNum != 0 || hasNext) { %>
        <center>
<%      if (rowNum != 0) { %>
<a class="link" href="consultarPedidoEntrada.jsp?rowNum=<%=0%>&nomeEntidade=<%=nomeEntidade%>&status=<%=status%>">Primeira</a>&nbsp&nbsp
|&nbsp&nbsp<a class="link" href="consultarPedidoEntrada.jsp?rowNum=<%=rowNum-gridSize%>&nomeEntidade=<%=nomeEntidade%>&status=<%=status%>">< Anterior</a>&nbsp&nbsp
<%      } else { %>
Primeira&nbsp&nbsp|&nbsp&nbsp< Anterior&nbsp
<%      } %>
<%      if (hasNext) { %>
|&nbsp&nbsp<a class="link" href="consultarPedidoEntrada.jsp?rowNum=<%=rowNum+gridSize%>&nomeEntidade=<%=nomeEntidade%>&status=<%=status%>">Próxima ></a>&nbsp&nbsp
|&nbsp&nbsp<a class="link" href="consultarPedidoEntrada.jsp?rowNum=<%=rowCount-gridSize%>&nomeEntidade=<%=nomeEntidade%>&status=<%=status%>">Última</a>
<%      } else { %>
|&nbsp&nbsp Próxima >&nbsp&nbsp|&nbsp&nbspÚltima
<%      } %>
        </center>
<%  } %>
<%@include file="../fimConexao.jsp"%>