<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.Produto" %>
<%@ page import="afero.model.Preco" %>
<%@ page import="afero.model.Divisao" %>
<%@ page import="afero.model.Estoque" %>
<%@ page import="afero.model.Loja" %>
<%@ page import="afero.model.Produto" %>
<%@ page import="afero.model.PedidoEntradaItem" %>
<%@ page import="afero.model.ListarEntradasProduto" %>
<%@ page import="afero.persistence.PedidoEntradaItemDAO" %>
<%@ page import="afero.persistence.ProdutoDAO" %>
<%@ page import="afero.persistence.PrecoDAO" %>
<%@ page import="afero.persistence.DivisaoDAO"%>
<%@ page import="afero.persistence.EstoqueDAO"%>
<%@ page import="afero.persistence.ProdutoDAO"%>
<%@ page import="afero.persistence.LojaDAO" %>
<%@ page import="afero.persistence.PedidoItensDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.Date"%>
<%@ page import="afero.util.ConverteDate" %>
<%@ page import="afero.util.Utilitaria" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function confirmaExcluir(cont, id, id1, id2) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarEntradaProduto.jsp?acao=exc&idProduto=' + id+'&idEstoque='+id1+'&idPreco='+id2;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.nomeProduto.value = '';
  document.all.tipoProduto.value = ''; //não está limpando
  document.forms[0].submit();
}  
</script>

<%
int cdProduto = 0;
int cdEstoque = 0;
PedidoEntradaItemDAO daoPedidoEntradaItem;
ProdutoDAO dao;
ProdutoDAO daoExclusao;
DivisaoDAO dao1;
PrecoDAO daoPreco;
EstoqueDAO daoEstoque;
EstoqueDAO daoEstoqueExclusao;
ConverteDate conDate = new ConverteDate();
String mensagem = request.getParameter("mensagem");
if(mensagem == null) mensagem = "";
String acao = request.getParameter("acao");
if (acao == null) acao = "listar";

String dsProduto = "";
String nmProduto = "";
String tipoProduto = "";
String status ="";
String dtCad = "";
String dtMod = "";
String nomeProduto = "";
String clausula = "";
String idProduto = "";
String idDivisao = "";
String usuarioProduto = "";
String cdBarra = "";
int idSubGrupo = 0;
int idGrupo = 0;
ConverteDate converte = new ConverteDate();
PedidoItensDAO daoPedidoItens = null;
String dataIni = request.getParameter("dataIni");
String dataFim = request.getParameter("dataFim");
daoPedidoItens = new PedidoItensDAO(conn);
if (dataIni == null) {
 dataIni = daoPedidoItens.dataAtualPedido();
}
if (dataFim == null) {
  dataFim = daoPedidoItens.dataAtualPedido();
}
//Dados Estoque
String idLoja = (String)session.getAttribute("idLoja");



 if (!acao.equalsIgnoreCase("voltar")) {
    nomeProduto = request.getParameter("nomeProduto");
    tipoProduto = request.getParameter("tipoProduto");
    if(nomeProduto == null) nomeProduto = "";
    if(tipoProduto == null) tipoProduto = "";
    
  }

  if (nomeProduto!= null) {
    clausula = " WHERE pe.dtEmissao BETWEEN '"+converte.DMYToYMDI(dataIni)+" 00:00:00' AND '"+converte.DMYToYMDI(dataFim)+" 23:59:59' AND p.dsProduto LIKE '"+nomeProduto+"%'";
  } 
  if (!tipoProduto.isEmpty()) {
    if (clausula.isEmpty()) {
      clausula = " WHERE pe.dtEmissao BETWEEN '"+converte.DMYToYMDI(dataIni)+" 00:00:00' AND '"+converte.DMYToYMDI(dataFim)+" 23:59:59' AND p.tipoProduto='"+tipoProduto+"'";
    } else {
      clausula = clausula+" AND p.tipoProduto='"+tipoProduto+"'";
    }
  }
//seleciona todos os registros do banco de dados
List list;
dao = new ProdutoDAO(conn);
daoPedidoEntradaItem = new PedidoEntradaItemDAO(conn);
clausula = clausula+" AND pe.idLoja = "+Integer.parseInt(idLoja)+" ORDER BY p.dsProduto ";
list = daoPedidoEntradaItem.listarEntradaProduto(clausula);

%>
<h1 class="cabecalho_pagina">Listar Entrada de Produto</h1>
<body onload="document.forms[0].elements[0].focus();" >
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<form action="listarEntradaProduto.jsp">
<iframe width=174 height=189 name="gToday:normal:"../js/calendar/agenda.js"
            id="gToday:normal:"../js/calendar/agenda.js" src="../js/calendar/ipopeng.htm"
            scrolling="no" frameborder="0" style="visibility:visible; z-index:999; 
    position:absolute; top:-500px; left:-500px;">
</iframe>
<table border="0" width="100%">
<tr>
      <td class='grid'>Dt. Emissão Inicial
	<input type="text" name="dataIni" size="15" value="<%= dataIni %>" onblur="chkData(this,'dd/MM/yyyy')" maxlength="10" class="inputs"><a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dataIni);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
      </td>
      <td class='grid'>Dt. Emissão Final 
	<input type="text"  name="dataFim" size="15" value="<%= dataFim %>" maxlength="10" onblur="chkData(this,'dd/MM/yyyy')" class="inputs"><a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dataFim);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
      </td>  
