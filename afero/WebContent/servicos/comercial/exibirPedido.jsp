<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.Orcamento"%>
<%@page import="afero.model.CondPagto"%>
<%@page import="afero.model.PedidoSaida"%>
<%@page import="afero.model.PedidoSaidaItem"%>
<%@page import="afero.model.OrcamentoPedidoSaida"%>
<%@page import="afero.model.OrdemServico"%>
<%@page import="afero.model.OrcamentoItem"%>
<%@page import="afero.model.Entidade"%>
<%@page import="afero.model.Entrega"%>
<%@page import="afero.model.Colaborador"%>
<%@page import="afero.model.Loja"%>
<%@page import="afero.persistence.LojaDAO"%>
<%@page import="afero.persistence.EntidadeDAO"%>
<%@page import="afero.persistence.PedidoSaidaDAO"%>
<%@page import="afero.persistence.EntregaDAO"%>
<%@page import="afero.persistence.OrcamentoDAO"%>
<%@page import="afero.persistence.ColaboradorDAO"%>
<%@page import="afero.persistence.OrcamentoPedidoSaidaDAO"%>
<%@page import="afero.persistence.OrdemServicoDAO"%>
<%@page import="afero.persistence.PedidoSaidaItemDAO"%>
<%@ page import="afero.util.Utilitaria" %>
<%@ page import="afero.util.ConverteDate" %>
<%@ page import="afero.model.Produto" %>
<%@ page import="afero.model.Unidade" %>
<%@ page import="afero.model.Estoque" %>
<%@ page import="afero.model.Preco" %>
<%@ page import="afero.persistence.ProdutoDAO" %>
<%@ page import="afero.persistence.CondPagtoDAO" %>
<%@ page import="afero.persistence.UnidadeDAO" %>
<%@ page import="afero.persistence.EstoqueDAO" %>
<%@ page import="afero.persistence.PrecoDAO" %>
<%@ page import="afero.persistence.OrcamentoItemDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@page import="afero.util.Utilitaria"%>
<%@include file="../../seguranca.jsp"%>
<%@include file="../../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../../css/afero.css" />
<script src="../../js/common.js"/></script>
<script>
function salvar() {
  	document.forms[0].submit();
}
</script>
<%
String idLojaUsuario = (String)session.getAttribute("idLoja");
String mensagem = request.getParameter("mensagem");
if(mensagem == null)mensagem = "";
PedidoSaidaDAO daoPedidoSaida = new PedidoSaidaDAO(conn);
String acao = request.getParameter("acao");
if(acao == null)acao="listar";
List list = null;
List listarEstoque = null;
List listarOrcamentoDAO = null;
List listUpdate = null;
ProdutoDAO dao;
EstoqueDAO daoEstoque;
PedidoSaidaItemDAO daoPedidoSaidaItem;
Produto prod = null;
Estoque estoque =null;
PedidoSaidaItem pedidoSaidaItem = null;
int cont = 0;
String preco = "0";
ConverteDate converte = new ConverteDate();
String idPedidoSaida = request.getParameter("idPedidoSaida");
PedidoSaida pedidoSaida = daoPedidoSaida.procurarPedidoSaidaItem(Integer.parseInt(idPedidoSaida));
int idColaborador =pedidoSaida.getIdColaborador();
Colaborador colaborador = new Colaborador();
ColaboradorDAO daoColaborador = new ColaboradorDAO(conn);
colaborador = daoColaborador.procurarColaborador(idColaborador);
String dsColaborador = colaborador.getNome();
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
float valorEntrega = entrega.getTxEntrega();
int cdEntidade =pedidoSaida.getCdEntidade();
String cdCondPagto = "";
if(pedidoSaida.getCdCondPagto()>0){
	cdCondPagto = "".valueOf(pedidoSaida.getCdCondPagto());
}else{
	cdCondPagto = "0";
}
Entidade entidade = new Entidade();
EntidadeDAO daoEntidade = new EntidadeDAO(conn);
entidade = daoEntidade.procurarEntidade(cdEntidade);
String dsEntidade = entidade.getNome();
String status = pedidoSaida.getStatus();
String statusPag = pedidoSaida.getStatusPag();
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
float desconto = pedidoSaida.getVlDesc();
double quantEstoque = 0;
double saldoEstoque = 0;
if (acao.equalsIgnoreCase("gravar")){
	status = request.getParameter("status");
	operacao = request.getParameter("operacao");
	cdCondPagto = request.getParameter("cdCondPagto");
	PedidoSaida pedidoSaidaUpdate = null;
	PedidoSaidaDAO daoPedidoSaidaUpdate = new PedidoSaidaDAO(conn);
	pedidoSaidaUpdate = daoPedidoSaidaUpdate.procurarPedidoSaida(Integer.parseInt(idPedidoSaida));
	//if (!daoPedidoSaidaUpdate.confirmarPedido(Integer.parseInt(idPedidoSaida))) {
		statusPag = request.getParameter("statusPag");
		daoPedidoSaidaUpdate.atualizarStatusPag(Integer.parseInt(idPedidoSaida),statusPag);
		if(Integer.parseInt(cdCondPagto) > 0){
			daoPedidoSaidaUpdate.atualizarCondPagto(Integer.parseInt(idPedidoSaida), Integer.parseInt(cdCondPagto));
		}
		if (!pedidoSaidaUpdate.getStatus().equals("A")) {
			pedidoSaidaUpdate.setStatus(status);
			pedidoSaidaUpdate.setOperacao(operacao);
			daoPedidoSaidaUpdate.atualizar(pedidoSaidaUpdate);
			if(status.equalsIgnoreCase("A")){
				daoPedidoSaidaUpdate.atualizarStatusPag(Integer.parseInt(idPedidoSaida),statusPag);
				Estoque estoqueUpdate = null;
				EstoqueDAO daoEstoqueProcurar = new EstoqueDAO(conn);
				PedidoSaidaItemDAO daoPedidoSaidaItemUpdate = new PedidoSaidaItemDAO(conn);
				listUpdate = daoPedidoSaidaItemUpdate.procurarPedidoSaidaItem(Integer.parseInt(idPedidoSaida));
				for ( Iterator it = listUpdate.iterator(); it.hasNext(); ) {
					PedidoSaidaItem pedidoItemUpdate = (PedidoSaidaItem) it.next();
					estoqueUpdate = daoEstoqueProcurar.procurarEstoque(pedidoItemUpdate.getIdProduto(), idLoja);
					if(estoqueUpdate.getQtEstoque() < 0){
						quantEstoque = (estoqueUpdate.getQtEstoque());
						saldoEstoque = (quantEstoque - pedidoItemUpdate.getQuant());
						estoqueUpdate.setQtEstoque(saldoEstoque);
					}else{
						estoqueUpdate.setQtEstoque((estoqueUpdate.getQtEstoque()) - (pedidoItemUpdate.getQuant()));	
					}
					EstoqueDAO daoEstoqueUpdate = new EstoqueDAO(conn);
					daoEstoqueUpdate.atualizar(estoqueUpdate);
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
      <th class="label">Condição de Pagto*</th>
      <td><select name="cdCondPagto" onchange="recarregar();">
          <option value='0'>Selecione...</option>
          <%@include file="../../WEB-INF/jspf/combo/comboCondicaoPagto.jspf"%></select>
          <script>comboSelect(document.forms[0].cdCondPagto, '<%=cdCondPagto%>');</script>
      </td>
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
    <th class="label">Entrega</th>
    <td><input disabled type="text" name="dsEntrega" <%if (dsEntrega != null) { %>value="<%=dsEntrega%>"<% }%>  size="60" maxlength="60"></td>
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
			<td><input type="text" name="hrEntrega" value="<%=hrEntrega%>"
						size="5" maxlength="5" onblur="chkTime(this,'')"></td>
	  </tr>
  <tr>
      <th class="label">Observação</th>
      <td><textarea disabled="disabled" name="observacao" cols="50" rows="2"><%=observacao %></textarea></td>
  </tr>
  <tr>
    <th class="label" colspan="1">Status</th>
    <td class="label_radio">
      <input  <%if(status.equalsIgnoreCase("A")){%> disabled <%} %>type="radio" class="radio" name="status" value="P" <%= (status.equals("P")? "checked": "") %>>Pendente
      <input type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Atendido
      <input  <%if(status.equalsIgnoreCase("A")){%> disabled <%} %>type="radio" class="radio" name="status" value="C" <%= (status.equals("C")? "checked": "") %>>Cancelado
    </td>
  </tr>
  
   <tr>
    <th class="label" colspan="1">Pago</th>
    <td class="label_radio">
      <input type="radio" class="radio" name="statusPag" value="P" <%= (statusPag.equals("P")? "checked": "") %>>Sim
      <input <%if(statusPag.equalsIgnoreCase("P")){%> disabled <%} %> type="radio" class="radio" name="statusPag" value="N" <%= (statusPag.equals("N")? "checked": "") %>>Não
    </td>
  </tr>
  
  <tr>
    <th class="label" colspan="1">Operação</th>
    <td class="label_radio">
      <input type="radio" class="radio" name="operacao" value="S" <%= (operacao.equals("S")? "checked": "") %>>Saída
      <input disabled type="radio" class="radio" name="operacao" value="T" <%= (operacao.equals("T")? "checked": "") %>>Transferência<br>
      <input disabled type="radio" class="radio" name="operacao" value="EE" <%= (operacao.equals("EE")? "checked": "") %>>Estorno de Entrada Por Devolução
      <input disabled type="radio" class="radio" name="operacao" value="AS" <%= (operacao.equals("AS")? "checked": "") %>>Ajuste de Saída
    </td>
  </tr>
  <tr>
      <th class="label">Anotação</th>
      <td><textarea disabled="disabled" name="anotacao" cols="100" rows="2"><%=anotacao %></textarea></td>
  </tr>
</table><hr>
<table border="0" width="100%">
    <tr>
      <th class="grid"><center></center></th>
      <th class="grid">Loja</th>
      <th class="grid"><center>Descrição do Produto</center></th>
      <th class="grid">Quantidade</th>
      <th class="grid">% Desc.</th>
      <th class="grid">Vl.Unitário</th>
      <th class="grid">Total</th>
      <th class="grid">Unidade</th>
      
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
 float total = 0;
 daoPedidoSaidaItem = new PedidoSaidaItemDAO(conn);
 list = daoPedidoSaidaItem.procurarPedidoSaidaItem(Integer.parseInt(idPedidoSaida));
 if(list != null){
  for ( Iterator it = list.iterator(); it.hasNext(); ) {
	pedidoSaidaItem = (PedidoSaidaItem) it.next();
	dao = new ProdutoDAO(conn);
	prod = dao.procurarProduto(pedidoSaidaItem.getIdProduto());
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
      <td class = "grid" width="5%"><center><%=prod.getDsProduto() + ". "+pedidoSaidaItem.getDsCompProduto()%></center></td>
      <td class="grid" width="3%" name="quantidade%>" size="10" maxlength="10"><%=Utilitaria.formatarNumero(pedidoSaidaItem.getQuant(),2)%></td>
      <td class="grid" width="3%" name="pDesc" size="10" maxlength="10"><%=Utilitaria.formatarNumero(pedidoSaidaItem.getPDesc(),2)%></td>
      <td class="grid" width="3%" name="vlUni" size="10" maxlength="10"><%=Utilitaria.formatarNumero(pedidoSaidaItem.getVlUni(),2)%></td>
      <%float precoItem = Utilitaria.toNumber(preco).floatValue() * pedidoSaidaItem.getQuant(); %>
      <td class="grid" width="3%" name="preco_<%=precoListar.getIdPreco()%>" size="10" maxlength="10"><%=Utilitaria.formatarNumero(precoItem,2)%></td>
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
      
      <th class="grid" width="5%"><center>TOTAL DO PEDIDO:</center></th>
      <td><input type="text" id="total" value="<%=Utilitaria.formatarNumero(total,2)%>" onblur="soma()"></td>
  </tr>
     <tr>
      
      <th class="grid" width="5%"><center>DESCONTO :(%)</center></th>
      <td><input type="text" id="valorEntrega" value="<%=desconto%>" onblur="soma()"></td>
  </tr> 
   <tr>
      
      <th class="grid" width="5%"><center>VALOR C/ O DESCONTO :</center></th>
      <td><input type="text" id="valorEntrega" value="<%=Utilitaria.formatarNumero(valorTotal,2)%>" onblur="soma()"></td>
  </tr>
   <tr>
      
      <th class="grid" width="5%"><center>TAXA DE ENTREGA : <%=dsEntrega%></center></th>
      <td><input type="text" id="valorEntrega" value="<%=Utilitaria.formatarNumero(valorEntrega,2)%>" onblur="soma()"></td>
  </tr>  
  <tr>
      <th class="grid" width="5%"><center>VALOR TOTAL:</center></th>
      <td><input type="text" id="valorTotal" value="<%=Utilitaria.formatarNumero(valorTotal + valorEntrega ,2)%>" onblur="soma()"></td>
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
<%@include file="../../fimConexao.jsp"%>
</body>
</html>