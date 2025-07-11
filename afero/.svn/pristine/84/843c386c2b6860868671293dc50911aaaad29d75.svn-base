<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.ContaMovto"%>
<%@page import="afero.model.Conta"%>
<%@page import="afero.model.Colaborador"%>
<%@page import="afero.persistence.ColaboradorDAO"%>
<%@page import="afero.persistence.ContaMovtoDAO"%>
<%@page import="afero.persistence.ContaDAO"%>
<%@page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<%@page import="afero.util.ConverteDate"%>
<%@page import="afero.util.Utilitaria"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script language=JavaScript src="../js/abas.js" type=text/javascript></script>
<script src="../js/common.js" /></script>
<script>
function salvar() {
  if (document.all.idConta.value == '0') {
    window.alert("O campo Conta é obrigatório.");
    document.all.idConta.focus();
  } else if (document.all.historico.value == ''){
      window.alert("O campo Histórico é obrigatório.");
      document.all.historico.focus();
  } else if (document.all.dtLanc.value == ''){
      window.alert("O campo Data de Lançamento é obrigatório.");
      document.all.dtLanc.focus();
   } else {
  	document.forms[0].submit();
  }
}

function cancelar() {
  document.forms[0].action="formContaMovto.jsp";
  document.forms[0].submit();
}

