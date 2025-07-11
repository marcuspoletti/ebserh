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
  document.all.tpInsc.value = 'J';
  document.forms[0].submit();
}  
</script>

<%
EntidadeFisicaDAO daoFisica;
EntidadeJuridicaDAO daoJuridica;
String acao = request.getParameter("acao");
if (acao == null) acao = "listar";
String idPlanoConta= request.getParameter("idPlanoConta");
if(idPlanoConta == null)idPlanoConta = "0";
String idCentroCusto = request.getParameter("idCentroCusto");
if(idCentroCusto == null)idCentroCusto = "0";
String idConta= request.getParameter("idConta");
if(idConta == null)idConta = "0";
String idDuplicataPai= request.getParameter("idDuplicataPai");
if(idDuplicataPai == null)idDuplicataPai = "0";
String nrTitulo= request.getParameter("nrTitulo");
if(nrTitulo == null)nrTitulo = "0";
String nrSerie= request.getParameter("nrSerie");
if(nrSerie == null)nrSerie="0";
String dtEmissao = request.getParameter("dtEmissao");
if(dtEmissao == null)dtEmissao="";
String idTipoDocumento = request.getParameter("idTipoDocumento");
if(idTipoDocumento == null)idTipoDocumento="0";
String sdEntidade = request.getParameter("cdEntidade");
if(sdEntidade == null)sdEntidade = "0";
int cdEntidade = Integer.parseInt(sdEntidade);
String dsEntidade = request.getParameter("dsEntidade");
if(dsEntidade == null)dsEntidade="";
String idColaborador = request.getParameter("idColaborador");
if(idColaborador == null)idColaborador="0";
String nrDoc = request.getParameter("nrDoc");
if(nrDoc == null)nrDoc = "";
String idLoja = request.getParameter("idLoja");
if(idLoja == null)idLoja = "0";
//

// Dados básicos
String telefone = request.getParameter("telefone");
if(telefone == null)telefone = "";
String clausula = "";
String nomeLocalizar = request.getParameter("nomeLocalizar");
if(nomeLocalizar == null)nomeLocalizar = "";
String tpInsc = request.getParameter("tpInsc"); 
if(tpInsc == null)tpInsc="J";
String statusLocalizar = request.getParameter("statusLocalizar");
if(statusLocalizar == null)statusLocalizar="A";
String cpfLocalizar = request.getParameter("cpfLocalizar");
if(cpfLocalizar == null)cpfLocalizar="";

  if(!telefone.equals("")){
	  if(tpInsc.equalsIgnoreCase("F")){
		  clausula = "JOIN tbentidadetelefone ec ON (f.cdEntidade = ec.cdEntidade) and (ec.nroTelefone like '"+telefone+"%') ";
          		  
	  }else{
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
    	}else{
    		clausula += " WHERE j.cnpj LIKE '"+cpfLocalizar+"%'";
    	}  
    } else {
    	if(tpInsc.equalsIgnoreCase("F")){
    		clausula = clausula+" AND f.cpf LIKE '"+cpfLocalizar+"%'";
    	}else{
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
<h1 class="cabecalho_pagina">Consulta</h1>
<hr>
<body onload="document.forms[0].elements[0].focus();" >
<form action="consultarClientesContasReceber.jsp">
<input type="hidden" name="idDuplicataPai" value="<%=idDuplicataPai%>">
<input type="hidden" name="idConta" value="<%=idConta%>">
<input type="hidden" name="idPlanoConta" value="<%=idPlanoConta%>">
<input type="hidden" name="idCentroCusto" value="<%=idCentroCusto%>">
<input type="hidden" name="idTipoDocumento" value="<%=idTipoDocumento%>">
<input type="hidden" name="nrTitulo" value="<%=nrTitulo%>">
<input type="hidden" name="nrSerie" value="<%=nrSerie%>">
<input type="hidden" name="dtEmissao" value="<%=dtEmissao%>">
<input type="hidden" name="nrDoc" value="<%=nrDoc%>">
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
      <th class="grid">CPF</th>
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
	<tr><% acao = "inc"; // DEPOIS DE LISTAR ACAO RECEBE INC PARA PASSAR PARAMETRO%> </tr>
    <tr>
      <td class = "grid" width="2%"><center><%=rowNum+cont%></center></td>
      <td class = "grid"><center><a class="link" target="principal" href="formDuplicataReceber.jsp?acao=<%=acao%>&idConta=<%=idConta%>&nrDoc=<%=nrDoc%>&nrSerie=<%=nrSerie%>&idDuplicataPai=<%=idDuplicataPai%>&idPlanoConta=<%=idPlanoConta%>&idCentroCusto=<%=idCentroCusto%>&idLoja<%=idLoja%>&idColaborador=<%=idColaborador%>&nrTitulo=<%=nrTitulo%>&idColaborador=<%=idColaborador%>&dtEmissao=<%=dtEmissao%>&idTipoDocumento=<%=idTipoDocumento%>&cdEntidade=<%=cdEntidade%>&dtEmissao=<%=dtEmissao %>&dsEntidade=<%=nomeEntidade%>"onclick="javascript:window.close()"><%=nomeEntidade%></a></center></td>
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
<a class="link" href="consultarClientesFinanceiro.jsp?rowNum=<%=0%>&nomeLocalizar=<%=nomeLocalizar%>&statusLocalizar=<%=statusLocalizar%>&tpInsc=<%=tpInsc%>&cpfLocalizar=<%=cpfLocalizar%>&telefone=<%=telefone%>"> Primeira</a>&nbsp;&nbsp;
|&nbsp;&nbsp;<a class="link" href="consultarClientesFinanceiro.jsp?rowNum=<%=rowNum-gridSize%>&nomeLocalizar=<%=nomeLocalizar%>&statusLocalizar=<%=statusLocalizar%>&tpInsc=<%=tpInsc%>&cpfLocalizar=<%=cpfLocalizar%>&telefone=<%=telefone%>"> < Anterior</a>&nbsp;&nbsp;
<%      } else { %>
Primeira&nbsp;&nbsp;|&nbsp;&nbsp;< Anterior&nbsp;
<%      } %>
<%      if (hasNext) { %>
|&nbsp;&nbsp;<a class="link" href="consultarClientesFinanceiro.jsp?rowNum=<%=rowNum+gridSize%>&nomeLocalizar=<%=nomeLocalizar%>&statusLocalizar=<%=statusLocalizar%>&tpInsc=<%=tpInsc%>&cpfLocalizar=<%=cpfLocalizar%>&telefone=<%=telefone%>">Próxima ></a>&nbsp;&nbsp;
|&nbsp;&nbsp;<a class="link" href="consultarClientesFinanceiro.jsp?rowNum=<%=rowCount-gridSize%>&nomeLocalizar=<%=nomeLocalizar%>&statusLocalizar=<%=statusLocalizar%>&tpInsc=<%=tpInsc%>&cpfLocalizar=<%=cpfLocalizar%>&telefone=<%=telefone%>">Última</a>
<%      } else { %>
|&nbsp;&nbsp; Próxima >&nbsp;&nbsp;|&nbsp;&nbsp;Última
<%      } %>
        </center>
<%  } %>
<%@include file="../fimConexao.jsp"%>