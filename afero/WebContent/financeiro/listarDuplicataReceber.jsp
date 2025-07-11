<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="java.util.Date"%>
<%@ page import="afero.model.Duplicata"%>
<%@ page import="afero.model.DuplicataParcela"%>
<%@ page import="afero.model.Colaborador"%>
<%@ page import="afero.model.Entidade"%>
<%@ page import="afero.model.Conta"%>
<%@ page import="afero.model.ContaMovto"%>
<%@ page import="afero.persistence.DuplicataDAO"%>
<%@ page import="afero.persistence.DuplicataParcelaDAO"%>
<%@ page import="afero.persistence.ColaboradorDAO"%>
<%@ page import="afero.persistence.EntidadeDAO"%>
<%@ page import="afero.persistence.ContaDAO"%>
<%@ page import="afero.persistence.ContaMovtoDAO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.Date" %>
<%@ page import="afero.util.ConverteDate"%>
<%@ page import="afero.util.Utilitaria"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<script src="../js/common.js"/></script>
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
		document.all.nomeLocalizar.value = '';
		document.all.idLojaLocalizar.value = '';
		document.all.idContaLocalizar.value = '0';
		document.all.nrDocLocalizar.value = '';
	  document.all.statusLocalizar[0].value = '';
	  document.all.statusLocalizar[1].value = 'A';
	  document.all.statusLocalizar[2].value = '';
	  document.all.statusLocalizar[3].value = '';
		document.forms[0].submit();
	}

	function popUp() {
		var idDPai = parseFloat(document.getElementById('idDuplicataPai').value);
		if (idDPai != 0) {
			//window.open('formAlterarVencimento.jsp?idDuplicataPai=' + idDPai + '&acao=atuP');
		}
	}
