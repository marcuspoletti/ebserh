<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="aferopet.model.GrupoMedicamento" %>
<%@ page import="aferopet.persistence.GrupoMedicamentoDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function confirmaExcluir(cont, id) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarGrupoMedicamento.jsp?acao=exc&idGrupoMedicamento=' + id;   
  }  
}  
</script>

<%
GrupoMedicamentoDAO dao;

String acao = request.getParameter("acao");
if (acao == null) acao = "listar";

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
  String idGrupoMedicamento = request.getParameter("idGrupoMedicamento");
  String descricao = request.getParameter("descricao");
  String status = request.getParameter("status");
  String idDivisao = request.getParameter("idDivisao");
  String idSubGrupo = request.getParameter("idSubGrupo");
  String idGrupo = request.getParameter("idGrupo");
  if (idGrupoMedicamento == null) idGrupoMedicamento = "";
  if (descricao == null) descricao = "";
  if (status == null) status = "A";
  if (idDivisao == null)idDivisao = "0";
  if (idSubGrupo == null)idSubGrupo = "0";
  if (idGrupo == null)idGrupo = "0";
  
  
  GrupoMedicamento grupoMedicamento = new GrupoMedicamento();

	try {
	  if (!acao.equalsIgnoreCase("inc")){
		  grupoMedicamento.setIdGrupoMedicamento(Integer.parseInt(idGrupoMedicamento));
	  }
	  grupoMedicamento.setDsGrupoMedicamento(descricao);
	  grupoMedicamento.setStatus(status);
	  grupoMedicamento.setIdDivisao(Integer.parseInt(idDivisao));
	  grupoMedicamento.setIdSubGrupo(Integer.parseInt(idSubGrupo));
	  grupoMedicamento.setIdGrupo(Integer.parseInt(idGrupo));
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}

  dao = new GrupoMedicamentoDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {
	  //inclui no banco de dados
  	dao.incluir(grupoMedicamento);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
	  dao.atualizar(grupoMedicamento);

  } else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  dao.excluir(grupoMedicamento);
  }
}

//seleciona todos os registros do banco de dados
dao = new GrupoMedicamentoDAO(conn);
List list = dao.listarGrupoMedicamento("");

int cont = 0;
%>
<h1  class="cabecalho_pagina">Cadastro Grupo de Medicamento</h1>

|<a class="button" href="formGrupoMedicamento.jsp?acao=inc">Novo Cadastro</a>|<br>

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
	GrupoMedicamento grupoMedicamento = (GrupoMedicamento) it.next();
	cont++;
%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid"><center><a href="formGrupoMedicamento.jsp?acao=atu&idGrupoMedicamento=<%=grupoMedicamento.getIdGrupoMedicamento()%>&idDivisao=<%=grupoMedicamento.getIdDivisao()%>"><%=grupoMedicamento.getDsGrupoMedicamento()%></a></center></td>
      <td class = "grid" width="5%"><center><%=grupoMedicamento.getStatus()%></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=grupoMedicamento.getIdGrupoMedicamento()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
    </tr>
<%
}
%>   
</table>
<%@include file="../fimConexao.jsp"%>