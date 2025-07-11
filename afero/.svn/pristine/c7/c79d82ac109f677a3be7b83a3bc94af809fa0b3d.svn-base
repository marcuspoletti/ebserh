<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@page import="afero.model.Duplicata"%>
<%@page import="afero.model.DuplicataParcela"%>
<%@page import="afero.model.Entidade"%>
<%@page import="afero.model.Loja"%>
<%@page import="afero.model.Colaborador"%>
<%@page import="afero.util.*"%>
<%@page import="afero.persistence.DuplicataDAO"%>
<%@page import="afero.persistence.DuplicataParcelaDAO"%>
<%@page import="afero.persistence.EntidadeDAO"%>
<%@page import="afero.persistence.LojaDAO"%>
<%@page import="afero.persistence.ColaboradorDAO"%>
<%@page import="afero.util.ConverteDate"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script language=JavaScript src="../js/abas.js" type=text/javascript></script>
<script src="../js/common.js" /></script>
<script>
	function salvar() {
	  if (document.all.dtEmissao.value == '') {
			window.alert("O campo Data de Emissão é obrigatório.");
			document.all.dtEmissao.focus();
		} else if (document.all.nrDoc.value == '') {
			window.alert("O campo Número do Documento é obrigatório.");
			document.all.nrDoc.focus();
		} else if (document.all.dtVenc.value == '') {
			window.alert("O campo Data de Vencimento é obrigatório.");
			document.all.dtVenc.focus();
		} else if (numero(document.all.valor.value) == '0.00' || document.all.valor.value == '') {
			window.alert("O campo Valor é obrigatório.");
			document.all.valor.focus();
		} else if (document.all.idConta.value == '0') {
			window.alert("O campo Conta é obrigatório.");
			document.all.idConta.focus();
		} else if (document.all.cdFormaPagto.value == '0') {
			window.alert("O campo Forma de Pagamento é obrigatório.");
			document.all.cdFormaPagto.focus();
		} else if (document.all.idPlanoConta.value == '0') {
			window.alert("O campo Plano de Conta é obrigatório.");
			document.all.idPlanoConta.focus();
		} else if (document.all.idCentroCusto.value == '0') {
			window.alert("O campo Centro de Custo é obrigatório.");
			document.all.idCentroCusto.focus();
		} else if (document.all.status[1].checked && document.all.dtOperacao.value == '') {
			window.alert("O campo Data da Operação é obrigatório.");
			document.all.dtOperacao.focus();
		} else if (document.all.status[1].checked && numero(document.all.vlOperacao.value) == '0.00') {
			window.alert("O campo Valor da Operação é obrigatório.");
			document.all.vlOperacao.focus();
		} else {
			document.forms[0].submit();
		}
	}

	function recarregar(acao) {
		document.forms[0].action = 'formDuplicataParcelaPagar.jsp?acao=' + acao;
		document.forms[0].submit();
	}

	function cancelar() {
		document.forms[0].action = 'formDuplicataParcelaPagar.jsp';
		document.forms[0].submit();
	}

	function voltar() {
		document.forms[0].action = 'listarDuplicataPagar.jsp?acao=voltar'
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
	String idDuplicataParcela = request.getParameter("idDuplicataParcela");
	String idDuplicata = request.getParameter("idDuplicata");
	String nrParcela = request.getParameter("nrParcela");
	String idConta = request.getParameter("idConta");
	String dtVenc = request.getParameter("dtVenc");
	String valor = request.getParameter("valor");
	String cdFormaPagto = request.getParameter("cdFormaPagto");
	String dtEmissao = request.getParameter("dtEmissao");
	String dtComp = request.getParameter("dtComp");
	String nrDoc = request.getParameter("nrDoc");
	String idPlanoConta = request.getParameter("idPlanoConta");
	String idCentroCusto = request.getParameter("idCentroCusto");
	String historico = request.getParameter("historico");
	String divideValor = request.getParameter("divideValor");
	String dtOperacao = request.getParameter("dtOperacao");
	String vlOperacao = request.getParameter("vlOperacao");
	String vlJuros = request.getParameter("vlJuros");
	String vlMulta = request.getParameter("vlMulta");
	String vlDesc = request.getParameter("vlDesc");
	String nossoNumero = request.getParameter("nossoNumero");
	String dtQuitacao = request.getParameter("dtQuitacao");
	String formaQuitacao = request.getParameter("formaQuitacao");
	String idColaborador = request.getParameter("idColaborador");
	String atualizaFinanceiro = request.getParameter("atualizaFinanceiro");
	String idContaMov = request.getParameter("idContaMov");
	String status = request.getParameter("status");
	String dtMod = request.getParameter("dtMod");
	String usuario = (String) session.getAttribute("Login");

	if (acao == null) acao = "atuP";
	if (idDuplicataParcela == null) idDuplicataParcela = "0";
	if (idDuplicata == null) idDuplicata = "0";
	if (nrParcela == null) nrParcela = "1";
	if (idConta == null) idConta = "0";
	if (dtVenc == null) dtVenc = "";	
	if (valor == null) valor = "";	
	if (cdFormaPagto == null) cdFormaPagto = "0";
	if (dtEmissao == null) dtEmissao = data;
	if (dtComp == null) dtComp = data;
	if (nrDoc == null) nrDoc = "";
	if (idPlanoConta == null) idPlanoConta = "0";
	if (idCentroCusto == null) idCentroCusto = "0";
	if (historico == null) historico = "";
	if (divideValor == null) divideValor = "N";
	if (dtOperacao == null) dtOperacao = "";
	if (vlOperacao == null) vlOperacao = "0";
	if (vlJuros == null) vlJuros = "0";
	if (vlMulta == null) vlMulta = "0";
	if (vlDesc == null) vlDesc = "0";
	if (nossoNumero == null) nossoNumero = "";
	if (dtQuitacao == null) dtQuitacao = "";
	if (formaQuitacao == null) formaQuitacao = "";
	if (idColaborador == null) idColaborador = "0";
	if (atualizaFinanceiro == null) atualizaFinanceiro = "N";
	if (idContaMov == null) idContaMov = "0";
	if (status == null) status = "A";
	if (dtMod == null) dtMod = "";	
	if (usuario == null) usuario = "";	
	
	String dsLoja = "";
	String dsEntidade = "";

	//verifica se acao foi atualizar
	if (acao.equalsIgnoreCase("atuP")) {
		DuplicataParcelaDAO dao = new DuplicataParcelaDAO(conn);
		DuplicataParcela duplicataParcela = dao.procurarDuplicataParcela(Integer.parseInt(idDuplicataParcela));
		nrParcela = String.valueOf(duplicataParcela.getNrParcela());
		idConta = String.valueOf(duplicataParcela.getIdConta());
		if (duplicataParcela.getDtVenc() != null) {
			dtVenc = ConverteDate.dateToString(duplicataParcela.getDtVenc());
		}
		valor = String.valueOf(duplicataParcela.getValor());	
		cdFormaPagto = String.valueOf(duplicataParcela.getCdFormaPagto());
		if (duplicataParcela.getDtEmissao() != null) {
			dtEmissao = ConverteDate.dateToString(duplicataParcela.getDtEmissao());
		}
		if (duplicataParcela.getDtComp() != null) {
			dtComp = ConverteDate.dateToString(duplicataParcela.getDtComp());
		}
		nrDoc = duplicataParcela.getNrDoc();
		idPlanoConta = String.valueOf(duplicataParcela.getIdPlanoConta());
		idCentroCusto = String.valueOf(duplicataParcela.getIdCentroCusto());
		historico = duplicataParcela.getHistorico();
		divideValor = duplicataParcela.getDivideValor();
		if (duplicataParcela.getDtOperacao() != null) {
			dtOperacao = ConverteDate.dateToString(duplicataParcela.getDtOperacao());
		}
		vlOperacao = String.valueOf(duplicataParcela.getVlOperacao());
		vlJuros = String.valueOf(duplicataParcela.getVlJuros());
		vlMulta = String.valueOf(duplicataParcela.getVlMulta());
		vlDesc = String.valueOf(duplicataParcela.getVlDesc());
		nossoNumero = duplicataParcela.getNossoNumero();
		if (duplicataParcela.getDtQuitacao() != null) {
			dtQuitacao = ConverteDate.dateToString(duplicataParcela.getDtQuitacao());
		}
		if (duplicataParcela.getFormaQuitacao() != null) {
			formaQuitacao = duplicataParcela.getFormaQuitacao();
		}
		idColaborador = String.valueOf(duplicataParcela.getIdColaborador());
		atualizaFinanceiro = duplicataParcela.getAtualizaFinanceiro();
		idContaMov = String.valueOf(duplicataParcela.getIdContaMovto());
		status = duplicataParcela.getStatus();
		if (duplicataParcela.getDtMov() != null) {
			dtMod = ConverteDate.dateToString(duplicataParcela.getDtMov());
		}
		usuario = duplicataParcela.getUsuario();

		DuplicataDAO daoDuplicata = new DuplicataDAO(conn);
		Duplicata duplicata = daoDuplicata.procurarDuplicata(Integer.parseInt(idDuplicata));
		String cdEntidade = String.valueOf(duplicata.getCdEntidade());
		String idLoja = String.valueOf(duplicata.getIdLoja());
		
		//Nome Loja
		LojaDAO daoLoja = new LojaDAO(conn);
		Loja loja = daoLoja.procurarLoja(Integer.parseInt(idLoja));
		dsLoja = loja.getApelido();

		//Nome Entidade
		EntidadeDAO daoEntidade = new EntidadeDAO(conn);
		Entidade entidade = daoEntidade.procurarEntidade(Integer.parseInt(cdEntidade));
		dsEntidade = entidade.getNome();
	}
%>
<body onload="document.all.historico.focus();">
	<h1 class="cabecalho_pagina">Contas a Pagar - Parcela</h1>
	<form method="post" action="listarDuplicataPagar.jsp?acao=<%=acao%>">
		<input type="hidden" name="usuario" value="<%=usuario%>" /> 
		<input type="hidden" name="idDuplicata" value="<%=idDuplicata%>" />
		<input type="hidden" name="idDuplicataParcela" value="<%=idDuplicataParcela%>" />
		<input type="hidden" name="nrParcela" value="<%=nrParcela%>" />
		<input type="hidden" name="divideValor" value="<%=divideValor%>" />
		<input type="hidden" name="idColaborador" value="<%=idColaborador%>" />
		<input type="hidden" name="atualizaFinanceiro" value="<%=atualizaFinanceiro%>" />
		<input type="hidden" name="idContaMov" value="<%=idContaMov%>" />
		<iframe width=174 height=189 name="gToday:normal:" ../js/calendar/agenda.js" id="gToday:normal:"
			../js/calendar/agenda.js" src="../js/calendar/ipopeng.htm" scrolling="no" frameborder="0"
			style="visibility: visible; z-index: 999; position: absolute; top: -500px; left: -500px;">
		</iframe>
		<table border="0" width="100%">
			<tr>
				<th class="label" style="height: 22px">Loja</th>
				<td style="height: 15px"><input disabled type="text"
					name="dsLoja" <%if (dsLoja != null) {%>
					value="<%=dsLoja%>" <%}%> size="60" maxlength="60">
				</td>
			</tr>
			<tr>
				<th class="label" style="height: 22px">Pagar para</th>
				<td style="height: 15px"><input disabled type="text"
					name="dsEntidade" <%if (dsEntidade != null) {%>
					value="<%=dsEntidade%>" <%}%> size="60" maxlength="60">
				</td>
			</tr>
			<tr>
				<th class="label" style="height: 22px">Parcela</th>
				<td style="height: 15px"><input disabled type="text"
					name="nrParcela" <%if (nrParcela != null) {%>
					value="<%=nrParcela%>" <%}%> size="10" maxlength="10">
				</td>
			</tr>
			<tr>
				<th class="label">Histórico</th>
				<td><textarea id="historico" name="historico" cols="100" rows="2"><%=historico%></textarea>
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
			<tr>
				<th class="label">Vencimento*</th>
				<td><input type="text" name="dtVenc" size="15"
					<%if (dtVenc != null) {%> value="<%=dtVenc%>" <%}%>
					onblur="chkData(this,'dd/MM/yyyy')" maxlength="10" class="inputs">
					<a href="javascript:void(0)"
					onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dtVenc);return false;"
					HIDEFOCUS><img class="PopcalTrigger" align="absmiddle"
						src="../js/calendar/calbtn.gif" width="34" height="22" border="0"
						alt="">
				</a></td>
			</tr>
			<tr>
				<th class="label">Valor*</th>
				<td><input type="text" name="valor" 
					value="<%=Utilitaria.formatarNumero(Float.parseFloat(valor), 2).toString()%>"
					onkeyup="FormataValor(this,event)" size="20" maxlength="15">
				</td>
			</tr>
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
				<th class="label">Data Operação</th>
				<td><input type="text" name="dtOperacao" size="15"
					<%if (dtOperacao != null) {%> value="<%=dtOperacao%>" <%}%>
					onblur="chkData(this,'dd/MM/yyyy')" maxlength="10" class="inputs">
					<a href="javascript:void(0)"
					onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dtOperacao);return false;"
					HIDEFOCUS><img class="PopcalTrigger" align="absmiddle"
						src="../js/calendar/calbtn.gif" width="34" height="22" border="0"
						alt="">
				</a></td>
			</tr>
			<tr>
				<th class="label">Valor Operação</th>
				<td><input type="text" name="vlOperacao"
					value="<%=Utilitaria.formatarNumero(Float.parseFloat(vlOperacao), 2).toString()%>"
					onkeyup="FormataValor(this,event)" size="20" maxlength="15">
				</td>
			</tr>
			<tr>
				<th class="label">Multa</th>
				<td><input type="text" name="vlMulta"
					value="<%=Utilitaria.formatarNumero(Float.parseFloat(vlMulta), 2).toString()%>"
					onkeyup="FormataValor(this,event)" size="20" maxlength="15">
				</td>
			</tr>
			<tr>
				<th class="label">Juros</th>
				<td><input type="text" name="vlJuros"
					value="<%=Utilitaria.formatarNumero(Float.parseFloat(vlJuros), 2).toString()%>"
					onkeyup="FormataValor(this,event)" size="20" maxlength="15">
				</td>
			</tr>
			<tr>
				<th class="label">Desconto</th>
				<td><input type="text" name="vlDesc"
					value="<%=Utilitaria.formatarNumero(Float.parseFloat(vlDesc), 2).toString()%>"
					onkeyup="FormataValor(this,event)" size="20" maxlength="15">
				</td>
			</tr>
			<tr>
				<th class="label">Nosso Número</th>
				<td><input type="text" name="nossoNumero" <%if (nossoNumero != null) {%>
					value="<%=nossoNumero%>" <%}%> size="25" maxlength="20">
				</td>
			</tr>		
			<tr>
				<th class="label">Data Quitação</th>
				<td><input type="text" name="dtQuitacao" size="15"
					<%if (dtQuitacao != null) {%> value="<%=dtQuitacao%>" <%}%>
					onblur="chkData(this,'dd/MM/yyyy')" maxlength="10" class="inputs">
					<a href="javascript:void(0)"
					onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dtQuitacao);return false;"
					HIDEFOCUS><img class="PopcalTrigger" align="absmiddle"
						src="../js/calendar/calbtn.gif" width="34" height="22" border="0"
						alt="">
				</a></td>
			</tr>
			<tr>
				<th class="label">Forma quitação</th>
				<td class="label_radio">
					<input type="radio" class="radio" name="formaQuitacao" value="D" 
					<%=(formaQuitacao.equals("D") ? "checked" : "")%>>Dinheiro 
					<input type="radio" class="radio" name="formaQuitacao" value="Q"
					<%=(formaQuitacao.equals("Q") ? "checked" : "")%>>Cheque 
					<input type="radio" class="radio" name="formaQuitacao" value="C"
					<%=(formaQuitacao.equals("C") ? "checked" : "")%>>Cartão 
					<input type="radio" class="radio" name="formaQuitacao" value="B" 
					<%=(formaQuitacao.equals("B") ? "checked" : "")%>>Bancária 
					<input type="radio" class="radio" name="formaQuitacao" value="O" 
					<%=(formaQuitacao.equals("O") ? "checked" : "")%>>Outra 
				</td>
			</tr>
			<tr>
				<th class="label">Status da Duplicata</th>
				<td class="label_radio">
					<input type="radio" class="radio" name="status" value="A"
					<%=(status.equals("A") ? "checked" : "")%>>A Pagar 
					<input type="radio" class="radio" name="status" value="Q"
					<%=(status.equals("Q") ? "checked" : "")%>>Quitado 
					<input type="radio" class="radio" name="status" value="C" 
					<%=(status.equals("C") ? "checked" : "")%>>Cancelado 
				</td>
			</tr>
  <%
    if (acao.equalsIgnoreCase("atu")) {
  %>
     	<tr>
  	    <th class="label">Registros:</th>
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
		<%if (acao.equalsIgnoreCase("atuP")) { %>
	 		<input class="button" type="button" value="Cancelar" onClick="javascript: cancelar();" />
		<%} else { %>
			<input class="button" type="button" value="Cancelar" onClick="javascript: voltar();" />
		<%} %>
	<%} %>
	<input class="button" type="button" value="Voltar" onClick="javascript: voltar();" />
	</td>
	<td class="campo_obrigatorio">* Campos Obrigatórios</td>
</tr>
</table>
</form>
<%@include file="../fimConexao.jsp"%>
</body>
</html>