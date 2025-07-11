<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.PedidoSaida"%>
<%@page import="afero.model.Entidade"%>
<%@page import="afero.model.Colaborador"%>
<%@page import="afero.persistence.EntidadeDAO"%>
<%@page import="afero.persistence.PedidoSaidaDAO"%>
<%@page import="afero.persistence.ColaboradorDAO"%>
<%@ page import="afero.util.ConverteDate" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/></script>
<script>
function salvar(acao) {
    document.forms[0].action='formCadastroItensPedido.jsp';
    document.forms[0].submit();
}
function cancelar() {
  document.forms[0].action="formPedido.jsp";
  document.forms[0].submit();
}
function recarregar(acao) {
  document.forms[0].action='formPedido.jsp';
  document.forms[0].submit();
}
</script>
</head>
<%

String acao = request.getParameter("acao");
if (acao == null) acao = "inc";
String idPedidoSaida = request.getParameter("idPedidoSaida");
PedidoSaidaDAO daoPedidoSaida = new PedidoSaidaDAO(conn); 
ConverteDate converte = new ConverteDate();
if (idPedidoSaida == null) idPedidoSaida = "0";
String idLoja = request.getParameter("idLoja");
if (idLoja == null) idLoja= (String)session.getAttribute("idLoja");
String cdEntidade = request.getParameter("cdEntidade");
if (cdEntidade == null)cdEntidade="2";
String idEntrega = request.getParameter("idEntrega");
if (idEntrega == null) idEntrega="1";
String idUsuario = (String)session.getAttribute("idUsuario");
ColaboradorDAO daoColaborador = new ColaboradorDAO(conn);
Colaborador colaborador = daoColaborador.procurarColaboradorUsuario(Integer.parseInt(idUsuario));
String idColaborador = request.getParameter("idColaborador");
if (idColaborador == null) idColaborador="".valueOf(colaborador.getIdColaborador());
String dsEntidade = request.getParameter("dsEntidade");
if (dsEntidade == null) dsEntidade="AO CONSUMIDOR";
String dtPed = daoPedidoSaida.dataAtualPedido();
double vlPed = 0;
String observacao = "";
String anotacao = "";
String status = "P";
String pessoaResponsavel = "";
String operacao = "S";
String dtMod = "";
String usuario = (String)session.getAttribute("Login");
String dtEntrega = daoPedidoSaida.dataAtualPedido();
String hrEntrega = "";
String statusPag = "N";
String tipoPedido = "B";
if (acao.equalsIgnoreCase("inc")){
	idPedidoSaida = "0";
	acao="inc";
}else if (acao.equalsIgnoreCase("atu")) {
	PedidoSaida pedidoSaida = daoPedidoSaida.procurarPedidoSaida(Integer.parseInt(idPedidoSaida));
	idLoja = "".valueOf(pedidoSaida.getIdLoja());
	cdEntidade = "".valueOf(pedidoSaida.getCdEntidade());
	EntidadeDAO daoEntidade = new EntidadeDAO(conn);
	Entidade entidade = daoEntidade.procurarEntidade(Integer.parseInt(cdEntidade));
	dsEntidade = entidade.getNome();
	idEntrega = "".valueOf(pedidoSaida.getIdEntrega());
         idColaborador = "".valueOf(pedidoSaida.getIdColaborador());
	observacao = pedidoSaida.getObservacao();
	anotacao = pedidoSaida.getAnotacao();
	if(anotacao == null)anotacao = "";
	status = pedidoSaida.getStatus();
	pessoaResponsavel=pedidoSaida.getPessoaResponsavel();
	operacao = pedidoSaida.getOperacao();
	if(pedidoSaida.getDtEntrega() != null){
	   dtEntrega = ConverteDate.dateToString(pedidoSaida.getDtEntrega());
	}else{
            dtEntrega = "";
	}
	hrEntrega = pedidoSaida.getHrEntrega();
	dtPed = ConverteDate.dateToString(pedidoSaida.getDtPed());
	vlPed = pedidoSaida.getVlPed();
	statusPag = daoPedidoSaida.statusPag(Integer.parseInt(idPedidoSaida));
	acao="atu";
}
%>
<body id="editar" onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Pedido</h1>
<form method="post" action="formPedido.jsp">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="idPedidoSaida" value="<%=idPedidoSaida%>"/>
<input type="hidden" name="usuario" value="<%=usuario%>"/>
<input type="hidden" name="idLoja" value="<%=idLoja%>"/>
<input type="hidden" name="idEntrega" value="<%=idEntrega%>"/>
<input type="hidden" name="idColaborador" value="<%=idColaborador%>"/>
<input type="hidden" name="dtPed" value="<%=dtPed%>"/>
<input type="hidden" name="dsEntidade" value="<%=dsEntidade%>"/>
<input type="hidden" name="cdEntidade" value="<%=cdEntidade%>"/>
<input type="hidden" name="tipoPedido" value="<%=tipoPedido%>"/>
<iframe width=174 height=189 name="gToday:normal:"../js/calendar/agenda.js"
            id="gToday:normal:"../js/calendar/agenda.js" src="../js/calendar/ipopeng.htm"
            scrolling="no" frameborder="0" style="visibility:visible; z-index:999; 
    position:absolute; top:-500px; left:-500px;">
    </iframe>
