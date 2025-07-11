<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.MaisVendidos" %>
<%@ page import="afero.model.MaiorVenda" %>
<%@ page import="afero.model.PedidoSaidaItem" %>
<%@ page import="afero.persistence.PedidoSaidaItemDAO" %>
<%@page import="java.util.Calendar" %>
<%@page import="afero.model.PedidoSaida"%>
<%@page import="afero.persistence.PedidoSaidaDAO"%>
<%@ page import="afero.model.Unidade" %>
<%@ page import="afero.model.Estoque" %>
<%@ page import="afero.model.Preco" %>
<%@ page import="afero.model.Loja" %>
<%@ page import="afero.persistence.ProdutoDAO" %>
<%@ page import="afero.persistence.UnidadeDAO" %>
<%@ page import="afero.persistence.EstoqueDAO" %>
<%@ page import="afero.persistence.LojaDAO" %>
<%@ page import="afero.persistence.PrecoDAO" %>
<%@ page import="afero.util.ConverteDate" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@page import="afero.util.Utilitaria"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/></script>

<script>

function localizar() {
  document.forms[0].action="produtosComMaiorSaidaQuantidade.jsp";
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.forms[0].action="produtosComMaiorSaidaQuantidade.jsp";
  document.all.nomeProduto.value = '';
  document.all.status.value = ''; //não está limpando
  document.forms[0].submit();
} 
function salvar() {
  document.all.acao.value='atu';
  document.forms[0].submit();	
}

function cancelar() {
  document.forms[0].action="produtosComMaiorSaidaQuantidade.jsp";
  document.forms[0].submit();
}

function recarregar() {
  document.forms[0].action='produtosComMaiorSaidaQuantidade.jsp';
  document.forms[0].submit();
}

</script>

<%
MaiorVenda maiorVenda = null;
PedidoSaidaItemDAO dao;
PedidoSaidaItem pedidoSaida;
int secs           = 120;
Calendar dataAtual = Calendar.getInstance();
ConverteDate converte = new ConverteDate();
PedidoSaidaDAO daoPedidoSaida = new PedidoSaidaDAO(conn);
String dataIni = request.getParameter("dataIni");
String dataFim = request.getParameter("dataFim");
int mes        = dataAtual.get(Calendar.MONTH) + 1;

if (dataIni == null) {
 dataIni = daoPedidoSaida.dataAtualPedido();
}
if (dataFim == null) {
  dataFim = daoPedidoSaida.dataAtualPedido();
}

int cont = 0;
String cdLoja = request.getParameter("idLoja");
int idLoja = 0;
if (cdLoja == null) {
	idLoja = Integer.parseInt((String)session.getAttribute("idLoja"));
} else {
	idLoja = Integer.parseInt(cdLoja);
}
String clausula = " where pss.status='A' and pss.operacao='T' and pss.idLoja = " + idLoja;
clausula += " and pss.dtPed BETWEEN '"+converte.DMYToYMDI(dataIni)+" 00:00:00' AND '"+converte.DMYToYMDI(dataFim)+" 23:59:59' ";
clausula += " group by idProduto order by quantidade desc ";
//seleciona todos os registros do banco de dados
List list = null;
List listarMaisVendido = null;
dao = new PedidoSaidaItemDAO(conn);
list = dao.comQuantidadeMaiorSaida(clausula);

%>

<h1 class="cabecalho_pagina">Produtos Com Maior Saída</h1>

<hr>

<body onload="document.forms[0].elements[0].focus();" >
<form action="produtosComMaiorSaidaQuantidade.jsp">

<input type="hidden" name="cont" value="<%=cont%>"/>
<iframe width=174 height=189 name="gToday:normal:"../js/calendar/agenda.js"
            id="gToday:normal:"../js/calendar/agenda.js" src="../js/calendar/ipopeng.htm"
            scrolling="no" frameborder="0" style="visibility:visible; z-index:999; 
    position:absolute; top:-500px; left:-500px;">
    </iframe>
<table colspan="2">
<tr>
      <th class="label">Loja</th>
      <td><select id="idLoja"name="idLoja" onchange="recarregar();" >
          <option value='0'>Todos...</option>
          <%@include file="../WEB-INF/jspf/combo/comboLoja.jspf" %></select>
          <script>comboSelect(document.forms[0].idLoja, '<%= idLoja %>');</script>
      </td>
      </tr>

