<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.DuplicataParcela"%>
<%@page import="afero.model.Duplicata"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="afero.util.Utilitaria"%>
<%@page import="afero.persistence.DuplicataParcelaDAO"%>
<%@page import="afero.persistence.DuplicataDAO"%>
<%@page import="afero.util.ConverteDate"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script language=JavaScript src="../js/abas.js" type=text/javascript></script>
<script src="../js/common.js" /></script>
<script language="Javascript">
function soma() {
	document.getElementById("vlTotal").value = '0';
	var total = 0;
	var num = eval(document.getElementById("qtdParcelas").value);
	var vlTitulo = parseFloat(document.getElementById("vlTitulo").value);
	for (i=1; i <= num; i++) {
		total += parseFloat(document.getElementById("parcela_"+i).value);
	}
	document.getElementById("vlTotal").value = total;
	document.getElementById("vlDiferencial").value = vlTitulo - total;
}

function enviarDados() {
	if(document.all.vlDiferencial.value != '0') {
		window.alert("O Valor da Diferença Precisa ser '0'(zero).");
		document.all.vlDiferencial.focus();
	} else {
		parametros();
	}
}

function parametros() {
	var dtParcVenc = "";
	var vtValores = "";
	var idDup = document.getElementById('idDuplicataPai').value;
	var num = eval(document.getElementById("qtdParcelas").value);
	for(i = 1; i <= num; i++){
		dtParcVenc += document.getElementById('dtParcVenc_'+i).value+'&';
		vtValores += parseFloat(document.getElementById('parcela_'+i).value)+'&';
	}
	//window.opener.document.forms[0].vtValores.value = vtValores; // Atribuindo os valores no HIDDEN na JPai;
	//window.opener.document.forms[0].dtParcVenc.value = dtParcVenc; // Atribuindo as datas no HIDDEN na JPai;
	//window.opener.document.forms[0].submit(); // Submit na JPai;
	document.getElementById('dtParcVenc').value = dtParcVenc;
	document.getElementById('vtValores').value = vtValores;
	document.forms[0].submit();
	fechar();
}

function fechar() {
	window.alert('Parcelas Salvas.');
	self.close();
}
</script>
</head>
<%
	String acao = request.getParameter("acao");
	if (acao == null)
		acao = "alt";
	
	String idDuplicataPai = request.getParameter("idDuplicataPai");
	String dtParcVenc = request.getParameter("dtParcVenc");
	String vtValores = request.getParameter("vtValores");
	if (dtParcVenc == null)
		dtParcVenc = "";
	if (vtValores == null)
		vtValores = "";

	DuplicataParcela dp = null;
	DuplicataParcelaDAO daoParcela = null;
	String dtEmissao = "";
	String dtVenc = "";
	String valor = "0";
	double valorTotal = 0;
%>
<body onload="soma()" >
<h1 class="cabecalho_pagina">Alterar Parcelas</h1>
<form method="post" action="formAlterarVencimento.jsp?acao=<%=acao%>&idDuplicataPai=<%=idDuplicataPai%>&vtValores=<%=vtValores%>&dtParcVenc=<%=dtParcVenc%>" name="formulario" id="formulario">
<input type="hidden" name="acao" value="<%=acao%>">
<input type="hidden" name="idDuplicataPai" id="idDuplicataPai" value="<%=idDuplicataPai%>"/>
<input type="hidden" name="vtValores" id="vtValores" value="<%=vtValores%>"/>
<input type="hidden" name="dtParcVenc" id="dtParcVenc" value="<%=dtParcVenc%>"/>
		<iframe width=174 height=189 name="gToday:normal:" ../js/calendar/agenda.js" id="gToday:normal:"
			../js/calendar/agenda.js" src="../js/calendar/ipopeng.htm" scrolling="no" frameborder="0"
			style="visibility: visible; z-index: 999; position: absolute; top: -500px; left: -500px;">
		</iframe>

