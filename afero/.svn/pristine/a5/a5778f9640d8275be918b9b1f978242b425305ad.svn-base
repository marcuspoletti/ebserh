<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.Entidade" %>
<%@ page import="afero.model.EntidadeFisica" %>
<%@ page import="afero.model.EntidadeJuridica" %>
<%@ page import="afero.model.EntidadeEndereco" %>
<%@ page import="afero.model.EntidadeTelefone" %>
<%@ page import="afero.model.EntidadeEmail" %>
<%@ page import="afero.model.Classificacao" %>
<%@ page import="afero.persistence.EntidadeDAO" %>
<%@ page import="afero.persistence.EntidadeFisicaDAO" %>
<%@ page import="afero.persistence.EntidadeJuridicaDAO" %>
<%@ page import="afero.persistence.EntidadeEnderecoDAO" %>
<%@ page import="afero.persistence.EntidadeTelefoneDAO" %>
<%@ page import="afero.persistence.EntidadeEmailDAO" %>
<%@page import="afero.persistence.ClassificacaoDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="afero.util.ConverteDate" %>
<%@ page import="java.text.ParseException" %>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<script>

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.nomeLocalizar.value = '';
  document.all.cpfLocalizar.value = '';
  document.all.statusLocalizar.value = 'A'; //não está limpando
  document.all.telefone.value = '';
  document.all.tpInsc.value = 'F';
  document.forms[0].submit();
}  
</script>

<%
EntidadeFisicaDAO daoFisica;
EntidadeJuridicaDAO daoJuridica;
String acao = request.getParameter("acao");
if (acao == null) acao = "listar";
String sdEntidade = request.getParameter("cdEntidade");
if(sdEntidade == null)sdEntidade = "0";
int cdEntidade = Integer.parseInt(sdEntidade);
String idLoja = "0";
String idBanco = "0";
String agencia = "";
String dvAgencia = "";
String contaCorrente = "";
String dvConta = "";
String nrCheque = "";
String valor = "0";
String dtEmissao = "";
String dtVenc = "";
String correntista = "";
String cpfCnpjParametro = "";
String destino = "";
String observacao = "";
String dtRecebido = "";
String idContaMovto = "0";
String status = "";
String dtCad = "";
String dtMod = "";

// Requests
	
	String idChequeRecebido = request.getParameter("idChequeRecebido");
	
	String usuario = (String) session.getAttribute("Login");
	
	idLoja = request.getParameter("idLoja");
	
	idBanco = request.getParameter("idBanco");
	
	if (request.getParameter("agencia") != null){
	   agencia = request.getParameter("agencia");
	}
	if (request.getParameter("dvAgencia") != null){
	   dvAgencia = request.getParameter("dvAgencia");
	}
	if (request.getParameter("contaCorrente") != null){
	   contaCorrente = request.getParameter("contaCorrente");
	}
	if (request.getParameter("dvConta") != null){
	   dvConta = request.getParameter("dvConta");
	}
	if (request.getParameter("nrCheque") != null){
	   nrCheque = request.getParameter("nrCheque");
	}
	if (request.getParameter("valor") != null){
	   valor = request.getParameter("valor");
	}
	if (request.getParameter("dtEmissao") != null){
	   dtEmissao = request.getParameter("dtEmissao");
	}
	if (request.getParameter("dtVenc") != null){
	   dtVenc = request.getParameter("dtVenc");	
	}
	if (request.getParameter("correntista") != null){
	  correntista = request.getParameter("correntista");
	}
	if (request.getParameter("cpfCnpjParametro")!= null){
	  cpfCnpjParametro = request.getParameter("cpfCnpjParametro");
	}
	if (request.getParameter("destino") != null){
	  destino = request.getParameter("destino");
	}
  if (request.getParameter("observacao") != null){
    observacao = request.getParameter("observacao");
  }
  if (request.getParameter("dtRecebido") != null){
    dtRecebido = request.getParameter("dtRecebido");
  }
	if (request.getParameter("idContaMovto") != null){
	  idContaMovto = request.getParameter("idContaMovto");
	}
	if (request.getParameter("status") != null){
	  status = request.getParameter("status");
	}
	if (idChequeRecebido == null) idChequeRecebido = "0";
	
	if (idLoja == null) idLoja = "0";

	if (idBanco == null) idBanco = "0";
	
	if (nrCheque == null) nrCheque="0";
	
	if (contaCorrente == null)contaCorrente = "";
	
	if (destino == null) destino = "";
	
	if (dvConta == null) dvConta = "";
	
	if (valor == null) valor = "0";
	
	if (dtEmissao == null) dtEmissao = "";
	
	if (dtVenc == null) dtVenc = "";
	
	if (observacao == null) observacao = "";
	
	if (dtRecebido == null) dtRecebido="";
	
	if (cpfCnpjParametro == null) cpfCnpjParametro = "";
	
	if (idContaMovto == null) idContaMovto = "0";
	
	if (status == null) status="A";
	
