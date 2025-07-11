<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.Transferencia"%>
<%@page import="afero.model.Colaborador"%>
<%@page import="afero.persistence.TransferenciaDAO"%>
<%@page import="afero.persistence.ColaboradorDAO"%>
<%@page import="afero.persistence.ContaDAO"%>
<%@ page import="afero.util.Utilitaria"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<%@page import="afero.util.ConverteDate"%>

<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script language=JavaScript src="../js/abas.js" type=text/javascript></script>
<script src="../js/common.js" /></script>
<script>
function salvar() {
  if (document.all.idContaDe.value == '0') {
    window.alert("O campo Conta é obrigatório.");
    document.all.idContaDe.focus();
  } else if (document.all.idContaPara.value == '0'){
      window.alert("O campo Conta é obrigatório.");
      document.all.idContaPara.focus();
   } else if (document.all.idColaborador.value == '0'){
      window.alert("O campo Colaborador é obrigatório.");
      document.all.idColaborador.focus();
   } else if (document.all.dtLanc.value == null){
	      window.alert("O campo Data de Lançamento é obrigatório.");
	      document.all.dtLanc.focus();
   }else{
  	document.forms[0].submit();
  }
}

function cancelar() {
  document.forms[0].action="formTransferencia.jsp";
  document.forms[0].submit();
}