</tr>
</table>
<table colspan="2">
  <tr>
    <th class='label'>Descrição do Produto</th>
    <td><input type="text" name="nomeProduto" <%if (nomeProduto != null) { %>value="<%=nomeProduto%>"<% }%> size="40" maxlength="50"></td>
    <td><input class="button" type="button" value="Localizar" onClick="javascript: localizar();" /></td>
    <td><input class="button" type="button" value="Nova pesquisa" onClick="javascript: novaPesquisa();" /></td>
  </tr>
  <tr>
    <th class="label">Tipo do Produto</th>
    <td class="label_radio">
      <input type="radio" class="radio" name="tipoProduto" value="" <%= (tipoProduto.equals("")? "checked": "") %>>Todos
      <input type="radio" class="radio" name="tipoProduto" value="SP" <%= (tipoProduto.equals("SP")? "checked": "") %>>Serviço Próprio
      <input type="radio" class="radio" name="tipoProduto" value="ST" <%= (tipoProduto.equals("ST")? "checked": "") %>>Serviço de Terceiros<br>
      <input type="radio" class="radio" name="tipoProduto" value="PP" <%= (tipoProduto.equals("PP")? "checked": "") %>>Produto Próprio
      <input type="radio" class="radio" name="tipoProduto" value="PT" <%= (tipoProduto.equals("PT")? "checked": "") %>>Produto de Terceiros
      <input type="radio" class="radio" name="tipoProduto" value="MP" <%= (tipoProduto.equals("MP")? "checked": "") %>>Matéria Prima </td>
  </tr>
  
</table>
<hr>

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr>
      <th class="grid">&nbsp;</th>
      <th class="grid">Número DOC.</th>
      <th class="grid">Dt.Ent.</th>
      <th class="grid"><center>Descrição do Produto</center></th>
      <th class="grid">Quant.</th>
      <th class="grid">Divisão</th>
      <th class="grid">Tipo do Produto</th>
      <th class="grid">Pr. Ent.</th>
      <th class="grid">Pr. Unit.</th>
      <th class="grid">Status</th>

    </tr>
<%
int cont = 0;


float quantTotal = 0;
float valorTotal = 0;
float valorItens = 0;
//Utiliza o ResultSet para trazer os registros do banco de dados
for ( Iterator it = list.iterator(); it.hasNext();) {
	ListarEntradasProduto prod = (ListarEntradasProduto) it.next();
         dao1 = new DivisaoDAO(conn);
	Divisao divisao = dao1.procurarDivisao(prod.getIdDivisao());
	daoEstoque = new EstoqueDAO(conn);
	int idEstoqueList = daoEstoque.getIdEstoque(Integer.parseInt(idLoja), prod.getIdProduto());
	Preco precoList = null;
	daoPreco = new PrecoDAO(conn);
	precoList = daoPreco.procurarPrecoEstoque(idEstoqueList);
	int idPrecoList = 0;
	if (precoList != null) {
		idPrecoList = precoList.getIdPreco();
	}
	quantTotal += prod.getQuant();
	valorItens +=prod.getQuant() * prod.getValor();
	valorTotal += prod.getValor();
	cont++;
	

%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid" width="3%"><center><%=prod.getNrDoc()%></center></td>
      <td class = "grid" width="3%"><center><%=ConverteDate.dateToString(prod.getDtPed())%></center></td>
      <td class = "grid"><center><a href="formProduto.jsp?acao=atu&idProduto=<%=prod.getIdProduto()%>&idEstoque=<%=idEstoqueList%>&idPreco=<%=idPrecoList%>"><%=prod.getDsProduto() %></a></center></td>
      <td class = "grid" width="3%"><center><%=Utilitaria.formatarNumero(prod.getQuant(),2)%></center></td>
      <td class = "grid" width="25%"><center><%=divisao.getDsDivisao()%></center></td>
      <td class = "grid" width="5%"><center><%=prod.getTipoProduto()%></center></td>
      <td class = "grid" width="4%"><center><%=Utilitaria.formatarNumero(prod.getQuant()*prod.getValor(),2)%></center></td>
      <td class = "grid" width="4%"><center><%=Utilitaria.formatarNumero(prod.getValor(),2)%></center></td>
      <td class = "grid" width="5%"><center><%=prod.getStatus()%></center></td>
  	</tr>
<%
}
%>  
    <tr>
      <th class="grid"></th>
      <th class="grid"></th>
      <th class="grid"></th>
      <th class="grid"><b><center><%="TOTAL"%></center></b></th>
      <th class="grid"><b><%=Utilitaria.formatarNumero(quantTotal,2)%></b></th>
      <th class="grid"></th>
      <th class="grid"></th>
      <th class="grid"><b><%=Utilitaria.formatarNumero(valorItens,2)%></b></th>
      <th class="grid"><b><%=Utilitaria.formatarNumero(valorTotal,2)%></b></th>
      <th class="grid"></th>

    </tr> 
</table>
</form>
<%@include file="../fimConexao.jsp"%>


