<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.Entidade" %>
<%@ page import="afero.persistence.EntidadeDAO" %>
<%@ page import="afero.model.EntidadeEndereco" %>
<%@ page import="afero.persistence.EntidadeEnderecoDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function confirmaExcluir(cont, cd, id) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarEntidadeEndereco.jsp?acao=exc&cdEntidade=' + cd + '&idEntidadeEndereco=' + id;   
  }  
}  
</script>

<%
EntidadeEnderecoDAO dao;
EntidadeDAO dao1;

String acao = request.getParameter("acao");
String acaoAnterior = request.getParameter("acaoAnterior");
String selectAba = request.getParameter("selectAba");
if (acao == null) acao = "listar";
if (acaoAnterior == null) acaoAnterior = "atu";
if (selectAba == null) selectAba = "3";
String dtMod = "";
String dtCad = "";
String usuario ="";

String cdEntidade = request.getParameter("cdEntidade");

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
  String idEntidadeEndereco = request.getParameter("idEntidadeEndereco");
  String cdTipoEndereco = request.getParameter("cdTipoEndereco");
  String cdTipoLogradouro = request.getParameter("cdTipoLogradouro");
  String idCidade = request.getParameter("idCidade");
  String dsEndereco = request.getParameter("dsEndereco");
  String nroEndereco = request.getParameter("nroEndereco");
  String cmpEndereco = request.getParameter("cmpEndereco");
  String baiEndereco = request.getParameter("baiEndereco");
  String cepEndereco = request.getParameter("cepEndereco");
  String cxpEndereco = request.getParameter("cxpEndereco");
  String refEndereco = request.getParameter("refEndereco");
  String enderecoPadrao = request.getParameter("enderecoPadrao");
  usuario = (String)session.getAttribute("Login");
  if (idEntidadeEndereco == null) idEntidadeEndereco = "";
  if (cdEntidade == null) cdEntidade = "";
  if (cdTipoEndereco == null) cdTipoEndereco = "1";
  if (cdTipoLogradouro == null) cdTipoLogradouro = "34";
  if (idCidade == null) idCidade = "1";
  if (dsEndereco == null) dsEndereco = "";
  if (nroEndereco == null) nroEndereco = "";
  if (cmpEndereco == null) cmpEndereco = "";
  if (baiEndereco == null) baiEndereco = "";
  if (cepEndereco == null) cepEndereco = "";
  if (cxpEndereco == null) cxpEndereco = "";
  if (refEndereco == null) refEndereco = "";
  if (enderecoPadrao == null) enderecoPadrao = "A";

  EntidadeEndereco entidadeEndereco = new EntidadeEndereco();

	try {
	  if (!acao.equalsIgnoreCase("inc")){
		  entidadeEndereco.setIdEntidadeEndereco(Integer.parseInt(idEntidadeEndereco));
	  }
	  if (!acao.equalsIgnoreCase("exc")){  
		  entidadeEndereco.setCdEntidade(Integer.parseInt(cdEntidade));
		  entidadeEndereco.setCdTipoEndereco(Integer.parseInt(cdTipoEndereco));
		  entidadeEndereco.setCdTipoLogradouro(Integer.parseInt(cdTipoLogradouro));
		  entidadeEndereco.setIdCidade(Integer.parseInt(idCidade));
		}
	  entidadeEndereco.setDsEndereco(dsEndereco);
	  entidadeEndereco.setNroEndereco(nroEndereco);
	  entidadeEndereco.setCmpEndereco(cmpEndereco);
	  entidadeEndereco.setBaiEndereco(baiEndereco);
	  entidadeEndereco.setCepEndereco(cepEndereco);
	  entidadeEndereco.setCxpEndereco(cxpEndereco);
	  entidadeEndereco.setRefEndereco(refEndereco);
	  entidadeEndereco.setPadrao(enderecoPadrao);
	  entidadeEndereco.setUsuario(usuario);
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}

  dao = new EntidadeEnderecoDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {
	  //inclui no banco de dados
  	dao.incluir(entidadeEndereco);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
	  dao.atualizar(entidadeEndereco);

  } else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  dao.excluir(entidadeEndereco);
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
dao = new EntidadeEnderecoDAO(conn);
List list = dao.listarEntidadeEndereco(" WHERE e.cdEntidade = "+cdEntidade);

int cont = 0;
%>
<h1  class="cabecalho_pagina">Cadastro de Endereço - Entidade</h1>

|<a class="button" href="formEntidadeEndereco.jsp?cdEntidade=<%=cdEntidade %>&acao=inc">Novo Endereço</a>|&nbsp;&nbsp;&nbsp;
<% if (entidade.getTpInsc().equals("F")) { %>
|<a class="button" href="formEntidadeFisica.jsp?cdEntidade=<%=cdEntidade %>&acao=<%=acaoAnterior %>&selectAba=<%=selectAba%>">Voltar</a>|<br>
<% } else { %>
|<a class="button" href="formEntidadeJuridica.jsp?cdEntidade=<%=cdEntidade %>&acao=<%=acaoAnterior %>&selectAba=<%=selectAba%>">Voltar</a>|<br>
<% } %>
<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr">
      <th class="grid">&nbsp;</th>
      <th class="grid"><center>Endereço</center></th>
      <th class="grid">Padrão</th>
      <th class="grid">Excluir</th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	EntidadeEndereco entidadeEndereco = (EntidadeEndereco) it.next();
	cont++;
%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid"><center><a href="formEntidadeEndereco.jsp?idEntidadeEndereco=<%=entidadeEndereco.getIdEntidadeEndereco()%>&&acao=atu">
      	<%=entidadeEndereco.getDsEndereco()+", "+entidadeEndereco.getNroEndereco()+" - "+entidadeEndereco.getBaiEndereco()%></a></center></td>
      <td class = "grid" width="5%"><center><%=entidadeEndereco.getPadrao()%></center></td>
      <%if (entidadeEndereco.getPadrao().equals("N")) {%>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=entidadeEndereco.getCdEntidade()%>,<%=entidadeEndereco.getIdEntidadeEndereco()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
      <% } else { %>
      <td class = "grid" width="3%"><center><img border = "0" src="../images/delete.gif"></center></td>
      <% } %>
    </tr>
<%
}
%>   
</table>
<%@include file="../fimConexao.jsp"%>