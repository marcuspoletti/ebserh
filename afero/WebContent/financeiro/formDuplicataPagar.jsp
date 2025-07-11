<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@page import="afero.model.Duplicata"%>
<%@page import="afero.model.Entidade"%>
<%@page import="afero.util.*"%>
<%@page import="afero.persistence.DuplicataDAO"%>
<%@page import="afero.persistence.EntidadeDAO"%>
<%@page import="afero.model.Colaborador"%>
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
		} else if (document.all.dsEntidade.value == '') {
			window.alert("O campo Pagar para é obrigatório.");
			document.all.dsEntidade.focus();
		} else if (document.all.idTipoDocumento.value == '0') {
			window.alert("O campo Tipo do Documento é obrigatório.");
			document.all.idTipoDocumento.focus();
		} else if (document.all.dtEmissao.value == '') {
			window.alert("O campo Data de Emissão é obrigatório.");
			document.all.dtEmissao.focus();
		} else if (document.all.nrDoc.value == '') {
			window.alert("O campo Número do Documento é obrigatório.");
			document.all.nrDoc.focus();
		} else if (document.all.valorTotal.value == '0' || document.all.valorTotal.value == '') {
			window.alert("O campo Valor é obrigatório.");
			document.all.valorTotal.focus();
		//} else if (document.all.acao.value == 'inc' && document.all.idConta.value == '0') {
		//	window.alert("O campo Conta é obrigatório.");
		//	document.all.idConta.focus();
		//} else if (document.all.acao.value == 'inc' && document.all.cdFormaPagto.value == '0') {
		//	window.alert("O campo Forma de Pagamento é obrigatório.");
		//	document.all.cdFormaPagto.focus();
		} else if (document.all.idPlanoConta.value == '0') {
			window.alert("O campo Plano de Conta é obrigatório.");
			document.all.idPlanoConta.focus();
		} else if (document.all.idCentroCusto.value == '0') {
			window.alert("O campo Centro de Custo é obrigatório.");
			document.all.idCentroCusto.focus();
		} else {
			document.forms[0].submit();
		}
	}

	function recarregar(acao) {
		document.forms[0].action = 'formDuplicataPagar.jsp?acao=' + acao;
		document.forms[0].submit();
	}

	function cancelar() {
		document.forms[0].action = 'formDuplicataPagar.jsp';
		document.forms[0].submit();
	}

	function voltar() {
		document.forms[0].action = 'listarDuplicataPagar.jsp?acao=voltar'
		document.forms[0].submit();
	}

	function parcelar() {
		document.all.quantParcelas.value = document.all.quantParcelas.value=='1' ? '2' : '1';
		document.forms[0].action = 'formDuplicataPagar.jsp?acao=inc';
		document.forms[0].submit();
	}

	function comboSelect(combo, key) {
		var err = window.onerror;
		window.onerror = new Function('return true');
		if (!combo)
			return;
		combo.selectedIndex = -1;
		for ( var i = 0; i < combo.options.length; i++) {
			if (combo.multiple) {
				combo.options[i].selected = (("," + key + ",").indexOf(","
						+ combo.options[i].value + ",") != -1);
			} else {
				combo.options[i].selected = (combo.options[i].value == key);
			}
		}
		window.onerror = err;
	}
