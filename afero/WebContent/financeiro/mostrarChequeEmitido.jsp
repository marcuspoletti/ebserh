<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.ChegueEmitido"%>
<%@page import="afero.model.Colaborador"%>
<%@page import="afero.model.Entidade"%>
<%@page import="afero.util.Utilitaria"%>
<%@page import="afero.persistence.ChegueEmitidoDAO"%>
<%@page import="afero.persistence.ColaboradorDAO"%>
<%@page import="afero.util.ConverteDate"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script language=JavaScript src="../js/abas.js" type=text/javascript></script>
<script src="../js/common.js" /></script>
<script>
function salvar() {
   if (document.all.idLoja.value == '0') {
   		window.alert("O campo Loja é obrigatório.");
    	document.all.idLoja.focus();
   }else if (document.all.idConta.value == '0') {
   	  window.alert("O campo Conta é obrigatório.");
      document.all.idConta.focus();
   }else if (document.all.nrChegue.value == '0') {
      window.alert("O campo Número do Chegue é obrigatório.");
    	document.all.nrChegue.focus();
   }else if (document.all.valor.value == '0,00') {
	  window.alert("O campo Valor é obrigatório.");
	  document.all.valor.focus();
   }else if (document.all.favorecido.value == "") {
		  window.alert("O campo Favorecido é obrigatório.");
		  document.all.favorecido.focus();
   }else{
      document.forms[0].submit();   
   } 	
  }
function recarregar(acao) {
  document.forms[0].action='formChegueEmitido.jsp?acao='+acao;
  document.forms[0].submit();
}
function cancelar() {
  document.forms[0].action="formChegueEmitido.jsp";
  document.forms[0].submit();
}
function voltar() {
  document.forms[0].action = 'listarChegueEmitido.jsp?acao=voltar'
	document.forms[0].submit();
}

</script>
</head>
<%
ColaboradorDAO daoDuplicataColaborador = new ColaboradorDAO(conn);

String idUsuario = (String)session.getAttribute("idUsuario");

Colaborador colaboradorDuplicata = daoDuplicataColaborador.procurarColaboradorUsuario(Integer.parseInt(idUsuario));

String acao = request.getParameter("acao");

String idChegueEmitido = request.getParameter("idChegueEmitido");

String idLoja = request.getParameter("idLoja");

String idConta = request.getParameter("idConta");

String idContaMovto = request.getParameter("idContaMovto");

String nrChegue = request.getParameter("nrChegue");

String valor = request.getParameter("valor");

String dtEmissao = request.getParameter("dtEmissao");

String dtVenc = request.getParameter("dtVenc");

String favorecido = request.getParameter("favorecido");

String cpfCnpj = request.getParameter("cpfCnpj");

String dtPagto = request.getParameter("dtPagto");

String status = request.getParameter("status");

String dtCad = request.getParameter("dtCad");

String dtMod = request.getParameter("dtMod");

String usuario = (String) session.getAttribute("Login");

if (acao == null) acao = "inc";

if (idChegueEmitido == null) idChegueEmitido = "0";

if (idLoja == null) idLoja = "0";

if (idConta == null) idConta = "0";

if(nrChegue == null)nrChegue="0";

if (valor == null)valor = "0";

if(dtEmissao == null)dtEmissao = "";

if(dtVenc == null)dtVenc = "";

if(favorecido == null)favorecido = "";

if(cpfCnpj == null)cpfCnpj = "";

if (dtPagto == null)dtPagto = "";

if(idContaMovto == null)idContaMovto = "0";

if (status == null)status="A";

if (dtCad == null)dtCad = "";

if (dtMod == null)dtMod = "";


//Nome da Entidade
String dsEntidade = request.getParameter("dsEntidade");
if(dsEntidade == null)dsEntidade = "";