</script>
<%
	String idLojaLocalizar = request.getParameter("idLojaLocalizar");
	if(idLojaLocalizar == null)idLojaLocalizar="0";
	String idContaLocalizar = request.getParameter("idContaLocalizar");
	if(idContaLocalizar == null)idContaLocalizar="0";
	String statusLocalizar = "A";
	Duplicata duplicata = new Duplicata();
	DuplicataDAO dao;
	DuplicataDAO daoExclusao;
	DuplicataParcela duplicataParcela = null;
	ContaDAO daoConta;	
	ContaMovto contaMovto;
	ContaMovtoDAO daoContaMovto;
	ConverteDate conDate = new ConverteDate();
	ColaboradorDAO daoDuplicataColaborador = new ColaboradorDAO(conn);
	String idUsuario = (String) session.getAttribute("idUsuario");
	Colaborador colaboradorDuplicata = daoDuplicataColaborador.procurarColaboradorUsuario(Integer.parseInt(idUsuario));
	if (idLojaLocalizar.isEmpty() || idLojaLocalizar.equals("0")) 
		idLojaLocalizar = "".valueOf(colaboradorDuplicata.getIdLoja());
	String mensagem = request.getParameter("mensagem");
	if (mensagem == null)
		mensagem = "";
	String acao = request.getParameter("acao");
	if (acao == null)
		acao = "listar";

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
	String nrDiasPag = "30";
	String quantParcelas = "0";
	String valorTotal = "0";
	String gerarBoleto = "N";
	String observacao = "";
	String tipoLancamento = "M";
	String txMulta = "0";
	String txJuros = "0";
	String tipoJuros = "M";
	String status = "A";
	String dtCad = "";
	String dtMod = "";
	String usuario = (String) session.getAttribute("Login");
	
	String dtVencimento = "";
	
	String dsEntidade = request.getParameter("dsEntidade");
	if (dsEntidade == null)
		dsEntidade = "";
	String nomeLocalizar = "";
	String nrDocLocalizar = null;
	String dtVenc1Localizar = "";
	String dtVenc2Localizar = "";
	String dtEmissao1Localizar = "";
	String dtEmissao2Localizar = "";
	String clausula = "";
	
	ConverteDate converte = new ConverteDate();
	DuplicataParcelaDAO daoDuplicataParcela = new DuplicataParcelaDAO(conn);
	//Variaveis para o formAlterarVencimento
	int idDuplicataPai = 0;
	String acP = request.getParameter("acP");
	String ck = "op";
	// fim

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
	String statusParcela = "A";
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
		dtVencimento = request.getParameter("dtVencimento");
		if (acao == null)
			acao = "inc";
		if (idDuplicata == null)
			idDuplicata = "0";
		if (idLoja == null)
			idLoja = String.valueOf(colaboradorDuplicata.getIdLoja());
		if (cdEntidade == null)
			cdEntidade = "0";
		if (dc == null)
			dc = "C";
		if (dtEmissao == null)
			dtEmissao = "";
		if (dtComp == null)
			dtComp = "";
		if (nrDoc == null)
			nrDoc = "0";
		if (idTipoDocumento == null)
			idTipoDocumento = "0";
		if (idPlanoConta == null)
			idPlanoConta = "0";
		if (idCentroCusto == null)
			idCentroCusto = "0";
		if (historico == null)
			historico = "";
		if (nrDiasPag == null)
			nrDiasPag = "30";
		if (quantParcelas == null)
			quantParcelas = "0";
		if (valorTotal == null)
			valorTotal = "0";
		if (gerarBoleto == null)
			gerarBoleto = "N";
		if (observacao == null)
			observacao = "";
		if (tipoLancamento == null)
			tipoLancamento = "M";
		if (txMulta == null)
			txMulta = "0";
		if (txJuros == null)
			txJuros = "0";
		if (tipoJuros == null)
			tipoJuros = "M";
		if (status == null)
			status = "A";
		if (dtCad == null)
			dtCad = "";
		if (dtMod == null)
			dtMod = "";
		if (dtVencimento == null)
			dtVencimento = "";

		// CAMPOS PARCELA
		if (request.getParameter("idDuplicataParcela") != null) {
			idDuplicataParcela = Utilitaria.toNumber(request.getParameter("idDuplicataParcela")).intValue();
		}
		if (request.getParameter("nrParcela") != null) {
			nrParcela = Utilitaria.toNumber(request.getParameter("nrParcela")).intValue();
		}
		if (request.getParameter("idConta") != null) {
			idConta = Utilitaria.toNumber(request.getParameter("idConta")).intValue();
		} else {
			idConta = 1;
		}
		//valor = Utilitaria.toNumber(valorTotal).doubleValue();
		if (request.getParameter("cdFormaPagto") != null) {
			cdFormaPagto = Utilitaria.toNumber(request.getParameter("cdFormaPagto")).intValue();
		} else {
			cdFormaPagto = 1;
		}
		dtEmissaoParcela = dtEmissao;
		dtCompParcela = dtComp;
		nrDocParcela = Utilitaria.toNumber(nrDoc).intValue();
		idPlanoContaParcela = Utilitaria.toNumber(idPlanoConta).intValue();
		idCentroCustoParcela = Utilitaria.toNumber(idPlanoConta).intValue();
		historico = request.getParameter("historico");
		if (request.getParameter("divideValor") != null) {
			divideValor = request.getParameter("divideValor");
		} else {
			divideValor = "N";
		}
		if (request.getParameter("atualizaFinanceiro") != null) {
			atualizaFinanceiro = request.getParameter("atualizaFinanceiro");
		} else {
			atualizaFinanceiro = "N";
		}
		dtOperacao = request.getParameter("dtOperacao");
		//vlOperacao = Utilitaria.toNumber(valorTotal).doubleValue();
		vlJuros = 0;
		vlMulta = 0;
		vlDesc = 0;

		if (request.getParameter("nossoNumero") != null) {
			nossoNumero = request.getParameter("nossoNumero");
		} else {
			nossoNumero = "";
		}

		dtQuitacao = request.getParameter("dtQuitacao");
		formaQuitacao = request.getParameter("formaQuitacao");
		if (request.getParameter("idColaborador") != null) {
			idColaborador = Utilitaria.toNumber(request.getParameter("idColaborador")).intValue();
		} else {
			idColaborador = 0;
		}

		//atualizaFinanceiro = request.getParameter("atualizaFinanceiro");
		if (request.getParameter("idContaMovto") != null) {
			idContaMovto = Utilitaria.toNumber(request.getParameter("idContaMovto")).intValue();
		}
		statusParcela = "A";
		dtMov = request.getParameter("dtMov");
		usuarioParcela = usuario;
		// FIM CAMPOS PARCELA
		
		try {
			if (!acao.equalsIgnoreCase("inc")) {
				duplicata.setIdDuplicata(Integer.parseInt(idDuplicata));
			}
			duplicata.setIdLoja(Integer.parseInt(idLoja));
			duplicata.setCdEntidade(Integer.parseInt(cdEntidade));
			duplicata.setDc(dc);
			if (dtEmissao != "") {
				duplicata.setDtEmissao(ConverteDate.stringToDate(dtEmissao));
			}
			if (dtComp != "") {
				duplicata.setDtComp(ConverteDate.stringToDate(dtComp));
				duplicata.setStatus("DQ");
			}
			duplicata.setNrDoc(nrDoc);
			duplicata.setIdTipoDocumento(Integer.parseInt(idTipoDocumento));
			duplicata.setIdPlanoConta(Integer.parseInt(idPlanoConta));
			duplicata.setIdCentroCusto(Integer.parseInt(idCentroCusto));
			duplicata.setHistorico(historico);
			duplicata.setNrDiasPag(Integer.parseInt(nrDiasPag));
			duplicata.setQuantParcelas(Integer.parseInt(quantParcelas));
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
			idDuplicataPai = dao.idDuplicataMax();

			if (Utilitaria.toNumber(quantParcelas).intValue() > 0) {
				duplicataParcela = new DuplicataParcela();
				DuplicataParcelaDAO daoParcela = new DuplicataParcelaDAO(conn);
				for (int parcela = 1; parcela <= Integer.parseInt(quantParcelas); parcela++) {
					duplicataParcela.setIdDuplicata(duplicata.getIdDuplicata());
					duplicataParcela.setNrParcela(parcela);
					duplicataParcela.setIdConta(idConta);
					//Início Data de Vencimento
					if (dtVencimento != null && parcela == 1) {
						dataVencimento = dtVencimento;
					} else {
						if (ultimaDataVencimento == null) {
							dataVencimento = daoParcela.dataVencimentoDataAtual(Integer.parseInt(nrDiasPag));
						} else {
							dataVencimento = daoParcela.dataVencimentoEntreDatas(ConverteDate.stringToDate(ultimaDataVencimento),
											Integer.parseInt(nrDiasPag));
						}
					}
					ultimaDataVencimento = dataVencimento;
					duplicataParcela.setDtVenc(ConverteDate.stringToDate(dataVencimento));
					//Fim Data de Vencimento
					//Valor da Parcela
					valorParcela = (duplicata.getValorTotal() / Integer.parseInt(quantParcelas));
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
					duplicataParcela.setVlOperacao(vlOperacao);
					duplicataParcela.setVlJuros(vlJuros);
					duplicataParcela.setVlMulta(vlMulta);
					duplicataParcela.setVlDesc(vlDesc);
					duplicataParcela.setNossoNumero(nossoNumero);
					duplicataParcela.setDtQuitacao(ConverteDate.stringToDate(dtQuitacao));
					duplicataParcela.setFormaQuitacao(formaQuitacao);
					duplicataParcela.setIdColaborador(idColaborador);
					duplicataParcela.setAtualizaFinanceiro(atualizaFinanceiro);
					duplicataParcela.setIdContaMovto(idContaMovto);
					duplicataParcela.setStatus(statusParcela);
					duplicataParcela.setDtMov(ConverteDate.stringToDate(dtMov));
					duplicataParcela.setUsuario(usuario);

					daoParcela.incluir(duplicataParcela);
				}
			}

		} else if (acao.equalsIgnoreCase("atu")) {
			//atualiza no banco de dados
			dao.atualizar(duplicata);
		} else if (acao.equalsIgnoreCase("exc")) {
			//exclui no banco de dados
			if (!daoExclusao.exclusaoIdDuplicata(Integer.parseInt(idDuplicata))) {
				dao.excluir(duplicata);
			} else {
				response.sendRedirect("listarDuplicataReceber.jsp?mensagem=Exclusão Inválida! Item já possui lançamentos.&acao=listar");
			}
		}
		
	} else if (acao.equalsIgnoreCase("atuP")) {

		if (request.getParameter("idDuplicataParcela") != null) {
			idDuplicataParcela = Integer.parseInt(request.getParameter("idDuplicataParcela"));
		}
		if (request.getParameter("idDuplicata") != null) {
			idDuplicata = request.getParameter("idDuplicata");
		}
		if (request.getParameter("nrParcela") != null) {
			nrParcela = Integer.parseInt(request.getParameter("nrParcela"));
		}
		if (request.getParameter("idConta") != null) {
			idConta = Integer.parseInt(request.getParameter("idConta"));
		}
		if (request.getParameter("dtVenc") != null) {
			dtVenc = request.getParameter("dtVenc");
		}
		if (request.getParameter("valor") != null) {
			valor = Utilitaria.toNumber(request.getParameter("valor")).doubleValue();
		}
		if (request.getParameter("cdFormaPagto") != null) {
			cdFormaPagto = Integer.parseInt(request.getParameter("cdFormaPagto"));
		}
		if (request.getParameter("dtEmissao") != null) {
			dtEmissao = request.getParameter("dtEmissao");
		}
		if (request.getParameter("dtComp") != null) {
			dtComp = request.getParameter("dtComp");
		}
		if (request.getParameter("nrDoc") != null) {
			nrDoc = request.getParameter("nrDoc");
		}
		if (request.getParameter("idPlanoConta") != null) {
			idPlanoConta = request.getParameter("idPlanoConta");
		}
		if (request.getParameter("idCentroCusto") != null) {
			idCentroCusto = request.getParameter("idCentroCusto");
		}
		if (request.getParameter("historico") != null) {
			historico = request.getParameter("historico");
		}
		if (request.getParameter("divideValor") != null) {
			divideValor = request.getParameter("divideValor");
		}
		if (request.getParameter("dtOperacao") != null) {
			dtOperacao = request.getParameter("dtOperacao");
		}
		if (request.getParameter("vlOperacao") != null) {
			vlOperacao = Utilitaria.toNumber(request.getParameter("vlOperacao")).doubleValue();
		}
		if (request.getParameter("vlJuros") != null) {
			vlJuros = Utilitaria.toNumber(request.getParameter("vlJuros")).floatValue();
		}
		if (request.getParameter("vlMulta") != null) {
			vlMulta = Utilitaria.toNumber(request.getParameter("vlMulta")).floatValue();
		}
		if (request.getParameter("vlDesc") != null) {
			vlDesc = Utilitaria.toNumber(request.getParameter("vlDesc")).floatValue();
		}
		if (request.getParameter("nossoNumero") != null) {
			nossoNumero = request.getParameter("nossoNumero");
		}
		if (request.getParameter("dtQuitacao") != null) {
			dtQuitacao = request.getParameter("dtQuitacao");
		}
		if (request.getParameter("formaQuitacao") != null) {
			formaQuitacao = request.getParameter("formaQuitacao");
		}
		if (request.getParameter("idColaborador") != null) {
			idColaborador = Integer.parseInt(request.getParameter("idColaborador"));
		}
		if (request.getParameter("atualizaFinanceiro") != null) {
			atualizaFinanceiro = request.getParameter("atualizaFinanceiro");
		}
		if (request.getParameter("idContaMovto") != null) {
			idContaMovto = Integer.parseInt(request.getParameter("idContaMovto"));
		}
		if (request.getParameter("status") != null) {
			status = request.getParameter("status");
		}
		usuario = (String) session.getAttribute("Login");

		duplicataParcela = new DuplicataParcela();
		DuplicataParcelaDAO daoParcela = new DuplicataParcelaDAO(conn);
		duplicataParcela.setIdDuplicataParcela(idDuplicataParcela);
		duplicataParcela.setIdDuplicata(Integer.parseInt(idDuplicata));
		duplicataParcela.setNrParcela(nrParcela);
		duplicataParcela.setIdConta(idConta);
		if (dtVenc != "") {
			duplicataParcela.setDtVenc(ConverteDate.stringToDate(dtVenc));
		}
		duplicataParcela.setValor(valor);
		duplicataParcela.setCdFormaPagto(cdFormaPagto);
		if (dtEmissao != "") {
			duplicataParcela.setDtEmissao(ConverteDate.stringToDate(dtEmissao));
		}
		if (dtComp != "") {
			duplicataParcela.setDtComp(ConverteDate.stringToDate(dtComp));
		}
		duplicataParcela.setNrDoc(nrDoc);
		duplicataParcela.setIdPlanoConta(Integer.parseInt(idPlanoConta));
		duplicataParcela.setIdCentroCusto(Integer.parseInt(idCentroCusto));
		duplicataParcela.setHistorico(historico);
		duplicataParcela.setDivideValor(divideValor);
		if (dtOperacao != "") {
			duplicataParcela.setDtOperacao(ConverteDate.stringToDate(dtOperacao));
		}
		duplicataParcela.setVlOperacao(vlOperacao);
		duplicataParcela.setVlJuros(vlJuros);
		duplicataParcela.setVlMulta(vlMulta);
		duplicataParcela.setVlDesc(vlDesc);
		duplicataParcela.setNossoNumero(nossoNumero);
		if (dtQuitacao != "") {
			duplicataParcela.setDtQuitacao(ConverteDate.stringToDate(dtQuitacao));
		}
		duplicataParcela.setFormaQuitacao(formaQuitacao);
		duplicataParcela.setIdColaborador(idColaborador);
		duplicataParcela.setAtualizaFinanceiro(atualizaFinanceiro);
		duplicataParcela.setIdContaMovto(idContaMovto);
		duplicataParcela.setStatus(status);
		if (dtMov != "") {
			duplicataParcela.setDtMov(ConverteDate.stringToDate(dtMov));
		}
		duplicataParcela.setUsuario(usuario);

		daoParcela.atualizar(duplicataParcela);
		
		dao = new DuplicataDAO(conn);
		dao.atualizarValorTotal(Integer.parseInt(idDuplicata));
		dao.atualizarStatus(Integer.parseInt(idDuplicata));
		
		if (duplicataParcela.getStatus().equals("Q")) {
			contaMovto = new ContaMovto();
			contaMovto.setIdConta(duplicataParcela.getIdConta());
			contaMovto.setDc("C");
			contaMovto.setValor(vlOperacao+vlJuros+vlMulta-vlDesc);
			contaMovto.setFormaMovto("P");
		  contaMovto.setDtLanc(duplicataParcela.getDtQuitacao());
			contaMovto.setDtComp(duplicataParcela.getDtComp());
			contaMovto.setIdTransferencia(0);
			contaMovto.setNrDoc(duplicataParcela.getNrDoc());
			contaMovto.setIdPlanoConta(duplicataParcela.getIdPlanoConta());
			contaMovto.setIdCentroCusto(duplicataParcela.getIdCentroCusto());
			contaMovto.setHistorico("Pagamento "+duplicataParcela.getNrDoc());
			contaMovto.setDivideValor("N");
			contaMovto.setIdColaborador(idColaborador);
			contaMovto.setVlSaldoAnterior(0);  // falta acertar o saldo anterior
			contaMovto.setVlSaldoAtual(0);  // falta acertar o saldo atual
			contaMovto.setConciliado("S");
			contaMovto.setStatus("A");
			contaMovto.setUsuario(duplicataParcela.getUsuario());
			daoContaMovto = new ContaMovtoDAO(conn);
			daoContaMovto.incluir(contaMovto);
		}
		
	} else {
		if (!acao.equalsIgnoreCase("voltar")) {
		  idContaLocalizar = request.getParameter("idContaLocalizar");
			if(idContaLocalizar == null) 
				idContaLocalizar = "0";
			nomeLocalizar = request.getParameter("nomeLocalizar");
			nrDocLocalizar = request.getParameter("nrDocLocalizar");
			dtVenc1Localizar = request.getParameter("dtVenc1Localizar");
			if (dtVenc1Localizar == null)
				dtVenc1Localizar = "";
			dtVenc2Localizar = request.getParameter("dtVenc2Localizar");
			if (dtVenc2Localizar == null)
				dtVenc2Localizar = "";
			dtEmissao1Localizar = request.getParameter("dtEmissao1Localizar");
			if (dtEmissao1Localizar == null)
				dtEmissao1Localizar = "";
			dtEmissao2Localizar = request.getParameter("dtEmissao2Localizar");
			if (dtEmissao2Localizar == null)
				dtEmissao2Localizar = "";
			statusLocalizar = request.getParameter("statusLocalizar");
			if (statusLocalizar == null)
				statusLocalizar = "A";
		}
		if (nomeLocalizar != null && !nomeLocalizar.isEmpty()) {
			clausula = " WHERE e.nome LIKE '" + nomeLocalizar + "%'";
		}

		if (nrDocLocalizar != null && !nrDocLocalizar.isEmpty()) {
			if (clausula.isEmpty()) {
				clausula += " WHERE d.nrDoc = '" + nrDocLocalizar + "'";
			} else {
				clausula += " AND d.nrDoc = '" + nrDocLocalizar + "'";
			}
		}
		
	  if (!idContaLocalizar.isEmpty() && !idContaLocalizar.equals("0")) {
		  if (clausula.isEmpty()) {
		    clausula = " WHERE dp.idConta="+idContaLocalizar;
		  } else {
		    clausula = clausula+" AND dp.idConta="+idContaLocalizar;
		  }
		}
	  
		if (dtVenc1Localizar != null && !dtVenc1Localizar.isEmpty() && dtVenc2Localizar != null && !dtVenc2Localizar.isEmpty()) {
			if (clausula.isEmpty()) {
				  clausula = " WHERE dp.dtVenc BETWEEN '"+converte.DMYToYMDI(dtVenc1Localizar)+" 00:00:00' AND '"+converte.DMYToYMDI(dtVenc2Localizar)+" 23:59:59'"; 
			} else {
				clausula += " AND dp.dtVenc BETWEEN '"+converte.DMYToYMDI(dtVenc1Localizar)+" 00:00:00' AND '"+converte.DMYToYMDI(dtVenc2Localizar)+" 23:59:59'";
			}
		} else if (dtVenc1Localizar != null && !dtVenc1Localizar.isEmpty() && dtVenc2Localizar != null && dtVenc2Localizar.isEmpty()) {
			if (clausula.isEmpty()) {
				  clausula = " WHERE dp.dtVenc >= '"+converte.DMYToYMDI(dtVenc1Localizar)+" 00:00:00'"; 
			} else {
				clausula += " AND dp.dtVenc >= '"+converte.DMYToYMDI(dtVenc1Localizar)+" 00:00:00'";
			}
		} else if (dtVenc1Localizar != null && dtVenc1Localizar.isEmpty() && dtVenc2Localizar != null && !dtVenc2Localizar.isEmpty()) {
			if (clausula.isEmpty()) {
				  clausula = " WHERE dp.dtVenc <= '"+converte.DMYToYMDI(dtVenc2Localizar)+" 23:59:59'"; 
			} else {
				clausula += " AND dp.dtVenc <= '"+converte.DMYToYMDI(dtVenc2Localizar)+" 23:59:59'";
			}
		}
		
		if (dtEmissao1Localizar != null && !dtEmissao1Localizar.isEmpty() && dtEmissao2Localizar != null && !dtEmissao2Localizar.isEmpty()) {
			if (clausula.isEmpty()) {
				  clausula = " WHERE dp.dtEmissao BETWEEN '"+converte.DMYToYMDI(dtEmissao1Localizar)+" 00:00:00' AND '"+converte.DMYToYMDI(dtEmissao2Localizar)+" 23:59:59'"; 
			} else {
				clausula += " AND dp.dtEmissao BETWEEN '"+converte.DMYToYMDI(dtEmissao1Localizar)+" 00:00:00' AND '"+converte.DMYToYMDI(dtEmissao2Localizar)+" 23:59:59'";
			}
		} else if (dtEmissao1Localizar != null && !dtEmissao1Localizar.isEmpty() && dtEmissao2Localizar != null && dtEmissao2Localizar.isEmpty()) {
			if (clausula.isEmpty()) {
				  clausula = " WHERE dp.dtEmissao >= '"+converte.DMYToYMDI(dtEmissao1Localizar)+" 00:00:00'"; 
			} else {
				clausula += " AND dp.dtEmissao >= '"+converte.DMYToYMDI(dtEmissao1Localizar)+" 00:00:00'";
			}
		} else if (dtEmissao1Localizar != null && dtEmissao1Localizar.isEmpty() && dtEmissao2Localizar != null && !dtEmissao2Localizar.isEmpty()) {
			if (clausula.isEmpty()) {
				  clausula = " WHERE dp.dtEmissao <= '"+converte.DMYToYMDI(dtEmissao2Localizar)+" 23:59:59'"; 
			} else {
				clausula += " AND dp.dtEmissao <= '"+converte.DMYToYMDI(dtEmissao2Localizar)+" 23:59:59'";
			}
		}

		if (statusLocalizar != null && !statusLocalizar.isEmpty()) {
			if (clausula.isEmpty()) {
				clausula += " WHERE dp.status = '" + statusLocalizar + "'";
			} else {
				clausula += " AND dp.status = '" + statusLocalizar + "'";
			}
		}
	  if (clausula.isEmpty()) {
	    clausula = " WHERE d.idLoja="+idLojaLocalizar;
	  } else {
	    clausula = clausula+" AND d.idLoja="+idLojaLocalizar;
	  }
	}
