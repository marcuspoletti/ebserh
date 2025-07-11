<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.Produto"%>
<%@ page import="afero.model.Agrupamento"%>
<%@ page import="afero.model.PedidoSaidaSubItem"%>
<%@ page import="afero.model.PedidoSaidaSubItens"%>
<%@ page import="afero.model.PedidoSaidaSub"%>
<%@ page import="afero.model.Unidade"%>
<%@ page import="afero.model.Estoque"%>
<%@ page import="afero.model.Preco"%>
<%@ page import="afero.model.Loja"%>
<%@ page import="afero.persistence.ProdutoDAO"%>
<%@ page import="afero.persistence.AgrupamentoDAO"%>
<%@ page import="afero.persistence.PedidoSaidaSubDAO"%>
<%@ page import="afero.persistence.UnidadeDAO"%>
<%@ page import="afero.persistence.EstoqueDAO"%>
<%@ page import="afero.persistence.LojaDAO"%>
<%@ page import="afero.persistence.PrecoDAO"%>
<%@ page import="afero.persistence.PedidoSaidaSubItemDAO"%>
<%@ page import="afero.persistence.PedidoSaidaSubItensDAO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Iterator"%>
<%@page import="afero.util.Utilitaria"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/></script>

<script>


function recarregarDesconto() {
  var total = parseFloat((document.getElementById("total").value).replace(",","."));
  var valorTotal = parseFloat((document.getElementById("valorTotal").value).replace(",","."));
  var desconto = (total-valorTotal)/total*100;
  document.getElementById("desconto").value = desconto.toFixed(2);
}

function recarregar() {
  document.forms[0].submit();
}

function salvar() {
  document.forms[0].submit();
}

function confirmaExcluir(id, id1) {  
  if (confirm("Deseja mesmo apagar o último registro ?")) {  
	  location.href = 'itensPedido.jsp?acao=exc&idPedidoSaida='+id+'&idPedidoSaidaItem=' + id1;
  }  
}

document.onkeydown = function(e){
	var keychar;

	// Internet Explorer
	try {
	keychar = String.fromCharCode(event.keyCode);
	e = event;
	}

	// Firefox, Opera, Chrome, etc...
	catch(err) {
	keychar = String.fromCharCode(e.keyCode);
	}

	if (e.keyCode == 121) {
	window.location(confirmaExcluir(document.getElementById("id").value, document.getElementById("id1").value));
	//alert('Você digitou CTRL + A');
	return false;
	}
	if (e.keyCode == 122) {
		window.open('impressaoBobinaP.jsp?idPedidoSaida='+document.getElementById("idPedidoSaida").value,'endeavour','width=420,height=420,scrollbars=yes');
		//alert('Você digitou CTRL + A');
		return false;
	}

}
</script>
<%
String idLojaUsuario = (String)session.getAttribute("idLoja");
List list = null;
List listPrecoAtualizarValorUni = null;
List listarEstoque = null;
List listarOrcamentoDAO = null;
ProdutoDAO dao;
EstoqueDAO daoEstoque;
PedidoSaidaSubItemDAO daoPedidoSaidaItem;
PedidoSaidaSubItensDAO daoPedidoSaidaSubItens;
Produto prod = null;
Estoque estoque = null;
PedidoSaidaSubItem pedidoSaidaItem = null;
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
float valorTotal = 0;
float totalizador = 0;
String idPedidoSaida = "";
String idPedidoSaidaItem = "";
if(request.getParameter("idPedidoSaida")!= null){
	idPedidoSaida = request.getParameter("idPedidoSaida");
}else{
	idPedidoSaida = "N";
}
if(idPedidoSaida.length()==0)idPedidoSaida="N";
if(request.getParameter("idPedidoSaidaItem")!= null){
	idPedidoSaidaItem = request.getParameter("idPedidoSaidaItem");
}else{
	idPedidoSaidaItem = "0";
}


String impProducao = "";
float diferenca = 0;
float divisao = 0;
float percentual = 0;
float totalParcial = 0;

if(acao.equalsIgnoreCase("exc")) {
	idPedidoSaidaItem = request.getParameter("idPedidoSaidaItem");
	PedidoSaidaSubItem pedidoSaidaItemExcluir = new PedidoSaidaSubItem();
	PedidoSaidaSubItemDAO daoPedidoSaidaItemExcluir = new PedidoSaidaSubItemDAO(conn);
	pedidoSaidaItemExcluir.setIdPedidoSaidaItem(Integer.parseInt(request.getParameter("idPedidoSaidaItem")));
	daoPedidoSaidaItemExcluir.excluir(pedidoSaidaItemExcluir);
	acao="listar";
}
if(!idPedidoSaida.equalsIgnoreCase("N")){
	if(acao.equalsIgnoreCase("listar")) {
		PedidoSaidaSub pedSaida = new PedidoSaidaSub();
		PedidoSaidaSubDAO daoPedSaida = new PedidoSaidaSubDAO(conn);
		pedSaida = daoPedSaida.procurarPedidoSaidaItem(Integer.parseInt(idPedidoSaida));
		valorTotal = (float)pedSaida.getVlPed();
		desconto = pedSaida.getVlDesc();
	}
}


