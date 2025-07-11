
<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.OrdemServico" %>
<%@page import="afero.model.PedidoSaida" %>
<%@page import="afero.model.Entidade" %>
<%@page import="afero.model.Loja" %>
<%@page import="afero.model.Colaborador" %>
<%@page import="afero.model.Entrega" %>
<%@page import="afero.model.TipoAtendimento" %>
<%@page import="afero.model.CondPagto" %>
<%@page import="afero.model.OrdemServicoObjeto" %>
<%@page import="afero.model.OrdemServicoItem" %>
<%@page import="afero.model.ConfigServico" %>
<%@page import="afero.model.ListaServico"%>
<%@page import="afero.model.ListaTarefa"%>
<%@page import="afero.model.Entrega"%>
<%@page import="afero.model.OrdemServicoTarefa"%>
<%@page import="afero.persistence.OrdemServicoDAO" %>
<%@page import="afero.persistence.PedidoSaidaDAO" %>
<%@page import="afero.persistence.EntidadeDAO" %>
<%@page import="afero.persistence.LojaDAO" %>
<%@page import="afero.persistence.ColaboradorDAO" %>
<%@page import="afero.persistence.EntregaDAO" %>
<%@page import="afero.persistence.TipoAtendimentoDAO" %>
<%@page import="afero.persistence.CondPagtoDAO" %>
<%@page import="afero.persistence.OrdemServicoObjetoDAO" %>
<%@page import="afero.persistence.OrdemServicoItemDAO" %>
<%@page import="afero.persistence.ConfigServicoDAO" %>
<%@page import="afero.persistence.ListaServicoDAO"%>
<%@page import="afero.persistence.ListaTarefaDAO"%>
<%@page import="afero.persistence.EntregaDAO"%>
<%@page import="afero.persistence.OrdemServicoItemDAO"%>
<%@page import="afero.persistence.OrdemServicoTarefaDAO"%>
<%@page import="java.util.List" %>
<%@page import="java.util.Iterator" %>
<%@page import="afero.util.ConverteDate" %>
<%@page import="afero.util.Utilitaria" %>
<%@page import="java.util.Date" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/></script>
<script>
function confirmaExcluirObj(cont, idObj) {
	  if (confirm("Deseja mesmo apagar o Objeto [" + cont + "]?")) {  
	       location.href = 'formAddObjetosOS.jsp?acao=excObj&idOrdemServico='+document.getElementById('idOrdemServico').value+'&idOrdemServicoObjeto='+idObj;
	  }
}

function confirmaExcluirItem(cont, idItem) {
	  if (confirm("Deseja mesmo apagar o Serviço [" + cont + "]?")) {  
	       location.href = 'formAddObjetosOS.jsp?acao=excItem&idOrdemServico='+document.getElementById('idOrdemServico').value+'&idOrdemServicoItem='+idItem;
	  }
}

function confirmaExcluirTarefa(cont, id) {
	  if (confirm("Deseja mesmo apagar a Tarefa [" + cont + "]?")) {  
	       location.href = 'formAddObjetosOS.jsp?acao=excTaf&idOrdemServico='+document.getElementById('idOrdemServico').value+'&idOrdemServicoTarefa='+id;
	  }
}
function salvar() {
		document.forms[0].submit();
}

function cancelar() {
  document.forms[0].action="formProdutosOS.jsp";
  document.forms[0].submit();
}

function voltar() {
  document.forms[0].action = 'listarOrdemServico.jsp?acao=voltar'
	document.forms[0].submit();
}

function abrirPopup(URL) {

  var width = 700;
  var height = 400;

  var left = 99;
  var top = 99;

  window.open(URL,'janela', 'width='+width+', height='+height+', top='+top+', left='+left+', scrollbars=yes, status=no, toolbar=no, location=no, directories=no, menubar=no, resizable=no, fullscreen=no');

}
</script>
</head>
<%
Entidade entidade;
EntidadeDAO daoEntidade;
String nomeEntidade = "";

Loja loja;
LojaDAO daoLoja;
String nomeLoja = "";

Colaborador colaborador;
ColaboradorDAO daoColaborador;
String nomeColaborador = "";

Entrega entrega;
EntregaDAO daoEntrega;
String nomeEntrega = "";

TipoAtendimento tipoAtendimento;
TipoAtendimentoDAO daoTipoAtendimento;
String nomeTipoAtendimento = "";