%>
<%
	//seleciona todos os registros do banco de dados
	List list;
	dao = new DuplicataDAO(conn);
	DuplicataParcelaDAO daoParcela = new DuplicataParcelaDAO(conn);
	clausula = clausula + " AND d.dc = 'C' ";
	list = daoParcela.listarDuplicataParcela(clausula);
	daoConta = new ContaDAO(conn);

	int cont = 0;
%>
<h1 class="cabecalho_pagina">Contas a Receber</h1>

|<a class="button" href="formDuplicataReceber.jsp?acao=inc">Novo Cadastro</a>|<br>

<%
	if (mensagem != null) {
%><div class="mensagem"><center><%=mensagem%></center></div><hr><%
	}
%>
<iframe width=174 height=189 name="gToday:normal:"../js/calendar/agenda.js"
            id="gToday:normal:"../js/calendar/agenda.js" src="../js/calendar/ipopeng.htm"
            scrolling="no" frameborder="0" style="visibility:visible; z-index:999; 
    position:absolute; top:-500px; left:-500px;">
</iframe>
<body onLoad="JavaScript: popUp(); document.all.idLojaLocalizar.focus();">
<form action="listarDuplicataReceber.jsp">
<input type="hidden" name="idDuplicataPai" id="idDuplicataPai" value="<%=idDuplicataPai%>" />
  <table colspan="2">
    <tr>
      <th class="label">Loja</th>
      <td><select name="idLojaLocalizar" >
          <%@include file="../WEB-INF/jspf/combo/comboLoja.jspf" %></select>
          <script>comboSelect(document.forms[0].idLojaLocalizar, '<%=idLojaLocalizar%>');</script>
      </td>
      <th class='label'>Receber de</th>
      <td><input type="text" id="nomeLocalizar" name="nomeLocalizar" <%if (nomeLocalizar != null) {%>value="<%=nomeLocalizar%>"<%}%>  size="40" maxlength="40"></td>
      <td><input class="button" type="button" value="Localizar" onClick="javascript: localizar();" />
      		<input class="button" type="button" value="Nova pesquisa" onClick="javascript: novaPesquisa();" /></td>
    </tr>
    <tr>
      <th class='label'>Nº Documento</th>
      <td><input type="text" name="nrDocLocalizar" <%if (nrDocLocalizar != null) {%>value="<%=nrDocLocalizar%>"<%}%>  size="20" maxlength="20"></td>
      <th class="label">Conta</th>
      <td><select name="idContaLocalizar" >
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboConta.jspf" %></select>
          <script>comboSelect(document.forms[0].idContaLocalizar, '<%=idContaLocalizar%>');</script>
      </td>
    </tr>
    <tr>
			<th class="label">Vencimento</th>
      <td class='grid'> de
				<input type="text" name="dtVenc1Localizar" size="15" value="<%= dtVenc1Localizar %>" onblur="chkData(this,'dd/MM/yyyy')" maxlength="10" class="inputs"><a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dtVenc1Localizar);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
				 a 
				<input type="text" name="dtVenc2Localizar" size="15" value="<%= dtVenc2Localizar %>" maxlength="10" onblur="chkData(this,'dd/MM/yyyy')" class="inputs"><a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dtVenc2Localizar);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
      </td>
			<th class="label">Emissão</th>
      <td class='grid'> de
				<input type="text" name="dtEmissao1Localizar" size="15" value="<%= dtEmissao1Localizar %>" onblur="chkData(this,'dd/MM/yyyy')" maxlength="10" class="inputs"><a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dtEmissao1Localizar);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
				 a 
				<input type="text" name="dtEmissao2Localizar" size="15" value="<%= dtEmissao2Localizar %>" maxlength="10" onblur="chkData(this,'dd/MM/yyyy')" class="inputs"><a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dtEmissao2Localizar);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
      </td>
    </tr>
  	<tr>
    	<th class="label">Status</th>
    	<td class="label_radio">
      	<input type="radio" class="radio" name="statusLocalizar" value="" <%=(statusLocalizar.equals("") ? "checked" : "")%>>Todas
      	<input type="radio" class="radio" name="statusLocalizar" value="A" <%=(statusLocalizar.equals("A") ? "checked" : "")%>>A receber
      	<input type="radio" class="radio" name="statusLocalizar" value="Q" <%=(statusLocalizar.equals("Q") ? "checked" : "")%>>Recebido
      	<input type="radio" class="radio" name="statusLocalizar" value="C" <%=(statusLocalizar.equals("C") ? "checked" : "")%>>Cancelado</td>
  	</tr>
	</table>
