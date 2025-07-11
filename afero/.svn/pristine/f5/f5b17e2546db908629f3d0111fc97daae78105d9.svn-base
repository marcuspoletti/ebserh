<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.EntidadeContato" %>
<%@ page import="afero.persistence.EntidadeContatoDAO" %>
<%@page import="afero.util.ConverteDate"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script src="../js/common.js" /></script>
<script>
function salvar() {
  if (document.all.nmContato.value == '') {
    window.alert("O campo Contato é obrigatório.");
    document.all.nmContato.focus();
   } else {
  	document.forms[0].submit();
  }
}

function cancelar() {
  document.forms[0].action="formEntidadeContato.jsp";
  document.forms[0].submit();
}

function voltar(cdEntidade) {
  document.forms[0].action = 'listarEntidadeContato.jsp?acao=voltar&cdEntidade='+cdEntidade;
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
//variáveis capturadas da página listarEntidadeContato.jsp
String acao = request.getParameter("acao");
String cdEntidade = request.getParameter("cdEntidade");
String idEntidadeContato = request.getParameter("idEntidadeContato");
String selectAba = request.getParameter("selectAba");
String acaoAnterior = request.getParameter("acaoAnterior");
if (acao == null) acao = "inc";
if (cdEntidade == null) cdEntidade = "";
if (idEntidadeContato == null) idEntidadeContato = "";
if (selectAba == null) selectAba = "5";
if (acaoAnterior == null) acaoAnterior = "atu";

int cdTipoNivel = 0;
String nmContato = "";
String dtNascimento = "";
String cargo = "";
String departamento = "";
String sexo = "M";
String telefone1 = "";
String ramal1 = "";
String telefone2 = "";
String ramal2 = "";
String fax = "";
String celular = "";
String email = "";
String hobby = "";
String time = "";
String status ="A";

String mensagem = request.getParameter("mensagem");

//verifica se acao foi atualizar
if (acao.equalsIgnoreCase("atu")) {
  EntidadeContatoDAO dao = new EntidadeContatoDAO(conn);
  EntidadeContato entidadeContato = dao.procurarEntidadeContato(Integer.parseInt(idEntidadeContato));
  cdEntidade = String.valueOf(entidadeContato.getCdEntidade());
  cdTipoNivel = entidadeContato.getCdTipoNivel();
  nmContato  = entidadeContato.getNmContato();
  dtNascimento = ConverteDate.dateToStr(entidadeContato.getDtNascimento(),"dd/MM/yyyy");
  if (dtNascimento == null) dtNascimento = "";
  cargo = entidadeContato.getCargo();
  departamento = entidadeContato.getDepartamento();
  sexo = entidadeContato.getSexo();
  telefone1 = entidadeContato.getTelefone1();
  ramal1 = entidadeContato.getRamal1();
  telefone2 = entidadeContato.getTelefone2();
  ramal2 = entidadeContato.getRamal2();
  fax = entidadeContato.getFax();
  celular = entidadeContato.getCelular();
  email = entidadeContato.getEmail();
  hobby = entidadeContato.getHobby();
  time = entidadeContato.getTime();
  status = entidadeContato.getStatus();
}
%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Contato - Entidade</h1>
<hr><% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<form method="post" action="listarEntidadeContato.jsp?cdEntidade=<%=cdEntidade%>&acao=<%=acao%>&idEntidadeContato=<%=idEntidadeContato%>&acaoAnterior=<%=acaoAnterior%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="cdEntidade" value="<%=cdEntidade%>"/>
<input type="hidden" name="idEntidadeContato" value="<%=idEntidadeContato%>"/>
<input type="hidden" name="selectAba" value="<%=selectAba%>"/>
<input type="hidden" name="acaoAnterior" value="<%=acaoAnterior%>"/>

<table border="0" width="100%">
  <tr>
    <th class="label">Nível Contato</th>
    <td><select name="cdTipoNivel" style="width: 172px">
        <option value='1'>Selecione...</option>
        <%@include file="../WEB-INF/jspf/combo/comboTipoNivel.jspf" %></select>
        <script>comboSelect(document.forms[0].cdTipoNivel, '<%= cdTipoNivel %>');</script>
    </td>
  </tr>
  <tr>
    <th class="label">Contato*</th>
    <td><input type="text" id="nmContato" name="nmContato" <%if (nmContato != null) { %>value="<%=nmContato%>"<% }%>  size="60" maxlength="60"></td>
  </tr>
 	<tr>
		<th class="label">Data de nascimento</th>
      		<td>
          	<input type="text" name="dtNascimento" size="15" value="<%= dtNascimento %>" onblur="chkData(this,'dd/MM/yyyy')" maxlength="10" class="inputs">
           	<a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dtNascimento);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
      		</td>
	</tr>
  <tr>
    <th class="label">Cargo</th>
    <td><input type="text" id="cargo" name="cargo" <%if (cargo != null) { %>value="<%=cargo%>"<% }%>  size="40" maxlength="40"></td>
  </tr>
  <tr>
    <th class="label">Departamento</th>
    <td><input type="text" id="departamento" name="departamento" <%if (departamento != null) { %>value="<%=departamento%>"<% }%>  size="40" maxlength="40"></td>
  </tr>
  <tr>
	<th class="label">Sexo</th>
	<td class="label_radio">
	  <input type="radio" class="radio" name="sexo" value="M" <%=(sexo.equals("M")? "checked": "") %>>Masculino 
		<input type="radio" class="radio" name="sexo" value="F"	<%=(sexo.equals("F")? "checked": "") %>>Feminino</td>
  </tr>
  <tr>
    <th class="label">Telefone 1</th>
    <td><input type="text" id="telefone1" name="telefone1" <%if (telefone1 != null) { %>value="<%=telefone1%>"<% }%>  size="15" maxlength="15"></td>
    <th class="label">Ramal 1</th>
    <td><input type="text" id="ramal1" name="ramal1" <%if (ramal1 != null) { %>value="<%=ramal1%>"<% }%>  size="5" maxlength="5"></td>
  </tr>
  <tr>
    <th class="label">Telefone 2</th>
    <td><input type="text" id="telefone2" name="telefone2" <%if (telefone2 != null) { %>value="<%=telefone2%>"<% }%>  size="15" maxlength="15"></td>
    <th class="label">Ramal 2</th>
    <td><input type="text" id="ramal2" name="ramal2" <%if (ramal2 != null) { %>value="<%=ramal2%>"<% }%>  size="5" maxlength="5"></td>
  </tr>
  <tr>
    <th class="label">Fax</th>
    <td><input type="text" id="fax" name="fax" <%if (fax != null) { %>value="<%=fax%>"<% }%>  size="15" maxlength="15"></td>
  </tr>
  <tr>
    <th class="label">Celular</th>
    <td><input type="text" id="celular" name=""celular"" <%if ("celular" != null) { %>value="<%=celular%>"<% }%>  size="15" maxlength="15"></td>
  </tr>
  <tr>
    <th class="label">Email</th>
    <td><input type="text" id="email" name=""email"" <%if ("email" != null) { %>value="<%=email%>"<% }%>  size="60" maxlength="100"></td>
  </tr>
  <tr>
    <th class="label">Hobby</th>
    <td><input type="text" id="hobby" name=""hobby"" <%if ("hobby" != null) { %>value="<%=hobby%>"<% }%>  size="25" maxlength="25"></td>
  </tr>
  <tr>
    <th class="label">Time</th>
    <td><input type="text" id="time" name=""time"" <%if ("time" != null) { %>value="<%=time%>"<% }%>  size="25" maxlength="25"></td>
  </tr>
	<tr>
		<th class="label">Ativo</th>
		<td class="label_radio">
		  <input type="radio" class="radio" name="status" value="A" <%=(status.equals("A")? "checked": "") %>>Sim 
			<input type="radio" class="radio" name="status" value="I"	<%=(status.equals("I")? "checked": "") %>>Não</td>
	</tr>
</table><hr>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
	<td><input class="button" type="button" value="Salvar" onClick="javascript: salvar();" />
	<input class="button" type="button" value="Cancelar" onClick="javascript: cancelar();" />
	<input class="button" type="button" value="Voltar" onClick="javascript:history.go(-1);" /></td>
	<td class="campo_obrigatorio">* Campos Obrigatórios</td>
</tr>
</table>
</form>
<%@include file="../fimConexao.jsp"%>
</body>
</html>