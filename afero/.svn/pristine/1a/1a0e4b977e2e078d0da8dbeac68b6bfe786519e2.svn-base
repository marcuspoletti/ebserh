<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.OrdemServico" %>
<%@page import="afero.model.ConfigServico" %>
<%@page import="afero.model.Entidade" %>
<%@page import="afero.persistence.OrdemServicoDAO" %>
<%@page import="afero.persistence.ConfigServicoDAO" %>
<%@page import="afero.persistence.EntidadeDAO" %>
<%@page import="afero.util.ConverteDate" %>
<%@page import="afero.util.Utilitaria" %>
<%@page import="java.util.Date" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/></script>
<script>
function number_format( number, decimals, dec_point, thousands_sep ) {
	var n = number, c = isNaN(decimals = Math.abs(decimals)) ? 2 : decimals;
	var d = dec_point == undefined ? "," : dec_point;
	var t = thousands_sep == undefined ? "." : thousands_sep, s = n < 0 ? "-" : "";
	var i = parseInt(n = Math.abs(+n || 0).toFixed(c)) + "", j = (j = i.length) > 3 ? j % 3 : 0;
	return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : "");
}
function calcula(){
	
	var valorServico           = document.getElementById('vlServ').value;
	var valorServicoFormat     = valorServico.replace(".","");
	var valorServicoFormatCalc = parseFloat(valorServicoFormat.replace(",","."));
	var valorDesc              = document.getElementById('vlDesc').value;
	var valorDescFormat        = valorDesc.replace(".","");
	var valorDescFormatCalc    = parseFloat(valorDescFormat.replace(",","."));
	var valorCalculoDesc       = (valorServicoFormatCalc * valorDescFormatCalc)/100;
	var valorTotalDesc         = valorServicoFormatCalc - valorCalculoDesc;
	var valorCusto             = document.getElementById('vlFrete').value;
	var valorCustoFormat       = valorCusto.replace(".","");
	var valorCustoFormatCalc   = parseFloat(valorCustoFormat.replace(",","."));
	var valorTotalCusto        = valorTotalDesc + valorCustoFormatCalc ;
	document.getElementById('vlTotal').value = number_format(valorTotalCusto, 2, ',', '.');
	
}
function salvar() {
	if (document.all.idColaborador.value == 0) {
		window.alert("O campo Colaborador é obrigatório.");
		document.all.idColaborador.focus();
	}else if (document.all.cdTipoAtendimento.value == 0) {
		window.alert("O campo Tipo de Atendimento é obrigatório.");
		document.all.idListaObjeto.focus();
	}else if (document.all.cdCondPagto.value == 0) {
		window.alert("O campo Condição de Pagamento é obrigatório.");
		document.all.cdCondPagto.focus();
	}else if (document.all.cdEntidade.value == 0) {
		window.alert("O campo Entidade é obrigatório.");
		document.all.cdEntidade.focus();
	}else{
		document.forms[0].submit();
	}
}


function cancelar() {
  document.forms[0].action="formOrdemServico.jsp";
  document.forms[0].submit();
}

function voltar() {
  document.forms[0].action = 'listarOrdemServico.jsp?acao=voltar'
	document.forms[0].submit();
}
function addPd(){
	var idOS = document.getElementById('idOrdemServico').value;
	location.href ='formAddObjetosOS.jsp?acao=atu&idOrdemServico='+idOS;
}
</script>
</head>
<%
ConfigServico configServico;
ConfigServicoDAO daoConfig = new ConfigServicoDAO(conn);

Entidade entidade;
EntidadeDAO daoEntidade;

String acao = request.getParameter("acao");
String idOrdemServico = request.getParameter("idOrdemServico");
String dsEntidade = request.getParameter("dsEntidade");
if(dsEntidade == null) dsEntidade = "";
String idEntidade = request.getParameter("cdEntidade");
int cdEntidade = 0;
if(idEntidade != null ){ 
	cdEntidade = Integer.parseInt(idEntidade);
}else {
	idEntidade = "0";
}

if (acao == null) acao = "inc";
if(idOrdemServico == null) idOrdemServico = "0";

int idLoja = Integer.parseInt((String)session.getAttribute("idLoja"));

