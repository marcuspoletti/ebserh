<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.PedidoEntrada"%>
<%@page import="afero.model.Entidade"%>
<%@page import="afero.persistence.EntidadeDAO"%>
<%@page import="afero.persistence.PedidoEntradaDAO"%>
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
    window.alert("O campo Colaborador é obrigatório.");
    document.all.idColaborador.focus();
   }else if (document.all.cdEntidade.value == '0') {
    window.alert("O campo Fornecedor/Distribuidor é obrigatório.");
    document.all.idColaborador.focus();
   }else if (document.all.nrDoc.value == '') {
    window.alert("O número do documento tem que ser preenchido.");
    document.all.nrDoc.focus();
   }else {
    document.forms[0].action="formCadastroItensCompras.jsp";
  	document.forms[0].submit();
  }
}
function cancelar() {
  document.forms[0].action="formCompras.jsp";
  document.forms[0].submit();
}

function recarregar(acao) {
  document.forms[0].action='formCompras.jsp?acao='+acao;
  document.forms[0].submit();
}

</script>
</head>
<%

String acao = request.getParameter("acao");
String idPedidoEntrada = request.getParameter("idPedidoEntrada");
PedidoEntradaDAO daoPedidoEntrada = new PedidoEntradaDAO(conn); 
ConverteDate converte = new ConverteDate();
if (acao == null) acao = "inc";
String idLoja = request.getParameter("idLoja");
if(idLoja==null)idLoja= (String)session.getAttribute("idLoja");;
String cdEntidade = request.getParameter("cdEntidade");
if(cdEntidade == null)cdEntidade = "0";
String idColaborador = request.getParameter("idColaborador");
if(idColaborador == null)idColaborador="0";
String dtEmissao = daoPedidoEntrada.dataAtualPedido();
double vlPed = 0;
String observacao = "";
String status = "P";
String dsEntidade = request.getParameter("dsEntidade");
if(dsEntidade == null)dsEntidade = "";
String operacao = "E";
String dtMod = "";
String dtMov = "";
String nrDoc = request.getParameter("nrDoc");
if(nrDoc == null)nrDoc="";
String usuario = (String)session.getAttribute("Login");
if (idPedidoEntrada == null || idPedidoEntrada.equals("0")){
	idPedidoEntrada = "0";
	acao="inc";
}else if(!idPedidoEntrada.equals("0")){
	PedidoEntrada pedidoEntrada = daoPedidoEntrada.procurarPedidoEntrada(Integer.parseInt(idPedidoEntrada));
	idLoja = "".valueOf(pedidoEntrada.getIdLoja());
	cdEntidade = "".valueOf(pedidoEntrada.getCdEntidade());
	idColaborador = "".valueOf(pedidoEntrada.getIdColaborador());
	dtEmissao = ConverteDate.dateToString(pedidoEntrada.getDtPed());
	vlPed = pedidoEntrada.getVlPed();
	observacao = pedidoEntrada.getObservacao();
	if(observacao == null)observacao="";
	status = pedidoEntrada.getStatus();
	operacao = pedidoEntrada.getOperacao();
	nrDoc = pedidoEntrada.getNrDoc();
	usuario=pedidoEntrada.getUsuario();
	EntidadeDAO daoEntidade = new EntidadeDAO(conn);
	Entidade entidade = daoEntidade.procurarEntidade(Integer.parseInt(cdEntidade));
	dsEntidade = entidade.getNome();
	acao="atu";
}
%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Pedido de Compras</h1>
<form method="post" action="formCompras.jsp?acao=<%=acao%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="idPedidoEntrada" value="<%=idPedidoEntrada%>"/>
<input type="hidden" name="usuario" value="<%=usuario%>"/>
<input type="hidden" name="dtEmissao" value="<%=dtEmissao%>"/>
<input type="hidden" name="cdEntidade" value="<%=cdEntidade%>"/>
<input type="hidden" name="dsEntidade" value="<%=dsEntidade%>"/>
<iframe width=174 height=189 name="gToday:normal:"../js/calendar/agenda.js"
            id="gToday:normal:"../js/calendar/agenda.js" src="../js/calendar/ipopeng.htm"
            scrolling="no" frameborder="0" style="visibility:visible; z-index:999; 
    position:absolute; top:-500px; left:-500px;">
    </iframe>


<table border="0" width="100%">
   <tr>
    <th class="label">Número do Documento</th>
    <td><input type="text" name="nrDoc" <%if (nrDoc != null) { %>value="<%=nrDoc%>"<% }%>  size="7" maxlength="7"></td>
  </tr>
  <tr>
      <th class="label">Loja*</th>
      <td><select name="idLoja" onchange="recarregar('<%=acao%>');">
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboLoja.jspf"%></select>
          <script>comboSelect(document.forms[0].idLoja, '<%= idLoja %>');</script>
      </td>
  </tr>
    <tr>
      <th class="label">Colaborador*</th>
      <td><select name="idColaborador" onchange="recarregar('<%=acao%>');">
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboColaborador.jspf"%></select>
          <script>comboSelect(document.forms[0].idColaborador, '<%= idColaborador %>');</script>
      </td>
  </tr>  
  
    <tr>
      <th class="label" style="height: 22px">Fornecedor / Distribuidor</th>
            <td style="height: 15px"><input type="text" name="dsEntidade" <%if (dsEntidade != "") { %>value="<%=dsEntidade%>"<% }%>  size="60" maxlength="60"> <a  href="consultarClientes.jsp?acao=<%=acao%>&idPedidoEntrada=<%=idPedidoEntrada%>&idLoja=<%=idLoja%>&idColaborador=<%=idColaborador%>&nrDoc=<%=nrDoc%>"><img border = "0" src="../images/pesquisa.gif"></a></td>
       		
  </tr>
   <tr>
    <th class="label">Data de Emissão</th>
       <td>
	     <input type="text" name="dtCasamento" size="15" value="<%=dtEmissao%>" onblur="chkData(this,'dd/MM/yyyy')" maxlength="10" class="inputs">
		 <a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dtCasamento);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
        </td>
  </tr>
  <tr>
      <th class="label">Observação</th>
      <td><textarea name="observacao" cols="60" rows="5" ><%=observacao%></textarea></td>
  </tr>
  <tr>
    <th class="label">Status</th>
    <td class="label_radio">
      <input disabled type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Atendido
      <input type="radio" class="radio" name="status" value="P" <%= (status.equals("P")? "checked": "") %>>Pendente<br>
      <input type="radio" class="radio" name="status" value="C" <%= (status.equals("C")? "checked": "") %>>Cancelado</td>
  </tr>
  <tr>
    <th class="label" colspan="1">Operação</th>
    <td class="label_radio">
      <input type="radio" class="radio" name="operacao" value="E" <%= (operacao.equals("E")? "checked": "") %>>Entrada
      <input type="radio" class="radio" name="operacao" value="T" <%= (operacao.equals("T")? "checked": "") %>>Transferência<br>
      <input type="radio" class="radio" name="operacao" value="ES" <%= (operacao.equals("ES")? "checked": "") %>>Estorno de Saída Por Devolução
      <input type="radio" class="radio" name="operacao" value="AE" <%= (operacao.equals("AE")? "checked": "") %>>Ajuste de Entrada
    </td>
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
<br>
<br>
|<a class="button" target="_blank" href="../financeiro/listarDuplicataPagar.jsp">Contas a Pagar</a>|<br>
<%@include file="../fimConexao.jsp"%>
</body>
</html>