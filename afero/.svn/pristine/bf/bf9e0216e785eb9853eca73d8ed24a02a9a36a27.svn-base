<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.ListaObjeto" %>
<%@ page import="afero.model.Loja" %>
<%@ page import="afero.model.ConfigServico" %>
<%@ page import="afero.persistence.ListaObjetoDAO" %>
<%@ page import="afero.persistence.ConfigServicoDAO" %>
<%@ page import="afero.persistence.LojaDAO" %>
<%@ page import="afero.util.Utilitaria" %>

<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function confirmaExcluir(cont, id) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarListaObjeto.jsp?acao=exc&idListaObjeto=' + id;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.dsPesquisaObjeto.value = '';
  document.all.pesCampo1.value = '';
  document.all.pesCampo2.value = '';
  document.all.pesCampo3.value = '';
  document.all.pesCampo4.value = '';
  document.all.status.value = ''; //não está limpando
  document.forms[0].submit();
}  
</script>

<%
ListaObjetoDAO dao;
ListaObjetoDAO daoExclusao;
LojaDAO lojaDAO = null;
Loja buscaLoja = null;

String mensagem = request.getParameter("mensagem");
if(mensagem == null)mensagem = "";
String acao = request.getParameter("acao");
if (acao == null) acao = "listar";

String clausula = " ORDER BY idLoja";

String dsPesquisaObjeto = request.getParameter("dsPesquisaObjeto");
String pesCampo1 = request.getParameter("pesCampo1");
String pesCampo2 = request.getParameter("pesCampo2");
String pesCampo3 = request.getParameter("pesCampo3");
String pesCampo4 = request.getParameter("pesCampo4");
int idLojaPesquisa = Integer.parseInt((String)session.getAttribute("idLoja"));
int a = 3;
if(idLojaPesquisa != 0){
	//idLojaPesquisa = Integer.parseInt(cdLojaPesquisa);
	a = idLojaPesquisa;//Integer.parseInt(cdLojaPesquisa);
}

String idListaObjeto;
int idLoja = Integer.parseInt((String)session.getAttribute("idLoja"));
String dsListaObjeto;
String campo1;
String campo2;
String campo3;
String campo4;
String status = "";

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
	
	idListaObjeto = request.getParameter("idListaObjeto");
	dsListaObjeto = request.getParameter("dsListaObjeto");
	campo1 = request.getParameter("campo1");
	campo2 = request.getParameter("campo2");
	campo3 = request.getParameter("campo3");
	campo4 = request.getParameter("campo4");
	status = request.getParameter("status");
	
	if(idListaObjeto == null) idListaObjeto = "0";
	if(dsListaObjeto == null) dsListaObjeto = "";
	if(campo1 == null) campo1 = "";
	if(campo2 == null) campo2 = "";
	if(campo3 == null) campo3 = "";
	if(campo4 == null) campo4 = "";
	if(status == null) status = "A";

	ListaObjeto listaObjeto = new ListaObjeto();
  
//	try {
	  if (!acao.equalsIgnoreCase("inc")){
		listaObjeto.setIdListaObjeto(Integer.parseInt(idListaObjeto));
	  }
	  
	  	listaObjeto.setIdLoja(idLoja);  
	  	listaObjeto.setDsListaObjeto(dsListaObjeto);
	  	listaObjeto.setCampo1(campo1);
	  	listaObjeto.setCampo2(campo2);
	  	listaObjeto.setCampo3(campo3);
	  	listaObjeto.setCampo4(campo4);
	  	listaObjeto.setStatus(status);
			
	  	
      if (acao.equalsIgnoreCase("exc")){
    	 listaObjeto.setIdListaObjeto(Integer.parseInt(idListaObjeto));
      }      
      
