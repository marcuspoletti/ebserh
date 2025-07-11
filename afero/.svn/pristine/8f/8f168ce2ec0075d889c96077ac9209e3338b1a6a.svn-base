<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.Agrupamento"%>
<%@page import="afero.model.OrcamentoSub"%>
<%@page import="afero.model.OrcamentoSubItem"%>
<%@page import="afero.model.OrcamentoSubItens"%>
<%@page import="afero.model.PedidoSaidaSubItens"%>
<%@page import="afero.model.Estoque"%>
<%@page import="afero.model.PedidoSaidaSub"%>
<%@page import="afero.model.PedidoSaidaSubItem"%>
<%@page import="afero.model.OrcamentoPedidoSaida"%>
<%@page import="afero.model.OrcamentoSubItem"%>
<%@page import="afero.model.Entrega"%>
<%@page import="afero.model.Entidade"%>
<%@page import="afero.model.Colaborador"%>
<%@page import="afero.model.Loja"%>
<%@page import="afero.persistence.LojaDAO"%>
<%@page import="afero.persistence.EntidadeDAO"%>
<%@page import="afero.persistence.AgrupamentoDAO"%>
<%@page import="afero.persistence.EstoqueDAO"%>
<%@page import="afero.persistence.EntregaDAO"%>
<%@page import="afero.persistence.OrcamentoSubDAO"%>
<%@page import="afero.persistence.PedidoSaidaSubDAO"%>
<%@page import="afero.persistence.PedidoSaidaSubItensDAO"%>
<%@page import="afero.persistence.OrcamentoSubItensDAO"%>
<%@page import="afero.persistence.PedidoSaidaSubItemDAO"%>
<%@page import="afero.persistence.ColaboradorDAO"%>
<%@page import="afero.persistence.OrcamentoPedidoSaidaDAO"%>
<%@ page import="afero.util.Utilitaria" %>
<%@ page import="afero.util.ConverteDate" %>
<%@ page import="afero.model.Produto" %>
<%@ page import="afero.model.Unidade" %>
<%@ page import="afero.model.Preco" %>
<%@ page import="afero.persistence.ProdutoDAO" %>
<%@ page import="afero.persistence.UnidadeDAO" %>
<%@ page import="afero.persistence.PrecoDAO" %>
<%@ page import="afero.persistence.OrcamentoSubItemDAO" %>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Iterator" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/>"</script>
<script>
function salvar() {
  	document.forms[0].submit();
}
</script>
<%

