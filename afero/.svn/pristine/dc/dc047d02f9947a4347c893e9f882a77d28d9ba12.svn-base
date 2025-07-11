<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.ChegueRecebido"%>
<%@ page import="afero.model.DuplicataParcela"%>
<%@ page import="afero.model.Colaborador"%>
<%@ page import="afero.model.Entidade"%>
<%@ page import="afero.model.Conta"%>
<%@ page import="afero.model.Banco"%>
<%@ page import="afero.persistence.ChequeRecebidoDAO"%>
<%@ page import="afero.persistence.DuplicataParcelaDAO"%>
<%@ page import="afero.persistence.ColaboradorDAO"%>
<%@ page import="afero.persistence.EntidadeDAO"%>
<%@ page import="afero.persistence.ContaDAO"%>
<%@ page import="afero.persistence.BancoDAO"%>
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
       location.href = 'listarChequeRecebido.jsp?acao=exc&idChequeRecebido='+id;
  }  
}
function localizar() {
  document.forms[0].submit();
}

function recarregar(acao) {
  document.forms[0].action='listarChequeRecebido.jsp?acao='+acao;
  document.forms[0].submit();
}

function novaPesquisa() {
  document.all.idLojaLocalizar.value = '';
  document.all.nmEntidade.value = '';
  document.all.nmCorrentista.value = '';
  document.all.statusLocalizar[0].value = 'A';
  document.all.statusLocalizar[1].value = '';
  document.all.statusLocalizar[2].value = '';
  document.all.statusLocalizar[3].value = '';
  document.all.statusLocalizar[4].value = '';
  document.forms[0].submit();
}  
</script>

<%
String idLojaLocalizar = request.getParameter("idLojaLocalizar");
if(idLojaLocalizar == null)idLojaLocalizar="0";
String nmCorrentista = "";
String statusLocalizar = "A";

ChegueRecebido chequeRecebido = new ChegueRecebido();
ChequeRecebidoDAO dao;
ChequeRecebidoDAO daoExclusao;
ConverteDate conDate = new ConverteDate();
ColaboradorDAO daoColaborador = new ColaboradorDAO(conn);
String idUsuario = (String)session.getAttribute("idUsuario");
Colaborador colaborador = daoColaborador.procurarColaboradorUsuario(Integer.parseInt(idUsuario));
if (idLojaLocalizar.isEmpty() || idLojaLocalizar.equals("0")) idLojaLocalizar = "".valueOf(colaborador.getIdLoja());
String mensagem = request.getParameter("mensagem");
if(mensagem == null)mensagem = "";
String acao = request.getParameter("acao");
if (acao == null) acao = "listar";
 
String idLoja = "";
String nmCheque = "0";
String nmEntidade = "";
String idChequeRecebido;
String cdEntidade;
String idBanco;
String agencia;
String dvAgencia;
String contaCorrente;
String dvConta;
String nrCheque = "0";
String valor;
String dtEmissao;
String dtVenc;
String correntista;
String cpfCnpj;
String destino;
String observacao;
String dtReceb;
String idContaMovto;
String status = "A";
String dtCad;
String dtMod;
String usuario;

