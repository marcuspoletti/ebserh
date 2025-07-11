<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>

<%@page import="afero.model.ConfigServico"%>
<%@page import="afero.model.OrdemServicoObjeto" %>
<%@ page import="afero.model.ListaObjeto" %>

<%@page import="afero.persistence.OrdemServicoObjetoDAO" %>
<%@page import="afero.persistence.ConfigServicoDAO"%>
<%@ page import="afero.persistence.ListaObjetoDAO" %>

<%@ page import="afero.util.Utilitaria" %>
<%@ page import="afero.util.ConverteDate" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script>

//Depois ver...
function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.dsPesquisaObjeto.value = '';
  document.all.dsCmpOb1.value = '';
  document.all.dsCmpOb2.value = '';
  document.all.dsCmpOb3.value = '';
  document.all.dsCmpOb4.value = '';
  document.all.status.value = ''; //não está limpando
  document.forms[0].submit();
}  

function addPd(){
	window.opener.location.reload();
	self.close();
}
</script>
<%
ListaObjetoDAO dao;
ConfigServicoDAO daoConfig;
ConfigServico configServico;
OrdemServicoObjetoDAO daoObjeto;
OrdemServicoObjetoDAO daoExclusao;
String acao = request.getParameter("acao");
if (acao == null) acao = "listar";
String dsPesquisaObjeto = request.getParameter("dsPesquisaObjeto");
String dsCmpOb1 = request.getParameter("dsCmpOb1");
String dsCmpOb2 = request.getParameter("dsCmpOb2");
String dsCmpOb3 = request.getParameter("dsCmpOb3");
String dsCmpOb4 = request.getParameter("dsCmpOb4");
String status = request.getParameter("status");
if(status == null)status = "";
String idOrdemServico = request.getParameter("idOrdemServico");
int idLoja = Integer.parseInt((String)session.getAttribute("idLoja"));

String clausula = "";


String idOrdemServicoObjeto = null;
//IdOrdemServico
String idListaObjeto = null;
String campo1 = null;
String campo2 = null;
String campo3 = null;
String campo4 = null;
String observacao = null;
String dtGarantia = null;
String nrControle = null;
String dtMod = null;
String usuario = (String)session.getAttribute("Login");

