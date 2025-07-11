<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.PedidoEntrada" %>
<%@ page import="afero.model.Produto" %>
<%@ page import="afero.model.PedidoSaida" %>
<%@ page import="afero.model.EntradaProduto" %>
<%@ page import="afero.persistence.PedidoSaidaDAO" %>
<%@ page import="afero.persistence.PedidoEntradaDAO" %>
<%@ page import="afero.persistence.ProdutoDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Date" %>
<%@ page import="afero.util.Utilitaria" %>
<%@ page import="afero.util.ConverteDate" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/></script>

<script>


function localizar() {
  document.forms[0].submit();
}  
 
</script>

<%
PedidoSaidaDAO daoPedidoSaida = new PedidoSaidaDAO(conn);
ConverteDate converte = new ConverteDate();
String dataIni = request.getParameter("dataIni");
String dataFim = request.getParameter("dataFim");
String status = request.getParameter("status");
if(status == null) status = "A";
PedidoEntradaDAO dao = null;
String acao = request.getParameter("acao");
String idProduto = request.getParameter("idProduto");
if(idProduto == null)idProduto="0";
ProdutoDAO daoProduto = new ProdutoDAO(conn);
String tipoProduto = request.getParameter("tipoProduto");
if(tipoProduto == null)tipoProduto = "PT";

String idLoja = request.getParameter("idLoja");
if (idLoja == null) {
	idLoja = (String)session.getAttribute("idLoja");
} 
String clausula = "";
int numDoc;
if (dataIni == null) {
    dataIni = daoPedidoSaida.dataAtualPedido();
}
if (dataFim == null) {
    dataFim = daoPedidoSaida.dataAtualPedido();
}
    clausula = " WHERE pe.dtPed BETWEEN '"+converte.DMYToYMDI(dataIni)+" 00:00:00' AND '"+converte.DMYToYMDI(dataFim)+" 23:59:59'";

    clausula = clausula+" AND pe.idLoja = "+Integer.parseInt(idLoja);
    clausula = clausula+" AND p.status='"+status+"'";
    if(tipoProduto.equals("T")){
    	clausula = clausula+" AND p.tipoProduto is not null";
    }else{
        clausula = clausula+" AND p.tipoProduto='"+tipoProduto+"'";
    }
//seleciona todos os registros do banco de dados
List list;
dao = new PedidoEntradaDAO(conn);
clausula = clausula+" ORDER BY pe.dtPed desc";
list = dao.listarEntradaProduto(clausula);
%>
<h1 class="cabecalho_pagina">Listagem de Entradas no Estoque</h1>
<body onload="document.forms[0].elements[0].focus();" >
<iframe width=174 height=189 name="gToday:normal:"../js/calendar/agenda.js"
            id="gToday:normal:"../js/calendar/agenda.js" src="../js/calendar/ipopeng.htm"
            scrolling="no" frameborder="0" style="visibility:visible; z-index:999; 
    position:absolute; top:-500px; left:-500px;">
</iframe>
<form method="post" action="relEntradaProduto.jsp">
<input type="hidden" name="idProduto" value="<%=idProduto%>">
<table border="0" width="100%">
 <tr>
      <th class="label">Datas:</th>
      <td class='grid'>Data Inicial 
	<input type="text" name="dataIni" size="15" value="<%= dataIni %>" onblur="chkData(this,'dd/MM/yyyy')" maxlength="10" class="inputs"><a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dataIni);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
      </td>
      <td class='grid'>Data Final 
	<input type="text"  name="dataFim" size="15" value="<%= dataFim %>" maxlength="10" onblur="chkData(this,'dd/MM/yyyy')" class="inputs"><a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dataFim);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
      </td>
</tr>
  <tr>
      <th class="label">Loja</th>
      <td><select id="idLoja"name="idLoja" onchange="recarregar('<%=acao%>');" >
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboLoja.jspf" %></select>
          <script>comboSelect(document.forms[0].idLoja, '<%= idLoja %>');</script>
      </td>
  </tr>
   
