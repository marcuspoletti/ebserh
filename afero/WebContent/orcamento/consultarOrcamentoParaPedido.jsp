<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.Orcamento" %>
<%@ page import="afero.model.Entidade" %>
<%@ page import="afero.persistence.OrcamentoDAO" %>
<%@ page import="afero.persistence.EntidadeDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Date" %>
<%@ page import="afero.util.ConverteDate" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>


function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.nomeEntidade.value = '';
  document.all.status.value = ''; //não está limpando
  document.all.numOrcamento.value = '';
  document.forms[0].submit();
}  
</script>

<%
String idLojaUsuario = (String)session.getAttribute("idLoja");
OrcamentoDAO dao = null;
String status = request.getParameter("status");
if(status == null)status = "R";
String nomeEntidade = request.getParameter("nomeEntidade");
String acao = request.getParameter("acao");
String clausula = "";
int numOrcamento;
if(request.getParameter("numOrcamento") == null || request.getParameter("numOrcamento") == ""){
	numOrcamento = 0;
}else{
	numOrcamento = Integer.parseInt(request.getParameter("numOrcamento"));
}
if(acao == null)acao="listar";
 if (!acao.equalsIgnoreCase("voltar")) {
	  nomeEntidade = request.getParameter("nomeEntidade");
	  if(nomeEntidade == null)nomeEntidade="";
      status = request.getParameter("status");
      if (status == null) status = "NA";
  }

  if (nomeEntidade!= null) {
    clausula = " WHERE e.nome LIKE '"+nomeEntidade+"%'";
  } 
  if (!status.isEmpty()) {
    if (clausula.isEmpty()) {
      clausula = " WHERE o.status='"+status+"'";
    } else {
      clausula = clausula+" AND o.status='"+status+"'";
    }
  }
  if(numOrcamento!= 0){ 
		 clausula = clausula+" AND o.idOrcamento = "+numOrcamento;
	 }
  
  clausula = clausula +" AND o.idLoja = "+Integer.parseInt(idLojaUsuario);

//seleciona todos os registros do banco de dados
List list;
dao = new OrcamentoDAO(conn);
clausula = clausula+" ORDER BY o.dtOrc desc";
list = dao.listarOrcamento(clausula);
%>
<h1 class="cabecalho_pagina">Consulta de Orçamento</h1>
<body onload="document.forms[0].elements[0].focus();" >
<form method="post" action="consultarOrcamentoParaPedido.jsp">
<table colspan="2">
  <tr>
    <th class='label'>Número do Orc.</th>
    <td><input type="text" name="numOrcamento" <%if (numOrcamento != 0) { %>value="<%=numOrcamento %>"<% }%>  size="20" maxlength="20"></td>
  </tr>
  <tr>
    <th class='label'>Nome do Cliente</th>
    <td><input type="text" name="nomeEntidade" <%if (nomeEntidade != null) { %>value="<%=nomeEntidade %>"<% }%>  size="40" maxlength="40"></td>
    <td><input class="button" type="button" value="Localizar" onClick="javascript: localizar();" /></td>
    <td><input class="button" type="button" value="Nova pesquisa" onClick="javascript: novaPesquisa();" /></td>
  </tr>
  <tr>
    <th class="label">Status</th>
    <td class="label_radio">
      <input  type="radio" class="radio" name="status" value="" <%= (status.equals("")? "checked": "") %>>Todos
      <input  type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Aprovado
      <input type="radio" class="radio" name="status" value="R" <%= (status.equals("R")? "checked": "") %>>Recusado<br>
      <input type="radio" class="radio" name="status" value="NA" <%= (status.equals("NA")? "checked": "") %>>Não Avaliado</td>
  </tr>
</table>
<hr>

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr">
      <th class="grid">&nbsp;</th>
      <th class="grid"><center>Número do Orcamento</center></th>
      <th class="grid"><center>Nome do Cliente</center></th>
      <th class="grid">Status</th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
int cont = 0;
int gridSize = 20;
String rowNumStr = request.getParameter("rowNum");
int rowNum = (rowNumStr == null ? 0: Integer.parseInt(rowNumStr));
if (rowNum < 0) rowNum = 0;
boolean hasNext = false;
int rowCount = list.size();
int rowLast = 0;
if (rowCount > 0) {
  if (rowCount > gridSize) {
    rowLast = rowNum+gridSize; 
    if (rowLast >= rowCount && rowCount > 0) rowLast = rowCount;
    if (rowNum > rowLast) rowNum = 0;
    list = list.subList(rowNum, rowLast);
  }
  hasNext = true;
}
String dsStatus="";
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	Orcamento orc = (Orcamento) it.next();
	Entidade entidade = new Entidade();
	EntidadeDAO daoEntidade = new EntidadeDAO(conn);
	entidade = daoEntidade.procurarEntidade(orc.getCdEntidade());
	cont++;
    if(orc.getStatus().equalsIgnoreCase("A")){
    	dsStatus = "Aprovado";
    	
    }else if (orc.getStatus().equalsIgnoreCase("R")){
    	dsStatus = "Recusado";
    	
    }else if(orc.getStatus().equalsIgnoreCase("NA")){
    	dsStatus = "Não Avaliado";
    }
%>
   <tr>
      <td class = "grid" width="2%"><center><%=rowNum+cont%></center></td>
      <td class = "grid" width="5%"><center><a target="_blank" href="orcamentoParaPedido.jsp?idOrcamento=<%=orc.getIdOrcamento()%>"><%=orc.getIdOrcamento()%></a></center></td>
      <td class = "grid" width="30%"><center><%=entidade.getNome()%></center></td>
      <td class = "grid" width="4%"><font color="red"><center><%=dsStatus%></center></font></td>
  	</tr>
<%
}
%>      
</table>
</form>
<br>
<%  if (rowNum != 0 || hasNext) { %>
        <center>
<%      if (rowNum != 0) { %>
<a class="link" href="consultarOrcamentoParaPedido.jsp?rowNum=<%=0%>&nomeEntidade=<%=nomeEntidade%>&status=<%=status%>">Primeira</a>&nbsp&nbsp
|&nbsp&nbsp<a class="link" href="consultarOrcamentoParaPedido.jsp?rowNum=<%=rowNum-gridSize%>&nomeEntidade=<%=nomeEntidade%>&status=<%=status%>">< Anterior</a>&nbsp&nbsp
<%      } else { %>
Primeira&nbsp&nbsp|&nbsp&nbsp< Anterior&nbsp
<%      } %>
<%      if (hasNext) { %>
|&nbsp&nbsp<a class="link" href="consultarOrcamentoParaPedido.jsp?rowNum=<%=rowNum+gridSize%>&nomeEntidade=<%=nomeEntidade%>&status=<%=status%>">Próxima ></a>&nbsp&nbsp
|&nbsp&nbsp<a class="link" href="consultarOrcamentoParaPedido.jsp?rowNum=<%=rowCount-gridSize%>&nomeEntidade=<%=nomeEntidade%>&status=<%=status%>">Última</a>
<%      } else { %>
|&nbsp&nbsp Próxima >&nbsp&nbsp|&nbsp&nbspÚltima
<%      } %>
        </center>
<%  } %>
<%@include file="../fimConexao.jsp"%>