if (acao.equalsIgnoreCase("incObj") || acao.equalsIgnoreCase("atuObj") || acao.equalsIgnoreCase("exc")) {
	
	idOrdemServicoObjeto = request.getParameter("idOrdemServicoObjeto");
	idOrdemServico = request.getParameter("idOrdemServico");
	idListaObjeto = request.getParameter("idListaObjeto");
	campo1 = request.getParameter("campo1");
	campo2 = request.getParameter("campo2");
	campo3 = request.getParameter("campo3");
	campo4 = request.getParameter("campo4");
	observacao = request.getParameter("observacao");
	dtGarantia = request.getParameter("dtGarantia");
	nrControle = request.getParameter("nrControle");
	dtMod = request.getParameter("dtMod");
	
	if(idOrdemServicoObjeto == null) idOrdemServicoObjeto = "0";
	if(idOrdemServico == null) idOrdemServico = "0";
	if(idListaObjeto == null) idListaObjeto = "0";
	if(campo1 == null) campo1 = "";
	if(campo2 == null) campo2 = "";
	if(campo3 == null) campo3 = "";
	if(campo4 == null) campo4 = "";
	if(observacao == null) observacao = "";
	if(dtGarantia == null) dtGarantia = "";
	if(nrControle == null) nrControle = "";
	if(dtMod == null) dtMod = "";

	OrdemServicoObjeto ordemServicoObjeto = new OrdemServicoObjeto();
  
	try {
	  if (!acao.equalsIgnoreCase("inc")){
		  ordemServicoObjeto.setIdOrdemServicoObjeto(Integer.parseInt(idOrdemServicoObjeto));
	  }
	  
	  	ordemServicoObjeto.setIdOrdemServicoObjeto(Integer.parseInt(idOrdemServicoObjeto));
	  	ordemServicoObjeto.setIdOrdemServico(Integer.parseInt(idOrdemServico));
	  	ordemServicoObjeto.setIdListaObjeto(Integer.parseInt(idListaObjeto));
	  	ordemServicoObjeto.setCampo1(campo1);
	  	ordemServicoObjeto.setCampo2(campo2);
	  	ordemServicoObjeto.setCampo3(campo3);
	  	ordemServicoObjeto.setCampo4(campo4);
	  	ordemServicoObjeto.setObservacao(observacao);
	  	if(dtGarantia != ""){
	  		ordemServicoObjeto.setDtGarantia(ConverteDate.stringToDate(dtGarantia));
	  	}
	  	ordemServicoObjeto.setNrControle(Integer.parseInt(nrControle));
	  	if(dtMod != ""){
	  		ordemServicoObjeto.setDtMod(ConverteDate.stringToDate(dtMod));
	  	}
	  	ordemServicoObjeto.setUsuario(usuario);
	  		  	
      if (!acao.equalsIgnoreCase("exc")){
    	 ordemServicoObjeto.setIdOrdemServicoObjeto(Integer.parseInt(idOrdemServicoObjeto));
      }      
      
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}

	daoObjeto = new OrdemServicoObjetoDAO(conn);
	daoExclusao = new OrdemServicoObjetoDAO(conn);

  if (acao.equalsIgnoreCase("incObj")) {  
	  //inclui no banco de dados
  	daoObjeto.incluir(ordemServicoObjeto);
  	%>
	  <script language="javascript">addPd();</script>
	<%
  } else if (acao.equalsIgnoreCase("atuObj")) {
	  //atualiza no banco de dados
    	 daoObjeto.atualiza(ordemServicoObjeto);
	  %>
	  	<script language="javascript">addPd();</script>
	  <%	  
  }
}

if(dsPesquisaObjeto != null){
	clausula += " WHERE dsListaObjeto like '"+dsPesquisaObjeto+"%' AND idLoja = "+idLoja;
}else {
	clausula += " WHERE idLoja = "+idLoja;
}

if(dsCmpOb1 != null){
	clausula += " AND campo1 like '"+dsCmpOb1+"%'";
}
if(dsCmpOb2 != null){
	clausula += " AND campo2 like '"+dsCmpOb2+"%'";
}
if(dsCmpOb3 != null){
	clausula += " AND campo3 like '"+dsCmpOb3+"%'";
}
if(dsCmpOb4 != null){
	clausula += " AND campo4 like '"+dsCmpOb4+"%'";
}
if(status != null && status != ""){
	clausula += " AND status = '"+status+"'";
}
//seleciona todos os registros do banco de dados
List list;
dao = new ListaObjetoDAO(conn);
clausula = clausula +" ORDER BY idLoja ";
list = dao.listarObjetos(clausula);
int cont = 0;

//CAMPOS de CONFIG SERVICO
daoConfig = new ConfigServicoDAO(conn);
configServico = new ConfigServico();
configServico = daoConfig.procurarConfigServico(" WHERE idLoja = "+idLoja);


