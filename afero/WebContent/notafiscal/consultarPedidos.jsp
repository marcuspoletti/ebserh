<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.PedidoSaida" %>
<%@ page import="afero.model.Orcamento" %>
<%@ page import="afero.model.Entidade" %>
<%@ page import="afero.persistence.OrcamentoDAO" %>
<%@ page import="afero.persistence.EntidadeDAO" %>
<%@ page import="afero.persistence.OrdemServicoDAO" %>
<%@ page import="afero.persistence.PedidoSaidaDAO" %>
<%@ page import="afero.util.ConverteDate" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Date" %>
<%@ page import="afero.util.ConverteDate" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/></script>

<script>
function selecionar_tudo(){ 
	   for (i=0;i<document.form1.elements.length;i++) 
	      if(document.form1.elements[i].type == "checkbox")	
	         document.form1.elements[i].checked=1 
} 
function deselecionar_tudo(){ 
	   for (i=0;i<document.form1.elements.length;i++) 
	      if(document.form1.elements[i].type == "checkbox")	
	         document.form1.elements[i].checked=0 
} 


function salvar() {
   document.form1.action="consultarPedidos.jsp?acao=gravar";
   document.form1.submit();
	  
}
function abrirPopup(URL) {

	  var width = 420;
	  var height = 420;

	  var left = 0;
	  var top = 0;

	  window.open(URL,'janela', 'width='+width+', height='+height+', top='+top+', left='+left+', scrollbars=yes, status=no, toolbar=no, location=no, directories=no, menubar=no, resizable=no, fullscreen=no');

}
function localizar() {
  document.form1.submit();
}  

function novaPesquisa() {
  document.all.idPedidoLocalizar.value = '';
  document.all.nomeLocalizar.value = '';
  document.all.statusLocalizar.value = ''; //não está limpando
  document.form1.submit();
}  
</script>

<%

String idUsuario = (String) session.getAttribute("idUsuario");
String idLojaUsuario = (String)session.getAttribute("idLoja");
PedidoSaidaDAO dao = null;
int idPedidoLocalizar;
if(request.getParameter("idPedidoLocalizar") == null || request.getParameter("idPedidoLocalizar") == ""){
	idPedidoLocalizar = 0;
} else {
	idPedidoLocalizar = Integer.parseInt(request.getParameter("idPedidoLocalizar"));
}
String nomeLocalizar = request.getParameter("nomeLocalizar");
if(nomeLocalizar == null) nomeLocalizar = "";
String statusLocalizar = request.getParameter("statusLocalizar");
String tipoPedidoLocalizar = request.getParameter("tipoPedidoLocalizar");
if(tipoPedidoLocalizar == null)tipoPedidoLocalizar="P";
if(statusLocalizar == null) statusLocalizar = "";
String acao = request.getParameter("acao");
if(acao == null) acao="listar";
String clausula = "";
if(acao.equalsIgnoreCase("gravar")){
	String[] idPedido = request.getParameterValues("pedido");
	for(int I=0;I<idPedido.length;I++){
		  if(request.getParameter("idPedido_"+idPedido[I])!= null){
			  PedidoSaidaDAO daoPedidoSaidaIntegracao = new PedidoSaidaDAO(conn);
			  daoPedidoSaidaIntegracao.atualizarIntegracao(Integer.parseInt(idPedido[I]));
		  }
	}
	acao="listar";
}
if (nomeLocalizar!= null) {
  clausula = " WHERE e.nome LIKE '"+nomeLocalizar+"%'";
} 
if (!statusLocalizar.isEmpty()) {
  if (clausula.isEmpty()) {
    clausula = " WHERE ps.status='"+statusLocalizar+"'";
  } else {
    clausula = clausula+" AND ps.status='"+statusLocalizar+"'";
  }
}
if(idPedidoLocalizar!= 0) { 
  clausula = clausula+" AND  ps.idPedidoSaida = "+idPedidoLocalizar;
}

clausula = clausula+" AND ps.tipoPedido = '"+tipoPedidoLocalizar+"'"+" AND ps.operacao='S' AND ps.idLoja = "+Integer.parseInt(idLojaUsuario);

//seleciona todos os registros do banco de dados
List list;
dao = new PedidoSaidaDAO(conn);
ConverteDate converte = new ConverteDate();
String dtPedidoIni = request.getParameter("dtPedidoIni");
String dtPedidoFim = request.getParameter("dtPedidoFim");
if (dtPedidoIni == null) {
	dtPedidoIni = dao.dataAtualPedido();
}
if (dtPedidoFim == null) {
	dtPedidoFim = dao.dataAtualPedido();
}
clausula = clausula+ " AND ps.dtPed BETWEEN '"+converte.DMYToYMDI(dtPedidoIni)+" 00:00:00' AND '"+converte.DMYToYMDI(dtPedidoFim)+" 23:59:59'";
clausula = clausula+" ORDER BY ps.dtPed desc";
list = dao.listarPedidoSaida(clausula);