//

// Dados básicos
String telefone = request.getParameter("telefone");
if (telefone == null) telefone = "";
String clausula = "";
String nomeLocalizar = request.getParameter("nomeLocalizar");
if (nomeLocalizar == null) nomeLocalizar = "";
String tpInsc = request.getParameter("tpInsc"); 
if (tpInsc == null) tpInsc="F";
String statusLocalizar = request.getParameter("statusLocalizar");
if (statusLocalizar == null) statusLocalizar="A";
String cpfLocalizar = request.getParameter("cpfLocalizar");
if (cpfLocalizar == null) cpfLocalizar="";

  if (!telefone.equals("")) {
	  if (tpInsc.equalsIgnoreCase("F")) {
		  clausula = "JOIN tbentidadetelefone ec ON (f.cdEntidade = ec.cdEntidade) and (ec.nroTelefone like '"+telefone+"%') ";
          		  
	  } else{
		  clausula = "JOIN tbentidadetelefone ec ON (j.cdEntidade = ec.cdEntidade) and (ec.nroTelefone like '"+telefone+"%') ";
	  }
	  
  }
  if (nomeLocalizar!= null) {
    clausula += " WHERE e.nome LIKE '"+nomeLocalizar+"%'";
  } 
  if (!cpfLocalizar.equals("")) {
    if (clausula.isEmpty()) {
    	if(tpInsc.equalsIgnoreCase("F")){
    		clausula += " WHERE f.cpf LIKE '"+cpfLocalizar+"%'";
    	} else{
    		clausula += " WHERE j.cnpj LIKE '"+cpfLocalizar+"%'";
    	}  
    } else {
    	if(tpInsc.equalsIgnoreCase("F")){
    		clausula = clausula+" AND f.cpf LIKE '"+cpfLocalizar+"%'";
    	} else {
    		clausula = clausula+" AND j.cnpj LIKE '"+cpfLocalizar+"%'";
    	}
      
    }
  }
  if (!statusLocalizar.equals("T")) {
    if (clausula.isEmpty()) {
      clausula += " WHERE e.status='"+statusLocalizar+"'";
    } else {
      clausula = clausula+" AND e.status='"+statusLocalizar+"'";
    }
  }

if (clausula.isEmpty()) {
  clausula += " WHERE e.tpInsc='"+tpInsc+"'";
} else {
  clausula = clausula+" AND e.tpInsc='"+tpInsc+"'";
}


//seleciona todos os registros do banco de dados
List list;
if(tpInsc.equalsIgnoreCase("F")){
	daoFisica = new EntidadeFisicaDAO(conn);
	clausula = clausula+" ORDER BY e.nome ";
	list = daoFisica.listarEntidadeFisica(clausula);	
}else{
	daoJuridica = new EntidadeJuridicaDAO(conn);
	clausula = clausula+" ORDER BY e.nome ";
	list = daoJuridica.listarEntidadesJuridica(clausula);
}
%>
<h1 class="cabecalho_pagina">Consulta de Clientes</h1>
<hr>
<body onload="document.forms[0].elements[0].focus();" >
<form action="consultarClientesChegueRecebido.jsp">
<input type="hidden" name="acao" value="<%=acao%>">
<input type="hidden" name="idChequeRecebido" value="<%=idChequeRecebido%>">
<input type="hidden" name="idLoja" value="<%=idLoja%>">
<input type="hidden" name="idBanco" value="<%=idBanco%>">
<input type="hidden" name="agencia" value="<%=agencia%>">
<input type="hidden" name="dvAgencia" value="<%=dvAgencia%>">
<input type="hidden" name="contaCorrente" value="<%=contaCorrente%>">
<input type="hidden" name="dvConta" value="<%=dvConta%>">
<input type="hidden" name="nrCheque" value="<%=nrCheque%>">
<input type="hidden" name="valor" value="<%=valor%>">
<input type="hidden" name="dtEmissao" value="<%=dtEmissao%>">
<input type="hidden" name="dtVenc" value="<%=dtVenc%>">
<input type="hidden" name="correntista" value="<%=correntista%>">
<input type="hidden" name="cpfCnpjParametro" value="<%=cpfCnpjParametro%>">
<input type="hidden" name="destino" value="<%=destino%>">
<input type="hidden" name="observacao" value="<%=observacao%>">
<input type="hidden" name="dtRecebido" value="<%=dtRecebido%>">
<input type="hidden" name="idContaMovto" value="<%=idContaMovto%>">
<input type="hidden" name="status" value="<%=status%>">