if(!acao.equalsIgnoreCase("atuObj") && (!acao.equalsIgnoreCase("incObj"))){
%>
<h1 class="cabecalho_pagina">Lista de Objeto</h1>
<body onload="document.forms[0].elements[0].focus();" >
<form action="consultarOrdemServicoObjeto.jsp">
<input type="hidden" name="idOrdemServico" value="<%=idOrdemServico%>"/>
<input type="hidden" name="acao" value="<%=acao%>"/>
<hr>
<table colspan="2">
   <tr>
    <th class='label'>Descrição Objeto</th>
    <td><input type="text" name="dsPesquisaObjeto" <%if (dsPesquisaObjeto != null) { %>value="<%=dsPesquisaObjeto %>"<% }%>  size="40" maxlength="40"></td>
  </tr>
  <tr>
		<%if(!configServico.getDsCmpOb1().equalsIgnoreCase("")){ %>
			<th class="grid"><%=configServico.getDsCmpOb1() %></th>
			<td><input type="text" name="dsCmpOb1" <%if (dsCmpOb1 != null) { %>value="<%=dsCmpOb1 %>"<% }%>  size="40" maxlength="40"></td>
		<%} %>
 </tr>
 <tr>
		<%if(!configServico.getDsCmpOb2().equalsIgnoreCase("")){ %>
			<th class="grid"><%=configServico.getDsCmpOb2() %></th>
			<td><input type="text" name="dsCmpOb2" <%if (dsCmpOb2 != null) { %>value="<%=dsCmpOb2 %>"<% }%>  size="40" maxlength="40"></td>
		<%} %>
 </tr>
 <tr>
		<%if(!configServico.getDsCmpOb3().equalsIgnoreCase("")){ %>
			<th class="grid"><%=configServico.getDsCmpOb3() %></th>
			<td><input type="text" name="dsCmpOb3" <%if (dsCmpOb3 != null) { %>value="<%=dsCmpOb3 %>"<% }%>  size="40" maxlength="40"></td>
		<%} %>
</tr>
<tr>
		<%if(!configServico.getDsCmpOb4().equalsIgnoreCase("")){ %>
			<th class="grid"><%=configServico.getDsCmpOb4() %></th>
			<td><input type="text" name="dsCmpOb4" <%if (dsCmpOb4 != null) { %>value="<%=dsCmpOb4 %>"<% }%>  size="40" maxlength="40"></td>
		<%} %>
</tr>
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

<table border="0" width="100%">
	<tr>
	         <th class="grid"><%="Adic."%></th>
		<%if(!configServico.getDsCmpOb1().equalsIgnoreCase("")){ %>
			<th class="grid"><%=configServico.getDsCmpOb1() %></th>
		<%} %>
		<%if(!configServico.getDsCmpOb2().equalsIgnoreCase("")){ %>
			<th class="grid"><%=configServico.getDsCmpOb2() %></th>
		<%} %>
		<%if(!configServico.getDsCmpOb3().equalsIgnoreCase("")){ %>
			<th class="grid"><%=configServico.getDsCmpOb3() %></th>
		<%} %>
		<%if(!configServico.getDsCmpOb4().equalsIgnoreCase("")){ %>
			<th class="grid"><%=configServico.getDsCmpOb4() %></th>
		<%} %>
	</tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
String msgStatus = "";
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	ListaObjeto listaObjeto = (ListaObjeto) it.next();
    cont++;
%>
	<tr>
		<td class="grid"><a href="formOrdemServicoObjeto.jsp?acao=<%=acao %>&idOrdemServico=<%=idOrdemServico %>&idListaObjeto=<%=listaObjeto.getIdListaObjeto() %>"><img border = "0" src="../images/soma.jpg"></a></td>
		<%if(!configServico.getDsCmpOb1().equalsIgnoreCase("")){ %>
			<td class="grid"><%=listaObjeto.getCampo1() %></td>
		<%} %>
		<%if(!configServico.getDsCmpOb2().equalsIgnoreCase("")){ %>
			<td class="grid"><%=listaObjeto.getCampo2() %></td>
		<%} %>
		<%if(!configServico.getDsCmpOb3().equalsIgnoreCase("")){ %>
			<td class="grid"><%=listaObjeto.getCampo3() %></td>
		<%} %>
		<%if(!configServico.getDsCmpOb4().equalsIgnoreCase("")){ %>
			<td class="grid"><%=listaObjeto.getCampo4() %></td>
		<%} %>
	</tr>
<%}
}%>
</table>
</form>
</body>