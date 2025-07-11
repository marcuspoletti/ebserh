<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.Mesa" %>
<%@ page import="afero.persistence.MesaDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@include file="../../seguranca.jsp"%>
<%@include file="../../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../../css/afero.css" />

<script>
function confirmaExcluir(cont, id) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarMesa.jsp?acao=exc&idMesa=' + id;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.dsMesa.value = '';
  document.all.status.value = ''; //não está limpando
  document.forms[0].submit();
}  
</script>

<%
MesaDAO dao;

String acao = request.getParameter("acao");
if (acao == null) acao = "listar";
String mensagem = request.getParameter("mensagem");
if(mensagem == null) mensagem="";
String dsMesa = "";
String status = "A";
String clausula = "";

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
  String idMesa = request.getParameter("idMesa");
  dsMesa = request.getParameter("dsMesa");
  status = request.getParameter("status");
  if (idMesa == null) idMesa = "";
  if (dsMesa == null) dsMesa = "";
  if (status == null) status = "A";

  Mesa mesa = new Mesa();

	try {
	  if (!acao.equalsIgnoreCase("inc")){
		  mesa.setIdMesa(Integer.parseInt(idMesa));
	  }
	  mesa.setDsMesa(dsMesa);
	  mesa.setStatus(status);
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}

  dao = new MesaDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {
	  //inclui no banco de dados
  	dao.incluir(mesa);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
	  dao.atualizar(mesa);

  } else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  if(!dao.exclusaoIdMesa(Integer.parseInt(idMesa))){
		  dao.excluir(mesa);
	  }else{
		  response.sendRedirect("listarMesa.jsp?mensagem=Exclusão Inválida! Item já possui lançamentos.&acao=listar");
	  }
  }
} else {
  if (!acao.equalsIgnoreCase("voltar")) {
    dsMesa = request.getParameter("dsMesa");
    status = request.getParameter("status");
    if (status == null) status = "";
  }

  if (dsMesa != null) {
    clausula = " WHERE dsMesa LIKE '"+dsMesa+"%'";
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
dao = new MesaDAO(conn);
clausula = clausula+" ORDER BY dsMesa asc";
list = dao.listarMesa(clausula);

int cont = 0;
%>
<h1 class="cabecalho_pagina">Cadastro de Mesa</h1>

|<a class="button" href="formMesa.jsp?acao=inc">Novo Cadastro</a>|<br>
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<body onload="document.forms[0].elements[0].focus();" >
<form action="listarMesa.jsp">
<table colspan="2">
  <tr>
    <th class='label'>Mesa</th>
    <td><input type="text" name="dsMesa" <%if (dsMesa != null) { %>value="<%=dsMesa%>"<% }%>  size="40" maxlength="40"></td>
    <td><input class="button" type="button" value="Localizar" onClick="javascript: localizar();" /></td>
    <td><input class="button" type="button" value="Nova pesquisa" onClick="javascript: novaPesquisa();" /></td>
  </tr>
  <tr>
    <th class="label">Status</th>
    <td class="label_radio">
      <input type="radio" class="radio" name="status" value="" <%= (status.equals("")? "checked": "") %>>Todos
      <input type="radio" class="radio" name="status" value="L" <%= (status.equals("L")? "checked": "") %>>Livre
      <input type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Aberta
      <input type="radio" class="radio" name="status" value="C" <%= (status.equals("C")? "checked": "") %>>Consumindo
      <input type="radio" class="radio" name="status" value="F" <%= (status.equals("F")? "checked": "") %>>Fechada
      <input type="radio" class="radio" name="status" value="R" <%= (status.equals("F")? "checked": "") %>>Reservada
      <input type="radio" class="radio" name="status" value="I" <%= (status.equals("I")? "checked": "") %>>Indisponível</td>
  </tr>
</table>
<hr>

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr>
      <th class="grid">&nbsp;</th>
      <th class="grid"><center>Cód. da Mesa</center></th>
      <th class="grid"><center>Mesa</center></th>
      <th class="grid">Status</th>
      <th class="grid">Excluir</th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
String statusMesa = "";
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	Mesa mesa = (Mesa) it.next();
	if(mesa.getStatus().equalsIgnoreCase("A")){
		statusMesa = "ABERTA";	
	}else if(mesa.getStatus().equalsIgnoreCase("C")){
		statusMesa = "CONSUMINDO";
	}else if(mesa.getStatus().equalsIgnoreCase("F")){
		statusMesa = "FECHADA";
	}else if(mesa.getStatus().equalsIgnoreCase("R")){
		statusMesa = "RESERVADA";
	} if(mesa.getStatus().equalsIgnoreCase("L")){
		statusMesa = "LIVRE";
	}if(mesa.getStatus().equalsIgnoreCase("I")){
		statusMesa = "INDISPONÌVEL";
	}
	cont++;
%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid" width="8%"><center><%=mesa.getIdMesa()%></center></td>
      <td class = "grid"><center><a href="formMesa.jsp?acao=atu&idMesa=<%=mesa.getIdMesa()%>"><%=mesa.getDsMesa()%></a></center></td>
      <td class = "grid" width="5%"><center><%=statusMesa%></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=mesa.getIdMesa()%>);"><img border = "0" src="../../images/delete.gif"></a></center></td>
  	</tr>
<%
}
%>   
</table>
</form>
<%@include file="../../fimConexao.jsp"%>
<p align="right">|<a class="button" href="formMesa.jsp?acao=inc">Novo Cadastro</a>|