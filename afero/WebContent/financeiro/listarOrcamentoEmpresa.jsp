<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.OrcamentoEmpresa" %>
<%@ page import="afero.persistence.OrcamentoEmpresaDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Date" %>
<%@ page import="afero.util.ConverteDate" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function confirmaExcluir(cont, id) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarOrcamentoEmpresa.jsp?acao=exc&idOrcamentoEmpresa=' + id;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.nmOrcamentoEmpresa.value = '';
  document.all.status.value = ''; //não está limpando
  document.forms[0].submit();
}  
</script>

<%
OrcamentoEmpresaDAO dao;
OrcamentoEmpresaDAO daoExclusao;
ConverteDate conDate = new ConverteDate();
String mensagem = request.getParameter("mensagem");
if(mensagem == null)mensagem = "";
String acao = request.getParameter("acao");
if (acao == null) acao = "listar";
String nmOrcamentoEmpresa= "";
String status ="A";
String clausula = "";
String idOrcamentoEmpresa = "";


if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
	
	idOrcamentoEmpresa = request.getParameter("idOrcamentoEmpresa");
	nmOrcamentoEmpresa = request.getParameter("nmOrcamentoEmpresa");
  status =request.getParameter("status");
  if(idOrcamentoEmpresa == null)idOrcamentoEmpresa= "0";
  if(nmOrcamentoEmpresa == null)nmOrcamentoEmpresa = "";
  if(status == null)status = "A";
  OrcamentoEmpresa orcamentoEmpresa = new OrcamentoEmpresa();
  
	try {
	  if (!acao.equalsIgnoreCase("inc")){
		  orcamentoEmpresa.setIdOrcamentoEmpresa(Integer.parseInt(idOrcamentoEmpresa));
	  }
	  
	  orcamentoEmpresa.setNmOrcamentoEmpresa(nmOrcamentoEmpresa);
	  orcamentoEmpresa.setStatus(status);
      if (!acao.equalsIgnoreCase("exc")){
    	  orcamentoEmpresa.setIdOrcamentoEmpresa(Integer.parseInt(idOrcamentoEmpresa)); 
      }
      
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}


  dao = new OrcamentoEmpresaDAO(conn);
  daoExclusao = new OrcamentoEmpresaDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {  
	  //inclui no banco de dados
  	dao.incluir(orcamentoEmpresa);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
    	 dao.atualizar(orcamentoEmpresa);
  }else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  if(!daoExclusao.exclusaoIdOrcamentoEmpresa(Integer.parseInt(idOrcamentoEmpresa))){
		  dao.excluir(orcamentoEmpresa);
	  }else{
		  response.sendRedirect("listarOrcamentoEmpresa.jsp?mensagem=Exclusão Inválida! Item já possui lançamentos.&acao=listar");
	  }
	  
  }
} else {
 if (!acao.equalsIgnoreCase("voltar")) {
    nmOrcamentoEmpresa = request.getParameter("nmOrcamentoEmpresa");
    status = request.getParameter("status");
    if (status == null) status = "";
  }

  if (nmOrcamentoEmpresa!= null) {
    clausula = " WHERE nmOrcamentoEmpresa LIKE '"+nmOrcamentoEmpresa+"%'";
  } 
  if (!status.isEmpty()) {
    if (clausula.isEmpty()) {
      clausula = " WHERE status='"+status+"'";
    } else {
      clausula = clausula+" AND status='"+status+"'";
    }
  }
}

//seleciona todos os registros do banco de dados
List list;
dao = new OrcamentoEmpresaDAO(conn);
clausula = clausula+" ORDER BY nmOrcamentoEmpresa ";
list = dao.listarOrcamentoEmpresa(clausula);

int cont = 0;
%>
<h1 class="cabecalho_pagina">Cadastro de Orçamento da Empresa</h1>

|<a class="button" href="formOrcamentoEmpresa.jsp?acao=inc">Novo Cadastro</a>|<br>

<body onload="document.forms[0].elements[0].focus();" >
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<form action="listarOrcamentoEmpresa.jsp">
<table colspan="2">
  <tr>
    <th class='label'>Descrição Orçamento</th>
    <td><input type="text" name="nmOrcamentoEmpresa" <%if (nmOrcamentoEmpresa != null) { %>value="<%=nmOrcamentoEmpresa %>"<% }%>  size="40" maxlength="40"></td>
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
      <th class="grid">&nbsp;</th>
      <th class="grid"><center>Descrição do Orçamento</center></th>
      <th class="grid"><center>Painel do Orçamento</center></th>
      <th class="grid"><center>Itens do Orçamento</center></th>
      <th class="grid">Status</th>
      <th class="grid">Excluir</th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
String msgStatus = "";
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	OrcamentoEmpresa orcamentoEmpresa = (OrcamentoEmpresa) it.next();
	if(orcamentoEmpresa.getStatus().equals("I")){
		msgStatus = "INATIVO";
	}else{
		msgStatus = "ATIVO";
	}
    cont++;

%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid"><center><a href="formOrcamentoEmpresa.jsp?acao=atu&idOrcamentoEmpresa=<%=orcamentoEmpresa.getIdOrcamentoEmpresa()%>"><%=orcamentoEmpresa.getNmOrcamentoEmpresa()%> </a></center></td>
      <td class = "grid" width="5%"><center><a target="_blank" href="formOrcamento.jsp?idOrcamentoEmpresa=<%=orcamentoEmpresa.getIdOrcamentoEmpresa()%>"><img border = "0" src="../images/pesquisa.gif"></a></center></td>
       <td class = "grid" width="5%"><center><a target="_blank" href="listarOrcamentoEmpresaItem.jsp?idOrcamentoEmpresa=<%=orcamentoEmpresa.getIdOrcamentoEmpresa()%>"><img border = "0" src="../images/edit.gif"></a></center></td>
      <td class = "grid" width="5%"><center><%=msgStatus%></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=orcamentoEmpresa.getIdOrcamentoEmpresa()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
  	</tr>
<%
}
%>   
</table>
</form>
<p align="right">|<a class="button" href="formOrcamentoEmpresa.jsp?acao=inc">Novo Cadastro</a>|