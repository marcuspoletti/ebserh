<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.CstCofins" %>
<%@ page import="afero.persistence.CstCofinsDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function confirmaExcluir(cont, id) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarCstCofins.jsp?acao=exc&cdCstCofins=' + id;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.nomeCstConfins.value = '';
  document.forms[0].submit();
}  
</script>

<%
CstCofinsDAO dao;
CstCofinsDAO daoExclusao;


String acao = request.getParameter("acao");
if (acao == null) acao = "listar";

String dsCstConfins = "";
String nomeCstConfins = "";
String clausula = "";
String cdCstConfins = "";
String mensagem = request.getParameter("mensagem");
if(mensagem == null)mensagem="";

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
    cdCstConfins = request.getParameter("cdCstCofins");
    dsCstConfins = request.getParameter("dsCstCofins");
    nomeCstConfins = request.getParameter("nomeCstConfins");
    if(cdCstConfins == null)cdCstConfins = "0";
    if(dsCstConfins == null)dsCstConfins = "";
    if(nomeCstConfins == null)nomeCstConfins ="";
   
  

   CstCofins cstConfins = new CstCofins();

	try {
	 
      cstConfins.setCdCstCofins(Integer.parseInt(cdCstConfins));
      cstConfins.setDsCstCofins(dsCstConfins);
     
	  
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}

  dao = new CstCofinsDAO(conn);
  daoExclusao = new CstCofinsDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {
	  //inclui no banco de dados
  	dao.incluir(cstConfins);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
	  dao.atualizar(cstConfins);

  } else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  if(!daoExclusao.exclusaoCstCofins(Integer.parseInt(cdCstConfins))) {
				dao.excluir(cstConfins);
			} else {
				response.sendRedirect("listarCstCofins.jsp?mensagem=Exclusão Inválida! Item já possui lançamentos.&acao=listar");
			}

		}
	} else {
		if (!acao.equalsIgnoreCase("voltar")) {
			nomeCstConfins = request.getParameter("nomeCstConfins");
		}

		if (nomeCstConfins != null) {
			clausula = " WHERE dsCstCofins LIKE '" + nomeCstConfins + "%'";
		}
	}

	//seleciona todos os registros do banco de dados
	List list;
	dao = new CstCofinsDAO(conn);
	clausula = clausula + " ORDER BY dsCstCofins ";
	list = dao.listarCstCofins(clausula);

	int cont = 0;
%>
<h1 class="cabecalho_pagina">Cadastro de Cst Cofins</h1>
|<a class="button" href="formCstCofins.jsp?acao=inc">Novo Cadastro</a>|<br>
<body onload="document.forms[0].elements[0].focus();" >
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<form action="listarCstConfins.jsp">
<table colspan="2">
  <tr>
    <th class='label'>Desc. do Cst</th>
    <td><input type="text" name="nomeCstConfins" <%if (nomeCstConfins != null) { %>value="<%=nomeCstConfins %>"<% }%>  size="40" maxlength="40"></td>
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
	CstCofins cstConfins = (CstCofins) it.next();
	cont++;

%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
       <td class = "grid" width="15%"><center><%=cstConfins.getCdCstCofins()%></center></td>
      <td class = "grid"><center><a href="formCstCofins.jsp?acao=atu&cdCstCofins=<%=cstConfins.getCdCstCofins()%>"><%=cstConfins.getDsCstCofins()%></a></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=cstConfins.getCdCstCofins()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
  	</tr>
<%
}
%>   
</table>
</form>
<p align="right">|<a class="button" href="formCstCofins.jsp?acao=inc">Novo Cadastro</a>|
<%@include file="../fimConexao.jsp"%>