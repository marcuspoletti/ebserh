<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.Orcamento"%>
<%@page import="afero.model.PedidoEntrada"%>
<%@page import="afero.model.PedidoEntradaItem"%>
<%@page import="afero.model.OrcamentoPedidoSaida"%>
<%@page import="afero.model.OrdemServico"%>
<%@page import="afero.model.OrcamentoItem"%>
<%@page import="afero.model.Entidade"%>
<%@page import="afero.model.Entrega"%>
<%@page import="afero.model.Colaborador"%>
<%@page import="afero.model.Loja"%>
<%@page import="afero.persistence.LojaDAO"%>
<%@page import="afero.persistence.EstoqueDAO"%>
<%@page import="afero.persistence.EntidadeDAO"%>
<%@page import="afero.persistence.PedidoEntradaDAO"%>
<%@page import="afero.persistence.EntregaDAO"%>
<%@page import="afero.persistence.OrcamentoDAO"%>
<%@page import="afero.persistence.ColaboradorDAO"%>
<%@page import="afero.persistence.OrcamentoPedidoSaidaDAO"%>
<%@page import="afero.persistence.OrdemServicoDAO"%>
<%@page import="afero.persistence.PedidoEntradaItemDAO"%>
<%@ page import="afero.util.Utilitaria" %>
<%@ page import="afero.util.ConverteDate" %>
<%@ page import="afero.model.Produto" %>
<%@ page import="afero.model.Unidade" %>
<%@ page import="afero.model.Estoque" %>
<%@ page import="afero.model.Preco" %>
<%@ page import="afero.persistence.ProdutoDAO" %>
<%@ page import="afero.persistence.UnidadeDAO" %>
<%@ page import="afero.persistence.EstoqueDAO" %>
<%@ page import="afero.persistence.PrecoDAO" %>
<%@ page import="afero.persistence.OrcamentoItemDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@page import="afero.util.Utilitaria"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/></script>
<script>
function salvar() {
  	document.forms[0].submit();
}
</script>
<%
String idLojaUsuario = (String)session.getAttribute("idLoja");
String mensagem = request.getParameter("mensagem");
if(mensagem == null)mensagem = "";
PedidoEntradaDAO daoPedidoEntrada = new PedidoEntradaDAO(conn);
String acao = request.getParameter("acao");
if(acao == null)acao="listar";
List list = null;
List listarEstoque = null;
ProdutoDAO dao;
EstoqueDAO daoEstoque;
PedidoEntradaItemDAO daoPedidoEntradaItem;
Produto prod = null;
Estoque estoque =null;
Preco precoInserir = new Preco();
Preco precoVenda = null;
PrecoDAO daoPrecoEntrada = new PrecoDAO(conn);
PedidoEntradaItem pedidoEntradaItem = null;
PedidoEntradaItem pedidoEntradaItemFiscal = null;
int cont = 0;
String preco = "0";
ConverteDate converte = new ConverteDate();
String idPedidoEntrada = request.getParameter("idPedidoEntrada");
PedidoEntrada pedidoEntrada = daoPedidoEntrada.procurarPedidoEntrada(Integer.parseInt(idPedidoEntrada));
int idColaborador =pedidoEntrada.getIdColaborador();
Colaborador colaborador = new Colaborador();
ColaboradorDAO daoColaborador = new ColaboradorDAO(conn);
colaborador = daoColaborador.procurarColaborador(idColaborador);
String dsColaborador = colaborador.getNome();
String usuario = (String)session.getAttribute("Login");
int idLoja = pedidoEntrada.getIdLoja();
Loja lojaListar = new Loja();
LojaDAO daoLoja = new LojaDAO(conn);
lojaListar = daoLoja.procurarLoja(idLoja);
String dsLoja = lojaListar.getApelido() +" / "+ lojaListar.getRazaoSocial(); 
int cdEntidade =pedidoEntrada.getCdEntidade();
Entidade entidade = new Entidade();
EntidadeDAO daoEntidade = new EntidadeDAO(conn);
entidade = daoEntidade.procurarEntidade(cdEntidade);
String dsEntidade = entidade.getNome();
String status = pedidoEntrada.getStatus();
String operacao = pedidoEntrada.getOperacao();
String dtPed =converte.dateToString(pedidoEntrada.getDtPed());
String dtMov = converte.dateToString(pedidoEntrada.getDtMov());
String observacao = pedidoEntrada.getObservacao();
double valorTotal = pedidoEntrada.getVlPed();
PrecoDAO daoPreco = new PrecoDAO(conn);
if(acao.equalsIgnoreCase("gravar")){
	if(!status.equalsIgnoreCase("A")){
		status = request.getParameter("status");
		if(status.equalsIgnoreCase("A") || status.equalsIgnoreCase("F")){
			pedidoEntrada.setStatus("A");
			daoPedidoEntrada.atualizar(pedidoEntrada);
			Estoque estoqueUpdate = null;
			daoPedidoEntradaItem = new PedidoEntradaItemDAO(conn);
			list = daoPedidoEntradaItem.listarProcurarPedidoEntradaItem(pedidoEntrada.getIdPedidoEntrada());
			for ( Iterator it = list.iterator(); it.hasNext(); ) {
				pedidoEntradaItem = (PedidoEntradaItem) it.next();
				EstoqueDAO daoEstoqueProcurar = new EstoqueDAO(conn);
				estoqueUpdate = daoEstoqueProcurar.procurarEstoque(pedidoEntradaItem.getIdProduto(), idLoja);
				estoqueUpdate.estoqueCompra(estoqueUpdate.getQtEstoque(), pedidoEntradaItem.getQuantPedida());
				EstoqueDAO daoEstoqueUpdate = new EstoqueDAO(conn);
				daoEstoqueUpdate.atualizar(estoqueUpdate);
				precoVenda = daoPreco.procurarPrecoEstoqueLoja(estoqueUpdate.getIdEstoque(), idLoja);
				daoPrecoEntrada.atualizarPrecoEntradaFinalizar(estoqueUpdate.getIdEstoque(), usuario);
		  		precoInserir.setCustoDireto(0);
		  		precoInserir.setCustoMedioGeral(0);
		  		precoInserir.setCustoReal(0);
		  		precoInserir.setIdEstoque(estoqueUpdate.getIdEstoque());
		  		precoInserir.setUsuario(usuario);
		  		precoInserir.setIdUnidade(pedidoEntradaItem.getIdUnidade());
		  		precoInserir.setUltimoCustoCompra(pedidoEntradaItem.getValor());
		  		precoInserir.setPreco(precoVenda.getPreco());
		  		daoPrecoEntrada.incluirEntrada(precoInserir);
			}
		}else{
			pedidoEntrada.setStatus(status);
			daoPedidoEntrada.atualizar(pedidoEntrada);
		}
	}else{
		response.sendRedirect("compras.jsp?mensagem=Já foi Atendido o Pedido de Entrada&idPedidoEntrada=" + idPedidoEntrada);
	}
}