CondPagto condPagto;
CondPagtoDAO daoCondPagto;
String nomeCondPagto = "";

OrdemServicoObjeto ordemServicoObjeto;
OrdemServicoObjeto servicoObjeto; // Para mostrar nome do objeto nos serviços 
OrdemServicoObjetoDAO daoObjeto;
String clausulaObj = "";

String nomeTipo = "";
String nomeStatus = "";

ConfigServico configServico;
ConfigServicoDAO daoConfig;

OrdemServicoItemDAO daoItem;
OrdemServicoItem ordemServicoItem;
String clausulaItem = "";
String nIdOS = "";// Guardar idOrdemServicoObjeto da OS

OrdemServicoTarefaDAO daoTarefa;
OrdemServicoTarefa ordemServicoTarefa;
String clausulaTarefa = "";

ListaTarefa listaTarefa;
ListaTarefaDAO daoListaTarefa;

ListaServico listaServico;
ListaServicoDAO daoListaServico;

String mensagem = request.getParameter("mensagem");
String acao = request.getParameter("acao");
String idOrdemServico = request.getParameter("idOrdemServico");

String idOrdemServicoObj = null; // Variavel para query de serviços.
String idOrdemServicoItemObj = null;
if (acao == null) acao = "inc";
if(idOrdemServico == null) idOrdemServico = "0";

int cdEntidade = 0;
int idLoja = Integer.parseInt((String)session.getAttribute("idLoja"));
int idColaborador = 0;
int cdTipoAtendimento = 0;
String tipo = "O";
Date dtOrc = null;
Date dtOS = null;
Date dtAprov = null;
Date dtEntrega = null;
String pessoaResponsavel = "";
Date dtInicio = null;
Date dtConclusao = null;
Date dtEntRealizada = null;
int cdCondPagto = 0;
int prazoEntrega = 0;
int prazoValidade = 0;
int prazoGarantia = 0;
String cmpOS1 = "";
String cmpOS2 = "";
String cmpOS3 = "";
String cmpOS4 = "";
String observacao = "";
double vlServ = 0;
double vlProd = 0;
double vlFrete = 0;
double vlDesc = 0;
String status = "I";
Date dtMod = null;
String usuario = (String) session.getAttribute("Login");
float valorTotal = 0;
float totalServicos = 0;
float totalTarefas = 0;
float totalTaxaEntregaPedidos = 0;
//exclusão
if(acao.equalsIgnoreCase("excObj")){
	daoObjeto = new OrdemServicoObjetoDAO(conn);
	ordemServicoObjeto = new OrdemServicoObjeto();
	int idOrdemServicoObjeto = Integer.parseInt(request.getParameter("idOrdemServicoObjeto"));
	ordemServicoObjeto.setIdOrdemServicoObjeto(idOrdemServicoObjeto);
	if(daoObjeto.existeServico(idOrdemServicoObjeto)){
		  mensagem = " Existe registro de serviço na ORDEM DE SERVIÇO OU ORÇAMENTO ";
	  }else{
		  daoObjeto.excluir(ordemServicoObjeto);
	  }
	  
	  acao = "atu";
}

