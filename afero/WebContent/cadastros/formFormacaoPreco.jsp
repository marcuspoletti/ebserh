<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.FormacaoPreco"%>
<%@page import="afero.util.Utilitaria"%>
<%@page import="afero.persistence.FormacaoPrecoDAO"%>
<%@page import="afero.util.ConverteDate"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/></script>

<script>
function salvar() {
 if(document.all.dsFormacaoPreco.value == '') {
     window.alert("O campo Descrição de Formação de Preço é obrigatório.");
    document.all.dsEntrega.focus();
   }else{
     document.forms[0].submit();
   }
}

function cancelar() {
  document.forms[0].action="formFormacaoPreco.jsp";
  document.forms[0].submit();
}

function voltar() {
  document.forms[0].action = 'listarFormacaoPreco.jsp?acao=voltar';
	document.forms[0].submit();
}
</script>
</head>
<%

String acao = request.getParameter("acao");
String idFormacaoPreco = request.getParameter("idFormacaoPreco");
ConverteDate converte = new ConverteDate();
if (acao == null) acao = "inc";
if (idFormacaoPreco == null) idFormacaoPreco = "";
String dsFormacaoPreco = "";
String usuario = (String)session.getAttribute("Login");
String dtMod = "";
String pFrete = "0";
String pIPI = "0";
String pOutrasDespesas = "0";
String pICMSEntrada = "0";
String pICMSSaida = "0";
String pCustoOperacional = "0";
String pOutrosImpostos = "0";
String pComissao = "0";
String pLucro = "0";
String status = "A";

//verifica se acao foi atualizar
if (acao.equalsIgnoreCase("atu")) {
  FormacaoPrecoDAO dao = new FormacaoPrecoDAO(conn);
  FormacaoPreco formacaoPreco = dao.procurarFormacaoPreco(Integer.parseInt(idFormacaoPreco));
  dsFormacaoPreco  = formacaoPreco.getDsFormacapPreco();
  usuario = formacaoPreco.getUsuario();
  dtMod = formacaoPreco.getDtMod().toString();
  pFrete = Utilitaria.formatarNumero(formacaoPreco.getpFrete(),2).toString();
  pIPI = Utilitaria.formatarNumero(formacaoPreco.getpIpi(),2).toString();
  pOutrasDespesas = Utilitaria.formatarNumero(formacaoPreco.getpOutrasDespesas(),2).toString();
  pICMSEntrada = Utilitaria.formatarNumero(formacaoPreco.getpIcmsEntrada(),2).toString();
  pICMSSaida = Utilitaria.formatarNumero(formacaoPreco.getpIcmsSaida(),2).toString();
  pCustoOperacional = Utilitaria.formatarNumero(formacaoPreco.getpCustoOperacional(),2).toString();
  pOutrosImpostos = Utilitaria.formatarNumero(formacaoPreco.getpOutrosImpostos(),2).toString(); 
  pComissao = Utilitaria.formatarNumero(formacaoPreco.getpComissao(),2).toString();
  pLucro = Utilitaria.formatarNumero(formacaoPreco.getpLucro(),2).toString();
  status = formacaoPreco.getStatus();
}
%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Formação Preço</h1>
<form method="post" action="listarFormacaoPreco.jsp?acao=<%=acao%>&idFormacaoPreco=<%=idFormacaoPreco%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="idFormacaoPreco" value="<%=idFormacaoPreco%>"/>
<input type="hidden" name="usuario" value="<%=usuario%>"/>

<table border="0" width="100%">
  <tr>
    <th class="label">Descricao da Formação Preço*</th>
    <td><input type="text" name="dsFormacaoPreco" <%if (dsFormacaoPreco != null) { %>value="<%=dsFormacaoPreco%>"<% }%>  size="40" maxlength="40"></td>
  </tr>
  <tr>
    <th class="label">Frete</th>
    <td><input type="text"  name="pFrete" value="<%=pFrete%>" onkeyup="FormataValor(this,event)" size="10" maxlength="10"></td>
  </tr>
  <tr>
    <th class="label">IPI</th>
    <td><input type="text"  name="pIPI" value="<%=pIPI%>" onkeyup="FormataValor(this,event)" size="10" maxlength="10"></td>
  </tr>
    <tr>
    <th class="label">Outras Despesas</th>
    <td><input type="text"  name="pOutrasDespesas" value="<%=pOutrasDespesas%>" onkeyup="FormataValor(this,event)" size="10" maxlength="10"></td>
  </tr>
  <tr>
    <th class="label">ICMS Entrada</th>
    <td><input type="text"  name="pICMSEntrada" value="<%=pICMSEntrada%>" onkeyup="FormataValor(this,event)" size="10" maxlength="10"></td>
  </tr>
    <tr>
    <th class="label">ICMS Saída</th>
    <td><input type="text"  name="pICMSSaida" value="<%=pICMSSaida%>" onkeyup="FormataValor(this,event)" size="10" maxlength="10"></td>
  </tr>
  <tr>
    <th class="label">Custo Operacional</th>
    <td><input type="text"  name="pCustoOperacional" value="<%=pCustoOperacional%>" onkeyup="FormataValor(this,event)" size="10" maxlength="10"></td>
  </tr>
  <tr>
    <th class="label">Outros Impostos</th>
    <td><input type="text"  name="pOutrosImpostos" value="<%=pOutrosImpostos%>" onkeyup="FormataValor(this,event)" size="10" maxlength="10"></td>
  </tr>
  <tr>
    <th class="label">Lucro</th>
    <td><input type="text"  name="pLucro" value="<%=pLucro%>" onkeyup="FormataValor(this,event)" size="10" maxlength="10"></td>
  </tr>
  <tr>
    <th class="label">Ativo</th>
      <td class="label_radio"><input type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Sim
      <input type="radio" class="radio" name="status" value="I" <%= (status.equals("I")? "checked": "") %>>Não</td>
  </tr>
   <%if(acao.equals("atu")){%>
  
  	<tr>
  	    <td class="label_menor"><center>Data Modificação :</center></td>
  	    <td class="label_menor"><center> <%if (dtMod != null) { %><%=converte.DMYToYMD(dtMod)%><% }%>&nbsp</center></td>
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