String idOrcamento = request.getParameter("idOrcamento");
OrcamentoSubDAO daoOrcamento = new OrcamentoSubDAO(conn);
OrcamentoSub orc = daoOrcamento.procurarOrcamentoItem(Integer.parseInt(idOrcamento));
PedidoSaidaSubDAO daoPedidoSaidaExistente = new PedidoSaidaSubDAO(conn);  
boolean ok = daoPedidoSaidaExistente.respPedidoSaida(Integer.parseInt(idOrcamento));
String mensagem = request.getParameter("mensagem");
if(mensagem == null)mensagem = "";
List list = null;
List listarEstoque = null;
List listarOrcamentoDAO = null;
List listUpdate = null;
List listUpdateItens = null;
List listSubItens = null;
List listarEstoqueSubItens = null;
ProdutoDAO dao;
EstoqueDAO daoEstoque;
OrcamentoSubItemDAO daoOrcamentoItem;
Produto prod = null;
Produto prodSubItens = null;
Estoque estoque =null;
Estoque estoqueSubList = null;
EstoqueDAO daoEstoqueSubItens;
ProdutoDAO daoProdutoSubItens;
OrcamentoSubItem orcamentoItem = null;
OrcamentoSubItens orcamentoItensUpdate = null;
OrcamentoSubItensDAO daoOrcamentoSubItens;
int cont = 0;
String preco = "0";
ConverteDate converte = new ConverteDate();
int idColaborador = orc.getIdColaborador();
Colaborador colaborador = new Colaborador();
ColaboradorDAO daoColaborador = new ColaboradorDAO(conn);
colaborador = daoColaborador.procurarColaborador(idColaborador);
String dsColaborador = colaborador.getNome();
int idLoja = orc.getIdLoja();
Loja lojaListar = new Loja();
LojaDAO daoLoja = new LojaDAO(conn);
lojaListar = daoLoja.procurarLoja(idLoja);
String dsLoja = lojaListar.getApelido() +" / "+ lojaListar.getRazaoSocial(); 
int idEntrega = orc.getIdEntrega();
Entrega entrega = new Entrega();
EntregaDAO daoEntrega = new EntregaDAO(conn);
entrega = daoEntrega.procurarEntrega(idEntrega);
String dsEntrega = entrega.getDsEntrega();
float valorEntrega = entrega.getTxEntrega();
int cdEntidade = orc.getCdEntidade();
Entidade entidade = new Entidade();
EntidadeDAO daoEntidade = new EntidadeDAO(conn);
entidade = daoEntidade.procurarEntidade(cdEntidade);
String dsEntidade = entidade.getNome();
int prazoValidade = orc.getPrazoValidade();
String dtEntrega = converte.dateToString(orc.getDtEntrega());
String status = request.getParameter("status");
if(status == null){
	status = orc.getStatus();
}
String dtOrc =converte.dateToString(orc.getDtOrc());
String observacao = orc.getObservacao();
double valorTotal = orc.getVlOrc();
float desconto = orc.getVlDesc();
double valorTotalApres = orc.getVlOrc();
//valorTotal = valorTotal + valorEntrega;
String pessoaResponsavel = orc.getPessoaResponsavel();
float valorItemOrcamento = Utilitaria.toNumber(String.valueOf(orc.getVlOrc())).floatValue();
String acao = request.getParameter("acao");
if(acao == null)acao = "listar";
if(acao.equalsIgnoreCase("gravar") ){
	 if(status.equals("A") && !ok){
		//OrdemServico ordemServico = new OrdemServico();
		//OrdemServicoDAO daoOrdemServico = new OrdemServicoDAO(conn);
		OrcamentoSub orcamento = new OrcamentoSub();
		OrcamentoSubDAO daoOrcamentoUpdate = new OrcamentoSubDAO(conn);
		orcamento.setVlAprov(valorTotal + valorEntrega);
		orcamento.setIdOrcamento(Integer.parseInt(idOrcamento));
		orcamento.setUsuario((String)session.getAttribute("Login"));
		orcamento.setStatus("A");
		daoOrcamentoUpdate.aprovarOrcamento(orcamento);
		OrcamentoSubItem orcamentoItemUpdate = null;
		OrcamentoSubItemDAO daoOrcamentoItemUpdate = new OrcamentoSubItemDAO(conn);
		//ordemServico.setStatus("A");
		//ordemServico.setObservacao(observacao);
		//ordemServico.setUsuario((String)session.getAttribute("Login"));
		//ordemServico.setIdOrcamento(Integer.parseInt(idOrcamento));
		//daoOrdemServico.incluir(ordemServico);
		PedidoSaidaSub pedidoSaida = new PedidoSaidaSub();
		pedidoSaida.setCdEntidade(cdEntidade);
		pedidoSaida.setIdColaborador(idColaborador);
		pedidoSaida.setIdLoja(idLoja);
		pedidoSaida.setIdEntrega(idEntrega);
		pedidoSaida.setStatus("P");
		pedidoSaida.setImpPedido("N");
		pedidoSaida.setObservacao(observacao);
		pedidoSaida.setUsuario((String)session.getAttribute("Login"));
		pedidoSaida.setVlPed(valorTotal);
		pedidoSaida.setOperacao("S");
		pedidoSaida.setHrEntrega("08:00");
		pedidoSaida.setObservacao(orc.getObservacao());
		pedidoSaida.setAnotacao("");
		pedidoSaida.setCdCondPagto(1);
		pedidoSaida.setVlDesc(desconto);
		pedidoSaida.setPessoaResponsavel(pessoaResponsavel);
		pedidoSaida.setDtEntrega(ConverteDate.stringToDate(dtEntrega));
		PedidoSaidaSubDAO daoPedidoSaida = new PedidoSaidaSubDAO(conn);
		daoPedidoSaida.incluirDesconto(pedidoSaida);
		int idPedidoSaida = daoPedidoSaida.idPedidoSaida();
		OrcamentoPedidoSaida orcamentoPedidoSaida = new OrcamentoPedidoSaida();
		orcamentoPedidoSaida.setIdOrcamento(Integer.parseInt(idOrcamento));
		orcamentoPedidoSaida.setIdPedidoSaida(idPedidoSaida);
		OrcamentoPedidoSaidaDAO daoOrcamentoPedidoSaida = new OrcamentoPedidoSaidaDAO(conn);
		daoOrcamentoPedidoSaida.incluir(orcamentoPedidoSaida);
		OrcamentoSubItensDAO daoOrcamentoItens = new  OrcamentoSubItensDAO(conn);
		listUpdate = daoOrcamentoItemUpdate.listarOrcamento(Integer.parseInt(idOrcamento));
		for ( Iterator it = listUpdate.iterator(); it.hasNext(); ) {
			orcamentoItemUpdate = (OrcamentoSubItem) it.next();
			orcamentoItemUpdate.setAprovado("A");
			orcamentoItemUpdate.setValorAprov(valorItemOrcamento + valorEntrega);
			daoOrcamentoItemUpdate.aprovarOrcamentoItem(orcamentoItemUpdate);
			PedidoSaidaSubItem pedidoSaidaItem = new PedidoSaidaSubItem();
			if(orcamentoItemUpdate.getIdAgrupamento()>0){
			   pedidoSaidaItem.setIdAgrupamento(orcamentoItemUpdate.getIdAgrupamento());
			}
			pedidoSaidaItem.setIdPedidoSaida(idPedidoSaida);
			pedidoSaidaItem.setIdProduto(orcamentoItemUpdate.getIdProduto());
			pedidoSaidaItem.setIdUnidade(orcamentoItemUpdate.getIdUnidade());
			pedidoSaidaItem.setQuant(orcamentoItemUpdate.getQuant());
			pedidoSaidaItem.setVlUni(orcamentoItemUpdate.getVlUni());
			pedidoSaidaItem.setpDesc(orcamentoItemUpdate.getpDesc());
			pedidoSaidaItem.setUsuario((String)session.getAttribute("Login"));
			pedidoSaidaItem.setValor(orcamentoItemUpdate.getValor());
			PedidoSaidaSubItemDAO daoPedidoSaidaItem = new PedidoSaidaSubItemDAO(conn);
			daoPedidoSaidaItem.incluir(pedidoSaidaItem);
			int idPedidoSaidaItem = daoPedidoSaidaItem.idPedidoSaidaItem();
			listUpdateItens = daoOrcamentoItens.procurarOrcamentoSubItensList(orcamentoItemUpdate.getIdOrcamentoItem());	
			for ( Iterator its = listUpdateItens.iterator(); its.hasNext(); ) {
				orcamentoItensUpdate = (OrcamentoSubItens)its.next();
				PedidoSaidaSubItens pedidoSaidaItens = new PedidoSaidaSubItens();
				pedidoSaidaItens.setIdPedidoSaidaItem(idPedidoSaidaItem);
				pedidoSaidaItens.setIdProduto(orcamentoItensUpdate.getIdProduto());
				pedidoSaidaItens.setIdUnidade(orcamentoItensUpdate.getIdUnidade());
				pedidoSaidaItens.setLarg(orcamentoItensUpdate.getLarg());
				pedidoSaidaItens.setComp(orcamentoItensUpdate.getComp());
				pedidoSaidaItens.setpDesc(orcamentoItensUpdate.getpDesc());
				pedidoSaidaItens.setQuant(orcamentoItensUpdate.getQuant());
				pedidoSaidaItens.setUsuario((String)session.getAttribute("Login"));
				pedidoSaidaItens.setVlUni(orcamentoItensUpdate.getVlUni());
				PedidoSaidaSubItensDAO daoPedidoSaidaItens = new PedidoSaidaSubItensDAO(conn);
				daoPedidoSaidaItens.incluir(pedidoSaidaItens);
				
				
			}
			
			
		}
		
	}else if((status.equals("R") || status.equals("NA"))){
		OrcamentoSubDAO daoOrcamentoUp = new OrcamentoSubDAO(conn);
		OrcamentoSub orcUpdate = daoOrcamentoUp.procurarOrcamento(Integer.parseInt(idOrcamento));
		if(status.equals("NA"))orcUpdate.setStatus("NA");
		if(status.equals("R"))orcUpdate.setStatus("R");
		
		daoOrcamentoUp.atualizar(orcUpdate);
	}else{
		response.sendRedirect("orcamentoParaPedido.jsp?mensagem=Já foi feito um Pedido através deste Orçamento&idOrcamento=" + idOrcamento);
	}
   
}
	
	

