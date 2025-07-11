<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.Conta"%>
<%@page import="afero.model.Colaborador"%>
<%@page import="afero.persistence.ColaboradorDAO"%>
<%@page import="afero.persistence.ContaDAO"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<%@page import="afero.util.ConverteDate"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script language=JavaScript src="../js/abas.js" type=text/javascript></script>
<script src="../js/common.js" /></script>
<script>
function salvar() {
  if (document.all.idLoja.value == '0') {
    window.alert("O campo Loja é obrigatório.");
    document.all.idLoja.focus();
  } else if (document.all.nmConta.value == ''){
      window.alert("O campo Nome Conta é obrigatório.");
      document.all.nmConta.focus();
   } else if (document.all.idTipoConta.value == '0'){
      window.alert("O campo Tipo de Conta é obrigatório.");
      document.all.idTipoConta.focus();
// } else if (document.all.idBanco.value == '0'){
//    window.alert("O campo Banco é obrigatório.");
//    document.all.idBanco.focus();
//   } else if (document.all.dtVencLimite.value == ''){
//      window.alert("O campo Data do Vencimento Limite é obrigatório.");
//      document.all.dtVencLimite.focus();
//   } else if (document.all.dtSaldoAbertura.value == ''){
//      window.alert("O campo Data do Saldo de Abertura é obrigatório.");
//      document.all.dtSaldoAbertura.focus();
   } else {
  	document.forms[0].submit();
  }
}

function cancelar() {
  document.forms[0].action="formConta.jsp";
  document.forms[0].submit();
}

function voltar() {
  document.forms[0].action = 'listarConta.jsp?acao=voltar'
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
String idConta = request.getParameter("idConta");
if(idConta == null)idConta = "0";
String idUsuario = (String)session.getAttribute("idUsuario");
ColaboradorDAO daoColaborador = new ColaboradorDAO(conn);
Colaborador colaboradorConta = daoColaborador.procurarColaboradorUsuario(Integer.parseInt(idUsuario));
if (acao == null) acao = "inc";
if (idConta == null) idConta = "0";
String idLoja = request.getParameter("idLoja");
if(idLoja == null)idLoja = "".valueOf(colaboradorConta.getIdLoja());
String idTipoConta = "0";
String idBanco = "0";
String nmConta = "";
String agencia = "";
String contaCorrente = "";
float vlLimiteCredito = 0;
String dtVencLimite = "";
String dtSaldoAbertura = "";
float vlSaldoAbertura = 0;
String paginaInicial = "S";
String status ="A";
String pessoaContato = "";
String nroTelefone = "";
String email = "";
String site = "";
String observacao = "";
String dtCad = "";
String dtMod = "";
String usuario = (String) session.getAttribute("Login");


//verifica se acao foi atualizar
if (acao.equalsIgnoreCase("atu")) {
    ContaDAO dao = new ContaDAO(conn);
    Conta conta = dao.procurarConta(Integer.parseInt(idConta));
    nmConta = conta.getNmConta();
    idLoja = "".valueOf(conta.getIdLoja());
    idTipoConta = "".valueOf(conta.getIdTipoConta());
    idBanco = "".valueOf(conta.getIdBanco());
    agencia = conta.getAgencia();
    contaCorrente = conta.getContaCorrente();
    vlLimiteCredito = conta.getVlLimiteCredito();
    if(conta.getDtVencLimite() != null){
    	dtVencLimite = ConverteDate.dateToString(conta.getDtVencLimite());
    }
    if(conta.getDtSaldoAbertura() != null){
    	dtSaldoAbertura = ConverteDate.dateToString(conta.getDtSaldoAbertura());
    }
    vlSaldoAbertura = conta.getVlSaldoAbertura();
    paginaInicial = conta.getPaginaInicial();
    status = conta.getStatus();
    pessoaContato = conta.getPessoaContato();
    nroTelefone = conta.getNroTelefone();
    email = conta.getEmail();
    site = conta.getSite();
    observacao = conta.getObservacao();
    if(conta.getDtCad() != null){
    	 dtCad = ConverteDate.dateToString(conta.getDtCad());
    }
    if(conta.getDtMod()!= null){
    	dtMod = ConverteDate.dateToString(conta.getDtMod());
    }
    usuario = (String) session.getAttribute("Login");

    
}
%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Conta</h1>
<form method="post" action="listarConta.jsp?acao=<%=acao%>">
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
          <script>comboSelect(document.forms[0].idLoja, '<%= idLoja %>');</script>
      </td>
  </tr>
  <tr>
    <th class="label">Nome da Conta*</th>
    <td><input type="text" name="nmConta" <%if (nmConta != null) { %>value="<%=nmConta%>"<% }%>  size="60" maxlength="50"></td>
  </tr>
    <tr>
      <th class="label">Tipo de Conta*</th>
      <td><select name="idTipoConta">
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboTipoConta.jspf" %></select>
          <script>comboSelect(document.forms[0].idTipoConta, '<%= idTipoConta %>');</script>
      </td>
  </tr>
      <tr>
      <th class="label">Banco</th>
      <td><select name="idBanco">
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboBanco.jspf" %></select>
          <script>comboSelect(document.forms[0].idBanco, '<%= idBanco %>');</script>
      </td>
  </tr>
  <tr>
    <th class="label">Agência</th>
    <td><input type="text" name="agencia" <%if (agencia != null) { %>value="<%=agencia%>"<% }%>  size="10" maxlength="6"></td>
  </tr>
  <tr>
    <th class="label">Conta Corrente</th>
    <td><input type="text" name="contaCorrente" <%if (contaCorrente != null) { %>value="<%=contaCorrente%>"<% }%>  size="20" maxlength="10"></td>
  </tr>
  </tr>
<!--
    <tr>
    <th class="label">Saldo Inicial</th>
    <td><input type="text" name="vlSaldoAbertura" value="<%=vlSaldoAbertura%>" onkeyup="FormataValor(this,event)" size="20" maxlength="20"></td>
  </tr>
    <tr>
    <th class="label">Data do Saldo Inicial*</th>
    <td>
	     <input type="text" name="dtSaldoAbertura" size="15" <%if (dtSaldoAbertura != null) { %>value="<%=dtSaldoAbertura%>"<%} %> onblur="chkData(this,'dd/MM/yyyy')" maxlength="10" class="inputs">
		 <a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dtSaldoAbertura);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
    </td>
  </tr>