String clausula = "";
ConverteDate converte = new ConverteDate();
ChequeRecebidoDAO daoChequeRecebido = new ChequeRecebidoDAO(conn);
if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
	
	idChequeRecebido = request.getParameter("idChequeRecebido");	
	idLoja = request.getParameter("idLoja");
	cdEntidade = request.getParameter("cdEntidade");
	idBanco = request.getParameter("idBanco");
	agencia = request.getParameter("agencia");
	dvAgencia = request.getParameter("dvAgencia");
	contaCorrente = request.getParameter("contaCorrente");
	dvConta = request.getParameter("dvConta");
	nrCheque = request.getParameter("nrCheque");
	valor = request.getParameter("valor");
	dtEmissao = request.getParameter("dtEmissao");
	dtVenc = request.getParameter("dtVenc");
	correntista = request.getParameter("correntista");
	cpfCnpj = request.getParameter("cpfCnpj");
	destino = request.getParameter("destino");
	observacao = request.getParameter("observacao");
	dtReceb = request.getParameter("dtReceb");
	idContaMovto = request.getParameter("idContaMovto");
	status = request.getParameter("status");
	dtCad = request.getParameter("dtCad");
	dtMod = request.getParameter("dtMod");
	usuario = request.getParameter("usuario");

	if(idChequeRecebido == null) idChequeRecebido = "0";
	if(idLoja == null)idLoja = "0";
	if(cdEntidade == null)cdEntidade = "0";
	if(idBanco == null)idBanco = "0";
	if(agencia == null)agencia = "";
	if(dvAgencia == null)dvAgencia = "";
	if(contaCorrente == null)contaCorrente = "";
	if(dvConta == null)dvConta = "";
	if(nrCheque == null)nrCheque="0";
	if(valor == null)valor = "0";
	if(dtEmissao == null)dtEmissao = "";
	if(dtVenc == null)dtVenc = "";
	if(correntista == null)correntista = "";
	if(cpfCnpj == null)cpfCnpj = "";
	if(destino == null)destino = "";
	if(observacao == null)observacao = "";
	if(dtReceb == null)dtReceb = "";
	if(idContaMovto == null)idContaMovto="0";
	if(status == null)status="A";
	if(dtCad == null)dtCad = "";
	if(dtMod == null)dtMod = "";

	try {

		  if (!acao.equalsIgnoreCase("inc")){
		  	chequeRecebido.setIdChegueRecebido(Utilitaria.toNumber(idChequeRecebido).intValue());
		  }
		  
		  chequeRecebido.setIdLoja(Utilitaria.toNumber(idLoja).intValue());
		  chequeRecebido.setCdEntidade(Utilitaria.toNumber(cdEntidade).intValue());
		  chequeRecebido.setIdBanco(Utilitaria.toNumber(idBanco).intValue());
		  chequeRecebido.setAgencia(agencia);
		  chequeRecebido.setDvAgencia(dvAgencia);
		  chequeRecebido.setContaCorrente(contaCorrente);
		  chequeRecebido.setDvConta(dvConta);
		  chequeRecebido.setNrChegue(Utilitaria.toNumber(nrCheque).intValue());
		  chequeRecebido.setValor(Utilitaria.toNumber(valor).doubleValue());
		  
		  if(dtEmissao != ""){
			  chequeRecebido.setDtEmissao(ConverteDate.stringToDate(dtEmissao));  
		  }
		  if(dtVenc != ""){
			  chequeRecebido.setDtVenc(ConverteDate.stringToDate(dtVenc));   
		  }
		  		  
		  chequeRecebido.setCorrentista(correntista);
		  chequeRecebido.setCpfCnpj(cpfCnpj);
		  chequeRecebido.setDestino(destino);
		  chequeRecebido.setObservacao(observacao);
		  
		  if(dtReceb != ""){
			  chequeRecebido.setDtReceb(ConverteDate.stringToDate(dtReceb));  
		  }
		  
		  chequeRecebido.setIdContaMovto(Utilitaria.toNumber(idContaMovto).intValue());
		  chequeRecebido.setStatus(status);
		  chequeRecebido.setUsuario(usuario);
		  
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}


  dao = new ChequeRecebidoDAO(conn);
  daoExclusao = new ChequeRecebidoDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {  
	  //inclui no banco de dados
  	dao.incluir(chequeRecebido);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
    	 dao.atualizar(chequeRecebido);
  }else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  	chequeRecebido.setIdChegueRecebido(Utilitaria.toNumber(idChequeRecebido).intValue());
		  dao.excluir(chequeRecebido);
  }
}else {
	 if (!acao.equalsIgnoreCase("voltar")) {
	     nmCheque = request.getParameter("nmCheque");
	     nmEntidade = request.getParameter("nmEntidade");
	     nmCorrentista = request.getParameter("nmCorrentista");
	     statusLocalizar = request.getParameter("statusLocalizar");
	     if (statusLocalizar == null) statusLocalizar = "A";
	  }
	  if (nmEntidade!= null && !nmEntidade.isEmpty()) {
	      if (clausula.isEmpty()) {
		      clausula = " WHERE e.nome like '"+nmEntidade+"%'";
	      } else {
		      clausula += " AND e.nome like '"+nmEntidade+"%'";
	      }  
	  }
	  if (nmCorrentista!= null && !nmCorrentista.isEmpty()) {
	      if (clausula.isEmpty()) {
		      clausula = " WHERE ch.correntista like '"+nmCorrentista+"%'";
	      } else {
		      clausula += " AND ch.correntista like '"+nmCorrentista+"%'";
	      }  
	  }
	  if (!statusLocalizar.isEmpty()) {
		  if (clausula.isEmpty()) {
		    clausula = " WHERE ch.status='"+statusLocalizar+"'";
		  } else {
		    clausula = clausula+" AND ch.status='"+statusLocalizar+"'";
		  }
		}
	  if (clausula.isEmpty()) {
		    clausula = " WHERE idLoja="+idLojaLocalizar;
	  } else {
	    clausula = clausula+" AND idLoja="+idLojaLocalizar;
	  }
}