<table border="0" width="100%">
<%--
  <tr>
      <th class="label">Loja*</th>
      <td><select name="idLoja" onchange="recarregar();">
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboLoja.jspf"%></select>
          <script>comboSelect(document.forms[0].idLoja, '<%= idLoja %>');</script>
      </td>
  </tr>
    <tr>
      <th class="label">Atendente*</th>
      <td><select name="idColaborador" onchange="recarregar();">
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboColaborador.jspf"%></select>
          <script>comboSelect(document.forms[0].idColaborador, '<%= idColaborador %>');</script>
      </td>
  </tr>
  <tr>
      <th class="label">Entrega*</th>
      <td><select name="idEntrega" onchange="recarregar();">
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboEntrega.jspf"%></select>
          <script>comboSelect(document.forms[0].idEntrega, '<%= idEntrega%>');</script>
      </td>
  </tr>
   --%>
    <tr>
      <th class="label" style="height: 22px">Cliente*</th>
         <td style="height: 15px"><input disabled type="text" name="dsEntidade" <%if (dsEntidade != null) { %>value="<%=dsEntidade%>"<% }%>  size="60" maxlength="60"></td>       		
  </tr>
    <tr>
    <th class="label">Pessoa Responsável</th>
    <td><input type="text" name="pessoaResponsavel" <%if (pessoaResponsavel != null) { %>value="<%=pessoaResponsavel%>"<% }%>  size="60" maxlength="60"></td>
  </tr>
  <%--
    <tr>
		<th class="label">Data de Entrega</th>
     <td>
	               	<input type="text" name="dtEntrega" size="15" value="<%= dtEntrega %>" onblur="chkData(this,'dd/MM/yyyy')" maxlength="10" class="inputs">
		               	<a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dtEntrega);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
            		</td>
 </tr>
		<tr>
			<th class="label">Hora de Entrega</th>
			<td><input type="text" name="hrEntrega" value="<%=hrEntrega%>"
						size="5" maxlength="5" onblur="chkTime(this,'')"></td>
	  </tr>
	   --%>
   <tr>
    <th class="label">Data do Pedido</th>
    <td><input disabled type="text" name="dtPed" <%if (dtPed != null) { %>value="<%=dtPed%>"<% }%>  size="10" maxlength="10"></td>
  </tr>

  <tr>
      <th class="label">Observação</th>
      <td><textarea name="observacao" cols="50" rows="2"><%=observacao %></textarea></td>
  </tr>
  <tr>
    <th class="label" colspan="1">Status</th>
    <td class="label_radio">
      <input type="radio" class="radio" name="status" value="P" <%= (status.equals("P")? "checked": "") %>>Pendente
      <input type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Atendido
      <input type="radio" class="radio" name="status" value="C" <%= (status.equals("C")? "checked": "") %>>Cancelado
    </td>
  </tr>
    <tr>
    <th class="label" colspan="1">Pago</th>
    <td class="label_radio">
      <input disabled type="radio" class="radio" name="statusPag" value="P" <%= (statusPag.equals("P")? "checked": "") %>>Sim
      <input  type="radio" class="radio" name="statusPag" value="N" <%= (statusPag.equals("N")? "checked": "") %>>Não
    </td>
  </tr>
  <tr>
    <th class="label" colspan="1">Operação</th>
    <td class="label_radio">
      <input type="radio" class="radio" name="operacao" value="S" <%= (operacao.equals("S")? "checked": "") %>>Saída
      <input type="radio" class="radio" name="operacao" value="T" <%= (operacao.equals("T")? "checked": "") %>>Transferência<br>
      <input type="radio" class="radio" name="operacao" value="ES" <%= (operacao.equals("ES")? "checked": "") %>>Estorno de Entrada Por Devolução
      <input type="radio" class="radio" name="operacao" value="AS" <%= (operacao.equals("AS")? "checked": "") %>>Ajuste de Saída
    </td>
  </tr>
  <tr>
      <th class="label">Anotação</th>
      <td><textarea name="anotacao" cols="100" rows="2"><%=anotacao %></textarea></td>
  </tr>
</table><hr>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
	<td><input class="button" type="button" value="Próximo" onClick="javascript: salvar('<%=acao%>');" />
	<input class="button" type="button" value="Cancelar" onClick="javascript: cancelar();" />
	<td class="campo_obrigatorio">* Campos Obrigatórios</td>
</tr>
</table>
</form>
<%@include file="../fimConexao.jsp"%>
</body>
</html>