</script>
</head>
<%
	String data = "";
	try {
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");      
		data = sdf.format(new Date());
	} catch (NumberFormatException nfe) {
		throw new Exception("Data inválida");
	} catch (Exception e) {
		throw new Exception(e.getMessage());
	}
	
	ColaboradorDAO daoDuplicataColaborador = new ColaboradorDAO(conn);
	String idUsuario = (String) session.getAttribute("idUsuario");
	Colaborador colaboradorDuplicata = daoDuplicataColaborador.procurarColaboradorUsuario(Integer.parseInt(idUsuario));
	String acao = request.getParameter("acao");
	String idDuplicata = request.getParameter("idDuplicata");
	String idLoja = request.getParameter("idLoja");
	String cdEntidade = request.getParameter("cdEntidade");
	String dc = request.getParameter("dc");
	String dtEmissao = request.getParameter("dtEmissao");
	String dtComp = request.getParameter("dtComp");
	String nrDoc = request.getParameter("nrDoc");
	String idTipoDocumento = request.getParameter("idTipoDocumento");
	String idPlanoConta = request.getParameter("idPlanoConta");
	String idCentroCusto = request.getParameter("idCentroCusto");
	String historico = request.getParameter("historico");
	String nrDiasPag = request.getParameter("nrDiasPag");
	String quantParcelas = request.getParameter("quantParcelas");
	String valorTotal = request.getParameter("valorTotal");
	String gerarBoleto = request.getParameter("gerarBoleto");
	String observacao = request.getParameter("observacao");
	String tipoLancamento = request.getParameter("tipoLancamento");
	String txMulta = request.getParameter("txMulta");
	String txJuros = request.getParameter("txJuros");
	String tipoJuros = request.getParameter("tipoJuros");
	String status = request.getParameter("status");
	String dtCad = request.getParameter("dtCad");
	String dtMod = request.getParameter("dtMod");
	String usuario = (String) session.getAttribute("Login");

	if (acao == null)
		acao = "inc";
	if (idDuplicata == null)
		idDuplicata = "0";
	if (idLoja == null)
		idLoja = String.valueOf(colaboradorDuplicata.getIdLoja());
	if (cdEntidade == null)
		cdEntidade = "0";
	if (dc == null)
		dc = "D";
	if (dtEmissao == null)
		dtEmissao = data;
	if (dtComp == null)
		dtComp = data;
	if (nrDoc == null)
		nrDoc = "";
	if (idTipoDocumento == null)
		idTipoDocumento = "0";
	if (idPlanoConta == null)
		idPlanoConta = "0";
	if (idCentroCusto == null)
		idCentroCusto = "0";
	if (historico == null)
		historico = "";
	if (nrDiasPag == null)
		nrDiasPag = "0";
	if (quantParcelas == null)
		quantParcelas = "1";
	if (valorTotal == null) {
		valorTotal = "0";
	} else {
		valorTotal = "".valueOf(Utilitaria.toNumber(valorTotal).doubleValue());		
	}
	if (gerarBoleto == null)
		gerarBoleto = "N";
	if (observacao == null)
		observacao = "";
	if (tipoLancamento == null)
		tipoLancamento = "M";
	if (txMulta == null) {
		txMulta = "0";
	} else {
		txMulta = "".valueOf(Utilitaria.toNumber(txMulta).doubleValue());		
	}
	if (txJuros == null) {
		txJuros = "0";
	} else {
		txJuros = "".valueOf(Utilitaria.toNumber(txJuros).doubleValue());		
	}
	if (tipoJuros == null)
		tipoJuros = "M";
	if (status == null)
		status = "A";
	if (dtCad == null)
		dtCad = "";
	if (dtMod == null)
		dtMod = "";	
	
	String dtVencimento = request.getParameter("dtVencimento");
	String idConta = request.getParameter("idConta");
	String cdFormaPagto = request.getParameter("cdFormaPagto");
	if (dtVencimento == null) dtVencimento = "";
	if (idConta == null) idConta = "0";
	if (cdFormaPagto == null) cdFormaPagto = "0";
	
	//Nome da Entidade
	String dsEntidade = request.getParameter("dsEntidade");
	if (dsEntidade == null)
		dsEntidade = "";

	//verifica se acao foi atualizar
	if (acao.equalsIgnoreCase("atu")) {
		DuplicataDAO dao = new DuplicataDAO(conn);
		Duplicata duplicata = dao.procurarDuplicata(Integer.parseInt(idDuplicata));
		idLoja = "".valueOf(duplicata.getIdLoja()).toString();
		if (cdEntidade.equals("0")) {
			cdEntidade = "".valueOf(duplicata.getCdEntidade()).toString();
		}
		dc = duplicata.getDc();
		if (duplicata.getDtEmissao() != null) {
			dtEmissao = ConverteDate.dateToString(duplicata.getDtEmissao());
		}
		if (duplicata.getDtComp() != null) {
			dtComp = ConverteDate.dateToString(duplicata.getDtComp());
		}
		nrDoc = duplicata.getNrDoc();
		idTipoDocumento = "".valueOf(duplicata.getIdTipoDocumento()).toString();
		idPlanoConta = "".valueOf(duplicata.getIdPlanoConta()).toString();
		idCentroCusto = "".valueOf(duplicata.getIdCentroCusto()).toString();
		historico = duplicata.getHistorico();
		nrDiasPag = "".valueOf(duplicata.getNrDiasPag());
		quantParcelas = "".valueOf(duplicata.getQuantParcelas());
		valorTotal = "".valueOf(duplicata.getValorTotal());
		gerarBoleto = duplicata.getGerarBoleto();
		observacao = duplicata.getObservacao();
		tipoLancamento = duplicata.getTipoLancamento();
		txMulta = "".valueOf(duplicata.getTxMulta());
		txJuros = "".valueOf(duplicata.getTxJuros());
		tipoJuros = duplicata.getTipoJuros();
		status = duplicata.getStatus();
		if (duplicata.getDtCad() != null) {
			dtCad = ConverteDate.dateToString(duplicata.getDtCad());
		}
		if (duplicata.getDtMod() != null) {
			dtMod = ConverteDate.dateToString(duplicata.getDtMod());
		}
		usuario = duplicata.getUsuario();

		//Nome Entidade
		EntidadeDAO daoEntidade = new EntidadeDAO(conn);
		Entidade entidade = daoEntidade.procurarEntidade(Integer.parseInt(cdEntidade));
		dsEntidade = entidade.getNome();
	}