<table colspan="2">
  <tr>
    <th class="label">Nome</th>
    <td><input type="text" name="nomeLocalizar" <%if (nomeLocalizar != null) { %>value="<%=nomeLocalizar %>"<% }%> size="40" maxlength="40"></td>
  </tr>
   <tr>
    <th class="label">CPF/CNPJ</th>
    <td><input type="text" id="cpfLocalizar" name="cpfLocalizar" <%if (cpfLocalizar != null) { %>value="<%=cpfLocalizar%>"<% }%>  size="14" maxlength="14" onblur="chkCPFCNPJ(this)"></td>
  </tr>
     <tr>
    <th class="label">Telefone</th>
    <td><input type="text" id="telefone" name="telefone" <%if (telefone != null) { %>value="<%=telefone%>"<% }%>  size="14" maxlength="14" onblur="chkCPFCNPJ(this)"></td>
  </tr>
  <tr>
    <th class="label">Tipo de Entidade</th>
    <td class="label_radio">
      <input type="radio" class="radio" name="tpInsc" value="J" <%= (tpInsc.equals("J")? "checked": "") %>>Pessoa Juridica
      <input type="radio" class="radio" name="tpInsc" value="F" <%= (tpInsc.equals("F")? "checked": "") %>>Pessoa Fisica
  </tr>
  <tr>
    <th class="label">Status</th>
    <td class="label_radio">
      <input type="radio" class="radio" name="statusLocalizar" value="A" <%= (statusLocalizar.equals("A")? "checked": "") %>>Ativo
      <input type="radio" class="radio" name="statusLocalizar" value="I" <%= (statusLocalizar.equals("I")? "checked": "") %>>Inativo
      <input type="radio" class="radio" name="statusLocalizar" value="T" <%= (statusLocalizar.equals("T")? "checked": "") %>>Todos</td>
    <td><input class="button" type="button" value="Localizar" onClick="javascript: localizar();" /></td>
    <td><input class="button" type="button" value="Nova pesquisa" onClick="javascript: novaPesquisa();" /></td>
  </tr>
</table>
<hr>

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr">
      <th class="grid">&nbsp;</th>
      <th class="grid"><center>Nome</center></th>
      <th class="grid"><%= (tpInsc.equalsIgnoreCase("F") ? "CPF": "CNPJ") %></th>
      <th class="grid">Status</th>
      
    </tr>
<%
int contGrid = 0;
int cont = 0;
int gridSize = 20;
String rowNumStr = request.getParameter("rowNum");
int rowNum = (rowNumStr == null ? 0: Integer.parseInt(rowNumStr));
if (rowNum < 0) rowNum = 0;
boolean hasNext = false;
int rowCount = list.size();
int rowLast = 0;
if (rowCount > 0) {
  if (rowCount > gridSize) {
    rowLast = rowNum+gridSize+1; 
    if (rowLast >= rowCount && rowCount > 0) rowLast = rowCount;
    if (rowNum > rowLast) rowNum = 0;
    list = list.subList(rowNum, rowLast);
  }
  hasNext = true;
}
//Utiliza o ResultSet para trazer os registros do banco de dados
String cpfCnpj = "";
String nomeEntidade = "";
String statusEntidade = "";
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	if(tpInsc.equalsIgnoreCase("F")){
		EntidadeFisica entidade = (EntidadeFisica) it.next();
		cpfCnpj = entidade.getCpf();
		cdEntidade = entidade.getCdEntidade();
		nomeEntidade = entidade.getNome();
		statusEntidade = entidade.getStatus();
	}else{
		EntidadeJuridica entidade = (EntidadeJuridica) it.next();
		cpfCnpj = entidade.getCnpj();
		cdEntidade = entidade.getCdEntidade();
		nomeEntidade = entidade.getNome();
		statusEntidade = entidade.getStatus();
	}
	
	cont++;
