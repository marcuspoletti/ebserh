<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.Produto" %>
<%@ page import="afero.model.Estoque" %>
<%@ page import="afero.model.Divisao" %>
<%@ page import="afero.persistence.ProdutoDAO" %>
<%@ page import="afero.persistence.EstoqueDAO" %>
<%@ page import="afero.persistence.DivisaoDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Date" %>
<%@ page import="afero.util.ConverteDate" %>
<%@page import="afero.util.Utilitaria"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/>"</script>

<script>

function localizar() {
  document.forms[0].action="formEstoque.jsp";
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.forms[0].action="formEstoque.jsp";
  document.all.nomeProduto.value = '';
  document.all.status.value = ''; //não está limpando
  document.forms[0].submit();
} 
function salvar() {
   if(document.all.idLoja.value == '0') {
    window.alert("O campo Loja é obrigatório.");
    document.all.idLoja.focus();
   } else {
     document.forms[0].submit();
   }
  	
}

function recarregar(acao) {
  document.forms[0].action='formEstoque.jsp?acao='+acao;
  document.forms[0].submit();
}

function cancelar() {
  document.forms[0].action="formEstoque.jsp";
  document.forms[0].submit();
}

function voltar() {
    document.forms[0].action = 'listarEstoque.jsp?acao=voltar'
	document.forms[0].submit(); 
}
</script>

<%
ProdutoDAO dao; 
Produto prod = null;
String nomeProduto = request.getParameter("nomeProduto");
if (nomeProduto == null) nomeProduto = "";
String status = request.getParameter("status");
if (status == null) status = "A";
String acao = request.getParameter("acao");
String mensagem = request.getParameter("mensagem");
if (mensagem == null) mensagem = null;
if (acao == null) acao="inc";
String clausula = "";
int cont = 0;
String cdLoja = request.getParameter("idLoja");
int idLoja = 0;
if (cdLoja == null) {
	idLoja = 0;
} else {
	idLoja = Integer.parseInt(cdLoja);
}

String qtEstoque = "0";
String qtMinima = "0";
String qtMaxima = "0";
String idEstoque = "";

if (!acao.equalsIgnoreCase("voltar")) {
  nomeProduto = request.getParameter("nomeProduto");
  status = request.getParameter("status");
  if (status == null) status = "A";    
}

//if (idLoja != 0) {
//  clausula = " WHERE idLoja = "+idLoja;
//}
if (nomeProduto!= null) {
  if (clausula.isEmpty()) {
    clausula = " WHERE dsProduto LIKE '"+nomeProduto+"%'";
  } else {
    clausula = clausula+" AND dsProduto LIKE '"+nomeProduto+"%'";
  }
} 
if (!status.isEmpty()) {
  if (clausula.isEmpty()) {
    clausula = " WHERE status='"+status+"'";
  } else {
    clausula = clausula+" AND status='"+status+"'";
  }
}
List list;
  	
dao = new ProdutoDAO(conn);
clausula = clausula+" ORDER BY dsProduto ";
list = dao.listarProduto(clausula);

%>

<h1 class="cabecalho_pagina">Cadastro de Estoque</h1>

<body onload="document.forms[0].elements[0].focus();" >
<hr><% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<form action="listarEstoque.jsp" method="post">

<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="cont" value="<%=cont%>"/>
<table colspan="2">
  <tr>
      <th class="label">Loja</th>
      <td><select id="idLoja"name="idLoja" onchange="recarregar('<%=acao%>');" >
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
    <th class="grid">&nbsp;</th>
    <th class="grid"><center>Selecionar</center></th>
    <th class="grid"><center>Descrição do Produto</center></th>
    <th class="grid">Tipo do Produto</th>
    <th class="grid">Status</th>
    <th class="grid">Quant. em Estoque</th>
    <th class="grid">Quant. Mínima</th>
    <th class="grid">Quant.Maxima</th>
  </tr>
