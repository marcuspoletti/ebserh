<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.Csosn" %>
<%@ page import="afero.persistence.CsosnDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function confirmaExcluir(cont, id) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarCsosn.jsp?acao=exc&cdCsosn=' + id;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.nomeCsosn.value = '';
  document.forms[0].submit();
}  
</script>

<%
	CsosnDAO dao;
CsosnDAO daoExclusao;


String acao = request.getParameter("acao");
if (acao == null) acao = "listar";

String dsCsosn = "";
String nomeCsosn = "";
String clausula = "";
String cdCsosn = "";
String mensagem = request.getParameter("mensagem");
if(mensagem == null)mensagem="";

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
    cdCsosn = request.getParameter("cdCsosn");
    dsCsosn = request.getParameter("dsCsosn");
    nomeCsosn = request.getParameter("nomeCsosn");
    if(cdCsosn == null)cdCsosn = "0";
    if(dsCsosn == null)dsCsosn = "";
    if(nomeCsosn == null)nomeCsosn ="";
   
  

   Csosn csosn = new Csosn();

	try {
	 
      csosn.setCdCsosn(Integer.parseInt(cdCsosn));
      csosn.setDsCsosn(dsCsosn);
     
	  
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}

  dao = new CsosnDAO(conn);
  daoExclusao = new CsosnDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {
	  //inclui no banco de dados
  	dao.incluir(csosn);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
	  dao.atualizar(csosn);

  } else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  if(!daoExclusao.exclusaoCsosn(Integer.parseInt(cdCsosn))) {
				dao.excluir(csosn);
			} else {
				response.sendRedirect("listarCsosn.jsp?mensagem=Exclusão Inválida! Item já possui lançamentos.&acao=listar");
			}

		}
	} else {
		if (!acao.equalsIgnoreCase("voltar")) {
			nomeCsosn = request.getParameter("nomeCsosn");
		}

		if (nomeCsosn != null) {
			clausula = " WHERE dsCsosn LIKE '" + nomeCsosn + "%'";
		}
	}

	//seleciona todos os registros do banco de dados
	List list;
	dao = new CsosnDAO(conn);
	clausula = clausula + " ORDER BY dsCsosn ";
	list = dao.listarCsosn(clausula);

	int cont = 0;
%>
<h1 class="cabecalho_pagina">Cadastro de Csosn</h1>
|<a class="button" href="formCsosn.jsp?acao=inc">Novo Cadastro</a>|<br>
<body onload="document.forms[0].elements[0].focus();" >
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<form action="listarCsosn.jsp">
<table colspan="2">
  <tr>
    <th class='label'>Desc. do Csosn</th>
    <td><input type="text" name="nomeCsosn" <%if (nomeCsosn != null) { %>value="<%=nomeCsosn %>"<% }%>  size="40" maxlength="40"></td>
    <td><input class="button" type="button" value="Localizar" onClick="javascript: localizar();" /></td>
    <td><input class="button" type="button" value="Nova pesquisa" onClick="javascript: novaPesquisa();" /></td>
  </tr>
</table>
<hr>

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr>
      <th class="grid">&nbsp;</th>
      <th class="grid"><center>Cod. do CST</center></th>
      <th class="grid"><center>Desc. do CST</center></th>
      <th class="grid">Excluir</th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	Csosn csosn = (Csosn) it.next();
	cont++;

%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
       <td class = "grid" width="15%"><center><%=csosn.getCdCsosn()%></center></td>
      <td class = "grid"><center><a href="formCsosn.jsp?acao=atu&cdCsosn=<%=csosn.getCdCsosn()%>"><%=csosn.getDsCsosn()%></a></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=csosn.getCdCsosn()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
  	</tr>
<%
}
%>   
</table>
</form>
<p align="right">|<a class="button" href="formCsosn.jsp?acao=inc">Novo Cadastro</a>|
<%@include file="../fimConexao.jsp"%>