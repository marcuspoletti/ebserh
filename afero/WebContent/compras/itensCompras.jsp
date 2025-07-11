<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.Produto" %>
<%@ page import="afero.model.Divisao" %>
<%@ page import="afero.model.PedidoEntradaItem" %>
<%@ page import="afero.model.PedidoEntrada" %>
<%@ page import="afero.model.Unidade" %>
<%@ page import="afero.model.Estoque" %>
<%@ page import="afero.model.Preco" %>
<%@ page import="afero.model.Loja" %>
<%@ page import="afero.persistence.ProdutoDAO" %>
<%@ page import="afero.persistence.PedidoEntradaDAO" %>
<%@ page import="afero.persistence.UnidadeDAO" %>
<%@ page import="afero.persistence.EstoqueDAO" %>
<%@ page import="afero.persistence.LojaDAO" %>
<%@ page import="afero.persistence.PrecoDAO"%>
<%@ page import="afero.persistence.DivisaoDAO"%>
<%@ page import="afero.persistence.PedidoEntradaItemDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@page import="afero.util.Utilitaria"%>
<%@page import="afero.util.ConverteDate"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/></script>

<script>

function soma(){

var desconto = parseFloat(document.getElementById("desconto").value);
var desc = desconto * document.getElementById("valorTotal").value / 100;
document.getElementById("valorTotal").value =document.getElementById("valorTotal").value - desc;
}

function salvar() {
  document.forms[0].submit();
}

