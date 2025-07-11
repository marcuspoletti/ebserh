<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.Produto" %>
<%@ page import="afero.model.Estoque" %>
<%@ page import="afero.model.Preco" %>
<%@ page import="afero.model.Divisao" %>
<%@ page import="afero.persistence.ProdutoDAO" %>
<%@ page import="afero.persistence.DivisaoDAO" %>
<%@ page import="afero.persistence.EstoqueDAO" %>
<%@ page import="afero.persistence.PrecoDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Date" %>
<%@ page import="afero.util.ConverteDate" %>
<%@page import="afero.util.Utilitaria"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/></script>

<script>

function localizar() {
  document.forms[0].action="formPreco.jsp";
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.forms[0].action="formPreco.jsp";
  document.all.nomeProduto.value = '';
  document.all.status.value = ''; //não está limpando
  document.forms[0].submit();
} 
function salvar() {
  document.forms[0].submit();	
}

function cancelar() {
  document.forms[0].action="formPreco.jsp";
  document.forms[0].submit();
}

function voltar() {
    document.forms[0].action = 'listarPreco.jsp?acao=voltar'
	document.forms[0].submit(); 
}

function recarregar(acao) {
  document.forms[0].action='formPreco.jsp?acao='+acao;
  document.forms[0].submit();
}
</script>

<%
List list = null;

ProdutoDAO dao; 
Produto prod = null;
String nomeProduto = request.getParameter("nomeProduto");
if (nomeProduto == null) nomeProduto = "";
String status = request.getParameter("status");
String mensagem = request.getParameter("mensagem");
if (mensagem == null) mensagem = "";
if (status == null) status = "A";
String acao = request.getParameter("acao");
if (acao == null) acao="inc";
String clausula = "";
int cont = 0;
int idUnidade;
String preco = "0";
int idEstoque = 0;
String idLoja = request.getParameter("idLoja");
if (idLoja == null) idLoja = "0";

if (!acao.equalsIgnoreCase("voltar")) {
  nomeProduto = request.getParameter("nomeProduto");
  status = request.getParameter("status");
  if (status == null) status = "A";
}
	
//if(!acao.equalsIgnoreCase("atu")){
if (!idLoja.equals("0")) {
  clausula = " WHERE e.idLoja = "+idLoja;
}
if (nomeProduto!= null) {
  if (clausula.isEmpty()) {
    clausula = " WHERE p.dsProduto LIKE '"+nomeProduto+"%'";
  } else {
    clausula = clausula+" AND p.dsProduto LIKE '"+nomeProduto+"%'";
  }
} 
if (!status.isEmpty()) {
  if (clausula.isEmpty()) {
    clausula = " WHERE p.status='"+status+"'";
  } else {
    clausula = clausula+" AND p.status='"+status+"'";
  }
}
  		
dao = new ProdutoDAO(conn);
if (!clausula.equals("")) {
	clausula = clausula+" ORDER BY p.dsProduto ";	
} else if (clausula.equals("")) {
 	clausula = " WHERE e.idLoja="+idLoja+" ORDER BY p.dsProduto";
}
list = dao.listarProdutoPrecoLoja(clausula, Utilitaria.toNumber(idLoja).intValue());
//}
   
%>

<h1 class="cabecalho_pagina">Cadastro de Preco</h1>
<body onload="document.forms[0].elements[0].focus();" >
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<form action="listarPreco.jsp" method="post">

<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="cont" value="<%=cont%>"/>
<table colspan="2">
  <tr>
    <th class="label">Loja</th>
      <td><select name="idLoja" onchange="recarregar('<%=acao%>');">
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboLoja.jspf" %></select>
          <script>comboSelect(document.forms[0].idLoja, '<%= idLoja %>');</script>
      </td>
    <td><input class="button" type="button" value="Localizar" onClick="javascript: localizar();" /></td>
    <td><input class="button" type="button" value="Nova pesquisa" onClick="javascript: novaPesquisa();" /></td>
  </tr>
  <tr>
    <th class='label'>Descrição do Produto</th>
    <td><input type="text" name="nomeProduto" <%if (nomeProduto != null) { %>value="<%=nomeProduto%>"<% }%>  size="40" maxlength="40"></td>
  </tr>
  <tr>
    <th class="label">Status</th>
    <td class="label_radio">
      <input type="radio" class="radio" name="status" value="" <%= (status.equals("")? "checked": "") %>>Todos
      <input type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Ativo
      <input type="radio" class="radio" name="status" value="I" <%= (status.equals("I")? "checked": "") %>>Inativo</td>
  </tr>
</table>
<hr>

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
  <tr>  
    <th class="grid"><center></center></th>
    <th class="grid"><center>Selecionar</center></th>
    <th class="grid"><center>Descrição do Produto</center></th>
    <th class="grid"><center>Divisão</center></th>
    <th class="grid">Tipo do Produto</th>
    <th class="grid">Status</th>
    <th class="grid">Preço</th>
    <th class="grid">Unidade</th>
  </tr>
<%
if (acao.equalsIgnoreCase("atu")) {
	ProdutoDAO prodAtu = new ProdutoDAO(conn);
	EstoqueDAO estoqueAtu = new EstoqueDAO(conn);
	String idPreco = request.getParameter("idPreco");
	Preco precoAtu = new Preco();
	PrecoDAO preAtu = new PrecoDAO(conn);
	precoAtu = preAtu.procurarPreco(Integer.parseInt(idPreco));
	idEstoque = precoAtu.getIdEstoque();
	Estoque estPreco = estoqueAtu.procurarEstoque(idEstoque);
	idUnidade = precoAtu.getIdUnidade();
	preco = Utilitaria.formatarNumero(precoAtu.getPreco(),2).toString();
	list = prodAtu.listarProcurarProduto(estPreco.getIdProduto());
}

