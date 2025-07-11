<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="aferopet.model.Medicamento"%>
<%@page import="afero.model.Produto"%>
<%@page import="afero.util.ConverteDate"%>
<%@page import="aferopet.persistence.MedicamentoDAO"%>
<%@page import="afero.persistence.ProdutoDAO"%>
<%@page import ="java.util.*" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/></script>

<script>
function salvar() {
	if(document.all.nmMedicamento.value == '') {
   	window.alert("O campo Nome do Medicamento é obrigatório.");
   	document.all.nmMedicamento.focus();
	}else if (document.all.idGrupoMedicamento.value == '0') {
	    window.alert("O campo Grupo do Medicamento é obrigatório.");
	    document.all.idGrupoMedicamento.focus();
  }else {
  	document.forms[0].submit();
  }
}

function cancelar() {
  document.forms[0].action="formMedicamento.jsp";
  document.forms[0].submit();
}

function recarregar(acao) {
  document.forms[0].action='formMedicamento.jsp?acao='+acao;
  document.forms[0].submit();
}

function voltar() {
  document.forms[0].action = 'listarMedicamento.jsp?acao=voltar'
	document.forms[0].submit();
}  
</script>
</head>
<%
String acao = request.getParameter("acao");
if (acao == null) acao = "inc";
String mensagem = request.getParameter("mensagem");
if (mensagem == null) mensagem = "mensagem";
String usuario =(String)session.getAttribute("Login");
if (usuario == null) usuario = "";
String idMedicamento = request.getParameter("idMedicamento");
if (idMedicamento == null) idMedicamento = "0";
String idGrupoMedicamentoStr = request.getParameter("idGrupoMedicamento");
int idGrupoMedicamento = 0;
if (idGrupoMedicamentoStr != null) {
	idGrupoMedicamento = Integer.parseInt(idGrupoMedicamentoStr);
}
String idProduto = request.getParameter("idProduto");
if(idProduto == null) idProduto = "0";
String nmMedicamento = request.getParameter("nmMedicamento");
if(nmMedicamento == null) nmMedicamento = "";
ConverteDate converte = new ConverteDate();

//String nmMedicamento = "";
String principioAtivo = "";
String apresentacao = "";
String dosePAtivo = "";
String doseApresentacao = "";
String uso = "";
String indicacao = "";
String fabricante = "";
String observacao = "";
String status = "A";
String dtMod = "";
String dtCad = "";
String dsProduto = request.getParameter("dsProduto");

if(dsProduto == null) dsProduto = "";

//verifica se acao foi atualizar
if (acao.equalsIgnoreCase("atu")){
	
	MedicamentoDAO dao = new MedicamentoDAO(conn);
  Medicamento medicamento = dao.procurarMedicamento(Integer.parseInt(idMedicamento));
  if (idGrupoMedicamento == 0) {
  	idGrupoMedicamento = medicamento.getIdGrupoMedicamento();
  }
  if (idProduto.equals("0")) {
	  idProduto = Integer.toString(medicamento.getIdProduto());
  }
  if (nmMedicamento.isEmpty()) {
		nmMedicamento = medicamento.getNmMedicamento();
  }
	principioAtivo = medicamento.getPrincipioAtivo();
	apresentacao = medicamento.getApresentacao();
	dosePAtivo = medicamento.getDosePAtivo();
	doseApresentacao = medicamento.getDoseApresentacao();
	uso = medicamento.getDoseApresentacao();
	indicacao = medicamento.getIndicacao();
	fabricante = medicamento.getFabricante();
	observacao = medicamento.getObservacao();
	status = medicamento.getStatus();
	dtMod = medicamento.getDtMod().toString();
	dtCad = medicamento.getDtCad().toString();
	    	
}
if (!idProduto.equals("0")) {
	ProdutoDAO daoProduto = new ProdutoDAO(conn);
	Produto produto = daoProduto.procurarProduto(Integer.parseInt(idProduto));
	dsProduto = produto.getDsProduto();
	nmMedicamento = produto.getDsProduto();
}

%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Medicamento</h1>
<form method="post" action="listarMedicamento.jsp?acao=<%=acao%>&idMedicamento=<%=idMedicamento%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="usuario" value="<%=usuario%>"/>
<input type="hidden" name="idMedicamento" value="<%=idMedicamento%>">
<input type="hidden" name="idProduto" value="<%=idProduto%>">
<%
	String param = "acao="+acao+
		"&idMedicamento="+idMedicamento+"&idGrupoMedicamento="+idGrupoMedicamento+
		"&nmMedicamento="+nmMedicamento;
