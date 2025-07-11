<%@page import="afero.model.TipoConta"%>
<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.Conta" %>
<%@ page import="afero.persistence.ContaDAO" %>
<%@ page import="afero.model.TipoConta" %>
<%@ page import="afero.persistence.TipoContaDAO" %>
<%@ page import="afero.model.Banco" %>
<%@ page import="afero.persistence.BancoDAO" %>
<%@ page import="afero.model.ContaMovto" %>
<%@ page import="afero.persistence.ContaMovtoDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="afero.util.Utilitaria"%>
<%@ page import="java.util.Date" %>
<%@ page import="afero.util.ConverteDate" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function confirmaExcluir(cont, id) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarConta.jsp?acao=exc&idConta=' + id;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.dsConta.value = '';
  document.all.status.value = ''; //não está limpando
  document.forms[0].submit();
}  
</script>

<%

ContaDAO dao;
ContaDAO daoExclusao;
ConverteDate conDate = new ConverteDate();
String mensagem = request.getParameter("mensagem");
if(mensagem == null)mensagem = "";
String acao = request.getParameter("acao");
if (acao == null) acao = "listar";
String idLoja = "0";
String idConta = "0";
String idTipoConta = "0";
String idBanco = "0";
String nmConta = "";
String agencia = "";
String contaCorrente = "";
float vlLimiteCredito = 0;
String dtVencLimite = "";
String dtSaldoAbertura = "";
float vlSaldoAbertura = 0;
String paginaInicial = "";
String status ="A";
String pessoaContato = "";
String nroTelefone = "";
String email = "";
String site = "";
String observacao = "";
String dtCad = "";
String dtMod = "";
String usuario = "";
String dsConta = "";
String clausula = "";

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
	idLoja = request.getParameter("idLoja");
	if(idLoja == null)idLoja = "0";
	idConta = request.getParameter("idConta");
	if(idConta == null)idConta = "0";
	idTipoConta = request.getParameter("idTipoConta");
	if(idTipoConta == null)idTipoConta = "0";
	idBanco = request.getParameter("idBanco");
	if(idBanco == null)idBanco = "0";
	if(request.getParameter("nmConta") != null){
		nmConta = request.getParameter("nmConta");	
	}
	agencia = request.getParameter("agencia");
	if(agencia == null)agencia="";
	contaCorrente = request.getParameter("contaCorrente");
	if(contaCorrente == null)contaCorrente="";
	if(request.getParameter("vlLimiteCredito")!= null){
		vlLimiteCredito = Utilitaria.toNumber(request.getParameter("vlLimiteCredito")).floatValue();
	}
	
	dtVencLimite = request.getParameter("dtVencLimite");
	if(dtVencLimite == null)dtVencLimite = "";
	dtSaldoAbertura = request.getParameter("dtSaldoAbertura");
	if(dtSaldoAbertura == null)dtSaldoAbertura = "";
	if(request.getParameter("vlSaldoAbertura")!=null){
		vlSaldoAbertura = Utilitaria.toNumber(request.getParameter("vlSaldoAbertura")).floatValue();
	}
	if(request.getParameter("paginaInicial") != null){
		paginaInicial = request.getParameter("paginaInicial");	
	}else{
		paginaInicial = "N";
	}
	
	
	status = request.getParameter("status");
	if(status == null)status="A";
	pessoaContato = request.getParameter("pessoaContato");
	if(pessoaContato == null)pessoaContato = "";
	nroTelefone = request.getParameter("nroTelefone");
	if(nroTelefone == null)nroTelefone = "";
	email = request.getParameter("email");
	if(email == null)email="";
	site = request.getParameter("site");
	if(site == null)site="";
	observacao = request.getParameter("observacao");
	if(observacao == null)observacao = "";
	usuario = request.getParameter("usuario");
	if(usuario == null)usuario = (String)session.getAttribute("Login");
    Conta conta = new Conta();
  
	try {
	  if (!acao.equalsIgnoreCase("inc")){
		  conta.setIdConta(Integer.parseInt(idConta));
	  }
	  conta.setAgencia(agencia);
	  conta.setContaCorrente(contaCorrente);
	  conta.setEmail(email);
	  conta.setIdBanco(Integer.parseInt(idBanco));
	  conta.setIdTipoConta(Integer.parseInt(idTipoConta));
	  conta.setIdLoja(Integer.parseInt(idLoja));
	  if(dtVencLimite != ""){
		  conta.setDtVencLimite(ConverteDate.stringToDate(dtVencLimite));
	  }
	  if(dtSaldoAbertura != ""){
		  conta.setDtSaldoAbertura(ConverteDate.stringToDate(dtSaldoAbertura));
	  }
	  
	  conta.setNmConta(nmConta);
	  conta.setPaginaInicial(paginaInicial);
	  conta.setObservacao(observacao);
	  conta.setNroTelefone(nroTelefone);
	  conta.setPessoaContato(pessoaContato);
	  conta.setSite(site);
	  conta.setStatus(status);
	  conta.setUsuario(usuario);
	  conta.setVlLimiteCredito(vlLimiteCredito);
	  conta.setVlSaldoAbertura(vlSaldoAbertura);
    if (!acao.equalsIgnoreCase("exc")){
    	  conta.setIdConta(Integer.parseInt(idConta));
    }
      
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}


  dao = new ContaDAO(conn);
  daoExclusao = new ContaDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {  
	  //inclui no banco de dados
  	dao.incluir(conta);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
    	 dao.atualizar(conta);
  }else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  if(!daoExclusao.exclusaoIdConta(Integer.parseInt(idConta))){
		  dao.excluir(conta);
	  }else{
		  response.sendRedirect("listarConta.jsp?mensagem=Exclusão Inválida! Item já possui lançamentos.&acao=listar");
	  }
	  
  }
} else {
 if (!acao.equalsIgnoreCase("voltar")) {
	 dsConta = request.getParameter("dsConta");
     status = request.getParameter("status");
     if (status == null) status = "";
  }

  if (dsConta!= null) {
    clausula = " WHERE nmConta LIKE '"+dsConta+"%'";
  } 
  if (!status.isEmpty()) {
    if (clausula.isEmpty()) {
      clausula = " WHERE status='"+status+"'";
    } else {
      clausula = clausula+" AND status='"+status+"'";
    }
  }
}

