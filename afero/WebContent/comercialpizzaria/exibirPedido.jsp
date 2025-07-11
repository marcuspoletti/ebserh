<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.Orcamento"%>
<%@page import="afero.model.PedidoSaidaSub"%>
<%@page import="afero.model.Agrupamento"%>
<%@page import="afero.model.PedidoSaidaSubItem"%>
<%@page import="afero.model.PedidoSaidaSubItens"%>
<%@page import="afero.model.OrcamentoPedidoSaida"%>
<%@page import="afero.model.OrdemServico"%>
<%@page import="afero.model.OrcamentoItem"%>
<%@page import="afero.model.Entidade"%>
<%@page import="afero.model.CondPagto"%>
<%@page import="afero.model.Entrega"%>
<%@page import="afero.model.Colaborador"%>
<%@page import="afero.model.Loja"%>
<%@page import="afero.persistence.LojaDAO"%>
<%@page import="afero.persistence.EntidadeDAO"%>
<%@page import="afero.persistence.PedidoSaidaSubDAO"%>
<%@page import="afero.persistence.AgrupamentoDAO"%>
<%@page import="afero.persistence.CondPagtoDAO"%>
<%@page import="afero.persistence.EntregaDAO"%>
<%@page import="afero.persistence.OrcamentoDAO"%>
<%@page import="afero.persistence.ColaboradorDAO"%>
<%@page import="afero.persistence.OrcamentoPedidoSaidaDAO"%>
<%@page import="afero.persistence.OrdemServicoDAO"%>
<%@page import="afero.persistence.PedidoSaidaSubItemDAO"%>
<%@page import="afero.persistence.PedidoSaidaSubItensDAO"%>
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
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/></script>
<script>
function salvar() {
  	document.forms[0].submit();
}
function recarregarFrete() {
	  var valorEntrega = parseFloat((document.getElementById("valorEntrega").value).replace(",","."));
	  var valorTotalDesconto = parseFloat((document.getElementById("valorTotalDesconto").value).replace(",","."));
	  var valor = valorTotalDesconto + valorEntrega;
	  document.getElementById("valorTotal").value = valor.toFixed(2);
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
	window.open('impressaoBobinaC.jsp?idPedidoSaida='+document.getElementById("idPedidoSaida").value,'endeavour','width=420,height=420,scrollbars=yes');
	//alert('Você digitou CTRL + A');
	return false;
	}
	if (e.keyCode == 122) {
		window.open('impressaoBobinaP.jsp?idPedidoSaida='+document.getElementById("idPedidoSaida").value,'endeavour','width=420,height=420,scrollbars=yes');
		//alert('Você digitou CTRL + A');
		return false;
	}
	if (e.keyCode == 123) {
		window.open('impressaoBobinaH.jsp?idPedidoSaida='+document.getElementById("idPedidoSaida").value,'endeavour','width=420,height=420,scrollbars=yes');
		//alert('Você digitou CTRL + A');
		return false;
	}

}
</script>
<%
String idLojaUsuario = (String)session.getAttribute("idLoja");
String mensagem = request.getParameter("mensagem");
if(mensagem == null)mensagem = "";
PedidoSaidaSubDAO daoPedidoSaida = new PedidoSaidaSubDAO(conn);
String acao = request.getParameter("acao");
if(acao == null)acao="listar";
List list = null;
List listarEstoque = null;
List listarOrcamentoDAO = null;
List listUpdate = null;
List listUpdateSubItens = null;
List listSubItens = null;
List listarEstoqueSubItens = null;
ProdutoDAO dao;
ProdutoDAO daoProdutoSubItens = null;
EstoqueDAO daoEstoque;
EstoqueDAO daoEstoqueSubItens;
PedidoSaidaSubItemDAO daoPedidoSaidaItem;
PedidoSaidaSubItensDAO daoPedidoSaidaSubItens;
Produto prod = null;
Produto prodSubItens = null;
Estoque estoque =null;
Estoque estoqueSubList = null;
PedidoSaidaSubItem pedidoSaidaItem = null;
PedidoSaidaSubItens pedidoSubItens = null;
int cont = 0;
String preco = "0";
ConverteDate converte = new ConverteDate();
String idPedidoSaida = request.getParameter("idPedidoSaida");
PedidoSaidaSub pedidoSaida = daoPedidoSaida.procurarPedidoSaidaItem(Integer.parseInt(idPedidoSaida));
int idColaborador =pedidoSaida.getIdColaborador();
Colaborador colaborador = new Colaborador();
ColaboradorDAO daoColaborador = new ColaboradorDAO(conn);
colaborador = daoColaborador.procurarColaborador(idColaborador);
String dsColaborador = colaborador.getNome();
String cdEntregador =  "".valueOf(daoPedidoSaida.getIdEntregador(Integer.parseInt(idPedidoSaida)));
int idLoja = pedidoSaida.getIdLoja();
Loja lojaListar = new Loja();
LojaDAO daoLoja = new LojaDAO(conn);
lojaListar = daoLoja.procurarLoja(idLoja);
String dsLoja = lojaListar.getApelido() +" / "+ lojaListar.getRazaoSocial(); 
int idEntrega = pedidoSaida.getIdEntrega();
Entrega entrega = new Entrega();
EntregaDAO daoEntrega = new EntregaDAO(conn);
entrega = daoEntrega.procurarEntrega(idEntrega);
String dsEntrega = entrega.getDsEntrega();
float valorEntrega = pedidoSaida.getVlFrete();
if(request.getParameter("valorEntrega") != null){
	valorEntrega = Utilitaria.toNumber(request.getParameter("valorEntrega")).floatValue();
	daoPedidoSaida.atualizarVlFrete(Integer.parseInt(idPedidoSaida), valorEntrega);
}
int cdEntidade =pedidoSaida.getCdEntidade();
Entidade entidade = new Entidade();
EntidadeDAO daoEntidade = new EntidadeDAO(conn);
entidade = daoEntidade.procurarEntidade(cdEntidade);
String dsEntidade = entidade.getNome();
String cdCondPagto = "0";
if(pedidoSaida.getCdCondPagto()>0){
	cdCondPagto = "".valueOf(pedidoSaida.getCdCondPagto());
}else{
	cdCondPagto = "0";
}
/**
CondPagto condPagto = null;
CondPagtoDAO daoCondPagto = new CondPagtoDAO(conn);
condPagto = daoCondPagto.procurarCondPagto(pedidoSaida.getCdCondPagto());
*/
String status = pedidoSaida.getStatus();
String statusPag = "";
if(daoPedidoSaida.statusPag(Integer.parseInt(idPedidoSaida)) != null){
statusPag = daoPedidoSaida.statusPag(Integer.parseInt(idPedidoSaida));
}else{
	statusPag = "N";	
}

