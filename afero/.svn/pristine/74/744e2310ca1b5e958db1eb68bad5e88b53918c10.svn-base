<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.CondPagto" %>
<%@ page import="afero.persistence.CondPagtoDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function confirmaExcluir(cont, id) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarCondPagto.jsp?acao=exc&cdCondPagto=' + id;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.dsPesquisaCond.value = '';
  document.all.status.value = ''; //não está limpando
  document.forms[0].submit();
}  
</script>
<%
CondPagtoDAO dao;
CondPagtoDAO daoExclusao;

String mensagem = request.getParameter("mensagem");
if(mensagem == null)mensagem = "";
String acao = request.getParameter("acao");
if (acao == null) acao = "listar";
String cdCondPagto = "";
String dsCondPagto = "";
String status = "A";
String clausula = "";

String dsPesquisaCond = request.getParameter("dsPesquisaCond");

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
	
	cdCondPagto = request.getParameter("cdCondPagto");
	dsCondPagto = request.getParameter("dsCondPagto");
	status = request.getParameter("status");
	
	if(cdCondPagto == null) cdCondPagto = "0";
	if(dsCondPagto == null) dsCondPagto = "";
	if(status == null) status = "A";

	CondPagto tipoAtendimento = new CondPagto();
  
	try {
	  if (!acao.equalsIgnoreCase("inc")){
		  tipoAtendimento.setCdCondPagto(Integer.parseInt(cdCondPagto));
	  }
	  
	  	tipoAtendimento.setDsCondPagto(dsCondPagto);
	  	tipoAtendimento.setStatus(status);
      
      if (!acao.equalsIgnoreCase("exc")){
    	  tipoAtendimento.setCdCondPagto(Integer.parseInt(cdCondPagto));
      }      
      
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}

	dao = new CondPagtoDAO(conn);
	daoExclusao = new CondPagtoDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {  
	  //inclui no banco de dados
  	dao.incluir(tipoAtendimento);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
    	 dao.atualiza(tipoAtendimento);
  }else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
		  dao.excluir(tipoAtendimento);
  }
}else {
 if (!acao.equalsIgnoreCase("voltar")) {
	 dsPesquisaCond = request.getParameter("dsPesquisaCond");
    status = request.getParameter("status");
    if (status == null) status = "";
  }
 if(dsPesquisaCond != null){
	 clausula = " WHERE dsCondPagto LIKE '"+dsPesquisaCond+"%'";
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
dao = new CondPagtoDAO(conn);
clausula = clausula +" ORDER BY dsCondPagto ";
list = dao.listarCondPagto(clausula);
int cont = 0;
%>
<h1 class="cabecalho_pagina">Condição de Pagamento</h1>

|<a class="button" href="formCondPagto.jsp?acao=inc">Novo Cadastro</a>|<br>

<body onload="document.forms[0].elements[0].focus();" >
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<form action="listarCondPagto.jsp">
<table colspan="2">
	<tr>
		<th class='label'>Condições de Pagamento</th>
		<td><input type="text" name="dsPesquisaCond" <%if (dsPesquisaCond != null) { %>value="<%=dsPesquisaCond %>"<% }%>  size="40" maxlength="40"></td>
		<td><input class="button" type="button" value="Localizar" onClick="javascript: localizar();" /></td>
		<td><input class="button" type="button" value="Nova pesquisa" onClick="javascript: novaPesquisa();" /></td>
	</tr>
	<tr>
		<th class="label">Status</th>
		<td class="label_radio">
			<input type="radio" class="radio" name="status" value="" <%= (status.equals("")? "checked": "") %>>Todos
			<input type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Ativo
			<input type="radio" class="radio" name="status" value="I" <%= (status.equals("I")? "checked": "") %>>Inativo
		</td>
	</tr>
</table>
<hr>

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
	<tr>
		<th class="grid">&nbsp;</th>
		<th class="grid"><center>Descrição</center></th>
		<th class="grid">Status</th>
		<%--<th class="grid">Excluir</th> --%>
	</tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
String msgStatus = "";
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	CondPagto tipoAtendimento = (CondPagto) it.next();
	if(tipoAtendimento.getStatus().equalsIgnoreCase("I")){
		msgStatus = "INATIVO";
	}else{
		msgStatus = "ATIVO";
	}
    cont++;

%>
    <tr>
    	<td class = "grid" width="2%"><center><%=cont%></center></td>
    	<td class = "grid"><center><a href="formCondPagto.jsp?acao=atu&cdCondPagto=<%=tipoAtendimento.getCdCondPagto() %>"><%=tipoAtendimento.getDsCondPagto()%> </a></center></td>
    	<td class = "grid" width="5%"><center><%=msgStatus%></center></td>
    	<%--<td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=tipoAtendimento.getCdCondPagto() %>);"><img border = "0" src="../images/delete.gif"></a></center></td> --%>
    </tr>
<%
}
%>   
</table>
</form>
<p align="right">|<a class="button" href="formCondPagto.jsp?acao=inc">Novo Cadastro</a>|