%>
<body onload="document.forms[0].elements[2].focus();" >
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<h1 class="cabecalho_pagina">Compra</h1>
<form method="post" action="compras.jsp?acao=<%="gravar"%>">
<input type="hidden" name="idPedidoEntrada" value="<%=idPedidoEntrada%>"/>
<table border="0" width="100%">
   <tr>
    <th class="label">Loja</th>
    <td><input disabled type="text" name="dsLoja" <%if (dsLoja != null) { %>value="<%=dsLoja%>"<% }%>  size="60" maxlength="60"></td>
  </tr>
     <tr>
    <th class="label">Colaborador</th>
    <td><input disabled type="text" name="dsColaborador" <%if (dsColaborador != null) { %>value="<%=dsColaborador%>"<% }%>  size="60" maxlength="60"></td>
  </tr>
  <tr>
    <th class="label">Fornecedor / Distribuidor</th>
    <td><input disabled type="text" name="dsEntidade" <%if (dsEntidade != null) { %>value="<%=dsEntidade%>"<% }%>  size="60" maxlength="60"></td>
  </tr>
   <tr>
    <th class="label">Data do Pedido</th>
    <td><input disabled type="text" name="dtPed" <%if (dtPed!= null) { %>value="<%=dtPed%>"<% }%>  size="30" maxlength="30"></td>
  </tr>
  <tr>
    <th class="label">Data da Movimentação</th>
    <td><input disabled type="text" name="dtMov" <%if (dtMov!= null) { %>value="<%=dtMov%>"<% }%>  size="30" maxlength="30"></td>
  </tr>
  <tr>
      <th class="label">Observação</th>
      <td><textarea disabled="disabled"name="observacao" cols="60" rows="5"><%=observacao%></textarea></td>
  </tr>
  <tr>
    <th class="label" colspan="1">Status</th>
    <td class="label_radio">
      <input type="radio" class="radio" name="status" value="P" <%= (status.equals("P")? "checked": "") %>>Pendente
      <input type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Atendido
      <input type="radio" class="radio" name="status" value="F" <%= (status.equals("F")? "checked": "") %>>Faturado
      <input type="radio" class="radio" name="status" value="C" <%= (status.equals("C")? "checked": "") %>>Cancelado
    </td>
  </tr>
  <tr>
    <th class="label" colspan="1">Operação</th>
    <td class="label_radio">
      <input type="radio" class="radio" name="operacao" value="E" <%= (operacao.equals("E")? "checked": "") %>>Entrada
      <input disabled type="radio" class="radio" name="operacao" value="T" <%= (operacao.equals("T")? "checked": "") %>>Transferência<br>
      <input disabled type="radio" class="radio" name="operacao" value="ES" <%= (operacao.equals("ES")? "checked": "") %>>Estorno de Saída Por Devolução
      <input disabled type="radio" class="radio" name="operacao" value="AE" <%= (operacao.equals("AE")? "checked": "") %>>Ajuste de Entrada
    </td>
  </tr>