%>
<body onload="document.forms[0].elements[0].focus();" >
<form  action="itensPedido.jsp?acao=exc" method="post">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="idPedidoSaida" value="<%=idPedidoSaida%>"/>
<%-- mostra todos os registros do banco de dados --%>
<hr>
<table border="0" width="100%">
    <tr>
      <th class="grid"><center></center></th>
      <th class="grid"><center>Desc. do Prod.</center></th>
    <%--<th class="grid"><center>Agrup.</center></th> --%>  
    <%--<th class="grid">Comp</th> --%>
    <%--<th class="grid">Larg</th> --%>
     <%-- <th class="grid">Imp.Prod</th> --%>
      <th class="grid">Quant.</th>
      <%--<th class="grid"> Desc.(%)</th> --%>
      <th class="grid">Vl.Unit.(R$)</th>
      <th class="grid">Vl.Item(R$)</th>
      <th class="grid">Und</th>
      <%--<th class="grid">Fatias</th> --%>
      <%--<th class="grid">Vl. Sub Itens</th> --%>
      <%--<th class="grid">Excluir</th> --%>
      
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
if(!idPedidoSaida.equalsIgnoreCase("N")){
 String dsAgrupamento = "Nenhuma"; 
 float total = 0;
 float totalItens = 0;
 float maiorValorSubItem = 0;
 daoPedidoSaidaItem = new PedidoSaidaSubItemDAO(conn);
 daoPedidoSaidaSubItens = new PedidoSaidaSubItensDAO(conn);
 PrecoDAO daoPreAtuValorUni = new PrecoDAO(conn);
 Preco precoAtuValorUni = null;
 listPrecoAtualizarValorUni = daoPedidoSaidaItem.procurarPedidoSaidaItem(Integer.parseInt(idPedidoSaida));
 if(listPrecoAtualizarValorUni != null){
	  for ( Iterator itPrecoAtualizarValorUni = listPrecoAtualizarValorUni.iterator(); itPrecoAtualizarValorUni.hasNext(); ) {
		pedidoSaidaItem = (PedidoSaidaSubItem) itPrecoAtualizarValorUni.next();
		maiorValorSubItem = daoPedidoSaidaSubItens.maiorValor(pedidoSaidaItem.getIdPedidoSaidaItem());
		precoAtuValorUni = daoPreAtuValorUni.procurarPrecoPedidoItemIdProduto(pedidoSaidaItem.getIdProduto(), Integer.parseInt(idPedidoSaida));
		if(maiorValorSubItem > 0){
			if(maiorValorSubItem > precoAtuValorUni.getPreco()){
				daoPedidoSaidaItem.atualizarValorUnit(pedidoSaidaItem.getIdPedidoSaidaItem(), maiorValorSubItem, usuario);
			}else if(precoAtuValorUni.getPreco() >= maiorValorSubItem){
				daoPedidoSaidaItem.atualizarValorUnit(pedidoSaidaItem.getIdPedidoSaidaItem(), precoAtuValorUni.getPreco(), usuario);
			}
		}else{
			precoAtuValorUni = daoPreAtuValorUni.procurarPrecoIdProduto(pedidoSaidaItem.getIdProduto());
			daoPedidoSaidaItem.atualizarValorUnit(pedidoSaidaItem.getIdPedidoSaidaItem(), precoAtuValorUni.getPreco(), usuario);
			
		}
		
	  }
 }
 list = daoPedidoSaidaItem.procurarPedidoSaidaItem(Integer.parseInt(idPedidoSaida));
 if(list != null){
  for ( Iterator it = list.iterator(); it.hasNext(); ) {
	pedidoSaidaItem = (PedidoSaidaSubItem) it.next();
	maiorValorSubItem = daoPedidoSaidaSubItens.maiorValor(pedidoSaidaItem.getIdPedidoSaidaItem());
	if(maiorValorSubItem >= pedidoSaidaItem.getVlUni()){
		daoPedidoSaidaItem.atualizarValorUnit(pedidoSaidaItem.getIdPedidoSaidaItem(), maiorValorSubItem, usuario);
	}
	if(daoPedidoSaidaItem.getImpProducao(pedidoSaidaItem.getIdPedidoSaidaItem())!= null){
		impProducao = daoPedidoSaidaItem.getImpProducao(pedidoSaidaItem.getIdPedidoSaidaItem());
	}else{
		impProducao = "N";
	}
	dao = new ProdutoDAO(conn);
	prod = dao.procurarProduto(pedidoSaidaItem.getIdProduto());
	if(daoPedidoSaidaItem.getidPedidoItem(pedidoSaidaItem.getIdPedidoSaidaItem())){
		//total+=daoPedidoSaidaItem.getValorSubItens(pedidoSaidaItem.getIdPedidoSaidaItem());
		//totalItens = daoPedidoSaidaItem.getValorSubItens(pedidoSaidaItem.getIdPedidoSaidaItem());
	}
	if(daoPedidoSaidaItem.getIdAgrupamentoPedido(pedidoSaidaItem.getIdAgrupamento())){
		AgrupamentoDAO daoAgrupamento = new AgrupamentoDAO(conn);
		Agrupamento itensAgrupOrcamento = daoAgrupamento.procurarAgrupamento(pedidoSaidaItem.getIdAgrupamento());
		if(itensAgrupOrcamento.getDsAgrupamento() != null){
			dsAgrupamento = itensAgrupOrcamento.getDsAgrupamento();
		}
	}
	
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
      <%if(pedidoSaidaItem.getDsCompProduto() != null){ %>
      <td class = "grid" width="10%"><center><%=prod.getDsProduto()+". "+ pedidoSaidaItem.getDsCompProduto()%></center></td>
      <%}else{ %>
       <td class = "grid" width="10%"><center><%=prod.getDsProduto()%></center></td>
      <%} %>
      <%--
      <%if(impProducao.equalsIgnoreCase("S")){ %>
       	<td class = "grid" width="3%"><%="SIM"%></td>
      <%}else{ %>
     	 <td class = "grid" width="3%"><font color="red"><i><%="NÃO"%></i></font></td>
      <%}%> --%>
      <%--<td class = "grid" width="5%"><center><%=dsAgrupamento%></center></td> --%>
      <%--<td class="grid" width="3%" name="comprimento" size="10" maxlength="10"><%=pedidoSaidaItem.getComp()%></td> --%>
      <%--<td class="grid" width="3%" name="largura" size="10" maxlength="10"><%=pedidoSaidaItem.getLarg()%></td> --%>
      <td class="grid" width="3%" name="quantidade" size="10" maxlength="10"><%=pedidoSaidaItem.getQuant()%></td>
      <%--<td class="grid" width="3%" name="pDesc" size="10" maxlength="10"><%=Utilitaria.formatarNumero(pedidoSaidaItem.getpDesc(),2)%></td> --%>
      <td class="grid" width="3%" name="valor" size="10" maxlength="10"><%=Utilitaria.formatarNumero(pedidoSaidaItem.getValor(),2)%></td>
      <%float precoItem = pedidoSaidaItem.getValor() * pedidoSaidaItem.getQuant(); %>
      <td class="grid" width="3%" name="preco_<%=precoListar.getIdPreco()%>" size="10" maxlength="10"><%=Utilitaria.formatarNumero(precoItem,2)%></td>
      <td class = "grid" width="3%"><center><%=unidadeListar.getDsUnidade()%></center></td>
      <%--<td class = "grid" width="3%"><center><a target="_blank" href="formCadastroSubItens.jsp?idPedidoSaida=<%=pedidoSaidaItem.getIdPedidoSaida()%>&idPedidoSaidaItem=<%=pedidoSaidaItem.getIdPedidoSaidaItem()%>&idLoja=<%=idLojaUsuario%>&nomeProduto=<%=prod.getDsProduto()%>&acao=inc"><img border = "0" src="../images/recado.gif"></a></center></td> --%>
      <%--<td class = "grid" width="4%" size="7" maxlength="10"><center><%=Utilitaria.formatarNumero(totalItens,2)%></center></td> --%>
      <%totalItens = 0; %>
      <%--
      <%if(!daoPedidoSaidaItem.getidPedidoItem(pedidoSaidaItem.getIdPedidoSaidaItem())){ %> 
           <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=pedidoSaidaItem.getIdPedidoSaida()%>,<%=pedidoSaidaItem.getIdPedidoSaidaItem()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
      <%}else{ %>
            <td class = "grid" width="4%" size="15" maxlength="15"><center><%="Possui Sub Itens"%></center></td>
      <%} %> 
      --%>
      <%total = total +  precoItem;%>
      
      <input type="hidden" name="idPreco" value="<%=precoListar.getIdPreco()%>"/>
      
      
      
  </tr>
  	
	
<%
		}
	}
	%>
	<input type="hidden"  id="cont" name="cont" value="<%=cont%>"/>
	<%
	}
}
%>
         <input type="hidden" name="idPedidoSaidaItem" value="<%=pedidoSaidaItem.getIdPedidoSaidaItem()%>"/>
	<input type="hidden" name="id1" value="<%=pedidoSaidaItem.getIdPedidoSaidaItem()%>"/>
	<input type="hidden" name="id" value="<%=idPedidoSaida%>"/>
  
<% 
 }
}
%>   
</table>
<table>
<tr>
<td>
  <iframe src="frameTotal.jsp?idPedidoSaida=<%=idPedidoSaida%>" name="frameTotal" width="100%" height="50" scrolling="auto" align="top" frameborder="0" hspace="0" vspace="0" marginheight="0" marginwidth="0"></iframe>
 </td>
 </tr>
</table>
</form>
<%@include file="../fimConexao.jsp"%>