//seleciona todos os registros do banco de dados
List list;
dao = new ChequeRecebidoDAO(conn);
clausula = clausula+" order by ch.nrCheque";
list = dao.listarChegueRecebido(clausula);

int cont = 0;
%>
<h1 class="cabecalho_pagina">Cheques Recebidos</h1>

|<a class="button" href="formChequeRecebido.jsp?acao=inc">Novo Cadastro</a>|<br>

<body onload="document.forms[0].elements[0].focus();" >
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<form action="listarChequeRecebido.jsp">
<table colspan="4">
  <tr>
    <th class="label">Loja</th>
    <td><select name="idLojaLocalizar" >
        <%@include file="../WEB-INF/jspf/combo/comboLoja.jspf" %></select>
        <script>comboSelect(document.forms[0].idLojaLocalizar, '<%=idLojaLocalizar%>');</script>
    </td>
    <th class='label'>Entidade</th>
    <td><input type="text" name="nmEntidade" <%if (nmEntidade != null) { %>value="<%=nmEntidade %>"<% }%> size="40" maxlength="40"></td>
    <td><input class="button" type="button" value="Localizar" onClick="javascript: localizar();" /></td>
    <td><input class="button" type="button" value="Nova pesquisa" onClick="javascript: novaPesquisa();" /></td>
  </tr>
	<tr>
    <th class='label'>Correntista</th>
    <td><input type="text" name="nmCorrentista" <%if (nmCorrentista != null) { %>value="<%=nmCorrentista %>"<% }%> size="40" maxlength="40"></td>
    <th class="label">Status</th>
    <td class="label_radio">
      <input type="radio" class="radio" name="statusLocalizar" value="" <%= (statusLocalizar.equals("")? "checked": "") %>>Todos
      <input type="radio" class="radio" name="statusLocalizar" value="A" <%= (statusLocalizar.equals("A")? "checked": "") %>>A Receber
      <input type="radio" class="radio" name="statusLocalizar" value="R" <%= (statusLocalizar.equals("R")? "checked": "") %>>Recebido
      <input type="radio" class="radio" name="statusLocalizar" value="D" <%= (statusLocalizar.equals("D")? "checked": "") %>>Devolvido
      <input type="radio" class="radio" name="statusLocalizar" value="Q" <%= (statusLocalizar.equals("Q")? "checked": "") %>>Devolvido/Quitado
    </td>
  </tr>
</table>
<hr>

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr">
      <th class="grid">&nbsp;</th>
			<th class="grid"><center>Entidade</center></th>      
			<th class="grid"><center>Banco / Agência / Conta</center></th>      
			<th class="grid"><center>Cheque</center></th>      
			<th class="grid"><center>Correntista</center></th>      
      <th class="grid"><center>Emissão</center></th>
      <th class="grid"><center>Vencimento</center></th>
      <th class="grid"><center>Valor</center></th>
      <th class="grid"><center>Compesação</center></th>
      <th class="grid">Status</th>
      <th class="grid">Excluir</th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
