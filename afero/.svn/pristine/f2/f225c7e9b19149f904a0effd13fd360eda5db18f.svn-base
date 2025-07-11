<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.Recibo"%>
<%@page import="afero.persistence.ReciboDAO"%>
<%@page import="afero.util.Utilitaria"%>
<%@page import="afero.util.ConverteDate"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<link type="text/css" rel="Stylesheet" href="../css/abas.css" />
<script language=JavaScript src="../js/abas.js" type=text/javascript></script>
<script src="../js/common.js" /></script>
<script>
function voltar() {
  document.forms[0].action = 'listarRecibo.jsp?acao=voltar';
	document.forms[0].submit();
}
</script>
</head>
<%
ConverteDate converte = new ConverteDate();
String acao = request.getParameter("acao");
String idRecibo = request.getParameter("idRecibo");

if (acao == null) acao = "inc";
if (idRecibo == null) idRecibo = "";

int idLoja = 0;
int cdEntidade = 0;
String favorecido = "";
double valor = 0;
String referente = "";
String observacao = "";
String emitente = "";
String endereco = "";
String cpfCnpj = "";
String cidade = "";
String dtEmissao = null;
String usuario = "";

//verifica se acao foi atualizar
if (acao.equalsIgnoreCase("atu")) {
  ReciboDAO dao = new ReciboDAO(conn);
  Recibo recibo = dao.procurarRecibo(Integer.parseInt(idRecibo));
  idLoja = recibo.getIdLoja();
  cdEntidade = recibo.getCdEntidade();
  favorecido = recibo.getFavorecido();
  valor = recibo.getValor();
  referente = recibo.getReferente();
  observacao = recibo.getObservacao();
  emitente = recibo.getEmitente();
  endereco = recibo.getEndereco();
  cpfCnpj = recibo.getCpfCnpj();
  cidade = recibo.getCidade();
  dtEmissao = converte.DMYToYMD(recibo.getDtEmissao().toString());
  usuario = recibo.getUsuario();
	 
}
%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Recibo</h1>
<form method="post" action="listarRecibo.jsp?acao=<%=acao%>&idRecibo=<%=idRecibo%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="idRecibo" value="<%=idRecibo%>"/>

<table border="0" width="100%">
 <tr>
      <th class="label">Loja / Emitente</th>
      <td><select name="idLoja" style="width: 172px">
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboLoja.jspf" %></select>
          <script>comboSelect(document.forms[0].idLoja, '<%= idLoja %>');</script>
      </td>
  </tr>
  <tr>
    <th class="label">Favorecido</th>
    <td><input type="text" name="favorecido" <%if (favorecido != null) { %>value="<%=favorecido%>"<% }%>  size="40" maxlength="40"></td>
  </tr>
  <tr>
    <th class="label">Cidade</th>
    <td><input type="text" name="cidade" <%if (cidade != null) { %>value="<%=cidade%>"<% }%>  size="40" maxlength="40"></td>
  </tr>
  <tr>
    <th class="label">Valor (R$)</th>
    <td><input type="text" name="valor" value="<%=Utilitaria.formatarNumero(valor,2).toString()%>" size="7" maxlength="7"></td>
  </tr>
  <tr>
    <th class="label">Referente</th>
    <td><input type="text" name="referente" <%if (referente != null) { %>value="<%=referente%>"<% }%>  size="40" maxlength="40"></td>
  </tr>
  <tr>
      <th class="label">Observação</th>
      <td><textarea name="observacao" cols="50" rows="2"><%=observacao %></textarea></td>
  </tr>
  <tr>
    <th class="label">CPF / CNPJ</th>
    <td><input type="text" name="cpfCnpj" <%if (cpfCnpj != null) { %>value="<%=cpfCnpj%>"<% }%>  size="40" maxlength="40"></td>
  </tr>
  <tr>
      <th class="label">Endereço</th>
      <td><textarea name="endereco" cols="50" rows="2"><%="endereco" %></textarea></td>
  </tr>
  <tr>
    <th class="label">Data de Emissão</th>
    <td><input type="text" name="cpfCnpj" <%if (dtEmissao != null) { %>value="<%=dtEmissao%>"<% }%>  size="40" maxlength="40"></td>
  </tr>
</table><hr>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
	<input class="button" type="button" value="Voltar" onClick="javascript: voltar();" /></td>
</tr>
</table>
</form>
<%@include file="../fimConexao.jsp"%>
</body>
</html>