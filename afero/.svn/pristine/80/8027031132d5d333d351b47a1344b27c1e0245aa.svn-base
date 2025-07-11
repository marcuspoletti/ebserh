<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.Estado" %>
<%@ page import="afero.model.Cidade" %>
<%@ page import="afero.persistence.EstadoDAO" %>
<%@ page import="afero.persistence.CidadeDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function confirmaExcluir(cont, id) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarCidade.jsp?acao=exc&idCidade=' + id;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.nmCidade.value = '';
  document.all.status.value = ''; //não está limpando
  document.forms[0].submit();
}  
</script>

<%
	CidadeDAO dao;

String acao = request.getParameter("acao");
if (acao == null) acao = "listar";
String mensagem = request.getParameter("mensagem");
if(mensagem == null) mensagem="";
String nmCidade = "";
String cdMunicipio = "";
String status = "A";
String clausula = "";

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
  String idCidade = request.getParameter("idCidade");
  String cdEstado = request.getParameter("cdEstado");
  nmCidade = request.getParameter("nmCidade");
  cdMunicipio = request.getParameter("cdMunicipio");
  status = request.getParameter("status");
  if (idCidade == null) idCidade = "";
  if (cdEstado == null)cdEstado = "0";
  if (nmCidade == null) nmCidade = "";
  if (cdMunicipio == null) cdMunicipio = "";
  if (status == null) status = "A";

  Cidade cidade = new Cidade();

	try {
	  if (!acao.equalsIgnoreCase("inc")){
		  cidade.setIdCidade(Integer.parseInt(idCidade));
	  }
	  cidade.setCdEstado(Integer.parseInt(cdEstado));
	  cidade.setNmCidade(nmCidade);
	  cidade.setCdMunicipio(cdMunicipio);
	  cidade.setStatus(status);
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}

  dao = new CidadeDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {
	  //inclui no banco de dados
  	dao.incluir(cidade);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
	  dao.atualizar(cidade);

  } else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  if(!dao.exclusaoIdCidade(Integer.parseInt(idCidade))){
		  dao.excluir(cidade);
	  }else{
		  response.sendRedirect("listarCidade.jsp?mensagem=Exclusão Inválida! Item já possui lançamentos.&acao=listar");
	  }
  }
} else {
  if (!acao.equalsIgnoreCase("voltar")) {
    nmCidade = request.getParameter("nmCidade");
    cdMunicipio = request.getParameter("cdMunicipio");
    status = request.getParameter("status");
    if (status == null) status = "";
  }

  if (nmCidade != null) {
    clausula = " WHERE nmCidade LIKE '"+nmCidade+"%'";
  } 
  if (!status.isEmpty()) {
    if (clausula.isEmpty()) {
      clausula = " WHERE status='"+status+"'";
    } else {
      clausula = clausula+" AND status='"+status+"'";
    }
  }
}
//seleciona todos os registros do banco de dados
List list;
dao = new CidadeDAO(conn);
clausula = clausula+" ORDER BY nmCidade";
list = dao.listarCidade(clausula);

int cont = 0;
%>
<h1 class="cabecalho_pagina">Cadastro de Cidade</h1>

|<a class="button" href="formCidade.jsp?acao=inc">Novo Cadastro</a>|<br>
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<body onload="document.forms[0].elements[0].focus();" >
<form action="listarCidade.jsp">
<table colspan="2">
  <tr>
    <th class='label'>Cidade</th>
    <td><input type="text" name="nmCidade" <%if (nmCidade != null) { %>value="<%=nmCidade%>"<% }%>  size="40" maxlength="40"></td>
    <td><input class="button" type="button" value="Localizar" onClick="javascript: localizar();" /></td>
    <td><input class="button" type="button" value="Nova pesquisa" onClick="javascript: novaPesquisa();" /></td>
  </tr>
  <tr>
    <th class="label">Status</th>
    <td class="label_radio">
      <input type="radio" class="radio" name="status" value="" <%= (status.equals("")? "checked": "") %>>Todos
      <input type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Ativo
      <input type="radio" class="radio" name="status" value="I" <%= (status.equals("I")? "checked": "") %>>Inativo</td>
  </tr>
</table>
<hr>

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr>
      <th class="grid">&nbsp;</th>
      <th class="grid"><center>Cidade</center></th>
      <th class="grid">Status</th>
      <th class="grid">Excluir</th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	Cidade cidade = (Cidade) it.next();
	cont++;
  EstadoDAO dao1 = new EstadoDAO(conn);
  Estado estado = dao1.procurarEstado(cidade.getCdEstado());
%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid"><center><a href="formCidade.jsp?acao=atu&idCidade=<%=cidade.getIdCidade()%>&cdEstado=<%=cidade.getCdEstado()%>>"><%=cidade.getNmCidade()+"/"+estado.getSiglaEstado()%></a></center></td>
      <td class = "grid" width="5%"><center><%=cidade.getStatus()%></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=cidade.getIdCidade()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
  	</tr>
<%
}
%>   
</table>
</form>
<%@include file="../fimConexao.jsp"%>
<p align="right">|<a class="button" href="formCidade.jsp?acao=inc">Novo Cadastro</a>|