//	} catch (NumberFormatException nfe) {
	//	throw new Exception("Código inválido");
	//}

	dao = new ListaObjetoDAO(conn);
	daoExclusao = new ListaObjetoDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {  
	  //inclui no banco de dados
  	dao.incluir(listaObjeto);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
    	 dao.atualiza(listaObjeto);
  }else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
		  dao.excluir(listaObjeto);
  }
}else{
if(idLojaPesquisa != 0){
 clausula = " WHERE idLoja = "+idLojaPesquisa;
}
 if (!acao.equalsIgnoreCase("voltar")) {
	 dsPesquisaObjeto = request.getParameter("dsPesquisaObjeto");
    status = request.getParameter("status");
    if (status == null) status = "";
  }
 if(dsPesquisaObjeto != null){
	 clausula += " AND dsListaObjeto LIKE '"+dsPesquisaObjeto+"%'";
 }
 if(pesCampo1 != null && pesCampo1.length() > 0){
	 clausula += " AND campo1 LIKE '"+pesCampo1+"%'";
 }
 if(pesCampo2 != null && pesCampo2.length() > 0){
	 clausula += " AND campo2 LIKE '"+pesCampo2+"%'";
 }
 if(pesCampo3 != null && pesCampo3.length() > 0){
	 clausula += " AND campo3 LIKE '"+pesCampo3+"%'";
 }
 if(pesCampo4 != null && pesCampo4.length() > 0){
	 clausula += " AND campo4 LIKE '"+pesCampo4+"%'";
 }
 if (!status.isEmpty()) {
    if (clausula.isEmpty()) {
      clausula = " AND WHERE status='"+status+"'";
    } else {
      clausula = clausula+" AND status='"+status+"'";
    }
  }
}



String msgStatus = "";
String nomeLoja = "";
buscaLoja = new Loja();
lojaDAO = new LojaDAO(conn);

//CAMPOS de CONFIG SERVICO

ConfigServicoDAO daoConfig = new ConfigServicoDAO(conn);
ConfigServico configServico = new ConfigServico();
configServico = daoConfig.procurarConfigServico(" WHERE idLoja = "+idLojaPesquisa);
buscaLoja = lojaDAO.procurarLoja(idLojaPesquisa);
nomeLoja = buscaLoja.getApelido()+" / "+buscaLoja.getRazaoSocial();
%>
<h1 class="cabecalho_pagina">Lista de Veículos</h1>

|<a class="button" href="formListaObjeto.jsp?acao=inc">Novo Cadastro</a>|<br>

<body onload="document.forms[0].elements[0].focus();" >
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<form action="listarListaObjeto.jsp">
<table colspan="2">
  <tr>
    <th class='label'>Descrição</th>
    <td><input type="text" name="dsPesquisaObjeto" <%if (dsPesquisaObjeto != null) { %>value="<%=dsPesquisaObjeto %>"<% }%>  size="40" maxlength="40"></td>
  </tr>
  <%if(configServico.getDsCmpOb1() != null || configServico.getDsCmpOb1() != ""){%>
  <tr>
    <th class='label'><%=configServico.getDsCmpOb1() %></th>
    <td><input type="text" name="pesCampo1" <%if (pesCampo1 != null) { %>value="<%=pesCampo1 %>"<% }%>  size="40" maxlength="40"></td>
  </tr>
  <%} %>
  <%if(configServico.getDsCmpOb2() != null || configServico.getDsCmpOb2() != ""){%>
  <tr>
    <th class='label'><%=configServico.getDsCmpOb2() %></th>
    <td><input type="text" name="pesCampo2" <%if (pesCampo2 != null) { %>value="<%=pesCampo2 %>"<% }%>  size="40" maxlength="40"></td>
  </tr>
   <%} %>
   <%if(configServico.getDsCmpOb3() != null || configServico.getDsCmpOb3() != ""){%>
  <tr>
    <th class='label'><%=configServico.getDsCmpOb3() %></th>
    <td><input type="text" name="pesCampo3" <%if (pesCampo3 != null) { %>value="<%=pesCampo3 %>"<% }%>  size="40" maxlength="40"></td>
  </tr>
  <%} %>
  <%if(configServico.getDsCmpOb4() != null || configServico.getDsCmpOb4() != ""){%>
  <tr>
    <th class='label'><%=configServico.getDsCmpOb4() %></th>
    <td><input type="text" name="pesCampo4" <%if (pesCampo4 != null) { %>value="<%=pesCampo4 %>"<% }%>  size="40" maxlength="40"></td>
  </tr>
  <%} %>
  <tr>
    <th class="label">Status</th>
    <td class="label_radio">
      <input type="radio" class="radio" name="status" value="" <%= (status.equals("")? "checked": "") %>>Todos
      <input type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Ativo
      <input type="radio" class="radio" name="status" value="I" <%= (status.equals("I")? "checked": "") %>>Inativo
    </td>
     <td><input class="button" type="button" value="Localizar" onClick="javascript: localizar();" /></td>
    <td><input class="button" type="button" value="Nova pesquisa" onClick="javascript: novaPesquisa();" /></td>
  </tr>

