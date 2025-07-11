<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.PlanoConta" %>
<%@ page import="afero.persistence.PlanoContaDAO" %>
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
       location.href = 'listarPlanoConta.jsp?acao=exc&idPlanoConta=' + id;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.nmPlanoConta.value = '';
  document.all.status.value = ''; //não está limpando
  document.forms[0].submit();
}  
</script>

<%
PlanoContaDAO dao;
PlanoContaDAO daoExclusao;
ConverteDate conDate = new ConverteDate();
String mensagem = request.getParameter("mensagem");
if(mensagem == null)mensagem = "";
String acao = request.getParameter("acao");
if (acao == null) acao = "listar";
String nmPlanoConta = "";
String cdPlanoConta = "";
String status ="A";
String dc = "";
String clausula = "";
String idPlanoConta = "";
String idPlanoContaPai = "0";


if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
	
	idPlanoConta = request.getParameter("idPlanoConta");
	idPlanoContaPai = request.getParameter("idPlanoContaPai");
	nmPlanoConta = request.getParameter("nmPlanoConta");
  status = request.getParameter("status");
  dc = request.getParameter("dc");
  cdPlanoConta = request.getParameter("cdPlanoConta");
  
  if(idPlanoConta == null)idPlanoConta = "0";
  if(idPlanoContaPai == null)idPlanoContaPai = "0";
  if(nmPlanoConta == null)nmPlanoConta = "";
  if(status == null)status = "A";
  if(dc == null)dc ="C";
  if(cdPlanoConta == null)cdPlanoConta ="0";
  PlanoConta planoConta = new PlanoConta();
  
	try {
	  if (!acao.equalsIgnoreCase("inc")){
		  planoConta.setIdPlanoConta(Integer.parseInt(idPlanoConta));
	  }
	  
    planoConta.setIdPlanoContaPai(Integer.parseInt(idPlanoContaPai));
	  planoConta.setNmPlanoConta(nmPlanoConta);
    planoConta.setStatus(status);
    planoConta.setDc(dc);
    planoConta.setCdPlanoConta(cdPlanoConta);
    if (!acao.equalsIgnoreCase("exc")){
      planoConta.setIdPlanoConta(Integer.parseInt(idPlanoConta)); 
    }
      
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}


  dao = new PlanoContaDAO(conn);
  daoExclusao = new PlanoContaDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {  
	  //inclui no banco de dados
  	dao.incluir(planoConta);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
    	 dao.atualizar(planoConta);
  }else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  if(!daoExclusao.exclusaoIdPlanoConta(Integer.parseInt(idPlanoConta))){
		  dao.excluir(planoConta);
	  }else{
		  response.sendRedirect("listarPlanoConta.jsp?mensagem=Exclusão Inválida! Item já possui lançamentos.&acao=listar");
	  }
	  
  }
} else {
 if (!acao.equalsIgnoreCase("voltar")) {
    nmPlanoConta = request.getParameter("nmPlanoConta");
    status = request.getParameter("status");
    if (status == null) status = "";
  }

  if (nmPlanoConta!= null) {
    clausula = " WHERE nmPlanoConta LIKE '"+nmPlanoConta+"%'";
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
dao = new PlanoContaDAO(conn);
clausula = clausula+" ORDER BY cdPlanoConta ";
list = dao.listarPlanoConta(clausula);

int cont = 0;
%>
<h1 class="cabecalho_pagina">Cadastro de Plano de Conta</h1>

|<a class="button" href="formPlanoConta.jsp?acao=inc">Novo Cadastro</a>|<br>

<body onload="document.forms[0].elements[0].focus();" >
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<form action="listarPlanoConta.jsp">
<table colspan="2">
  <tr>
    <th class='label'>Descrição Plano Conta</th>
    <td><input type="text" name="nmPlanoConta" <%if (nmPlanoConta != null) { %>value="<%=nmPlanoConta %>"<% }%>  size="40" maxlength="40"></td>
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
      <th class="grid"><center>Código do Plano de Conta</center></th>
      <th class="grid"><center>Descrição do Plano de Conta</center></th>
      <th class="grid"><center>Sub-Plano de Conta de</center></th>
      <th class="grid">Status</th>
      <th class="grid">Excluir</th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
String msgStatus = "";
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	PlanoConta planoC = (PlanoConta) it.next();
	String nmPlanoContaPai = "";
	if (planoC.getIdPlanoContaPai()>0) {
		PlanoConta subplanoC = dao.procurarPlanoConta(planoC.getIdPlanoContaPai());
		nmPlanoContaPai = subplanoC.getNmPlanoConta();		
	}
	if(planoC.getStatus().equals("I")){
		msgStatus = "INATIVO";
	}else{
		msgStatus = "ATIVO";
	}
    cont++;

%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid"><center><%=planoC.getCdPlanoConta()%></center></td>
      <td class = "grid"><center><a href="formPlanoConta.jsp?acao=atu&idPlanoConta=<%=planoC.getIdPlanoConta()%>"><%=planoC.getNmPlanoConta()%> </a></center></td>
      <td class = "grid"><center><%=nmPlanoContaPai%></center></td>
      <td class = "grid" width="5%"><center><%=msgStatus%></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=planoC.getIdPlanoConta()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
  	</tr>
<%
}
%>   
</table>
</form>
<p align="right">|<a class="button" href="formPlanoConta.jsp?acao=inc">Novo Cadastro</a>|
