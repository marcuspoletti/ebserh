<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.OrdemServicoItem" %>
<%@page import="afero.model.OrdemServicoObjeto"%>
<%@page import="afero.model.ListaServico"%>

<%@page import="afero.persistence.OrdemServicoItemDAO" %>
<%@page import="afero.persistence.OrdemServicoObjetoDAO"%>
<%@page import="afero.persistence.ListaServicoDAO"%>

<%@page import="afero.util.ConverteDate" %>
<%@page import="afero.util.Utilitaria" %>
<%@page import="java.util.Date" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/></script>
<script>
function salvar() {
	if(document.all.idColaborador.value == '0'){
		window.alert("O campo 'Colaborador' é obrigatório");
		document.all.idColaborador.focus();
	}else{
		document.forms[0].submit();
	}
}
function number_format( number, decimals, dec_point, thousands_sep ) {
	var n = number, c = isNaN(decimals = Math.abs(decimals)) ? 2 : decimals;
	var d = dec_point == undefined ? "," : dec_point;
	var t = thousands_sep == undefined ? "." : thousands_sep, s = n < 0 ? "-" : "";
	var i = parseInt(n = Math.abs(+n || 0).toFixed(c)) + "", j = (j = i.length) > 3 ? j % 3 : 0;
	return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : "");
}
function calcula() {
	var valorServico           = document.getElementById('vlUni').value;
	var valorServicoFormat     = valorServico.replace(".","");
	var valorServicoFormatCalc = parseFloat(valorServicoFormat.replace(",","."));
	var quant                  = document.getElementById('quant').value;
	var quantFormat            = quant.replace(".","");
	var quantFormatCalc        = parseFloat(quantFormat.replace(",","."));
	var calculoValor           = quantFormatCalc*valorServicoFormatCalc;
	
	var valorDesc              = document.getElementById('pDesc').value;
	var valorDescFormat        = valorDesc.replace(".","");
	var valorDescFormatCalc    = parseFloat(valorDescFormat.replace(",","."));
	var valorCalculoDesc       = (calculoValor * valorDescFormatCalc)/100;
	var valorTotalDesc         = calculoValor - valorCalculoDesc;
	
	document.getElementById('valor').value = number_format(valorTotalDesc, 2, ',', '.');   
	
}

function cancelar() {
  document.forms[0].action="formOrdemServicoItem.jsp";
  document.forms[0].submit();
}

function recarregar(acao) {
  document.forms[0].action='formOrdemServicoItem.jsp?acao='+acao;
  document.forms[0].submit();
}

function voltar() {
	history.back(1);
}  
</script>
</head>
<%
OrdemServicoObjeto ordemServicoObjeto;
OrdemServicoObjetoDAO daoObj;

ListaServico listaServico;
ListaServicoDAO daoServico;


String acao = request.getParameter("acao");

String idOrdemServicoItem = request.getParameter("idOrdemServicoItem");
String idOrdemServicoObjeto = request.getParameter("idOrdemServicoObjeto");
String idListaServico = request.getParameter("idListaServico");

if (acao == null) acao = "inc";
if(idOrdemServicoItem == null) idOrdemServicoItem = "0";

String dsCompServico = "";
String comp = "0";
String larg = "0";
String quant = "1";
String valor = "0";
String pDesc = "0";
String vlUni = "0";
int idColaborador = Integer.parseInt((String)session.getAttribute("idColaborador"));
String dtMod = null;
String usuario = (String)session.getAttribute("Login");

if (acao.equalsIgnoreCase("atu")){
	
	OrdemServicoItemDAO dao = new OrdemServicoItemDAO(conn);
	OrdemServicoItem ordemServicoItem = dao.procurarOrdemServicoItem(" WHERE idOrdemServicoItem = "+idOrdemServicoItem );
	
	idOrdemServicoObjeto = ""+ordemServicoItem.getIdOrdemServicoObjeto();
	idListaServico = ""+ordemServicoItem.getIdListaServico();
	dsCompServico = ordemServicoItem.getDsCompServico();
	comp = ""+ordemServicoItem.getComp();
	larg = ""+ordemServicoItem.getLarg();
	quant = ""+ordemServicoItem.getQuant();
	valor = ""+ordemServicoItem.getValor();
	pDesc = ""+ordemServicoItem.getpDesc();
	vlUni = ""+ordemServicoItem.getVlUni();
	idColaborador = ordemServicoItem.getIdColaborador();
	dtMod = ConverteDate.dateToString(ordemServicoItem.getDtMod());
	usuario = ordemServicoItem.getUsuario();
	
}else if(acao.equalsIgnoreCase("inc")){
	
	ListaServicoDAO dao = new ListaServicoDAO(conn);
	listaServico = dao.procurarListaServico(" WHERE idListaServico = "+Integer.parseInt(idListaServico));
	vlUni = "".valueOf(listaServico.getPreco());

	
	
}
%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Serviço</h1>
<form method="post" action="listarOrdemServicoItem.jsp?acao=<%=acao%>&idOrdemServicoItem=<%=idOrdemServicoItem%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" id="idOrdemServicoItem" name="idOrdemServicoItem" value="<%=idOrdemServicoItem %>"/>
<input type="hidden" id="idOrdemServicoObjeto" name="idOrdemServicoObjeto" value="<%=idOrdemServicoObjeto %>"/>
<input type="hidden" id="idListaServico " name="idListaServico" value="<%=idListaServico %>"/>

