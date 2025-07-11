<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="aferopet.model.AnimalFicha"%>
<%@page import="aferopet.model.Animal"%>
<%@page import="afero.util.ConverteDate"%>
<%@page import="aferopet.persistence.AnimalFichaDAO"%>
<%@page import="aferopet.persistence.AnimalDAO"%>
<%@page import ="java.util.*" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/></script>

<script>
function salvar() {
	if (document.all.dtAtend.value == '') {
   	window.alert("O campo Data de Atendimento é obrigatório.");
   	document.all.dtAtend.focus();
	} else if (document.all.descricao.value == '') {
	    window.alert("O campo Descrição Atendimento é obrigatório.");
	    document.all.descricao.focus();
  } else {
  	document.forms[0].submit();
  }
}

function cancelar() {
  document.forms[0].action="formAnimalFicha.jsp";
  document.forms[0].submit();
}

function recarregar(acao) {
  document.forms[0].action='formAnimalFicha.jsp?acao='+acao;
  document.forms[0].submit();
}

function voltar() {
  document.forms[0].action = 'listarAnimalFicha.jsp?acao=voltar'
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
String idAnimalFicha = request.getParameter("idAnimalFicha");
if (idAnimalFicha == null) idAnimalFicha = "0";
String idAnimal = request.getParameter("idAnimal");
if(idAnimal == null) idAnimal = "0";
ConverteDate converte = new ConverteDate();

String dtAtend = "";
String descricao = "";
String peso = "";
String altura = "";
String observacao = "";
String exame = "";
String tipoAtividade = "C";
String dtMod = "";

//verifica se acao foi atualizar
if (acao.equalsIgnoreCase("atu")){
	
	AnimalFichaDAO dao = new AnimalFichaDAO(conn);
  AnimalFicha animalFicha = dao.procurarAnimalFicha(Integer.parseInt(idAnimalFicha));
  if (idAnimal.equals("0")) {
	  idAnimal = Integer.toString(animalFicha.getIdAnimal());
  }
	if(animalFicha.getDtAtend() != null){
		dtAtend = ConverteDate.dateToString(animalFicha.getDtAtend());	
	}
  descricao = animalFicha.getDescricao();
  if (animalFicha.getPeso()>0)
  	peso = Integer.toString(animalFicha.getPeso());
  if (animalFicha.getAltura()>0)
    altura = Integer.toString(animalFicha.getAltura());
  observacao = animalFicha.getObservacao();
  exame = animalFicha.getExame();
	tipoAtividade = animalFicha.getTipoAtividade();
	dtMod = animalFicha.getDtMod().toString();
	    	
}

%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Animal - Ficha Clínica</h1>
<form method="post" action="listarAnimalFicha.jsp?acao=<%=acao%>&idAnimalFicha=<%=idAnimalFicha%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="usuario" value="<%=usuario%>"/>
<input type="hidden" name="idAnimalFicha" value="<%=idAnimalFicha%>">
<input type="hidden" name="idAnimal" value="<%=idAnimal%>">
<iframe width=174 height=189 name="gToday:normal:"../js/calendar/agenda.js"
            id="gToday:normal:"../js/calendar/agenda.js" src="../js/calendar/ipopeng.htm"
            scrolling="no" frameborder="0" style="visibility:visible; z-index:999; 
    position:absolute; top:-500px; left:-500px;">
</iframe>
<table border="0" width="100%">
  <tr>
  <th class="label">Data Atendimento*</th>
    <td>
	    <input type="text" name="dtAtend" size="15" <%if (dtAtend != null) { %>value="<%=dtAtend%>"<%} %> onblur="chkData(this,'dd/MM/yyyy')" maxlength="10" class="inputs">
		  <a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dtAtend);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
    </td>
  </tr>
  <tr>
      <th class="label">Descrição Atendimento*</th>
      <td><textarea id="descricao" name="descricao" cols="100" rows="4" ><%=descricao%></textarea></td>
  </tr>
  <tr>
    <th class="label">Peso</th>
    <td><input type="text" id="peso" name="peso" <%if (peso != null) { %>value="<%=peso%>"<% }%>  size="5" maxlength="4"></td>
  </tr>
  <tr>
    <th class="label">Altura</th>
    <td><input type="text" id="altura" name="altura" <%if (altura != null) { %>value="<%=altura%>"<% }%>  size="5" maxlength="4"></td>
  </tr>
  <tr>
      <th class="label">Observação</th>
      <td><textarea name="observacao" cols="100" rows="2" ><%=observacao%></textarea></td>
  </tr>
  <tr>
      <th class="label">Exames</th>
      <td><textarea name="exame" cols="100" rows="4" ><%=exame%></textarea></td>
  </tr>
  <tr>
    <th class="label">Tipo Atividade</th>
      <td class="label_radio">
      <input type="radio" class="radio" name="tipoAtividade" value="C" <%= (tipoAtividade.equals("C")? "checked": "") %>>Primeira Consulta
      <input type="radio" class="radio" name="tipoAtividade" value="R" <%= (tipoAtividade.equals("R")? "checked": "") %>>Retorno</td>    
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