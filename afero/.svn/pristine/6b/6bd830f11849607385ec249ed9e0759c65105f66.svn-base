<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.Entidade" %>
<%@ page import="afero.persistence.EntidadeDAO" %>
<%@ page import="afero.model.EntidadeEmail" %>
<%@ page import="afero.persistence.EntidadeEmailDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function confirmaExcluir(cont, cd, id) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarEntidadeEmail.jsp?acao=exc&cdEntidade=' + cd + '&idEntidadeEmail=' + id;   
  }  
}  
</script>

<%
EntidadeEmailDAO dao;
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
  String idEntidadeEmail = request.getParameter("idEntidadeEmail");
  String cdTipoEmail = request.getParameter("cdTipoEmail");
  String dsEmail = request.getParameter("dsEmail");
  String emailPadrao = request.getParameter("emailPadrao");
  usuario = (String)session.getAttribute("Login");
  if (idEntidadeEmail == null) idEntidadeEmail = "";
  if (cdEntidade == null) cdEntidade = "";
  if (cdTipoEmail == null) cdTipoEmail = "1";
  if (dsEmail == null) dsEmail = "";
  if (emailPadrao == null) emailPadrao = "A";

  EntidadeEmail entidadeEmail = new EntidadeEmail();

	try {
	  if (!acao.equalsIgnoreCase("inc")){
		  entidadeEmail.setIdEntidadeEmail(Integer.parseInt(idEntidadeEmail));
	  }
	  if (!acao.equalsIgnoreCase("exc")){  
		  entidadeEmail.setCdEntidade(Integer.parseInt(cdEntidade));
		  entidadeEmail.setCdTipoEmail(Integer.parseInt(cdTipoEmail));
		}
	  entidadeEmail.setDsEmail(dsEmail);
	  entidadeEmail.setPadrao(emailPadrao);
	  entidadeEmail.setUsuario(usuario);
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}

  dao = new EntidadeEmailDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {
	  //inclui no banco de dados
  	dao.incluir(entidadeEmail);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
	  dao.atualizar(entidadeEmail);

  } else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  dao.excluir(entidadeEmail);
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
dao = new EntidadeEmailDAO(conn);
List list = dao.listarEntidadeEmail(" WHERE e.cdEntidade = "+cdEntidade);

int cont = 0;
%>

<h1  class="cabecalho_pagina">Cadastro de Email - Entidade</h1>

|<a class="button" href="formEntidadeEmail.jsp?cdEntidade=<%=cdEntidade %>&acao=inc">Novo Email</a>|&nbsp;&nbsp;&nbsp;
<% if (entidade.getTpInsc().equals("F")) { %>
|<a class="button" href="formEntidadeFisica.jsp?cdEntidade=<%=cdEntidade %>&acao=<%=acaoAnterior %>&selectAba=<%=selectAba%>">Voltar</a>|<br>
<% } else { %>
|<a class="button" href="formEntidadeJuridica.jsp?cdEntidade=<%=cdEntidade %>&acao=<%=acaoAnterior %>&selectAba=<%=selectAba%>">Voltar</a>|<br>
<% } %>

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr">
      <th class="grid">&nbsp;</th>
      <th class="grid"><center>Email</center></th>
      <th class="grid">Padrão</th>
      <th class="grid">Excluir</th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	EntidadeEmail entidadeEmail = (EntidadeEmail) it.next();
	cont++;
%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid"><center><a href="formEntidadeEmail.jsp?idEntidadeEmail=<%=entidadeEmail.getIdEntidadeEmail()%>&&acao=atu">
      	<%=entidadeEmail.getDsEmail()%></a></center></td>
      <td class = "grid" width="5%"><center><%=entidadeEmail.getPadrao()%></center></td>
      <%if (entidadeEmail.getPadrao().equals("N")) {%>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=entidadeEmail.getCdEntidade()%>,<%=entidadeEmail.getIdEntidadeEmail()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
      <% } else { %>
      <td class = "grid" width="3%"><center><img border = "0" src="../images/delete.gif"></center></td>
      <% } %>
    </tr>
<%
}
%>   
</table>
<%@include file="../fimConexao.jsp"%>