<hr>

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr>
      <th class="grid">&nbsp;</th>
      <th class="grid"><center>Receber de</center></th>
      <th class="grid"><center>Num. Doc.</center></th>
      <th class="grid"><center>Conta</center></th>
      <th class="grid"><center>Num. Parc.</center></th>
      <th class="grid"><center>Vencimento</center></th>
      <th class="grid"><center>Valor</center></th>
      <th class="grid"><center>Data Operação</center></th>
      <th class="grid"><center>Valor Operação</center></th>
      <th class="grid">Status</th>
      <th class="grid">Excluir</th>
    </tr>
<%
	//Utiliza o ResultSet para trazer os registros do banco de dados
	String msgStatus = "";
	String nomeCliente = "";
	Entidade entidade = null;
	Conta conta = null;
	Duplicata dup = null;
	DuplicataParcela dupParc = null;
	DuplicataParcelaDAO daoConsultaParcela = null;
	EntidadeDAO daoEntidade = new EntidadeDAO(conn);
	daoConta = new ContaDAO(conn);
	daoConsultaParcela = new DuplicataParcelaDAO(conn);
	int contQuitada = 0;
	int contAberta = 0;
	for (Iterator it = list.iterator(); it.hasNext();) {
		dupParc = (DuplicataParcela) it.next();
		dup = dao.procurarDuplicata(dupParc.getIdDuplicata());
		String alerta = "";
		if (dupParc.getStatus().equals("C")) {
			msgStatus = "Cancelado";
		} else if (dupParc.getStatus().equals("A")) {
			msgStatus = "A Receber";
			Date data = new Date();
			if (converte.dateToString(data).equals(converte.dateToString(dupParc.getDtVenc()))) {
				alerta = "</br>Vencendo hoje";
			} else if (data.after(dupParc.getDtVenc())) {
				alerta = "</br>Vencido há "+Utilitaria.dataDiff(dupParc.getDtVenc(), data)+" dia(s)";			
			}
		} else if (dupParc.getStatus().equals("Q")) {
			msgStatus = "Recebido";
		} else {
			msgStatus = "";
		}
		//dupParc = daoConsultaParcela.procurarDuplicataParcelaAberta(dup.getIdDuplicata());
		if (dupParc.getIdConta() != 0) {
			conta = daoConta.procurarConta(dupParc.getIdConta());
		}
		contQuitada = daoConsultaParcela.contDuplicataParcelaQuitada(dup.getIdDuplicata());
		contAberta = daoConsultaParcela.contDuplicataParcelaAberta(dup.getIdDuplicata());
		entidade = daoEntidade.procurarEntidade(dup.getCdEntidade());
		nomeCliente = entidade.getNome();
		String contaListar = "";
		if(conta != null){
			contaListar = conta.getNmConta();
		}else{
			contaListar = " - ";
		}
		//conta.setNmConta(nomeCliente);
		cont++;
%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid"><center><%=nomeCliente%></center></td>
      <td class = "grid" width="5%"><center><a href="formDuplicataReceber.jsp?acao=atu&idDuplicata=<%=dup.getIdDuplicata()%>"><%=dup.getNrDoc()%> </a></center></td>
     
      	<td class = "grid"><center><%=contaListar%></center></td>
      
     	<td class = "grid" width="10%"><center><a href="formDuplicataParcelaReceber.jsp?acao=atuP&idDuplicata=<%=dup.getIdDuplicata()%>&idDuplicataParcela=<%=dupParc.getIdDuplicataParcela()%>"><%=dup.getQuantParcelas()==1 ? "Única":"Parcela "+dupParc.getNrParcela()+"/"+dup.getQuantParcelas()%> </a></center></td>
     	<td class = "grid" width="10%"><center><%=converte.dateToString(dupParc.getDtVenc())%><%=alerta %></center></td>
     	<td class = "grid" width="10%"><center><%=Utilitaria.formatarNumero(dupParc.getValor(), 2)%></center></td>
     	<%if (dupParc.getDtOperacao() != null) {%>
     		<td class = "grid" width="10%"><center><%=converte.dateToString(dupParc.getDtOperacao())%></center></td>
     		<td class = "grid" width="10%"><center><%=Utilitaria.formatarNumero(dupParc.getVlOperacao(), 2)%></center></td>
     	<%} else { %>
     		<td class = "grid" width="10%"><center></center></td>
     		<td class = "grid" width="10%"><center></center></td>
     	<%} 
     	  if (dupParc.getStatus().equals("A")) {
     	%>
      	<td class = "grid" width="5%"><center><a href="formDuplicataParcelaRecebimento.jsp?acao=atuP&idDuplicata=<%=dup.getIdDuplicata()%>&idDuplicataParcela=<%=dupParc.getIdDuplicataParcela()%>"><%=msgStatus%> </a></center></td>
      <%} else { %>
      	<td class = "grid" width="5%"><center><%=msgStatus%></center></td>
      <%} %>
      <%if(dupParc.getStatus().equalsIgnoreCase("A")){ %>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=dup.getIdDuplicata()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
      <%}else{%>
      	<td class = "grid" width="3%"><center>-</center></td>
      <%} %>
  	</tr>
<%
	}
%>
</table>
</body>
</form>
<p align="right">|<a class="button" href="formDuplicataReceber.jsp?acao=inc">Novo Cadastro</a>|</p>