<tr>
    <th class="label">Status</th>
    <td class="label_radio">
      <input type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Ativo
      <input type="radio" class="radio" name="status" value="I" <%= (status.equals("I")? "checked": "") %>>Inativo</td>
    <td><input class="button" type="button" value="Localizar" onClick="javascript: localizar();" /></td>
  </tr>
  <tr>
     <th class="label">Tipo do Produto</th>
     <td class="label_radio"><input type="radio" class="radio" name="tipoProduto" value="SP" <%= (tipoProduto.equals("SP")? "checked": "") %>>Serviço Próprio
     <input type="radio" class="radio" name="tipoProduto" value="ST" <%= (tipoProduto.equals("ST")? "checked": "") %>>Serviço de Terceiros
     <input type="radio" class="radio" name="tipoProduto" value="PP" <%= (tipoProduto.equals("PP")? "checked": "") %>>Produto Próprio<br>
     <input type="radio" class="radio" name="tipoProduto" value="PT" <%= (tipoProduto.equals("PT")? "checked": "") %>>Produto de Terceiros
     <input type="radio" class="radio" name="tipoProduto" value="MP" <%= (tipoProduto.equals("MP")? "checked": "") %>>Matéria Prima   
     <input type="radio" class="radio" name="tipoProduto" value="T" <%= (tipoProduto.equals("T")? "checked": "") %>>Todos
</tr>
</table>
<hr>

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr>
      <th class="grid" width="2%">&nbsp;</th>
      <th class="grid" width="2%"><center>Cód Produto</center></th>
      <th class="grid" width="2%"><center>Desc. Prod</center></th>
      <th class="grid" width="3%"><center>Pedido Ent.</center></th>
      <th class="grid" width="3%"><center>Data do Ped.Compra</center></th>
      <th class="grid" width="3%"><center>Quant</center></th>
      <th class="grid" width="3%"><center>Pr. Unit</center></th>
      <th class="grid" width="3%"><center>Custo Direto</center></th>
      
    </tr>
<%
int cont = 0;
String codigoProduto = "";
float totalCusto = 0;
float totalPrUnit = 0;
for (Iterator it = list.iterator(); it.hasNext();) {
	EntradaProduto entradaProd = (EntradaProduto) it.next();
	if(entradaProd.getCdProduto() != null){
		codigoProduto = entradaProd.getCdProduto(); 
	}else{
		codigoProduto = "Não esta cadastro";
	}
	cont++;
	totalCusto +=entradaProd.getCusto();
	totalPrUnit += entradaProd.getPrUnit();
%>
  
   <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid" width="5%"><center><%=codigoProduto%></center></td>
      <td class = "grid" width="15%"><center><%=entradaProd.getDsProduto()%></center></td>
      <td class = "grid" width="5%"><center><%=entradaProd.getNumPedido()%></center></td>
       <td class = "grid" width="5%"><center><%=ConverteDate.dateToString(entradaProd.getDtPed())%></center></td>
      <td class = "grid" width="5%"><center><%=Utilitaria.formatarNumero(entradaProd.getQuant(),0)%></center></td>
      <td class = "grid" width="5%"><center><%=Utilitaria.formatarNumero(entradaProd.getPrUnit(),2)%></center></td>
      <td class = "grid" width="5%"><center><%=Utilitaria.formatarNumero(entradaProd.getCusto(),2)%></center></td>
</tr>
<%
}
%>    
  <tr>
  <td class = "grid" width="2%"><font color="red"><center>Total</center></font></td>
  <td class = "grid" width="2%"><center></center></td>
  <td class = "grid" width="2%"><center></center></td>
  <td class = "grid" width="2%"><center></center></td>
  <td class = "grid" width="2%"><center></center></td>
  <td class = "grid" width="5%"><center></center></td>
  <td class = "grid" width="5%"><center></center></td>
  <td class = "grid" width="5%"><font color="red"><center><%=Utilitaria.formatarNumero(totalCusto,2)%></center></font></td>
  </tr>  
  <tr>
  <br>
	<input class="button"type="button" value="Imprimir" onclick="javascript:window.print()">
  </tr>
</table>
</form>
<%@include file="../fimConexao.jsp"%>