<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.TipoAtendimento" %>
<%@ page import="afero.persistence.TipoAtendimentoDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function confirmaExcluir(cont, id) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarTipoAtendimento.jsp?acao=exc&cdTipoAtendimento=' + id;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.dsPesquisaAtendimento.value = '';
  document.all.status.value = ''; //não está limpando
  document.forms[0].submit();
}  
</script>

<%
TipoAtendimentoDAO dao;
TipoAtendimentoDAO daoExclusao;

String mensagem = request.getParameter("mensagem");
if(mensagem == null)mensagem = "";
String acao = request.getParameter("acao");
if (acao == null) acao = "listar";
String cdTipoAtendimento = "";
String dsTipoAtendimento = "";
String status = "A";
String clausula = "";

String dsPesquisaAtendimento = request.getParameter("dsPesquisaAtendimento");


if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
	
	cdTipoAtendimento = request.getParameter("cdTipoAtendimento");
	dsTipoAtendimento = request.getParameter("dsTipoAtendimento");
	status = request.getParameter("status");
	
	if(cdTipoAtendimento == null) cdTipoAtendimento = "0";
	if(dsTipoAtendimento == null) dsTipoAtendimento = "";
	if(status == null) status = "A";

	TipoAtendimento tipoAtendimento = new TipoAtendimento();
  
	try {
	  if (!acao.equalsIgnoreCase("inc")){
		  tipoAtendimento.setCdTipoAtendimento(Integer.parseInt(cdTipoAtendimento));
	  }
	  
	  	tipoAtendimento.setDsTipoAtendimento(dsTipoAtendimento);
	  	tipoAtendimento.setStatus(status);
      
      if (!acao.equalsIgnoreCase("exc")){
    	  tipoAtendimento.setCdTipoAtendimento(Integer.parseInt(cdTipoAtendimento));
      }      
      
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}

	dao = new TipoAtendimentoDAO(conn);
	daoExclusao = new TipoAtendimentoDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {  
	  //inclui no banco de dados
  	dao.incluir(tipoAtendimento);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
    	 dao.atualiza(tipoAtendimento);
  }else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
		  dao.excluir(tipoAtendimento);
  }
}else {
 if (!acao.equalsIgnoreCase("voltar")) {
	 dsPesquisaAtendimento = request.getParameter("dsPesquisaAtendimento");
    status = request.getParameter("status");
    if (status == null) status = "";
  }
 if(dsPesquisaAtendimento != null){
	 clausula = " WHERE dsTipoAtendimento LIKE '"+dsPesquisaAtendimento+"%'";
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
dao = new TipoAtendimentoDAO(conn);
clausula = clausula +" ORDER BY dsTipoAtendimento ";
list = dao.listarTipoAtendimento(clausula);
int cont = 0;
%>
<h1 class="cabecalho_pagina">Tipo de Atendimento</h1>

|<a class="button" href="formTipoAtendimento.jsp?acao=inc">Novo Cadastro</a>|<br>

<body onload="document.forms[0].elements[0].focus();" >
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<form action="listarTipoAtendimento.jsp">
<table colspan="2">
  <tr>
    <th class='label'>Descrição Tipo Atendimento</th>
    <td><input type="text" name="dsPesquisaAtendimento" <%if (dsPesquisaAtendimento != null) { %>value="<%=dsPesquisaAtendimento %>"<% }%>  size="40" maxlength="40"></td>
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
      <th class="grid"><center>Descrição</center></th>
      <th class="grid">Status</th>
      <th class="grid">Excluir</th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
String msgStatus = "";
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	TipoAtendimento tipoAtendimento = (TipoAtendimento) it.next();
	if(tipoAtendimento.getStatus().equalsIgnoreCase("I")){
		msgStatus = "INATIVO";
	}else{
		msgStatus = "ATIVO";
	}
    cont++;

%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid"><center><a href="formTipoAtendimento.jsp?acao=atu&cdTipoAtendimento=<%=tipoAtendimento.getCdTipoAtendimento() %>"><%=tipoAtendimento.getDsTipoAtendimento()%> </a></center></td>
      <td class = "grid" width="5%"><center><%=msgStatus%></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=tipoAtendimento.getCdTipoAtendimento() %>);"><img border = "0" src="../images/delete.gif"></a></center></td>
  	</tr>
<%
}
%>   
</table>
</form>
<p align="right">|<a class="button" href="formTipoAtendimento.jsp?acao=inc">Novo Cadastro</a>|
