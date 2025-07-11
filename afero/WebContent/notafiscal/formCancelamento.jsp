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
function verifica_qtd(){
    vQtd = document.getElementById('dsCancelamento');
    if(vQtd.value.length >= 255){
    	window.alert('Máximo de 255 Caracteres');
        vQtd.focus();
        return false;
    }
}
function salvar() {
    if(document.all.dsCancelamento.value == ''){
   	window.alert("O campo Descrição do Cancelamento é obrigatório.");
    	document.all.dsCancelamento.focus();
    }else{
     document.forms[0].submit();
   }
}

function cancelar() {
  document.forms[0].action="formCancelamento.jsp";
  document.forms[0].submit();
}

function voltar() {
  document.forms[0].action = 'listarCancelamento.jsp?acao=voltar';
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
String dsCancelamento = "";



%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Formulário de Cancelamento de Nota fiscal</h1>
<form method="post" action="listarCancelamento.jsp?acao=<%=acao%>&idRetornoNotaFiscal=<%=idRetornoNotaFiscal%>&referencia=<%=referencia%>">


<table border="0" width="100%" align="center">
 
    <tr colspan = "5">
		<td  align="center" class="grid_erro"><font size="3" ><center><%="A NFe poderá ser cancelada até 24 horas depois da emissão. Alguns estados permitem um prazo maior para o cancelamento, verifique os detalhes junto com o SEFAZ do seu estado."%></center></font></td>

    </tr>
    
</table>

<hr>
<table border="0" width="100%">
  <tr>
    <th class="label">Descrição da Justificativa*</th>
    <td><textarea name="dsCancelamento" id="dsCancelamento" cols="100" rows="8" onkeypress="javascript: verifica_qtd();" maxlenght="255"><%=dsCancelamento %></textarea></td>
  </tr>
  
</table><hr>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
	<td><input class="button" type="button" value="Salvar" onClick="javascript: salvar();" />
	<input class="button" type="button" value="Cancelar" onClick="window.close();" />
	<td class="campo_obrigatorio">* Campos Obrigatórios</td>
</tr>
</table>
</form>
<%@include file="../fimConexao.jsp"%>

</body>
</html>