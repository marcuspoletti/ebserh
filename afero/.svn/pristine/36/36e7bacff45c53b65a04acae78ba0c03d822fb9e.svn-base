<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.Produto" %>
<%@ page import="afero.model.Agrupamento" %>
<%@ page import="afero.model.PedidoSaidaSubItem" %>
<%@ page import="afero.model.PedidoSaidaSub" %>
<%@ page import="afero.model.Unidade" %>
<%@ page import="afero.model.Estoque" %>
<%@ page import="afero.model.Preco" %>
<%@ page import="afero.model.Loja" %>
<%@ page import="afero.persistence.ProdutoDAO" %>
<%@ page import="afero.persistence.AgrupamentoDAO" %>
<%@ page import="afero.persistence.PedidoSaidaSubDAO" %>
<%@ page import="afero.persistence.UnidadeDAO" %>
<%@ page import="afero.persistence.EstoqueDAO" %>
<%@ page import="afero.persistence.LojaDAO" %>
<%@ page import="afero.persistence.PrecoDAO" %>
<%@ page import="afero.persistence.PedidoSaidaSubItemDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@page import="afero.util.Utilitaria"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/>"</script>

<script>

function recarregar() {
  document.forms[0].action="itensPedidoItemSubItem.jsp?acao=atu";
  document.forms[0].submit();
}



function salvar() {
  document.forms[0].submit();
}

function confirmaExcluir(cont, id, id1) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'itensPedidoItemSubItem.jsp?acao=exc&idPedidoSaida='+id+'&idPedidoSaidaItem=' + id1;   
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
PedidoSaidaSubItemDAO daoPedidoSaidaItem;
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

double valorTotal = 0;
double totalizador = 0;
String idPedidoSaida = request.getParameter("idPedidoSaida");

if(acao.equalsIgnoreCase("exc")) {
	String idPedidoSaidaItem = request.getParameter("idPedidoSaidaItem");
	PedidoSaidaSubItem pedidoSaidaItemExcluir = new PedidoSaidaSubItem();
	PedidoSaidaSubItemDAO daoPedidoSaidaItemExcluir = new PedidoSaidaSubItemDAO(conn);
	pedidoSaidaItemExcluir.setIdPedidoSaidaItem(Integer.parseInt(request.getParameter("idPedidoSaidaItem")));
	daoPedidoSaidaItemExcluir.excluir(pedidoSaidaItemExcluir);
	acao="listar";
}
if(acao.equalsIgnoreCase("atu")) {
	
	PedidoSaidaSub pedidoSaida = new PedidoSaidaSub();
	PedidoSaidaSubDAO daoPedidoSaida = new PedidoSaidaSubDAO(conn);
	pedidoSaida = daoPedidoSaida.procurarPedidoSaida(Integer.parseInt(idPedidoSaida));
	if(request.getParameter("valorTotal")!= null){
		valorTotal = Utilitaria.toNumber(request.getParameter("valorTotal")).doubleValue();	
		pedidoSaida.setVlPed(valorTotal);
	}
	if(request.getParameter("desconto") != null){
		desconto = Float.parseFloat(request.getParameter("desconto"));
		pedidoSaida.setVlDesc(desconto);
		totalizador = Utilitaria.toNumber(request.getParameter("total")).doubleValue();	
	    pedidoSaida.setVlPed(totalizador - (totalizador *(desconto/100)));
		
	}
	daoPedidoSaida.atualizar(pedidoSaida);
    
    PedidoSaidaSub pedSaida = new PedidoSaidaSub();
	PedidoSaidaSubDAO daoPedSaida = new PedidoSaidaSubDAO(conn);
	pedSaida = daoPedSaida.procurarPedidoSaidaItem(Integer.parseInt(idPedidoSaida));
	valorTotal = pedSaida.getVlPed();
	desconto = pedSaida.getVlDesc();
}
if(acao.equalsIgnoreCase("listar")) {
	PedidoSaidaSub pedSaida = new PedidoSaidaSub();
	PedidoSaidaSubDAO daoPedSaida = new PedidoSaidaSubDAO(conn);
	pedSaida = daoPedSaida.procurarPedidoSaidaItem(Integer.parseInt(idPedidoSaida));
	//valorTotal = pedSaida.getVlPed();
	desconto = pedSaida.getVlDesc();
}


