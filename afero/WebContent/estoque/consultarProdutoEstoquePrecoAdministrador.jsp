<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.Produto" %>
<%@ page import="afero.model.Unidade" %>
<%@ page import="afero.model.Estoque" %>
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
  document.forms[0].action="consultarProdutoEstoquePreco.jsp";
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.forms[0].action="consultarProdutoEstoquePreco.jsp";
  document.all.nomeProduto.value = '';
  document.all.status.value = ''; //não está limpando
  document.forms[0].submit();
} 
function salvar() {
  document.all.acao.value='atu';
  document.forms[0].submit();	
}

function cancelar() {
  document.forms[0].action="consultarProdutoEstoquePreco.jsp";
  document.forms[0].submit();
}

function recarregar(acao) {
  document.forms[0].action='consultarProdutoEstoquePreco.jsp?acao='+acao;
  document.forms[0].submit();
}

</script>

<%
ProdutoDAO dao;
EstoqueDAO daoEstoque;
Produto prod = null;
Estoque estoque =null;
String nomeProduto = request.getParameter("nomeProduto");
if(nomeProduto == null) nomeProduto = "";
String status = request.getParameter("status");
if(status == null) status = "A";
String acao = request.getParameter("acao");
if(acao == null) acao="listar";
String clausula = "";
int cont = 0;
String preco = "0";
String cdLoja = request.getParameter("idLoja");
int idLoja = 0;
if (cdLoja == null) {
	idLoja = Integer.parseInt((String)session.getAttribute("idLoja"));
} else {
	idLoja = Integer.parseInt(cdLoja);
}

if (nomeProduto!= null) {
  clausula = " WHERE dsProduto LIKE '"+nomeProduto+"%'";
} 
if (!status.isEmpty()) {
if (clausula.isEmpty()) {
  clausula = " WHERE status='"+status+"'";
} else {
  clausula = clausula+" AND status='"+status+"'";
  }
}	
clausula = clausula+" ORDER BY dsProduto ";

//seleciona todos os registros do banco de dados
List list = null;
List listarEstoque = null;
dao = new ProdutoDAO(conn);
list = dao.listarProduto(clausula);

%>

<h1 class="cabecalho_pagina">Consulta de Estoques</h1>

<hr>

<body onload="document.forms[0].elements[0].focus();" >
<form action="consultarProdutoEstoquePrecoAdministrador.jsp?acao=listar">

<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="cont" value="<%=cont%>"/>
<table colspan="2">
<tr>
      <th class="label">Loja</th>
      <td><select id="idLoja"name="idLoja" onchange="recarregar('<%=acao%>');" >
          <option value='0'>Todos...</option>
          <%@include file="../WEB-INF/jspf/combo/comboLoja.jspf" %></select>
          <script>comboSelect(document.forms[0].idLoja, '<%= idLoja %>');</script>
      </td>
      </tr>
  <tr>
    <th class='label'>Descrição do Produto</th>
    <td><input type="text" name="nomeProduto" <%if (nomeProduto != null) { %>value="<%=nomeProduto%>"<% }%>  size="40" maxlength="40"></td>
    <td><input class="button" type="button" value="Localizar" onClick="javascript: localizar();" /></td>
    <td><input class="button" type="button" value="Nova pesquisa" onClick="javascript: novaPesquisa();" /></td>
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
    <tr">
      
      <th class="grid"><center></center></th>
      <th class="grid">Loja</th>
      <th class="grid"><center>Descrição do Produto</center></th>
      <th class="grid">Tipo do Produto</th>
      <th class="grid">Status</th>
      <th class="grid">Estoque</th>
      
    </tr>
<%
int gridSize = 20;
String rowNumStr = request.getParameter("rowNum");
int rowNum = (rowNumStr == null ? 0: Integer.parseInt(rowNumStr));
if (rowNum < 0) rowNum = 0;
boolean hasNext = false;
int rowCount = list.size();
int rowLast = 0;
if (rowCount > 0) {
  if (rowCount > gridSize) {
    rowLast = rowNum+gridSize+100; 
    if (rowLast >= rowCount && rowCount > 0) rowLast = rowCount;
    if (rowNum > rowLast) rowNum = 0;
    list = list.subList(rowNum, rowLast);
  }
  hasNext = true;
}


//Utiliza o ResultSet para trazer os registros do banco de dados
for ( Iterator it = list.iterator(); hasNext && cont < gridSize; hasNext = it.hasNext()) {
	prod = (Produto) it.next();
	daoEstoque = new EstoqueDAO(conn);
	listarEstoque = daoEstoque.procurarEstoquePreco(prod.getIdProduto(), idLoja);
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
      <td class = "grid" width="5%"><center><%=rowNum+cont%></center></td>
      <td class = "grid" width="10%"><center><%=lojaEstoque.getApelido()%></center></td>
      <td class = "grid"><center><a target="_blank" href="../cadastros/formProduto.jsp?acao=atu&idProduto=<%=prod.getIdProduto()%>"><%=prod.getDsProduto() %></a> </center></td>
      <td class = "grid" width="5%"><center><%=prod.getTipoProduto()%></center></td>
      <td class = "grid" width="5%"><center><%=prod.getStatus()%></center></td>
      
      <%if (estoque.getQtEstoque()<=estoque.getQtMinimo()){ %>
      	 <td class = "grid" width="5%" title="ESTOQUE ESTÁ COM A QUANTIDADE MÍNIMA NO LIMITE OU ULTRAPASSOU."><center><font color="red"><b><i><%=Utilitaria.formatarNumero(estoque.getQtEstoque(),2)%></i></b></font></center></td>
      <%}else{ %>
      	 <td class = "grid" width="5%" ><center><%=Utilitaria.formatarNumero(estoque.getQtEstoque(),2)%></center></td>
      <%} %>
      
  </tr>    
<%
		}
	}
	}
}

%>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
  <br>
	<input class="button"type="button" value="Imprimir" onclick="javascript:window.print()">
  </tr>
</table>
</form>
<%  if (rowNum != 0 || hasNext) { %>
        <center>
<%      if (rowNum != 0) { %>
<a class="link" href="consultarProdutoEstoquePrecoAdministrador.jsp?rowNum=<%=0%>&nomeProduto=<%=nomeProduto%>&status=<%=status%>&idLoja=<%=idLoja%>">Primeira</a>&nbsp&nbsp
|&nbsp&nbsp<a class="link" href="consultarProdutoEstoquePrecoAdministrador.jsp?rowNum=<%=rowNum-gridSize%>&nomeProduto=<%=nomeProduto%>&status=<%=status%>&idLoja=<%=idLoja%>">< Anterior</a>&nbsp&nbsp
<%      } else { %>
Primeira&nbsp&nbsp|&nbsp&nbsp< Anterior&nbsp
<%      } %>
<%      if (hasNext) { %>
|&nbsp&nbsp<a class="link" href="consultarProdutoEstoquePrecoAdministrador.jsp?rowNum=<%=rowNum+gridSize%>&nomeProduto=<%=nomeProduto%>&status=<%=status%>&idLoja=<%=idLoja%>">Próxima ></a>&nbsp&nbsp
|&nbsp&nbsp<a class="link" href="consultarProdutoEstoquePrecoAdministrador.jsp?rowNum=<%=rowCount-gridSize%>&nomeProduto=<%=nomeProduto%>&status=<%=status%>&idLoja=<%=idLoja%>">Última</a>
<%      } else { %>
|&nbsp&nbsp Próxima >&nbsp&nbsp|&nbsp&nbspÚltima
<%      } %>
        </center>
<%  } %>
<%@include file="../fimConexao.jsp"%>