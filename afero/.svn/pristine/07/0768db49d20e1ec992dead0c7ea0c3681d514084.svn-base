<%@page import="afero.model.ProdutoEstoquePreco"%>
<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.Produto" %>
<%@ page import="afero.model.Unidade" %>
<%@ page import="afero.model.EstoqueProdutoPreco" %>
<%@ page import="afero.model.Preco" %>
<%@ page import="afero.model.Loja" %>
<%@ page import="afero.persistence.ProdutoDAO" %>
<%@ page import="afero.persistence.UnidadeDAO" %>
<%@ page import="afero.persistence.EstoqueDAO" %>
<%@ page import="afero.persistence.LojaDAO" %>
<%@ page import="afero.persistence.PrecoDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@page import="afero.util.Utilitaria"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/></script>

<script>

function localizar() {
  //document.forms[0].action='listarProdutoEstoque.jsp?acao='+acao;
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.nomeProduto.value = '';
  document.all.status.value = 'A'; //não está limpando
  document.forms[0].submit();
} 
function recarregar(acao) {
  document.forms[0].action='listarProdutoEstoque.jsp?acao='+acao;
  document.forms[0].submit();
}
</script>

<%
ProdutoDAO dao;
String tipoProduto = request.getParameter("tipoProduto");
if(tipoProduto == null) tipoProduto = "";
String status = request.getParameter("status");
if(status == null) status = "A";
String itens = request.getParameter("itens");
if(itens == null) itens = "";
String acao = request.getParameter("acao");
if(acao == null) acao = "listar";
String clausula = "";

int cont = 0;
String cdLoja = request.getParameter("idLoja");
int idLoja = 0;
if (cdLoja == null) {
	idLoja = Integer.parseInt((String)session.getAttribute("idLoja"));
} else {
	idLoja = Integer.parseInt(cdLoja);
}

clausula = clausula+" WHERE e.idLoja = "+idLoja;

if (!tipoProduto.isEmpty()) {
    if (clausula.isEmpty()) {
      clausula = " WHERE p.tipoProduto='"+tipoProduto+"'";
    } else {
      clausula = clausula+" AND p.tipoProduto='"+tipoProduto+"'";
    }
  }

if (!itens.isEmpty() && itens.equals("Z")) {
    if (clausula.isEmpty()) {
      clausula = " WHERE (e.qtEstoque IS NULL OR e.qtEstoque <= 0)";
    } else {
      clausula = clausula+" AND (e.qtEstoque IS NULL OR e.qtEstoque <= 0)";
    }
  }

if (!status.isEmpty()) {
    if (clausula.isEmpty()) {
      clausula = " WHERE e.status= '"+status+"'";
    } else {
      clausula = clausula+" AND e.status= '"+status+"'";
    }
  }

clausula = clausula+" AND pr.precoPadrao = 'S' ";
clausula = clausula+" ORDER BY p.dsProduto ";

//System.out.println(clausula);

//seleciona todos os registros do banco de dados
List list = null;
dao = new ProdutoDAO(conn);
list = dao.listarProdutoEstoquePreco(clausula);

%>

<h1 class="cabecalho_pagina">Listagem de Produtos</h1>

<hr>

<body onload="document.forms[0].elements[0].focus();" >
<form action="listarProdutoEstoque.jsp?acao=<%=acao%>">
<input type="hidden" name="acao" value="<%=acao%>"/>

<table colspan="2">
  <tr>
      <th class="label">Loja</th>
      <td><select id="idLoja"name="idLoja" onchange="recarregar('<%=acao%>');" >
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboLoja.jspf" %></select>
          <script>comboSelect(document.forms[0].idLoja, '<%= idLoja %>');</script>
      </td>
  </tr>
