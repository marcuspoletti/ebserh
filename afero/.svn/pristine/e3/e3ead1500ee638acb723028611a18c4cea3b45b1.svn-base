<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.TipoFrequencia" %>
<%@ page import="afero.persistence.TipoFrequenciaDAO" %>
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
       location.href = 'listarTipoFrequencia.jsp?acao=exc&cdTipoFrequencia=' + id;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.dsTipoFrequencia.value = '';
  document.all.status.value = ''; //não está limpando
  document.forms[0].submit();
}  
</script>

<%
TipoFrequenciaDAO dao;
TipoFrequenciaDAO daoExclusao;
ConverteDate conDate = new ConverteDate();
String mensagem = request.getParameter("mensagem");
if(mensagem == null)mensagem = "";
String acao = request.getParameter("acao");
if (acao == null) acao = "listar";
String dsTipoFrequencia = "";
String status ="A";
String clausula = "";
String cdTipoFrequencia = "";


if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
	
	cdTipoFrequencia = request.getParameter("cdTipoFrequencia");
	dsTipoFrequencia = request.getParameter("dsTipoFrequencia");
    status =request.getParameter("status");
    if(cdTipoFrequencia == null)cdTipoFrequencia = "0";
    if(dsTipoFrequencia == null)dsTipoFrequencia = "";
    if(status == null)status = "A";
    TipoFrequencia tipoFrequencia = new TipoFrequencia();
  
	try {
	  if (!acao.equalsIgnoreCase("inc")){
		  tipoFrequencia.setCdTipoFrequencia(Integer.parseInt(cdTipoFrequencia));
	  }
	  
	  tipoFrequencia.setDsTipoFrequencia(dsTipoFrequencia);
	  tipoFrequencia.setStatus(status);
      if (!acao.equalsIgnoreCase("exc")){
    	  tipoFrequencia.setCdTipoFrequencia(Integer.parseInt(cdTipoFrequencia)); 
      }
      
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}


  dao = new TipoFrequenciaDAO(conn);
  daoExclusao = new TipoFrequenciaDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {  
	  //inclui no banco de dados
  	dao.incluir(tipoFrequencia);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
    	 dao.atualizar(tipoFrequencia);
  }else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  if(!daoExclusao.exclusaoCdTipoFrequencia(Integer.parseInt(cdTipoFrequencia))){
		  dao.excluir(tipoFrequencia);
	  }else{
		  response.sendRedirect("listarTipoFrequencia.jsp?mensagem=Exclusão Inválida! Item já possui lançamentos.&acao=listar");
	  }
	  
  }
} else {
 if (!acao.equalsIgnoreCase("voltar")) {
	 dsTipoFrequencia = request.getParameter("dsTipoFrequencia");
     status = request.getParameter("status");
     if (status == null) status = "";
  }

  if (dsTipoFrequencia!= null) {
    clausula = " WHERE dsTipoFrequencia LIKE '"+dsTipoFrequencia+"%'";
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
dao = new TipoFrequenciaDAO(conn);
clausula = clausula+" ORDER BY dsTipoFrequencia ";
list = dao.listarTipoFrequencia(clausula);

int cont = 0;
%>
<h1 class="cabecalho_pagina">Cadastro de Tipo de Frequência</h1>

|<a class="button" href="formTipoFrequencia.jsp?acao=inc">Novo Cadastro</a>|<br>

<body onload="document.forms[0].elements[0].focus();" >
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<form action="listarTipoFrequencia.jsp">
<table colspan="2">
  <tr>
    <th class='label'>Descrição Tipo Frequência</th>
    <td><input type="text" name="dsTipoFrequencia" <%if (dsTipoFrequencia != null) { %>value="<%=dsTipoFrequencia %>"<% }%>  size="40" maxlength="40"></td>
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
      <th class="grid"><center>Descrição do Tipo de Frequência</center></th>
      <th class="grid">Status</th>
      <th class="grid">Excluir</th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
String msgStatus = "";
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	TipoFrequencia tipoFrequencia = (TipoFrequencia) it.next();
	if(tipoFrequencia.getStatus().equals("I")){
		msgStatus = "INATIVO";
	}else{
		msgStatus = "ATIVO";
	}
    cont++;

%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid"><center><a href="formTipoFrequencia.jsp?acao=atu&cdTipoFrequencia=<%=tipoFrequencia.getCdTipoFrequencia()%>"><%=tipoFrequencia.getDsTipoFrequencia()%> </a></center></td>
      <td class = "grid" width="5%"><center><%=msgStatus%></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=tipoFrequencia.getCdTipoFrequencia()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
  	</tr>
<%
}
%>   
</table>
</form>
<p align="right">|<a class="button" href="formTipoFrequencia.jsp?acao=inc">Novo Cadastro</a>|