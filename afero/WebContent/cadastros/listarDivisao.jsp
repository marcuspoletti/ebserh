<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.Grupo" %>
<%@ page import="afero.model.SubGrupo" %>
<%@ page import="afero.model.Divisao" %>
<%@ page import="afero.persistence.GrupoDAO" %>
<%@ page import="afero.persistence.SubGrupoDAO" %>
<%@ page import="afero.persistence.DivisaoDAO" %>
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
       location.href = 'listarDivisao.jsp?acao=exc&idDivisao=' + id;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.nomeDivisao.value = '';
  document.all.status.value = ''; //não está limpando
  document.forms[0].submit();
}  
</script>

<%
DivisaoDAO dao;
DivisaoDAO daoExclusao;
SubGrupoDAO dao1;
GrupoDAO dao2;
ConverteDate conDate = new ConverteDate();
String mensagem = request.getParameter("mensagem");
if(mensagem == null)mensagem = "";
String acao = request.getParameter("acao");
if (acao == null) acao = "listar";

String dsDivisao = "";
String status ="A";
String dtCad = "";
String dtMod = "";
String nomeDivisao = "";
String clausula = "";
String idDivisao = "";
String idSubGrupo = "";
String idGrupo = "";
String usuario = (String) session.getAttribute("Login");

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
	
	idDivisao = request.getParameter("idDivisao");
	dsDivisao = request.getParameter("dsDivisao");
    status =request.getParameter("status");
    nomeDivisao = request.getParameter("nomeDivisao");
    idSubGrupo = request.getParameter("idSubGrupo");
    idGrupo = request.getParameter("idGrupo");
    if(idDivisao == null)idDivisao = "0";
    if(dsDivisao == null)dsDivisao = "";
    if(status == null)status = "A";
    if(nomeDivisao == null)nomeDivisao ="";
    if(idSubGrupo == null)idSubGrupo = "";
    if(idGrupo == null)idGrupo = "0";
    Divisao divisao = new Divisao();
  
	try {
	  if (!acao.equalsIgnoreCase("inc")){
		  divisao.setIdDivisao(Integer.parseInt(idDivisao));
	  }
	  
      divisao.setDsDivisao(dsDivisao);
      divisao.setStatus(status);
      divisao.setUsuario(usuario);
      if (!acao.equalsIgnoreCase("exc")){
       	  divisao.setIdGrupo(Integer.parseInt(idGrupo)); 
          divisao.setIdSubGrupo(Integer.parseInt(idSubGrupo));
      }
      
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}


  dao = new DivisaoDAO(conn);
  daoExclusao = new DivisaoDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {
	 
	  
	  //inclui no banco de dados
  	dao.incluir(divisao);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
     if(!dao.AtualizarIdDivisao(Integer.parseInt(idDivisao),Integer.parseInt(idGrupo),Integer.parseInt(idSubGrupo))){
    	 dao.atualizar(divisao);
     }else{
    	response.sendRedirect("listarDivisao.jsp?mensagem=Atualização Inválida! Item já possui lançamentos.&acao=listar");	
     }
	 	 

  } else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  if(!daoExclusao.exclusaoIdDivisao(Integer.parseInt(idDivisao))){
		  dao.excluir(divisao);
	  }else{
		  response.sendRedirect("listarDivisao.jsp?mensagem=Exclusão Inválida! Item já possui lançamentos.&acao=listar");
	  }
	  
  }
} else {
 if (!acao.equalsIgnoreCase("voltar")) {
    nomeDivisao = request.getParameter("nomeDivisao");
    status = request.getParameter("status");
    if (status == null) status = "";
  }

  if (nomeDivisao!= null) {
    clausula = " WHERE dsDivisao LIKE '"+nomeDivisao+"%'";
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
dao = new DivisaoDAO(conn);
clausula = clausula+" ORDER BY idGrupo, idsubGrupo, dsDivisao ";
list = dao.listarDivisao(clausula);

int cont = 0;
%>
<h1 class="cabecalho_pagina">Cadastro de Divisão</h1>

|<a class="button" href="formDivisao.jsp?acao=inc">Novo Cadastro</a>|<br>

<body onload="document.forms[0].elements[0].focus();" >
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<form action="listarDivisao.jsp">
<table colspan="2">
  <tr>
    <th class='label'>Descrição da Divisão</th>
    <td><input type="text" name="nomeDivisao" <%if (nomeDivisao != null) { %>value="<%=nomeDivisao %>"<% }%>  size="40" maxlength="40"></td>
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
      <th class="grid"><center>Descrição da Divisão</center></th>
      <th class="grid"><center>Descrição do Grupo / Subgrupo</center></th>
      <th class="grid">Status</th>
      <th class="grid">Excluir</th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	Divisao divisao = (Divisao) it.next();
  dao1 = new SubGrupoDAO(conn);
	SubGrupo subGrupo = dao1.procurarSubGrupo(divisao.getIdSubGrupo());
  dao2 = new GrupoDAO(conn);
	Grupo grupo = dao2.procurarGrupo(subGrupo.getIdGrupo());
	cont++;

%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid"><center><a href="formDivisao.jsp?acao=atu&idDivisao=<%=divisao.getIdDivisao()%>"><%=divisao.getDsDivisao()%> </a></center></td>
      <td class = "grid"><center><%=grupo.getDsGrupo()+" / "+subGrupo.getDsSubGrupo()%></center></td>
      <td class = "grid" width="5%"><center><%=divisao.getStatus()%></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=divisao.getIdDivisao()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
  	</tr>
<%
}
%>   
</table>
</form>
<p align="right">|<a class="button" href="formDivisao.jsp?acao=inc">Novo Cadastro</a>|
<%@include file="../fimConexao.jsp"%>