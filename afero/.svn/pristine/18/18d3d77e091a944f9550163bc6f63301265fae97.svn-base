<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.Entidade" %>
<%@ page import="afero.persistence.EntidadeDAO" %>
<%@ page import="afero.model.EntidadeTelefone" %>
<%@ page import="afero.persistence.EntidadeTelefoneDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function confirmaExcluir(cont, cd, id) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarEntidadeTelefone.jsp?acao=exc&cdEntidade=' + cd + '&idEntidadeTelefone=' + id;   
  }  
}  
</script>

<%
EntidadeTelefoneDAO dao;
EntidadeDAO dao1;

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
  String idEntidadeTelefone = request.getParameter("idEntidadeTelefone");
  String cdTipoTelefone = request.getParameter("cdTipoTelefone");
  String nroTelefone = request.getParameter("nroTelefone");
  String ramTelefone = request.getParameter("ramTelefone");
  String telefonePadrao = request.getParameter("telefonePadrao");
  usuario = (String)session.getAttribute("Login");
  if (idEntidadeTelefone == null) idEntidadeTelefone = "";
  if (cdEntidade == null) cdEntidade = "";
  if (cdTipoTelefone == null) cdTipoTelefone = "1";
  if (nroTelefone == null) nroTelefone = "";
  if (ramTelefone == null) ramTelefone = "";
  if (telefonePadrao == null) telefonePadrao = "A";

  EntidadeTelefone entidadeTelefone = new EntidadeTelefone();

	try {
	  if (!acao.equalsIgnoreCase("inc")){
		  entidadeTelefone.setIdEntidadeTelefone(Integer.parseInt(idEntidadeTelefone));
	  }
	  if (!acao.equalsIgnoreCase("exc")){  
		  entidadeTelefone.setCdEntidade(Integer.parseInt(cdEntidade));
		  entidadeTelefone.setCdTipoTelefone(Integer.parseInt(cdTipoTelefone));
		}
	  entidadeTelefone.setNroTelefone(nroTelefone);
	  entidadeTelefone.setRamTelefone(ramTelefone);
	  entidadeTelefone.setPadrao(telefonePadrao);
	  entidadeTelefone.setUsuario(usuario);
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}

  dao = new EntidadeTelefoneDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {
	  //inclui no banco de dados
  	dao.incluir(entidadeTelefone);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
	  dao.atualizar(entidadeTelefone);

  } else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  dao.excluir(entidadeTelefone);
  }
}

dao1 = new EntidadeDAO(conn);
Entidade entidade;
try {
	entidade = dao1.procurarEntidade(Integer.parseInt(cdEntidade));
} catch (NumberFormatException nfe) {
	throw new Exception("Código inválido");
}

//seleciona todos os registros do banco de dados
dao = new EntidadeTelefoneDAO(conn);
List list = dao.listarEntidadeTelefone(" WHERE e.cdEntidade = "+cdEntidade);

int cont = 0;
%>
<h1  class="cabecalho_pagina">Cadastro de Telefone - Entidade</h1>

|<a class="button" href="formEntidadeTelefone.jsp?cdEntidade=<%=cdEntidade %>&acao=inc">Novo Telefone</a>|&nbsp;&nbsp;&nbsp;
<% if (entidade.getTpInsc().equals("F")) { %>
|<a class="button" href="formEntidadeFisica.jsp?cdEntidade=<%=cdEntidade %>&acao=<%=acaoAnterior %>&selectAba=<%=selectAba%>">Voltar</a>|<br>
<% } else { %>
|<a class="button" href="formEntidadeJuridica.jsp?cdEntidade=<%=cdEntidade %>&acao=<%=acaoAnterior %>&selectAba=<%=selectAba%>">Voltar</a>|<br>
<% } %>

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr">
      <th class="grid">&nbsp;</th>
      <th class="grid"><center>Telefone</center></th>
      <th class="grid">Padrão</th>
      <th class="grid">Excluir</th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	EntidadeTelefone entidadeTelefone = (EntidadeTelefone) it.next();
	cont++;
%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid"><center><a href="formEntidadeTelefone.jsp?idEntidadeTelefone=<%=entidadeTelefone.getIdEntidadeTelefone()%>&&acao=atu">
      	<%=entidadeTelefone.getNroTelefone()%></a></center></td>
      <td class = "grid" width="5%"><center><%=entidadeTelefone.getPadrao()%></center></td>
      <%if (entidadeTelefone.getPadrao().equals("N")) {%>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=entidadeTelefone.getCdEntidade()%>,<%=entidadeTelefone.getIdEntidadeTelefone()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
      <% } else { %>
      <td class = "grid" width="3%"><center><img border = "0" src="../images/delete.gif"></center></td>
      <% } %>
    </tr>
<%
}
%>   
</table>
<%@include file="../fimConexao.jsp"%>