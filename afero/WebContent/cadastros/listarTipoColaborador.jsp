<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.TipoColaborador"%>
<%@ page import="afero.persistence.TipoColaboradorDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>

<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function confirmaExcluir(cont, id) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarTipoColaborador.jsp?acao=exc&idTipoColaborador=' + id;   
  }  
}  
</script>

<%
TipoColaboradorDAO dao;
String mensagem = request.getParameter("mensagem");
if(mensagem == null) mensagem="";
String acao = request.getParameter("acao");
if (acao == null) acao = "listar";

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
  String idTipoColaborador = request.getParameter("idTipoColaborador");
  String descricao = request.getParameter("descricao");
  String status = request.getParameter("status");
  if (idTipoColaborador == null) idTipoColaborador = "";
  if (descricao == null) descricao = "";
  if (status == null) status = "A";
  
  TipoColaborador tipoColaborador = new TipoColaborador();

	try {
	  if (!acao.equalsIgnoreCase("inc")){
		  tipoColaborador.setIdTipoColaborador(Integer.parseInt(idTipoColaborador));
	  }
	  tipoColaborador.setDsColaborador(descricao);
	  tipoColaborador.setStatus(status);
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}

  dao = new TipoColaboradorDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {
	  //inclui no banco de dados
  	dao.incluir(tipoColaborador);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
	  dao.atualizar(tipoColaborador);

  } else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  if(!dao.exclusaoIdColaborador(Integer.parseInt(idTipoColaborador))){
		  dao.excluir(tipoColaborador);
	  }else{
		  response.sendRedirect("listarTipoColaborador.jsp?mensagem=Exclusão Inválida! Item já possui lançamentos.&acao=listar");
	  }
	  
  }
}

//seleciona todos os registros do banco de dados
dao = new TipoColaboradorDAO(conn);
List list = dao.listarTipoColaborador("");

int cont = 0;
%>
<h1  class="cabecalho_pagina">Cadastro Tipo de Colaborador</h1>

|<a class="button" href="formTipoColaborador.jsp?acao=inc">Novo Cadastro</a>|<br>
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr">
      <th class="grid">&nbsp;</th>
      <th class="grid"><center>Descrição</center></th>
      <th class="grid">Status</th>
      <th class="grid">Excluir</th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	TipoColaborador tipoColaborador = (TipoColaborador) it.next();
	cont++;
%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid"><center><a href="formTipoColaborador.jsp?acao=atu&idTipoColaborador=<%=tipoColaborador.getIdTipoColaborador()%>"><%=tipoColaborador.getDsColaborador()%></a></center></td>
      <td class = "grid" width="5%"><center><%=tipoColaborador.getStatus()%></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=tipoColaborador.getIdTipoColaborador()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
    </tr>
<%
}
%>   
</table>
<%@include file="../fimConexao.jsp"%>