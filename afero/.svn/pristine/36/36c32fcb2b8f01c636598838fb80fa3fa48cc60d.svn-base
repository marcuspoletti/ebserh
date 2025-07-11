<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="aferopet.model.TipoRaca" %>
<%@ page import="aferopet.persistence.TipoRacaDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function confirmaExcluir(cont, id) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarTipoRaca.jsp?acao=exc&idTipoRaca=' + id;   
  }  
}  
</script>

<%
TipoRacaDAO dao;

String acao = request.getParameter("acao");
if (acao == null) acao = "listar";

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
  String idTipoRaca = request.getParameter("idTipoRaca");
  String descricao = request.getParameter("descricao");
  String status = request.getParameter("status");
  if (idTipoRaca == null) idTipoRaca = "";
  if (descricao == null) descricao = "";
  if (status == null) status = "A";
  
  TipoRaca tipoRaca = new TipoRaca();

	try {
	  if (!acao.equalsIgnoreCase("inc")){
		  tipoRaca.setIdTipoRaca(Integer.parseInt(idTipoRaca));
	  }
	  tipoRaca.setDsTipoRaca(descricao);
	  tipoRaca.setStatus(status);
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}

  dao = new TipoRacaDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {
	  //inclui no banco de dados
  	dao.incluir(tipoRaca);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
	  dao.atualizar(tipoRaca);

  } else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  dao.excluir(tipoRaca);
  }
}

//seleciona todos os registros do banco de dados
dao = new TipoRacaDAO(conn);
List list = dao.listarTipoRaca("");

int cont = 0;
%>
<h1  class="cabecalho_pagina">Cadastro Tipo de Raça</h1>

|<a class="button" href="formTipoRaca.jsp?acao=inc">Novo Cadastro</a>|<br>

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
	TipoRaca tipoRaca = (TipoRaca) it.next();
	cont++;
%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid"><center><a href="formTipoRaca.jsp?acao=atu&idTipoRaca=<%=tipoRaca.getIdTipoRaca()%>"><%=tipoRaca.getDsTipoRaca()%></a></center></td>
      <td class = "grid" width="5%"><center><%=tipoRaca.getStatus()%></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=tipoRaca.getIdTipoRaca()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
    </tr>
<%
}
%>   
</table>
<%@include file="../fimConexao.jsp"%>