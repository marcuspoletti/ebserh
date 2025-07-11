<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.Cfop" %>
<%@ page import="afero.persistence.CfopDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function confirmaExcluir(cont, id) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarCfop.jsp?acao=exc&cdCfop=' + id;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.nomeCfop.value = '';
  document.forms[0].submit();
}  
</script>

<%
CfopDAO dao;
CfopDAO daoExclusao;


String acao = request.getParameter("acao");
if (acao == null) acao = "listar";

String dsCfop = "";
String descricao = "";
String aplicacao = "";
String nomeCfop = "";
String clausula = "";
String cdCfop = "";
String mensagem = request.getParameter("mensagem");
if(mensagem == null)mensagem="";

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
    cdCfop = request.getParameter("cdCfop");
    dsCfop = request.getParameter("dsCfop");
    nomeCfop = request.getParameter("nomeCfop");
    descricao = request.getParameter("descricao");
    aplicacao = request.getParameter("aplicacao");
    if(cdCfop == null)cdCfop = "0";
    if(dsCfop == null)dsCfop = "";
    if(nomeCfop == null)nomeCfop ="";
    if(descricao == null)descricao= "";
    if(aplicacao == null)aplicacao = "";
   
  

   Cfop cfop = new Cfop();

	try {
	 
      cfop.setCdCfop(Integer.parseInt(cdCfop));
      cfop.setDsCfop(dsCfop);
      cfop.setDescricao(descricao);
      cfop.setAplicacao(aplicacao);
     
	  
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}

  dao = new CfopDAO(conn);
  daoExclusao = new CfopDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {
	  //inclui no banco de dados
  	dao.incluir(cfop);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
	  dao.atualizar(cfop);

  } else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  if(!daoExclusao.exclusaoCfop(Integer.parseInt(cdCfop))) {
				dao.excluir(cfop);
			} else {
				response.sendRedirect("listarCfop.jsp?mensagem=Exclusão Inválida! Item já possui lançamentos.&acao=listar");
			}

		}
	} else {
		if (!acao.equalsIgnoreCase("voltar")) {
			nomeCfop = request.getParameter("nomeCfop");
		}

		if (nomeCfop != null) {
			clausula = " WHERE dsCfop LIKE '" + nomeCfop + "%'";
		}
	}

	//seleciona todos os registros do banco de dados
	List list;
	dao = new CfopDAO(conn);
	clausula = clausula + " ORDER BY dsCfop ";
	list = dao.listarCfop(clausula);

	int cont = 0;
%>
<h1 class="cabecalho_pagina">Cadastro de Cfop</h1>
|<a class="button" href="formCfop.jsp?acao=inc">Novo Cadastro</a>|<br>
<body onload="document.forms[0].elements[0].focus();" >
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<form action="listarCfop.jsp">
<table colspan="2">
  <tr>
    <th class='label'>Desc. do Cfop</th>
    <td><input type="text" name="nomeCfop" <%if (nomeCfop != null) { %>value="<%=nomeCfop %>"<% }%>  size="40" maxlength="40"></td>
    <td><input class="button" type="button" value="Localizar" onClick="javascript: localizar();" /></td>
    <td><input class="button" type="button" value="Nova pesquisa" onClick="javascript: novaPesquisa();" /></td>
  </tr>
</table>
<hr>

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr>
      <th class="grid">&nbsp;</th>
      <th class="grid"><center>Cod. do CFOP</center></th>
      <th class="grid"><center>Desc. do CFOP</center></th>
      <th class="grid"><center>Desc.</center></th>
      <th class="grid"><center>Apli.</center></th>
      <th class="grid">Excluir</th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	Cfop cfop = (Cfop) it.next();
	cont++;

%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
       <td class = "grid" width="15%"><center><%=cfop.getCdCfop()%></center></td>
      <td class = "grid"><center><a href="formCfop.jsp?acao=atu&cdCfop=<%=cfop.getCdCfop()%>"><%=cfop.getDsCfop()%></a></center></td>
      <td class = "grid" width="15%"><center><%=cfop.getDescricao()%></center></td>
      <td class = "grid" width="15%"><center><%=cfop.getAplicacao()%></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=cfop.getCdCfop()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
  	</tr>
<%
}
%>   
</table>
</form>
<p align="right">|<a class="button" href="formCfop.jsp?acao=inc">Novo Cadastro</a>|
<%@include file="../fimConexao.jsp"%>