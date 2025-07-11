<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.Crt" %>
<%@ page import="afero.persistence.CrtDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function confirmaExcluir(cont, id) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarCrt.jsp?acao=exc&idCrt=' + id;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.descricao.value = '';
  document.forms[0].submit();
}  
</script>

<%
CrtDAO dao;

String acao = request.getParameter("acao");
if (acao == null) acao = "listar";
String mensagem = request.getParameter("mensagem");
if(mensagem == null) mensagem="";
String descricao = "";
String codigo = "";
String clausula = "";

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
  String idCrt = request.getParameter("idCrt");
  codigo = request.getParameter("codigo");
  descricao = request.getParameter("descricao");
  
  if (idCrt == null) idCrt = "";
  if (codigo == null)codigo = "0";
  if (descricao == null) descricao = "";
  

  Crt crt = new Crt();

	try {
	  if (!acao.equalsIgnoreCase("inc")){
		  crt.setIdCrt(Integer.parseInt(idCrt));
	  }
	  crt.setCodigo(Integer.parseInt(codigo));
	  crt.setDescricao(descricao);
	  
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}

  dao = new CrtDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {
	  //inclui no banco de dados
  	dao.incluir(crt);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
	  dao.atualizar(crt);

  } else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  if(!dao.exclusaoIdCrt(Integer.parseInt(idCrt))){
		  dao.excluir(crt);
	  }else{
		  response.sendRedirect("listarCrt.jsp?mensagem=Exclusão Inválida! Item já possui lançamentos.&acao=listar");
	  }
  }
} else {
  if (!acao.equalsIgnoreCase("voltar")) {
	descricao = request.getParameter("descricao");
    codigo = request.getParameter("codigo");
  }

  if (descricao != null) {
    clausula = " WHERE descricao LIKE '"+descricao+"%'";
  } 
}
//seleciona todos os registros do banco de dados
List list;
dao = new CrtDAO(conn);
clausula = clausula+" ORDER BY descricao";
list = dao.listarCrt(clausula);

int cont = 0;
%>
<h1 class="cabecalho_pagina">Cadastro de CRT</h1>

|<a class="button" href="formCrt.jsp?acao=inc">Novo Cadastro</a>|<br>
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<body onload="document.forms[0].elements[0].focus();" >
<form action="listarCrt.jsp">
<table colspan="2">
  <tr>
    <th class='label'>Descrição</th>
    <td><input type="text" name="nmCidade" <%if (descricao != null) { %>value="<%=descricao%>"<% }%>  size="40" maxlength="40"></td>
    <td><input class="button" type="button" value="Localizar" onClick="javascript: localizar();" /></td>
    <td><input class="button" type="button" value="Nova pesquisa" onClick="javascript: novaPesquisa();" /></td>
  </tr>
  
</table>
<hr>

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr">
      <th class="grid">&nbsp;</th>
      <th class="grid"><center>Código</center></th>
      <th class="grid">Descrição</th>
      <th class="grid">Excluir</th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	Crt crt = (Crt) it.next();
	cont++;
%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid" width="2%"><center><%=crt.getCodigo()%></center></td>
      <td class = "grid"><center><a href="formCrt.jsp?acao=atu&idCrt=<%=crt.getIdCrt()%>"><%=crt.getDescricao()%></a></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=crt.getIdCrt()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
  	</tr>
<%
}
%>   
</table>
</form>
<%@include file="../fimConexao.jsp"%>
<p align="right">|<a class="button" href="formCrt.jsp?acao=inc">Novo Cadastro</a>|