Integer idMecanico = 0;
if(request.getParameter("idMecanico") != null){
	idMecanico = Integer.parseInt(request.getParameter("idMecanico"));
}
int idColaborador = Integer.parseInt((String)session.getAttribute("idColaborador"));
int cdTipoAtendimento = 0;
String tipo = "O";
String dtOrc =  daoConfig.dataAtual();
String dtOS = daoConfig.dataAtual();
String dtAprov = null;
String dtEntrega = daoConfig.dataAtual();
String pessoaResponsavel = "";
String dtInicio = daoConfig.dataAtual();
String dtConclusao = null;
String dtEntRealizada = null;
String horaEntrada = "00:00";
String horaSaida = "00:00";
int cdCondPagto = 0;
int prazoEntrega = 0;
int prazoValidade = 0;
int prazoGarantia = 0;
String cmpOS1 = "";
String cmpOS2 = "";
String cmpOS3 = "";
String cmpOS4 = "";
String observacao = "";

double vlServ = 0;
double vlProd = 0;
double vlFrete = 0;
double vlDesc = 0;
double vlTotal = 0;
String status = "A";
String dtMod = null;
String usuario = (String)session.getAttribute("Login");


if (acao.equalsIgnoreCase("atu")){
	
	OrdemServicoDAO dao = new OrdemServicoDAO(conn);
	OrdemServico ordemServico = dao.procurarOrdemServico(" WHERE idOrdemServico = "+Integer.parseInt(idOrdemServico));
	
	idLoja = ordemServico.getIdLoja();
	cdEntidade = ordemServico.getCdEntidade();
	idColaborador = ordemServico.getIdColaborador();
	cdTipoAtendimento = ordemServico.getCdTipoAtendimento();
	tipo = ordemServico.getTipo();
	if(ordemServico.getDtOrc() != null){
		dtOrc = ConverteDate.dateToString(ordemServico.getDtOrc());
	}
	if(ordemServico.getDtOS() != null){
		dtOS = ConverteDate.dateToString(ordemServico.getDtOS());
	}
	if(ordemServico.getDtAprov() != null){
		dtAprov = ConverteDate.dateToString(ordemServico.getDtAprov());
	}
	if(ordemServico.getDtEntrega() != null){
		dtEntrega = ConverteDate.dateToString(ordemServico.getDtEntrega());
	}
	
	pessoaResponsavel = ordemServico.getPessoaResponsavel();
	
	if(ordemServico.getDtInicio() != null){
		dtInicio = ConverteDate.dateToString(ordemServico.getDtInicio());
	}
	if(ordemServico.getDtConclusao() != null){
		dtConclusao = ConverteDate.dateToString(ordemServico.getDtConclusao());
	}
	if(ordemServico.getDtEntRealizada() != null){
		dtEntRealizada = ConverteDate.dateToString(ordemServico.getDtEntRealizada());
	}
	
	cdCondPagto = ordemServico.getCdCondPagto();
	prazoEntrega = ordemServico.getPrazoEntrega();
	prazoValidade = ordemServico.getPrazoEntrega();
	prazoGarantia = ordemServico.getPrazoGarantia();
	cmpOS1 = ordemServico.getCmpOS1();
	cmpOS2 = ordemServico.getCmpOS2();
	cmpOS3 = ordemServico.getCmpOS3();
	cmpOS4 = ordemServico.getCmpOS4();
	observacao = ordemServico.getObservacao();
	vlServ = ordemServico.getVlServ();
	vlProd = ordemServico.getVlProd();
	vlFrete = ordemServico.getVlFrete();
	vlDesc = ordemServico.getVlDesc();
	status = ordemServico.getStatus();
	if( ordemServico.getDtMod()!= null){
		dtMod = ConverteDate.dateToString(ordemServico.getDtMod());
	}
	usuario = ordemServico.getUsuario();
	horaEntrada = dao.getHoraEntrada(ordemServico.getIdOrdemServico());
	horaSaida = dao.getHoraSaida(ordemServico.getIdOrdemServico());
	idMecanico = dao.getIdMecanico(ordemServico.getIdOrdemServico());
	
	//Nome da Entidade
	entidade = new Entidade();
	daoEntidade = new EntidadeDAO(conn);
	entidade = daoEntidade.procurarEntidade(cdEntidade);
	dsEntidade = entidade.getNome();
}
if(!idOrdemServico.equalsIgnoreCase("0")){
	   OrdemServicoDAO daoOrdemServico = new OrdemServicoDAO(conn);
	   vlServ = daoOrdemServico.getTotal(Integer.parseInt(idOrdemServico));
	   vlProd = daoOrdemServico.getTotalPedidosOrdemServico(Integer.parseInt(idOrdemServico));
	   vlTotal = daoOrdemServico.getValorTotal(Integer.parseInt(idOrdemServico));
		
}