<%
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
Estoque estoqueList  = null;
for ( Iterator it = list.iterator(); hasNext && cont < gridSize; hasNext = it.hasNext()) {
  prod = (Produto) it.next();
	if (idLoja != 0) {
		EstoqueDAO daoEstoqueListar = new EstoqueDAO(conn);
		estoqueList = daoEstoqueListar.procurarEstoqueLojaProduto(idLoja, prod.getIdProduto());
		if (estoqueList != null) {
		  qtEstoque = Utilitaria.formatarNumero(estoqueList.getQtEstoque(),2);
			qtMinima = Utilitaria.formatarNumero(estoqueList.getQtMinimo(), 2);
			qtMaxima = Utilitaria.formatarNumero(estoqueList.getQtMaximo(), 2);
		} else {
			qtEstoque = "0";
			qtMinima = "0";
			qtMaxima = "0";
		}
	} else {
		qtEstoque = "0";
		qtMinima = "0";
		qtMaxima = "0";
	}
	
	cont++;

%>
  <tr>
    <td class = "grid" width="2%"><center><%=rowNum+cont%></center></td>
    <td class = "grid" width="5%"><input type="checkbox" name="idProduto_<%=prod.getIdProduto()%>" value="<%=prod.getIdProduto()%>"></td>
    <td class = "grid"><center><a target="_blank" href="formProduto.jsp?acao=atu&idProduto=<%=prod.getIdProduto()%>"><%=prod.getNmProduto()%> / <%=prod.getDsProduto() %></a> </center></td>
    <td class = "grid" width="5%"><center><%=prod.getTipoProduto()%></center></td>
    <td class = "grid" width="5%"><center><%=prod.getStatus()%></center></td>
    <td class="grid" width="5%"><input disabled type="text"  name="qtEstoque_<%=prod.getIdProduto()%>" value="<%=qtEstoque%>" onkeyup="FormataValor(this,event)" size="10" maxlength="10"></td>
    <td class="grid" width="5%"><input type="text"  name="qtMinima_<%=prod.getIdProduto()%>" value="<%=qtMinima%>" onkeyup="FormataValor(this,event)" size="10" maxlength="10"></td>
    <td class="grid" width="5%"><input type="text"  name="qtMaxima_<%=prod.getIdProduto()%>" value="<%=qtMaxima%>" onkeyup="FormataValor(this,event)" size="10" maxlength="10"></td>
    <input type="hidden" name="idProduto" value="<%=prod.getIdProduto()%>"/>   
  </tr>
<%
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
<a class="link" href="formEstoque.jsp?rowNum=<%=0%>&idLoja=<%=idLoja%>&nomeProduto=<%=nomeProduto%>&status=<%=status%>">Primeira</a>&nbsp&nbsp
|&nbsp&nbsp<a class="link" href="formEstoque.jsp?rowNum=<%=rowNum-gridSize%>&idLoja=<%=idLoja%>&nomeProduto=<%=nomeProduto%>&status=<%=status%>">< Anterior</a>&nbsp&nbsp
<%      } else { %>
Primeira&nbsp&nbsp|&nbsp&nbsp< Anterior&nbsp
<%      } %>
<%      if (hasNext) { %>
|&nbsp&nbsp<a class="link" href="formEstoque.jsp?rowNum=<%=rowNum+gridSize%>&idLoja=<%=idLoja%>&nomeProduto=<%=nomeProduto%>&status=<%=status%>">Próxima ></a>&nbsp&nbsp
|&nbsp&nbsp<a class="link" href="formEstoque.jsp?rowNum=<%=rowCount-gridSize%>&idLoja=<%=idLoja%>&nomeProduto=<%=nomeProduto%>&status=<%=status%>">Última</a>
<%      } else { %>
|&nbsp&nbsp Próxima >&nbsp&nbsp|&nbsp&nbspÚltima
<%      } %>
        </center>
<%  } %>
<%@include file="../fimConexao.jsp"%>