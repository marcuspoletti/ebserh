<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.util.Utilitaria"%>
<%@page import="afero.auxiliar.IUrls"%>
<%@page import="afero.persistence.AgrupamentoDAO"%>
<%@page import="afero.util.ConverteDate"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/></script>

<script>
function salvar() {
    if(document.all.dsCorrecao.value == ''){
   	window.alert("O campo Descrição da Carta de Correção é obrigatório.");
    	document.all.dsCorrecao.focus();
    }else{
     document.forms[0].submit();
   }
}

function cancelar() {
  document.forms[0].action="formCartaCorrecao.jsp";
  document.forms[0].submit();
}

function voltar() {
  document.forms[0].action = 'listarCartaCorrecao.jsp?acao=voltar';
	document.forms[0].submit();
}
</script>
</head>
<%

String acao = request.getParameter("acao");
String idRetornoNotaFiscal = request.getParameter("idRetornoNotaFiscal");
String referencia = request.getParameter("referencia");
if(referencia == null) referencia="0";
ConverteDate converte = new ConverteDate();
if (acao == null) acao = "inc";
if (idRetornoNotaFiscal == null) idRetornoNotaFiscal = "";
String dsCorrecao = "";



%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Carta de Correção Nota Fiscal</h1>
<form method="post" action="listarCartaCorrecao.jsp?acao=<%=acao%>&idRetornoNotaFiscal=<%=idRetornoNotaFiscal%>&referencia=<%=referencia%>">


<table border="0" width="100%" align="center">
    <tr colspan = "5">
		<td  align="center" class="grid_erro"><font size="3" ><center><%="Uma Carta de Correção eletrônica (CCe) pode ser utilizada para corrigir eventuais erros na NFe. As seguintes informações não podem ser corrigidas:"%></center></font></td>

    </tr>
    <tr colspan = "5">
		<td  align="center" class="grid_erro"><font size="3" ><center><%="As variáveis que determinam o valor do imposto tais como: base de cálculo, alíquota, diferença de preço, quantidade, valor da operação ou da prestação;"%></center></font></td>

    </tr>
    <tr colspan = "5">
		<td  align="center" class="grid_erro"><font size="3" ><center><%="A correção de dados cadastrais que implique mudança do remetente ou do destinatário;"%></center></font></td>

    </tr>
     <tr colspan = "5">
		<td  align="center" class="grid_erro"><font size="3" ><center><%="A data de emissão ou de saída."%></center></font></td>
		
    </tr>
    
</table>

<hr>
<table border="0" width="100%">
  <tr>
    <th class="label">Descrição da Justificativa*</th>
    <td><textarea name="dsCorrecao" cols="100" rows="8"><%=dsCorrecao %></textarea></td>
  </tr>
  
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