%>
<body onload="document.forms[0].elements[0].focus();" >
<form action="itensPedidoItemSubItem.jsp?acao=atu" method="post">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="cont" value="<%=cont%>"/>
<input type="hidden" name="idPedidoSaida" value="<%=idPedidoSaida%>"/>
<%-- mostra todos os registros do banco de dados --%>
<hr>
<table border="0" width="100%">
    <tr>
      <th class="grid"><center></center></th>
      <th class="grid"><center>Desc. do Prod.</center></th>
      <th class="grid"><center>Agrup.</center></th>
       <th class="grid">Comp</th>
      <th class="grid">Larg</th>
      <th class="grid">Quant.</th>
      <th class="grid"> Desc.(%)</th>
      <th class="grid">Vl.Unit.(R$)</th>
      <th class="grid">Vl.Item(R$)</th>
      <th class="grid">Und</th>
      <th class="grid">Sub Itens</th>
      <th class="grid">Vl. Sub Itens</th>
      <th class="grid">Excluir</th>
      
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
 String dsAgrupamento = "Nenhuma"; 
 float total = 0;
 float totalItens = 0;
 daoPedidoSaidaItem = new PedidoSaidaSubItemDAO(conn);
 list = daoPedidoSaidaItem.procurarPedidoSaidaItem(Integer.parseInt(idPedidoSaida));
 if(list != null){
  for ( Iterator it = list.iterator(); it.hasNext(); ) {
	pedidoSaidaItem = (PedidoSaidaSubItem) it.next();
	dao = new ProdutoDAO(conn);
	prod = dao.procurarProduto(pedidoSaidaItem.getIdProduto());
	if(daoPedidoSaidaItem.getidPedidoItem(pedidoSaidaItem.getIdPedidoSaidaItem())){
		total+=daoPedidoSaidaItem.getValorSubItens(pedidoSaidaItem.getIdPedidoSaidaItem());
		totalItens = daoPedidoSaidaItem.getValorSubItens(pedidoSaidaItem.getIdPedidoSaidaItem());
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
      <td class = "grid" width="5%"><center><%=dsAgrupamento%></center></td>
      <td class="grid" width="3%" name="comprimento" size="10" maxlength="10"><%=pedidoSaidaItem.getComp()%></td>
      <td class="grid" width="3%" name="largura" size="10" maxlength="10"><%=pedidoSaidaItem.getLarg()%></td>
      <td class="grid" width="3%" name="quantidade" size="10" maxlength="10"><%=pedidoSaidaItem.getQuant()%></td>
      <td class="grid" width="3%" name="pDesc" size="10" maxlength="10"><%=Utilitaria.formatarNumero(pedidoSaidaItem.getpDesc(),2)%></td>
      <td class="grid" width="3%" name="vlUni" size="10" maxlength="10"><%=Utilitaria.formatarNumero(pedidoSaidaItem.getVlUni(),2)%></td>
      <%float precoItem = Utilitaria.toNumber(preco).floatValue() * pedidoSaidaItem.getQuant(); %>
      <td class="grid" width="3%" name="preco_<%=precoListar.getIdPreco()%>" size="10" maxlength="10"><%=Utilitaria.formatarNumero(precoItem,2)%></td>
      <td class = "grid" width="3%"><center><%=unidadeListar.getDsUnidade()%></center></td>
      <td class = "grid" width="3%"><center><a target="_blank" href="formCadastroSubItens.jsp?idPedidoSaida=<%=pedidoSaidaItem.getIdPedidoSaida()%>&idPedidoSaidaItem=<%=pedidoSaidaItem.getIdPedidoSaidaItem()%>&idLoja=<%=idLojaUsuario%>&acao=inc"><img border = "0" src="../images/recado.gif"></a></center></td>
       <td class = "grid" width="4%" size="7" maxlength="10"><center><%=Utilitaria.formatarNumero(totalItens,2)%></center></td>
      <%totalItens = 0; %>
      <%if(!daoPedidoSaidaItem.getidPedidoItem(pedidoSaidaItem.getIdPedidoSaidaItem())){ %> 
           <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=pedidoSaidaItem.getIdPedidoSaida()%>,<%=pedidoSaidaItem.getIdPedidoSaidaItem()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
      <%}else{ %>
            <td class = "grid" width="4%" size="15" maxlength="15"><center><%="Possui Sub Itens"%></center></td>
      <%} %> 
     
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
      <%
        	valorTotal = total - (total *(desconto/100));	
            PedidoSaidaSub pedidoSaida = new PedidoSaidaSub();
  	        PedidoSaidaSubDAO daoPedidoSaida = new PedidoSaidaSubDAO(conn);
  	        pedidoSaida = daoPedidoSaida.procurarPedidoSaida(Integer.parseInt(idPedidoSaida));	
  		    pedidoSaida.setVlPed(valorTotal);
  		    pedidoSaida.setVlDesc(desconto);
  	        pedidoSaida.setVlPed(valorTotal);
        	daoPedidoSaida.atualizar(pedidoSaida);
      %>
      
      <th class="grid" width="5%"><center>TOTAL:</center></th>
      <td class = "grid" width="3%"><center><%=Utilitaria.formatarNumero(total,2)%></center></td>
  </tr>
  <tr>
      <th class="grid" width="5%"><center>DESCONTO :(%)</center></th>
      <td><input  type="text" id="desconto" name ="desconto" value="<%=desconto%>" onblur="recarregar()" ></td>
          
  </tr>
  <tr>
      
      <th class="grid" width="5%"><center>Valor Total:</center></th>
   
      <td class = "grid" width="3%"><center><%=Utilitaria.formatarNumero(valorTotal,2)%></center></td>
      
      <input type="hidden"  id="total" name="total" value="<%=Utilitaria.formatarNumero(total,2)%>"/>
      <input type="hidden"  id="valorTotal" name="valorTotal" value="<%=Utilitaria.formatarNumero(valorTotal,2)%>"/>
  </tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
    <br>
	<td><input class="button" type="button" value="Gravar" onClick="javascript: recarregar();" />
</tr>
</table>
</form>
<%@include file="../fimConexao.jsp"%>