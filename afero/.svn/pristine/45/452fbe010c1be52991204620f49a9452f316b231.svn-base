<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.Ncm" %>
<%@ page import="afero.persistence.NcmDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function confirmaExcluir(cont, id) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarNcm.jsp?acao=exc&cdNcm=' + id;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.nomeNcm.value = '';
  document.forms[0].submit();
}  
</script>

<%
NcmDAO dao;
NcmDAO daoExclusao;


String acao = request.getParameter("acao");
if (acao == null) acao = "listar";

String dsNcm = "";
String nomeNcm = "";
String clausula = "";
String cdNcm = "";
String mensagem = request.getParameter("mensagem");
if(mensagem == null)mensagem="";

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
    cdNcm = request.getParameter("cdNcm");
    dsNcm = request.getParameter("dsNcm");
    nomeNcm = request.getParameter("nomeNcm");
    if(cdNcm == null)cdNcm = "0";
    if(dsNcm == null)dsNcm = "";
    if(nomeNcm == null)nomeNcm ="";
   
  

   Ncm ncm = new Ncm();

	try {
	 
      ncm.setCdNcm(cdNcm);
      ncm.setDsNcm(dsNcm);
     
	  
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}

  dao = new NcmDAO(conn);
  daoExclusao = new NcmDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {
	  //inclui no banco de dados
  	dao.incluir(ncm);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
	  dao.atualizar(ncm);

  } else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  if(!daoExclusao.exclusaoCdNcm(cdNcm)){
		  dao.excluir(ncm);
	  }else{
		  response.sendRedirect("listarNcm.jsp?mensagem=Exclusão Inválida! Item já possui lançamentos.&acao=listar");
	  }
	  
  }
} else {
 if (!acao.equalsIgnoreCase("voltar")) {
    nomeNcm = request.getParameter("nomeNcm");
  }

  if (nomeNcm!= null) {
    clausula = " WHERE dsNcm LIKE '"+nomeNcm+"%'";
  } 
}

//seleciona todos os registros do banco de dados
List list;
dao = new NcmDAO(conn);
clausula = clausula+" ORDER BY dsNcm ";
list = dao.listarNcm(clausula);

int cont = 0;
%>
<h1 class="cabecalho_pagina">Cadastro de NCM</h1>
|<a class="button" href="formNcm.jsp?acao=inc">Novo Cadastro</a>|<br>
<body onload="document.forms[0].elements[0].focus();" >
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<form action="listarNcm.jsp">
<table colspan="2">
  <tr>
    <th class='label'>Desc. do Ncm</th>
    <td><input type="text" name="nomeNcm" <%if (nomeNcm != null) { %>value="<%=nomeNcm %>"<% }%>  size="40" maxlength="40"></td>
    <td><input class="button" type="button" value="Localizar" onClick="javascript: localizar();" /></td>
    <td><input class="button" type="button" value="Nova pesquisa" onClick="javascript: novaPesquisa();" /></td>
  </tr>
</table>
<hr>

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr>
      <th class="grid">&nbsp;</th>
      <th class="grid"><center>Cod. do NCM</center></th>
      <th class="grid"><center>Desc. do NCM</center></th>
      <th class="grid">Excluir</th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	Ncm ncm = (Ncm) it.next();
	cont++;

%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
       <td class = "grid" width="15%"><center><%=ncm.getCdNcm()%></center></td>
      <td class = "grid"><center><a href="formNcm.jsp?acao=atu&cdNcm=<%=ncm.getCdNcm()%>"><%=ncm.getDsNcm()%></a></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=ncm.getCdNcm()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
  	</tr>
<%
}
%>   
</table>
</form>
<p align="right">|<a class="button" href="formNcm.jsp?acao=inc">Novo Cadastro</a>|
<%@include file="../fimConexao.jsp"%>