</table><hr>
<table border="0" width="100%">
    <tr>
      <th class="grid"><center></center></th>
      <th class="grid">Loja</th>
      <th class="grid"><center>Descrição do Produto</center></th>
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
      <th class="grid">Unidade</th>
      
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
      <%float precoItem = pedidoEntradaItem.getValor() * pedidoEntradaItem.getQuant(); %>
      <td class="grid" width="3%" name="preco_<%=precoListar.getIdPreco()%>" size="10" maxlength="10"><%=Utilitaria.formatarNumero(pedidoEntradaItem.getValor(),2)%></td>
      <td class = "grid" width="5%"><center><%=pedidoEntradaItemFiscal.getNfNCST() %></center></td>
      <td class = "grid" width="5%"><center><%=pedidoEntradaItemFiscal.getNfICFOP() %></center></td>
      <td class="grid" width="3%" name="quantidade%>" size="10" maxlength="10"><%=Utilitaria.formatarNumero(pedidoEntradaItem.getQuant(),2)%></td>
      <td class = "grid" width="5%"><center><%=Utilitaria.formatarNumero(pedidoEntradaItemFiscal.getNfNvBC(), 2)%></center></td>
      <td class = "grid" width="5%"><center><%=Utilitaria.formatarNumero(pedidoEntradaItemFiscal.getNfNvICMS(), 2) %></center></td>
      <td class = "grid" width="5%"><center><%=Utilitaria.formatarNumero(pedidoEntradaItemFiscal.getNfNvBCST(), 2) %></center></td>
      <td class = "grid" width="5%"><center><%=Utilitaria.formatarNumero(pedidoEntradaItemFiscal.getNfNvICMSST(), 2) %></center></td>
      <td class = "grid" width="5%"><center><%=Utilitaria.formatarNumero(pedidoEntradaItemFiscal.getNfNpICMS(), 2) %></center></td>
      <td class = "grid" width="5%"><center><%=Utilitaria.formatarNumero(pedidoEntradaItemFiscal.getNfOvIPI(), 2) %></center></td>
      <td class = "grid" width="3%"><center><%=unidadeListar.getDsUnidade()%></center></td>
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
  <tr>
      <th class="grid" width="5%"><center>VALOR TOTAL:</center></th>
      <td><input type="text" id="total" value="<%=Utilitaria.formatarNumero((total),2)%>" onblur="soma()"></td>
  </tr>
  <br>
</table>
<br>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
	<td><input class="button" type="button" value="Gravar" onClick="javascript: salvar();" />
</td>
</tr>
</table>
</form>
<%@include file="../fimConexao.jsp"%>
</body>
</html>