String pessoaResponsavel = pedidoSaida.getPessoaResponsavel();
String operacao = pedidoSaida.getOperacao();
String dtPed =converte.dateToString(pedidoSaida.getDtPed());
String dtEntrega = converte.dateToString(pedidoSaida.getDtEntrega());
String hrEntrega = pedidoSaida.getHrEntrega();
if(hrEntrega == null)hrEntrega="";
String observacao = pedidoSaida.getObservacao();
String anotacao = pedidoSaida.getAnotacao();
if(anotacao == null)anotacao="";
double valorTotal = pedidoSaida.getVlPed();

double quantEstoque = 0;
double saldoEstoque = 0;
if (acao.equalsIgnoreCase("gravar")){
	status = request.getParameter("status");
	operacao = request.getParameter("operacao");
	cdCondPagto = request.getParameter("cdCondPagto");
	observacao = request.getParameter("observacao");
	anotacao = request.getParameter("anotacao");
	statusPag = request.getParameter("statusPag");
	cdEntregador = request.getParameter("cdEntregador");
	PedidoSaidaSub pedidoSaidaUpdate = null;
	PedidoSaidaSubDAO daoPedidoSaidaUpdate = new PedidoSaidaSubDAO(conn);
	pedidoSaidaUpdate = daoPedidoSaidaUpdate.procurarPedidoSaida(Integer.parseInt(idPedidoSaida));
	daoPedidoSaidaUpdate.atualizarObservacao(Integer.parseInt(idPedidoSaida),observacao);
	daoPedidoSaidaUpdate.atualizarAnotacao(Integer.parseInt(idPedidoSaida),anotacao);
	daoPedidoSaidaUpdate.atualizarStatusPag(Integer.parseInt(idPedidoSaida),statusPag);
	if(Integer.parseInt(cdCondPagto) > 0){
		daoPedidoSaidaUpdate.atualizarCondPagto(Integer.parseInt(idPedidoSaida), Integer.parseInt(cdCondPagto));
	}
	if(Integer.parseInt(cdEntregador)>0){
		daoPedidoSaidaUpdate.atualizarEntregador(Integer.parseInt(idPedidoSaida), Integer.parseInt(cdEntregador));
	}
	pedidoSaidaUpdate = daoPedidoSaidaUpdate.procurarPedidoSaida(Integer.parseInt(idPedidoSaida));
	//if (!daoPedidoSaidaUpdate.confirmarPedido(Integer.parseInt(idPedidoSaida))) {
		if (!pedidoSaidaUpdate.getStatus().equals("A")) {
			pedidoSaidaUpdate.setStatus(status);
			pedidoSaidaUpdate.setOperacao(operacao);
			daoPedidoSaidaUpdate.atualizar(pedidoSaidaUpdate);
			if(status.equalsIgnoreCase("A") || status.equalsIgnoreCase("F")){
				statusPag = "P";
				daoPedidoSaidaUpdate.atualizarStatusPag(Integer.parseInt(idPedidoSaida),statusPag);
				Estoque estoqueUpdate = null;
				EstoqueDAO daoEstoqueProcurar = new EstoqueDAO(conn);
				PedidoSaidaSubItemDAO daoPedidoSaidaItemUpdate = new PedidoSaidaSubItemDAO(conn);
				listUpdate = daoPedidoSaidaItemUpdate.procurarPedidoSaidaItem(Integer.parseInt(idPedidoSaida));
				for ( Iterator it = listUpdate.iterator(); it.hasNext(); ) {
					PedidoSaidaSubItem pedidoItemUpdate = (PedidoSaidaSubItem) it.next();
					estoqueUpdate = daoEstoqueProcurar.procurarEstoque(pedidoItemUpdate.getIdProduto(), idLoja);
					estoqueUpdate.estoqueSaida(estoqueUpdate.getQtEstoque(), pedidoItemUpdate.getQuant());
					EstoqueDAO daoEstoqueUpdate = new EstoqueDAO(conn);
					daoEstoqueUpdate.atualizar(estoqueUpdate);
				}
				//SubItens Inicio
				listUpdate = daoPedidoSaidaItemUpdate.procurarPedidoSaidaItem(Integer.parseInt(idPedidoSaida));
				for ( Iterator itPedidoSaida = listUpdate.iterator(); itPedidoSaida.hasNext(); ) {
			             PedidoSaidaSubItem pedidoItensUpdate = (PedidoSaidaSubItem) itPedidoSaida.next();
				    Estoque estoqueUpdateSubItens = null;
				    EstoqueDAO daoEstoqueProcurarSubItens = new EstoqueDAO(conn);
				    PedidoSaidaSubItensDAO daoPedidoSaidaSubItensUpdate = new PedidoSaidaSubItensDAO(conn);
				    listUpdateSubItens = daoPedidoSaidaSubItensUpdate.listarPedidoSaidaSubItensList(pedidoItensUpdate.getIdPedidoSaidaItem());
				    for ( Iterator it = listUpdateSubItens.iterator(); it.hasNext(); ) {
					PedidoSaidaSubItens pedidoItemUpdate = (PedidoSaidaSubItens) it.next();
					estoqueUpdateSubItens = daoEstoqueProcurar.procurarEstoque(pedidoItemUpdate.getIdProduto(), idLoja);
					estoqueUpdate.estoqueSaida(estoqueUpdateSubItens.getQtEstoque(), pedidoItemUpdate.getQuant());
					EstoqueDAO daoEstoqueUpdateSubItens = new EstoqueDAO(conn);
					daoEstoqueUpdateSubItens.atualizar(estoqueUpdate);
				  }
				
				
				//Fim
				}
			}
	} else {
		response.sendRedirect("exibirPedido.jsp?mensagem=Já foi aprovado ou faturado este Pedido&idPedidoSaida=" + idPedidoSaida);
	}
	//} else {
	//	response.sendRedirect("exibirPedido.jsp?mensagem=Não pode aprovar o pedido porque a Ordem de Serviço esta aberta&idPedidoSaida=" + idPedidoSaida);
	//}
	
	acao = "listar";
}
%>
<body onload="document.forms[0].elements[2].focus();" >
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<h1 class="cabecalho_pagina">Pedido</h1>
<form method="post" action="exibirPedido.jsp?acao=<%="gravar"%>">
<input type="hidden" name="idPedidoSaida" value="<%=idPedidoSaida%>"/>
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
    <th class="label">Cliente</th>
    <td><input disabled type="text" name="dsEntidade" <%if (dsEntidade != null) { %>value="<%=dsEntidade%>"<% }%>  size="60" maxlength="60"></td>
  </tr>
    <tr>
    <th class="label">Pessoa Responsável</th>
    <td><input disabled type="text" name="pessoaResponsavel" <%if (pessoaResponsavel != null) { %>value="<%=pessoaResponsavel%>"<% }%>  size="60" maxlength="60"></td>
  </tr>
   <tr>
    <th class="label">Data do Pedido</th>
    <td><input disabled type="text" name="dtOrc" <%if (dtPed != null) { %>value="<%=dtPed%>"<% }%>  size="30" maxlength="30"></td>
  </tr>
  <tr>
    <th class="label">Data da Entrega</th>
    <td><input disabled type="text" name="dtEntrega" <%if (dtPed != null) { %>value="<%=dtEntrega%>"<% }%>  size="30" maxlength="30"></td>
  </tr>
  <tr>
			<th class="label">Hora de Entrega</th>
			<td><input disabled type="text" name="hrEntrega" value="<%=hrEntrega%>"
						size="5" maxlength="5" onblur="chkTime(this,'')"></td>
	  </tr>
  <tr>
    <th class="label">Entrega</th>
    <td><input disabled type="text" name="dsEntrega" <%if (dsEntrega != null) { %>value="<%=dsEntrega%>"<% }%>  size="60" maxlength="60"></td>
  </tr>
  <tr>
      <th class="label">Referência</th>
      <td><textarea name="anotacao" cols="60" rows="1"><%=anotacao %></textarea></td>
  </tr>
    <tr>
      <th class="label">Condição de Pagto*</th>
      <td><select name="cdCondPagto" onchange="recarregar();">
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboCondicaoPagto.jspf"%></select>
          <script>comboSelect(document.forms[0].cdCondPagto, '<%=cdCondPagto%>');</script>
      </td>
  </tr>
   <tr>
      <th class="label">Entregador</th>
      <td><select name="cdEntregador">
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboEntregador.jspf"%></select>
          <script>comboSelect(document.forms[0].cdEntregador, '<%=cdEntregador%>');</script>
      </td>
  </tr>
  <%--
  <tr>
    <th class="label">Cond. Pagto.</th>
    <td><input disabled type="text" name="condPagto" <%if (condPagto.getDsCondPagto() != null) { %>value="<%=condPagto.getDsCondPagto() %>"<% }%>  size="60" maxlength="60"></td>
  </tr>
   --%>
  <tr>
      <th class="label">Obs./Troco</th>
      <td><textarea name="observacao" cols="60" rows="1"><%=observacao %></textarea></td>
  </tr>
  </tr>
     <tr>
    <th class="label" colspan="1">Pago</th>
    <td class="label_radio">
      <input type="radio" class="radio" name="statusPag" value="P" <%= (statusPag.equals("P")? "checked": "") %>>Sim
      <input  <%if(statusPag.equalsIgnoreCase("P")){%> disabled <%} %>type="radio" class="radio" name="statusPag" value="N" <%= (statusPag.equals("N")? "checked": "") %>>Não
    </td>
  </tr>
  <tr>
    <th class="label" colspan="1">Status</th>
    <td class="label_radio">
      <input type="radio" class="radio" name="status" value="P" <%= (status.equals("P")? "checked": "") %>>Pendente
      <input type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Atendido
      <input type="radio" class="radio" name="status" value="C" <%= (status.equals("C")? "checked": "") %>>Cancelado
    </td>
  <tr>
    <th class="label" colspan="1">Operação</th>
    <td class="label_radio">
      <input type="radio" class="radio" name="operacao" value="S" <%= (operacao.equals("S")? "checked": "") %>>Saída
      <input disabled type="radio" class="radio" name="operacao" value="T" <%= (operacao.equals("T")? "checked": "") %>>Transferência<br>
      <input disabled type="radio" class="radio" name="operacao" value="EE" <%= (operacao.equals("EE")? "checked": "") %>>Estorno de Entrada Por Devolução
      <input disabled type="radio" class="radio" name="operacao" value="AS" <%= (operacao.equals("AS")? "checked": "") %>>Ajuste de Saída
    </td>
  </tr>