//verifica se acao foi atualizar
if (acao.equalsIgnoreCase("atu")) {
    ChegueEmitidoDAO dao = new ChegueEmitidoDAO(conn);
    ChegueEmitido chegueEmitido = dao.procurarChegueEmitido(Integer.parseInt(idChegueEmitido));
	
	idLoja = "".valueOf(chegueEmitido.getIdLoja());
	idConta = "".valueOf(chegueEmitido.getIdConta());
	nrChegue = "".valueOf(chegueEmitido.getNrChegue());
	valor = "".valueOf(chegueEmitido.getValor());
	if(chegueEmitido.getDtEmissao() != null){
		dtEmissao = ConverteDate.dateToString(chegueEmitido.getDtEmissao());	
	}
	if(chegueEmitido.getDtVenc() != null){
		dtVenc = ConverteDate.dateToString(chegueEmitido.getDtVenc());
	}
	favorecido = chegueEmitido.getFavorecido();
	cpfCnpj = chegueEmitido.getCpfCnpj();
	
	if(chegueEmitido.getDtPagto() != null){
		dtPagto = ConverteDate.dateToString(chegueEmitido.getDtPagto());
	}
	idContaMovto = "".valueOf(chegueEmitido.getIdContaMovto());
	status = chegueEmitido.getStatus();
	if(chegueEmitido.getDtCad() != null){
		dtCad = ConverteDate.dateToString(chegueEmitido.getDtCad());
	}
	if(chegueEmitido.getDtMod() != null){
		dtMod = ConverteDate.dateToString(chegueEmitido.getDtMod());
	}
         usuario = chegueEmitido.getUsuario();
}
%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Chegue Emitido</h1>
<form method="post" action="listarChegueEmitido.jsp?acao=<%=acao%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="usuario" value="<%=usuario%>"/>
<input type="hidden" name="idChegueEmitido" value="<%=idChegueEmitido%>"/>


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
    <th class="label">Conta*</th>
    <td><select name="idConta" >
        <option value='0'>Selecione...</option>
        <%@include file="../WEB-INF/jspf/combo/comboConta.jspf" %></select>
        <script>comboSelect(document.forms[0].idConta, '<%=idConta%>');</script>
    </td>
  </tr>
  <tr>
    <th class="label">Chegue*</th>
    <td><input type="text" name="nrChegue" <%if (nrChegue != null) { %>value="<%=nrChegue%>"<% }%>  size="40" maxlength="40"></td>
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
    <td><input type="text" name="valor" value="<%=Utilitaria.formatarNumero(Float.parseFloat(valor),2).toString()%>"  onkeyup="FormataValor(this,event)" size="40" maxlength="40"></td>
  </tr>
  <tr>  
    <th class="label">Favorecido</th>
    <td><input type="text" name="favorecido" value="<%=favorecido%>" size="40" maxlength="60"></td>
  </tr>
  <tr>
	<th class="label">CPF/CNPJ</th>
	<td><input type="text" name="cpfCnpj" value="<%=cpfCnpj%>"
	size="20" maxlength="18" onblur="chkCPFCNPJ(this)"></td>
 </tr>
  <tr>
    <th class="label">Compesação</th>
   <td>
	     <input type="text" name="dtPagto" size="15" <%if (dtPagto != null) { %>value="<%=dtPagto%>"<%} %> onblur="chkData(this,'dd/MM/yyyy')" maxlength="10" class="inputs">
		 <a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dtPagto);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
    </td>
  </tr>
	<tr>
    <th class="label">Status</th>
      <td class="label_radio">
      <input type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>A Pagar
      <input type="radio" class="radio" name="status" value="P" <%= (status.equals("P")? "checked": "") %>>Pago ao favorecido
      <input type="radio" class="radio" name="status" value="D" <%= (status.equals("D")? "checked": "") %>>Devolvido
      <input type="radio" class="radio" name="status" value="Q" <%= (status.equals("Q")? "checked": "") %>>Devolvido/Quitado</td>
  </tr>
  <%
    if(acao.equalsIgnoreCase("atu")){
   %>
     	<tr>
  	    <th class="label">Registros:</th>
   	 	<td class="label_menor"><center>&nbsp Registro: <%if (dtCad != null) { %><%=dtCad%><% }%>&nbsp</center></td>
   	 	<td class="label_menor"><center>&nbsp Modificação: <%if (dtMod != null) { %><%=dtMod%><% }%>&nbsp</center></td>
   	 	<td class="label_menor"><center>&nbsp Usuário: <%if (usuario != null) { %><%=usuario%><% }%>&nbsp</center></td>
  	    
	</tr>
  <%
    }
  %>  
</table>
<hr>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
	<td><input class="button" type="button" value="Voltar" onClick="javascript: voltar();" /></td>
	<td class="campo_obrigatorio">* Campos Obrigatórios</td>
</tr>
</table>
</form>
<%@include file="../fimConexao.jsp"%>
</body>
</html>