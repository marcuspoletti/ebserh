<%@page import="afero.model.ProdutoEstoquePreco"%>
<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.Produto" %>
<%@ page import="afero.model.Unidade" %>
<%@ page import="afero.util.ConverteDate" %>
<%@ page import="afero.model.EstoqueProdutoPreco" %>
<%@page import="afero.persistence.PedidoEntradaDAO"%>
<%@ page import="afero.model.Preco" %>
<%@ page import="afero.model.Loja" %>
<%@ page import="afero.persistence.ProdutoDAO" %>
<%@ page import="afero.persistence.UnidadeDAO" %>
<%@ page import="afero.persistence.EstoqueDAO" %>
<%@ page import="afero.persistence.LojaDAO" %>
<%@ page import="afero.persistence.PrecoDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@page import="afero.util.Utilitaria"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script language=JavaScript src="../js/abas.js" type=text/javascript></script>
<script src="../js/common.js"/></script>

<script>

function localizar() {
  document.forms[0].action='listaEstoqueIvent.jsp?acao='+acao;
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.nomeProduto.value = '';
  document.all.status.value = 'A'; //não está limpando
  document.forms[0].submit();
} 
function recarregar(acao) {
  document.forms[0].action='listaEstoqueIvent.jsp?acao='+acao;
  document.forms[0].submit();
}
</script>

<%
ProdutoDAO dao;
PedidoEntradaDAO daoPedidoSaida = new PedidoEntradaDAO(conn);
ConverteDate converte = new ConverteDate();
String status = request.getParameter("status");
if(status == null) status = "A";
String acao = request.getParameter("acao");
if(acao == null) acao = "listar";
String clausula = "";

int cont = 0;
String cdLoja = request.getParameter("idLoja");
int idLoja = 0;
if (cdLoja == null) {
	idLoja = Integer.parseInt((String)session.getAttribute("idLoja"));
} else {
	idLoja = Integer.parseInt(cdLoja);
}

String dataIni = request.getParameter("dataIni");
String dataFim = request.getParameter("dataFim");
if (dataIni == null) {
    dataIni = daoPedidoSaida.dataAtualPedido();
}
if (dataFim == null) {
    dataFim = daoPedidoSaida.dataAtualPedido();
}

clausula = clausula+" WHERE e.status= 'A' AND e.idLoja = "+idLoja+" AND p.status = '"+status+"' AND precoPadrao = 'S' ORDER BY p.dsProduto ";

//seleciona todos os registros do banco de dados
List list = null;
dao = new ProdutoDAO(conn);
list = dao.listarProdutoEstoquePreco(clausula);

%>

<h1 class="cabecalho_pagina">Listagem de Movimentação de Estoque</h1>

<hr>

<body onload="document.forms[0].elements[0].focus();" >
<form action="listaEstoqueIvent.jsp?acao=<%=acao%>">
<iframe width=174 height=189 name="gToday:normal:"../js/calendar/agenda.js"
            id="gToday:normal:"../js/calendar/agenda.js" src="../js/calendar/ipopeng.htm"
            scrolling="no" frameborder="0" style="visibility:visible; z-index:999; 
    position:absolute; top:-500px; left:-500px;">
</iframe>
<input type="hidden" name="acao" value="<%=acao%>"/>
<table align="center" border="0">
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
      <th class="label">Loja</th>
      <td><select id="idLoja"name="idLoja">
          <option value='0'>Todos...</option>
          <%@include file="../WEB-INF/jspf/combo/comboLoja.jspf" %></select>
          <script>comboSelect(document.forms[0].idLoja, '<%= idLoja %>');</script>
      </td>
      <td align="center">
        <input type="button" value="Atualizar" class="botao" onclick="recarregar('<%=acao%>');" >
    </td>
  </tr>
<%--  
  <tr>
    <th class='label'>Descrição do Produto</th>
    <td><input type="text" name="nomeProduto" <%if (nomeProduto != null) { %>value="<%=nomeProduto%>"<% }%>  size="40" maxlength="40"></td>
  </tr>
  --%>
  <%--
  <tr>
    <th class="label">Status</th>
    <td class="label_radio">
      <input type="radio" class="radio" name="status" value="" <%= (status.equals("")? "checked": "") %>>Todos
      <input type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Ativo
      <input type="radio" class="radio" name="status" value="I" <%= (status.equals("I")? "checked": "") %>>Inativo</td>
     <td><input class="button" type="button" value="Localizar" onClick="javascript: localizar('<%=acao%>');" /></td>
   <td><input class="button" type="button" value="Nova pesquisa" onClick="javascript: novaPesquisa();" /></td> 
  </tr>
  --%> 