%>
<body onload="document.forms[0].elements[2].focus();" >
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<h1 class="cabecalho_pagina">Cadastro de Orçamento / Pedido</h1>
<form method="post" action="orcamentoParaPedido.jsp?acao=<%="gravar"%>">
<input type="hidden" name="idOrcamento" value="<%=idOrcamento%>"/>
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
    <th class="label">Taxa de Entrega</th>
    <td><input disabled type="text" name="dsEntrega" <%if (dsEntrega != null) { %>value="<%=dsEntrega%>"<% }%>  size="60" maxlength="60"></td>
  </tr>
   <tr>
    <th class="label">Data do Orçamento</th>
    <td><input disabled type="text" name="dtOrc" <%if (dtOrc != null) { %>value="<%=dtOrc%>"<% }%>  size="30" maxlength="30"></td>
  </tr>
     <tr>
    <th class="label">Data da Entrega</th>
    <td><input disabled type="text" name="dtEntrega" <%if (dtEntrega != null) { %>value="<%=dtEntrega%>"<% }%>  size="30" maxlength="30"></td>
  </tr>
   <tr>
    <th class="label">Prazo de Validade</th>
    <td><input disabled type="text" name="prazoValidade" value="<%=prazoValidade%>"  size="10" onkeyup="FormataValor(this,event)" maxlength="10"></td>
  </tr>
  <tr>
      <th class="label">Observação</th>
      <td><textarea disabled="disabled"name="observacao" cols="60" rows="5"><%=observacao %></textarea></td>
  </tr>
  <%if(orc.getStatus().equals("A")){ %>
  	<tr>
    <th class="label">Situação do Documento</th>
      <td class="label_radio"><input disabled type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Aprovado
      <input  disabled type="radio" class="radio" name="status" value="R" <%= (status.equals("R")? "checked": "") %>>Recusado
      <input  disabled type="radio" class="radio" name="status" value="NA" <%= (status.equals("NA")? "checked": "") %>>Não Avaliado</td>
  </tr>
  <%}else{ %>
      	<tr>
    <th class="label">Situação do Documento</th>
      <td class="label_radio"><input  type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Aprovado
      <input   type="radio" class="radio" name="status" value="R" <%= (status.equals("R")? "checked": "") %>>Recusado
      <input   type="radio" class="radio" name="status" value="NA" <%= (status.equals("NA")? "checked": "") %>>Não Avaliado</td>
  </tr>
  <%} %>