</table>
<hr>
<table border="0" width="100%">
    <tr>
      <td class='grid'>Data Inicial 
	<input type="text" name="dataIni" size="15" value="<%= dataIni %>" onblur="chkData(this,'dd/MM/yyyy')" maxlength="10" class="inputs"><a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dataIni);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
      </td>
      <td class='grid'>Data Final 
	<input type="text"  name="dataFim" size="15" value="<%= dataFim %>" maxlength="10" onblur="chkData(this,'dd/MM/yyyy')" class="inputs"><a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dataFim);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
      </td>

     
    <td align="center">
        <input type="button" value="Atualizar" class="botao" onclick="recarregar();">
        <input type="button" value="Imprimir" class="botao" onclick="print();">
    </td>
    </tr>

</table>
</form>

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr>
      
      <th class="grid"><center></center></th>
      <th class="grid">Produto</th>
      <th class="grid"><center>Total de Saídas</center></th>
      
    </tr>
<%

int gridSize = 20;
String rowNumStr = request.getParameter("rowNum");
int rowNum = (rowNumStr == null ? 0: Integer.parseInt(rowNumStr));
if (rowNum < 0) rowNum = 0;
boolean hasNext = false;
int rowCount = list.size();
int rowLast = 0;
if (rowCount > 0) {
  if (rowCount > gridSize) {
    rowLast = rowNum+gridSize+100; 
    if (rowLast >= rowCount && rowCount > 0) rowLast = rowCount;
    if (rowNum > rowLast) rowNum = 0;
    list = list.subList(rowNum, rowLast);
  }
  hasNext = true;

}


//Utiliza o ResultSet para trazer os registros do banco de dados
for ( Iterator it = list.iterator(); hasNext && cont < gridSize; hasNext = it.hasNext()) {
	maiorVenda = (MaiorVenda) it.next();
	cont++;
%>
    <tr>
      <td class = "grid" width="5%"><center><%=rowNum+cont%></center></td>
      <td class = "grid" width="30%"><center><%=maiorVenda.getNmProduto()%></center></td>
      <td class = "grid" width="20%"><center><%=Utilitaria.formatarNumero(maiorVenda.getQuant(),3) %></center></td>
  </tr>    
<%
}

%>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
  <br>
	<input class="button"type="button" value="Imprimir" onclick="javascript:window.print()">
  </tr>
</table>

<%  if (rowNum != 0 || hasNext) { %>
        <center>
<%      if (rowNum != 0) { %>
<a class="link" href="produtosComMaiorSaidaQuantidade.jsp?rowNum=<%=0%>&idLoja=<%=idLoja%>&dataIni=<%=dataIni%>&dataFim=<%=dataFim%>">Primeira</a>&nbsp&nbsp
|&nbsp&nbsp<a class="link" href="produtosComMaiorSaidaQuantidade.jsp?rowNum=<%=rowNum-gridSize%>&idLoja=<%=idLoja%>&dataIni=<%=dataIni%>&dataFim=<%=dataFim%>">< Anterior</a>&nbsp&nbsp
<%      } else { %>
Primeira&nbsp&nbsp|&nbsp&nbsp< Anterior&nbsp
<%      } %>
<%      if (hasNext) { %>
|&nbsp&nbsp<a class="link" href="produtosComMaiorSaidaQuantidade.jsp?rowNum=<%=rowNum+gridSize%>&idLoja=<%=idLoja%>&dataIni=<%=dataIni%>&dataFim=<%=dataFim%>">Próxima ></a>&nbsp&nbsp
|&nbsp&nbsp<a class="link" href="produtosComMaiorSaidaQuantidade.jsp?rowNum=<%=rowCount-gridSize%>&idLoja=<%=idLoja%>&dataIni=<%=dataIni%>&dataFim=<%=dataFim%>">Última</a>
<%      } else { %>
|&nbsp&nbsp Próxima >&nbsp&nbsp|&nbsp&nbspÚltima
<%      } %>
        </center>
<%  } %>
<%@include file="../fimConexao.jsp"%>