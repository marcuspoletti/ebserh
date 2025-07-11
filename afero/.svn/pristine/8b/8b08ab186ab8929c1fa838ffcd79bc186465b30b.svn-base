<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.Duplicata"%>
<%@ page import="afero.model.DuplicataParcela"%>
<%@ page import="afero.model.Colaborador"%>
<%@ page import="afero.model.Entidade"%>
<%@ page import="afero.model.Conta"%>
<%@ page import="afero.persistence.DuplicataDAO"%>
<%@ page import="afero.persistence.DuplicataParcelaDAO"%>
<%@ page import="afero.persistence.ColaboradorDAO"%>
<%@ page import="afero.persistence.EntidadeDAO"%>
<%@ page import="afero.persistence.ContaDAO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.Date" %>
<%@ page import="afero.util.ConverteDate"%>
<%@ page import="afero.util.Utilitaria"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script>
function confirmaExcluir(cont, id) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarDuplicataReceber.jsp?acao=exc&idDuplicata=' + id;   
  }  
}
function localizar() {
  document.forms[0].submit();
}
function novaPesquisa() {
  document.all.consNrDoc.value = '';
  document.all.nmDuplicata.value = '';
  document.all.status.value = ''; //não está limpando
  document.forms[0].submit();
}  
</script>
<%
Duplicata duplicata = new Duplicata();
DuplicataDAO dao;
DuplicataDAO daoExclusao;
DuplicataParcela duplicataParcela = null;
ContaDAO daoConta;
ConverteDate conDate = new ConverteDate();
ColaboradorDAO daoDuplicataColaborador = new ColaboradorDAO(conn);
String idUsuario = (String)session.getAttribute("idUsuario");
Colaborador colaboradorDuplicata = daoDuplicataColaborador.procurarColaboradorUsuario(Integer.parseInt(idUsuario));
String mensagem = request.getParameter("mensagem");
if(mensagem == null)mensagem = "";
String acao = request.getParameter("acao");
if (acao == null) acao = "listar";
String idDuplicata = "0";
String idLoja = "0";
String cdEntidade = "0";
String dc = "C";
String dtEmissao = "";
String dtComp = "";
String nrDoc = "0";
String idTipoDocumento = "0";
String idPlanoConta = "0";
String idCentroCusto = "0";
String historico = "";
String nrDiasPag="0";
String quantParcelas="0";
String valorTotal="0";
String gerarBoleto = "N";
String observacao = "";
String tipoLancamento = "M";
String txMulta = "0";
String txJuros = "0";
String tipoJuros = "M";
String status ="A";
String dtCad = "";
String dtMod = "";
String usuario = (String)session.getAttribute("Login");
String dsEntidade = request.getParameter("dsEntidade");
if(dsEntidade == null)dsEntidade = "";
String nmDuplicata = "";
String consNrDoc = "";
String clausula = "";
ConverteDate converte = new ConverteDate();
DuplicataParcelaDAO daoDuplicataParcela = new DuplicataParcelaDAO(conn);
//Duplicata Parcela
int idDuplicataParcela = 0;
int nrParcela = 0;
int idConta = 0;
String dtVenc = "";
double valor = 0;
int cdFormaPagto = 0;
String dtEmissaoParcela = "";
String dtCompParcela = "";
int nrDocParcela = 0;
int idPlanoContaParcela = 0;
int idCentroCustoParcela = 0;
String historicoParcela = "";
String divideValor = "";
String dtOperacao = "";
double vlOperacao = 0;
float vlJuros = 0;
float vlMulta = 0;
float vlDesc = 0;
String nossoNumero = "0";
String dtQuitacao = "";
String formaQuitacao = "";
int idColaborador = 0;
String atualizaFinanceiro = "";
int idContaMovto = 0;
String statusParcela = "";
String dtMov = "";
String usuarioParcela = "";
if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
	idDuplicata = request.getParameter("idDuplicata");
	idLoja = request.getParameter("idLoja");
	cdEntidade = request.getParameter("cdEntidade");
	dc = request.getParameter("dc");
	dtEmissao = request.getParameter("dtEmissao");
	dtComp = request.getParameter("dtComp");
	nrDoc = request.getParameter("nrDoc");
	idTipoDocumento = request.getParameter("idTipoDocumento");
	idPlanoConta = request.getParameter("idPlanoConta");
	idCentroCusto = request.getParameter("idCentroCusto");
	historico = request.getParameter("historico");
	nrDiasPag = request.getParameter("nrDiasPag");
	quantParcelas = request.getParameter("quantParcelas");
	valorTotal = request.getParameter("valorTotal");
	gerarBoleto = request.getParameter("gerarBoleto");
	observacao = request.getParameter("observacao");
	tipoLancamento = request.getParameter("tipoLancamento");
	txMulta = request.getParameter("txMulta");
	txJuros = request.getParameter("txJuros");
	tipoJuros = request.getParameter("tipoJuros");
	status = request.getParameter("status");
	dtCad = request.getParameter("dtCad");
	dtMod = request.getParameter("dtMod");
	usuario = (String) session.getAttribute("Login");
	if (acao == null) acao = "inc";
	if (idDuplicata == null) idDuplicata = "0";
	if(idLoja== null)idLoja= String.valueOf(colaboradorDuplicata.getIdLoja());
	if (cdEntidade == null) cdEntidade = "0";
	if(dc == null)dc = "C";
	if(dtEmissao == null)dtEmissao = "";
	if(dtComp == null)dtComp = "";
	if(nrDoc == null)nrDoc="0";
	if (idTipoDocumento == null) idTipoDocumento = "0";
	if (idPlanoConta == null) idPlanoConta = "0";
	if (idCentroCusto == null) idCentroCusto = "0";
	if (historico == null)historico="";
	if (nrDiasPag == null)nrDiasPag = "0";
	if (quantParcelas == null)quantParcelas="0"; 
	if (valorTotal == null)valorTotal = "0";
	if (gerarBoleto == null)gerarBoleto="N";
	if (observacao == null)observacao = "";
	if (tipoLancamento == null)tipoLancamento = "M";
	if (txMulta == null)txMulta = "0";
	if (txJuros == null)txJuros = "0";
	if (tipoJuros == null)tipoJuros="M";
	if (status == null)status="A";
	if (dtCad == null)dtCad = "";
	if (dtMod == null)dtMod = "";

	// CAMPOS PARCELA
         if(request.getParameter("idDuplicataParcela") != null){
        	 	idDuplicataParcela = Utilitaria.toNumber(request.getParameter("idDuplicataParcela")).intValue();
         }
         if(request.getParameter("nrParcela") != null){
        	 	nrParcela = Utilitaria.toNumber(request.getParameter("nrParcela")).intValue();
         }
         if(request.getParameter("idConta") != null){
        	 	idConta = Utilitaria.toNumber(request.getParameter("idConta")).intValue();
         }else{
        	 	idConta = 1;
         }
	dtVenc = request.getParameter("dtVenc");
	valor = Utilitaria.toNumber(valorTotal).doubleValue();
	if(request.getParameter("cdFormaPagto") != null){
		cdFormaPagto = Utilitaria.toNumber(request.getParameter("cdFormaPagto")).intValue();
	}else{
		cdFormaPagto = 1;
	}
	dtEmissaoParcela = dtEmissao;
	dtCompParcela = dtComp;
	nrDocParcela = Utilitaria.toNumber(nrDoc).intValue();	
	idPlanoContaParcela = Utilitaria.toNumber(idPlanoConta).intValue();
	idCentroCustoParcela = Utilitaria.toNumber(idPlanoConta).intValue();
	historico = request.getParameter("historico");
	if(request.getParameter("divideValor") != null){
		divideValor = request.getParameter("divideValor");
	}else{
		divideValor = "N";
	}
	if(request.getParameter("atualizaFinanceiro")!= null){
		atualizaFinanceiro = request.getParameter("atualizaFinanceiro");
	}else{
		atualizaFinanceiro="N";
	}
	dtOperacao = request.getParameter("dtOperacao");
	vlOperacao = Utilitaria.toNumber(valorTotal).doubleValue();
	vlJuros = 0;
	vlMulta = 0;
	vlDesc = 0;
	//Em teste
	if(request.getParameter("nossoNumero") != null){
		nossoNumero = request.getParameter("nossoNumero");
	}else{
		nossoNumero = "";
	}
	
	dtQuitacao = request.getParameter("dtQuitacao");
	formaQuitacao = request.getParameter("formaQuitacao");
	if(request.getParameter("idColaborador") != null){
		idColaborador = Utilitaria.toNumber(request.getParameter("idColaborador")).intValue();
	}else{
		idColaborador = 0;
	}
	
	atualizaFinanceiro = request.getParameter("atualizaFinanceiro");
	if(request.getParameter("idContaMovto") != null){
		idContaMovto = Utilitaria.toNumber(request.getParameter("idContaMovto")).intValue();
	}
	statusParcela = "NA";
	dtMov = request.getParameter("dtMov");
	usuarioParcela = usuario;
	// FIM CAMPOS PARCELA
	try {
		if (!acao.equalsIgnoreCase("inc")){ 
			duplicata.setIdDuplicata(Utilitaria.toNumber(idDuplicata).intValue());
		}
		duplicata.setIdLoja(Utilitaria.toNumber(idLoja).intValue());
      		duplicata.setCdEntidade(Utilitaria.toNumber(cdEntidade).intValue());
      		duplicata.setDc(dc);
      		if(dtEmissao != ""){
    			duplicata.setDtEmissao(ConverteDate.stringToDate(dtEmissao));  
      		}
      		if(dtComp != ""){
    	  		duplicata.setDtComp(ConverteDate.stringToDate(dtComp));  
    	  		duplicata.setStatus("DQ");
      		}
      		duplicata.setNrDoc(nrDoc);
      		duplicata.setIdTipoDocumento(Utilitaria.toNumber(idTipoDocumento).intValue());
      		duplicata.setIdPlanoConta(Utilitaria.toNumber(idPlanoConta).intValue());
      		duplicata.setIdCentroCusto(Utilitaria.toNumber(idCentroCusto).intValue());
      		duplicata.setHistorico(historico);
      		duplicata.setNrDiasPag(Utilitaria.toNumber(nrDiasPag).intValue());
      		duplicata.setQuantParcelas(Utilitaria.toNumber(quantParcelas).intValue());
      		duplicata.setValorTotal(Utilitaria.toNumber(valorTotal).doubleValue());
      		duplicata.setGerarBoleto(gerarBoleto);
      		duplicata.setObservacao(observacao);
      		duplicata.setTipoLancamento(tipoLancamento);
      		duplicata.setTxMulta(Utilitaria.toNumber(txMulta).floatValue());
      		duplicata.setTxJuros(Utilitaria.toNumber(txJuros).floatValue());
      		duplicata.setTipoJuros(tipoJuros);
      		duplicata.setStatus(status);
      		duplicata.setUsuario(usuario);
      		
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}
  dao = new DuplicataDAO(conn);
  daoExclusao = new DuplicataDAO(conn);
  double valorParcela = 0;
  String ultimaDataVencimento = null;
  String dataVencimento = null;
  if (acao.equalsIgnoreCase("inc")) {  
	  //inclui no banco de dados
  	  dao.incluir(duplicata);
	  duplicata.setIdDuplicata(dao.idDuplicataMax());
	  if(Utilitaria.toNumber(quantParcelas).intValue() > 0){
   		duplicataParcela = new DuplicataParcela();
   		DuplicataParcelaDAO daoParcela = new DuplicataParcelaDAO(conn);
   		for(int I = 1; I <= Utilitaria.toNumber(quantParcelas).intValue(); I++ ){
   			duplicataParcela.setIdDuplicata(duplicata.getIdDuplicata());
   			duplicataParcela.setNrParcela(I);
   			duplicataParcela.setIdConta(idConta);
   			//Início Data de Vencimento
   			if(ultimaDataVencimento == null){
   				dataVencimento = daoParcela.dataVencimentoDataAtual(Integer.parseInt(nrDiasPag));
   				ultimaDataVencimento = dataVencimento;
   			}else{
   				dataVencimento = daoParcela.dataVencimentoEntreDatas(ConverteDate.stringToDate(ultimaDataVencimento),Integer.parseInt(nrDiasPag));
   				ultimaDataVencimento = dataVencimento;
   			}
   			duplicataParcela.setDtVenc(ConverteDate.stringToDate(dataVencimento));
   			//Fim Data de Vencimento
   			//Valor da Parcela
   			valorParcela = (duplicata.getValorTotal() / Utilitaria.toNumber(quantParcelas).intValue());
   			duplicataParcela.setValor(valorParcela);
   		         //Valor da Parcela
   			duplicataParcela.setCdFormaPagto(cdFormaPagto);
   			duplicataParcela.setDtEmissao(duplicata.getDtEmissao());
   			duplicataParcela.setDtComp(duplicata.getDtComp());
   			duplicataParcela.setNrDoc(duplicata.getNrDoc());
   			duplicataParcela.setIdPlanoConta(duplicata.getIdPlanoConta());
   			duplicataParcela.setIdCentroCusto(duplicata.getIdCentroCusto());
   			duplicataParcela.setHistorico(duplicata.getHistorico());
   			duplicataParcela.setDivideValor(divideValor);
   			duplicataParcela.setDtOperacao(ConverteDate.stringToDate(dtOperacao));
   			duplicataParcela.setVlOperacao(valor); 
   			duplicataParcela.setVlJuros(vlJuros);
   			duplicataParcela.setVlMulta(vlMulta);
   			duplicataParcela.setVlDesc(vlDesc);
   			duplicataParcela.setNossoNumero(nossoNumero);
   			duplicataParcela.setDtQuitacao(ConverteDate.stringToDate(dtQuitacao));
   			duplicataParcela.setFormaQuitacao(formaQuitacao);
   			duplicataParcela.setIdColaborador(idColaborador);
   			duplicataParcela.setAtualizaFinanceiro(atualizaFinanceiro);
   			duplicataParcela.setIdContaMovto(idContaMovto);
   			duplicataParcela.setStatus(status);
   			duplicataParcela.setDtMov(ConverteDate.stringToDate(dtMov));
   			duplicataParcela.setUsuario(usuario);
   			
   			
   			daoParcela.incluir(duplicataParcela);
   		}
   	}
	 
  }else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
    	 dao.atualizar(duplicata);
  }else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  if(!daoExclusao.exclusaoIdDuplicata(Integer.parseInt(idDuplicata))){
		  dao.excluir(duplicata);
	  }else{
		  response.sendRedirect("listarDuplicataReceber.jsp?mensagem=Exclusão Inválida! Item já possui lançamentos.&acao=listar");
	  }
  }
}else {
 if(!acao.equalsIgnoreCase("voltar")) {
    nmDuplicata= request.getParameter("nmDuplicata");
    status = request.getParameter("status");
    consNrDoc = request.getParameter("consNrDoc");
    if (status == null) status = "A";
  }
  if (nmDuplicata!= null) {
    clausula = " WHERE e.nome LIKE'"+nmDuplicata+"%'";
  } 
  if(!status.isEmpty()) {
    if (clausula.isEmpty()) {
      clausula += " WHERE d.status='"+status+"'";
    }else {
      clausula += " AND d.status='"+status+"'";
   }
  }
  if(status.equals("")){
	 if (clausula.isEmpty()) {
	      clausula += " WHERE d.status is not null ";
	 }else {
	      clausula += " AND d.status is not null ";
	 }
  }
  
}