</table><hr>
<table border="0" width="100%">
    <tr">
      <th class="grid"><center></center></th>
      <th class="grid">Loja</th>
      <th class="grid">Agrup.</th>
      <th class="grid"><center>Desc. do Prod.</center></th>
      <th class="grid">Comp.</th>
      <th class="grid">Larg.</th>
      <th class="grid">Quant.</th>
      <th class="grid">% Desc.</th>
      <th class="grid">Vl.Unitário</th>
      <th class="grid">Total</th>
      <th class="grid">Unidade</th>
      
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
 String dsAgrupamento = "Nenhum";
 String idLojaUsuario = (String)session.getAttribute("idLoja");
 OrcamentoSubItens orcamentoSubItens = null;
 float total = 0;
 daoOrcamentoItem = new OrcamentoSubItemDAO(conn);
 daoOrcamentoSubItens = new OrcamentoSubItensDAO(conn);
 list = daoOrcamentoItem.procurarOrcamentoItem(Integer.parseInt(idOrcamento));
 daoOrcamentoSubItens = new OrcamentoSubItensDAO(conn);
 if(list != null){
  for ( Iterator it = list.iterator(); it.hasNext(); ) {
	orcamentoItem = (OrcamentoSubItem) it.next();
	dao = new ProdutoDAO(conn);
	prod = dao.procurarProduto(orcamentoItem.getIdProduto());
	if(daoOrcamentoItem.getIdAgrupamentoOrcamento(orcamentoItem.getIdAgrupamento())){
		AgrupamentoDAO daoAgrupamento = new AgrupamentoDAO(conn);
		Agrupamento itensAgrupOrcamento = daoAgrupamento.procurarAgrupamento(orcamentoItem.getIdAgrupamento());
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
			preco = Utilitaria.formatarNumero(orcamentoItem.getVlUni(), 2).toString();
			UnidadeDAO daoUnidade = new UnidadeDAO(conn);
			Unidade unidadeListar = daoUnidade.procurarUnidade(precoListar.getIdUnidade());	
%>
    <tr>
      <td class = "grid" width="1%"><center><%=cont%></center></td>
      <td class = "grid" width="5%"><center><%=lojaEstoque.getApelido()%></center></td>
      <td class = "grid" width="5%"><center><%=dsAgrupamento%></center></td>
      <td class = "grid" width="10%"><center> <%=prod.getDsProduto() +". "+orcamentoItem.getDsCompProduto()%></center></td>
      <td class="grid" width="3%" name="comprimento" size="10" maxlength="10"><%=Utilitaria.formatarNumero(orcamentoItem.getComp(),0)%></td>
       <td class="grid" width="3%" name="largura" size="10" maxlength="10"><%=Utilitaria.formatarNumero(orcamentoItem.getLarg(),0)%></td>
      <td class="grid" width="3%" name="quantidade" size="10" maxlength="10"><%=Utilitaria.formatarNumero(orcamentoItem.getQuant(),0)%></td>
      <td class="grid" width="3%" name="pDesc" size="10" maxlength="10"><%=Utilitaria.formatarNumero(orcamentoItem.getpDesc(),2)%></td>
      <td class="grid" width="3%" name="vlUni" size="10" maxlength="10"><%=Utilitaria.formatarNumero(orcamentoItem.getVlUni(),2)%></td>
      <td class = "grid" width="3%"><center><%=unidadeListar.getDsUnidade()%></center></td>
      <%float precoItem = Utilitaria.toNumber(preco).floatValue() * orcamentoItem.getQuant(); %>
      <td class="grid" width="3%" name="preco_<%=precoListar.getIdPreco()%>" size="10" maxlength="10"><%=Utilitaria.formatarNumero(precoItem,2)%></td>
      <%total = total +  precoItem;%>
  </tr>
  <input type="hidden" name="idPreco" value="<%=precoListar.getIdPreco()%>"/>
  <%
       listSubItens = daoOrcamentoSubItens.procurarOrcamentoSubItensList(orcamentoItem.getIdOrcamentoItem());
       if(listSubItens != null){
          for ( Iterator itSubItens = listSubItens.iterator(); itSubItens.hasNext(); ) {
        	      orcamentoSubItens = (OrcamentoSubItens) itSubItens.next();
        	      daoProdutoSubItens = new ProdutoDAO(conn);
        	      prodSubItens = daoProdutoSubItens.procurarProduto(orcamentoItem.getIdProduto());
        	      daoEstoqueSubItens = new EstoqueDAO(conn);
        	      listarEstoqueSubItens = daoEstoqueSubItens.procurarEstoquePreco(prodSubItens.getIdProduto(), Integer.parseInt(idLojaUsuario));
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
        	  			preco = Utilitaria.formatarNumero(orcamentoSubItens.getVlUni(), 2).toString();
        	  			UnidadeDAO daoUnidadeSubList = new UnidadeDAO(conn);
        	  			Unidade unidadeListarSubList = daoUnidadeSubList.procurarUnidade(precoListar.getIdUnidade());
        	  			
      %>
    <tr>
      <td class="grid" width="1%"><center></center></td>
      <td class="grid" width="1%"><center></center></td>
      <td class="grid" width="1%"><center></center></td>
      <td class="grid"  width="20%"><center><%=prodSubItens.getDsProduto() +". "+orcamentoSubItens.getComp()%></center></td>
      <td class="grid"  width="3%"><center><%=orcamentoSubItens.getComp()%></center></td>
      <td class="grid"  width="3%"><center><%=orcamentoSubItens.getLarg()%></center></td>
      <td class="grid"  width="3%"><center><%=orcamentoSubItens.getQuant()%></center></td>
      <td class="grid"  width="3%"><center><%=Utilitaria.formatarNumero(orcamentoSubItens.getpDesc(),2)%></center></td>
      <td class="grid"  width="3%"><center><%=Utilitaria.formatarNumero(orcamentoSubItens.getVlUni(),2)%></center></td>
      <%float precoItemSub = Utilitaria.toNumber(preco).floatValue() * orcamentoSubItens.getQuant(); %>
      <td class="grid"  width="3%"><center><%=Utilitaria.formatarNumero(precoItemSub,2)%></center></td>
      <td class="grid"  width="3%"><center><%=unidadeListarSubList.getDsUnidade()%></center></td>
 
      <%total = total +  precoItemSub;%>
  </tr>
  
  
  
  
  
<%
		}
	}
	}
}
       }