</table>
<hr>

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr>
      
      <th class="grid"><center></center></th>
      <th class="grid">Loja</th>
      <th class="grid"><center>Descrição do Produto</center></th>
      <th class="grid" colspan="2">Saldo / Valor</th>
      <th class="grid" colspan="2">Entrada / Valor</th>
      <th class="grid" colspan="2">Saida / Valor</th>
      <th class="grid">Saldo Geral</th>
      <th class="grid">Valor (R$)</th>
    </tr>
<%

//Utiliza o ResultSet para trazer os registros do banco de dados
String consultaSaldo = " AND pe.dtPed <= '"+converte.DMYToYMDI(dataIni)+" 00:00:00' GROUP BY p.idProduto ";
String consulta = " AND pe.dtPed BETWEEN '"+converte.DMYToYMDI(dataIni)+" 00:00:00' AND '"+converte.DMYToYMDI(dataFim)+" 23:59:59' GROUP BY p.idProduto ";
double totalGeral  = 0;
double precoGeral = 0;
EstoqueProdutoPreco prod;
double saldoParcial = 0;
double entradaParcial = 0;
double saidaParcial = 0;
double valorParcial = 0;
double entradaGeral = 0;
double valorEntrada = 0;
double saidaGeral = 0;
double valorSaida = 0;
double valorGeral = 0;
EstoqueDAO daoEstoque;
for ( Iterator it = list.iterator();it.hasNext();) {
	prod = (EstoqueProdutoPreco) it.next();
	cont++;	
	daoEstoque = new EstoqueDAO(conn);
	//if(daoEstoque.saldoAte(idLoja, prod.getIdProduto(), consultaSaldo) != 0){
		 entradaParcial = daoEstoque.saldoEntradaAte(idLoja, prod.getIdProduto(), consultaSaldo);
		 saidaParcial = daoEstoque.saldoSaidaAte(idLoja, prod.getIdProduto(), consultaSaldo);
		 saldoParcial = (entradaParcial - saidaParcial);
		valorParcial = (saldoParcial*daoEstoque.valorPreco(prod.getIdProduto()));
	//}
	//if(daoEstoque.entradaAte(idLoja, prod.getIdProduto(), null) != 0){
		entradaGeral = daoEstoque.entradaAte(idLoja, prod.getIdProduto(), consulta);
		valorEntrada = (entradaGeral * daoEstoque.valorPreco(prod.getIdProduto()));
	//}
	//if(daoEstoque.saidaAte(idLoja, prod.getIdProduto(), null)!= 0){
		saidaGeral = daoEstoque.saidaAte(idLoja, prod.getIdProduto(), consulta);
		valorSaida = (saidaGeral * daoEstoque.valorPreco(prod.getIdProduto()));
	//}
	precoGeral = daoEstoque.valorPreco(prod.getIdProduto());
	
	
%>
    <tr>
      <td class = "grid" width="5%"><center><%=cont%></center></td>
      <td class = "grid" width="10%"><center><%=prod.getApelidoLoja()%></center></td>
      <td class = "grid"><center><%=prod.getDsProduto() %></center></td>
      <td class = "grid" width="5%"><center><%=Utilitaria.formatarNumero(saldoParcial,2)%></center></td>
      <td class = "grid" width="5%"><center><%=Utilitaria.formatarNumero(valorParcial,2)%></center></td>
      <td class = "grid" width="5%"><center><%=Utilitaria.formatarNumero(entradaGeral,2)%></center></td>
      <td class = "grid" width="5%"><center><%=Utilitaria.formatarNumero(valorEntrada,2)%></center></td>
      <td class = "grid" width="5%"><center><%=Utilitaria.formatarNumero(saidaGeral,2)%></center></td>
      <td class = "grid" width="5%"><center><%=Utilitaria.formatarNumero(valorSaida,2)%></center></td>
      <td class = "grid" width="5%"><center><%=Utilitaria.formatarNumero(((saldoParcial+entradaGeral) - saidaGeral),2)%></center></td>
      <%valorGeral =  ((saldoParcial+entradaGeral) - saidaGeral) * precoGeral;%>
      <td class = "grid" width="5%"><center><%=Utilitaria.formatarNumero(valorGeral,2)%></center></td>
  </tr>
  
<%

          totalGeral +=valorGeral;
}

%>   
   <tr>
      <td class = "grid" width="5%"><center></center> - </td>
      <td class = "grid" width="10%"><center></center> - </td>
      <td class = "grid"> - </td>
      <td class = "grid" width="5%" colspan="2"> - </td>
      <td class = "grid" width="5%" colspan="2"> - </td>
      <td class = "grid" width="5%" colspan="2"> - </td>
      <td class = "grid" width="5%"> - </td>
      <td class = "grid" width="5%"><center><%=Utilitaria.formatarNumero(totalGeral, 2)%></center></td>
      
  </tr>
      
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
  <br>
	<input class="button"type="button" value="Imprimir" onclick="javascript:window.print()">
  </tr>
</table>
</form>

<%@include file="../fimConexao.jsp"%>