%>
<h1 class="cabecalho_pagina">Consulta de Vendas</h1>
<body onload="document.forms[0].elements[0].focus();" >
<form name="form1" method="post" action="consultarPedidos.jsp">
<iframe width=174 height=189 name="gToday:normal:"../js/calendar/agenda.js"
            id="gToday:normal:"../js/calendar/agenda.js" src="../js/calendar/ipopeng.htm"
            scrolling="no" frameborder="0" style="visibility:visible; z-index:999; 
    position:absolute; top:-500px; left:-500px;">
    </iframe>
<table colspan="2">
  <tr>
    <th class='label'>Número do Pedido</th>
    <td><input type="text" name="idPedidoLocalizar" <%if (idPedidoLocalizar != 0) { %>value="<%=idPedidoLocalizar%>"<% }%>  size="20" maxlength="20"></td>
  </tr>
  <tr>
    <th class='label'>Nome do Cliente</th>
    <td><input type="text" name="nomeLocalizar" <%if (nomeLocalizar != null) { %>value="<%=nomeLocalizar %>"<% }%>  size="40" maxlength="40" style="width: 403px"></td>
    <td><input class="button" type="button" value="Localizar" onClick="javascript: localizar();" /></td>
    <td><input class="button" type="button" value="Nova pesquisa" onClick="javascript: novaPesquisa();" /></td>
  </tr>
  <tr>
    <th class="label" colspan="1">Status</th>
    <td class="label_radio">
      <input type="radio" class="radio" name="statusLocalizar" value="" <%= (statusLocalizar.equals("")? "checked": "") %>>Todos
      <input type="radio" class="radio" name="statusLocalizar" value="P" <%= (statusLocalizar.equals("P")? "checked": "") %>>Pendente
      <input type="radio" class="radio" name="statusLocalizar" value="A" <%= (statusLocalizar.equals("A")? "checked": "") %>>Atendido
      <input type="radio" class="radio" name="statusLocalizar" value="F" <%= (statusLocalizar.equals("F")? "checked": "") %>>Faturado
      <input type="radio" class="radio" name="statusLocalizar" value="C" <%= (statusLocalizar.equals("C")? "checked": "") %>>Cancelado
    </td>
  </tr>
    <tr>
    <th class="label" colspan="1">Tipo Pedido</th>
    <td class="label_radio">
      <input type="radio" class="radio" name="tipoPedidoLocalizar" value="P" <%= (tipoPedidoLocalizar.equals("P")? "checked": "") %>>Presencial
      <input type="radio" class="radio" name="tipoPedidoLocalizar" value="R" <%= (tipoPedidoLocalizar.equals("R")? "checked": "") %>>Rápido
      <input type="radio" class="radio" name="tipoPedidoLocalizar" value="T" <%= (tipoPedidoLocalizar.equals("T")? "checked": "") %>>Telefonista
    </td>
  </tr>
  </table>
  <table>
  <tr>
	<th class="label">Data do Pedido Inicial</th>
     <td>
          <input type="text"  name="dtPedidoIni" size="15" value="<%= dtPedidoIni %>" onblur="chkData(this,'dd/MM/yyyy')" maxlength="10" class="inputs">
          <a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dtPedidoIni);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
    </td>
    <th class="label">Data do Pedido Final</th>
     <td>
          <input type="text"  name="dtPedidoFim" size="15" value="<%= dtPedidoFim %>" onblur="chkData(this,'dd/MM/yyyy')" maxlength="10" class="inputs">
          <a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dtPedidoFim);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
    </td>
 </tr>
</table>
<hr>

<%-- mostra todos os registros do banco de dados --%>
<tr>
      <td class = "grid" width="30%"><center><a href="javascript:selecionar_tudo()">Selecionar Todos</a><%=" | "%><a href="javascript:deselecionar_tudo()">Selecionar Nenhum</a></center></td>
</tr>

 

<table border="0" width="100%">
    <tr>
      
      <th class="grid" width="2%">&nbsp;</th>
      <th class="grid" width="2%"><center>Selecionar</center></th>
      <th class="grid" width="2%"><center>Núm. do Orçamento</center></th>
      <th class="grid" width="2%"><center>Núm. do Pedido</center></th>
      <th class="grid" width="2%"><center>Data do Pedido</center></th>
      <th class="grid" width="5%"><center>Nome do Cliente</center></th>
      <th class="grid" width="2%">Status</th>
      <th class="grid" width="2%">Pago</th>
      <th class="grid" width="2%">Integração</th>
      <th class="grid" width="2%">Nota Fiscal</th>
    </tr>
<%
int cont = 0;
int gridSize = 20;
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

//Utiliza o ResultSet para trazer os registros do banco de dados
String dsStatus = "";
String impressao = "";
int numOrcamento = 0;
String statusPagamento = "";
String integracao = "N";
String nfe = "C";