<%
	if (acao.equalsIgnoreCase("atuP")) {

		dp = new DuplicataParcela();
		daoParcela = new DuplicataParcelaDAO(conn);
		List list = daoParcela.listarDuplicataParcela(" WHERE dp.idDuplicata = "
						+ Integer.parseInt(idDuplicataPai));
%>
<table border="0" width="50%">
<tr>
	<th class="grid">Parcela</th>
  <th class="grid">Vencimento*</th>
  <th class="grid">Valor*</th>
</tr>
<%
	  int cont = 0;
		Duplicata duplicata = new Duplicata();
		DuplicataDAO daoDuplicata = new DuplicataDAO(conn);
		for (Iterator it = list.iterator(); it.hasNext();) {
			dp = (DuplicataParcela) it.next();
			duplicata = daoDuplicata.procurarDuplicata(dp.getIdDuplicata());
			cont++;
%>
 
<tr>
	<td class = "grid" width="2%"><center><%=cont%></center></td>
	<td class="grid" >
		<input type="text" name="dtParcVenc_"<%=cont%> id="dtParcVenc_"<%=cont%> size="15" <%if (dp.getDtVenc() != null) {%>value="<%=ConverteDate.dateToString(dp.getDtVenc())%>"<%}%> onblur="chkData(this,'dd/MM/yyyy')" maxlength="10" class="inputs">
		<a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dtParcVenc_<%=cont%>);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
	<td class="grid">
		<input type="text" name="parcela" id=parcela_<%=cont%> onBlur="soma()" value="<%=dp.getValor()%>"  size="20" maxlength="15"></td>
	</td>
</tr>
<%
		}
%>

<tr>
	<td><input type="hidden" value="<%=cont%>" id="qtdParcelas" /></td>
</tr>
</table>
<hr>
<table border="0" width="100%">
<tr>
	<th class="label">Valor Total das Parcelas</th>
	<td><input type="text" name="vlTotal" id="vlTotal"  size="40" maxlength="40" /></td>
</tr>
<tr>
	<th class="label">Valor do Titulo</th>
	<td><input disabled type="text" name="vlTitulo" id="vlTitulo"  size="40" maxlength="40" value="<%=duplicata.getValorTotal()%>" /></td>
</tr>
<tr>
	<th class="label">Diferença</th>
	<td><input type="text" style="font-weight:bold; color:#FF0000" name="vlDiferencial" id="vlDiferencial" size="40" maxlength="40"></td>
</tr>
</table>
<hr>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
	<td><input class="button" type="button" value="salvar" onClick="javascript: enviarDados();" />
	<td class="campo_obrigatorio">* Campos Obrigatórios</td>
</tr>
</table>
</form>
<%
	} else if (acao.equalsIgnoreCase("atuB")) {
		DuplicataDAO dao;
		int ck = 1;
		if ((vtValores != "") && (dtParcVenc != "")) {
			try {
				String[] vetValores = vtValores.split("&");// Split para separa e formar o vetor de valores;
				String[] vetData = dtParcVenc.split("&");// Split para separa e formar o vetor de datas;

				DuplicataParcela parcelaD = null;
				DuplicataParcelaDAO parcelaDao = null;
				parcelaDao = new DuplicataParcelaDAO(conn);

				for (int i = 0; i < vetValores.length; i++) { // inserir no Banco os novos valores e as datas;
					parcelaD = new DuplicataParcela();
					parcelaD.setIdDuplicata(Integer.parseInt(idDuplicataPai));
					parcelaD.setNrParcela(ck);
					parcelaD.setValor(Utilitaria.toNumber(vetValores[i]).doubleValue());
					parcelaD.setDtVenc(ConverteDate.stringToDate(vetData[i]));
					parcelaDao.alterarParcelas(parcelaD);
					ck++;
				}
				dao = new DuplicataDAO(conn);
				dao.atualizarValorTotal(Integer.parseInt(idDuplicataPai));
				
				ck = -1;
				
			} catch (Exception e) {
				throw new AferoDAOException("Erro ao inserir dados: "	+ e);
			}
		}
		if (ck == -1) {
%>
		<input type="hidden" onBlur="fechar();"/>
<%
		}
	}
%>
<%@include file="../fimConexao.jsp"%>
</body>
</html>