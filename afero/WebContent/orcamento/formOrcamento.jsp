<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.Orcamento"%>
<%@page import="afero.persistence.OrcamentoDAO"%>
<%@ page import="afero.util.ConverteDate" %>
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
   }else if (document.all.idColaborador.value == '0') {
    window.alert("O campo Atendente é obrigatório.");
    document.all.idColaborador.focus();
   }else if (document.all.idEntrega.value == '0') {
    window.alert("O campo Entrega é obrigatório.");
    document.all.idEntrega.focus();
   }else if (document.all.cdEntidade.value == '0') {
    window.alert("O campo Cliente é obrigatório.");
    document.all.dsEntidade.focus();
   }else {
    document.forms[0].action="formCadastroItensOrcamento.jsp?acao=inc";
  	document.forms[0].submit();
  }
}
function cancelar() {
  document.forms[0].action="formOrcamento.jsp";
  document.forms[0].submit();
}
function recarregar(acao) {
  document.forms[0].action='formOrcamento.jsp?acao='+acao;
  document.forms[0].submit();
}
</script>
</head>
<%

String acao = request.getParameter("acao");
String idOrcamento = request.getParameter("idOrcamento");
OrcamentoDAO daoOrcamento = new OrcamentoDAO(conn); 
ConverteDate converte = new ConverteDate();
if (acao == null) acao = "inc";
if (idOrcamento == null) idOrcamento = "0";
String idLoja = request.getParameter("idLoja");
if(idLoja== null)idLoja= (String)session.getAttribute("idLoja");
String cdEntidade = request.getParameter("cdEntidade");
if(cdEntidade == null)cdEntidade = "0";
String dsEntidade = request.getParameter("dsEntidade");
if(dsEntidade == null)dsEntidade="";
String idEntrega =request.getParameter("idEntrega");
if(idEntrega==null)idEntrega="0";
String idColaborador = request.getParameter("idColaborador");
if(idColaborador == null)idColaborador="0";
String dtOrc = daoOrcamento.dataAtualOrcamento();
String dtEntrega = daoOrcamento.dataAtualOrcamento();
double vlOrc = 0;
int prazoValidade = 0;
String observacao = "";
String pessoaResponsavel = "";
String status = "NA";
String dtMod = "";
String usuario = (String)session.getAttribute("Login");
String hrEntrega = "00:00";
%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Orçamento</h1>
<form method="post" action="formOrcamento.jsp?acao=<%=acao%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="idOrcamento" value="<%=idOrcamento%>"/>
<input type="hidden" name="usuario" value="<%=usuario%>"/>
<input type="hidden" name="dtOrc" value="<%=dtOrc%>"/>
<input type="hidden" name="cdEntidade" value="<%=cdEntidade%>"/>
<input type="hidden" name="dsEntidade" value="<%=dsEntidade%>"/>
<iframe width=174 height=189 name="gToday:normal:"../js/calendar/agenda.js"
            id="gToday:normal:"../js/calendar/agenda.js" src="../js/calendar/ipopeng.htm"
            scrolling="no" frameborder="0" style="visibility:visible; z-index:999; 
    position:absolute; top:-500px; left:-500px;">
    </iframe>

<table border="0" width="100%">
  <tr>
      <th class="label">Loja*</th>
      <td><select name="idLoja" onchange="recarregar('<%=acao%>');" required="true">
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboLoja.jspf"%></select>
          <script>comboSelect(document.forms[0].idLoja, '<%= idLoja %>');</script>
      </td>
  </tr>
    <tr>
      <th class="label">Atendente*</th>
      <td><select name="idColaborador" onchange="recarregar('<%=acao%>');" required="true">
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboColaborador.jspf"%></select>
          <script>comboSelect(document.forms[0].idColaborador, '<%= idColaborador %>');</script>
      </td>
  </tr>
  <tr>
      <th class="label">Taxa de Entrega*</th>
      <td><select name="idEntrega" onchange="recarregar('<%=acao%>');" required="true">
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboEntrega.jspf"%></select>
          <script>comboSelect(document.forms[0].idEntrega, '<%= idEntrega%>');</script>
      </td>
  </tr>
    
    <tr>
      <th class="label" style="height: 22px">Cliente*</th>
            <td style="height: 15px"><input disabled type="text" name="dsEntidade" <%if (dsEntidade != null) { %>value="<%=dsEntidade%>"<% }%>  size="60" maxlength="60"> <a href="consultarClientes.jsp?acao=<%=acao%>&idOrcamento=<%=idOrcamento%>&idLoja=<%=idLoja%>&idEntrega=<%=idEntrega%>&idColaborador=<%=idColaborador%>"><img border = "0" src="../images/pesquisa.gif"></a></td>
       		
  </tr>
    <tr>
    <th class="label">Pessoa Responsável</th>
    <td><input type="text" name="pessoaResponsavel" <%if (pessoaResponsavel != null) { %>value="<%=pessoaResponsavel%>"<% }%>  size="60" maxlength="60"></td>
  </tr>
  <tr>
		<th class="label">Data de Entrega</th>
     <td>
	               	<input type="text" name="dtCasamento" size="15" value="<%= dtEntrega %>" onblur="chkData(this,'dd/MM/yyyy')" maxlength="10" class="inputs">
		               	<a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dtCasamento);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
            		</td>
 </tr>
 <tr>
			<th class="label">Hora de Entrega</th>
			<td><input type="text" name="hrEntrega" value="<%=hrEntrega%>"
						size="5" maxlength="5" onblur="chkTime(this,'')"></td>
	  </tr>
   <tr>
    <th class="label">Data do Orçamento</th>
    <td><input disabled type="text" name="dtOrc" <%if (dtOrc != null) { %>value="<%=dtOrc%>"<% }%>  size="10" maxlength="10"></td>
  </tr>
   <tr>
    <th class="label">Prazo de Validade</th>
    <td><input type="text" name="prazoValidade" value="<%=prazoValidade%>"  size="10"  maxlength="10"></td>
  </tr>
  <tr>
      <th class="label">Observação</th>
      <td><textarea name="observacao" cols="60" rows="5"><%=observacao %></textarea></td>
  </tr>
  <tr>
    <th class="label">Status</th>
    <td class="label_radio">
      <input disabled type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Aprovado
      <input type="radio" class="radio" name="status" value="R" <%= (status.equals("N")? "checked": "") %>>Recusado<br>
      <input type="radio" class="radio" name="status" value="NA" <%= (status.equals("NA")? "checked": "") %>>Não Avaliado</td>
  </tr>
</table><hr>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
	<td><input class="button" type="button" value="Próximo" onClick="javascript: salvar();" />
	<input class="button" type="button" value="Cancelar" onClick="javascript: cancelar();" />
	<td class="campo_obrigatorio">* Campos Obrigatórios</td>
</tr>
</table>
</form>
<%@include file="../fimConexao.jsp"%>
</body>
</html>