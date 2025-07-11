<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.Produto" %>
<%@ page import="afero.persistence.ProdutoDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@page import="afero.util.Utilitaria"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/>"</script>

<script>

function localizar() {
  
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.nomeProduto.value = '';
  document.all.status.value = ''; //não está limpando
  document.forms[0].submit();
} 
function salvar() {
  document.all.acao.value='atu';
  document.forms[0].submit();	
}

function cancelar() {
  document.forms[0].action="consultarProduto.jsp";
  document.forms[0].submit();
}

function recarregar(acao) {
  document.forms[0].action='consultarProduto.jsp?acao='+acao;
  document.forms[0].submit();
}
</script>

<%
ProdutoDAO dao;
Produto prod = null;
String acao = request.getParameter("acao");
if(acao == null) acao = "listar";
String idDivisao = request.getParameter("idDivisao");
if(idDivisao == null)idDivisao = "0";
String idMedicamento = request.getParameter("idMedicamento");
if (idMedicamento == null) idMedicamento = "0";
String idGrupoMedicamento = request.getParameter("idGrupoMedicamento");
if (idGrupoMedicamento == null) idGrupoMedicamento = "0";
String nmMedicamento = request.getParameter("nmMedicamento");
if(nmMedicamento == null) nmMedicamento = "";

String nomeProduto = request.getParameter("nomeProduto");
if(nomeProduto == null) nomeProduto = "";
String status = request.getParameter("status");
if(status == null) status = "A";
String clausula = "";
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

if(!idDivisao.equalsIgnoreCase("0")){
	clausula = clausula+" AND idDivisao= "+Integer.parseInt(idDivisao);
}

clausula = clausula+" ORDER BY dsProduto ";

int cont = 0;

//seleciona todos os registros do banco de dados
List list = null;
dao = new ProdutoDAO(conn);
list = dao.listarProduto(clausula);
%>

<h1 class="cabecalho_pagina">Consulta de Produtos</h1>

<hr>

<body onload="document.forms[0].elements[0].focus();" >
<form action="consultarProduto.jsp">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="cont" value="<%=cont%>"/>
<input type="hidden" name="idMedicamento" value="<%=idMedicamento%>">
<input type="hidden" name="idGrupoMedicamento" value="<%=idGrupoMedicamento%>">
<table colspan="2">
<tr>
      <th class="label">Divisão*</th>
      <td><select name="idDivisao" onchange="recarregar('<%=acao%>');" required="true">
          <option value='0'>Todos...</option>
          <%@include file="../WEB-INF/jspf/combo/comboDivisao.jspf"%></select>
          <script>comboSelect(document.forms[0].idDivisao, '<%= idDivisao %>');</script>
      </td>
      </tr>
  <tr>
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
    <td><input class="button" type="button" value="Localizar" onClick="javascript: localizar();" /></td>
    <td><input class="button" type="button" value="Nova pesquisa" onClick="javascript: novaPesquisa();" /></td>
  </tr>
</table>
<hr>

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr>     
      <th class="grid"><center></center></th>
      <th class="grid"><center>Descrição do Produto</center></th>
      <th class="grid">Tipo do Produto</th>
      <th class="grid">Status</th>
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
	cont++;
	String param = "acao="+acao+
		"&idMedicamento="+idMedicamento+"&idGrupoMedicamento="+idGrupoMedicamento+
		"&nmMedicamento="+nmMedicamento+"&idProduto="+prod.getIdProduto()+"&idDivisao="+prod.getIdDivisao();
%>
    <tr>
      <td class = "grid" width="5%"><center><%=rowNum+cont%></center></td>
      <td class = "grid"><center><a class="link" target="principal" href="../pet/formMedicamento.jsp?<%=param%>"><%=prod.getDsProduto() %></a> </center></td>
      <td class = "grid" width="5%"><center><%=prod.getTipoProduto()%></center></td>
      <td class = "grid" width="5%"><center><%=prod.getStatus()%></center></td>
  </tr>
  
<%
}
%>   
      
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
</table>
</form>
<%  if (rowNum != 0 || hasNext) { %>
        <center>
<%      if (rowNum != 0) { %>
<a class="link" href="consultarProduto.jsp?rowNum=<%=0%>&nomeProduto=<%=nomeProduto%>&status=<%=status%>">Primeira</a>&nbsp&nbsp
|&nbsp&nbsp<a class="link" href="consultarProduto.jsp?rowNum=<%=rowNum-gridSize%>&nomeProduto=<%=nomeProduto%>&status=<%=status%>"> Anterior</a>&nbsp&nbsp
<%      } else { %>
Primeira&nbsp&nbsp|&nbsp&nbsp< Anterior&nbsp
<%      } %>
<%      if (hasNext) { %>
|&nbsp&nbsp<a class="link" href="consultarProduto.jsp?rowNum=<%=rowNum+gridSize%>&nomeProduto=<%=nomeProduto%>&status=<%=status%>">Próxima ></a>&nbsp&nbsp
|&nbsp&nbsp<a class="link" href="consultarProduto.jsp?rowNum=<%=rowCount-gridSize%>&nomeProduto=<%=nomeProduto%>&status=<%=status%>">Última</a>
<%      } else { %>
|&nbsp&nbsp Próxima >&nbsp&nbsp|&nbsp&nbspÚltima
<%      } %>
        </center>
<%  } %>
</body>
<%@include file="../fimConexao.jsp"%>