if(acao.equalsIgnoreCase("excItem")){
	daoItem = new OrdemServicoItemDAO(conn);
	ordemServicoItem = new OrdemServicoItem();
	int idOrdemServicoItem = Integer.parseInt(request.getParameter("idOrdemServicoItem"));
	ordemServicoItem.setIdOrdemServicoItem(idOrdemServicoItem);
	if(daoItem.existeServico(idOrdemServicoItem)){
		  mensagem = " Existe registro de serviço na ORDEM DE SERVIÇO OU ORÇAMENTO ";
	  }else{
		  daoItem.excluir(ordemServicoItem);
	  }
	  //exclui no banco de dados
	 
	  acao = "atu";
}
if(acao.equalsIgnoreCase("excTaf")){
	daoTarefa = new OrdemServicoTarefaDAO(conn);
	ordemServicoTarefa= new OrdemServicoTarefa();
	int idOrdemServicoTarefa = Integer.parseInt(request.getParameter("idOrdemServicoTarefa"));
	ordemServicoTarefa.setIdOrdemServicoTarefa(idOrdemServicoTarefa);

	  //exclui no banco de dados
	//  if(daoTarefa.existeServico(idOrdemServicoTarefa)){
	//	  mensagem = " Existe registro de serviço na ORDEM DE SERVIÇO OU ORÇAMENTO ";
	  //}else{
		  daoTarefa.excluir(ordemServicoTarefa);
	 // }
	  
	  acao = "atu";
}
if (acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("inc")){
	
	OrdemServicoDAO dao = new OrdemServicoDAO(conn);
	OrdemServico ordemServico = dao.procurarOrdemServico(" WHERE idOrdemServico = "+Integer.parseInt(idOrdemServico) );
	idLoja = ordemServico.getIdLoja();
	cdEntidade = ordemServico.getCdEntidade();
	idColaborador = ordemServico.getIdColaborador();
	cdTipoAtendimento = ordemServico.getCdTipoAtendimento();
	tipo = ordemServico.getTipo();
	dtOrc = ordemServico.getDtOrc();
	dtOS = ordemServico.getDtOS();
	dtAprov = ordemServico.getDtAprov();
	dtEntrega = ordemServico.getDtEntrega();
	pessoaResponsavel = ordemServico.getPessoaResponsavel();
	dtInicio = ordemServico.getDtInicio();
	dtConclusao = ordemServico.getDtConclusao();
	dtEntRealizada = ordemServico.getDtEntRealizada();
	cdCondPagto = ordemServico.getCdCondPagto();
	prazoEntrega = ordemServico.getPrazoEntrega();
	prazoValidade = ordemServico.getPrazoEntrega();
	prazoGarantia = ordemServico.getPrazoGarantia();
	cmpOS1 = ordemServico.getCmpOS1();
	cmpOS2 = ordemServico.getCmpOS2();
	cmpOS3 = ordemServico.getCmpOS3();
	cmpOS4 = ordemServico.getCmpOS4();
	observacao = ordemServico.getObservacao();
	vlServ = dao.getTotal(Integer.parseInt(idOrdemServico));//ordemServico.getVlServ();
	vlProd = ordemServico.getVlProd();
	vlFrete = ordemServico.getVlFrete();
	vlDesc = ordemServico.getVlDesc();
	valorTotal = dao.getValorTotal(Integer.parseInt(idOrdemServico));
	status = ordemServico.getStatus();
	dtMod = ordemServico.getDtMod();
	usuario = ordemServico.getUsuario();
	
	// Nome da Entidade
	entidade = new Entidade();
	daoEntidade = new EntidadeDAO(conn);
	entidade = daoEntidade.procurarEntidade(cdEntidade);
	nomeEntidade = entidade.getNome();
	
	//Loja
	loja = new Loja();
	daoLoja = new LojaDAO(conn);
	loja = daoLoja.procurarLoja(idLoja);
	nomeLoja = loja.getRazaoSocial();
	
	//Colaborador
	colaborador = new Colaborador();
	daoColaborador = new ColaboradorDAO(conn);
	colaborador = daoColaborador.procurarColaborador(idColaborador);
	nomeColaborador = colaborador.getNome();
	
	
	
	//Tipo de Atendimento
	tipoAtendimento = new TipoAtendimento();
	daoTipoAtendimento = new TipoAtendimentoDAO(conn);
	tipoAtendimento = daoTipoAtendimento.procurarTipoAtendimento(" WHERE cdTipoAtendimento = "+cdTipoAtendimento );
	nomeTipoAtendimento  = tipoAtendimento.getDsTipoAtendimento();
	
	//Condição de Pagamento
	condPagto = new CondPagto();
	daoCondPagto = new CondPagtoDAO(conn);
	condPagto = daoCondPagto.procurarCondPagto(" WHERE cdCondPagto = "+cdCondPagto );
	nomeCondPagto = condPagto.getDsCondPagto();
	
	// Tipo
	if(tipo.equalsIgnoreCase("o")){
		nomeTipo = "Orçamento";
	}else if(tipo.equalsIgnoreCase("s")){
		nomeTipo = "Ordem de Serviço";
	}
}
%>

<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Ordem de Serviço</h1>
<hr><% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<form method="post" action="listarOrdemServico.jsp?acao=<%=acao%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" id="idOrdemServico" name="idOrdemServico" value="<%=idOrdemServico%>"/>
<input type="hidden" id="idOrdemServicoObjeto" name="idOrdemServicoObjeto" value="<%=idOrdemServicoObj %>"/>
<iframe width=174 height=189 name="gToday:normal:"../js/calendar/agenda.js"
            id="gToday:normal:"../js/calendar/agenda.js" src="../js/calendar/ipopeng.htm"
            scrolling="no" frameborder="0" style="visibility:visible; z-index:999; 
    position:absolute; top:-500px; left:-500px;">