function confirmaExcluir(cont, id, id1) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'itensCompras.jsp?acao=exc&idPedidoEntrada='+id1+'&idPedidoEntradaItem=' + id;   
  }  
}
</script>
<%
String idLojaUsuario = (String)session.getAttribute("idLoja");
List list = null;
List listarEstoque = null;
List listarOrcamentoDAO = null;
ProdutoDAO dao;
EstoqueDAO daoEstoque;
PedidoEntradaItemDAO daoPedidoEntradaItem;
Produto prod = null;
Estoque estoque =null;
PedidoEntradaItem pedidoEntradaItem = null;
PedidoEntradaItem pedidoEntradaItemFiscal = null;
String nomeProduto = request.getParameter("nomeProduto");
if(nomeProduto == null)nomeProduto = "";
String status = request.getParameter("status");
if(status == null)status = "A";
String acao = request.getParameter("acao");
if(acao == null)acao="listar";
String clausula = "";
int cont = 0;
String preco = "0";
float desconto = 0;
double valor = 0;
String idPedidoEntrada = request.getParameter("idPedidoEntrada");
if(acao.equalsIgnoreCase("exc")){
	String idPedidoEntradaItem = request.getParameter("idPedidoEntradaItem");
	PedidoEntradaItem pedidoEntradaExcluir = new PedidoEntradaItem();
	PedidoEntradaItemDAO daoPedidoEntradaItemExcluir = new PedidoEntradaItemDAO(conn);
	pedidoEntradaExcluir.setIdPedidoEntradaItem(Integer.parseInt(request.getParameter("idPedidoEntradaItem")));
	daoPedidoEntradaItemExcluir.excluir(pedidoEntradaExcluir);
	
}
if(acao.equalsIgnoreCase("atu")){
	valor = Utilitaria.toNumber(request.getParameter("valorTotal")).doubleValue();
	PedidoEntrada pedidoEntrada = new PedidoEntrada();
	PedidoEntradaDAO daoPedidoEntrada = new PedidoEntradaDAO(conn);
	pedidoEntrada = daoPedidoEntrada.procurarPedidoEntrada(Integer.parseInt(idPedidoEntrada));
	pedidoEntrada.setVlPed(valor);
	pedidoEntrada.setIdOrdemServico(0);
	pedidoEntrada.setIdPedidoEntradaOrigem(0);
	daoPedidoEntrada.atualizar(pedidoEntrada);
	
}
%>
<body onload="document.forms[0].elements[0].focus();" >
<form action="itensCompras.jsp?acao=atu" method="post">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="cont" value="<%=cont%>"/>
<input type="hidden" name="idPedidoEntrada" value="<%=idPedidoEntrada%>"/>
<hr>
<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr>
      <th class="grid"><center></center></th>
      <th class="grid">Loja</th>
      <th class="grid"><center>Desc. do Prod.</center></th>
      <th class="grid"><center>Divisão</center></th>
      <th class="grid">Preço</th>
      <th class="grid">C.S.T.</th>
      <th class="grid">CFOP</th>
      <th class="grid">Quant.</th>
      <th class="grid">BC.ICMS</th>
      <th class="grid">V.ICMS</th>
      <th class="grid">BC. ICMS ST</th>
      <th class="grid">VL. ICMS ST</th>
      <th class="grid">ICMS</th>
      <th class="grid">IPI</th>
      <th class="grid">Validade</th>
      <th class="grid">Lote Fabricação</th>
      <th class="grid">Unidade</th>
      <th class="grid">Excluir</th>
      
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
 float total = 0;
 daoPedidoEntradaItem = new PedidoEntradaItemDAO(conn);
 list = daoPedidoEntradaItem.listarProcurarPedidoEntradaItem(Integer.parseInt(idPedidoEntrada));
 if(list != null){
  for ( Iterator it = list.iterator(); it.hasNext(); ) {
	pedidoEntradaItem = (PedidoEntradaItem) it.next();
	pedidoEntradaItemFiscal = daoPedidoEntradaItem.listarPedidoEntradaItemFiscal(pedidoEntradaItem.getIdPedidoEntradaItem());
	dao = new ProdutoDAO(conn);
	prod = dao.procurarProduto(pedidoEntradaItem.getIdProduto());
	DivisaoDAO dao1 = new DivisaoDAO(conn);
	Divisao divisao = dao1.procurarDivisao(prod.getIdDivisao());
	daoEstoque = new EstoqueDAO(conn);
	listarEstoque = daoEstoque.procurarEstoquePreco(prod.getIdProduto(), Integer.parseInt(idLojaUsuario));
	if(listarEstoque != null){
	for (Iterator itListar = listarEstoque.iterator(); itListar.hasNext();){
		cont++;
		estoque = (Estoque) itListar.next();
		LojaDAO loja = new LojaDAO(conn);
		Loja lojaEstoque = loja.procurarLoja(estoque.getIdLoja());
		PrecoDAO daoPrecoListar = new PrecoDAO(conn);
		Preco precoListar = daoPrecoListar.procurarPrecoEstoque(estoque.getIdEstoque());
		if(precoListar!=null){
			
			preco = Utilitaria.formatarNumero(precoListar.getPreco(), 2).toString();
			UnidadeDAO daoUnidade = new UnidadeDAO(conn);
			Unidade unidadeListar = daoUnidade.procurarUnidade(precoListar.getIdUnidade());	
%>
    <tr>
      <td class = "grid" width="1%"><center><%=cont%></center></td>
      <td class = "grid" width="5%"><center><%=lojaEstoque.getApelido()%>/<%=lojaEstoque.getRazaoSocial()%></center></td>
      <td class = "grid" width="5%"><center><%=prod.getDsProduto() %></center></td>
      <td class = "grid" width="1%"><center><%=divisao.getDsDivisao()%></center></td>
      <%float precoItem = pedidoEntradaItem.getValor() * pedidoEntradaItem.getQuant(); %>
      <td class="grid" width="3%" name="preco_<%=precoListar.getIdPreco()%>" size="10" maxlength="10"><%=Utilitaria.formatarNumero(pedidoEntradaItem.getValor(),2)%></td>
      <td class = "grid" width="5%"><center><%=pedidoEntradaItemFiscal.getNfNCST() %></center></td>
      <td class = "grid" width="5%"><center><%=pedidoEntradaItemFiscal.getNfICFOP() %></center></td>
      <td class="grid" width="3%" name="quantidade%>" size="10" maxlength="10"><%=pedidoEntradaItem.getQuant()%></td>
      <td class = "grid" width="5%"><center><%=Utilitaria.formatarNumero(pedidoEntradaItemFiscal.getNfNvBC(), 2)%></center></td>
      <td class = "grid" width="5%"><center><%=Utilitaria.formatarNumero(pedidoEntradaItemFiscal.getNfNvICMS(), 2) %></center></td>
      <td class = "grid" width="5%"><center><%=Utilitaria.formatarNumero(pedidoEntradaItemFiscal.getNfNvBCST(), 2) %></center></td>
      <td class = "grid" width="5%"><center><%=Utilitaria.formatarNumero(pedidoEntradaItemFiscal.getNfNvICMSST(), 2) %></center></td>
      <td class = "grid" width="5%"><center><%=Utilitaria.formatarNumero(pedidoEntradaItemFiscal.getNfNpICMS(), 2) %></center></td>
      <td class = "grid" width="5%"><center><%=Utilitaria.formatarNumero(pedidoEntradaItemFiscal.getNfOvIPI(), 2) %></center></td>
      <%if(pedidoEntradaItem.getDtVal() != null){ %>
      	<td class = "grid" width="3%"><center><%=ConverteDate.dateToString(pedidoEntradaItem.getDtVal())%></center></td>
      <%}else{%>
      	<td class = "grid" width="1%"><center><%="--"%></center></td>
      <%}%>
      <td class = "grid" width="3%"><center><%=pedidoEntradaItem.getLoteFab()%></center></td>
      <td class = "grid" width="3%"><center><%=unidadeListar.getDsUnidade()%></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=pedidoEntradaItem.getIdPedidoEntradaItem()%>,<%=pedidoEntradaItem.getIdPedidoEntrada()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
      <%total = total +  precoItem;%>
  </tr>
  <input type="hidden" name="idPreco" value="<%=precoListar.getIdPreco()%>"/>
<%
		}
	}
	}
}
%>
   
   <input type="hidden"  id="cont" value="<%=cont%>"/>
<% 
 }
%>   
  <br>
  <tr>
      
      <th class="grid" width="5%"><center>TOTAL:</center></th>
      <td><input type="text" id="total" value="<%=Utilitaria.formatarNumero(total,2)%>" onblur="soma()"></td>
  </tr>
  <tr>
      <th class="grid" width="5%"><center>DESCONTO :(%)</center></th>
      <td><input disabled type="text" id="desconto" name ="desconto" value="<%=desconto%>" ></td>
  </tr>
  <tr>
      <input type="hidden"  id="total" value="<%=total%>"/>
      <th class="grid" width="5%"><center>Valor Total:</center></th>
      <%
        if(valor == 0){
        	valor = total;
        }
      %>
      <td><input type="text" id="valorTotal" name="valorTotal" value="<%=Utilitaria.formatarNumero(valor,2)%>"></td>
   
  </tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
    <br>
	<td><input class="button" type="button" value="Gravar" onClick="javascript: salvar();" />
</tr>
</table>
<%@include file="../fimConexao.jsp"%>

</form>