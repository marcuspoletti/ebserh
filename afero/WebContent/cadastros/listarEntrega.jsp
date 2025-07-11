<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.Entrega" %>
<%@ page import="afero.util.Utilitaria" %>
<%@ page import="afero.persistence.EntregaDAO" %>
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
       location.href = 'listarEntrega.jsp?acao=exc&idEntrega=' + id;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.nomeEntrega.value = '';
  document.all.status.value = ''; //não está limpando
  document.forms[0].submit();
}  
</script>

<%
EntregaDAO dao;
ConverteDate conDate = new ConverteDate();
String mensagem = request.getParameter("mensagem");
if(mensagem == null) mensagem="";
String acao = request.getParameter("acao");
if (acao == null) acao = "listar";

String dsEntrega = "";
String dtCad = "";
String dtMod = "";
String nomeEntrega = "";
String clausula = "";
String idEntrega = "";
String txEntrega = "";
String usuario = "";

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
	idEntrega = request.getParameter("idEntrega");
	dsEntrega = request.getParameter("dsEntrega");
    nomeEntrega = request.getParameter("nomeEntrega");
    txEntrega = request.getParameter("txEntrega");
    usuario = request.getParameter("usuario");
    if(idEntrega == null)idEntrega = "0";
    if(dsEntrega == null)dsEntrega= "";
    if(nomeEntrega == null)nomeEntrega ="";
    if(txEntrega == null)txEntrega ="0";
   
  

   Entrega entrega = new Entrega();

	try {
	  if (!acao.equalsIgnoreCase("inc")){
		 entrega.setIdEntrega(Integer.parseInt(idEntrega));
	  }
      entrega.setDsEntrega(dsEntrega);
      entrega.setTxEntrega(Utilitaria.toNumber(txEntrega).floatValue());
      entrega.setUsuario(usuario);
	  
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}

  dao = new EntregaDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {
	  //inclui no banco de dados
  	dao.incluir(entrega);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
	  dao.atualizar(entrega);

  } else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  if(!dao.exclusaoIdEntrega(Integer.parseInt(idEntrega))){
		  dao.excluir(entrega);
	  }else{
		  response.sendRedirect("listarEntrega.jsp?mensagem=Exclusão Inválida! Item já possui lançamentos.&acao=listar");
	  }
  }
} else {
 if (!acao.equalsIgnoreCase("voltar")) {
    nomeEntrega = request.getParameter("nomeEntrega");
  }

  if (nomeEntrega!= null) {
    clausula = " WHERE dsEntrega LIKE '"+nomeEntrega+"%'";
  } 

}

//seleciona todos os registros do banco de dados
List list;
dao = new EntregaDAO(conn);
clausula = clausula+" ORDER BY dsEntrega ";
list = dao.listarEntrega(clausula);

int cont = 0;
%>
<h1 class="cabecalho_pagina">Cadastro de Taxa de Entrega</h1>

|<a class="button" href="formEntrega.jsp?acao=inc">Novo Cadastro</a>|<br>
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<body onload="document.forms[0].elements[0].focus();" >
<form action="listarEntrega.jsp">
<table colspan="2">
  <tr>
    <th class='label'>Descrição da Entrega</th>
    <td><input type="text" name="nomeEntrega" <%if (nomeEntrega != null) { %>value="<%=nomeEntrega%>"<% }%>  size="40" maxlength="40"></td>
    <td><input class="button" type="button" value="Localizar" onClick="javascript: localizar();" /></td>
    <td><input class="button" type="button" value="Nova pesquisa" onClick="javascript: novaPesquisa();" /></td>
  </tr>
</table>
<hr>

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr>
      <th class="grid">&nbsp;</th>
      <th class="grid"><center>Descrição da Entrega</center></th>
      <th class="grid"><center>Taxa de Entrega</center></th>
      <th class="grid">Excluir</th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	Entrega entr = (Entrega) it.next();
	cont++;

%>
   <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid" width="15%"><center><a href="formEntrega.jsp?acao=atu&idEntrega=<%=entr.getIdEntrega()%>"><%=entr.getDsEntrega()%></a></center></td>
      <td class = "grid" width="5%"><center><%=Utilitaria.formatarNumero(entr.getTxEntrega(),2)%></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=entr.getIdEntrega()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
  	</tr>
<%
}
%>      
</table>
</form>
<p align="right">|<a class="button" href="formEntrega.jsp?acao=inc">Novo Cadastro</a>|
<%@include file="../fimConexao.jsp"%>