function voltar() {
  document.forms[0].action = 'listarContaMovto.jsp?acao=voltar'
	document.forms[0].submit();
}
function comboSelect(combo, key) {
  var err = window.onerror; 
  window.onerror = new Function('true'); 
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
String data = "";
try {
	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");      
	data = sdf.format(new Date());
} catch (NumberFormatException nfe) {
	throw new Exception("Data inválida");
} catch (Exception e) {
	throw new Exception(e.getMessage());
}

String acao = request.getParameter("acao");
String idContaLocalizar = request.getParameter("idContaLocalizar");
String idContaMovto = request.getParameter("idContaMovto");
String idUsuario = (String)session.getAttribute("idUsuario");
ColaboradorDAO daoColaborador = new ColaboradorDAO(conn);
Colaborador colaboradorContaMovto = daoColaborador.procurarColaboradorUsuario(Integer.parseInt(idUsuario));

if (acao == null) acao = "inc";
if (idContaLocalizar == null) idContaLocalizar = "1";
if (idContaMovto == null)idContaMovto = "0";

int idConta = Integer.parseInt(idContaLocalizar);
String dc = "C";
String valor = "0.0";
String formaMovto = "D";
String dtLanc = data;
String dtComp = "";
int idTransferencia = 0;
String nrDoc = "";
int idPlanoConta = 0;
int idCentroCusto = 0;
String historico = "";
String divideValor = "N";
String idColaborador = "".valueOf(colaboradorContaMovto.getIdColaborador());
double vlSaldoAnterior = 0;
double vlSaldoAtual = 0;
String conciliado = "N";
String status = "R";
String dtCad = "";
String dtMod = "";
String usuario = (String) session.getAttribute("Login");

String nmConta = "";

//verifica se acao foi atualizar
if (acao.equalsIgnoreCase("atu")) {
  ContaMovtoDAO dao = new ContaMovtoDAO(conn);
  ContaMovto contaMovto = dao.procurarContaMovto(Integer.parseInt(idContaMovto));
  ContaDAO daoconta = new ContaDAO(conn);
  Conta ct = daoconta.procurarConta(idConta);
  nmConta = ct.getNmConta();
  idConta = contaMovto.getIdConta();
  dc = contaMovto.getDc();
	valor = "".valueOf(contaMovto.getValor()); 
	formaMovto = contaMovto.getFormaMovto();
	dtLanc = ConverteDate.dateToString(contaMovto.getDtLanc());
	if (contaMovto.getDtComp() != null) {
		dtComp = ConverteDate.dateToString(contaMovto.getDtComp());
	}
	idTransferencia = contaMovto.getIdTransferencia();
	nrDoc = contaMovto.getNrDoc();
	idPlanoConta = contaMovto.getIdPlanoConta();
	idCentroCusto = contaMovto.getIdCentroCusto();
	historico = contaMovto.getHistorico();
	divideValor = contaMovto.getDivideValor();
	idColaborador = "".valueOf(contaMovto.getIdColaborador());
	vlSaldoAnterior = contaMovto.getVlSaldoAnterior(); 
	vlSaldoAtual = contaMovto.getVlSaldoAtual();
	conciliado = contaMovto.getConciliado();
	status = contaMovto.getStatus();
	dtCad = ConverteDate.dateToString(contaMovto.getDtCad());
	dtMod = ConverteDate.dateToString(contaMovto.getDtMod());
	usuario = (String) session.getAttribute("Login");
	
}


%>
<body onload="document.forms[0].elements[0].focus();" >
<h1 class="cabecalho_pagina">Movimentação de Conta</h1>
<form method="post" action="listarContaMovto.jsp?acao=<%=acao%>&idContaLocalizar=<%=idContaLocalizar%>">
<iframe width=174 height=189 name="gToday:normal:"../js/calendar/agenda.js"
            id="gToday:normal:"../js/calendar/agenda.js" src="../js/calendar/ipopeng.htm"
            scrolling="no" frameborder="0" style="visibility:visible; z-index:999; 
    position:absolute; top:-500px; left:-500px;">
    </iframe>
<table border="0" width="100%">
		<tr>
			<th class="label">Conta*</th>
    	<td><select <%= (acao.equals("atu")? "disabled": "") %> name="idConta" >
    		<option value='0'>Selecione...</option>
    		<%@include file="../WEB-INF/jspf/combo/comboConta.jspf" %></select>
    		<script>comboSelect(document.forms[0].idConta, '<%=idConta%>');</script>
    	</td>
    </tr>
    <tr>
    	<th class="label">Movimento</th>
    	<td class="label_radio">
    	  <input type="radio" class="radio" name="formaMovto" value="D" <%= (formaMovto.equals("D")? "checked": "") %>>Depósito
    	  <input type="radio" class="radio" name="formaMovto" value="R" <%= (formaMovto.equals("R")? "checked": "") %>>Retirada
    		<input type="radio" class="radio" name="formaMovto" value="T" <%= (formaMovto.equals("T")? "checked": "") %>>Transferência
    	</td>
    </tr>
    <tr>
    	<th class="label">Data Lançamento*</th>
    	<td><input type="text" name="dtLanc" size="15" <%if (dtLanc != null) { %>value="<%=dtLanc%>"<%} %> onblur="chkData(this,'dd/MM/yyyy')" maxlength="10" class="inputs" />
    		<a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dtLanc);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
    	</td>
    </tr>
    <tr>
    	<th class="label">Data Compensação</th>
    	<td><input type="text" name="dtComp" size="15" <%if (dtComp != null) { %>value="<%=dtComp%>"<%} %> onblur="chkData(this,'dd/MM/yyyy')" maxlength="10" class="inputs" />
    		<a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dtComp);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
    	</td>
    </tr>
    <tr>
    	<th class="label">Histórico*</th>
    	<td><input type="text" name="historico" <%if (historico != null) { %>value="<%=historico%>"<% }%>  size="100" maxlength="100">
    </tr>
    <tr>
    	<th class="label">Documento</th>
    	<td><input type="text" name="nrDoc" <%if (nrDoc != null) { %>value="<%=nrDoc%>"<% }%>  size="20" maxlength="20"></td>
    </tr>
    <tr>
    	<th class="label">Valor*</th>
    	<td>
    		<input type="text" name="valor" <%if (valor != null) { %> value="<%=Utilitaria.formatarNumero(Float.parseFloat(valor),2).toString()%>"<% } %>  onkeyup="FormataValor(this,event)" size="40" maxlength="40">
    	</td>
    </tr>
