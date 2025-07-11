<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.ListaObjeto" %>
<%@page import="afero.model.ConfigServico" %>
<%@page import="afero.persistence.ListaObjetoDAO" %>
<%@page import="afero.persistence.ConfigServicoDAO" %>
<%@page import ="java.util.*" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/></script>

<script>
function salvar() {
	if(document.all.dsListaObjeto.value == '') {
		window.alert("O campo Descrição do Objeto é obrigatório.");
		document.all.dsListaObjeto.focus();
	}else {
		document.forms[0].submit();
	}
}

function cancelar() {
  document.forms[0].action="formListaObjeto.jsp";
  document.forms[0].submit();
}

function recarregar(acao) {
  document.forms[0].action='formListaObjeto.jsp?acao='+acao;
  document.forms[0].submit();
}

function voltar() {
  document.forms[0].action = 'listarListaObjeto.jsp?acao=voltar'
	document.forms[0].submit();
}  
</script>
</head>
<%
ConfigServicoDAO daoConfig;
ConfigServico configServico = null;
ListaObjeto listaObjeto = null;

String acao = request.getParameter("acao");
if (acao == null) acao = "inc";

String idListaObjeto = request.getParameter("idListaObjeto");
int idLoja = Integer.parseInt((String)session.getAttribute("idLoja"));
String dsListaObjeto = "";
String campo1 = "";
String campo2 = "";
String campo3 = "";
String campo4 = "";
String status = "A";


if (acao.equalsIgnoreCase("atu")){
	
	ListaObjetoDAO dao = new ListaObjetoDAO(conn);
	listaObjeto = dao.procurarListaObjeto(" WHERE idListaObjeto = " +Integer.parseInt(idListaObjeto)+ ";");
	idLoja = listaObjeto.getIdLoja();
	dsListaObjeto = listaObjeto.getDsListaObjeto();
	campo1 = listaObjeto.getCampo1();
	campo2 = listaObjeto.getCampo2();
	campo3 = listaObjeto.getCampo3();
	campo4 = listaObjeto.getCampo4();
	status = listaObjeto.getStatus();
	
}
daoConfig = new ConfigServicoDAO(conn);
configServico = daoConfig.procurarConfigServico(" WHERE idLoja = "+idLoja);

%>

<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Veículos</h1>
<form method="post" action="listarListaObjeto.jsp?acao=<%=acao%>&idListaObjeto=<%=idListaObjeto%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="idListaObjeto" value="<%=idListaObjeto%>"/>
<input type="hidden" name="idListaObjeto" value="<%=idLoja%>"/>
<table border="0" width="100%">
  
  
  <%if(configServico != null || listaObjeto != null ){ %>
   	
   		<tr>
   			<th class="label"><%=configServico.getDsCmpOb1() %></th>
   			<td><input type="text" id="campo1" name="campo1" <%if (campo1 != null) { %>value="<%=campo1 %>"<% }%>  size="60" maxlength="50"></td>
   		</tr>
   	
   	
   		<tr>
   			<th class="label"><%=configServico.getDsCmpOb2() %></th>
   			<td><input type="text" id="campo2" name="campo2" <%if (campo2 != null) { %>value="<%=campo2 %>"<% }%>  size="60" maxlength="50"></td>
   		</tr>
   
   
   		<tr>
   			<th class="label"><%=configServico.getDsCmpOb3() %></th>
   			<td><input type="text" id="campo3" name="campo3" <%if (campo3 != null) { %>value="<%=campo3 %>"<% }%>  size="60" maxlength="50"></td>
   		</tr>
   
   
   		<tr>
   			<th class="label"><%=configServico.getDsCmpOb4() %></th>
   			<td><input type="text" id="campo4" name="campo4" <%if (campo4 != null) { %>value="<%=campo4 %>"<% }%>  size="60" maxlength="50"></td>
   		</tr>
   
   	<tr>
   		<th class="label">Descrição*</th>
   		<td><textarea  id="dsListaObjeto" name="dsListaObjeto" cols="57" rows="5" maxlength="200"><%=dsListaObjeto%></textarea></td>
   	</tr>
   	<tr>
   		<th class="label">Status</th>
   		<td class="label_radio">
   			<input type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Ativo
   			<input type="radio" class="radio" name="status" value="I" <%= (status.equals("I")? "checked": "") %>>Inativo
   		</td>
   	</tr>
   	<%} %>
</table><hr>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
	<td>
		<input class="button" type="button" value="Salvar" onClick="javascript: salvar();" />
		<input class="button" type="button" value="Cancelar" onClick="javascript: cancelar();" />
		<input class="button" type="button" value="Voltar" onClick="javascript: voltar();" />
	</td>
	<td class="campo_obrigatorio">* Campos Obrigatórios</td>
</tr>

</table>
</form>
<%@include file="../fimConexao.jsp"%>
</body>
</html>