<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.Duplicata"%>
<%@ page import="afero.model.DuplicataParcela"%>
<%@ page import="afero.model.Colaborador"%>
<%@ page import="afero.model.Entidade" %>
<%@ page import="afero.model.Conta" %>
<%@ page import="afero.model.FormaPagto" %>
<%@ page import="afero.persistence.DuplicataDAO"%>
<%@ page import="afero.persistence.DuplicataParcelaDAO"%>
<%@ page import="afero.persistence.ColaboradorDAO"%>
<%@ page import="afero.persistence.OrcamentoDAO" %>
<%@ page import="afero.persistence.EntidadeDAO" %>
<%@ page import="afero.persistence.FormaPagtoDAO" %>
<%@ page import="afero.persistence.ContaDAO" %>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.Date" %>
<%@ page import="afero.util.ConverteDate"%>
<%@ page import="afero.util.Utilitaria"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<%
	//Todos os atributos
	String clausula = "";
	String acao = request.getParameter("acao");
	int idDuplicata = Integer.parseInt(request
			.getParameter("idDuplicata"));
	if (acao == null)
		acao = "listar";

	ConverteDate ConverteDate = new ConverteDate();
	Utilitaria Utilitaria = new Utilitaria();

	String idDuplicataParcela = request
			.getParameter("idDuplicataParcela");
	if (idDuplicataParcela == null)
		idDuplicataParcela = "";

	String nrParcela = request.getParameter("nrParcela");
	if (nrParcela == null)
		nrParcela = "";

	String idConta = request.getParameter("idConta");
	if (idConta == null)
		idConta = "";

	String dtVenc = request.getParameter("dtVenc");
	if (dtVenc == null)
		dtVenc = "";

	String valor = request.getParameter("valor");
	if (valor == null)
		valor = "0";

	String cdFormaPagto = request.getParameter("cdFormaPagto");
	if (cdFormaPagto == null)
		cdFormaPagto = "";

	String dtEmissao = request.getParameter("dtEmissao");
	if (dtEmissao == null)
		dtEmissao = "";

	String dtComp = request.getParameter("dtComp");
	if (dtComp == null)
		dtComp = "";

	String nrDoc = request.getParameter("nrDoc");
	if (nrDoc == null)
		nrDoc = "";

	String idPlanoConta = request.getParameter("idPlanoConta");
	if (idPlanoConta == null)
		idPlanoConta = "";

	String idCentroCusto = request.getParameter("idCentroCusto");
	if (idCentroCusto == null)
		idCentroCusto = "";

	String historico = request.getParameter("historico");
	if (historico == null)
		historico = "";

	String divideValor = request.getParameter("divideValor");

	String dtOperacao = request.getParameter("dtOperacao");
	if (dtOperacao == null)
		dtOperacao = null;

	String vlOperacao = request.getParameter("vlOperacao");
	if (vlOperacao == null)
		vlOperacao = "";

	String vlJuros = request.getParameter("vlJuros");
	if (vlJuros == null)
		vlJuros = "";

	String vlMulta = request.getParameter("vlMulta");
	if (vlMulta == null)
		vlMulta = "";

	String vlDesc = request.getParameter("vlDesc");
	if (vlDesc == null)
		vlDesc = "";

	String nossoNumero = request.getParameter("nossoNumero");
	if (nossoNumero == null)
		nossoNumero = "";

	String dtQuitacao = request.getParameter("dtQuitacao");
	if (dtQuitacao == null)
		dtQuitacao = "";

	String formaQuitacao = request.getParameter("formaQuitacao");
	if (formaQuitacao == null)
		formaQuitacao = "";

	String idColaborador = request.getParameter("idColaborador");
	if (idColaborador == null)
		idColaborador = "";

	String atualizaFinanceiro = request
			.getParameter("atualizaFinanceiro");
	if (atualizaFinanceiro == null)
		atualizaFinanceiro = "";

	String idContaMovto = request.getParameter("idContaMovto");
	if (idContaMovto == null)
		idContaMovto = "";

	String status = request.getParameter("status");
	if (status == null)
		status = "";

	String dtMov = request.getParameter("dtMov");
	if (dtMov == null)
		dtMov = "";

	String usuario = request.getParameter("usuario");
	if (usuario == null)
		usuario = null;
	//
	String voltarDC = request.getParameter("voltarDC");
	//
	if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu")
			|| acao.equalsIgnoreCase("exc")) {

		DuplicataParcela duplicataParcela = new DuplicataParcela();

		duplicataParcela.setIdDuplicata(idDuplicata);
		duplicataParcela.setIdDuplicataParcela(Integer
				.parseInt(idDuplicataParcela));
		duplicataParcela.setNrParcela(Integer.parseInt(nrParcela));
		duplicataParcela.setIdConta(Integer.parseInt(idConta));
		if (dtVenc != "") {
			duplicataParcela.setDtVenc(ConverteDate
					.stringToDate(dtVenc));
		} else {
			duplicataParcela.setDtVenc(null);
		}
		duplicataParcela.setValor(Utilitaria.toNumber(valor)
				.doubleValue());
		duplicataParcela.setCdFormaPagto(Utilitaria.toNumber(
				cdFormaPagto).intValue());
		if (dtEmissao != "") {
			duplicataParcela.setDtEmissao(ConverteDate
					.stringToDate(dtEmissao));
		} else {
			duplicataParcela.setDtEmissao(null);
		}
		if (dtComp != "") {
			duplicataParcela.setDtComp(ConverteDate
					.stringToDate(dtComp));
		} else {
			duplicataParcela.setDtComp(null);
		}
		duplicataParcela.setNrDoc(nrDoc);
		duplicataParcela.setIdPlanoConta(Utilitaria.toNumber(
				idPlanoConta).intValue());
		duplicataParcela.setIdCentroCusto(Utilitaria.toNumber(
				idCentroCusto).intValue());
		duplicataParcela.setHistorico(historico);
		duplicataParcela.setDivideValor(divideValor);
		if (dtOperacao != "") {
			duplicataParcela.setDtOperacao(ConverteDate
					.stringToDate(dtOperacao));
		} else {
			duplicataParcela.setDtOperacao(null);
		}
		duplicataParcela.setVlOperacao(Utilitaria.toNumber(vlOperacao)
				.doubleValue());
		duplicataParcela.setVlJuros(Utilitaria.toNumber(vlJuros)
				.floatValue());
		duplicataParcela.setVlMulta(Utilitaria.toNumber(vlMulta)
				.floatValue());
		duplicataParcela.setVlDesc(Utilitaria.toNumber(vlDesc)
				.floatValue());
		duplicataParcela.setNossoNumero(nossoNumero);
		if (dtQuitacao != "") {
			duplicataParcela.setDtQuitacao(ConverteDate
					.stringToDate(dtQuitacao));
		} else {
			duplicataParcela.setDtQuitacao(null);
		}

		duplicataParcela.setFormaQuitacao(formaQuitacao);
		//duplicataParcela.setIdColaborador(Integer.parseInt(idColaborador));
		duplicataParcela.setAtualizaFinanceiro(atualizaFinanceiro);
		duplicataParcela.setStatus(status);
		duplicataParcela.setUsuario(usuario);

		DuplicataParcelaDAO daoParcela = new DuplicataParcelaDAO(conn);

		if (acao.equalsIgnoreCase("inc")) {

			daoParcela.incluir(duplicataParcela);
			acao = "listar";

		} else if (acao.equalsIgnoreCase("atu")) {
			if (status.equalsIgnoreCase("DQ")) {
				dtQuitacao = daoParcela.dataAtualDuplicata();
				duplicataParcela.setDtQuitacao(ConverteDate.stringToDate(dtQuitacao));

			}
			daoParcela.atualizar(duplicataParcela);
			acao = "listar";

		} else if (acao.equalsIgnoreCase("exc")) {

			daoParcela.exclusaoIdDuplicataParcela(duplicataParcela
					.getIdDuplicataParcela());
			acao = "listar";
		}

	}

	if (acao.equalsIgnoreCase("listar")) {
		clausula = " WHERE dp.idDuplicata = " + idDuplicata;
	} else {
		clausula = " WHERE dp.idDuplicata = " + idDuplicata
				+ " AND dp.idDuplicataParcela = " + idDuplicataParcela;
	}

	if (status != null) {
		clausula += " AND dp.status = '" + status + "'";
	}
	List list;
	DuplicataParcelaDAO dao = new DuplicataParcelaDAO(conn);
	list = dao.listarDuplicataParcela(clausula);
