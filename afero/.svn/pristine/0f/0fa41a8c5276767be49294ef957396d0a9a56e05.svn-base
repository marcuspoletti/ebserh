<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="aferopet.model.AnimalRetorno"%>
<%@page import="aferopet.model.Animal"%>
<%@page import="afero.util.ConverteDate"%>
<%@page import="aferopet.persistence.AnimalRetornoDAO"%>
<%@page import="aferopet.persistence.AnimalDAO"%>
<%@page import ="java.util.*" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/></script>

<script>
function salvar() {
	if (document.all.dtRetorno.value == '') {
   	window.alert("O campo Data de Retorno é obrigatório.");
   	document.all.dtRetorno.focus();
	} else if (document.all.descricao.value == '') {
	    window.alert("O campo Descrição Atividade é obrigatório.");
	    document.all.descricao.focus();
	} else if (document.all.avisoTempo.value == '' && document.all.avisoUnidade.value != '0') {
	    window.alert("O campo Lembrete não informado o tempo.");
	    document.all.avisoTempo.focus();
	} else if (!document.all.avisoTempo.value == '' && document.all.avisoUnidade.value == '0') {
	    window.alert("O campo Lembrete não informado a unidade do tempo");
	    document.all.avisoUnidade.focus();
  } else {
  	document.forms[0].submit();
  }
}

function cancelar() {
  document.forms[0].action="formAnimalRetorno.jsp";
  document.forms[0].submit();
}

function recarregar(acao) {
  document.forms[0].action='formAnimalRetorno.jsp?acao='+acao;
  document.forms[0].submit();
}

function voltar() {
  document.forms[0].action = 'listarAnimalRetorno.jsp?acao=voltar'
	document.forms[0].submit();
}  

</script>
</head>
<%
String acao = request.getParameter("acao");
if (acao == null) acao = "inc";
String mensagem = request.getParameter("mensagem");
if (mensagem == null) mensagem = "mensagem";
String usuario =(String)session.getAttribute("Login");
if (usuario == null) usuario = "";
String idAnimalRetorno = request.getParameter("idAnimalRetorno");
if (idAnimalRetorno == null) idAnimalRetorno = "0";
String idAnimal = request.getParameter("idAnimal");
if(idAnimal == null) idAnimal = "0";
ConverteDate converte = new ConverteDate();

String dtRetorno = "";
String descricao = "";
String lembrete = "N";
String avisoTempo = "";
String avisoUnidade = "0";
String status = "A";
String dtMod = "";

//verifica se acao foi atualizar
if (acao.equalsIgnoreCase("atu")){
	
	AnimalRetornoDAO dao = new AnimalRetornoDAO(conn);
  AnimalRetorno animalRetorno = dao.procurarAnimalRetorno(Integer.parseInt(idAnimalRetorno));
  if (idAnimal.equals("0")) {
	  idAnimal = Integer.toString(animalRetorno.getIdAnimal());
  }
	if(animalRetorno.getDtRetorno() != null){
		dtRetorno = ConverteDate.dateToString(animalRetorno.getDtRetorno());	
	}
  descricao = animalRetorno.getDescricao();
  lembrete = animalRetorno.getLembrete();
  if (animalRetorno.getAvisoTempo()>0)
    avisoTempo = Integer.toString(animalRetorno.getAvisoTempo());
  avisoUnidade = animalRetorno.getAvisoUnidade();
	status = animalRetorno.getStatus();
	dtMod = animalRetorno.getDtMod().toString();
	    	
}

%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Animal - Retorno</h1>
<form method="post" action="listarAnimalRetorno.jsp?acao=<%=acao%>&idAnimalRetorno=<%=idAnimalRetorno%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="usuario" value="<%=usuario%>"/>
<input type="hidden" name="idAnimalRetorno" value="<%=idAnimalRetorno%>">
<input type="hidden" name="idAnimal" value="<%=idAnimal%>">
<iframe width=174 height=189 name="gToday:normal:"../js/calendar/agenda.js"
            id="gToday:normal:"../js/calendar/agenda.js" src="../js/calendar/ipopeng.htm"
            scrolling="no" frameborder="0" style="visibility:visible; z-index:999; 
    position:absolute; top:-500px; left:-500px;">
</iframe>
<table border="0" width="100%">
  <tr>
  <th class="label">Data Retorno*</th>
    <td>
	    <input type="text" name="dtRetorno" size="15" <%if (dtRetorno != null) { %>value="<%=dtRetorno%>"<%} %> onblur="chkData(this,'dd/MM/yyyy')" maxlength="10" class="inputs">
		  <a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dtRetorno);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
    </td>
  </tr>
  <tr>
    <th class="label">Descrição Atividade*</th>
    <td><input type="text" id="descricao" name="descricao" <%if (descricao != null) { %>value="<%=descricao%>"<% }%>  size="100" maxlength="100"></td>
  </tr>
  <tr>
    <th class="label">Lembrete</th>
      <td class="label">  
        <input type="text" id="avisoTempo" name="avisoTempo" <%if (avisoTempo != null) { %>value="<%=avisoTempo%>"<% }%>  size="4" maxlength="3">
      <select name="avisoUnidade">
        <option value='0'>Selecione...</option>
        <%@include file="../WEB-INF/jspf/combo/comboAvisoUnidade.jsp" %></select>
        <script>comboSelect(document.forms[0].avisoUnidade, '<%= avisoUnidade %>');</script></td>
  </tr>
  <tr>
    <th class="label">Status</th>
      <td class="label_radio">
      <input type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Agendado
      <input type="radio" class="radio" name="status" value="C" <%= (status.equals("C")? "checked": "") %>>Cancelado    
      <input type="radio" class="radio" name="status" value="R" <%= (status.equals("R")? "checked": "") %>>Realizado    
      <input type="radio" class="radio" name="status" value="N" <%= (status.equals("N")? "checked": "") %>>Não compareceu</td>    
  </tr>
  <%if(acao.equals("atu")){%>
  
  	<tr>
   	 	<td class="label_menor"></td>
 	    <td class="label_menor"><center>&nbsp Modificação: <%if (dtMod != null) { %><%=converte.DMYToYMD(dtMod)%><% }%>&nbsp</center></td>
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