%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Ordem de Serviço</h1>
<form method="post" action="listarOrdemServico.jsp?acao=<%=acao%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" id="idOrdemServico" name="idOrdemServico" value="<%=idOrdemServico%>"/>
<input type="hidden" name="usuario" value="<%=usuario %>"/>
<input type="hidden" name="cdEntidade" id="cdEntidade" value="<%=cdEntidade%>">
<iframe width=174 height=189 name="gToday:normal:"../js/calendar/agenda.js"
            id="gToday:normal:"../js/calendar/agenda.js" src="../js/calendar/ipopeng.htm"
            scrolling="no" frameborder="0" style="visibility:visible; z-index:999; 
    position:absolute; top:-500px; left:-500px;">
</iframe>
<table border="0" width="100%">
	<tr>
		<th class="label">Entidade:</th>
		<td style="height: 15px"><input disabled type="text" name="dsEntidade" id="dsEntidade" <%if (dsEntidade != null) { %>value="<%=dsEntidade%>"<% }%>  size="60" maxlength="60">
		<a  href="consultarClientesOrdemServico.jsp?acao=<%=acao%>&idOrdemServico=<%=idOrdemServico%>&idLoja=<%=idLoja%>&idColaborador=<%=idColaborador%>&cdTipoAtendimento=<%=cdTipoAtendimento%>&tipo=<%=tipo%>&dtOrc=<%=dtOrc%>&dtOS=<%=dtOS%>&dtAprov=<%=dtAprov%>&dtEntrega=<%=dtEntrega%>&pessoaResponsavel=<%=pessoaResponsavel%>&dtInicio=<%=dtInicio%>&dtConclusao=<%=dtConclusao%>&dtEntRealizada=<%=dtEntRealizada%>&cdCondPagto=<%=cdCondPagto%>&prazoEntrega=<%=prazoEntrega%>&prazoValidade=<%=prazoValidade%>&prazoGarantia=<%=prazoGarantia%>&cmpOS1=<%=cmpOS1%>&cmpOS2=<%=cmpOS2%>&cmpOS3=<%=cmpOS3%>&cmpOS4=<%=cmpOS4%>&vlServ=<%=vlServ%>&vlProd=<%=vlProd%>&vlFrete=<%=vlFrete%>&vlDesc=<%=vlDesc%>&status=<%=status%>&dtMod=<%=dtMod%>"><img border = "0" src="../images/pesquisa.gif"></a></td>
	</tr>