//int cont = 0;
int gridSize = 15;
String rowNumStr = request.getParameter("rowNum");
int rowNum = (rowNumStr == null ? 0: Integer.parseInt(rowNumStr));
if (rowNum < 0) rowNum = 0;
boolean hasNext = false;
int rowCount = list.size();
int rowLast = 0;
if (rowCount > 0) {
  if (rowCount > gridSize) {
    rowLast = rowNum+gridSize+1; 
    if (rowLast >= rowCount && rowCount > 0) rowLast = rowCount;
    if (rowNum > rowLast) rowNum = 0;
    list = list.subList(rowNum, rowLast);
  }
  hasNext = true;
}

//Utiliza o ResultSet para trazer os registros do banco de dados
List listarEstoque;
Estoque est = null;
for ( Iterator it = list.iterator(); hasNext && cont < gridSize; hasNext = it.hasNext()) {
  prod = (Produto) it.next();
	EstoqueDAO estoqueProd = new EstoqueDAO(conn);
	listarEstoque = estoqueProd.procurarEstoquePrecoLoja(prod.getIdProduto(), Integer.parseInt(idLoja));
	DivisaoDAO dao1 = new DivisaoDAO(conn);
	Divisao divisao = dao1.procurarDivisao(prod.getIdDivisao());
	if (listarEstoque != null) {
		for ( Iterator itx = listarEstoque.iterator(); itx.hasNext(); ) {
	 	  est = (Estoque) itx.next();
	 	  PrecoDAO daoPrecoListar = new PrecoDAO(conn);
		  Preco precoListar = daoPrecoListar.procurarPrecoList(est.getIdEstoque(), prod.getIdProduto());
	 	  if (precoListar != null) {
		    preco = Utilitaria.formatarNumero(precoListar.getPreco(),2).toString();
		    idUnidade = precoListar.getIdUnidade();
	    } else {
			  preco = "0";
			  idUnidade = 0;
		  }
	  cont++;
%>
  <tr>
    <td class = "grid" width="2%"><center><%=rowNum+cont%></center></td>
    <input type="hidden" name="idEstoque_<%=prod.getIdProduto()%>" value="<%=est.getIdEstoque()%>"/>
    <td class = "grid"><input type="checkbox" name="idProduto_<%=prod.getIdProduto()%>" value="<%=prod.getIdProduto()%>"></td>
    <td class = "grid"><center><a target="_blank" href="formProduto.jsp?acao=atu&idProduto=<%=prod.getIdProduto()%>"><%=prod.getNmProduto()%> / <%=prod.getDsProduto() %></a> </center></td>
    <td class = "grid" width="20%"><center><%=divisao.getDsDivisao()%></center></td>
    <td class = "grid" width="5%"><center><%=prod.getTipoProduto()%></center></td>
    <td class = "grid" width="5%"><center><%=prod.getStatus()%></center></td>
    <td class="grid" width="5%"><input type="text"  name="preco_<%=prod.getIdProduto()%>" value="<%=preco%>" onkeyup="FormataValor(this,event)" size="10" maxlength="10"></td>
    <td width="5%"><select name="idUnidade_<%=prod.getIdProduto()%>" >
        <option value='0'>Selecione...</option>
        <%@include file="../WEB-INF/jspf/combo/comboUnidadeDe.jspf" %></select>
        <script>comboSelect(document.forms[0].idUnidade_<%=prod.getIdProduto()%>, '<%=idUnidade%>');</script>
    </td>
  </tr>
    <input type="hidden" name="idProduto" value="<%=prod.getIdProduto()%>"/>    
<%
	  }
  }
}

%>   
      
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
	<td><input class="button" type="button" value="Salvar" onClick="javascript: salvar();" />
	<input class="button" type="button" value="Cancelar" onClick="javascript: cancelar();" />
	<input class="button" type="button" value="Voltar" onClick="javascript: voltar();" /></td>
	<td class="campo_obrigatorio">* Campos Obrigatórios</td>
</tr>
</table>
</form>
<br >
<%  if (rowNum != 0 || hasNext) { %>
        <center>
<%      if (rowNum != 0) { %>
<a class="link" href="formPreco.jsp?rowNum=<%=0%>&idLoja=<%=idLoja%>&nomeProduto=<%=nomeProduto%>&status=<%=status%>">Primeira</a>&nbsp&nbsp
|&nbsp&nbsp<a class="link" href="formPreco.jsp?rowNum=<%=rowNum-gridSize%>&idLoja=<%=idLoja%>&nomeProduto=<%=nomeProduto%>&status=<%=status%>">< Anterior</a>&nbsp&nbsp
<%      } else { %>
Primeira&nbsp&nbsp|&nbsp&nbsp< Anterior&nbsp
<%      } %>
<%      if (hasNext) { %>
|&nbsp&nbsp<a class="link" href="formPreco.jsp?rowNum=<%=rowNum+gridSize%>&idLoja=<%=idLoja%>&nomeProduto=<%=nomeProduto%>&status=<%=status%>">Próxima ></a>&nbsp&nbsp
|&nbsp&nbsp<a class="link" href="formPreco.jsp?rowNum=<%=rowCount-gridSize%>&idLoja=<%=idLoja%>&nomeProduto=<%=nomeProduto%>&status=<%=status%>">Última</a>
<%      } else { %>
|&nbsp&nbsp Próxima >&nbsp&nbsp|&nbsp&nbspÚltima
<%      } %>
        </center>
<%  } %>
<%@include file="../fimConexao.jsp"%>