//seleciona todos os registros do banco de dados
List list;
dao = new DuplicataDAO(conn);
clausula = clausula+" AND d.dc = 'C' ";
list = dao.listarDuplicata(clausula);
daoConta = new ContaDAO(conn);

int cont = 0;
%>
<h1 class="cabecalho_pagina">Contas a Receber</h1>

|<a class="button" href="formDuplicataReceber.jsp?acao=inc">Novo Cadastro</a>|<br>

<body onload="document.forms[0].elements[0].focus();" >
<% if (mensagem != null) { %><div class="mensagem"><center><%=mensagem %></center></div><hr><% } %>
<form action="listarDuplicataReceber.jsp">
<table colspan="2">
<tr>
    <th class='label'>Número Doc.</th>
    <td><input type="text" name="consNrDoc" <%if (consNrDoc != null) { %>value="<%=consNrDoc %>"<% }%>  size="40" maxlength="40"></td>
  </tr>
  <tr>
    <th class='label'>Receber de</th>
    <td><input type="text" name="nmDuplicata" <%if (nmDuplicata != null) { %>value="<%=nmDuplicata %>"<% }%>  size="40" maxlength="40"></td>
    <td><input class="button" type="button" value="Localizar" onClick="javascript: localizar();" /></td>
    <td><input class="button" type="button" value="Nova pesquisa" onClick="javascript: novaPesquisa();" /></td>
  </tr>
  <tr>
    <th class="label">Status</th>
    <td class="label_radio">
      <input type="radio" class="radio" name="status" value="" <%= (status.equals("")? "checked": "") %>>Todos
      <input type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Ativo
      <input type="radio" class="radio" name="status" value="I" <%= (status.equals("I")? "checked": "") %>>Inativo
      <input type="radio" class="radio" name="status" value="DQ" <%= (status.equals("DQ")? "checked": "") %>>Quitado
      <input type="radio" class="radio" name="status" value="RP" <%= (status.equals("RP")? "checked": "") %>>Reparcelado</td>
  </tr>
