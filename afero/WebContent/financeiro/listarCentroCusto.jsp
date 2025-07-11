<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.CentroCusto" %>
<%@ page import="afero.persistence.CentroCustoDAO" %>
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
       location.href = 'listarCentroCusto.jsp?acao=exc&idCentroCusto=' + id;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.nmCentroCusto.value = '';
  document.all.status.value = ''; //não está limpando
  document.forms[0].submit();
}  
</script>

<%
CentroCustoDAO dao;
CentroCustoDAO daoExclusao;
ConverteDate conDate = new ConverteDate();
String mensagem = request.getParameter("mensagem");
if(mensagem == null)mensagem = "";
String acao = request.getParameter("acao");
if (acao == null) acao = "listar";
String nmCentroCusto = "";
String cdCentroCusto = "";
String pessoaResponsavel = "";
String nrTelefone = "";
String status ="A";
String clausula = "";
String idCentroCusto = "";
String idCentroCustoPai = "0";


if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
	
	idCentroCusto = request.getParameter("idCentroCusto");
	idCentroCustoPai = request.getParameter("idCentroCustoPai");
	nmCentroCusto = request.getParameter("nmCentroCusto");
  status = request.getParameter("status");
  cdCentroCusto = request.getParameter("cdCentroCusto");
  pessoaResponsavel= request.getParameter("pessoaResponsavel");
  nrTelefone = request.getParameter("nrTelefone"); 
  
  if(idCentroCusto == null)idCentroCusto = "0";
  if(idCentroCustoPai == null)idCentroCustoPai = "0";
  if(nmCentroCusto == null)nmCentroCusto = "";
  if(status == null)status = "A";
  if(cdCentroCusto == null)cdCentroCusto ="0";
  if(pessoaResponsavel == null)pessoaResponsavel="";
  if(nrTelefone == null)nrTelefone = "";
  CentroCusto centroCusto = new CentroCusto();
  
	try {
	  if (!acao.equalsIgnoreCase("inc")){
		  centroCusto.setIdCentroCusto(Integer.parseInt(idCentroCusto));
	  }
	  
    centroCusto.setIdCentroCustoPai(Integer.parseInt(idCentroCustoPai));
	  centroCusto.setNmCentroCusto(nmCentroCusto);
    centroCusto.setStatus(status);
    centroCusto.setCdCentroCusto(cdCentroCusto);
    centroCusto.setPessoaResponsavel(pessoaResponsavel);
    centroCusto.setNroTelefone(nrTelefone);
    if (!acao.equalsIgnoreCase("exc")){
      centroCusto.setIdCentroCusto(Integer.parseInt(idCentroCusto)); 
    }
      
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}


  dao = new CentroCustoDAO(conn);
  daoExclusao = new CentroCustoDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {  
	  //inclui no banco de dados
  	dao.incluir(centroCusto);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
    	 dao.atualizar(centroCusto);
  }else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  if(!daoExclusao.exclusaoIdCentroCusto(Integer.parseInt(idCentroCusto))){
		  dao.excluir(centroCusto);
	  }else{
		  response.sendRedirect("listarCentroCusto.jsp?mensagem=Exclusão Inválida! Item já possui lançamentos.&acao=listar");
	  }
	  
  }
} else {
 if (!acao.equalsIgnoreCase("voltar")) {
    nmCentroCusto = request.getParameter("nmCentroCusto");
    status = request.getParameter("status");
    if (status == null) status = "";
  }

  if (nmCentroCusto!= null) {
    clausula = " WHERE nmCentroCusto LIKE '"+nmCentroCusto+"%'";
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
dao = new CentroCustoDAO(conn);
clausula = clausula+" ORDER BY cdCentroCusto ";
list = dao.listarCentroCusto(clausula);

int cont = 0;
%>
<h1 class="cabecalho_pagina">Cadastro de Centro de Custo</h1>

|<a class="button" href="formCentroCusto.jsp?acao=inc">Novo Cadastro</a>|<br>

<body onload="document.forms[0].elements[0].focus();" >
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<form action="listarCentroCusto.jsp">
<table colspan="2">
  <tr>
    <th class='label'>Descrição Centro Custo</th>
    <td><input type="text" name="nmCentroCusto" <%if (nmCentroCusto != null) { %>value="<%=nmCentroCusto %>"<% }%>  size="40" maxlength="40"></td>
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
      <th class="grid"><center>Código do Centro de Custo</center></th>
      <th class="grid"><center>Descrição do Centro de Custo</center></th>
      <th class="grid"><center>Sub-Centro de Custo de</center></th>
      <th class="grid">Status</th>
      <th class="grid">Excluir</th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
String msgStatus = "";
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	CentroCusto centroC = (CentroCusto) it.next();
	String nmCentroCustoPai = "";
	if (centroC.getIdCentroCustoPai()>0) {
		CentroCusto subcentroC = dao.procurarCentroCusto(centroC.getIdCentroCustoPai());
		nmCentroCustoPai = subcentroC.getNmCentroCusto();		
	}
	if(centroC.getStatus().equals("I")){
		msgStatus = "INATIVO";
	}else{
		msgStatus = "ATIVO";
	}
    cont++;

%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid"><center><%=centroC.getCdCentroCusto()%></center></td>
      <td class = "grid"><center><a href="formCentroCusto.jsp?acao=atu&idCentroCusto=<%=centroC.getIdCentroCusto()%>"><%=centroC.getNmCentroCusto()%> </a></center></td>
      <td class = "grid"><center><%=nmCentroCustoPai%></center></td>
      <td class = "grid" width="5%"><center><%=msgStatus%></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=centroC.getIdCentroCusto()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
  	</tr>
<%
}
%>   
</table>
</form>
<p align="right">|<a class="button" href="formCentroCusto.jsp?acao=inc">Novo Cadastro</a>|
