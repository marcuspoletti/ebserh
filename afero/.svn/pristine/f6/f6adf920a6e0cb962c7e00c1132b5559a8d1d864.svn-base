<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.Produto" %>
<%@ page import="afero.model.PedidoSaidaSubItens" %>
<%@ page import="afero.model.PedidoSaidaSubItem" %>
<%@ page import="afero.model.Unidade" %>
<%@ page import="afero.model.Estoque" %>
<%@ page import="afero.model.Preco" %>
<%@ page import="afero.model.Loja" %>
<%@ page import="afero.persistence.ProdutoDAO" %>
<%@ page import="afero.persistence.PedidoSaidaSubItemDAO" %>
<%@ page import="afero.persistence.UnidadeDAO" %>
<%@ page import="afero.persistence.EstoqueDAO" %>
<%@ page import="afero.persistence.LojaDAO" %>
<%@ page import="afero.persistence.PrecoDAO" %>
<%@ page import="afero.persistence.PedidoSaidaSubItensDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@page import="afero.util.Utilitaria"%>
<%@include file="../../seguranca.jsp"%>
<%@include file="../../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../../css/afero.css" />
<script src="../../js/common.js"/></script>

<script>

function recarregar() {
  document.forms[0].action="itensPedidoSubItens.jsp?acao=atu";
  document.forms[0].submit();
}



function salvar() {
  document.forms[0].submit();
}

function confirmaExcluir(cont, id, id1) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'itensPedidoItemSubItens.jsp?acao=exc&idPedidoSaidaSubItem='+id+'&idPedidoSaidaItem=' + id1;   
  }  
}
</script>
<%
String idPedidoSaida = request.getParameter("idPedidoSaida");
if(idPedidoSaida == null)idPedidoSaida = "0";
String idLojaUsuario = (String)session.getAttribute("idLoja");
List list = null;
List listarEstoque = null;
List listarOrcamentoDAO = null;
List listAtualizarValorUni = null;
ProdutoDAO dao;
EstoqueDAO daoEstoque;
PedidoSaidaSubItensDAO daoPedidoSaidaItem;
PedidoSaidaSubItemDAO daoPedidoSaidaItemAtualizarValorUni;
Produto prod = null;
Estoque estoque = null;
PedidoSaidaSubItens pedidoSaidaItem = null;
PedidoSaidaSubItem pedidoSaidaItemAtuValorUni = null;
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
String usuario = (String)session.getAttribute("Login");
double valorTotal = 0;
double totalizador = 0;
String idPedidoSaidaItem = request.getParameter("idPedidoSaidaItem");
if(idPedidoSaidaItem == null)idPedidoSaidaItem="0";

