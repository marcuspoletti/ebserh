<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="aferopet.model.TipoEspecie" %>
<%@ page import="aferopet.persistence.TipoEspecieDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function confirmaExcluir(cont, id) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarTipoEspecie.jsp?acao=exc&cdTipoEspecie=' + id;   
  }  
}  
</script>

<%
TipoEspecieDAO dao;

String acao = request.getParameter("acao");
if (acao == null) acao = "listar";

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
  String cdTipoEspecie = request.getParameter("cdTipoEspecie");
  String descricao = request.getParameter("descricao");
  String status = request.getParameter("status");
  if (cdTipoEspecie == null) cdTipoEspecie = "";
  if (descricao == null) descricao = "";
  if (status == null) status = "A";
  
  TipoEspecie tipoEspecie = new TipoEspecie();

	try {
	  if (!acao.equalsIgnoreCase("inc")){
		  tipoEspecie.setCdTipoEspecie(Integer.parseInt(cdTipoEspecie));
	  }
	  tipoEspecie.setDsTipoEspecie(descricao);
	  tipoEspecie.setStatus(status);
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}

  dao = new TipoEspecieDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {
	  //inclui no banco de dados
  	dao.incluir(tipoEspecie);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
	  dao.atualizar(tipoEspecie);

  } else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  dao.excluir(tipoEspecie);
  }
}

//seleciona todos os registros do banco de dados
dao = new TipoEspecieDAO(conn);
List list = dao.listarTipoEspecie("");

int cont = 0;
%>
<h1  class="cabecalho_pagina">Cadastro Tipo de Espécie</h1>

|<a class="button" href="formTipoEspecie.jsp?acao=inc">Novo Cadastro</a>|<br>

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
	TipoEspecie tipoEspecie = (TipoEspecie) it.next();
	cont++;
%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid"><center><a href="formTipoEspecie.jsp?acao=atu&cdTipoEspecie=<%=tipoEspecie.getCdTipoEspecie()%>"><%=tipoEspecie.getDsTipoEspecie()%></a></center></td>
      <td class = "grid" width="5%"><center><%=tipoEspecie.getStatus()%></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=tipoEspecie.getCdTipoEspecie()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
    </tr>
<%
}
%>   
</table>
<%@include file="../fimConexao.jsp"%>