%>

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

</head>
<body>
<%
	if (status.equals("A")) {
%>
  <h1 class="cabecalho_pagina">Contas a Pagar - Parcelas Abertas</h1>
<%
	} else {
%>
  <h1 class="cabecalho_pagina">Contas a Pagar - Parcelas Quitadas</h1>
<%
	}
%>
<%
	if (voltarDC.equalsIgnoreCase("D")) {
%>
	|<a href="listarDuplicataPagar.jsp?acao=<%="listar"%>">Voltar</a>|
<%
	} else {
%>	
  |<a href="listarDuplicataReceber.jsp?acao=<%="listar"%>">Voltar</a>|
<%
	}
%>	
<hr>
		
<table border="0" width="100%">
    <tr>
      <th class="grid">&nbsp;</th>
      <th class="grid"><center>Parcela</center></th>
      <th class="grid"><center>Fornecedor (Emitente)</center></th>
      <th class="grid"><center>Vencimento</center></th>
      <th class="grid"><center>Competência</center></th>
      <th class="grid"><center>Valor</center></th>
      <th class="grid"><center>Operação</center></th>
      <th class="grid"><center>Quitação</center></th>
      <th class="grid"><center>Status</center></th>
      <th class="grid"><center>Usuário</center></th>
      <th class="grid"><center>Pagar conta</center></th>
    </tr>
