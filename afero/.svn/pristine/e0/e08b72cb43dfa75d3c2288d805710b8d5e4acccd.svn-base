<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.EntidadeEndereco" %>
<%@ page import="afero.persistence.EntidadeEnderecoDAO" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function salvar() {
  if (document.all.dsEndereco.value == '') {
    window.alert("O campo Endereço é obrigatório.");
    document.all.dsEndereco.focus();
   } else {
  	document.forms[0].submit();
  }
}

function cancelar() {
  document.forms[0].action="formEntidadeEnderecoSimplificado.jsp";
  document.forms[0].submit();
}

function voltar(cdEntidade) {
  document.forms[0].action = 'listarEntidadeEnderecoSimplificado.jsp?acao=voltar&cdEntidade='+cdEntidade;
	document.forms[0].submit();
}  

function comboSelect(combo, key) {
  var err = window.onerror; 
  window.onerror = new Function('return true'); 
  if (!combo) return; 
  combo.selectedIndex=-1; 
  for (var i = 0; i < combo.options.length; i++) {
    if (combo.multiple) {
      combo.options[i].selected=((","+key+",").indexOf(","+combo.options[i].value+",") != -1); 
    } else {
      combo.options[i].selected=(combo.options[i].value == key);
    }
  }
  window.onerror = err;
}  
</script>
</head>
<%
//variáveis capturadas da página listarEntidadeEnderecoSimplificado.jsp
String acao = request.getParameter("acao");
String cdEntidade = request.getParameter("cdEntidade");
String idEntidadeEndereco = request.getParameter("idEntidadeEndereco");
String selectAba = request.getParameter("selectAba");
String acaoAnterior = request.getParameter("acaoAnterior");
if (acao == null) acao = "inc";
if (cdEntidade == null) cdEntidade = "";
if (idEntidadeEndereco == null) idEntidadeEndereco = "";
if (selectAba == null) selectAba = "1";
if (acaoAnterior == null) acaoAnterior = "atu";

String tpInsc = request.getParameter("tpInsc");
if (tpInsc == null) tpInsc = "F";
int cdTipoEndereco;
if (!tpInsc.equals("F")) cdTipoEndereco = 1; else cdTipoEndereco = 3;
int cdTipoLogradouro = 34;
int idCidade = 1;
String dsEndereco = "";
String nroEndereco = "";
String cmpEndereco = "";
String baiEndereco = "";
String cepEndereco = "";
String cxpEndereco = "";
String refEndereco = "";
String enderecoPadrao ="N";

String mensagem = request.getParameter("mensagem");

//verifica se acao foi atualizar
if (acao.equalsIgnoreCase("atu")) {
  EntidadeEnderecoDAO dao = new EntidadeEnderecoDAO(conn);
  EntidadeEndereco entidadeEndereco = dao.procurarEntidadeEndereco(Integer.parseInt(idEntidadeEndereco));
  cdEntidade = String.valueOf(entidadeEndereco.getCdEntidade());
  cdTipoEndereco = entidadeEndereco.getCdTipoEndereco();
  cdTipoLogradouro = entidadeEndereco.getCdTipoLogradouro();
  idCidade = entidadeEndereco.getIdCidade();
	dsEndereco  = entidadeEndereco.getDsEndereco();
	nroEndereco  = entidadeEndereco.getNroEndereco();
	cmpEndereco  = entidadeEndereco.getCmpEndereco();
	baiEndereco  = entidadeEndereco.getBaiEndereco();
	cepEndereco  = entidadeEndereco.getCepEndereco();
	cxpEndereco  = entidadeEndereco.getCxpEndereco();
	refEndereco  = entidadeEndereco.getRefEndereco();
	enderecoPadrao = entidadeEndereco.getPadrao();
}
%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Endereço - Entidade</h1>
<hr><% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<form method="post" action="listarEntidadeEnderecoSimplificado.jsp?cdEntidade=<%=cdEntidade%>&acao=<%=acao%>&idEntidadeEndereco=<%=idEntidadeEndereco%>&acaoAnterior=<%=acaoAnterior%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="cdEntidade" value="<%=cdEntidade%>"/>
<input type="hidden" name="idEntidadeEndereco" value="<%=idEntidadeEndereco%>"/>
<input type="hidden" name="selectAba" value="<%=selectAba%>"/>
<input type="hidden" name="acaoAnterior" value="<%=acaoAnterior%>"/>

