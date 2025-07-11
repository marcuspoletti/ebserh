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
  document.forms[0].action='consultarProdutoEst.jsp?acao='+acao;
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.nomeProduto.value = '';
  document.all.status.value = 'A'; //não está limpando
  document.forms[0].submit();
} 
function recarregar(acao) {
  document.forms[0].action='consultarProdutoEst.jsp?acao='+acao;
  document.forms[0].submit();
}
</script>

<%
ProdutoDAO dao;
String status = request.getParameter("status");
if(status == null) status = "A";
String acao = request.getParameter("acao");
if(acao == null) acao = "listar";
String clausula = "";
String nomeProduto = request.getParameter("nomeProduto");
if(nomeProduto == null) nomeProduto = "";
int cont = 0;
String cdLoja = request.getParameter("idLoja");
int idLoja = 0;
if (cdLoja == null) {
	idLoja = Integer.parseInt((String)session.getAttribute("idLoja"));
} else {
	idLoja = Integer.parseInt(cdLoja);
}

//-------------------------------------
if (nomeProduto!= null) {
          clausula = " WHERE p.dsProduto LIKE '"+nomeProduto+"%' AND e.status= 'A' AND e.idLoja = "+idLoja+" AND p.status = '"+status+"' AND pr.precoPadrao = 'S' ORDER BY p.dsProduto ";
}else{
	clausula = " WHERE e.status= 'A' AND e.idLoja = "+idLoja+" AND p.status = '"+status+"' AND pr.precoPadrao = 'S' ORDER BY p.dsProduto ";	
}
//-------------------------------------
//seleciona todos os registros do banco de dados
List list = null;
dao = new ProdutoDAO(conn);
list = dao.listarProdutoEstoquePreco(clausula);

%>

<h1 class="cabecalho_pagina">Consulta de Produtos</h1>

<hr>

<body onload="document.forms[0].elements[0].focus();" >
<form action="consultarProdutoEst.jsp?acao=<%=acao%>">
<input type="hidden" name="acao" value="<%=acao%>"/>

<table colspan="2">
  <tr>
      <th class="label">Loja</th>
      <td><select id="idLoja" name="idLoja">
          <option value='0'>Todos...</option>
          <%@include file="../WEB-INF/jspf/combo/comboLoja.jspf" %></select>
          <script>comboSelect(document.forms[0].idLoja, '<%= idLoja %>');</script>
      </td>
  </tr>

  <tr>
    <th class='label'>Descrição do Produto</th>
    <td><input type="text" name="nomeProduto" <%if (nomeProduto != null) { %>value="<%=nomeProduto%>"<% }%>  size="40" maxlength="40"></td>
    <td><input class="button" type="button" value="Localizar" onClick="javascript:localizar();" /></td>
     <td><input class="button" type="button" value="Nova pesquisa" onClick="javascript:novaPesquisa();" /></td>
  </tr>
  <%--
  <tr>
    <th class="label">Status</th>
    <td class="label_radio">
      <%--<input type="radio" class="radio" name="status" value="" <%= (status.equals("")? "checked": "") %>>Todos
      <input type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Ativo
      <input type="radio" class="radio" name="status" value="I" <%= (status.equals("I")? "checked": "") %>>Inativo</td>
  </tr>
   --%>
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
      <th class="grid">Diferença</th>
      <th class="grid">Inventário</th>
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
      <td class = "grid" width="5%"><center><%=cont%></center></td>
      <td class = "grid" width="10%"><center><%=prod.getApelidoLoja()%></center></td>
      <td class = "grid"><center><%=prod.getDsProduto() %></center></td>
      <td class = "grid" width="5%"><center><%=prod.getTipoProduto()%></center></td>
      <td class = "grid" width="5%"><center><%=prod.getStatus()%></center></td>
      <td class = "grid" width="5%"><center><%=Utilitaria.formatarNumero(prod.getQtEstoque(),2)%></center></td>
      <td class = "grid" width="5%" size="10" maxlength="10"></td>
      <td class = "grid" width="5%"><center></center></td>
      <td class = "grid" width="5%"><center><%=prod.getDsUnidade()%></center></td> 
  </tr>
  
<%

          total +=prod.getQtEstoque()* prod.getPreco();
  
}

%>   
   <tr>
      <td class = "grid" width="5%"><center></center> - </td>
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