%>
    <tr>
      <td class = "grid" width="2%"><center><%=rowNum+cont%></center></td>
      <td class = "grid"><center><a class="link" target="principal" href="formChequeRecebido.jsp?acao=<%=acao%>&idChequeRecebido=<%=idChequeRecebido%>&idLoja=<%=idLoja%>&idBanco=<%=idBanco%>&agencia=<%=agencia%>&dvAgencia=<%=dvAgencia%>&dvConta=<%=dvConta%>&contaCorrente=<%=contaCorrente%>&nrCheque=<%=nrCheque%>&valor=<%=valor%>&dtEmissao=<%=dtEmissao%>&dtVenc=<%=dtVenc%>&correntista=<%=correntista%>&cpfCnpj=<%=cpfCnpjParametro%>&destino=<%=destino%>&cdEntidade=<%=cdEntidade%>&observacao=<%=observacao%>&dsEntidade=<%=nomeEntidade%>&dtRecebido=<%=dtRecebido%>&idContaMovto=<%=idContaMovto%>&status=<%=status%>"onclick="javascript:window.close()"><%=nomeEntidade%></a></center></td>
      <td class = "grid" width="10%"><center><%=cpfCnpj%></center></td>
      <td class = "grid" width="5%"><center><%=statusEntidade%></center></td>
      
  	</tr>
<%
}
%>   
</table>
</form>
<%  if (rowNum != 0 || hasNext) { %>
        <center>
<%      if (rowNum != 0) { %>
<a class="link" href="consultarClientesChegueRecebido.jsp?rowNum=<%=0%>&nomeLocalizar=<%=nomeLocalizar%>&statusLocalizar=<%=statusLocalizar%>&tpInsc=<%=tpInsc%>&cpfLocalizar=<%=cpfLocalizar%>&telefone=<%=telefone%>"> Primeira</a>&nbsp;&nbsp;
|&nbsp;&nbsp;<a class="link" href="consultarClientesChegueRecebido.jsp?rowNum=<%=rowNum-gridSize%>&nomeLocalizar=<%=nomeLocalizar%>&statusLocalizar=<%=statusLocalizar%>&tpInsc=<%=tpInsc%>&cpfLocalizar=<%=cpfLocalizar%>&telefone=<%=telefone%>"> < Anterior</a>&nbsp;&nbsp;
<%      } else { %>
Primeira&nbsp;&nbsp;|&nbsp;&nbsp;< Anterior&nbsp;
<%      } %>
<%      if (hasNext) { %>
|&nbsp;&nbsp;<a class="link" href="consultarClientesChegueRecebido.jsp?rowNum=<%=rowNum+gridSize%>&nomeLocalizar=<%=nomeLocalizar%>&statusLocalizar=<%=statusLocalizar%>&tpInsc=<%=tpInsc%>&cpfLocalizar=<%=cpfLocalizar%>&telefone=<%=telefone%>">Próxima ></a>&nbsp;&nbsp;
|&nbsp;&nbsp;<a class="link" href="consultarClientesChegueRecebido.jsp?rowNum=<%=rowCount-gridSize%>&nomeLocalizar=<%=nomeLocalizar%>&statusLocalizar=<%=statusLocalizar%>&tpInsc=<%=tpInsc%>&cpfLocalizar=<%=cpfLocalizar%>&telefone=<%=telefone%>">Última</a>
<%      } else { %>
|&nbsp;&nbsp; Próxima >&nbsp;&nbsp;|&nbsp;&nbsp;Última
<%      } %>
        </center>
<%  } %>
<%@include file="../fimConexao.jsp"%>