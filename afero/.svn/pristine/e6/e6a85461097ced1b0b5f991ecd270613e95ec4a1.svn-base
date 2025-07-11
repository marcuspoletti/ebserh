<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.CstPis" %>
<%@ page import="afero.persistence.CstPisDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function confirmaExcluir(cont, id) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarCstPis.jsp?acao=exc&cdCstPis=' + id;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.nomeCstPis.value = '';
  document.forms[0].submit();
}  
</script>

<%
	CstPisDAO dao;
CstPisDAO daoExclusao;


String acao = request.getParameter("acao");
if (acao == null) acao = "listar";

String dsCstPis = "";
String nomeCstPis = "";
String clausula = "";
String cdCstPis = "";
String mensagem = request.getParameter("mensagem");
if(mensagem == null)mensagem="";

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
    cdCstPis = request.getParameter("cdCstPis");
    dsCstPis = request.getParameter("dsCstPis");
    nomeCstPis = request.getParameter("nomeCstPis");
    if(cdCstPis == null)cdCstPis = "0";
    if(dsCstPis == null)dsCstPis = "";
    if(nomeCstPis == null)nomeCstPis ="";
   
  

   CstPis cstPis = new CstPis();

	try {
	 
      cstPis.setCdCstPis(Integer.parseInt(cdCstPis));
      cstPis.setDsCstPis(dsCstPis);
     
	  
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}

  dao = new CstPisDAO(conn);
  daoExclusao = new CstPisDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {
	  //inclui no banco de dados
  	dao.incluir(cstPis);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
	  dao.atualizar(cstPis);

  } else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  if(!daoExclusao.exclusaoCstPis(Integer.parseInt(cdCstPis))) {
				dao.excluir(cstPis);
			} else {
				response.sendRedirect("listarCstPis.jsp?mensagem=Exclusão Inválida! Item já possui lançamentos.&acao=listar");
			}

		}
	} else {
		if (!acao.equalsIgnoreCase("voltar")) {
			nomeCstPis = request.getParameter("nomeCstPis");
		}

		if (nomeCstPis != null) {
			clausula = " WHERE dsCstPis LIKE '" + nomeCstPis + "%'";
		}
	}

	//seleciona todos os registros do banco de dados
	List list;
	dao = new CstPisDAO(conn);
	clausula = clausula + " ORDER BY dsCstPis ";
	list = dao.listarCstPis(clausula);

	int cont = 0;
%>
<h1 class="cabecalho_pagina">Cadastro de Cst Pis</h1>
|<a class="button" href="formCstPis.jsp?acao=inc">Novo Cadastro</a>|<br>
<body onload="document.forms[0].elements[0].focus();" >
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<form action="listarCstPis.jsp">
<table colspan="2">
  <tr>
    <th class='label'>Desc. do Cst</th>
    <td><input type="text" name="nomeCstPis" <%if (nomeCstPis != null) { %>value="<%=nomeCstPis %>"<% }%>  size="40" maxlength="40"></td>
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
	CstPis cstPis = (CstPis) it.next();
	cont++;

%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
       <td class = "grid" width="15%"><center><%=cstPis.getCdCstPis()%></center></td>
      <td class = "grid"><center><a href="formCstPis.jsp?acao=atu&cdCstPis=<%=cstPis.getCdCstPis()%>"><%=cstPis.getDsCstPis()%></a></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=cstPis.getCdCstPis()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
  	</tr>
<%
}
%>   
</table>
</form>
<p align="right">|<a class="button" href="formCstPis.jsp?acao=inc">Novo Cadastro</a>|
<%@include file="../fimConexao.jsp"%>