%>
<table border="0" width="100%">
  <tr>
    <th class="label">Nome Medicamento*</th>
    <td><input type="text" id="nmMedicamento" name="nmMedicamento" onchange="recarregar('<%=acao%>');"<%if (nmMedicamento != null) { %>value="<%=nmMedicamento%>"<% }%>  size="60" maxlength="50"></td>
  </tr>
  <tr>
      <th class="label">Descrição Produto</th>
      <td><input disabled type="text" name="dsProduto" <%if (dsProduto != null) { %>value="<%=dsProduto%>"<% }%>  size="100" maxlength="100"> <a  href="consultarProduto.jsp?<%=param%>"><img border = "0" src="../images/pesquisa.gif"></a> <font class="campo_obrigatorio">(Integração c/ Estoque)</font></td>
  </tr>
  <tr>
      <th class="label">Grupo Medicamento*</th>
      <td><select name="idGrupoMedicamento" style="width: 172px" onchange="recarregar('<%=acao%>');">
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboGrupoMedicamento.jspf" %></select>
          <script>comboSelect(document.forms[0].idGrupoMedicamento, '<%= idGrupoMedicamento %>');</script>
      </td>
  </tr>
  <tr>
    <th class="label">Princípio Ativo</th>
    <td><input type="text" id="principioAtivo" name="principioAtivo" <%if (principioAtivo != null) { %>value="<%=principioAtivo%>"<% }%>  size="100" maxlength="100"></td>
  </tr>
  <tr>
    <th class="label">Apresentação</th>
    <td><input type="text" id="apresentacao" name="apresentacao" <%if (apresentacao != null) { %>value="<%=apresentacao%>"<% }%>  size="100" maxlength="100"></td>
  </tr>
  <tr>
    <th class="label">Dose P. Ativo</th>
    <td><input type="text" id="dosePAtivo" name="dosePAtivo" <%if (dosePAtivo != null) { %>value="<%=dosePAtivo%>"<% }%>  size="100" maxlength="100"></td>
  </tr>
  <tr>
    <th class="label">Dose Apresentação</th>
    <td><input type="text" id="doseApresentacao" name="doseApresentacao" <%if (doseApresentacao != null) { %>value="<%=doseApresentacao%>"<% }%>  size="100" maxlength="100"></td>
  </tr>
  <tr>
    <th class="label">Uso</th>
    <td><input type="text" id="uso" name="uso" <%if (uso != null) { %>value="<%=uso%>"<% }%>  size="100" maxlength="100"></td>
  </tr>
  <tr>
    <th class="label">Indicação</th>
    <td><input type="text" id="indicacao" name="indicacao" <%if (indicacao != null) { %>value="<%=indicacao%>"<% }%>  size="100" maxlength="100"></td>
  </tr>
  <tr>
    <th class="label">Fabricante</th>
    <td><input type="text" id="fabricante" name="fabricante" <%if (fabricante != null) { %>value="<%=fabricante%>"<% }%>  size="60" maxlength="50"></td>
  </tr>
  <tr>
    <th class="label">Observação</th>
    <td><input type="text" id="observacao" name="observacao" <%if (observacao != null) { %>value="<%=observacao%>"<% }%>  size="100" maxlength="100"></td>
  </tr>
  <tr>
    <th class="label">Ativo</th>
      <td class="label_radio"><input type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Sim
      <input type="radio" class="radio" name="status" value="I" <%= (status.equals("I")? "checked": "") %>>Não</td>    
  </tr>
  <%if(acao.equals("atu")){%>
  
  	<tr>
   	 	<td class="label_menor"><center>&nbsp Registro: <%if (dtCad != null) { %><%=converte.DMYToYMD(dtCad)%><% }%>&nbsp</center></td>
  	    <td class="label_menor"><center>&nbsp Modificação: <%if (dtMod != null) { %><%=converte.DMYToYMD(dtMod)%><% }%>&nbsp</center></td>
	</tr>

  <% }%>
</table><hr>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
	<td><input class="button" type="button" value="Salvar" onClick="javascript: salvar();" />
	<input class="button" type="button" value="Cancelar" onClick="javascript: cancelar();" />
	<input class="button" type="button" value="Voltar" onClick="javascript: voltar();" /></td>
	<td class="campo_obrigatorio">* Campos Obrigatórios</td>
</tr>
</table>
</form>
<%@include file="../fimConexao.jsp"%>
</body>
</html>