</iframe>
<!--  Cabeçalho  -->
<table border="0" align="center" width="100%">
	<tr>
		<th class="label">Entidade:</th>
		<td class="textos">&nbsp;<%=nomeEntidade %></td>
		<th class="label">Loja:</th>
		<td class="textos">&nbsp;<%=nomeLoja %></td>
	</tr>
	<tr>
		<th class="label">Colaborador:</th>
		<td class="textos">&nbsp;<%=nomeColaborador %></td>
		<th class="label">Tipo:</th>
		<td class="textos">&nbsp;<%=nomeTipo %></td>
	</tr>
	<tr>
		<th class="label">Local de Entrega:</th>
		<td class="textos">&nbsp;<%=nomeEntrega %></td>
		<th class="label">Tipo Atendimento:</th>
		<td class="textos">&nbsp;<%=nomeTipoAtendimento %></td>
	</tr>
	<tr>
		<th class="label">Responsável:</th>
		<td class="textos">&nbsp;<%=pessoaResponsavel %></td>
		
		<!--  Orçamento ou OS  -->	
		<%if(tipo.equalsIgnoreCase("o")) {%>
			<th class="grid">Data do Orçamento:</th>
			<td class="textos">&nbsp;<%=ConverteDate.dateToString(dtOrc) %></td>
		<%} else if(tipo.equalsIgnoreCase("s")){ %>
			<th class="grid">Data da OS:</th>
			<td class="textos">&nbsp;<%=ConverteDate.dateToString(dtOS) %></td>
		<%} %>
	</tr>
	<tr>
		<th class="label">Status:</th>
		<% 
		if(status.equalsIgnoreCase("A")){
			nomeStatus = "Aberta";
		}else if(status.equalsIgnoreCase("F")){
			nomeStatus = "Fechada";
		}else if(status.equalsIgnoreCase("C")){
			nomeStatus = "Cancelada";
		}
		%>
		<td class="textos">&nbsp;<%=nomeStatus %></td>
		<th class="label" style="color:red">Desconto(%):</th>
		<td class="textos" style="color:red">&nbsp;<%=Utilitaria.formatarNumero(vlDesc,2)%></td>
	<tr>
		<th class="label" style="color:red">Custo de Desl.:</th>
		<td class="textos" style="color:red">&nbsp;<%=Utilitaria.formatarDinheiro(vlFrete) %></td>
		<th class="label" style="color:red">Total Serv.(R$):</th>
		<td class="textos" style="color:red">&nbsp;<%=Utilitaria.formatarDinheiro(vlServ) %></td>
	</tr>
	<tr>
		<th class="label" style="color:red">Valor Total(R$):</th>
		<td class="textos" style="color:red">&nbsp;<%=Utilitaria.formatarDinheiro(valorTotal) %></td>
	</tr>
</table>
<%
List listPedido;
PedidoSaidaDAO daoPedidoSaida = new PedidoSaidaDAO(conn);
PedidoSaida pedidoSaida = null;
listPedido = daoPedidoSaida.listarPedidoOrdemServico(Integer.parseInt(idOrdemServico), idLoja);
int contPedido = 0;
String linkPedido = "";
for ( Iterator itPedido = listPedido.iterator(); itPedido.hasNext(); ) {
	pedidoSaida = (PedidoSaida) itPedido.next();
	linkPedido = "editarFormPedido.jsp?idPedidoSaida="+pedidoSaida.getIdPedidoSaida()+"&acao=atu";
	contPedido++;
	
	
	
	
%>
<p align="left"><a class="button" href="formAddObjetosOS.jsp?acao=<%=acao%>&idOrdemServico=<%=idOrdemServico%>" style="font-size: 14px; float: left;">Atualizar</a>
<p align="right"><a target="blank" href="comercial/editarFormPedido.jsp?idPedidoSaida=<%=pedidoSaida.getIdPedidoSaida()%>&acao=atu"   style="font-size: 14px; float: right;" span style="padding-left:20px"><%="|"+"Pedido nº:"+pedidoSaida.getIdPedidoSaida()+"|"%></a>
<%} %>
<br>
<br>
<p align="right"><a class="grid" target="blank" href="comercial/formPedido.jsp?acao=inc&idOrdemServico=<%=idOrdemServico%>"   style="font-size: 14px; float: right;">Adic. Ped. Produto</a>
<br>
<br>
<hr>
<%--<p align="right"><a class="grid" target="blank" href="listarListaTarefa.jsp"   style="font-size: 14px; float: right;"><%="|" +" Cadastrar Tarefas " + " | "%></a> --%>
<p align="right"><a class="grid" target="blank" href="listarListaServico.jsp"   style="font-size: 14px; float: right;"><%="|" + " Cadastrar Serviços " + " | " %></a>
<p align="right"><a class="grid" target="blank" href="listarListaObjeto.jsp"   style="font-size: 14px; float: right;"><%="|" + " Cadastrar Veículos   " + " | " %></a>
<br>
<br>
<hr>
<br>
<table border="0" width="100%">
	<tr>
		<th class="label" colspan="8">Resumo Pedidos</th>
	</tr>
	<tr>
		<th class="grid">&nbsp;</th>
		<th class="grid">Num. Ped.</th>
		<th class="grid">Dt. Pedido</th>
		<th class="grid">Responsável</th>
		<th class="grid">Quant. Produtos</th>
		<th class="grid">Valor Ped. (R$)</th>
	</tr>
