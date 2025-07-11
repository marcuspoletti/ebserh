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
	if (acao == null)
		acao = "listar";
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
	String usuario = request.getParameter("usuario");
	String dtVencimento = request.getParameter("dtVencimento");
	String idConta = request.getParameter("idConta");
	String cdFormaPagto = request.getParameter("cdFormaPagto");

	// Dados básicos
	String telefone = request.getParameter("telefone");
	if (telefone == null)
		telefone = "";
	String clausula = "";
	String nomeLocalizar = request.getParameter("nomeLocalizar");
	if (nomeLocalizar == null)
		nomeLocalizar = "";
	String tpInsc = request.getParameter("tpInsc");
	if (tpInsc == null)
		tpInsc = "J";
	String statusLocalizar = request.getParameter("statusLocalizar");
	if (statusLocalizar == null)
		statusLocalizar = "A";
	String cpfLocalizar = request.getParameter("cpfLocalizar");
	if (cpfLocalizar == null)
		cpfLocalizar = "";

	if (!telefone.equals("")) {
		if (tpInsc.equalsIgnoreCase("F")) {
			clausula = "JOIN tbentidadetelefone ec ON (f.cdEntidade = ec.cdEntidade) and (ec.nroTelefone like '"
					+ telefone + "%') ";

		} else {
			clausula = "JOIN tbentidadetelefone ec ON (j.cdEntidade = ec.cdEntidade) and (ec.nroTelefone like '"
					+ telefone + "%') ";
		}

	}
	if (nomeLocalizar != null) {
		clausula += " WHERE e.nome LIKE '" + nomeLocalizar + "%'";
	}
	if (!cpfLocalizar.equals("")) {
		if (clausula.isEmpty()) {
			if (tpInsc.equalsIgnoreCase("F")) {
				clausula += " WHERE f.cpf LIKE '" + cpfLocalizar + "%'";
			} else {
				clausula += " WHERE j.cnpj LIKE '" + cpfLocalizar
						+ "%'";
			}
		} else {
			if (tpInsc.equalsIgnoreCase("F")) {
				clausula = clausula + " AND f.cpf LIKE '"
						+ cpfLocalizar + "%'";
			} else {
				clausula = clausula + " AND j.cnpj LIKE '"
						+ cpfLocalizar + "%'";
			}

		}
	}
	if (!statusLocalizar.equals("T")) {
		if (clausula.isEmpty()) {
			clausula += " WHERE e.status='" + statusLocalizar + "'";
		} else {
			clausula = clausula + " AND e.status='" + statusLocalizar
					+ "'";
		}
	}

	if (clausula.isEmpty()) {
		clausula += " WHERE e.tpInsc='" + tpInsc + "'";
	} else {
		clausula = clausula + " AND e.tpInsc='" + tpInsc + "'";
	}

	//seleciona todos os registros do banco de dados
	List list;
	if (tpInsc.equalsIgnoreCase("F")) {
		daoFisica = new EntidadeFisicaDAO(conn);
		clausula = clausula + " ORDER BY e.nome ";
		list = daoFisica.listarEntidadeFisica(clausula);
	} else {
		daoJuridica = new EntidadeJuridicaDAO(conn);
		clausula = clausula + " ORDER BY e.nome ";
		list = daoJuridica.listarEntidadesJuridica(clausula);
	}
