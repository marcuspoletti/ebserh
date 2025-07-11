<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.ListaServico" %>
<%@page import="afero.persistence.ListaServicoDAO" %>
<%@page import="afero.util.ConverteDate" %>
<%@page import="afero.util.Utilitaria" %>
<%@page import="java.util.Date" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/></script>
<script>
function salvar() {
	if (document.all.idLoja.value == 0) {
		window.alert("O campo Loja é obrigatório.");
		document.all.idLoja.focus();
	}else if (document.all.dsListaServico.value == '') {
		window.alert("O campo Descrição do Tarefa é obrigatório.");
		document.all.dsListaServico.focus();
	}else if(document.all.idUnidade.value == '0') {
		window.aler("O Campo Unidade é obrigatório.");
		document.all.idUnidade.focus();
	}else {
		document.forms[0].submit();
	}
}

function cancelar() {
  document.forms[0].action="formListaServico.jsp";
  document.forms[0].submit();
}

function recarregar(acao) {
  document.forms[0].action='formListaServico.jsp?acao='+acao;
  document.forms[0].submit();
}


function voltar() {
  document.forms[0].action = 'listarListaServico.jsp?acao=voltar'
	document.forms[0].submit();
}  
</script>
</head>
<%
String acao = request.getParameter("acao");
String idListaServico = request.getParameter("idListaServico");

if (acao == null) acao = "inc";
if(idListaServico == null) idListaServico = "0";

int idLoja = Integer.parseInt((String)session.getAttribute("idLoja"));
String dsListaServico = "";
int cdListaServico = 0;
float preco = 0;
int idUnidade = 0;
String status = "A";
String usuario = (String) session.getAttribute("Login");

if (acao.equalsIgnoreCase("atu")){
	
	ListaServicoDAO dao = new ListaServicoDAO(conn);
	ListaServico listaServico = dao.procurarListaServico(" WHERE idListaServico = "+Integer.parseInt(idListaServico));
	idLoja = listaServico.getIdLoja();
	dsListaServico = listaServico.getDsListaServico();
	cdListaServico = listaServico.getCdListaServico();
	preco = listaServico.getPreco();
	idUnidade = listaServico.getIdUnidade();
	status = listaServico.getStatus();
	usuario = listaServico.getUsuario();	
}
%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Serviço</h1>
<form method="post" action="listarListaServico.jsp?acao=<%=acao%>&idListaServico=<%=idListaServico%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="idListaServico" value="<%=idListaServico%>"/>
<input type="hidden" name="idLoja" value="<%=idLoja%>"/>

<table border="0" width="100%">
<%--
   <tr>
      <th class="label">Loja*</th>
      <td><select disabled="disabled" name="idLoja" required="true">
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboLoja.jspf"%></select>
          <script>comboSelect(document.forms[0].idLoja, '<%=idLoja %>');</script>
      </td>
  </tr>
   --%>
	<tr>
		<th class="label">Descrição*</th>
		<td><textarea  id="dsListaServico" name="dsListaServico" cols="50" rows="5" maxlength="100"><%=dsListaServico%></textarea></td>
	</tr>
	<tr>
		<th class="label">Código Serviço</th>
		<td><input id="cdListaServico" name="cdListaServico"  size="50" maxlength="100" value="<%=cdListaServico%>"/></td>
	</tr>
	
	<tr>
		<th class="label">Preço</th>
		<td><input type="text" id="preco" name="preco" onkeyup="FormataValor(this,event)" size="50" maxlength="50" value="<%=preco%>"></td>
	</tr>
	<tr>
		<th class="label">Unidade</th>
			<td><select name="idUnidade" required="true">
			<option value='0'>Selecione...</option>
			<%@include file="../WEB-INF/jspf/combo/comboUnidade.jspf"%></select>
			<script>comboSelect(document.forms[0].idUnidade,'<%= idUnidade%>');</script>
		</td>
	</tr>
	<tr>
		<th class="label">Status</th>
		<td class="label_radio">
			<input type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Ativo
			<input type="radio" class="radio" name="status" value="I" <%= (status.equals("I")? "checked": "") %>>Inativo
		</td>
	</tr>
  <%
    if(acao.equalsIgnoreCase("atu")){
   %>
     	<tr>
  	    <th class="label">Registros:</th>
   	 	<td class="label_menor"><center>&nbsp Usuário: <%if (usuario != null) { %><%=usuario%><% }%>&nbsp;</center></td>
  	    
	</tr>
  <%
    }
  %>  
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