</table>
<hr>

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
	<tr>
		<th class="grid" colspan="7"><%=nomeLoja %></th>
	</tr>
	<%if(configServico != null){ %>
	<tr>
	
		<th class="grid">&nbsp;</th>
		<th class="grid"><center><%=configServico.getDsCmpOb1() %></center></th>
		<th class="grid"><center><%=configServico.getDsCmpOb2() %></center></th>
		<th class="grid"><center><%=configServico.getDsCmpOb3() %></center></th>
		<th class="grid"><center><%=configServico.getDsCmpOb4() %></center></th>
		<th class="grid">Status</th>
		<th class="grid">Excluir</th>
	</tr>
	<%}%>
<%
	//seleciona todos os registros do banco de dados
	List objetoList;
	dao = new ListaObjetoDAO(conn);
	String clausulaObjeto = "";
	int cont = 0;
	
	
	objetoList = dao.listarObjetos(clausula);
	
	for ( Iterator itObjeto = objetoList.iterator(); itObjeto.hasNext(); ) {
		ListaObjeto listaObjeto = (ListaObjeto) itObjeto.next();
		if(listaObjeto.getStatus().equalsIgnoreCase("I")){
			msgStatus = "INATIVO";
		}else{
			msgStatus = "ATIVO";
		}
		cont++;
	%>
	
	<tr>
		<td class = "grid" width="2%"><center><%=cont%></center></td>
		<%if(!configServico.getDsCmpOb1().equalsIgnoreCase("")){ %>
			<td class="grid"><center><a href="formListaObjeto.jsp?acao=atu&idListaObjeto=<%=listaObjeto.getIdListaObjeto() %>" ><%=listaObjeto.getCampo1() %></a></center></td>
		<%} %>
		<%if(!configServico.getDsCmpOb2().equalsIgnoreCase("")){ %>
			<td class="grid"><center><a href="formListaObjeto.jsp?acao=atu&idListaObjeto=<%=listaObjeto.getIdListaObjeto() %>" ><%=listaObjeto.getCampo2() %></a></center></td>
		<%} %>
		<%if(!configServico.getDsCmpOb3().equalsIgnoreCase("")){ %>
			<td class="grid"><center><a href="formListaObjeto.jsp?acao=atu&idListaObjeto=<%=listaObjeto.getIdListaObjeto() %>" ><%=listaObjeto.getCampo3() %></a></center></td>
		<%} %>
		<%if(!configServico.getDsCmpOb4().equalsIgnoreCase("")){ %>
			<td class="grid"><center><a href="formListaObjeto.jsp?acao=atu&idListaObjeto=<%=listaObjeto.getIdListaObjeto() %>" ><%=listaObjeto.getCampo4() %></a></center></td>
		<%} %>
		<td class = "grid" width="5%"><center><%=msgStatus%></center></td>
		<td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=listaObjeto.getIdListaObjeto() %>);"><img border = "0" src="../images/delete.gif"></a></center></td>
	</tr>
	<%}
%>
</table>
</form>
<p align="right">|<a class="button" href="formListaObjeto.jsp?acao=inc">Novo Cadastro</a>|