for ( Iterator it = list.iterator(); hasNext && cont < gridSize; hasNext = it.hasNext()) {
	PedidoSaida pedidoSaida = (PedidoSaida) it.next();
	PedidoSaida pedSaida = dao.procurarPedidoSaida(pedidoSaida.getIdPedidoSaida());
	impressao = dao.statusImpressao(pedidoSaida.getIdPedidoSaida());
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
	if(impressao.equalsIgnoreCase("S")){
		impressao="SIM";
		
	}else{
		impressao = "NÃO";
	}
	if(dao.statusPag(pedSaida.getIdPedidoSaida()) != null){
		if(dao.statusPag(pedSaida.getIdPedidoSaida()).equalsIgnoreCase("S")){
			statusPagamento = "SIM";
		}else{
		     statusPagamento = "NÃO";
		}
	}
	if(dao.getIntegracao(pedSaida.getIdPedidoSaida()).equalsIgnoreCase("N")){
		 integracao = "NÃO" ;
	}else{
		integracao = "SIM";
	}
	if(dao.getNFE(pedSaida.getIdPedidoSaida()).equalsIgnoreCase("C")){
		nfe = "CANCELADO";
	}else if(dao.getNFE(pedSaida.getIdPedidoSaida()).equalsIgnoreCase("E")){
		nfe = "EMITIDO";
	}else{
		nfe = "NÃO EMITIDO";
	}
        
%>
  
   <tr>
      <td class = "grid" width="2%"><center><%=rowNum+cont%></center></td>
      <td class = "grid" width="3%"><input type="checkbox" name="idPedido_<%=pedSaida.getIdPedidoSaida()%>" value="<%=pedSaida.getIdPedidoSaida()%>"></td>
      <%if(numOrcamento == 0){ %>
      	<td class = "grid" width="2%"><font color="red"><center><%="PEDIDO"%></center></font></td>
      <%}else{ %>
      	 <td class = "grid" width="2%"><center><%=numOrcamento%></center></td>
      <%} %>
      <td class = "grid" width="2%"><center><%=pedSaida.getIdPedidoSaida()%></center></td>
      <td class = "grid" width="5%"><center><%=ConverteDate.dateToString(pedSaida.getDtPed())%></center></td>
      <td class = "grid" width="30%"><center><%=entidade.getNome()%></center></td>
      <td class = "grid" width="3%"><font color="red"><center><%=dsStatus%></center></font></td>
      <td class = "grid" width="3%"><center><%=statusPagamento%></center></td>
      <td class = "grid" width="3%"><center><%=integracao%></center></td>
      <td class = "grid" width="3%"><center><%=nfe%></center></td>
      
      
  </tr>
  	<input type="hidden" name="pedido" value="<%=pedSaida.getIdPedidoSaida()%>"/>
<%
}
%>      
</table>

<tr>
    <br>
	<td><input class="button" type="button" value="Gravar" onClick="javascript: salvar();" />
</tr>
</form>


   
   
   
 
 
 
 
<br>
<%  if (rowNum != 0 || hasNext) { %>
        <center>
<%      if (rowNum != 0) { %>
<a class="link" href="consultarPedidos.jsp?rowNum=<%=0%>&nomeLocalizar=<%=nomeLocalizar%>&statusLocalizar=<%=statusLocalizar%>&idPedidoLocalizar=<%=idPedidoLocalizar%>&tipoPedidoLocalizar=<%=tipoPedidoLocalizar%>&dtPedidoIni=<%=dtPedidoIni%>&dtPedidoFim=<%=dtPedidoFim%>">Primeira</a>&nbsp&nbsp
|&nbsp&nbsp<a class="link" href="consultarPedidos.jsp?rowNum=<%=rowNum-gridSize%>&nomeLocalizar=<%=nomeLocalizar%>&statusLocalizar=<%=statusLocalizar%>&idPedidoLocalizar=<%=idPedidoLocalizar%>&tipoPedidoLocalizar=<%=tipoPedidoLocalizar%>&dtPedidoIni=<%=dtPedidoIni%>&dtPedidoFim=<%=dtPedidoFim%>">< Anterior</a>&nbsp&nbsp
<%      } else { %>
Primeira&nbsp&nbsp|&nbsp&nbsp< Anterior&nbsp
<%      } %>
<%      if (hasNext) { %>
|&nbsp&nbsp<a class="link" href="consultarPedidos.jsp?rowNum=<%=rowNum+gridSize%>&nomeLocalizar=<%=nomeLocalizar%>&statusLocalizar=<%=statusLocalizar%>&idPedidoLocalizar=<%=idPedidoLocalizar%>&tipoPedidoLocalizar=<%=tipoPedidoLocalizar%>&dtPedidoIni=<%=dtPedidoIni%>&dtPedidoFim=<%=dtPedidoFim%>">Próxima ></a>&nbsp&nbsp
|&nbsp&nbsp<a class="link" href="consultarPedidos.jsp?rowNum=<%=rowCount-gridSize%>&nomeLocalizar=<%=nomeLocalizar%>&statusLocalizar=<%=statusLocalizar%>&idPedidoLocalizar=<%=idPedidoLocalizar%>&tipoPedidoLocalizar=<%=tipoPedidoLocalizar%>&dtPedidoIni=<%=dtPedidoIni%>&dtPedidoFim=<%=dtPedidoFim%>">Última</a>
<%      } else { %>
|&nbsp&nbsp Próxima >&nbsp&nbsp|&nbsp&nbspÚltima
<%      } %>
        </center>
<%  } %>
<%@include file="../fimConexao.jsp"%>