<%--  
  <tr>
    <th class='label'>Descrição do Produto</th>
    <td><input type="text" name="nomeProduto" <%if (nomeProduto != null) { %>value="<%=nomeProduto%>"<% }%>  size="40" maxlength="40"></td>
  </tr>
  --%>
  <tr>
    <th class="label">Tipo do Produto</th>
    <td class="label_radio">
      <input type="radio" class="radio" name="tipoProduto" value="" <%= (tipoProduto.equals("")? "checked": "") %>>Todos
      <input type="radio" class="radio" name="tipoProduto" value="SP" <%= (tipoProduto.equals("SP")? "checked": "") %>>Serviço Próprio
      <input type="radio" class="radio" name="tipoProduto" value="ST" <%= (tipoProduto.equals("ST")? "checked": "") %>>Serviço de Terceiros
      <input type="radio" class="radio" name="tipoProduto" value="PP" <%= (tipoProduto.equals("PP")? "checked": "") %>>Produto Próprio
      <input type="radio" class="radio" name="tipoProduto" value="PT" <%= (tipoProduto.equals("PT")? "checked": "") %>>Produto de Terceiros
      <input type="radio" class="radio" name="tipoProduto" value="MP" <%= (tipoProduto.equals("MP")? "checked": "") %>>Matéria Prima </td>
  </tr>
  <tr>
    <th class="label">Itens do estoque</th>
    <td class="label_radio">
      <input type="radio" class="radio" name="itens" value="" <%= (itens.equals("")? "checked": "") %>>Todos
      <input type="radio" class="radio" name="itens" value="Z" <%= (itens.equals("Z")? "checked": "") %>>Estoque zerado
  </tr>
  <tr>
    <th class="label">Status</th>
    <td class="label_radio">
      <input type="radio" class="radio" name="status" value="" <%= (status.equals("")? "checked": "") %>>Todos
      <input type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Ativo
      <input type="radio" class="radio" name="status" value="I" <%= (status.equals("I")? "checked": "") %>>Inativo</td>
    <td><input class="button" type="button" value="Localizar" onClick="javascript: localizar();" /></td>
  </tr>
</table>
<hr>

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr>
      
      <th class="grid"><center></center></th>
      <th class="grid">Loja</th>
      <th class="grid"><center>Descrição do Produto</center></th>
      <th class="grid">Tipo do Produto</th>
      <th class="grid">Status</th>
      <th class="grid">Quantidade</th>
      <th class="grid">Preço</th>
      <th class="grid">Total</th>
      <th class="grid">Unidade</th>
    </tr>
<%

//Utiliza o ResultSet para trazer os registros do banco de dados
double total  = 0;
EstoqueProdutoPreco prod;
for ( Iterator it = list.iterator();it.hasNext();) {
	prod = (EstoqueProdutoPreco) it.next();
	cont++;	
	
	
%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid" width="10%"><center><%=prod.getApelidoLoja()%></center></td>
      <td class = "grid"><center><%=prod.getDsProduto() %></center></td>
      <td class = "grid" width="5%"><center><%=prod.getTipoProduto()%></center></td>
      <td class = "grid" width="5%"><center><%=prod.getStatus()%></center></td>
      <td class = "grid" width="5%"><center><%=Utilitaria.formatarNumero(prod.getQtEstoque(),2)%></center></td>
      <td class = "grid" width="5%" size="10" maxlength="10"><%=prod.getPreco()%></td>
      <td class = "grid" width="5%"><center><%=Utilitaria.formatarNumero((prod.getQtEstoque()* prod.getPreco()), 2)%></center></td>
      <td class = "grid" width="5%"><center><%=prod.getDsUnidade()%></center></td> 
  </tr>
  
<%

          total +=prod.getQtEstoque()* prod.getPreco();
  
}

%>   
   <tr>
      <td class = "grid" width="2%"><center></center> - </td>
      <td class = "grid" width="10%"><center></center> - </td>
      <td class = "grid"> - </td>
      <td class = "grid" width="5%"> - </td>
      <td class = "grid" width="5%"> - </td>
      <td class = "grid" width="5%"> - </td>
      <td class = "grid" width="5%"> - </td>
      <td class = "grid" width="5%"><center><%=Utilitaria.formatarNumero(total, 2)%></center></td>
      <td class = "grid" width="5%"> - </td>
  </tr>
      
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
  <br>
	<input class="button"type="button" value="Imprimir" onclick="javascript:window.print()">
  </tr>
</table>
</form>

<%@include file="../fimConexao.jsp"%>