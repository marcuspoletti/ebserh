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
       location.href = 'listarDuplicata.jsp?acao=exc&idDuplicata=' + id;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.nmDuplicata.value = '';
  document.all.status.value = ''; //não está limpando
  document.forms[0].submit();
}  
</script>

<%
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
String dc = "D";
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
String usuario = (String) session.getAttribute("Login");
String dsEntidade = request.getParameter("dsEntidade");
if(dsEntidade == null)dsEntidade = "";
String nmDuplicata = "";
String clausula = "";
ConverteDate converte = new ConverteDate();
DuplicataParcelaDAO daoDuplicataParcela = new DuplicataParcelaDAO(conn);
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
	if(dc == null)dc = "D";
	if(dtEmissao == null)dtEmissao = "";
	if(dtComp == null)dtComp = "";
	if(nrDoc == null)nrDoc="";
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
	if(request.getParameter("quantParcelas") != null){
		quantParcelas = Utilitaria.toNumber(request.getParameter("quantParcelas")).intValue();
	}
	if(status == null)status="A";
	
	Duplicata duplicata = new Duplicata();
  
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
      if (!acao.equalsIgnoreCase("exc")){
    	  duplicata.setIdDuplicata(Integer.parseInt(idDuplicata));
      }
      
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}


  dao = new DuplicataDAO(conn);
  daoExclusao = new DuplicataDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {  
	  //inclui no banco de dados
  	dao.incluir(duplicata);
	  
	  //Falta Implementar Duplicata Parcela
  	 if(Utilitaria.toNumber(quantParcelas).intValue() != 0){
   	  duplicataParcela = new DuplicataParcela();
   	  for(int I=0;I<=Utilitaria.toNumber(quantParcelas).intValue();I++ ){
   		  
   	  }
     }
	  //Falta Implementar

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
    	 dao.atualizar(duplicata);
  }else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  if(!daoExclusao.exclusaoIdDuplicata(Integer.parseInt(idDuplicata))){
		  dao.excluir(duplicata);
	  }else{
		  response.sendRedirect("listarDuplicata.jsp?mensagem=Exclusão Inválida! Item já possui lançamentos.&acao=listar");
	  }
	  
  }
} else {
 if(!acao.equalsIgnoreCase("voltar")) {
    nmDuplicata= request.getParameter("nmDuplicata");
    status = request.getParameter("status");
    if (status == null) status = "A";
  }
  if (nmDuplicata!= null) {
    clausula = " WHERE e.nome LIKE'"+nmDuplicata+"%'";
  } 
  if(!status.isEmpty()) {
    if (clausula.isEmpty()) {
      clausula = " WHERE d.status='"+status+"'";
    }else {
      clausula = " AND d.status='"+status+"'";
   }
  }
  if(status.equals("")){
	 if (clausula.isEmpty()) {
	      clausula = " WHERE d.status is not null ";
	 }else {
	      clausula = " AND d.status is not null ";
	 }
  }
}

//seleciona todos os registros do banco de dados
List list;
dao = new DuplicataDAO(conn);
clausula = clausula+" AND d.dc = 'D' ";
list = dao.listarDuplicata(clausula);
daoConta = new ContaDAO(conn);

int cont = 0;
%>
<h1 class="cabecalho_pagina">Contas a Pagar</h1>

|<a class="button" href="formDuplicata.jsp?acao=inc">Novo Cadastro</a>|<br>

<body onload="document.forms[0].elements[0].focus();" >
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<form action="listarDuplicata.jsp">
<table colspan="2">
  <tr>
    <th class='label'>Pagar para</th>
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
    <tr">
      <th class="grid">&nbsp;</th>
      <th class="grid"><center>Pagar para</center></th>
      <th class="grid"><center>Conta</center></th>
      <th class="grid"><center>Data de Emissão</center></th>
      <th class="grid"><center>Data de Compensação</center></th>
      <th class="grid"><center>Valor</center></th>
      <th class="grid"><center>Baixa do Título</center></th>
      <th class="grid">Status</th>
      <th class="grid">Excluir</th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
String msgStatus = "";
String nomeCliente = "";
Entidade entidade = null;
Conta conta = null;
EntidadeDAO daoEntidade = new EntidadeDAO(conn);
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
	entidade = daoEntidade.procurarEntidade(dup.getCdEntidade());
	nomeCliente = entidade.getNome();
	cont++;

%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid"><center><a href="formDuplicata.jsp?acao=atu&idDuplicata=<%=dup.getIdDuplicata()%>"><%=nomeCliente%> </a></center></td>
      <td class = "grid"><center><%=conta.getNmConta()%></center></td>
      <td class = "grid" width="10%"><center><%=converte.dateToString(dup.getDtEmissao())%></center></td>
      <td class = "grid" width="10%"><center><%=converte.dateToString(dup.getDtComp())%></center></td>
      <td class = "grid" width="10%"><center><%=Utilitaria.formatarNumero(dup.getValorTotal(),2)%></center></td>
      <td class = "grid" width="10%"><center><a href="baixaPagamento.jsp?acao=atu&idDuplicata=<%=dup.getIdDuplicata()%>"><img border = "0" src="../images/baixa.gif"></a></center></td>
      <td class = "grid" width="5%"><center><%=msgStatus%></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=dup.getIdDuplicata()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
  	</tr>
<%
}
%>   
</table>
</form>
<p align="right">|<a class="button" href="formDuplicata.jsp?acao=inc">Novo Cadastro</a>|