<!--
    <tr>
    	<th class="label">Tipo</th>
    	<td class="label_radio"><input type="radio" class="radio" name="dc" value="C" <%= (dc.equals("C")? "checked": "") %>>Crédito
    		<input type="radio" class="radio" name="dc" value="D" <%= (dc.equals("D")? "checked": "") %>>Débito
    	</td>
    </tr>
    <tr>
    	<th class="label">Plano Conta*</th>
    	<td><select name="idPlanoConta" style="width: 172px">
    		<option value='0'>Selecione...</option>
    		<%@include file="../WEB-INF/jspf/combo/comboPlanoConta.jspf" %></select>
    		<script>comboSelect(document.forms[0].idPlanoConta, '<%= idPlanoConta %>');</script>
    	</td>
    </tr>
    <tr>
    	<th class="label">Centro de Custo*</th>
    	<td><select name="idCentroCusto" style="width: 172px">
    		<option value='0'>Selecione...</option>
    		<%@include file="../WEB-INF/jspf/combo/comboCentroCusto.jspf" %></select>
    		<script>comboSelect(document.forms[0].idCentroCusto, '<%= idCentroCusto%>');</script>
    	</td>
    </tr>
    <tr>
    	<th class="label">Divide Valor</th>
    	<td class="label_radio">
    		<input type="radio" class="radio" name="divideValor" value="S" <%=(divideValor.equals("S")? "checked": "") %> />Sim
    		<input type="radio" class="radio" name="divideValor" value="N" <%=(divideValor.equals("N")? "checked": "") %>/>Não
    	</td>
    </tr>
    <tr>
    	<th class="label">Colaborador*</th>
    	<td><select name="idColaborador" >
    		<option value='0'>Selecione...</option>
    		<%@include file="../WEB-INF/jspf/combo/comboColaboradorContaMovto.jspf" %></select>
    		<script>comboSelect(document.forms[0].idColaborador, '<%=idColaborador%>');</script>
    	</td>
    </tr>
    <tr>
    	<th class="label">Valor Saldo Anterior</th>
    	<td><input type="text" name="vlSaldoAnterior" value="<%=vlSaldoAnterior%>"  onkeyup="FormataValor(this,event)" size="40" maxlength="40"></td>
    </tr>
    <tr>
    	<th class="label">Valor Saldo Atual</th>
    	<td><input type="text" name="vlSaldoAtual" value="<%=vlSaldoAtual%>"  onkeyup="FormataValor(this,event)" size="40" maxlength="40"></td>
    </tr>
-->
    <tr>
    	<th class="label">Conciliado</th>
    	<td class="label_radio">
    		<input type="radio" class="radio" name="conciliado" value="S" <%=(conciliado.equals("S")? "checked": "") %> />Sim
    		<input type="radio" class="radio" name="conciliado" value="N" <%=(conciliado.equals("N")? "checked": "") %>/>Não
    	</td>
    </tr>
    <tr>
    	<th class="label">Status</th>
    	<td class="label_radio">
    	  <input type="radio" class="radio" name="status" value="R" <%= (status.equals("R")? "checked": "") %>>Realizado
    		<input type="radio" class="radio" name="status" value="P" <%= (status.equals("P")? "checked": "") %>>Previsto
    	</td>
    </tr>
  </table><hr>

  <%if(acao.equals("atu")){%>
 <table border="0" width="100%">  
  	<tr>
  	    <th class="label">Registros:</th>
  	    <td class="label_menor"><center>&nbsp Modificação: <%if (dtMod != null) { %><%=dtMod%><% }%>&nbsp</center></td>
	</tr>
</table><hr>
  <% }%>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
	<td><input class="button" type="button" value="Salvar" onClick="javascript: salvar();" />
	<input class="button" type="button" value="Cancelar" onClick="javascript: cancelar();" />
	<input class="button" type="button" value="Voltar" onClick="javascript: voltar();" /></td>
	<td class="campo_obrigatorio">* Campos Obrigatórios</td>
</tr>
</table>
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="idConta" value="<%=idConta%>"/>
<input type="hidden" name="idContaLocalizar" value="<%=idContaLocalizar%>"/>
<input type="hidden" name="idContaMovto" value="<%=idContaMovto%>"/>
<input type="hidden" name="idTransferencia" value="<%=idTransferencia%>"/>
<input type="hidden" name="divideValor" value="<%=divideValor%>"/>
<input type="hidden" name="idColaborador" value="<%=idColaborador%>"/>
<input type="hidden" name="usuario" value="<%=usuario%>"/>
</form>
<%@include file="../fimConexao.jsp"%>
</body>
</html>