<%
	//Utiliza o ResultSet para trazer os registros do banco de dados
	Duplicata du = null;
	DuplicataDAO daoDuplicata = new DuplicataDAO(conn);
	DuplicataParcela dp = null;
	String msgStatus = "";
	int cont = 0;
	Entidade entidade = null;
	EntidadeDAO daoEntidade = new EntidadeDAO(conn);
	String nomeConta;
	String fPagto;
	FormaPagto formaPagto = null;
	FormaPagtoDAO daoformaPagto = new FormaPagtoDAO(conn);
	ContaDAO daoConta = new ContaDAO(conn);
	for (Iterator it = list.iterator(); it.hasNext();) {
		dp = (DuplicataParcela) it.next();
		du = daoDuplicata.procurarDuplicata(dp.getIdDuplicata());
		if (dp.getStatus().equals("I")) {
			msgStatus = "INATIVO";
		} else if (dp.getStatus().equals("A")) {
			msgStatus = "ATIVO";
		} else if (dp.getStatus().equals("DQ")) {
			msgStatus = "QUITADO";
		} else {
			msgStatus = "REPARCELADO";
		}
		//Conta conta = daoConta.procurarConta(dp.getIdConta());
		entidade = daoEntidade.procurarEntidade(du.getCdEntidade());
		nomeConta = entidade.getNome();
		//formaPagto = daoformaPagto.procurarFormaPagto(dp.getCdFormaPagto());
		//fPagto = formaPagto.getDsFormaPagto();
		cont++;
%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid" width="5%"><center><b><%=dp.getNrParcela()%></b></center></td>
      <%
      	if (!dp.getStatus().equals("DQ")) {
      %>
       	<td class = "grid" width="15%"><center><%=nomeConta%></center></td>
      <%
      	} else {
      %>
      	<td class = "grid" width="15%"><center><a target="_blank" href="visualizarParcela.jsp?idDuplicata=<%=dp.getIdDuplicata()%>&idDuplicataParcela=<%=dp.getIdDuplicataParcela()%>&acao=<%="atu"%>"><%=nomeConta%></a></center></td>
      <%
      	}
      %>
      <%
      	if (dp.getDtVenc() != null) {
      %>
        <td class = "grid" width="10%"><center><%=ConverteDate.dateToString(dp.getDtVenc())%></center></td>
      <%
      	} else {
      %>
      	 <td class = "grid" width="10%"><center>-</center></td>
      <%
      	}
      %>
      <%
      	if (dp.getDtComp() != null) {
      %>
      	<td class = "grid" width="10%"><center><%=ConverteDate.dateToString(dp.getDtComp())%></center></td>
      <%
      	} else {
      %>
      	<td class = "grid" width="10%"><center>-</center></td>
      <%
      	}
      %>
      <td class = "grid" width="10%"><center><%=Utilitaria.formatarNumero(dp.getValor(), 2)%></center></td>
      <%
      	if (dp.getDtOperacao() != null) {
      %>
      	<td class = "grid" width="10%"><center><%=ConverteDate.dateToString(dp.getDtOperacao())%></center></td>
      <%
      	} else {
      %>
      	<td class = "grid" width="10%"><center>-</center></td>
      <%
      	}
      %>
      <%
      	if (dp.getDtQuitacao() != null) {
      %>
      	<td class = "grid" width="10%"><center><%=ConverteDate.dateToString(dp.getDtQuitacao())%></center></td>
      <%
      	} else {
      %>
      	<td class = "grid" width="10%"><center>-</center></td>
      <%
      	}
      %>
      <td class = "grid" width="5%"><center><%=msgStatus%></center></td>
      <td class = "grid" width="5%"><center><%=dp.getUsuario()%></center></td>
      <%
      	if (!dp.getStatus().equals("DQ")) {
      %>
      	<td class = "grid" width="10%"><center><a href="formDuplicataParcela.jsp?idDuplicata=<%=dp.getIdDuplicata()%>&idDuplicataParcela=<%=dp.getIdDuplicataParcela()%>&acao=<%="atu"%>&voltarDC=<%=voltarDC%>"><img border = "0" src="../images/baixa.gif"></a></center></td>
     <%
     	} else {
     %>
     	<td class = "grid" width="10%"><center>-</center></td>
     <%
     	}
     %> 	
      
 	</tr>
<%
	}
%>

</table>
<p align="right">|
<%
	if (voltarDC.equalsIgnoreCase("D")) {
%>
  <a href="listarDuplicataPagar.jsp?acao=<%="listar"%>">Voltar</a>
<%
	} else {
%>	
  <a href="listarDuplicataReceber.jsp?acao=<%="listar"%>">Voltar</a>
<%
	}
%>
|</p>
</body>
</html>