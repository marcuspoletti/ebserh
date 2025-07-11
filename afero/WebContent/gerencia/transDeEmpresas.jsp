<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.Produto" %>
<%@ page import="afero.model.Preco" %>
<%@ page import="afero.model.Divisao" %>
<%@ page import="afero.model.Estoque" %>
<%@ page import="afero.model.Loja" %>
<%@ page import="afero.model.Produto" %>
<%@ page import="afero.persistence.ProdutoDAO" %>
<%@ page import="afero.persistence.PrecoDAO" %>
<%@ page import="afero.persistence.DivisaoDAO"%>
<%@ page import="afero.persistence.EstoqueDAO"%>
<%@ page import="afero.persistence.ProdutoDAO"%>
<%@ page import="afero.persistence.LojaDAO" %>
<%@ page import="afero.util.Utilitaria" %>
<%@page import ="java.util.*" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css"/>
<script src="../js/common.js"/></script>
<script>
function salvar() {
  if (document.all.idLojaDe.value == '0') {
    window.alert("O campo Loja De é obrigatório.");
    document.all.idLojaDe.focus();
   } else if (document.all.idLojaPara.value == '0') {
    window.alert("O campo Loja Para é obrigatório.");
    document.all.idLojaPara.focus();
   }else if (document.all.idLojaPara.value == document.all.idLojaDe.value) {
	    window.alert("O campo Loja Para não pode ser igual a Loja De.");
	    document.all.idLojaPara.focus();
   }else {
         document.forms[0].action ='transDeEmpresas.jsp?acao=atu';
  	document.forms[0].submit();
  }
}
</script>

<%
ProdutoDAO daoProdutoList = new ProdutoDAO(conn);

PrecoDAO daoPreco = new PrecoDAO(conn);
EstoqueDAO daoEstoque = new EstoqueDAO(conn);
Estoque estoque = new Estoque();
Preco preco = new Preco();
String usuarioEstoque = (String)session.getAttribute("Login");
String status = "A";
int cdEstoque = 0;
String acao = request.getParameter("acao");
if(acao == null)acao = "listar";
String idLojaDe = request.getParameter("idLojaDe");
String idLojaPara = request.getParameter("idLojaPara");
if(idLojaDe == null)idLojaDe="0";
if(idLojaPara == null)idLojaPara = "0";
String quantMin = request.getParameter("quantMin");
if(quantMin == null)quantMin = "0";
String quantMax = request.getParameter("quantMax");
if(quantMax == null)quantMax = "0";
String quantAtual = request.getParameter("quantAtual");
if(quantAtual == null)quantAtual = "0";
if(acao.equalsIgnoreCase("atu")){
int cont = 0;
String clausula = " ORDER BY dsProduto ";
List list = daoProdutoList.listarProduto(clausula);
for (Iterator it = list.iterator(); it.hasNext();) {
	cont ++;
	Produto prod = (Produto) it.next();
	
	//Preenchendo o estoque
         estoque.setIdLoja(Integer.parseInt(idLojaPara));
	estoque.setUsuario(usuarioEstoque);
	estoque.setIdProduto(prod.getIdProduto());
	estoque.setQtEstoque(Utilitaria.toNumber(quantAtual).doubleValue());
	estoque.setQtMinimo(Utilitaria.toNumber(quantMin).doubleValue());
	estoque.setQtMaximo(Utilitaria.toNumber(quantMax).doubleValue());
	estoque.setStatus(status);
	//Inserção no Estoque. Recuperando o Id do Estoque
	cdEstoque = daoEstoque.incluirProduto(estoque);
	//Recuperando o Estoque e Preço anterior
	Estoque estoqueDe = daoEstoque.procurarEstoqueLojaProduto(Integer.parseInt(idLojaDe), prod.getIdProduto());
	Preco precoDe = daoPreco.procurarPrecoEstoqueLoja(estoqueDe.getIdEstoque(), Integer.parseInt(idLojaDe));
	//Inserção na Tabela de Preços
	preco.setIdEstoque(cdEstoque);
	preco.setIdUnidade(precoDe.getIdUnidade());
	preco.setPreco(precoDe.getPreco());
	preco.setCustoDireto(preco.getCustoDireto());
         preco.setCustoReal(precoDe.getCustoReal());
	preco.setCustoMedioGeral(precoDe.getCustoMedioGeral());
	preco.setUsuario(usuarioEstoque);
	preco.setPrecoPadrao(precoDe.getPrecoPadrao());
	//Incluindo o preço
	daoPreco.incluir(preco);
}
}

%>
<body onload="document.forms[0].elements[2].focus();">
<h1 class="cabecalho_pagina">Duplicar Produtos entre Lojas</h1>
<form method="post" action="transDeEmpresas.jsp">
<table border="0" width="100%">
   <tr>
      <th class="label">De*</th>
      <td><select name="idLojaDe">
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboLoja.jspf" %></select>
          <script>comboSelect(document.forms[0].idLojaDe, '<%= idLojaDe %>');</script>
      </td>
  </tr>
     <tr>
      <th class="label">Para*</th>
      <td><select name="idLojaPara">
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboLojaPara.jspf" %></select>
          <script>comboSelect(document.forms[0].idLojaPara, '<%= idLojaPara %>');</script>
      </td>
  </tr>
  <tr>
    <th class="label">Quant. Min.</th>
    <td><input type="text" id="quantMin" name="quantMin" <%if (quantMin != null) { %>value="<%=quantMin%>"<% }%>  size="5" maxlength="5"></td>
  </tr>
   <tr>
    <th class="label">Quant. Max.</th>
    <td><input type="text" id="quantMax" name="quantMax" <%if (quantMax != null) { %>value="<%=quantMax%>"<% }%>  size="5" maxlength="5"></td>
  </tr>
  <tr>
    <th class="label">Quant. Atual</th>
    <td><input type="text" id="quantAtual" name="quantAtual" <%if (quantAtual!= null) { %>value="<%=quantAtual%>"<% }%>  size="5" maxlength="5" ></td>
  </tr>
  </table>
  <br>
  <table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
	<td><center><input class="button" type="button" value="Duplicar" onClick="javascript: salvar();" /></center></td>
</tr>
</table>
  </form>
<%@include file="../fimConexao.jsp"%>