function voltar() {
  document.forms[0].action = 'listarTransferencia.jsp?acao=listar'
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
//variáveis capturadas da página listarCidade.jsp
String acao = request.getParameter("acao");
String idTransferencia = request.getParameter("idTransferencia");
if(idTransferencia == null)idTransferencia = "0";
String idUsuario = (String)session.getAttribute("idUsuario");
ColaboradorDAO daoColaboradorTransf = new ColaboradorDAO(conn);
Colaborador colaboradorTransf = daoColaboradorTransf.procurarColaboradorUsuario(Integer.parseInt(idUsuario));
ConverteDate converte = new ConverteDate();
if (acao == null) acao = "inc";
String idLoja = request.getParameter("idLoja");
if(idLoja == null)idLoja = "".valueOf(colaboradorTransf.getIdLoja());

int idContaDe= 0;
int idContaPara = 0;
double valor = 0;
String formaMovto = "";
String dtLanc = null;
String lancaAutomatico= "I";
String historico = "";
int cdTipoFrequencia = 0;
String informaParcelas = "I";
int quantParcelas = 0;
String dtUltimoLanc = null;
int idColaborador = colaboradorTransf.getIdColaborador();
String status = "A";
String dtCad = null;
String dtMod = null;
String usuario = (String) session.getAttribute("Login");



//verifica se acao foi atualizar
if (acao.equalsIgnoreCase("atu")) {
    TransferenciaDAO dao = new TransferenciaDAO(conn);
    int idT = Utilitaria.toNumber(idTransferencia).intValue();
    Transferencia transferencia = dao.procurarTransferencia(idT);
    idContaDe   = transferencia.getIdContaDe();
    idContaPara = transferencia.getIdContaPara();
    valor = transferencia.getValor();
    formaMovto = transferencia.getFormaMovto();
    if(transferencia.getDtLanc() != null){
    	dtLanc = converte.dateToString(transferencia.getDtLanc());
    }
    lancaAutomatico = transferencia.getLancaAutomatico();
    historico = transferencia.getHistorico();
    cdTipoFrequencia = transferencia.getCdTipoFrequencia();
    informaParcelas = transferencia.getInformaParcelas();
    quantParcelas = transferencia.getQuantParcelas();
    if(transferencia.getDtUltimoLanc() != null){
    	dtUltimoLanc = converte.dateToString(transferencia.getDtUltimoLanc());
    }        
    idColaborador = colaboradorTransf.getIdColaborador();
    status  = transferencia.getStatus();
    if(transferencia.getDtCad() != null){
    	dtCad = converte.dateToString(transferencia.getDtCad());
    }
    if(transferencia.getDtMod() != null){
    	dtMod = converte.dateToString(transferencia.getDtMod());
    }        
    usuario = transferencia.getUsuario();
        
}
%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Transferência de Conta</h1>
<form method="post" action="listarTransferencia.jsp?acao=<%=acao%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="idTransferencia" value="<%=idTransferencia%>"/>
<input type="hidden" name="usuario" value="<%=usuario%>"/>
<input type="hidden" name="dtCad" value="<%=dtCad %>" />
<input type="hidden" name="dtMod" value="<%=dtMod %>" /> 
<iframe width=174 height=189 name="gToday:normal:"../js/calendar/agenda.js"
            id="gToday:normal:"../js/calendar/agenda.js" src="../js/calendar/ipopeng.htm"
            scrolling="no" frameborder="0" style="visibility:visible; z-index:999; 
    position:absolute; top:-500px; left:-500px;">
    </iframe>
<table border="0" width="100%">
  <tr>
  	<th class="label">Colaborador*</th>
    <td><select name="idColaborador" >
    	<option value='0'>Selecione...</option>
        <%@include file="../WEB-INF/jspf/combo/comboColaborador.jspf" %></select>
        <script>comboSelect(document.forms[0].idColaborador, '<%=idColaborador%>');</script>
    </td>
  </tr>
  <tr>
  	<th class="label">Conta De*</th>
    <td><select name="idContaDe" >
    	<option value='0'>Selecione...</option>
        <%@include file="../WEB-INF/jspf/combo/comboConta.jspf" %></select>
        <script>comboSelect(document.forms[0].idContaDe, '<%=idContaDe%>');</script>
    </td>
  </tr>
  <tr>
  	<th class="label">Conta Para*</th>
    <td><select name="idContaPara" >
    	<option value='0'>Selecione...</option>
        <%@include file="../WEB-INF/jspf/combo/comboContaPara.jspf" %></select>
        <script>comboSelect(document.forms[0].idContaPara, '<%=idContaPara%>');</script>
    </td>
  </tr>
  <tr>
  	<th class="label">Valor</th>
    <td><input type="text" name="valor" value="<%=Utilitaria.formatarNumero(valor,2).toString()%>"  onkeyup="FormataValor(this,event)" size="40" maxlength="40"></td>
  </tr>
  <tr>  
    <th class="label">Quantidade Parcelas</th>
    <td><input type="text" name="quantParcelas" value="<%=quantParcelas%>"  size="40" maxlength="40"></td>
  </tr>
  <tr>
    <th class="label">Data de Lançamento*</th>
    <td>
    	<input type="text" name="dtLanc" size="15" <%if (dtLanc != null) { %>value="<%=dtLanc%>"<%} %> onblur="chkData(this,'dd/MM/yyyy')" maxlength="10" class="inputs">
		<a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dtLanc);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
    </td>
  </tr>
  <tr>
    <th class="label">Informar Parcelas</th>
      <td class="label_radio"><input type="radio" class="radio" name="informaParcelas" value="A" <%= (informaParcelas.equals("A")? "checked": "") %>>Sim
      <input type="radio" class="radio" name="informaParcelas" value="I" <%=(informaParcelas.equals("I")? "checked": "") %>>Não</td>
  </tr>  
  <tr>
    <th class="label">Lançamento Automático</th>
    <td class="label_radio"><input type="radio" class="radio" name="lancaAutomatico" value="A" <%= (lancaAutomatico.equals("A")? "checked": "") %>>Sim
    	<input type="radio" class="radio" name="lancaAutomatico" value="I" <%= (lancaAutomatico.equals("I")? "checked": "") %>>Não
   	</td>
  </tr>
  <tr>
  	<th class="label">Histórico</th>
    <td><textarea name="historico" cols="60" rows="5" ><%=historico%></textarea></td>
  </tr>
  <tr>
  	<th class="label">Tipo de Frequência*</th>
    <td><select name="cdTipoFrequencia">
    	<option value='0'>Selecione...</option>
        <%@include file="../WEB-INF/jspf/combo/comboTipoFrequencia.jspf" %></select>
        <script>comboSelect(document.forms[0].cdTipoFrequencia, '<%=cdTipoFrequencia%>');</script>
    </td>
  </tr>
  <tr>
  	<th class="label">Data do Último Lançamento</th>
  	<td>
  		<input type="text" name="dtUltimoLanc" size="15" <%if (dtUltimoLanc != null) { %>value="<%=dtUltimoLanc%>"<%} %> onblur="chkData(this,'dd/MM/yyyy')" maxlength="10" class="inputs">
		<a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dtUltimoLanc);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
    </td>
  </tr>
  <tr>
    <th class="label">Forma Movimento ???</th>
    <td class="label_radio"><input type="radio" class="radio" name="formaMovto" value="S" <%= (formaMovto.equals("S")? "checked": "") %>>Sim
    	<input type="radio" class="radio" name="formaMovto" value="N" <%= (formaMovto.equals("N")? "checked": "") %>>Não
    </td>
  </tr>
  <tr>
  	<th class="label">Status</th>
  	<td class="label_radio"><input type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Ativo
  		<input type="radio" class="radio" name="status" value="I" <%= (status.equals("I")? "checked": "") %>>Inativo
  		<input type="radio" class="radio" name="status" value="EF" <%= (status.equals("EF")? "checked": "") %>>Efetuada
  	</td>  	   
  </tr>
  
 
</table><hr>
 
<%if(acao.equals("atu")){%>
<table border="0" width="100%"> 
  	<tr>
  	    <th class="label">Registros:</th>
   	 	<td class="label_menor"><center>&nbsp; Data de Cadastro: <%if(dtCad != null) { %> <%=dtCad%><%}%> &nbsp;</center></td>
   	 	<td class="label_menor"><center>&nbsp; Última Modificação:<%if(dtMod != null){ %><%=dtMod %> <%} %>&nbsp;</center></td>
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
</form>
<%@include file="../fimConexao.jsp"%>
</body>
</html>