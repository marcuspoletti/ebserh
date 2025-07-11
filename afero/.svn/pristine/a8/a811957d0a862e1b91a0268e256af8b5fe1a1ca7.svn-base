<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.CstIcms" %>
<%@ page import="afero.persistence.CstIcmsDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function confirmaExcluir(cont, id) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarCstIcms.jsp?acao=exc&cdCstIcms=' + id;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.nomeCstIcms.value = '';
  document.forms[0].submit();
}  
</script>

<%
	CstIcmsDAO dao;
CstIcmsDAO daoExclusao;


String acao = request.getParameter("acao");
if (acao == null) acao = "listar";

String dsCstIcms = "";
String nomeCstIcms = "";
String clausula = "";
String cdCstIcms = "";
String mensagem = request.getParameter("mensagem");
if(mensagem == null)mensagem="";

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
    cdCstIcms = request.getParameter("cdCstIcms");
    dsCstIcms = request.getParameter("dsCstIcms");
    nomeCstIcms = request.getParameter("nomeCstIcms");
    if(cdCstIcms == null)cdCstIcms = "0";
    if(dsCstIcms == null)dsCstIcms = "";
    if(nomeCstIcms == null)nomeCstIcms ="";
   
  

   CstIcms cstIcms = new CstIcms();

	try {
	 
      cstIcms.setCdCstIcms(Integer.parseInt(cdCstIcms));
      cstIcms.setDsCstIcms(dsCstIcms);
     
	  
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}

  dao = new CstIcmsDAO(conn);
  daoExclusao = new CstIcmsDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {
	  //inclui no banco de dados
  	dao.incluir(cstIcms);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
	  dao.atualizar(cstIcms);

  } else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  if(!daoExclusao.exclusaoCstIcms(Integer.parseInt(cdCstIcms))) {
				dao.excluir(cstIcms);
			} else {
				response.sendRedirect("listarCstIcms.jsp?mensagem=Exclusão Inválida! Item já possui lançamentos.&acao=listar");
			}

		}
	} else {
		if (!acao.equalsIgnoreCase("voltar")) {
			nomeCstIcms = request.getParameter("nomeCstIcms");
		}

		if (nomeCstIcms != null) {
			clausula = " WHERE dsCstIcms LIKE '" + nomeCstIcms + "%'";
		}
	}

	//seleciona todos os registros do banco de dados
	List list;
	dao = new CstIcmsDAO(conn);
	clausula = clausula + " ORDER BY dsCstIcms ";
	list = dao.listarCstIcms(clausula);

	int cont = 0;
%>
<h1 class="cabecalho_pagina">Cadastro de Cst Icms</h1>
|<a class="button" href="formCstIcms.jsp?acao=inc">Novo Cadastro</a>|<br>
<body onload="document.forms[0].elements[0].focus();" >
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<form action="listarCstIcms.jsp">
<table colspan="2">
  <tr>
    <th class='label'>Desc. do CstIcms</th>
    <td><input type="text" name="nomeCstIcms" <%if (nomeCstIcms != null) { %>value="<%=nomeCstIcms %>"<% }%>  size="40" maxlength="40"></td>
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
	CstIcms cstIcms = (CstIcms) it.next();
	cont++;

%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
       <td class = "grid" width="15%"><center><%=cstIcms.getCdCstIcms()%></center></td>
      <td class = "grid"><center><a href="formCstIcms.jsp?acao=atu&cdCstIcms=<%=cstIcms.getCdCstIcms()%>"><%=cstIcms.getDsCstIcms()%></a></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=cstIcms.getCdCstIcms()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
  	</tr>
<%
}
%>   
</table>
</form>
<p align="right">|<a class="button" href="formCstIcms.jsp?acao=inc">Novo Cadastro</a>|
<%@include file="../fimConexao.jsp"%>