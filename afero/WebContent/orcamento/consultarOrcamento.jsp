<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.Orcamento" %>
<%@page import="afero.model.PedidoEntrada"%>
<%@ page import="afero.model.Entidade" %>
<%@ page import="afero.persistence.OrcamentoDAO" %>
<%@ page import="afero.persistence.EntidadeDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Date" %>
<%@ page import="afero.util.ConverteDate" %>
<%@ page import="afero.util.Utilitaria" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>


function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.idOrcamentoLocalizar.value='';
  document.all.nomeLocalizar.value = '';
  document.all.statusLocalizar.value = ''; //não está limpando
  document.forms[0].submit();
}  
</script>

<%
String idLojaUsuario = (String)session.getAttribute("idLoja");
OrcamentoDAO dao = null;
int idOrcamentoLocalizar;
if(request.getParameter("idOrcamentoLocalizar") == null || request.getParameter("idOrcamentoLocalizar") == ""){
	idOrcamentoLocalizar = 0;
}else{
	idOrcamentoLocalizar = Integer.parseInt(request.getParameter("idOrcamentoLocalizar"));
}
String nomeLocalizar = request.getParameter("nomeLocalizar");
if(nomeLocalizar == null) nomeLocalizar = "";
String statusLocalizar = request.getParameter("statusLocalizar");
if(statusLocalizar == null) statusLocalizar = "";
String acao = request.getParameter("acao");
if(acao == null) acao="listar";
String clausula = "";

if (nomeLocalizar!= null) {
  clausula = " WHERE e.nome LIKE '"+nomeLocalizar+"%'";
} 
if (!statusLocalizar.isEmpty()) {
  if (clausula.isEmpty()) {
    clausula = " WHERE o.status='"+statusLocalizar+"'";
  } else {
    clausula = clausula+" AND o.status='"+statusLocalizar+"'";
  }
}
if(idOrcamentoLocalizar!= 0){ 
  clausula = clausula+" AND o.idOrcamento = "+idOrcamentoLocalizar;
}
 
clausula = clausula +" AND o.idLoja = "+Integer.parseInt(idLojaUsuario);

//seleciona todos os registros do banco de dados
List list;
dao = new OrcamentoDAO(conn);
clausula = clausula+" ORDER BY o.dtOrc desc";
list = dao.listarOrcamento(clausula);

%>
<h1 class="cabecalho_pagina">Consulta de Orçamentos</h1>
<body onload="document.forms[0].elements[0].focus();" >
<form method="post" action="consultarOrcamento.jsp">
<table colspan="2">
  <tr>
    <th class='label'>Número do Orçamento</th>
    <td><input type="text" name="idOrcamentoLocalizar" <%if (idOrcamentoLocalizar != 0) { %>value="<%=idOrcamentoLocalizar %>"<% }%>  size="20" maxlength="20"></td>
  </tr>
  <tr>
    <th class='label'>Nome do Cliente</th>
    <td><input type="text" name="nomeLocalizar" <%if (nomeLocalizar != null) { %>value="<%=nomeLocalizar %>"<% }%>  size="40" maxlength="40" style="width: 350px"></td>
    <td><input class="button" type="button" value="Localizar" onClick="javascript: localizar();" /></td>
    <td><input class="button" type="button" value="Nova pesquisa" onClick="javascript: novaPesquisa();" /></td>
  </tr>
  <tr>
    <th class="label">Status</th>
    <td class="label_radio">
      <input type="radio" class="radio" name="statusLocalizar" value="" <%= (statusLocalizar.equals("")? "checked": "") %>>Todos
      <input type="radio" class="radio" name="statusLocalizar" value="A" <%= (statusLocalizar.equals("A")? "checked": "") %>>Aprovado
      <input type="radio" class="radio" name="statusLocalizar" value="R" <%= (statusLocalizar.equals("R")? "checked": "") %>>Recusado
      <input type="radio" class="radio" name="statusLocalizar" value="NA" <%= (statusLocalizar.equals("NA")? "checked": "") %>>Não Avaliado</td>
  </tr>
</table>
<hr>

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr">
      <th class="grid">&nbsp;</th>
      <th class="grid"><center>Núm. do Orçamento</center></th>
      <th class="grid"><center>Data do Orçamento</center></th>
      <th class="grid"><center>Nome do Cliente</center></th>
      <th class="grid"><center>Imprimir</center></th>
      <th class="grid"><center>Editar</center></th>
      <th class="grid"><center>Status</center></th>
    </tr>
<%
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
    rowLast = rowNum+gridSize+1; 
    if (rowLast >= rowCount && rowCount > 0) rowLast = rowCount;
    if (rowNum > rowLast) rowNum = 0;
    list = list.subList(rowNum, rowLast);
  }
  hasNext = true;
}

//Utiliza o ResultSet para trazer os registros do banco de dados
String dsStatus = "";
for ( Iterator it = list.iterator(); hasNext && cont < gridSize; hasNext = it.hasNext()) {
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
      <td class = "grid" width="2%"><center><a target="_blank" href="exibirOrcamento.jsp?idOrcamento=<%=orc.getIdOrcamento()%>"><%=orc.getIdOrcamento()%></a></center></td>
      <td class = "grid" width="5%"><center><%=ConverteDate.dateToString(orc.getDtOrc())%></center></td>
      <td class = "grid" width="30%"><center><%=entidade.getNome()%></center></td>
      <td class = "grid" width="2%"><center><a target="_blank" href="impOrcamento.jsp?idOrcamento=<%=orc.getIdOrcamento()%>"><img border = "0" src="../images/imprimir.gif"></a></center></td>
      <%if(orc.getStatus().equalsIgnoreCase("R") || orc.getStatus().equalsIgnoreCase("NA")){%>
      	 <td class = "grid" width="2%"><a target="_blank" href="editarFormOrcamento.jsp?idOrcamento=<%=orc.getIdOrcamento()%>&acao=<%="atu"%>"><img border="0"src="../images/edit.gif"></a></img></td>
      <%}else{ %>
         <td class = "grid" width="2%"><center>-</center></td>
      <%} %>
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
<a class="link" href="consultarOrcamento.jsp?rowNum=<%=0%>&nomeLocalizar=<%=nomeLocalizar%>&statusLocalizar=<%=statusLocalizar%>">Primeira</a>&nbsp&nbsp
|&nbsp&nbsp<a class="link" href="consultarOrcamento.jsp?rowNum=<%=rowNum-gridSize%>&nomeLocalizar=<%=nomeLocalizar%>&statusLocalizar=<%=statusLocalizar%>">< Anterior</a>&nbsp&nbsp
<%      } else { %>
Primeira&nbsp&nbsp|&nbsp&nbsp< Anterior&nbsp
<%      } %>
<%      if (hasNext) { %>
|&nbsp&nbsp<a class="link" href="consultarOrcamento.jsp?rowNum=<%=rowNum+gridSize%>&nomeLocalizar=<%=nomeLocalizar%>&statusLocalizar=<%=statusLocalizar%>">Próxima ></a>&nbsp&nbsp
|&nbsp&nbsp<a class="link" href="consultarOrcamento.jsp?rowNum=<%=rowCount-gridSize%>&nomeLocalizar=<%=nomeLocalizar%>&statusLocalizar=<%=statusLocalizar%>">Última</a>
<%      } else { %>
|&nbsp&nbsp Próxima >&nbsp&nbsp|&nbsp&nbspÚltima
<%      } %>
        </center>
<%  } %>
<%@include file="../fimConexao.jsp"%>