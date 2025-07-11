<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.ChegueRecebido"%>
<%@page import="afero.model.Entidade"%>
<%@page import="afero.util.*"%>
<%@page import="afero.persistence.ChequeRecebidoDAO"%>
<%@page import="afero.persistence.EntidadeDAO"%>
<%@page import="afero.model.Colaborador"%>
<%@page import="afero.persistence.ColaboradorDAO"%>
<%@page import="afero.util.ConverteDate"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script language=JavaScript src="../js/abas.js" type=text/javascript></script>
<script src="../js/common.js" /></script>
<script>
function Salvar() {
	 if (document.all.idLoja.value == '0') {
	 		window.alert("O campo Loja é obrigatório.");
	   	document.all.idLoja.focus();
	} else if (document.all.dsEntidade.value == "") {
		  window.alert("O campo Entidade é obrigatório.");
		  document.all.dsEntidade.focus();
	} else if (document.all.idBanco.value == '0') {
		  window.alert("O campo Banco é obrigatório.");
		  document.all.idBanco.focus();
	} else if (document.all.nrCheque.value == '0') {
	    window.alert("O campo Número do Chegue é obrigatório.");
   		document.all.nrCheque.focus();
 	} else if (document.all.dtEmissao.value == '') {
		  window.alert("O campo Data de Emissão é obrigatório.");
		  document.all.dtEmissao.focus();
	} else if (document.all.valor.value == '0,00') {
	  	window.alert("O campo Valor  é obrigatório.");
   		document.all.valor.focus();
 	} else {
		  document.forms[0].submit();
 }

}
function recarregar(acao) {
  document.forms[0].action='formChequeRecebido.jsp?acao='+acao;
  document.forms[0].submit();
}
function cancelar() {
  document.forms[0].action="formChequeRecebido.jsp";
  document.forms[0].submit();
}