<table border="0" width="100%">
  <tr>
    <th class="label">Tipo Endereço</th>
    <td><select name="cdTipoEndereco" style="width: 172px">
        <option value='1'>Selecione...</option>
        <%@include file="../WEB-INF/jspf/combo/comboTipoEndereco.jspf" %></select>
        <script>comboSelect(document.forms[0].cdTipoEndereco, '<%= cdTipoEndereco %>');</script>
    </td>
  </tr>
  <tr>
    <th class="label">Tipo Logradouro</th>
    <td><select name="cdTipoLogradouro" style="width: 172px">
        <option value='1'>Selecione...</option>
        <%@include file="../WEB-INF/jspf/combo/comboTipoLogradouro.jspf" %></select>
        <script>comboSelect(document.forms[0].cdTipoLogradouro, '<%= cdTipoLogradouro %>');</script>
    </td>
  </tr>
  <tr>
    <th class="label">Endereço*</th>
    <td><input type="text" id="dsEndereco" name="dsEndereco" <%if (dsEndereco != null) { %>value="<%=dsEndereco%>"<% }%>  size="40" maxlength="40"></td>
  </tr>
  <tr>
    <th class="label">Número</th>
    <td><input type="text" id="nroEndereco" name="nroEndereco" <%if (nroEndereco != null) { %>value="<%=nroEndereco%>"<% }%>  size="5" maxlength="5"></td>
  </tr>
  <tr>
    <th class="label">Complemento</th>
    <td><input type="text" id="cmpEndereco" name="cmpEndereco" <%if (cmpEndereco != null) { %>value="<%=cmpEndereco%>"<% }%>  size="40" maxlength="40"></td>
  </tr>
  <tr>
    <th class="label">Bairro</th>
    <td><input type="text" id="baiEndereco" name="baiEndereco" <%if (baiEndereco != null) { %>value="<%=baiEndereco%>"<% }%>  size="40" maxlength="40"></td>
  </tr>
  <tr>
    <th class="label">CEP</th>
    <td><input type="text" id="cepEndereco" name="cepEndereco" <%if (cepEndereco != null) { %>value="<%=cepEndereco%>"<% }%>  size="10" maxlength="10"></td>
  </tr>
  <tr>
    <th class="label">Cidade</th>
    <td><select name="idCidade" style="width: 172px">
        <option value='1'>Selecione...</option>
        <%@include file="../WEB-INF/jspf/combo/comboCidade.jspf" %></select>
        <script>comboSelect(document.forms[0].idCidade, '<%= idCidade %>');</script>
    </td>
  </tr>
  <tr>
    <th class="label">Caixa Postal</th>
    <td><input type="text" id="cxpEndereco" name="cxpEndereco" <%if (cxpEndereco != null) { %>value="<%=cxpEndereco%>"<% }%>  size="10" maxlength="10"></td>
  </tr>
  <tr>
    <th class="label">Referência</th>
    <td><input type="text" id="refEndereco" name="refEndereco" <%if (refEndereco != null) { %>value="<%=refEndereco%>"<% }%>  size="50" maxlength="50"></td>
  </tr>
  <tr>
    <th class="label">Padrão</th>
      <td class="label_radio"><input type="radio" class="radio" name="enderecoPadrao" value="S" <%= (enderecoPadrao.equals("S")? "checked": "") %>>Sim
      <input type="radio" class="radio" name="enderecoPadrao" value="N" <%= (enderecoPadrao.equals("N")? "checked": "") %>>Não</td>    
  </tr>
</table><hr>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
	<td><input class="button" type="button" value="Salvar" onClick="javascript: salvar();" />
	<input class="button" type="button" value="Cancelar" onClick="javascript: cancelar();" />
	<input class="button" type="button" value="Voltar" onClick="javascript:history.go(-1);" /></td>
	<td class="campo_obrigatorio">* Campos Obrigatórios</td>
</tr>
</table>
</form>
<%@include file="../fimConexao.jsp"%>

</body>
</html>