-->
  <tr>
    <th class="label">Limite</th>
    <td><input type="text" name="vlLimiteCredito" value="<%=vlLimiteCredito%>" onkeyup="FormataValor(this,event)" size="20" maxlength="20"></td>
  </tr>
<!--
	<tr>
    <th class="label">Data do Vencimento Limite</th>
   <td>
	     <input type="text" name="dtVencLimite" size="15" <%if (dtVencLimite != null) { %>value="<%=dtVencLimite%>"<%} %> onblur="chkData(this,'dd/MM/yyyy')" maxlength="10" class="inputs">
		 <a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dtVencLimite);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
    </td>
-->
  <tr>
    <th class="label">Pessoa Contato</th>
    <td><input type="text" name="pessoaContato" <%if (pessoaContato != null) { %>value="<%=pessoaContato%>"<% }%>  size="60" maxlength="60"></td>
  </tr>
  <tr>
    <th class="label">Número do Telefone</th>
    <td><input type="text" name="nroTelefone" <%if (nroTelefone != null) { %>value="<%=nroTelefone%>"<% }%>  size="20" maxlength="15"></td>
  </tr>
    <tr>
    <th class="label">Email</th>
    <td><input type="text" name="email" <%if (email != null) { %>value="<%=email%>"<% }%>  size="60" maxlength="60"></td>
  </tr>
      <tr>
    <th class="label">Site</th>
    <td><input type="text" name="site" <%if (site != null) { %>value="<%=site%>"<% }%>  size="60" maxlength="60"></td>
  </tr>
  <tr>
      <th class="label">Observação</th>
      <td><textarea name="observacao" cols="50" rows="2" ><%=observacao%></textarea></td>
  </tr> 
<!--
  <tr>
    <th class="label">Página Inicial</th>
      <td class="label_radio"><input type="radio" class="radio" name="paginaInicial" value="S" <%= (paginaInicial.equals("S")? "checked": "") %>>Sim
      <input type="radio" class="radio" name="paginaInicial" value="N" <%= (paginaInicial.equals("N")? "checked": "") %>>Não</td>
    
  </tr>
-->
  <tr>
    <th class="label">Ativo</th>
      <td class="label_radio"><input type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Sim
      <input type="radio" class="radio" name="status" value="I" <%= (status.equals("I")? "checked": "") %>>Não</td>
    
  </tr>
</table><hr>
 <table border="0" width="100%">
  <%if(acao.equals("atu")){%>
  
  	<tr>
  	    <th class="label">Registros:</th>
   	 	<td class="label_menor"><center>&nbsp Registro: <%if (dtCad != null) { %><%=dtCad%><% }%>&nbsp</center></td>
  	    <td class="label_menor"><center>&nbsp Modificação: <%if (dtMod != null) { %><%=dtMod%><% }%>&nbsp</center></td>
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
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="idConta" value="<%=idConta%>"/>
<input type="hidden" name="usuario" value="<%=usuario%>"/>
</form>
<%@include file="../fimConexao.jsp"%>
</body>
</html>