%>
<h1 class="cabecalho_pagina">Consulta</h1>
<hr>
<body onload="document.forms[0].elements[0].focus();" >
<form method="post" action="consultarClientesContasPagar.jsp?acao=<%=acao%>">
<input type="hidden" name="idDuplicata" value="<%=idDuplicata%>">
<input type="hidden" name="idLoja" value="<%=idLoja%>">
<input type="hidden" name="cdEntidade" value="<%=cdEntidade%>">
<input type="hidden" name="dc" value="<%=dc%>">
<input type="hidden" name="dtEmissao" value="<%=dtEmissao%>">
<input type="hidden" name="dtComp" value="<%=dtComp%>">
<input type="hidden" name="nrDoc" value="<%=nrDoc%>">
<input type="hidden" name="idTipoDocumento" value="<%=idTipoDocumento%>">
<input type="hidden" name="idPlanoConta" value="<%=idPlanoConta%>">
<input type="hidden" name="idCentroCusto" value="<%=idCentroCusto%>">
<input type="hidden" name="historico" value="<%=historico%>">
<input type="hidden" name="nrDiasPag" value="<%=nrDiasPag%>">
<input type="hidden" name="quantParcelas" value="<%=quantParcelas%>">
<input type="hidden" name="valorTotal" value="<%=valorTotal%>">
<input type="hidden" name="gerarBoleto" value="<%=gerarBoleto%>">
<input type="hidden" name="observacao" value="<%=observacao%>">
<input type="hidden" name="tipoLancamento" value="<%=tipoLancamento%>">
<input type="hidden" name="txMulta" value="<%=txMulta%>">
<input type="hidden" name="txJuros" value="<%=txJuros%>">
<input type="hidden" name="tipoJuros" value="<%=tipoJuros%>">
<input type="hidden" name="status" value="<%=status%>">
<input type="hidden" name="dtCad" value="<%=dtCad%>">
<input type="hidden" name="dtMod" value="<%=dtMod%>">
<input type="hidden" name="usuario" value="<%=usuario%>">
<input type="hidden" name="dtVencimento" value="<%=dtVencimento%>">
<input type="hidden" name="idConta" value="<%=idConta%>">
<input type="hidden" name="cdFormaPagto" value="<%=cdFormaPagto%>">

<table colspan="2">
  <tr>
    <th class="label">Nome</th>
    <td><input type="text" name="nomeLocalizar" <%if (nomeLocalizar != null) {%>value="<%=nomeLocalizar%>"<%}%> size="40" maxlength="40"></td>
  </tr>
   <tr>
    <th class="label">CPF/CNPJ</th>
    <td><input type="text" id="cpfLocalizar" name="cpfLocalizar" <%if (cpfLocalizar != null) {%>value="<%=cpfLocalizar%>"<%}%>  size="14" maxlength="14" onblur="chkCPFCNPJ(this)"></td>
  </tr>
     <tr>
    <th class="label">Telefone</th>
    <td><input type="text" id="telefone" name="telefone" <%if (telefone != null) {%>value="<%=telefone%>"<%}%>  size="14" maxlength="14" onblur="chkCPFCNPJ(this)"></td>
  </tr>
  <tr>
    <th class="label">Tipo de Entidade</th>
    <td class="label_radio">
      <input type="radio" class="radio" name="tpInsc" value="J" <%=(tpInsc.equals("J") ? "checked" : "")%>>Pessoa Juridica
      <input type="radio" class="radio" name="tpInsc" value="F" <%=(tpInsc.equals("F") ? "checked" : "")%>>Pessoa Fisica
  </tr>
  <tr>
    <th class="label">Status</th>
    <td class="label_radio">
      <input type="radio" class="radio" name="statusLocalizar" value="A" <%=(statusLocalizar.equals("A") ? "checked" : "")%>>Ativo
      <input type="radio" class="radio" name="statusLocalizar" value="I" <%=(statusLocalizar.equals("I") ? "checked" : "")%>>Inativo
      <input type="radio" class="radio" name="statusLocalizar" value="T" <%=(statusLocalizar.equals("T") ? "checked" : "")%>>Todos</td>
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
	int rowNum = (rowNumStr == null ? 0 : Integer.parseInt(rowNumStr));
	if (rowNum < 0)
		rowNum = 0;
	boolean hasNext = false;
	int rowCount = list.size();
	int rowLast = 0;
	if (rowCount > 0) {
		if (rowCount > gridSize) {
			rowLast = rowNum + gridSize + 1;
			if (rowLast >= rowCount && rowCount > 0)
				rowLast = rowCount;
			if (rowNum > rowLast)
				rowNum = 0;
			list = list.subList(rowNum, rowLast);
		}
		hasNext = true;
	}
	//Utiliza o ResultSet para trazer os registros do banco de dados
	String cpfCnpj = "";
	String nomeEntidade = "";
	String statusEntidade = "";
	for (Iterator it = list.iterator(); it.hasNext();) {
		if (tpInsc.equalsIgnoreCase("F")) {
			EntidadeFisica entidade = (EntidadeFisica) it.next();
			cpfCnpj = entidade.getCpf();
			cdEntidade = "".valueOf(entidade.getCdEntidade()).toString();
			nomeEntidade = entidade.getNome();
			statusEntidade = entidade.getStatus();
		} else {
			EntidadeJuridica entidade = (EntidadeJuridica) it.next();
			cpfCnpj = entidade.getCnpj();
			cdEntidade = "".valueOf(entidade.getCdEntidade()).toString();
			nomeEntidade = entidade.getNome();
			statusEntidade = entidade.getStatus();
		}

		cont++;
%>
    <tr>
      <td class = "grid" width="2%"><center><%=rowNum + cont%></center></td>
      <td class = "grid"><center><a class="link" target="principal" href="formDuplicataPagar.jsp?acao=<%=acao%>&idDuplicata=<%=idDuplicata%>&idLoja=<%=idLoja%>&cdEntidade=<%=cdEntidade%>&dc=<%=dc%>&dtEmissao=<%=dtEmissao%>&dtComp=<%=dtComp%>&nrDoc=<%=nrDoc%>&idTipoDocumento=<%=idTipoDocumento%>&idPlanoConta=<%=idPlanoConta%>&idCentroCusto=<%=idCentroCusto%>&historico=<%=historico%>&nrDiasPag=<%=nrDiasPag%>&quantParcelas=<%=quantParcelas%>&dtVencimento=<%=dtVencimento%>&valorTotal=<%=valorTotal%>&idConta=<%=idConta%>&cdFormaPagto=<%=cdFormaPagto%>&gerarBoleto=<%=gerarBoleto%>&observacao=<%=observacao%>&tipoLancamento=<%=tipoLancamento%>&txMulta=<%=txMulta%>&txJuros=<%=txJuros%>&tipoJuros=<%=tipoJuros%>&status=<%=status%>&dtCad=<%=dtCad%>&dtMod=<%=dtMod%>&usuario=<%=usuario%>&dsEntidade=<%=nomeEntidade%>" onclick="javascript:window.close()"><%=nomeEntidade%></a></center></td>
      <td class = "grid" width="10%"><center><%=cpfCnpj%></center></td>
      <td class = "grid" width="5%"><center><%=statusEntidade%></center></td>
      
  	</tr>
<%
	}