%>
<body onload="document.all.idLoja.focus();">
	<h1 class="cabecalho_pagina">Contas a Pagar</h1>
	<form method="post" action="listarDuplicataPagar.jsp?acao=<%=acao%>">
		<input type="hidden" name="cdEntidade" value="<%=cdEntidade%>">
		<input type="hidden" name="usuario" value="<%=usuario%>" /> 
		<input type="hidden" name="dsEntidade" value="<%=dsEntidade%>" /> 
		<input type="hidden" name="idDuplicata" value="<%=idDuplicata%>" />
		<input type="hidden" name="dc" value="<%=dc%>" />
		<%
		  if (!(acao.equalsIgnoreCase("inc") && !quantParcelas.equals("1"))) {
		%>
		<input type="hidden" name="quantParcelas" value="<%=quantParcelas%>" />
		<input type="hidden" name="status" value="<%=status%>" />
		<% }%>
		<iframe width=174 height=189 name="gToday:normal:" ../js/calendar/agenda.js" id="gToday:normal:"
			../js/calendar/agenda.js" src="../js/calendar/ipopeng.htm" scrolling="no" frameborder="0"
			style="visibility: visible; z-index: 999; position: absolute; top: -500px; left: -500px;">
		</iframe>
		<table border="0" width="100%">
			<tr>
				<th class="label">Loja*</th>
				<td><select name="idLoja" required="true">
						<option value='0'>Selecione...</option>
						<%@include file="../WEB-INF/jspf/combo/comboLoja.jspf"%></select>
					<script>comboSelect(document.forms[0].idLoja, '<%=idLoja%>');</script>
				</td>
			</tr>
			<tr>
				<th class="label" style="height: 22px">Pagar para*</th>
				<td style="height: 15px"><input disabled type="text"
					name="dsEntidade" <%if (dsEntidade != null) {%>
					value="<%=dsEntidade%>" <%}%> size="60" maxlength="60"><a
					href="consultarClientesContasPagar.jsp?acao=<%=acao%>&idDuplicata=<%=idDuplicata%>&idLoja=<%=idLoja%>&cdEntidade=<%=cdEntidade%>&dc=<%=dc%>&dtEmissao=<%=dtEmissao%>&dtComp=<%=dtComp%>&nrDoc=<%=nrDoc%>&idTipoDocumento=<%=idTipoDocumento%>&idPlanoConta=<%=idPlanoConta%>&idCentroCusto=<%=idCentroCusto%>&historico=<%=historico%>&nrDiasPag=<%=nrDiasPag%>&quantParcelas=<%=quantParcelas%>&dtVencimento=<%=dtVencimento%>&valorTotal=<%=valorTotal%>&idConta=<%=idConta%>&cdFormaPagto=<%=cdFormaPagto%>&gerarBoleto=<%=gerarBoleto%>&observacao=<%=observacao%>&tipoLancamento=<%=tipoLancamento%>&txMulta=<%=txMulta%>&txJuros=<%=txJuros%>&tipoJuros=<%=tipoJuros%>&status=<%=status%>&dtCad=<%=dtCad%>&dtMod=<%=dtMod%>&usuario=<%=usuario%>"><img border="0" src="../images/pesquisa.gif"></a>
				</td>
			</tr>
			<tr>
				<th class="label">Histórico</th>
				<td><textarea name="historico" cols="100" rows="2"><%=historico%></textarea>
				</td>
			</tr>
			<tr>
				<th class="label">Tipo de Documento*</th>
				<td><select name="idTipoDocumento"">
						<option value='0'>Selecione...</option>
						<%@include file="../WEB-INF/jspf/combo/comboTipoDocumento.jspf"%></select>
					<script>comboSelect(document.forms[0].idTipoDocumento, '<%=idTipoDocumento%>');</script>
				</td>
			</tr>		
			<tr>
				<th class="label">Emissão*</th>
				<td><input type="text" name="dtEmissao" size="15"
					<%if (dtEmissao != null) {%> value="<%=dtEmissao%>" <%}%>
					onblur="chkData(this,'dd/MM/yyyy')" maxlength="10" class="inputs">
					<a href="javascript:void(0)"
					onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dtEmissao);return false;"
					HIDEFOCUS><img class="PopcalTrigger" align="absmiddle"
						src="../js/calendar/calbtn.gif" width="34" height="22" border="0"
						alt="">
				</a></td>
			</tr>
			<tr>
				<th class="label">Competência</th>
				<td><input type="text" name="dtComp" size="15"
					<%if (dtComp != null) {%> value="<%=dtComp%>" <%}%>
					onblur="chkData(this,'dd/MM/yyyy')" maxlength="10" class="inputs">
					<a href="javascript:void(0)"
					onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dtComp);return false;"
					HIDEFOCUS><img class="PopcalTrigger" align="absmiddle"
						src="../js/calendar/calbtn.gif" width="34" height="22" border="0"
						alt=""></a>
				</td>
			</tr>
			<tr>
				<th class="label">Nº Documento*</th>
				<td><input type="text" name="nrDoc" <%if (nrDoc != null) {%>
					value="<%=nrDoc%>" <%}%> size="20" maxlength="20">
				</td>
			</tr>		
		  <%
    		if (acao.equalsIgnoreCase("atu")){
  		%>
			<tr>
				<th class="label">Quant. Parcelas*</th>
				<td><input type="text" name="quantParcelas" disabled="disabled"
					<%if (quantParcelas != null) {%> value="<%=quantParcelas%>" <%}%>
					size="10" maxlength="4">
				</td>
			</tr>
			<tr>
				<th class="label">Valor Total*</th>
				<td><input type="text" name="valorTotal" disabled="disabled"
					value="<%=Utilitaria.formatarNumero(Float.parseFloat(valorTotal), 2).toString()%>"
					onkeyup="FormataValor(this,event)" size="20" maxlength="15">
					<input type="hidden" name="valorTotal" value="<%=Utilitaria.formatarNumero(Float.parseFloat(valorTotal), 2).toString()%>" />
				</td>
			</tr>
		  <%
    		} else {
    			//dtVencimento = "";
    			//idConta = "0";
    			//cdFormaPagto = "0";
    			if (quantParcelas.equals("1")) {
  		%>  
			<tr>
				<th class="label">Vencimento*</th>
				<td><input type="text" name="dtVencimento" size="15"
					<%if (dtVencimento != null) {%> value="<%=dtVencimento%>" <%}%>
					onblur="chkData(this,'dd/MM/yyyy')" maxlength="10" class="inputs">
					<a href="javascript:void(0)"
					onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dtVencimento);return false;"
					HIDEFOCUS><img class="PopcalTrigger" align="absmiddle"
						src="../js/calendar/calbtn.gif" width="34" height="22" border="0"
						alt="">
				</a></td>
			</tr>
			<tr>
				<th class="label">Valor*</th>
				<td><input type="text" name="valorTotal" 
					value="<%=Utilitaria.formatarNumero(Float.parseFloat(valorTotal), 2).toString()%>"
					onkeyup="FormataValor(this,event)" size="20" maxlength="15">
				</td>
			</tr>
			<%} else { %>
			<tr>
				<th class="label">Parcelar o Total de*</th>
				<td><input type="text" name="valorTotal" 
					value="<%=Utilitaria.formatarNumero(Float.parseFloat(valorTotal), 2).toString()%>"
					onkeyup="FormataValor(this,event)" size="20" maxlength="15">
				</td>
			</tr>
			<tr>
				<th class="label">Quant. Parcelas*</th>
				<td><input type="text" name="quantParcelas"
					<%if (quantParcelas != null) {%> value="<%=quantParcelas%>" <%}%>
					size="10" maxlength="4">
				</td>
			</tr>
			<tr>
				<th class="label">Venc. 1a Parcela*</th>
				<td><input type="text" name="dtVencimento" size="15"
					<%if (dtVencimento != null) {%> value="<%=dtVencimento%>" <%}%>
					onblur="chkData(this,'dd/MM/yyyy')" maxlength="10" class="inputs">
					<a href="javascript:void(0)"
					onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dtVencimento);return false;"
					HIDEFOCUS><img class="PopcalTrigger" align="absmiddle"
						src="../js/calendar/calbtn.gif" width="34" height="22" border="0"
						alt="">
				</a></td>
			</tr>
			<%} %>
			<tr>
				<th class="label">Conta*</th>
      	<td><select name="idConta" >
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboConta.jspf" %></select>
          <script>comboSelect(document.forms[0].idConta, '<%= idConta %>');</script>
      	</td>
			</tr>
			<tr>
				<th class="label">Forma de Pagamento*</th>
      	<td><select name="cdFormaPagto" >
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboFormaPagto.jspf" %></select>
          <script>comboSelect(document.forms[0].cdFormaPagto, '<%= cdFormaPagto %>');</script>
      	</td>
			</tr>
		  <%
    		} 
  		%>  
			<tr>
				<th class="label">Plano de Conta*</th>
      	<td><select name="idPlanoConta" >
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboPlanoContaD.jspf" %></select>
          <script>comboSelect(document.forms[0].idPlanoConta, '<%= idPlanoConta %>');</script>
      	</td>
			</tr>
			<tr>
				<th class="label">Centro de Custo*</th>
      	<td><select name="idCentroCusto">
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboCentroCusto.jspf" %></select>
          <script>comboSelect(document.forms[0].idCentroCusto, '<%= idCentroCusto%>');</script>
      	</td>
			</tr>
			<tr>
				<th class="label">Gerar Boleto</th>
				<td class="label_radio">
					<input type="radio" class="radio" name="gerarBoleto" value="S"
					<%=(gerarBoleto.equals("S") ? "checked" : "")%>>Sim 
					<input type="radio" class="radio" name="gerarBoleto" value="N"
					<%=(gerarBoleto.equals("N") ? "checked" : "")%>>Não
				</td>
			</tr>
			<tr>
				<th class="label">Tipo de Lançamento</th>
				<td class="label_radio"><input type="radio" class="radio"
					name="tipoLancamento" value="M"
					<%=(tipoLancamento.equals("M") ? "checked" : "")%>>Manual <input
					type="radio" class="radio" name="tipoLancamento" value="A"
					<%=(tipoLancamento.equals("A") ? "checked" : "")%>>Automático</td>
			</tr>
			<tr>
				<th class="label">Taxa de Multa (%)</th>
				<td><input type="text" name="txMulta"
					value="<%=Utilitaria.formatarNumero(Float.parseFloat(txMulta), 2).toString()%>"
					onkeyup="FormataValor(this,event)" size="20" maxlength="15">
				</td>
			</tr>
			<tr>
				<th class="label">Taxa de Juros (%)</th>
				<td><input type="text" name="txJuros"
					value="<%=Utilitaria.formatarNumero(Float.parseFloat(txJuros), 2).toString()%>"
					onkeyup="FormataValor(this,event)" size="20" maxlength="15">
				</td>
			</tr>
			<tr>
				<th class="label">Tipo de Juros</th>
				<td class="label_radio"><input type="radio" class="radio"
					name="tipoJuros" value="M"
					<%=(tipoJuros.equals("M") ? "checked" : "")%>>Mensalmente <input
					type="radio" class="radio" name="tipoJuros" value="D"
					<%=(tipoJuros.equals("D") ? "checked" : "")%>>Diariamente</td>
			</tr>
			<tr>
				<th class="label">Observação</th>
				<td><textarea name="observacao" cols="100" rows="2"><%=observacao%></textarea>
				</td>
			</tr>
			<tr>
				<th class="label">Status da Duplicata</th>
				<td class="label_radio">
					<input type="radio" class="radio" name="status" value="A" disabled="disabled" 
					<%=(status.equals("A") ? "checked" : "")%>>A Pagar 
					<input type="radio" class="radio" name="status" value="Q" disabled="disabled"
					<%=(status.equals("Q") ? "checked" : "")%>>Quitado 
					<input type="radio" class="radio" name="status" value="I" disabled="disabled"
					<%=(status.equals("C") ? "checked" : "")%>>Cancelado 
				</td>
			</tr>
  <%
    if (acao.equalsIgnoreCase("atu")) {
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
	<td>
	<%if (status.equals("A")) { %>
			<input class="button" type="button" value="Salvar" onClick="javascript: salvar();" />
		<%if (acao.equalsIgnoreCase("atu")) { %>
	 		<input class="button" type="button" value="Cancelar" onClick="javascript: cancelar();" />
		<%} else { %>
			<input class="button" type="button" value="Cancelar" onClick="javascript: voltar();" />
		<%} %>
	<%} %>
	<input class="button" type="button" value="Voltar" onClick="javascript: voltar();" />
	<%if (acao.equalsIgnoreCase("inc")) { %>
	 	<input class="button" type="button" value="<%=quantParcelas.equals("1") ? "Parcelar" : "Desfazer Parcelas"%>" onClick="javascript: parcelar();" />
	<%} %>
	</td>
	<td class="campo_obrigatorio">* Campos Obrigatórios</td>
</tr>
</table>
</form>
<%@include file="../fimConexao.jsp"%>
</body>
</html>