//seleciona todos os registros do banco de dados
List list;
dao = new ContaDAO(conn);
clausula = clausula+" ORDER BY nmConta ";
list = dao.listarConta(clausula);

int cont = 0;
%>
<h1 class="cabecalho_pagina">Cadastro de Conta</h1>

|<a class="button" href="formConta.jsp?acao=inc">Novo Cadastro</a>|<br>

<body onload="document.forms[0].elements[0].focus();" >
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<form action="listarConta.jsp" method="get">
<table colspan="2">
  <tr>
    <th class='label'>Nome da Conta</th>
    <td><input type="text" name="dsConta" <%if (dsConta != null) { %>value="<%=dsConta %>"<% }%>  size="40" maxlength="40"></td>
    <td><input class="button" type="button" value="Localizar" onClick="javascript: localizar();" /></td>
    <td><input class="button" type="button" value="Nova pesquisa" onClick="javascript: novaPesquisa();" /></td>
  </tr>
  <tr>
    <th class="label">Status</th>
    <td class="label_radio">
      <input type="radio" class="radio" name="status" value="" <%= (status.equals("")? "checked": "") %>>Todos
      <input type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Ativo
      <input type="radio" class="radio" name="status" value="I" <%= (status.equals("I")? "checked": "") %>>Inativo</td>
  </tr>
</table>
<hr>

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr>
      <th class="grid">&nbsp;</th>
      <th class="grid"><center>Tipo da Conta</center></th>
      <th class="grid"><center>Nome da Conta</center></th>
      <th class="grid"><center>Banco</center></th>
      <th class="grid"><center>Agência</center></th>
      <th class="grid"><center>Conta Corrente</center></th>
      <th class="grid"><center>Saldo Atual</center></th>
      <th class="grid">Status</th>
      <th class="grid">Excluir</th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
String msgStatus = "";
TipoContaDAO tipoContaDAO = new TipoContaDAO(conn);
TipoConta tipoConta;
BancoDAO bancoDAO = new BancoDAO(conn);
Banco banco;
ContaMovtoDAO contaMovtoDAO = new ContaMovtoDAO(conn);
ContaMovto contaMovto;
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	Conta contaLista = (Conta) it.next();
	if(contaLista.getStatus().equals("I")){
		msgStatus = "INATIVO";
	}else{
		msgStatus = "ATIVO";
	}
	tipoConta = tipoContaDAO.procurarTipoConta(contaLista.getIdTipoConta());
	if (contaLista.getIdBanco() == 0) {
		banco = null;		
	} else {
		banco = bancoDAO.procurarBanco(contaLista.getIdBanco());
	}
  cont++;

%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid"><center><%=tipoConta.getDsTipoConta()%></center></td>
      <td class = "grid"><center><a href="formConta.jsp?acao=atu&idConta=<%=contaLista.getIdConta()%>"><%=contaLista.getNmConta()%> </a></center></td>
      <%
      if (banco == null) {
      %>
      	<td class = "grid" width="25%"><center></center></td>
      	<td class = "grid" width="10%"><center></center></td>
      	<td class = "grid" width="10%"><center></center></td>
      <%} else { %>
      	<td class = "grid" width="25%"><center><%=banco.getNmBanco()%></center></td>
      	<td class = "grid" width="10%"><center><%=contaLista.getAgencia()%></center></td>
      	<td class = "grid" width="10%"><center><%=contaLista.getContaCorrente()%></center></td>
      <%} %>
      <td class = "grid" width="10%"><center><%=Utilitaria.formatarNumero(contaLista.getVlSaldoAtual(), 2)%></center></td>
      <td class = "grid" width="5%"><center><%=msgStatus%></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=contaLista.getIdConta()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
  	</tr>
<%
}
%>   
</table>
</form>
<p align="right">|<a class="button" href="formConta.jsp?acao=inc">Novo Cadastro</a>|