<%
List listPedidoResumo;
PedidoSaidaDAO daoPedidoSaidaResumo = new PedidoSaidaDAO(conn);
PedidoSaida pedidoSaidaResumo = null;
listPedidoResumo = daoPedidoSaidaResumo.listarPedidoOrdemServico(Integer.parseInt(idOrdemServico), idLoja);
int contPedidoResumo = 0;
int quantItens = 0;
float totalPedidoResumo = 0;
for ( Iterator itPedidoResumo = listPedido.iterator(); itPedidoResumo.hasNext(); ) {
	pedidoSaidaResumo = (PedidoSaida) itPedidoResumo.next();
	ColaboradorDAO daoColaboradorResumo = new ColaboradorDAO(conn);
	Colaborador colaboradorResumo = daoColaboradorResumo.procurarColaborador(pedidoSaidaResumo.getIdColaborador());
	quantItens = daoPedidoSaidaResumo.getQuantItensPedido(pedidoSaidaResumo.getIdPedidoSaida());
	contPedidoResumo++;
	totalPedidoResumo += pedidoSaidaResumo.getVlPed();
	EntregaDAO daoEntregaPedido = new EntregaDAO(conn);
	Entrega entregaPedido = daoEntregaPedido.procurarEntrega(pedidoSaidaResumo.getIdEntrega());
	totalTaxaEntregaPedidos += entregaPedido.getTxEntrega();
	
%>
	<tr>
                  <td class="grid" width="3%"><%=contPedidoResumo %></td>
                  <td class="grid" width="10%"><%=pedidoSaidaResumo.getIdPedidoSaida()%></td>
		<td class="grid" width="20%"><%=ConverteDate.dateToString(pedidoSaidaResumo.getDtPed()) %></td>
		<td class="grid" width="20%"><%=colaboradorResumo.getApelido() %></td>
		<td class="grid" width="20%"><%=Utilitaria.formatarNumero(quantItens, 0) %></td>
		<td class="grid" width="20%"><%=Utilitaria.formatarNumero(pedidoSaidaResumo.getVlPed(), 2) %></td>
	</tr>
<%} %>
</table>
<table border=0 align="right">
	<tr>
		<th class="grid" width="100px">Total Pedidos</th>
		<td width="50px"><input type="text" id="valorServicos" name="valores" value="<%=Utilitaria.formatarNumero(totalPedidoResumo+totalTaxaEntregaPedidos, 2) %>" size="10px"/></td>
	</tr>
</table>
<br>
<br>
<hr>
<%// Objetos - Campos ConfigServiços