</table>
<hr>

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr>
      <th class="grid">&nbsp;</th>
      <th class="grid"><center>Receber de</center></th>
      
      <th class="grid"><center>Data de Emissão</center></th>
      <th class="grid"><center>Data de Compensação</center></th>
      <th class="grid"><center>Valor</center></th>
      <th class="grid"><center>Quant. Parcelas</center></th>
      <th class="grid"><center>Parcelas Aberta</center></th>
      <th class="grid"><center>Parcelas Quitada</center></th>
      <th class="grid">Status</th>
      <th class="grid">Excluir</th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
String msgStatus = "";
String nomeCliente = "";
Entidade entidade = null;
Conta conta = null;
DuplicataParcelaDAO daoConsultaParcela = null;
EntidadeDAO daoEntidade = new EntidadeDAO(conn);
int contQuitada = 0;
int contAberta = 0;
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	Duplicata dup = (Duplicata) it.next();
	if(dup.getStatus().equals("I")){
		msgStatus = "INATIVO";
	}else if(dup.getStatus().equals("A")){
		msgStatus = "ATIVO";
	}else if(dup.getStatus().equals("DQ")){
		msgStatus = "QUITADO";
	}else{
		msgStatus = "REPARCELADO";
	}
	daoConsultaParcela = new DuplicataParcelaDAO(conn);
	contQuitada = daoConsultaParcela.contDuplicataParcelaQuitada(dup.getIdDuplicata());
	contAberta = daoConsultaParcela.contDuplicataParcelaAberta(dup.getIdDuplicata());
	entidade = daoEntidade.procurarEntidade(dup.getCdEntidade());
	nomeCliente = entidade.getNome();
	
	//conta.setNmConta(nomeCliente);
	cont++;

