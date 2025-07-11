<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="aferopet.model.Animal"%>
<%@page import="afero.model.Entidade"%>
<%@page import="afero.util.ConverteDate"%>
<%@page import="aferopet.persistence.AnimalDAO"%>
<%@page import="afero.persistence.EntidadeDAO"%>
<%@page import ="java.util.*" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/></script>

<script>
function salvar() {
	if(document.all.nmAnimal.value == '') {
   	window.alert("O campo Nome do Animal é obrigatório.");
   	document.all.nmAnimal.focus();
	}else if (document.all.cdTipoEspecie.value == '0') {
	    window.alert("O campo Tipo de Espécie é obrigatório.");
	    document.all.cdTipoEspecie.focus();
	}else if (document.all.idTipoRaca.value == '0') {
	    window.alert("O campo Tipo de Raça é obrigatório.");
	    document.all.idTipoRaca.focus();
  }else {
  	document.forms[0].submit();
  }
}

function cancelar() {
  document.forms[0].action="formAnimal.jsp";
  document.forms[0].submit();
}

function recarregar(acao) {
  document.forms[0].action='formAnimal.jsp?acao='+acao;
  document.forms[0].submit();
}

function voltar() {
  document.forms[0].action = 'listarAnimal.jsp?acao=voltar'
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
String idAnimal = request.getParameter("idAnimal");
if (idAnimal == null) idAnimal = "0";
String cdEntidade = request.getParameter("cdEntidade");
if (cdEntidade == null) cdEntidade = "0";
String cdTipoEspecie = request.getParameter("cdTipoEspecie");
if (cdTipoEspecie == null) cdTipoEspecie = "0";
String idTipoRaca = request.getParameter("idTipoRaca");
if (idTipoRaca == null) idTipoRaca = "0";
String nmAnimal = request.getParameter("nmAnimal");
if (nmAnimal == null) nmAnimal = "";
ConverteDate converte = new ConverteDate();

//String nmAnimal = "";
String dtNascimento = "";
String sexo = "M";
String porte = "P";
String cor = "";
String registro = "";
String microchip = "";
String passaporte = "";
String origem = "";
String estado = "";
String alergia = "";
String observacao = "";
String obito = "N";
String pedigree = "N";
String status = "A";
String dtMod = "";
String dtCad = "";
String nome = request.getParameter("nome");
if(nome == null) nome = "";

//verifica se acao foi atualizar
if (acao.equalsIgnoreCase("atu")){
	
	AnimalDAO dao = new AnimalDAO(conn);
  Animal animal = dao.procurarAnimal(Integer.parseInt(idAnimal));
  if (cdEntidade.equals("0")) {
	  cdEntidade = Integer.toString(animal.getCdEntidade());
  }
  if (cdTipoEspecie.equals("0")) {
	  cdTipoEspecie = Integer.toString(animal.getCdTipoEspecie());
  }
  if (idTipoRaca.equals("0")) {
	  idTipoRaca = Integer.toString(animal.getIdTipoRaca());
  }
  if (nmAnimal.isEmpty()) {
		nmAnimal = animal.getNmAnimal();
  }
	if(animal.getDtNascimento() != null){
		dtNascimento = ConverteDate.dateToString(animal.getDtNascimento());	
	}
  sexo = animal.getSexo();
  porte = animal.getPorte();
  cor = animal.getCor();
  registro = animal.getRegistro();
  microchip = animal.getMicrochip();
  passaporte = animal.getPassaporte();
  origem = animal.getOrigem();
  estado = animal.getEstado();
  alergia = animal.getAlergia();
  pedigree = animal.getPedigree();
  obito = animal.getObito();
  observacao = animal.getObservacao();
	status = animal.getStatus();
	if(animal.getDtMod() != null){
		dtMod = animal.getDtMod().toString();
	}
	dtCad = animal.getDtCad().toString();
	    	
}
if (!cdEntidade.equals("0")) {
	EntidadeDAO daoEntidade = new EntidadeDAO(conn);
	Entidade entidade = daoEntidade.procurarEntidade(Integer.parseInt(cdEntidade));
	nome = entidade.getNome();
}

%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Animal</h1>
<form method="post" action="listarAnimal.jsp?acao=<%=acao%>&idAnimal=<%=idAnimal%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="usuario" value="<%=usuario%>"/>
<input type="hidden" name="idAnimal" value="<%=idAnimal%>">
<input type="hidden" name="cdEntidade" value="<%=cdEntidade%>">
<iframe width=174 height=189 name="gToday:normal:"../js/calendar/agenda.js"
            id="gToday:normal:"../js/calendar/agenda.js" src="../js/calendar/ipopeng.htm"
            scrolling="no" frameborder="0" style="visibility:visible; z-index:999; 
    position:absolute; top:-500px; left:-500px;">
</iframe>
<%
	String param = "acao="+acao+
		"&idAnimal="+idAnimal+
		"&cdEntidade="+cdEntidade+
		"&cdTipoEspecie="+cdTipoEspecie+
		"&idTipoRaca="+idTipoRaca+
		"&nmAnimal="+nmAnimal;
%>
<table border="0" width="100%">
  <tr>
    <th class="label">Nome Proprietário</th>
    <td><input disabled type="text" name="nome" <%if (nome != null) { %>value="<%=nome%>"<% }%>  size="100" maxlength="100"> <a  href="consultarClientes.jsp?<%=param%>"><img border = "0" src="../images/pesquisa.gif"></a> <font class="campo_obrigatorio">(Consulta)</font></td>
  </tr>
  <tr>
    <th class="label">Nome Animal*</th>
    <td><input type="text" id="nmAnimal" name="nmAnimal" <%if (nmAnimal != null) { %>value="<%=nmAnimal%>"<% }%>  size="60" maxlength="50"></td>
  </tr>
  <tr>
    <th class="label">Tipo de Espécie*</th>
    <td><select name="cdTipoEspecie" style="width: 172px" onchange="recarregar('<%=acao%>');">
        <option value='0'>Selecione...</option>
        <%@include file="../WEB-INF/jspf/combo/comboTipoEspecie.jspf" %></select>
        <script>comboSelect(document.forms[0].cdTipoEspecie, '<%= cdTipoEspecie %>');</script>
    </td>
  </tr>
  <tr>
    <th class="label">Tipo de Raça*</th>
    <td><select name="idTipoRaca" style="width: 172px" onchange="recarregar('<%=acao%>');">
        <option value='0'>Selecione...</option>
        <%@include file="../WEB-INF/jspf/combo/comboTipoRaca.jspf" %></select>
        <script>comboSelect(document.forms[0].idTipoRaca, '<%= idTipoRaca %>');</script>
    </td>
  </tr>
  <tr>
  <th class="label">Data Nascimento</th>
    <td>
	    <input type="text" name="dtNascimento" size="15" <%if (dtNascimento != null) { %>value="<%=dtNascimento%>"<%} %> onblur="chkData(this,'dd/MM/yyyy')" maxlength="10" class="inputs">
		  <a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dtNascimento);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
    </td>
  </tr>
  <tr>
    <th class="label">Sexo</th>
      <td class="label_radio"><input type="radio" class="radio" name="sexo" value="M" <%= (sexo.equals("M")? "checked": "") %>>Macho
      <input type="radio" class="radio" name="sexo" value="F" <%= (sexo.equals("F")? "checked": "") %>>Femea</td>    
  </tr>
  <tr>
    <th class="label">Porte</th>
      <td class="label_radio"><input type="radio" class="radio" name="porte" value="P" <%= (porte.equals("P")? "checked": "") %>>Pequeno
      <input type="radio" class="radio" name="porte" value="M" <%= (porte.equals("M")? "checked": "") %>>Médio    
      <input type="radio" class="radio" name="porte" value="G" <%= (porte.equals("G")? "checked": "") %>>Grande</td>    
  </tr>
  <tr>
    <th class="label">Cor</th>
    <td><input type="text" id="cor" name="cor" <%if (cor != null) { %>value="<%=cor%>"<% }%>  size="20" maxlength="20"></td>
  </tr>
  <tr>
    <th class="label">Registro</th>
    <td><input type="text" id="registro" name="registro" <%if (registro != null) { %>value="<%=registro%>"<% }%>  size="20" maxlength="20"></td>
  </tr>
  <tr>
    <th class="label">Microchip</th>
    <td><input type="text" id="microchip" name="microchip" <%if (microchip != null) { %>value="<%=microchip%>"<% }%>  size="20" maxlength="20"></td>
  </tr>
  <tr>
    <th class="label">Passaporte</th>
    <td><input type="text" id="passaporte" name="passaporte" <%if (passaporte != null) { %>value="<%=passaporte%>"<% }%>  size="20" maxlength="20"></td>
  </tr>
  <tr>
    <th class="label">Origem</th>
    <td><input type="text" id="origem" name="origem" <%if (origem != null) { %>value="<%=origem%>"<% }%>  size="100" maxlength="100"></td>
  </tr>
  <tr>
    <th class="label">Estado</th>
    <td><input type="text" id="estado" name="estado" <%if (estado != null) { %>value="<%=estado%>"<% }%>  size="100" maxlength="100"></td>
  </tr>
  <tr>
    <th class="label">Alergia</th>
    <td><input type="text" id="alergia" name="alergia" <%if (alergia != null) { %>value="<%=alergia%>"<% }%>  size="100" maxlength="100"></td>
  </tr>
  <tr>
    <th class="label">Observação</th>
    <td><input type="text" id="observacao" name="observacao" <%if (observacao != null) { %>value="<%=observacao%>"<% }%>  size="100" maxlength="100"></td>
  </tr>
  <tr>
    <th class="label">Pedigree</th>
    <td class="label_radio"><input type="radio" class="radio" name="pedigree" value="S" <%= (pedigree.equals("A")? "checked": "") %>>Sim
      <input type="radio" class="radio" name="pedigree" value="N" <%= (pedigree.equals("N")? "checked": "") %>>Não</td>    
  </tr>
  <tr>
    <th class="label">Obito</th>
    <td class="label_radio"><input type="radio" class="radio" name="obito" value="S" <%= (obito.equals("S")? "checked": "") %>>Sim
      <input type="radio" class="radio" name="obito" value="N" <%= (obito.equals("N")? "checked": "") %>>Não</td>    
  </tr>
  <tr>
    <th class="label">Ativo</th>
    <td class="label_radio"><input type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Sim
      <input type="radio" class="radio" name="status" value="I" <%= (status.equals("I")? "checked": "") %>>Não</td>    
  </tr>
  <%if(acao.equals("atu")){%>  
  	<tr>
   	 	<td class="label_menor"><center>&nbsp Registro: <%if (dtCad != null) { %><%=converte.DMYToYMD(dtCad)%><% }%>&nbsp</center></td>
 	    <td class="label_menor"><center>&nbsp Modificação: <%if (dtMod != null && !dtMod.isEmpty()) { %><%=converte.DMYToYMD(dtMod)%><% }%>&nbsp</center></td>
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