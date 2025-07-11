<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.RamoAtividade" %>
<%@ page import="afero.persistence.RamoAtividadeDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function confirmaExcluir(cont, id) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarRamoAtividade.jsp?acao=exc&idRamoAtividade=' + id;   
  }  
}  
</script>

<%
RamoAtividadeDAO dao;

String acao = request.getParameter("acao");
if (acao == null) acao = "listar";

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
  String idRamoAtividade = request.getParameter("idRamoAtividade");
  String descricao = request.getParameter("descricao");
  String status = request.getParameter("status");
  if (idRamoAtividade == null) idRamoAtividade = "";
  if (descricao == null) descricao = "";
  if (status == null) status = "A";

  RamoAtividade tipoRamoAtividade = new RamoAtividade();

	try {
	  if (!acao.equalsIgnoreCase("inc")){
		  tipoRamoAtividade.setIdRamoAtividade(Integer.parseInt(idRamoAtividade));
	  }
	  tipoRamoAtividade.setDsRamoAtividade(descricao);
	  tipoRamoAtividade.setStatus(status);
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}

  dao = new RamoAtividadeDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {
	  //inclui no banco de dados
  	dao.incluir(tipoRamoAtividade);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
	  dao.atualizar(tipoRamoAtividade);

  } else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  dao.excluir(tipoRamoAtividade);
  }
}

//seleciona todos os registros do banco de dados
dao = new RamoAtividadeDAO(conn);
List list = dao.listarRamoAtividade("");

int cont = 0;
%>
<h1  class="cabecalho_pagina">Cadastro Ramo de Atividade</h1>

|<a class="button" href="formRamoAtividade.jsp?acao=inc">Novo Cadastro</a>|<br>

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
	RamoAtividade tipoRamoAtividade = (RamoAtividade) it.next();
	cont++;
%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid"><center><a href="formRamoAtividade.jsp?acao=atu&idRamoAtividade=<%=tipoRamoAtividade.getIdRamoAtividade()%>"><%=tipoRamoAtividade.getDsRamoAtividade()%></a></center></td>
      <td class = "grid" width="5%"><center><%=tipoRamoAtividade.getStatus()%></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=tipoRamoAtividade.getIdRamoAtividade()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
    </tr>
<%
}
%>   
</table>
<%@include file="../fimConexao.jsp"%>