%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid"><center><a href="formDuplicataReceber.jsp?acao=atu&idDuplicata=<%=dup.getIdDuplicata()%>"><%=nomeCliente%> </a></center></td>
	  
      <%if(dup.getDtEmissao() != null){ %>    
      	<td class = "grid" width="10%"><center><%=converte.dateToString(dup.getDtEmissao())%></center></td>
      <%}else{ %>
      	<td class = "grid" width="10%"><center>-</center></td>
      <%} %>
      <%if(dup.getDtComp() != null){ %>
      	<td class = "grid" width="10%"><center><%=converte.dateToString(dup.getDtComp())%></center></td>
      <%}else{%>
      	<td class = "grid" width="10%"><center>-</center></td>
      <%} %>
      <td class = "grid" width="10%"><center><%=Utilitaria.formatarNumero(dup.getValorTotal(),2)%></center></td>
      <td class = "grid" width="10%"><center><%=dup.getQuantParcelas()%></center></td>
      <td class = "grid" width="5%"><center><a href="listarDuplicataParcela.jsp?idDuplicata=<%=dup.getIdDuplicata()%>&status=<%="A"%>&voltarDC=<%="C"%>"><%=contAberta%>(Ver)</a></center></td>
      <td class = "grid" width="5%"><center><a href="listarDuplicataParcela.jsp?idDuplicata=<%=dup.getIdDuplicata()%>&status=<%="DQ"%>&voltarDC=<%="C"%>"><%=contQuitada%>(Ver)</a></center></td>
      <td class = "grid" width="5%"><center><%=msgStatus%></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=dup.getIdDuplicata()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
  	</tr>
<%
}
%>  
</table>
</form>
<p align="right">|<a class="button" href="formDuplicataReceber.jsp?acao=inc">Novo Cadastro</a>|