//CAMPOS de CONFIG SERVICO
daoConfig = new ConfigServicoDAO(conn);
configServico = new ConfigServico();
configServico = daoConfig.procurarConfigServico(" WHERE idLoja = "+idLoja);
%>
<p align="right"><a class="button" href="javascript:abrirPopup('consultarOrdemServicoObjeto.jsp?acao=inc&idOrdemServico=<%=idOrdemServico %>&idLoja=<%=idLoja %>');"   style="font-size: 14px; float: right;">Adicionar Veículos</a>
<table border="0" width="100%">
	<tr>
		<th class="label" colspan="8">Veículos</th>
	</tr>
	<tr>
		<th class="grid">&nbsp;</th>
		<%if(!configServico.getDsCmpOb1().equalsIgnoreCase("")){ %>
			<th class="grid"><%=configServico.getDsCmpOb1() %></th>
		<%} %>
		<%if(!configServico.getDsCmpOb2().equalsIgnoreCase("")){ %>
			<th class="grid"><%=configServico.getDsCmpOb2() %></th>
		<%} %>
		<%if(!configServico.getDsCmpOb3().equalsIgnoreCase("")){ %>
			<th class="grid"><%=configServico.getDsCmpOb3() %></th>
		<%} %>
		<%if(!configServico.getDsCmpOb4().equalsIgnoreCase("")){ %>
			<th class="grid"><%=configServico.getDsCmpOb4() %></th>
		<%} %>
		<th class="grid">Data da Garantia</th>
		<th class="grid">Controle</th>
		<th class="grid" width="7%">Remover</th>
	</tr>
	
<%  
//seleciona todos os registros do banco de dados
List listObjeto;
daoObjeto = new OrdemServicoObjetoDAO(conn);
clausulaObj = clausulaObj +" WHERE idOrdemServico = "+idOrdemServico;
listObjeto = daoObjeto.listar(clausulaObj);
int cont = 0;

for ( Iterator itObjeto = listObjeto.iterator(); itObjeto.hasNext(); ) {
	ordemServicoObjeto = (OrdemServicoObjeto) itObjeto.next();
	cont++;
%>
	<tr>
		<td class="grid" width="3%"><%=cont %></td>
		<%if(!configServico.getDsCmpOb1().equalsIgnoreCase("")){ %>
				<td class="grid" width="22%">
				
				<!-- FUNÇÃO PARA MOSTRAR TODOS SERVIÇOS DE UM MESMO OBJETO -->
					<a href="formAddObjetosOS.jsp?acao=<%=acao%>&idOrdemServico=<%=idOrdemServico%>&idOrdemServicoObjeto=<%=ordemServicoObjeto.getIdOrdemServicoObjeto()%>"><%=ordemServicoObjeto.getCampo1() %></a>
					
				<!-- FUNÇÃO PARA PERMITIR EDITAR UMA 'ordemServicoObjeto' -->
					<%//href="javascript:abrirPopup('formOrdemServicoObjeto.jsp?acao=<%=acao>&idOrdemServico=<%=idOrdemServico >&idOrdemServicoObjeto=<%=ordemServicoObjeto.getIdOrdemServicoObjeto() >');" ></a> %>
				</td>
		<%} %>
		<%if(!configServico.getDsCmpOb2().equalsIgnoreCase("")){ %>
			<td class="grid" width="20%"><%=ordemServicoObjeto.getCampo2() %></td>
		<%} %>
		<%if(!configServico.getDsCmpOb3().equalsIgnoreCase("")){ %>
			<td class="grid" width="20%"><%=ordemServicoObjeto.getCampo3() %></td>			
		<%} %>
		<%if(!configServico.getDsCmpOb4().equalsIgnoreCase("")){ %>
			<td class="grid" width="20%"><%=ordemServicoObjeto.getCampo4() %></td>
		<%} %>
		<td class="grid"><%if(ordemServicoObjeto.getDtGarantia() != null){ %><%=ConverteDate.dateToString(ordemServicoObjeto.getDtGarantia()) %><%} else { %> - <%} %></td>
		<td class="grid"><%=ordemServicoObjeto.getNrControle() %></td>
		
		<!--  ELABORAR FUNÇÃO PARA EXCLUSÃO DO OBJETO QUE JÁ POSSUA UM SERVIÇO ASSOCIADO A ELE -->
		<td class = "grid" width="3%"><center><a href="javascript: confirmaExcluirObj(<%=cont%>,<%=ordemServicoObjeto.getIdOrdemServicoObjeto() %>);"><img border = "0" src="../images/delete.gif"></a></center></td>		
	</tr>
	

<!-- ADICIONAR SERVIÇO -->

<% } // fim do objeto %>
</table>
<hr>
<!--  SERVIÇOS -->
<!--  MOSTRAR TODOS OS SERVIÇOS -->
<%--<p align="left"><a class="button" href="formAddObjetosOS.jsp?acao=<%=acao%>&idOrdemServico=<%=idOrdemServico%>" style="font-size: 14px; float: left;">Todos Serviços</a> --%>
<!-- ADICIONAR SERVIÇO -->
<p align="right"><a class="button" href="javascript:abrirPopup('consultarOrdemServicoItem.jsp?acao=inc&idOrdemServico=<%=idOrdemServico %>&idLoja=<%=idLoja %>');"  style="font-size: 14px; float: right;">Adicionar Serviço</a>
<table border="0" width="100%">
	<tr>
		<th class="label" colspan="8">Serviços</th>
	</tr>
	<tr>
		<th class="grid">&nbsp;</th>
		<th class="grid">Descrição</th>
		<th class="grid">Desc. Serviço</th>
		<th class="grid">Valor (Unitário) (R$)</th>
		<th class="grid">Quantidade</th>
		<th class="grid">Desconto (%)</th>
		<th class="grid">Valor (R$)</th>
		<th class="grid">Remover</th>
	</tr>