%>
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
      
      <th class="grid" width="5%"><center>TOTAL DO PEDIDO:</center></th>
      <td><input type="text" id="total" value="<%=Utilitaria.formatarNumero(total,2)%>" ></td>
  </tr>
       <tr>
      
      <th class="grid" width="5%"><center>DESCONTO :(%)</center></th>
      <td><input type="text" id="valorEntrega" value="<%=desconto%>" ></td>
  </tr> 
   <tr>
      
      <th class="grid" width="5%"><center>VALOR C/ O DESCONTO :</center></th>
      <td><input type="text" id="valorEntrega" value="<%=Utilitaria.formatarNumero(valorTotalApres,2)%>" ></td>
  </tr>
   <tr>
      
      <th class="grid" width="5%"><center>TAXA DE ENTREGA : <%=dsEntrega%></center></th>
      <td><input type="text" id="valorEntrega" value="<%=Utilitaria.formatarNumero(valorEntrega,2)%>" ></td>
  </tr>  
  <%
  valorTotalApres += valorEntrega;
  %>
   <tr>
      <th class="grid" width="5%"><center>VALOR TOTAL:</center></th>
      <td><input type="text" id="valorTotal" value="<%=Utilitaria.formatarNumero((valorTotalApres),2)%>" ></td>
  </tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<br>
<br>
<tr>
	<td><input class="button" type="button" value="Orçamento X Pedido" onClick="javascript: salvar();" />
</tr>
</table>
</form>
<%@include file="../fimConexao.jsp"%>
</body>
</html>