</table><hr>
<table border="0" width="100%">
    <tr>
      <th class="grid"><center></center></th>
      <th class="grid">Loja</th>
     <%--<th class="grid">Agrup.</th> --%> 
      <th class="grid"><center>Desc. do Prod.</center></th>
      <%--<th class="grid">Comp.</th> --%>
      <%--<th class="grid">Larg.</th> --%>
      <th class="grid">Quant.</th>
      <th class="grid">% Desc.</th>
      <th class="grid">Vl.Unit.</th>
      <th class="grid">Total</th>
      <th class="grid">Unidade</th>
      
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
 String dsAgrupamento = "Nenhum"; 
 float total = 0;
 daoPedidoSaidaItem = new PedidoSaidaSubItemDAO(conn);
 daoPedidoSaidaSubItens = new PedidoSaidaSubItensDAO(conn);
 list = daoPedidoSaidaItem.procurarPedidoSaidaItem(Integer.parseInt(idPedidoSaida));
 if(list != null){
  for ( Iterator it = list.iterator(); it.hasNext(); ) {
	pedidoSaidaItem = (PedidoSaidaSubItem) it.next();
	dao = new ProdutoDAO(conn);
	prod = dao.procurarProduto(pedidoSaidaItem.getIdProduto());
	if(daoPedidoSaidaItem.getIdAgrupamentoPedido(pedidoSaidaItem.getIdAgrupamento())){
		AgrupamentoDAO daoAgrupamento = new AgrupamentoDAO(conn);
		Agrupamento itensAgrupOrcamento = daoAgrupamento.procurarAgrupamento(pedidoSaidaItem.getIdAgrupamento());
		if(itensAgrupOrcamento.getDsAgrupamento() != null){
			dsAgrupamento = itensAgrupOrcamento.getDsAgrupamento();
		}
	}
	daoEstoque = new EstoqueDAO(conn);
	listarEstoque = daoEstoque.procurarEstoquePreco(prod.getIdProduto(),  Integer.parseInt(idLojaUsuario));
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
      <td class = "grid" width="5%"><center><%=lojaEstoque.getApelido()%></center></td>
      <%--<td class = "grid" width="5%"><center><%=dsAgrupamento%></center></td> --%>
      <%if(pedidoSaidaItem.getDsCompProduto() != null){ %>
        <td class = "grid" width="5%"><center><%=prod.getDsProduto() +". "+pedidoSaidaItem.getDsCompProduto() %></center></td>
      <%}else{ %>
         <td class = "grid" width="5%"><center><%=prod.getDsProduto()%></center></td>
      <%} %>
      <%--<td class="grid" width="3%" name="quantidade%>" size="7" maxlength="7"><%=Utilitaria.formatarNumero(pedidoSaidaItem.getComp(),2)%></td> --%>
      <%--<td class="grid" width="3%" name="quantidade%>" size="7" maxlength="7"><%=Utilitaria.formatarNumero(pedidoSaidaItem.getLarg(),2)%></td> --%>
      <td class="grid" width="3%" name="quantidade%>" size="7" maxlength="7"><%=Utilitaria.formatarNumero(pedidoSaidaItem.getQuant(),2)%></td>
      <td class="grid" width="3%" name="pDesc" size="7" maxlength="7"><%=Utilitaria.formatarNumero(pedidoSaidaItem.getpDesc(),2)%></td>
      <td class="grid" width="3%" name="vlUni" size="7" maxlength="7"><%=Utilitaria.formatarNumero(pedidoSaidaItem.getValor(),2)%></td>
      <%float precoItem = pedidoSaidaItem.getValor() * pedidoSaidaItem.getQuant(); %>
      <td class="grid" width="3%" name="preco_<%=precoListar.getIdPreco()%>" size="7" maxlength="7"><%=Utilitaria.formatarNumero(precoItem,2)%></td>
      <td class = "grid" width="3%"><center><%=unidadeListar.getDsUnidade()%></center></td>
      <%total = total +  precoItem;%>
  </tr>
      <%
       listSubItens = daoPedidoSaidaSubItens.listarPedidoSaidaSubItensListCompProduto(pedidoSaidaItem.getIdPedidoSaidaItem());
       if(listSubItens != null){
          for ( Iterator itSubItens = listSubItens.iterator(); itSubItens.hasNext(); ) {
        	      pedidoSubItens = (PedidoSaidaSubItens) itSubItens.next();
        	      daoProdutoSubItens = new ProdutoDAO(conn);
        	      prodSubItens = daoProdutoSubItens.procurarProduto(pedidoSubItens.getIdProduto());
        	      daoEstoqueSubItens = new EstoqueDAO(conn);
        	      listarEstoqueSubItens = daoEstoqueSubItens.procurarEstoquePreco(pedidoSubItens.getIdProduto(), Integer.parseInt(idLojaUsuario));
        	      if(listarEstoqueSubItens != null){
        	  	for (Iterator itListarSubItens = listarEstoqueSubItens.iterator(); itListarSubItens.hasNext();){
        	  		cont++;
        	  		estoqueSubList = (Estoque) itListarSubItens.next();
        	  		LojaDAO lojaSubItens = new LojaDAO(conn);
        	  		Loja lojaEstoqueSubItens = lojaSubItens.procurarLoja(estoqueSubList.getIdLoja());
        	  		PrecoDAO daoPrecoListarSubItens = new PrecoDAO(conn);
        	  		Preco precoListarSubList = daoPrecoListarSubItens.procurarPrecoEstoque(estoque.getIdEstoque());
        	  		if(precoListar!=null){
        	  			
        	  			//preco = Utilitaria.formatarNumero(precoListar.getPreco(), 2).toString();
        	  			preco = Utilitaria.formatarNumero(pedidoSubItens.getVlUni(), 2).toString();
        	  			UnidadeDAO daoUnidadeSubList = new UnidadeDAO(conn);
        	  			Unidade unidadeListarSubList = daoUnidadeSubList.procurarUnidade(precoListar.getIdUnidade());
        	  			
      %>
   <tr>
      <td class="grid" width="1%"><center></center></td>
      <td class="grid" width="1%"><center></center></td>
      <%--<td class="grid" width="1%"><center></center></td> --%>
      <td class="grid"  width="5%"><center><%=prodSubItens.getDsProduto()+". "+pedidoSubItens.getDsCompProduto()%></center></td>
     <%--<td class="grid"  width="3%"><center><%=pedidoSubItens.getComp()%></center></td> --%> 
     <%--<td class="grid"  width="3%"><center><%=pedidoSubItens.getLarg()%></center></td> --%>
      <td class="grid"  width="3%"><center><%=pedidoSubItens.getQuant()%></center></td>
      <td class="grid"  width="3%"><center><%="FATIA"%></center></td>
      <td class="grid"  width="3%"><center><%="FATIA"%></center></td>
      <%//float precoItemSub = Utilitaria.toNumber(preco).floatValue() * pedidoSubItens.getQuant(); %>
      <td class="grid"  width="3%"><center><%="FATIA"%></center></td>
      <td class="grid"  width="3%"><center><%=unidadeListarSubList.getDsUnidade()%></center></td>
 
      <%//total = total +  precoItemSub;%>
  </tr>
      <%
    	   
       	}
       }
        	      }
          }
       }
      
      %>
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
 float desconto = pedidoSaida.getVlDesc();
%> 
  <tr>
      
      <th class="grid" width="5%"><center>TOTAL DO PEDIDO:</center></th>
      <td><input type="text" id="total" name="total" value="<%=Utilitaria.formatarNumero(total,2)%>" ></td>
  </tr>
     <tr>
      
      <th class="grid" width="5%"><center>DESCONTO :(%)</center></th>
      <td><input type="text" id="desconto" name="desconto" value="<%=desconto%>"></td>
  </tr> 
   <tr>
      
      <th class="grid" width="5%"><center>VALOR C/ O DESCONTO :</center></th>
      <td><input type="text" id="valorTotalDesconto" name="valorTotalDesconto" value="<%=Utilitaria.formatarNumero(valorTotal,2)%>" ></td>
  </tr>
   <tr>
      <%if(!status.equalsIgnoreCase("A")){ %>
      	<th class="grid" width="5%"><center>TAXA DE ENTREGA : <%=dsEntrega%></center></th>
      	<td><input type="text" id="valorEntrega" name="valorEntrega" value="<%=Utilitaria.formatarNumero(valorEntrega,2)%>" onkeyup="FormataValor(this,event)" onblur="recarregarFrete()"></td>
      <%}else{%>
      	<th class="grid" width="5%"><center>TAXA DE ENTREGA : <%=dsEntrega%></center></th>
      	<td><input type="text" value="<%=Utilitaria.formatarNumero(valorEntrega,2)%>"></td>
      <%}%>
  </tr>  
  <tr>
      <th class="grid" width="5%"><center>VALOR TOTAL:</center></th>
      <td><input type="text" id="valorTotal" name="valorTotal" value="<%=Utilitaria.formatarNumero(valorTotal + valorEntrega ,2)%>"></td>
  </tr>
  <br>
</table>
<br>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
	<td><input class="button" type="button" value="Gravar" onClick="javascript: salvar();" /> 
	<input class="button" type="button" value="Imprimir Completo(F10)" onClick="javaScript:void(window.open('impressaoBobinaC.jsp?idPedidoSaida=<%=idPedidoSaida%>','endeavour','width=420,height=420,scrollbars=yes'));"/>
	<input class="button" type="button" value="Imprimir Produção (F11)" onClick="javaScript:void(window.open('impressaoBobinaP.jsp?idPedidoSaida=<%=idPedidoSaida%>','endeavour','width=420,height=420,scrollbars=yes'));"/>
	<input class="button" type="button" value="Imprimir Conta (F12)" onClick="javaScript:void(window.open('impressaoBobinaH.jsp?idPedidoSaida=<%=idPedidoSaida%>','endeavour','width=420,height=420,scrollbars=yes'));"/></td>
	
</tr>
</table>
</form>
<%@include file="../fimConexao.jsp"%>
</body>
</html>