<% if(idLoja != 0){ 
	
	//CAMPOS de CONFIG SERVICO
	
	configServico = new ConfigServico();
	configServico = daoConfig.procurarConfigServico(" WHERE idLoja = "+idLoja);
%>
	<tr>
		<th class="label">Colaborador:</th>
		<td><select name="idColaborador" required="true">
			<option value='0'>Selecione...</option>
			<%@include file="../WEB-INF/jspf/combo/comboColaborador.jspf"%></select>
			<script>comboSelect(document.forms[0].idColaborador, '<%=idColaborador %>');</script>
		</td>
	</tr>
	<tr>
		<th class="label">Tipo Atendimento:</th>
		<td><select name="cdTipoAtendimento" required="true">
			<option value='0'>Selecione...</option>
			<%@include file="../WEB-INF/jspf/combo/comboTipoAtendimento.jspf"%></select>
			<script>comboSelect(document.forms[0].cdTipoAtendimento, '<%=cdTipoAtendimento %>');</script>
		</td>
	</tr>
	<tr>
		<th class="label">Tipo:</th>
		<td class="label_radio">
			<input type="radio" class="radio" name="tipo" value="O" <%= (tipo.equals("O")? "checked": "") %>>Orçamento
			<input type="radio" class="radio" name="tipo" value="S" <%= (tipo.equals("S")? "checked": "") %>>Ordem de Serviço
		</td>
	</tr>
	<tr>
		<th class="label">Data de Orçamento:</th>
		<td><input  name="dtOrc" type="text" size="10" maxlength="10" onblur="chkData(this,'dd/MM/yyyy')" <%if(dtOrc != null){ %>value="<%=dtOrc %>"<%} %>/>
			<a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dtOrc);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
		</td>
	</tr>
	<tr>
		<th class="label">Dt. de Ordem Serviço:</th>
		<td><input  name="dtOS" type="text" size="10" maxlength="10" onblur="chkData(this,'dd/MM/yyyy')" <%if(dtOS != null){ %>value="<%=dtOS %>"<%} %>/>
			<a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dtOS);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
		</td>
	</tr>
	<tr>
		<th class="label">Data de Aprovação:</th>
		<td><input  name="dtAprov" type="text" size="10" maxlength="10" onblur="chkData(this,'dd/MM/yyyy')" <%if(dtAprov != null){ %>value="<%=dtAprov %>"<%} %>/>
			<a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dtAprov);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
		</td>
	</tr>
	<tr>
		<th class="label">Hora da Entrada</th>
		<td><input type="text" name="horaEntrada" value="<%=horaEntrada%>"
		size="5" maxlength="5" onblur="chkTime(this,'')"></td>
	  </tr>
	<tr>
		<th class="label">Data de Entrega:</th>
		<td><input  name="dtEntrega" type="text" size="10" maxlength="10" onblur="chkData(this,'dd/MM/yyyy')" <%if(dtEntrega != null){ %>value="<%=dtEntrega %>"<%} %>/>
			<a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dtEntrega);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
		</td>
	</tr>
	
	<tr>
		<th class="label">Pessoa Resp.:</th>
		<td><input type="text"  id="pessoaResponsavel" name="pessoaResponsavel" value="<%=pessoaResponsavel %>" size="40" maxlength="60" /></td>
	</tr>
	<tr>
		<th class="label">Data de Ínicio:</th>
		<td><input  name="dtInicio" type="text" size="10" maxlength="10" onblur="chkData(this,'dd/MM/yyyy')" <%if(dtInicio != null){ %>value="<%=dtInicio %>"<%} %>/>
			<a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dtInicio);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
		</td>
	</tr>
	<tr>
		<th class="label">Data de Conclusão:</th>
		<td><input  name="dtConclusao" type="text" size="10" maxlength="10" onblur="chkData(this,'dd/MM/yyyy')" <%if(dtConclusao != null){ %>value="<%=dtConclusao %>"<%} %>/>
			<a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dtConclusao);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
		</td>
	</tr>
	<tr>
		<th class="label">Dt. de Entrega Realizada:</th>
		<td><input  name="dtEntRealizada" type="text" size="10" maxlength="10" onblur="chkData(this,'dd/MM/yyyy')" <%if(dtEntRealizada != null){ %>value="<%=dtEntRealizada %>"<%} %>/>
			<a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dtEntRealizada);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
		</td>
	</tr>
	<tr>
		<th class="label">Hora da Entrega</th>
		<td><input type="text" name="horaSaida" value="<%=horaSaida%>"
		size="5" maxlength="5" onblur="chkTime(this,'')"></td>
	  </tr>
	  <!-- 
	  <tr>
		<th class="label">Mecanico</th>
		<td><select name="idMecanico" required="true">
			<option value='0'>Selecione...</option>
			<%@include file="../WEB-INF/jspf/combo/comboMecanico.jspf"%></select>
			<script>comboSelect(document.forms[0].idMecanico, '<%=idMecanico %>');</script>
		</td>
	</tr>
	 -->
	<tr>
		<th class="label">Cond. de Pagamento:</th>
		<td><select name="cdCondPagto" required="true">
			<option value='0'>Selecione...</option>
			<%@include file="../WEB-INF/jspf/combo/comboCondPagto.jspf"%></select>
			<script>comboSelect(document.forms[0].cdCondPagto, '<%=cdCondPagto %>');</script>
		</td>
	</tr>
	<tr>
		<th class="label">Prazo Entrega:</th>
		<td><input type="text"  id="prazoEntrega" name="prazoEntrega" value="<%=prazoEntrega %>" size="40" maxlength="40" /></td>
	</tr>
	<tr>
		<th class="label">Prazo Validade:</th>
		<td><input type="text"  id="prazoValidade" name="prazoValidade" value="<%=prazoValidade %>" size="40" maxlength="40" /></td>
	</tr>
	<tr>
		<th class="label">Prazo Garantia:</th>
		<td><input type="text"  id="prazoGarantia" name="prazoGarantia" value="<%=prazoGarantia %>" size="40" maxlength="40" /></td>
	</tr>
	<%if(configServico != null){ %>
	<tr>
		<th class="label"><%=configServico.getDsCampo1()+":" %></th>
		<td><input type="text"  id="cmpOS1" name="cmpOS1" value="<%=cmpOS1 %>" size="40" maxlength="40" /></td>
	</tr>
	<tr>
		<th class="label"><%=configServico.getDsCampo2()+":" %></th>
		<td><input type="text"  id="cmpOS2" name="cmpOS2" value="<%=cmpOS2 %>" size="40" maxlength="40" /></td>
	</tr>	
	<tr>
		<th class="label"><%=configServico.getDsCampo3()+":" %></th>
		<td><input type="text"  id="cmpOS3" name="cmpOS3" value="<%=cmpOS3 %>" size="40" maxlength="40" /></td>
	</tr>
	<tr>
		<th class="label"><%=configServico.getDsCampo4()+":" %></th>
		<td><input type="text"  id="cmpOS4" name="cmpOS4" value="<%=cmpOS4 %>" size="40" maxlength="40" /></td>
	</tr>
   	<%} %>
   	<tr>
		<th class="label">Observação:</th>
		<td><textarea  id="observacao" name="observacao" cols="50" rows="5" maxlength="100"><%=observacao %></textarea></td>
	</tr>
	<tr>
		<th class="label">Valor Serviço(R$):</th>
		<td><input type="text"  id="vlServ" name="vlServ" value="<%=Utilitaria.formatarNumero(vlServ, 2) %>" onkeyup="FormataValor(this,event)" onblur="calcula();" size="40" maxlength="40" /></td>
	</tr>
	<tr>
		<th class="label">Valor Produto(R$):</th>
		<td><input type="text"  id="vlProd" name="vlProd" value="<%=Utilitaria.formatarNumero(vlProd, 2) %>" onkeyup="FormataValor(this,event)" size="40" maxlength="40" /></td>
	</tr>
	<tr>
		<th class="label">Custo de Desl.(R$):</th>
		<td><input type="text"  id="vlFrete" name="vlFrete" value="<%=Utilitaria.formatarNumero(vlFrete, 2) %>" onkeyup="FormataValor(this,event)" onblur="calcula();" size="40" maxlength="40" /></td>
	</tr>
	<tr>
		<th class="label">Valor Desconto (%):</th>
		<td><input type="text"  id="vlDesc" name="vlDesc" value="<%=Utilitaria.formatarNumero(vlDesc, 2) %>" onkeyup="FormataValor(this,event)" onblur="calcula();"  size="40" maxlength="40" /></td>
	</tr>
		<tr>
		<th class="label">Valor Total(R$):</th>
		<td><input type="text"  id="vlTotal" name="vlTotal" value="<%=Utilitaria.formatarNumero(vlTotal, 2) %>" onkeyup="FormataValor(this,event)" size="40" maxlength="40" /></td>
	</tr>
	<tr>
		<th class="label">Status:</th>
		<td class="label_radio" <%if(acao.equalsIgnoreCase("inc")){ %>disabled<%} %>>
			<input type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Aberta
			<input type="radio" class="radio" name="status" value="F" <%= (status.equals("F")? "checked": "") %>>Fechada
			<input type="radio" class="radio" name="status" value="C" <%= (status.equals("C")? "checked": "") %>>Cancelada
		</td>
	</tr>
  <%  if(acao.equalsIgnoreCase("atu")){   %>
   <tr>
   		<th class="label" rowspan="2">Registros:</th>
   		<td class="label_menor"><center>&nbsp; Modificação: <%if (dtMod != null) { %><%=dtMod%><% }%>&nbsp;</center></td>
   </tr>
   <tr>
   		<td class="label_menor"><center>&nbsp; Usuário: <%if (usuario != null) { %><%=usuario%><% }%>&nbsp;</center></td>
   </tr>  
  <%} %>  
</table>
<%} // Fechando if da Loja  %>
<hr>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			<%if(idLoja != 0){ %>
				<input class="button" type="button" value="Salvar" onClick="javascript: salvar();" />
				
				<%if(acao.equalsIgnoreCase("atu")){ %>
					<input class="button" type="button" value="Adicionar Veículos/Serviços" onClick="javaScript: addPd();" />
				<%} %>			
			<%} %>
			<input class="button" type="button" value="Cancelar" onClick="javascript: cancelar();" />
			<input class="button" type="button" value="Voltar" onClick="javascript: voltar();" />
		</td>
		<td class="campo_obrigatorio">* Campos Obrigatórios</td>
	</tr>	
</table>
</form>
<%@include file="../fimConexao.jsp"%>
</body>
</html>