<iframe width=174 height=189 name="gToday:normal:"../js/calendar/agenda.js"
            id="gToday:normal:"../js/calendar/agenda.js" src="../js/calendar/ipopeng.htm"
            scrolling="no" frameborder="0" style="visibility:visible; z-index:999; 
    position:absolute; top:-500px; left:-500px;">
</iframe>
<%
ordemServicoObjeto = new OrdemServicoObjeto();
daoObj = new OrdemServicoObjetoDAO(conn);
ordemServicoObjeto = daoObj.procurarOrdemServicoObjeto(" WHERE idOrdemServicoObjeto = "+idOrdemServicoObjeto);
String nomeObjeto = ordemServicoObjeto.getCampo1();

listaServico = new ListaServico();
daoServico = new ListaServicoDAO(conn);
listaServico = daoServico.procurarListaServico(" WHERE idListaServico = "+idListaServico);
String nomeServico = listaServico.getDsListaServico();
dsCompServico = listaServico.getDsListaServico();
%>

<table border="0" width="100%">
	<tr>
		<th class="label">Objeto</th>
		<td><input readonly="readonly" type="text"  id="nomeObjeto" name="nomeObjeto" size="40" maxlength="20" value="<%=nomeObjeto %>" /></td>
	</tr>
	<tr>
		<th class="label">Serviço</th>
		<td><input readonly="readonly" type="text"  id="nomeServico" name="nomeServico" size="40" maxlength="20" value="<%=nomeServico %>" /></td>
	</tr>
	<tr>
		<th class="label">Descrição </th>
		<td><textarea  id="dsCompServico" name="dsCompServico" cols="50" rows="5" maxlength="100"><%=dsCompServico%></textarea></td>
	</tr>
	<tr>
		<th class="label">Comprimento</th>
		<td><input type="text"  id="comp" name="comp" value="<%=comp%>" size="40" maxlength="5" /></td>
	</tr>
	<tr>
		<th class="label">Largura</th>
		<td><input type="text"  id="larg" name="larg" value="<%=larg%>" size="40" maxlength="5" /></td>
	</tr>
	<tr>
		<th class="label">Valor Unitário</th>
		<td><input type="text"  id="vlUni" name="vlUni" value="<%=Utilitaria.formatarNumero(Float.parseFloat(vlUni), 2).toString() %>" onkeyup="FormataValor(this,event)" size="40" maxlength="40" /></td>
	</tr>
	<tr>
		<th class="label">Quantidade</th>
		<td><input type="text"  id="quant" name="quant" value="<%=quant%>" size="40" maxlength="5" onblur="calcula();"/></td>
	</tr>
	<tr>
		<th class="label">Desconto</th>
		<td><input type="text"  id="pDesc" name="pDesc" value="<%=Utilitaria.formatarNumero(Float.parseFloat(pDesc), 2).toString() %>" onkeyup="FormataValor(this,event)" onblur="calcula();" size="40" maxlength="40" /></td>
	</tr>
	<tr>
		<th class="label">Valor</th>
		<td><input type="text" name="valor" value="<%=Utilitaria.formatarNumero(Float.parseFloat(valor), 2).toString() %>"  onkeyup="FormataValor(this,event)"  onblur="calcula();" size="40" maxlength="40"></td>
	</tr>
	<tr>
		<th class="label">Colaborador*</th>
		<td><select name="idColaborador" required="true">
			<option value='0'>Selecione...</option>
			<%@include file="../WEB-INF/jspf/combo/comboColaborador.jspf"%></select>
			<script>comboSelect(document.forms[0].idColaborador, '<%=idColaborador %>');</script>
		</td>
	</tr>
<% if(acao.equalsIgnoreCase("atu")){ %>
	
	<tr>
		<th class="label">Registros:</th>
   	 	<td class="label_menor"><center>&nbsp Modificação: <%if (dtMod != null) { %><%=dtMod%><% }%>&nbsp;</center></td>
   	 	<td class="label_menor"><center>&nbsp Usuário: <%if (usuario != null) { %><%=usuario%><% }%>&nbsp;</center></td>
   	</tr>
<%} %>
  
</table><hr>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			<input class="button" type="button" value="Adicionar" onClick="javascript: salvar();" />
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