String msgStatus = "";
String conta = "";
Entidade entidade = null;
Banco banco = null;
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	ChegueRecebido chequeRecebidoListar = (ChegueRecebido) it.next();
	EntidadeDAO daoEntidade = new EntidadeDAO(conn);
	entidade = daoEntidade.procurarEntidade(chequeRecebidoListar.getCdEntidade());
	BancoDAO daoBanco = new BancoDAO(conn);
	banco = daoBanco.procurarBanco(chequeRecebidoListar.getIdBanco());
	cont++;
	if (chequeRecebidoListar.getStatus().equalsIgnoreCase("A")){
		msgStatus = "A receber";
	} else if(chequeRecebidoListar.getStatus().equalsIgnoreCase("R")) {
		msgStatus = "Recebido";
	} else if(chequeRecebidoListar.getStatus().equalsIgnoreCase("D")) {
		msgStatus = "Devolvido";
	} else if(chequeRecebidoListar.getStatus().equalsIgnoreCase("Q")) {
		msgStatus = "Devolvido/Quitado";
	}
conta = banco.getNrBanco()+" | "+
				chequeRecebidoListar.getAgencia()+"-"+chequeRecebidoListar.getDvAgencia()+" | "+
				chequeRecebidoListar.getContaCorrente()+"-"+chequeRecebidoListar.getDvConta();
%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
        <td class = "grid"><center><%=entidade.getNome()%></center></td>
        <td class = "grid"><center><%=conta%></center></td>
      <% if(chequeRecebidoListar.getStatus().equalsIgnoreCase("A")){%>
      	<td class = "grid"><center><a href="formChequeRecebido.jsp?acao=atu&idChequeRecebido=<%=chequeRecebidoListar.getIdChegueRecebido()%>"><%=chequeRecebidoListar.getNrChegue()%></a></center></td>
      <%}else{ %>
        <td class = "grid"><center><a href="visualizarChegueRecebido.jsp?acao=atu&idChequeRecebido=<%=chequeRecebidoListar.getIdChegueRecebido()%>"><%=chequeRecebidoListar.getNrChegue()%></a></center></td>
      <%} %>
        <td class = "grid"><center><%=chequeRecebidoListar.getCorrentista()%></center></td>
      <%if(chequeRecebidoListar.getDtEmissao() != null){%>
        <td class = "grid" width="10%"><center><%=converte.dateToString(chequeRecebidoListar.getDtEmissao())%></center></td>
      <%}else{ %>
         <td class = "grid" width="10%"><center>-</center></td>
      <%} %>
      <%if(chequeRecebidoListar.getDtVenc() != null){ %>
         <td class = "grid" width="10%"><center><%=converte.dateToString(chequeRecebidoListar.getDtVenc())%></center></td>
      <%}else{ %>
      	<td class = "grid" width="10%"><center>-</center></td>
      <%} %>
      <td class = "grid" width="10%"><center><%=Utilitaria.formatarNumero(chequeRecebidoListar.getValor(),2)%></center></td>
      <% if(chequeRecebidoListar.getDtReceb() != null){%>
       	<td class = "grid" width="10%"><center><%=converte.dateToString(chequeRecebidoListar.getDtReceb())%></center></td>
      <%}else{ %>
        <td class = "grid" width="10%"><center>-</center></td>
      <%} %>
      <td class = "grid" width="5%"><center><%=msgStatus%></center></td>
      <%if(chequeRecebidoListar.getStatus().equalsIgnoreCase("A")){ %>
        <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=chequeRecebidoListar.getIdChegueRecebido()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
      <%}else{%>
        <td class = "grid" width="3%"><center>-</center></td>
      <%} %>  
  	</tr>
<%
}
%>   
</table>
</form>
<p align="right">|<a class="button" href="formChequeRecebido.jsp?acao=inc">Novo Cadastro</a>|<br>