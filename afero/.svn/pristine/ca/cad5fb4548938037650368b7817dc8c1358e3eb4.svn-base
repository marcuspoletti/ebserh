<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.TipoDocumento" %>
<%@ page import="afero.persistence.TipoDocumentoDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Date" %>
<%@ page import="afero.util.ConverteDate" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function confirmaExcluir(cont, id) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarTipoDocumento.jsp?acao=exc&idTipoDocumento=' + id;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.dsTipoDocumento.value = '';
  document.all.status.value = ''; //não está limpando
  document.forms[0].submit();
}  
</script>

<%
TipoDocumentoDAO dao;
TipoDocumentoDAO daoExclusao;
ConverteDate conDate = new ConverteDate();
String mensagem = request.getParameter("mensagem");
if(mensagem == null)mensagem = "";
String acao = request.getParameter("acao");
if (acao == null) acao = "listar";
String dsTipoDocumento = "";
String status          = "A";
String cdTipoDocumento = "";
String clausula = "";
String idTipoDocumento = "";


if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
	
	idTipoDocumento     = request.getParameter("idTipoDocumento");
	dsTipoDocumento     = request.getParameter("dsTipoDocumento");
	status              = request.getParameter("status");
  cdTipoDocumento     = request.getParameter("cdTipoDocumento");
  if(idTipoDocumento == null)  idTipoDocumento = "0";
  if(dsTipoDocumento == null)  dsTipoDocumento = "";
  if(status == null)           status = "A";
  if(cdTipoDocumento == null)cdTipoDocumento ="";
  TipoDocumento tipoDocumento = new TipoDocumento();
  
	try {
	  if (!acao.equalsIgnoreCase("inc")){
		  tipoDocumento.setIdTipoDocumento(Integer.parseInt(idTipoDocumento));
	  }
	  tipoDocumento.setDsTipoDocumento(dsTipoDocumento);
	  tipoDocumento.setCdTipoDocumento(cdTipoDocumento);
    tipoDocumento.setStatus(status);
    if (!acao.equalsIgnoreCase("exc")){
      tipoDocumento.setIdTipoDocumento(Integer.parseInt(idTipoDocumento)); 
    }
      
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}


  dao = new TipoDocumentoDAO(conn);
  daoExclusao = new TipoDocumentoDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {  
	  //inclui no banco de dados
  	dao.incluir(tipoDocumento);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
    	 dao.atualizar(tipoDocumento);
  }else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  if(!daoExclusao.exclusaoIdTipoDocumento(Integer.parseInt(idTipoDocumento))){
		  dao.excluir(tipoDocumento);
	  }else{
		  
		  response.sendRedirect("listarTipoDocumento.jsp?mensagem=Exclusão Inválida! Item já possui lançamentos.&acao=listar");
	  }
	  
  }
} else {
 if (!acao.equalsIgnoreCase("voltar")) {
	  dsTipoDocumento = request.getParameter("dsTipoDocumento");
    status = request.getParameter("status");
    if (status == null) status = "";
  }

  if (dsTipoDocumento!= null) {
    clausula = " WHERE dsTipoDocumento LIKE '"+dsTipoDocumento+"%'";
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
dao = new TipoDocumentoDAO(conn);
clausula = clausula+" ORDER BY dsTipoDocumento ";
list = dao.listarTipoDocumento(clausula);

int cont = 0;
%>
<h1 class="cabecalho_pagina">Cadastro de Tipe de Documento</h1>

|<a class="button" href="formTipoDocumento.jsp?acao=inc">Novo Cadastro</a>|<br>

<body onload="document.forms[0].elements[0].focus();" >
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<form action="listarTipoDocumento.jsp">
<table colspan="2">
  <tr>
    <th class='label'>Descrição Tipo Documento</th>
    <td><input type="text" name="dsTipoDocumento" <%if (dsTipoDocumento != null) { %>value="<%=dsTipoDocumento %>"<% }%>  size="40" maxlength="40"></td>
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
    <tr">
      <th class="grid">&nbsp;</th>
      <th class="grid"><center>Descrição do Tipo de Documento</center></th>
      <th class="grid"><center>Código do Tipo de Documento</center></th>
      <th class="grid">Status</th>
      <th class="grid">Excluir</th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
String msgStatus = "";
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	TipoDocumento tipoDocumento= (TipoDocumento) it.next();
	if(tipoDocumento.getStatus().equals("I")){
		msgStatus = "INATIVO";
	}else{
		msgStatus = "ATIVO";
	}
    cont++;

%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid"><center><a href="formTipoDocumento.jsp?acao=atu&idTipoDocumento=<%=tipoDocumento.getIdTipoDocumento()%>"><%=tipoDocumento.getDsTipoDocumento()%> </a></center></td>
      <td class = "grid"><center><%=tipoDocumento.getCdTipoDocumento()%></center></td>
      <td class = "grid" width="5%"><center><%=msgStatus%></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=tipoDocumento.getIdTipoDocumento()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
  	</tr>
<%
}
%>   
</table>
</form>
<p align="right">|<a class="button" href="formTipoDocumento.jsp?acao=inc">Novo Cadastro</a>|
