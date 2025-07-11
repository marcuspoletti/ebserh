<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.EntidadeDependente" %>
<%@ page import="afero.persistence.EntidadeDependenteDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="afero.util.ConverteDate" %>
<%@ page import="java.text.ParseException" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function confirmaExcluir(cont, cd, id) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarEntidadeDependenteSimplificado.jsp?acao=exc&cdEntidade=' + cd + '&idEntidadeDependente=' + id;   
  }  
}  
</script>

<%
EntidadeDependenteDAO dao;

String acao = request.getParameter("acao");
String acaoAnterior = request.getParameter("acaoAnterior");
String selectAba = request.getParameter("selectAba");
if (acao == null) acao = "listar";
if (acaoAnterior == null) acaoAnterior = "atu";
if (selectAba == null) selectAba = "1";
String dtMod = "";
String dtCad = "";
String usuario ="";

String cdEntidade = request.getParameter("cdEntidade");

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
  String idEntidadeDependente = request.getParameter("idEntidadeDependente");
  String idTipoDependente = request.getParameter("idTipoDependente");
  String nmDependente = request.getParameter("nmDependente");
  String dtNascimento = request.getParameter("dtNascimento");
  String sexo = request.getParameter("sexo");
  String status = request.getParameter("status");
  usuario = (String)session.getAttribute("Login");
  if (idEntidadeDependente == null) idEntidadeDependente = "";
  if (cdEntidade == null) cdEntidade = "";
  if (idTipoDependente == null) idTipoDependente = "1";
  if (nmDependente == null) nmDependente = "";
  if (dtNascimento == null) dtNascimento = "";
  if (status == null) status = "A";

  EntidadeDependente entidadeDependente = new EntidadeDependente();

	try {
	  if (!acao.equalsIgnoreCase("inc")){
		  entidadeDependente.setIdEntidadeDependente(Integer.parseInt(idEntidadeDependente));
	  }
	  if (!acao.equalsIgnoreCase("exc")){  
		  entidadeDependente.setCdEntidade(Integer.parseInt(cdEntidade));
		  entidadeDependente.setIdTipoDependente(Integer.parseInt(idTipoDependente));
		}
	  entidadeDependente.setNmDependente(nmDependente);
	  if (!dtNascimento.equals(""))
	  	entidadeDependente.setDtNascimento(ConverteDate.stringToDate(dtNascimento));
	  entidadeDependente.setSexo(sexo);
	  entidadeDependente.setStatus(status);
	  entidadeDependente.setUsuario(usuario);
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	} catch (ParseException pe) {
		throw new Exception("Data inválida");
	}

  dao = new EntidadeDependenteDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {
	  //inclui no banco de dados
  	dao.incluir(entidadeDependente);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
	  dao.atualizar(entidadeDependente);

  } else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  dao.excluir(entidadeDependente);
  }
}

//seleciona todos os registros do banco de dados
dao = new EntidadeDependenteDAO(conn);
List list = dao.listarEntidadeDependente(" WHERE e.cdEntidade = "+cdEntidade);

int cont = 0;
%>
<h1  class="cabecalho_pagina">Cadastro de Dependente - Entidade</h1>

|<a class="button" href="formEntidadeDependenteSimplificado.jsp?cdEntidade=<%=cdEntidade %>&acao=inc">Novo Dependente</a>|&nbsp;&nbsp;&nbsp;
|<a class="button" href="formEntidadeFisicaSimplificado.jsp?cdEntidade=<%=cdEntidade %>&acao=<%=acaoAnterior %>&selectAba=<%=selectAba%>">Voltar</a>|<br>

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr">
      <th class="grid">&nbsp;</th>
      <th class="grid"><center>Dependente</center></th>
      <th class="grid">Status</th>
      <th class="grid">Excluir</th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	EntidadeDependente entidadeDependente = (EntidadeDependente) it.next();
	cont++;
%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid"><center><a href="formEntidadeDependenteSimplificado.jsp?idEntidadeDependente=<%=entidadeDependente.getIdEntidadeDependente()%>&acao=atu">
      	<%=entidadeDependente.getNmDependente()%></a></center></td>
      <td class = "grid" width="5%"><center><%=entidadeDependente.getStatus()%></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=entidadeDependente.getCdEntidade()%>,<%=entidadeDependente.getIdEntidadeDependente()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
    </tr>
<%
}
%>   
</table>
<%@include file="../fimConexao.jsp"%>