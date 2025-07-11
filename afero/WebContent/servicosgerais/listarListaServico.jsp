<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.ListaServico" %>
<%@ page import="afero.persistence.ListaServicoDAO" %>
<%@ page import="afero.util.Utilitaria" %>
<%@ page import="afero.util.ConverteDate" %>

<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function confirmaExcluir(cont, id) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarListaServico.jsp?acao=exc&idListaServico='+id;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.dsPesquisaServicoServico.value = '';
  document.all.status.value = ''; //não está limpando
  document.forms[0].submit();
}  
</script>

<%
ListaServicoDAO dao;
ListaServicoDAO daoExclusao;

String mensagem = request.getParameter("mensagem");
if(mensagem == null)mensagem = "";
String acao = request.getParameter("acao");
if (acao == null) acao = "listar";
String dsPesquisaServico = request.getParameter("dsPesquisaServico");
String clausula = "";

String idListaServico;
String idLoja;
String dsListaServico;
String cdListaServico;
String preco;
String idUnidade;
String status = "";
String usuario;


if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
	
	idListaServico = request.getParameter("idListaServico");
	idLoja = request.getParameter("idLoja");
	dsListaServico = request.getParameter("dsListaServico");
	cdListaServico = request.getParameter("cdListaServico");
	preco = request.getParameter("preco");
	idUnidade = request.getParameter("idUnidade");
	status = request.getParameter("status");
	usuario = (String) session.getAttribute("Login");
	
	
	if(idListaServico == null) idListaServico = "0";
	if(idLoja == null) idLoja = "0";
	if(dsListaServico == null) dsListaServico = "";
	if(cdListaServico == null) cdListaServico = "0";
	if(preco == null) preco = "0";
	if(idUnidade == null) idUnidade = "0";
	if(status == null) status = "A";

	ListaServico listaServico = new ListaServico();
  
	try {
	  if (!acao.equalsIgnoreCase("inc")){
		listaServico.setIdListaServico(Integer.parseInt(idListaServico));
	  }
	  
	  	listaServico.setIdLoja(Integer.parseInt(idLoja));
		listaServico.setDsListaServico(dsListaServico);
		listaServico.setCdListaServico(Integer.parseInt(cdListaServico));
		listaServico.setPreco(Utilitaria.toNumber(preco).floatValue());
		listaServico.setIdUnidade(Integer.parseInt(idUnidade));
		listaServico.setStatus(status);
		listaServico.setUsuario(usuario);
      
      if (!acao.equalsIgnoreCase("exc")){
    	 listaServico.setIdListaServico(Integer.parseInt(idListaServico));
      }      
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}

	dao = new ListaServicoDAO(conn);
	daoExclusao = new ListaServicoDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {  
	  //inclui no banco de dados
  	dao.incluir(listaServico);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
    	 dao.atualiza(listaServico);
  }else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
		  dao.excluir(listaServico);
  }
}else {
 if (!acao.equalsIgnoreCase("voltar")) {
	 dsPesquisaServico = request.getParameter("dsPesquisaServico");
    status = request.getParameter("status");
    if (status == null) status = "";
  }
 if(dsPesquisaServico != null){
	 clausula = " WHERE dsListaServico LIKE '"+dsPesquisaServico+"%'";
 }
 if (!status.isEmpty()) {
    if (clausula.isEmpty()) {
      clausula = " WHERE status='"+status+"'";
    } else {
      clausula = clausula+" AND status='"+status+"'";
    }
  }
}

//seleciona todos os registros do banco de dados
List list;
dao = new ListaServicoDAO(conn);
clausula = clausula +" ORDER BY dsListaServico ";
list = dao.listarListaServico(clausula);
int cont = 0;
%>
<h1 class="cabecalho_pagina">Lista de Serviço</h1>

|<a class="button" href="formListaServico.jsp?acao=inc">Novo Cadastro</a>|<br>

<body onload="document.forms[0].elements[0].focus();" >
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<form action="listarListaServico.jsp">
<table colspan="2">
  <tr>
    <th class='label'>Descrição Serviços</th>
    <td><input type="text" name="dsPesquisaServico" <%if (dsPesquisaServico != null) { %>value="<%=dsPesquisaServico %>"<% }%>  size="40" maxlength="40"></td>
    <td><input class="button" type="button" value="Localizar" onClick="javascript: localizar();" /></td>
    <td><input class="button" type="button" value="Nova pesquisa" onClick="javascript: novaPesquisa();" /></td>
  </tr>
  <tr>
    <th class="label">Status</th>
    <td class="label_radio">
      <input type="radio" class="radio" name="status" value="" <%= (status.equals("")? "checked": "") %>>Todos
      <input type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Ativo
      <input type="radio" class="radio" name="status" value="I" <%= (status.equals("I")? "checked": "") %>>Inativo</td>
  </tr>
</table>
<hr>
<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr>
      <th class="grid">&nbsp;</th>
      <th class="grid"><center>Descrição do Tipo de Conta</center></th>
      <th class="grid">Preço</th>
      <th class="grid">Status</th>
      <th class="grid">Excluir</th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
String msgStatus = "";
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	ListaServico listaServico = (ListaServico) it.next();
	if(listaServico.getStatus().equalsIgnoreCase("I")){
		msgStatus = "INATIVO";
	}else{
		msgStatus = "ATIVO";
	}
    cont++;
%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid"><center><a href="formListaServico.jsp?acao=atu&idListaServico=<%=listaServico.getIdListaServico() %>"><%=listaServico.getDsListaServico() %> </a></center></td>
      <td class = "grid" width="5%"><center><%=Utilitaria.formatarNumero(listaServico.getPreco(), 2) %></center></td>
      <td class = "grid" width="5%"><center><%=msgStatus%></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=listaServico.getIdListaServico() %>);"><img border = "0" src="../images/delete.gif"></a></center></td>
  	</tr>
<%
}
%>   
</table>
</form>
<p align="right">|<a class="button" href="formTipoConta.jsp?acao=inc">Novo Cadastro</a>|