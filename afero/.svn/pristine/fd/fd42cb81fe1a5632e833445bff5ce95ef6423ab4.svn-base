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
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.style5 {
	color: #000066;
	font-weight: bold;
}
-->
.texto {
	font-family: Verdana, Geneva, Arial, Helvetica, sans-serif;
	font-size: 8pt;
	color: Navy;
	border: none;
}
.texto_or {
	font-family: Verdana, Geneva, Arial, Helvetica, sans-serif;
	font-size: 9pt;
	color: Black;
	border: none;
	text-align: left;
}
function Impressao(pedido){
  location.href="impPedido.jsp?impressao=ok&idPedidoSaida="+pedido;
  window.print();
}
</style>
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
if(acao.equalsIgnoreCase("gravar")){
	if(!status.equalsIgnoreCase("A")){
		status = request.getParameter("status");
		if(status.equalsIgnoreCase("A")){
			pedidoEntrada.setStatus("A");
			daoPedidoEntrada.atualizar(pedidoEntrada);
			Estoque estoqueUpdate = null;
			daoPedidoEntradaItem = new PedidoEntradaItemDAO(conn);
			list = daoPedidoEntradaItem.listarProcurarPedidoEntradaItem(pedidoEntrada.getIdPedidoEntrada());
			for ( Iterator it = list.iterator(); it.hasNext(); ) {
				pedidoEntradaItem = (PedidoEntradaItem) it.next();
				EstoqueDAO daoEstoqueProcurar = new EstoqueDAO(conn);
				estoqueUpdate = daoEstoqueProcurar.procurarEstoque(pedidoEntradaItem.getIdProduto(), idLoja);
				estoqueUpdate.setQtEstoque(estoqueUpdate.getQtEstoque() + pedidoEntradaItem.getQuantPedida());
				EstoqueDAO daoEstoqueUpdate = new EstoqueDAO(conn);
				daoEstoqueUpdate.atualizar(estoqueUpdate);
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
<body>
<div align="center"></div>
<table width="700" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
  <tr>
    <td><table width="700" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
      <tr>
        
        <td width="580"><table width="580" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="9" align="left" valign="top">&nbsp;</td>
              <td width="427" class="texto"><strong><%=lojaListar.getRazaoSocial()%></strong></td>
              <td width="132" align="right" class="texto" valign="top"><p><strong><span class="style5">Afero</span></strong></p></td>
              <td width="12" align="right" valign="top">&nbsp;</td>
            </tr>
            <tr>
              <td align="left">&nbsp;</td>
              <td class="texto"><%=lojaListar.getEndereco()+" "%><%=lojaListar.getCmpEndereco()+" "%><%=lojaListar.getBairro()%></td>
              <td align="right" valign="top" class="texto"><strong>Data: </strong><%=dtPed%></td>
              <td align="right" valign="top">&nbsp;</td>
            </tr>
            <tr>
              <td valign="top">&nbsp;</td>
              <td class="texto"><%="Telefone : " + lojaListar.getNroTelefone() %></td>
              <!-- <td align="right" valign="top"><strong>Hora:</strong> 00:00:00</td> -->
              <td align="right" valign="top">&nbsp;</td>
            </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>
<hr>
<br>

<table border="0" width="100%">
   <tr>
    <th align="right" class="texto" style="width: 170px">Loja</th>
    <td type="text" name="dsLoja" size="60" class="texto_or" maxlength="60"><%=dsLoja%></td>
  </tr>
     <tr>
    <th align="right" class="texto">Colaborador</th>
    <td  type="text" name="dsColaborador" class="texto_or" size="60" maxlength="60"><%=dsColaborador%></td>
  </tr>
  <tr>
    <th align="right" class="texto">Fornecedor / Distribuidor</th>
    <td type="text" name="dsEntidade" class="texto_or" size="60" maxlength="60"><%=dsEntidade%></td>
  </tr>
   <tr>
    <th align="right"class="texto">Data do Pedido</th>
    <td type="text" name="dtPed" class="texto_or"size="30" maxlength="30"><%=dtPed%></td>
  </tr>
  <tr>
    <th align="right" class="texto">Data da Movimentação</th>
    <td class="texto_or" type="text" name="dtMov" size="30" maxlength="30"><%=dtMov%></td>
  </tr>
  <tr>
      <th align="right"class="texto">Observação</th>
      <td><textarea name="observacao" class="texto_or" cols="60" rows="5"><%=observacao%></textarea></td>
  </tr>
  <tr>
    <th class="texto" align="right" colspan="1">Status</th>
    <td class="texto_or">
      <input type="radio" class="texto_or" name="status" value="P" <%= (status.equals("P")? "checked": "") %>>Pendente
      <input type="radio" class="texto_or" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Atendido
      <input type="radio" class="texto_or" name="status" value="C" <%= (status.equals("C")? "checked": "") %>>Cancelado
    </td>
  </tr>
  <tr>
    <th class="texto" colspan="1" align="right">Operação</th>
    <td class="texto_or">
      <input type="radio" class="texto_or" name="operacao" value="E" <%= (operacao.equals("E")? "checked": "") %>>Entrada
      <input type="radio" class="texto_or" name="operacao" value="T" <%= (operacao.equals("T")? "checked": "") %>>Transferência<br>
      <input type="radio" class="texto_or" name="operacao" value="ES" <%= (operacao.equals("ES")? "checked": "") %>>Estorno de Saída Por Devolução
      <input type="radio" class="texto_or" name="operacao" value="AE" <%= (operacao.equals("AE")? "checked": "") %>>Ajuste de Entrada
    </td>
  </tr>
</table><hr>
<table border="0" width="100%">
    <tr>
      <th class="texto"><center></center></th>
      <th class="texto">Loja</th>
      <th class="texto"><center>Descrição do Produto</center></th>
      <th class="texto">Preço</th>
      <th class="texto">C.S.T.</th>
      <th class="texto">CFOP</th>
      <th class="texto">Quant.</th>
      <th class="texto">BC.ICMS</th>
      <th class="texto">V.ICMS</th>
      <th class="texto">BC. ICMS ST</th>
      <th class="texto">VL. ICMS ST</th>
      <th class="texto">ICMS</th>
      <th class="texto">IPI</th>
      <th class="texto">Unidade</th>
      
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
      <td class = "texto_or" width="1%"><center><%=cont%></center></td>
      <td class = "texto_or" width="5%"><center><%=lojaEstoque.getApelido()%>/<%=lojaEstoque.getRazaoSocial()%></center></td>
      <td class = "texto_or" width="5%"><center><%=prod.getDsProduto() %></center></td>
      <%float precoItem = pedidoEntradaItem.getValor() * pedidoEntradaItem.getQuant(); %>
      <td class="texto_or" width="3%" name="preco_<%=precoListar.getIdPreco()%>" size="10" maxlength="10"><center><%=Utilitaria.formatarNumero(pedidoEntradaItem.getValor(),2)%></center></td>
      <td class = "texto_or" width="5%"><center><%=pedidoEntradaItemFiscal.getNfNCST() %></center></td>
      <td class = "texto_or" width="5%"><center><%=pedidoEntradaItemFiscal.getNfICFOP() %></center></td>
      <td class="texto_or" width="3%" name="quantidade%>" size="10" maxlength="10"><center><%=Utilitaria.formatarNumero(pedidoEntradaItem.getQuant(),2)%></center></td>
            <td class = "grid" width="5%"><center><%=Utilitaria.formatarNumero(pedidoEntradaItemFiscal.getNfNvBC(), 2)%></center></td>
      <td class = "texto_or" width="5%"><center><%=Utilitaria.formatarNumero(pedidoEntradaItemFiscal.getNfNvICMS(), 2)%></center></td>
      <td class = "texto_or" width="5%"><center><%=Utilitaria.formatarNumero(pedidoEntradaItemFiscal.getNfNvBCST(), 2) %></center></td>
      <td class = "texto_or" width="5%"><center><%=Utilitaria.formatarNumero(pedidoEntradaItemFiscal.getNfNvICMSST(), 2)%></center></td>
      <td class = "texto_or" width="5%"><center><%=Utilitaria.formatarNumero(pedidoEntradaItemFiscal.getNfNpICMS(), 2)%></center></td>
      <td class = "texto_or" width="5%"><center><%=Utilitaria.formatarNumero(pedidoEntradaItemFiscal.getNfOvIPI(), 2) %></center></td>
      <td class = "texto_or" width="3%"><center><%=unidadeListar.getDsUnidade()%></center></td>
      <%total = total +  precoItem;%>
  </tr>
  
<%
		}
	}
	}
}
%>
   
  
<% 
 }
%> 
  <tr>
      <th class="texto" width="5%"><center>VALOR TOTAL:</center></th>
      <td type="texto_or"><%=Utilitaria.formatarNumero((total),2)%></td>
  </tr>
  <br>
</table>
<br>
<%@include file="../fimConexao.jsp"%>
</body>
</html>