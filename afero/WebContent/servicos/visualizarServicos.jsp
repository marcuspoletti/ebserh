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
<hr><% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<form method="post" action="visualizarServicos.jsp?acao=<%=acao%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" id="idOrdemServico" name="idOrdemServico" value="<%=idOrdemServico%>"/>
<input type="hidden" id="idOrdemServicoObjeto" name="idOrdemServicoObjeto" value="<%=idOrdemServicoObj %>"/>
<iframe width=174 height=189 name="gToday:normal:"../js/calendar/agenda.js"
            id="gToday:normal:"../js/calendar/agenda.js" src="../js/calendar/ipopeng.htm"
            scrolling="no" frameborder="0" style="visibility:visible; z-index:999; 
    position:absolute; top:-500px; left:-500px;">
</iframe>

<%
List listObjeto;
daoObjeto = new OrdemServicoObjetoDAO(conn);
clausulaObj = clausulaObj +" WHERE idOrdemServico = "+idOrdemServico;
listObjeto = daoObjeto.listar(clausulaObj);

%>

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
		<td class="grid" width="20%"><%=ordemServicoItem.getDsCompServico() %></td>
		<td class="grid" width="20%"><%=nomeServico %></td>
		<td class="grid" width="20%"><%=Utilitaria.formatarNumero(ordemServicoItem.getVlUni(), 2) %></td>
		<td class="grid" width="20%"><%=Utilitaria.formatarNumero(ordemServicoItem.getQuant(), 0) %></td>
		<td class="grid" width="20%"><%=Utilitaria.formatarNumero(ordemServicoItem.getpDesc(), 2) %></td>
		<td class="grid" width="20%"><%=Utilitaria.formatarNumero(ordemServicoItem.getValor(), 2) %></td>
				
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
<br>
<br>
<table border="0" width="100%">
    <tr>
    <td align="right">
        <input type="button" value="Imprimir" class="botao" onclick="print();">
    </td>
    </tr>

</table>

<%@include file="../fimConexao.jsp"%>
</body>
</html>