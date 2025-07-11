<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.CstIpi" %>
<%@ page import="afero.persistence.CstIpiDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function confirmaExcluir(cont, id) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarCstIpi.jsp?acao=exc&cdCstIpi=' + id;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.nomeCstIpi.value = '';
  document.forms[0].submit();
}  
</script>

<%
CstIpiDAO dao;
CstIpiDAO daoExclusao;


String acao = request.getParameter("acao");
if (acao == null) acao = "listar";

String dsCstIpi = "";
String nomeCstIpi = "";
String clausula = "";
String cdCstIpi = "";
String mensagem = request.getParameter("mensagem");
if(mensagem == null)mensagem="";

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
    cdCstIpi = request.getParameter("cdCstIpi");
    dsCstIpi = request.getParameter("dsCstIpi");
    nomeCstIpi = request.getParameter("nomeCstIpi");
    if(cdCstIpi == null)cdCstIpi = "0";
    if(dsCstIpi == null)dsCstIpi = "";
    if(nomeCstIpi == null)nomeCstIpi ="";
   
  

   CstIpi cstIpi = new CstIpi();

	try {
	 
      cstIpi.setCdCstIpi(Integer.parseInt(cdCstIpi));
      cstIpi.setDsCstIpi(dsCstIpi);
     
	  
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}

  dao = new CstIpiDAO(conn);
  daoExclusao = new CstIpiDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {
	  //inclui no banco de dados
  	dao.incluir(cstIpi);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
	  dao.atualizar(cstIpi);

  } else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  if(!daoExclusao.exclusaoCstIpi(Integer.parseInt(cdCstIpi))) {
				dao.excluir(cstIpi);
			} else {
				response.sendRedirect("listarCstIpi.jsp?mensagem=Exclusão Inválida! Item já possui lançamentos.&acao=listar");
			}

		}
	} else {
		if (!acao.equalsIgnoreCase("voltar")) {
			nomeCstIpi = request.getParameter("nomeCstIpi");
		}

		if (nomeCstIpi != null) {
			clausula = " WHERE dsCstIpi LIKE '" + nomeCstIpi + "%'";
		}
	}

	//seleciona todos os registros do banco de dados
	List list;
	dao = new CstIpiDAO(conn);
	clausula = clausula + " ORDER BY dsCstIpi ";
	list = dao.listarCstIpi(clausula);

	int cont = 0;
%>
<h1 class="cabecalho_pagina">Cadastro de Cst Ipi</h1>
|<a class="button" href="formCstIpi.jsp?acao=inc">Novo Cadastro</a>|<br>
<body onload="document.forms[0].elements[0].focus();" >
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<form action="listarCstIpi.jsp">
<table colspan="2">
  <tr>
    <th class='label'>Desc. do CstIpi</th>
    <td><input type="text" name="nomeCstIpi" <%if (nomeCstIpi != null) { %>value="<%=nomeCstIpi %>"<% }%>  size="40" maxlength="40"></td>
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
	CstIpi cstIpi = (CstIpi) it.next();
	cont++;

%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
       <td class = "grid" width="15%"><center><%=cstIpi.getCdCstIpi()%></center></td>
      <td class = "grid"><center><a href="formCstIpi.jsp?acao=atu&cdCstIpi=<%=cstIpi.getCdCstIpi()%>"><%=cstIpi.getDsCstIpi()%></a></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=cstIpi.getCdCstIpi()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
  	</tr>
<%
}
%>   
</table>
</form>
<p align="right">|<a class="button" href="formCstIpi.jsp?acao=inc">Novo Cadastro</a>|
<%@include file="../fimConexao.jsp"%>