function voltar() {
  document.forms[0].action = 'listarChequeRecebido.jsp?acao=voltar';
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
ColaboradorDAO daoDuplicataColaborador = new ColaboradorDAO(conn);

String idUsuario = (String)session.getAttribute("idUsuario");

Colaborador colaboradorDuplicata = daoDuplicataColaborador.procurarColaboradorUsuario(Integer.parseInt(idUsuario));

//Atributos

String idLoja = "0";
String cdEntidade = "0";
String idBanco;
String agencia;
String dvAgencia;
String contaCorrente;
String dvConta;
String nrCheque ="0";
String valor;
String dtEmissao;
String dtVenc;
String correntista;
String cpfCnpj;
String destino;
String observacao;
String dtReceb;
String idContaMovto;
String status;
String dtCad;
String dtMod;


// Requests

	String acao = request.getParameter("acao");
	
	String idChequeRecebido = request.getParameter("idChequeRecebido");
	
	String usuario = (String) session.getAttribute("Login");
	
	idLoja = request.getParameter("idLoja");

	cdEntidade = request.getParameter("cdEntidade");
	
	idBanco = request.getParameter("idBanco");
	
	agencia = request.getParameter("agencia");
	
	dvAgencia = request.getParameter("dvAgencia");
	
	contaCorrente = request.getParameter("contaCorrente");
	
	dvConta = request.getParameter("dvConta");
	
	nrCheque = request.getParameter("nrCheque");
	
	valor = request.getParameter("valor");
	
	dtEmissao = request.getParameter("dtEmissao");
	
	dtVenc = request.getParameter("dtVenc");
	
	correntista = request.getParameter("correntista");
	
	cpfCnpj = request.getParameter("cpfCnpj");
	
	destino = request.getParameter("destino");
	
	observacao = request.getParameter("observacao");
	
	dtReceb = request.getParameter("dtReceb");
	
	idContaMovto = request.getParameter("idContaMovto");
	
	status = request.getParameter("status");
	
	dtCad = request.getParameter("dtCad");
	
	dtMod = request.getParameter("dtMod");


	if (acao == null) acao = "inc";
	
	if (idChequeRecebido == null) idChequeRecebido = "0";
	
	if (idLoja == null) idLoja = "0";

	if (cdEntidade == null) cdEntidade = "0";
	
	if (agencia == null)agencia="";
	
	if (dvAgencia == null)dvAgencia="";
	
	if (dvConta == null)dvConta="";
	
	if (contaCorrente == null)contaCorrente="";
	
	if (correntista == null)correntista="";
	
	if (destino == null)destino = "";
	
	if (observacao == null)observacao = "";
	
	if (dtReceb == null)dtReceb = "";
	
	if (idBanco == null) idBanco = "0";
	
	 if(nrCheque == null)nrCheque="0";
	
	if (valor == null)valor = "0";
	
	if(dtEmissao == null)dtEmissao = "";
	
	if(dtVenc == null)dtVenc = "";
	
	if(cpfCnpj == null)cpfCnpj = "";
	
	if(idContaMovto == null)idContaMovto = "0";
	
	if (status == null)status="A";
	
	if (dtCad == null)dtCad = "";
	
	if (dtMod == null)dtMod = "";

//Nome da Entidade
String dsEntidade = request.getParameter("dsEntidade");
if(dsEntidade == null)dsEntidade = "";

//verifica se acao foi atualizar
if (acao.equalsIgnoreCase("atu")) {
    ChequeRecebidoDAO dao = new ChequeRecebidoDAO(conn);
    int idCheqRecebido = Integer.parseInt(idChequeRecebido); 
    ChegueRecebido chequeRecebido = null;
    chequeRecebido = dao.procurarChegueRecebido(idCheqRecebido);	
		idLoja = "".valueOf(chequeRecebido.getIdLoja());
    cdEntidade = "".valueOf(chequeRecebido.getCdEntidade());
    idBanco = "".valueOf(chequeRecebido.getIdBanco());
    agencia = chequeRecebido.getAgencia();
    dvAgencia = chequeRecebido.getDvAgencia();
    contaCorrente = chequeRecebido.getContaCorrente();
    dvConta = chequeRecebido.getDvConta();
		nrCheque = "".valueOf(chequeRecebido.getNrChegue());
	if(chequeRecebido.getDtEmissao() != null){
		dtEmissao = ConverteDate.dateToString(chequeRecebido.getDtEmissao());	
	}
	if(chequeRecebido.getDtVenc() != null){
		dtVenc = ConverteDate.dateToString(chequeRecebido.getDtVenc());
	}
	valor = "".valueOf(chequeRecebido.getValor());
	correntista = chequeRecebido.getCorrentista();
	cpfCnpj = chequeRecebido.getCpfCnpj();
	destino = chequeRecebido.getDestino();
	observacao = chequeRecebido.getObservacao();
	
	if (chequeRecebido.getDtReceb() != null){
		dtReceb = ConverteDate.dateToString(chequeRecebido.getDtReceb());
	}	
	idContaMovto = "".valueOf(chequeRecebido.getIdContaMovto());
	status = chequeRecebido.getStatus();
	if(chequeRecebido.getDtCad() != null){
		dtCad = ConverteDate.dateToString(chequeRecebido.getDtCad());
	}
	if(chequeRecebido.getDtMod() != null){
		dtMod = ConverteDate.dateToString(chequeRecebido.getDtMod());
	}
    usuario = chequeRecebido.getUsuario();	
    EntidadeDAO daoEntidade = new EntidadeDAO(conn);
    Entidade entidade = daoEntidade.procurarEntidade(Integer.parseInt(cdEntidade));
    dsEntidade = entidade.getNome();
}

%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Cheque Recebido</h1>
<form method="post" action="listarChequeRecebido.jsp?acao=<%=acao%>&idChequeRecebido=<%=idChequeRecebido%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="cdEntidade" value="<%=cdEntidade%>"/>
<input type="hidden" name="usuario" value="<%=usuario%>"/>
<input type="hidden" name="idChequeRecebido" value="<%=idChequeRecebido%>"/>

<iframe width=174 height=189 name="gToday:normal:"../js/calendar/agenda.js"
            id="gToday:normal:"../js/calendar/agenda.js" src="../js/calendar/ipopeng.htm"
            scrolling="no" frameborder="0" style="visibility:visible; z-index:999; 
    position:absolute; top:-500px; left:-500px;">
</iframe>
<table border="0" width="100%">
  <tr>
    <th class="label">Loja*</th>
    <td><select name="idLoja" >
        <option value='0'>Selecione...</option>
        <%@include file="../WEB-INF/jspf/combo/comboLoja.jspf" %></select>
        <script>comboSelect(document.forms[0].idLoja, '<%=idLoja%>');</script>
    </td>
  </tr>
  <tr>
  	<th class="label">Entidade*</th>
  	<td style="height: 15px"><input disabled type="text" name="dsEntidade" <%if (dsEntidade != null) { %>value="<%=dsEntidade%>"<% }%>  size="60" maxlength="60"> 
  	<a href="consultarClientesChegueRecebido.jsp?acao=<%=acao%>&idChequeRecebido=<%=idChequeRecebido%>&idLoja=<%=idLoja%>&cdEntidade=<%=cdEntidade%>&idBanco=<%=idBanco%>&agencia=<%=agencia%>&dvAgencia=<%=dvAgencia%>&dvConta=<%=dvConta%>&contaCorrente=<%=contaCorrente%>&nrCheque=<%=nrCheque%>&valor=<%=valor%>&dtEmissao=<%=dtEmissao%>&dtVenc=<%=dtVenc%>&correntista=<%=correntista%>&cpfCnpjParametro=<%=cpfCnpj%>&destino=<%=destino%>&agencia=<%=agencia%>&dvAgencia=<%=dvAgencia%>&observacao=<%=observacao%>&dtReceb=<%=dtReceb%>&idContaMovto=<%=idContaMovto%>&status=<%=status%>"><img border = "0" src="../images/pesquisa.gif"></a></td>
  </tr>
  <tr>
  	<th class="label">Banco*</th>
  	<td><select name="idBanco" value="<%=idBanco %>">
  		<option value="0">Selecione...</option>
  		<%@include file="../WEB-INF/jspf/combo/comboBanco.jspf" %></select>
  		<script>comboSelect(document.forms[0].idBanco, '<%=idBanco%>');</script>
  	</td>
  </tr>
  <tr>
  	<th class="label">Agência</th>
  	<td><input type="text" name="agencia" <%if (agencia != null) { %>value="<%=agencia%>"<% }%>  size="5" maxlength="5" style="margin-right:5px">-
  		<input type="text" name="dvAgencia" <%if (dvAgencia != null) { %> value="<%=dvAgencia%>"<% } %> size="1" maxlength="1" /></td>
  </tr>
  <tr>
  	<th class="label">Conta Corrente</th>
  	<td><input type="text" name="contaCorrente" <%if (contaCorrente != null) { %>value="<%=contaCorrente%>"<% }%>  size="10" maxlength="10" style="margin-right:5px">-
  		<input type="text" name="dvConta" <%if (dvConta != null) { %>value="<%=dvConta%>"<% } %> size="1" maxlength="1" /></td>
  </tr>
  <tr>
  	<th class="label">Cheque*</th>
  	<td><input type="text" name="nrCheque" <%if (nrCheque != null) { %>value="<%=nrCheque%>"<% }%>  size="15" maxlength="11"></td>
  </tr>
  <tr>
  	<th class="label">Emissão*</th>
  	<td>
  		<input type="text" name="dtEmissao" size="15" <%if (dtEmissao != null) { %>value="<%=dtEmissao%>"<%} %> onblur="chkData(this,'dd/MM/yyyy')" maxlength="10" class="inputs">
  		<a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dtEmissao);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
  	</td>
  </tr>
  <tr>
  	<th class="label">Vencimento</th>
  	<td>
  		<input type="text" name="dtVenc" size="15" <%if (dtVenc != null) { %>value="<%=dtVenc%>"<%} %> onblur="chkData(this,'dd/MM/yyyy')" maxlength="10" class="inputs">
  		<a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dtVenc);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
  	</td>
  </tr>
  <tr>
  	<th class="label">Valor*</th>
  	<td>
  		<input type="text" name="valor" <%if (valor != null) { %> value="<%=Utilitaria.formatarNumero(Float.parseFloat(valor),2).toString()%>"<% } %>  onkeyup="FormataValor(this,event)" size="40" maxlength="40">
  	</td>
  </tr>
  <tr>
  	<th class="label">Correntista*</th>
  	<td>
  		<input type="text" name="correntista" <%if (correntista != null) { %>value="<%=correntista%>"<% }%>  size="40" maxlength="40">
  	</td>
  </tr>
  <tr>
  	<th class="label">CPF/CNPJ</th>
  	<td>
  		<input type="text" name="cpfCnpj" <%if (cpfCnpj != null ) { %> value="<%=cpfCnpj%>" <% } %> size="20" maxlength="18" onblur="chkCPFCNPJ(this)">
  	</td>
  </tr>
  <tr>
  	<th class="label">Destino</th>
  	<td>
  		<textarea name="destino" cols="60" rows="2" maxlength="100" ><%if (destino != null) { %> <%=destino%><% }%></textarea>
  	</td>
  </tr>
  <tr>
  	<th class="label">Observação</th>
  	<td>
  		<textarea name="observacao" cols="60" rows="2" maxlength="100" ><%if (observacao != null) {%> <%=observacao%> <% }%></textarea>
  	</td>
  </tr>
  <tr>
  	<th class="label">Compesação</th>
  	<td>
  		<input type="text" name="dtReceb" size="15" <%if (dtReceb != null) { %>value="<%=dtReceb%>"<%} %> onblur="chkData(this,'dd/MM/yyyy')" maxlength="10" class="inputs">
  		<a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dtReceb);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
  	</td>
  </tr>
	<tr>
    <th class="label">Status</th>
      <td class="label_radio">
      <input type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>A Receber
      <input type="radio" class="radio" name="status" value="R" <%= (status.equals("R")? "checked": "") %>>Recebido
      <input type="radio" class="radio" name="status" value="D" <%= (status.equals("D")? "checked": "") %>>Devolvido
      <input type="radio" class="radio" name="status" value="Q" <%= (status.equals("Q")? "checked": "") %>>Devolvido/Quitado</td>
  </tr>
<% if(acao.equalsIgnoreCase("atu")){ %>
  <tr>
  	<th class="label">Registros:</th>
  	<td class="label_menor"><center>&nbsp Registro: <%if (dtCad != null) { %><%=dtCad%><% }%>&nbsp</center></td>
   	<td class="label_menor"><center>&nbsp Modificação: <%if (dtMod != null) { %><%=dtMod%><% }%>&nbsp</center></td>
   	<td class="label_menor"><center>&nbsp Usuário: <%if (usuario != null) { %><%=usuario%><% }%>&nbsp</center></td>
   </tr>

</table>
<% } %>

<hr>
</form>
<%@include file="../fimConexao.jsp"%>
</body>
</html>