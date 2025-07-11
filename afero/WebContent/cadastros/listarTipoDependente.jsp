<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.TipoDependente" %>
<%@ page import="afero.persistence.TipoDependenteDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function confirmaExcluir(cont, id) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarTipoDependente.jsp?acao=exc&idTipoDependente=' + id;   
  }  
}  
</script>

<%
TipoDependenteDAO dao;

String acao = request.getParameter("acao");
if (acao == null) acao = "listar";

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
  String idTipoDependente = request.getParameter("idTipoDependente");
  String descricao = request.getParameter("descricao");
  String status = request.getParameter("status");
  if (idTipoDependente == null) idTipoDependente = "";
  if (descricao == null) descricao = "";
  if (status == null) status = "A";

  TipoDependente tipoDependente = new TipoDependente();

	try {
	  if (!acao.equalsIgnoreCase("inc")){
		  tipoDependente.setIdTipoDependente(Integer.parseInt(idTipoDependente));
	  }
	  tipoDependente.setDsTipoDependente(descricao);
	  tipoDependente.setStatus(status);
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}

  dao = new TipoDependenteDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {
	  //inclui no banco de dados
  	dao.incluir(tipoDependente);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
	  dao.atualizar(tipoDependente);

  } else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  dao.excluir(tipoDependente);
  }
}

//seleciona todos os registros do banco de dados
dao = new TipoDependenteDAO(conn);
List list = dao.listarTipoDependente("");

int cont = 0;
%>
<h1  class="cabecalho_pagina">Cadastro de Tipo Dependente</h1>

|<a class="button" href="formTipoDependente.jsp?acao=inc">Novo Cadastro</a>|<br>

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
	TipoDependente tipoDependente = (TipoDependente) it.next();
	cont++;
%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid"><center><a href="formTipoDependente.jsp?acao=atu&idTipoDependente=<%=tipoDependente.getIdTipoDependente()%>"><%=tipoDependente.getDsTipoDependente()%></a></center></td>
      <td class = "grid" width="5%"><center><%=tipoDependente.getStatus()%></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=tipoDependente.getIdTipoDependente()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
    </tr>
<%
}
%>   
</table>
<%@include file="../fimConexao.jsp"%>