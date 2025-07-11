<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.RelacaoUnidade" %>
<%@ page import="afero.persistence.RelacaoUnidadeDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Date" %>
<%@ page import="afero.util.ConverteDate" %>
<%@page import="afero.util.Utilitaria"%>
<%@page import="afero.model.UnidadeRelacaoUnidade"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>

<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function confirmaExcluir(cont, id) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = "listarRelacaoUnidade.jsp?acao=exc&idRelacaoUnidade="+id ;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.nomeSubGrupo.value = '';
  document.all.status.value = ''; //não está limpando
  document.forms[0].submit();
}  
</script>

<%

RelacaoUnidadeDAO dao;
Utilitaria util = new Utilitaria();
String acao = request.getParameter("acao");
if (acao == null) acao = "listar";

String idUnidadeDe = "";
String idUnidadePara = "";
String clausula = "";
String fatorConversao = "0";
String idRelacaoUnidade = "";

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
	idUnidadeDe = request.getParameter("idUnidadeDe");
	idUnidadePara = request.getParameter("idUnidadePara");
	fatorConversao = request.getParameter("fatorConversao");
	idRelacaoUnidade = request.getParameter("idRelacaoUnidade");
    if (idUnidadeDe == null)idUnidadeDe = "";
    if (idUnidadePara == null) idUnidadePara = "";
    if (fatorConversao == null) fatorConversao = "";
    

    RelacaoUnidade relacaoUnidade = new RelacaoUnidade();

	try {
	  if(!acao.equalsIgnoreCase("inc")){
		  relacaoUnidade.setIdRelacaoUnidade(Integer.parseInt(idRelacaoUnidade));  
	  }
	  if(!acao.equalsIgnoreCase("exc")){
	   relacaoUnidade.setIdUnidadeDe(Integer.parseInt(idUnidadeDe));
	   relacaoUnidade.setIdUnidadePara(Integer.parseInt(idUnidadePara));
	   relacaoUnidade.setFatorConversao(util.toNumber(fatorConversao).floatValue());
	  }
	  
      
	  
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}

  dao = new RelacaoUnidadeDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {
	  //inclui no banco de dados
  	dao.incluir(relacaoUnidade);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
	  dao.atualizar(relacaoUnidade);

  } else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  dao.excluir(relacaoUnidade);
  }
}

//seleciona todos os registros do banco de dados
List list;
dao = new RelacaoUnidadeDAO(conn);
clausula = "";
list = dao.listarRelacaoUnidade(clausula);

int cont = 0;
%>
<h1 class="cabecalho_pagina">Cadastro de Relação Unidade</h1>

|<a class="button" href="formRelacaoUnidade.jsp?acao=inc">Novo Cadastro</a>|<br>

<body onload="document.forms[0].elements[0].focus();" >

<hr>

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr">
      <th class="grid">&nbsp;</th>
      <th class="grid"><center>Relação Unidade</center></th>
      <th class="grid">Excluir</th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	RelacaoUnidade relacao = (RelacaoUnidade) it.next();
	cont++;
	UnidadeRelacaoUnidade unidadeRelacaoUnidade = relacao.getUnidadeRelacaoUnidade();
	

%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid"><center><a href="formRelacaoUnidade.jsp?acao=atu&idRelacaoUnidade=<%=relacao.getIdRelacaoUnidade()%>">DE:  <%=unidadeRelacaoUnidade.getDsUnidadeDe()%>       PARA:  <%=unidadeRelacaoUnidade.getDsUnidadePara()%> </a></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=relacao.getIdRelacaoUnidade()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
  	</tr>
<%
}
%>   
</table>

<p align="right">|<a class="button" href="formRelacaoUnidade.jsp?acao=inc">Novo Cadastro</a>|
<%@include file="../fimConexao.jsp"%>