%>   
</table>
</form>
<%
	if (rowNum != 0 || hasNext) {
%>
        <center>
<%
	if (rowNum != 0) {
%>
<a class="link" href="consultarClientesContasPagar.jsp?acao=<%=acao%>&rowNum=<%=0%>&nomeLocalizar=<%=nomeLocalizar%>&statusLocalizar=<%=statusLocalizar%>&tpInsc=<%=tpInsc%>&cpfLocalizar=<%=cpfLocalizar%>&telefone=<%=telefone%>"> Primeira</a>&nbsp;&nbsp;
|&nbsp;&nbsp;<a class="link" href="consultarClientesContasPagar.jsp?acao=<%=acao%>&rowNum=<%=rowNum - gridSize%>&nomeLocalizar=<%=nomeLocalizar%>&statusLocalizar=<%=statusLocalizar%>&tpInsc=<%=tpInsc%>&cpfLocalizar=<%=cpfLocalizar%>&telefone=<%=telefone%>"> < Anterior</a>&nbsp;&nbsp;
<%
	} else {
%>
Primeira&nbsp;&nbsp;|&nbsp;&nbsp;< Anterior&nbsp;
<%
	}
%>
<%
	if (hasNext) {
%>
|&nbsp;&nbsp;<a class="link" href="consultarClientesContasPagar.jsp?acao=<%=acao%>&rowNum=<%=rowNum + gridSize%>&nomeLocalizar=<%=nomeLocalizar%>&statusLocalizar=<%=statusLocalizar%>&tpInsc=<%=tpInsc%>&cpfLocalizar=<%=cpfLocalizar%>&telefone=<%=telefone%>">Próxima ></a>&nbsp;&nbsp;
|&nbsp;&nbsp;<a class="link" href="consultarClientesContasPagar.jsp?acao=<%=acao%>&rowNum=<%=rowCount - gridSize%>&nomeLocalizar=<%=nomeLocalizar%>&statusLocalizar=<%=statusLocalizar%>&tpInsc=<%=tpInsc%>&cpfLocalizar=<%=cpfLocalizar%>&telefone=<%=telefone%>">Última</a>
<%
	} else {
%>
|&nbsp;&nbsp; Próxima >&nbsp;&nbsp;|&nbsp;&nbsp;Última
<%
	}
%>
        </center>
<%
	}
%>
<%@include file="../fimConexao.jsp"%>