if(acao.equalsIgnoreCase("exc")) {
	String idPedidoSaidaSubItem = request.getParameter("idPedidoSaidaSubItem");
	PedidoSaidaSubItens pedidoSaidaItemExcluir = new PedidoSaidaSubItens();
	PedidoSaidaSubItensDAO daoPedidoSaidaItemExcluir = new PedidoSaidaSubItensDAO(conn);
	pedidoSaidaItemExcluir.setIdPedidoSaidaSubItem(Integer.parseInt(idPedidoSaidaSubItem));
	daoPedidoSaidaItemExcluir.excluir(pedidoSaidaItemExcluir);
	acao="listar";
}
%>
<body onload="document.forms[0].elements[0].focus();" >
<form action="itensPedidoItem.jsp?acao=atu" method="post">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="cont" value="<%=cont%>"/>
<hr>
<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr>
      <th class="grid"><center></center></th>
      <th class="grid"><center>Desc. do Prod.</center></th>
      <%--<th class="grid">Comp</th> --%>
      <%--<th class="grid">Larg</th> --%>
      <th class="grid">Quant.</th>
     <%--<th class="grid"> Desc.(%)</th>
      <th class="grid">Vl.Unit.(R$)</th>
      <th class="grid">Vl.Item(R$)</th> --%> 
      <th class="grid">Und</th>
      <th class="grid">Excluir</th>
      
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
 float totalQuant = 0; 
 float total = 0;
 float maiorValor = 0;
 float maiorAtuValorItem = 0;
 int idPedidoSaidaItemMaiorValor = 0;
 daoPedidoSaidaItemAtualizarValorUni = new PedidoSaidaSubItemDAO(conn);
 daoPedidoSaidaItem = new PedidoSaidaSubItensDAO(conn);
 List listAtuPreco = daoPedidoSaidaItem.listarPedidoSaidaSubItensList(Integer.parseInt(idPedidoSaidaItem));
 if(listAtuPreco != null){
	  maiorValor = daoPedidoSaidaItem.maiorValor(Integer.parseInt(idPedidoSaidaItem));
	  for ( Iterator itAtuPreco = listAtuPreco.iterator(); itAtuPreco.hasNext(); ) { 
		  pedidoSaidaItem = (PedidoSaidaSubItens) itAtuPreco.next();
		  daoPedidoSaidaItem.atualizarValorUnit(pedidoSaidaItem.getIdPedidoSaidaSubItem(), maiorValor, usuario);
	  }
 }
 /**
 listAtualizarValorUni = daoPedidoSaidaItemAtualizarValorUni.procurarPedidoSaidaItem(Integer.parseInt(idPedidoSaida));
 if(listAtualizarValorUni != null){
	  for ( Iterator itAtualizarValorUni = listAtualizarValorUni.iterator(); itAtualizarValorUni.hasNext(); ) {
		pedidoSaidaItemAtuValorUni = (PedidoSaidaSubItem) itAtualizarValorUni.next();
		maiorAtuValorItem = daoPedidoSaidaItemAtualizarValorUni.maiorValor(pedidoSaidaItemAtuValorUni.getIdPedidoSaidaItem());
		
		if(maiorAtuValorItem >= pedidoSaidaItemAtuValorUni.getVlUni()){
			daoPedidoSaidaItemAtualizarValorUni.atualizarValorUnit(pedidoSaidaItemAtuValorUni.getIdPedidoSaidaItem(), maiorAtuValorItem, usuario);
		}
	  }
 }
 */
 list = daoPedidoSaidaItem.listarPedidoSaidaSubItensListCompProduto(Integer.parseInt(idPedidoSaidaItem));
 if(list != null){
  for ( Iterator it = list.iterator(); it.hasNext(); ) {
	
	pedidoSaidaItem = (PedidoSaidaSubItens) it.next();
	dao = new ProdutoDAO(conn);
	prod = dao.procurarProduto(pedidoSaidaItem.getIdProduto());
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
			
			//preco = Utilitaria.formatarNumero(precoListar.getPreco(), 2).toString();
			preco = Utilitaria.formatarNumero(pedidoSaidaItem.getVlUni(), 2).toString();
			UnidadeDAO daoUnidade = new UnidadeDAO(conn);
			Unidade unidadeListar = daoUnidade.procurarUnidade(precoListar.getIdUnidade());
			
			  	
			
%>
    <tr>
      <td class = "grid" width="1%"><center><%=cont%></center></td>
      <td class = "grid" width="10%"><center><%=prod.getDsProduto()+". "+pedidoSaidaItem.getDsCompProduto()%></center></td>
      <%--<td class="grid" width="3%" name="comprimento" size="7" maxlength="7"><%=pedidoSaidaItem.getComp()%></td> --%>
      <%--<td class="grid" width="3%" name="largura" size="7" maxlength="7"><%=pedidoSaidaItem.getLarg()%></td> --%>
      <td class="grid" width="3%" name="quantidade" size="7" maxlength="7"><%=pedidoSaidaItem.getQuant()%></td>
      <%--<td class="grid" width="3%" name="pDesc" size="7" maxlength="7"><%=Utilitaria.formatarNumero(pedidoSaidaItem.getpDesc(),2)%></td> --%>
      <%--<td class="grid" width="3%" name="vlUni" size="7" maxlength="7"><%=Utilitaria.formatarNumero(pedidoSaidaItem.getVlUni(),2)%></td> --%>
      <%float precoItem = Utilitaria.toNumber(preco).floatValue() * pedidoSaidaItem.getQuant(); %>
      <%totalQuant += pedidoSaidaItem.getQuant();%>
      <%--<td class="grid" width="3%" name="preco_<%=precoListar.getIdPreco()%>" size="7" maxlength="10"><%=Utilitaria.formatarNumero(precoItem,2)%></td> --%>
      <td class = "grid" width="3%"><center><%=unidadeListar.getDsUnidade()%></center></td> 
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=pedidoSaidaItem.getIdPedidoSaidaSubItem()%>,<%=pedidoSaidaItem.getIdPedidoSaidaItem()%>);"><img border = "0" src="../../images/delete.gif"></a></center></td>
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
      <th class="grid" width="5%"><center>TOTAL DE FATIAS:</center></th>
      <td class = "grid" width="3%"><center><%=Utilitaria.formatarNumero(totalQuant,2)%></center></td>
  </tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
</table>
</form>
<%@include file="../../fimConexao.jsp"%>