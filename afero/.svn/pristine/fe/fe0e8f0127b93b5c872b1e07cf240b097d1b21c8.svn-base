<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.TipoEntidade" %>
<%@ page import="afero.persistence.TipoEntidadeDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function confirmaExcluir(cont, id) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarTipoEntidade.jsp?acao=exc&idTipoEntidade=' + id;   
  }  
}  
</script>

<%
TipoEntidadeDAO dao;

String acao = request.getParameter("acao");
if (acao == null) acao = "listar";

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
  String idTipoEntidade = request.getParameter("idTipoEntidade");
  String descricao = request.getParameter("descricao");
  String status = request.getParameter("status");
  if (idTipoEntidade == null) idTipoEntidade = "";
  if (descricao == null) descricao = "";
  if (status == null) status = "A";
  
  TipoEntidade tipoEntidade = new TipoEntidade();

	try {
	  if (!acao.equalsIgnoreCase("inc")){
		  tipoEntidade.setIdTipoEntidade(Integer.parseInt(idTipoEntidade));
	  }
	  tipoEntidade.setDsTipoEntidade(descricao);
	  tipoEntidade.setStatus(status);
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}

  dao = new TipoEntidadeDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {
	  //inclui no banco de dados
  	dao.incluir(tipoEntidade);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
	  dao.atualizar(tipoEntidade);

  } else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  dao.excluir(tipoEntidade);
  }
}

//seleciona todos os registros do banco de dados
dao = new TipoEntidadeDAO(conn);
List list = dao.listarTipoEntidade("");

int cont = 0;
%>
<h1  class="cabecalho_pagina">Cadastro Tipo de Entidade</h1>

|<a class="button" href="formTipoEntidade.jsp?acao=inc">Novo Cadastro</a>|<br>

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
	TipoEntidade tipoEntidade = (TipoEntidade) it.next();
	cont++;
%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid"><center><a href="formTipoEntidade.jsp?acao=atu&idTipoEntidade=<%=tipoEntidade.getIdTipoEntidade()%>"><%=tipoEntidade.getDsTipoEntidade()%></a></center></td>
      <td class = "grid" width="5%"><center><%=tipoEntidade.getStatus()%></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=tipoEntidade.getIdTipoEntidade()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
    </tr>
<%
}
%>   
</table>
<%@include file="../fimConexao.jsp"%>