<%
ordemServicoItem = new OrdemServicoItem();
daoItem = new OrdemServicoItemDAO(conn);
List <OrdemServicoItem> listItem = null;
String id[] = null;
for ( Iterator itObjetoItem = listObjeto.iterator(); itObjetoItem.hasNext(); ) {
	ordemServicoObjeto = (OrdemServicoObjeto) itObjetoItem.next();
	//Montar Clausula Item  -->  Se for NULL mostrará todos os serviços
	
clausulaItem = " WHERE idOrdemServicoObjeto = "+ordemServicoObjeto.getIdOrdemServicoObjeto();
daoItem = new OrdemServicoItemDAO(conn);
listItem = daoItem.listar(clausulaItem);
int cont2 = 0;
// Associar Objeto com o serviço
String nomeObjeto = "";
String nomeServico = "";

for ( Iterator itServico = listItem.iterator(); itServico.hasNext(); ) {
	ordemServicoItem = (OrdemServicoItem) itServico.next();
	cont2++;
	
	//NOME DO OBJETO
	servicoObjeto = new OrdemServicoObjeto();
	servicoObjeto  = daoObjeto.procurarOrdemServicoObjeto(" WHERE idOrdemServicoObjeto = "+ordemServicoItem.getIdOrdemServicoObjeto());
	nomeObjeto = servicoObjeto.getCampo1();
	
	//NOME SERVIÇO
	listaServico = new ListaServico();
	daoListaServico = new ListaServicoDAO(conn);
	listaServico = daoListaServico.procurarListaServico(" WHERE idListaServico = "+ordemServicoItem.getIdListaServico());
	nomeServico = listaServico.getDsListaServico();
	totalServicos += ordemServicoItem.getValor();
%>
	<tr>
		<td class="grid" width="3%"><%=cont2 %></td>
		<%--<td class="grid" width="20%"><%=nomeObjeto %></td> --%>
		<td class="grid" width="20%"><%=ordemServicoItem.getDsCompServico() %></td>
		<td class="grid" width="20%"><a href="javascript:abrirPopup('formOrdemServicoItem.jsp?acao=atu&idOrdemServicoItem=<%=ordemServicoItem.getIdOrdemServicoItem()%>');" ><%=nomeServico %></a></td>
		<td class="grid" width="20%"><%=Utilitaria.formatarNumero(ordemServicoItem.getVlUni(), 2) %></td>
		<td class="grid" width="20%"><%=Utilitaria.formatarNumero(ordemServicoItem.getQuant(), 0) %></td>
		<td class="grid" width="20%"><%=Utilitaria.formatarNumero(ordemServicoItem.getpDesc(), 2) %></td>
		<td class="grid" width="20%"><%=Utilitaria.formatarNumero(ordemServicoItem.getValor(), 2) %></td>
		<td class="grid" width="20%"><a href="javascript:confirmaExcluirItem(<%=cont2%>,<%=ordemServicoItem.getIdOrdemServicoItem() %>);"><img border = "0" src="../images/delete.gif"></a></td>		
	</tr>
<%} %>
<%} %>
</table>
<table border=0 align="right">
	<tr>
		<th class="grid" width="100px">Total Serviços</th>
		<td width="50px"><input type="text" id="valorServicos" name="valores" value="<%=Utilitaria.formatarNumero(totalServicos, 2) %>" size="10px"/></td>
	</tr>
</table>


</form>

<%@include file="../fimConexao.jsp"%>
</body>
</html>