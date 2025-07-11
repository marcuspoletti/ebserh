<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.PedidoSaidaSub"%>
<%@page import="afero.model.Mesa"%>
<%@page import="afero.model.Entrega"%>
<%@page import="afero.model.Colaborador"%>
<%@page import="afero.model.Loja"%>
<%@page import="afero.persistence.LojaDAO"%>
<%@page import="afero.persistence.MesaDAO"%>
<%@page import="afero.persistence.EntregaDAO"%>
<%@page import="afero.persistence.PedidoSaidaSubDAO"%>
<%@page import="afero.persistence.ColaboradorDAO"%>
<%@ page import="afero.util.ConverteDate" %>
<%@ page import="afero.util.Utilitaria" %>
<%@include file="../../seguranca.jsp"%>
<%@include file="../../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../../css/afero.css" />
<script src="../../js/common.js"/></script>
<script>
function salvar() {
  	document.forms[0].submit();
}
function cancelar() {
  document.forms[0].action="formPedido.jsp";
  document.forms[0].submit();
}
function redirecionar(id) {
  document.forms[0].action='exibirPedido.jsp?idPedidoSaida='+id;
  document.forms[0].submit();

}
</script>
</head>
<%
PedidoSaidaSubDAO daoPedidoSaida=null;
MesaDAO daoMesa = null;
String dsMesa = request.getParameter("dsMesa");
if(dsMesa == null)dsMesa = "";
Loja loja = null;
Colaborador colaborador = null;
Entrega entrega = null;
double vlPed = 0;
String acao  = request.getParameter("acao");
String idMesa = request.getParameter("idMesa");
if(idMesa == null){
  idMesa="0";
}

String statusConsulta = request.getParameter("statusConsulta");
if (statusConsulta == null)statusConsulta="A";
String idPedidoSaida = request.getParameter("idPedidoSaida");
int numPedido = Integer.parseInt(idPedidoSaida);
String idLoja = request.getParameter("idLoja");
LojaDAO daoLoja = new LojaDAO(conn);
loja = daoLoja.procurarLoja(Integer.parseInt(idLoja));
String dsLoja = loja.getApelido() +  " / "  + loja.getRazaoSocial();
String cdEntidade = request.getParameter("cdEntidade");
if (cdEntidade == null) cdEntidade="1";
String idEntrega = request.getParameter("idEntrega");
String cdCondPagto = request.getParameter("cdCondPagto");
if(cdCondPagto == null)cdCondPagto="1";
String impPedido = request.getParameter("impPedido");
if(impPedido == null)impPedido = "N";
EntregaDAO daoEntrega = new EntregaDAO(conn);
entrega = daoEntrega.procurarEntrega(Integer.parseInt(idEntrega));
String dsEntrega = entrega.getDsEntrega();
//float txEntrega = entrega.getTxEntrega();
//float txEntrega = entrega.getTxEntrega();
String idColaborador = request.getParameter("idColaborador");
ColaboradorDAO daoColaborador = new ColaboradorDAO(conn);
colaborador = daoColaborador.procurarColaborador(Integer.parseInt(idColaborador));
String dsColaborador = colaborador.getApelido() + " / " + colaborador.getNome(); 
String observacao = request.getParameter("observacao");
if (observacao == null) observacao="";
String anotacao = request.getParameter("anotacao");
if (anotacao == null) anotacao="";
String status = request.getParameter("status");
if (status == null) status = "P";
String operacao = request.getParameter("operacao");
if (operacao == null) operacao = "S";
String statusPag = request.getParameter("statusPag");
if(statusPag == null)statusPag="N";
String tipoPedido = request.getParameter("tipoPedido");
if(tipoPedido == null)tipoPedido="PZ";
String dtEntrega = request.getParameter("dtEntrega");
String hrEntrega = request.getParameter("hrEntrega");
String usuario = request.getParameter("usuario");
if (usuario == null) usuario = "";
String dtPed = request.getParameter("dtPed");
String pessoaResponsavel = request.getParameter("pessoaResponsavel");
if (dtPed == null) dtPed="";
String quantPessoas = request.getParameter("quantPessoas");
PedidoSaidaSub pedidoSaida = new PedidoSaidaSub();
pedidoSaida.setIdLoja(Integer.parseInt(idLoja));
pedidoSaida.setQuantPessoa(Integer.parseInt(quantPessoas));
pedidoSaida.setCdEntidade(Integer.parseInt(cdEntidade));
pedidoSaida.setIdEntrega(Integer.parseInt(idEntrega));
pedidoSaida.setIdColaborador(Integer.parseInt(idColaborador));
pedidoSaida.setObservacao(observacao);
pedidoSaida.setCdCondPagto(Integer.parseInt(cdCondPagto));
pedidoSaida.setAnotacao(anotacao);
pedidoSaida.setStatus(status);
pedidoSaida.setUsuario(usuario);
pedidoSaida.setDtEntrega(ConverteDate.stringToDate(dtEntrega));
pedidoSaida.setHrEntrega(hrEntrega);
pedidoSaida.setPessoaResponsavel(pessoaResponsavel);
pedidoSaida.setOperacao(operacao);
pedidoSaida.setImpPedido(impPedido);
pedidoSaida.setStatusPag(statusPag);
pedidoSaida.setTipoPedido(tipoPedido);
//pedidoSaida.setVlFrete(txEntrega);
daoPedidoSaida = new PedidoSaidaSubDAO(conn);
daoMesa = new MesaDAO(conn);
if (acao.equalsIgnoreCase("inc")) {
	daoPedidoSaida.incluir(pedidoSaida);
	numPedido = daoPedidoSaida.idPedidoSaida();
	idPedidoSaida = String.valueOf(numPedido);
	daoPedidoSaida.atualizarStatusPag(Integer.parseInt(idPedidoSaida), pedidoSaida.getStatusPag());
	daoPedidoSaida.atualizarTipoPedido(Integer.parseInt(idPedidoSaida), pedidoSaida.getTipoPedido());
	daoPedidoSaida.atualizarQuantPessoas(Integer.parseInt(idPedidoSaida), pedidoSaida.getQuantPessoa());
	if(!idMesa.equalsIgnoreCase("0")){
		daoPedidoSaida.atualizarMesaPedido(Integer.parseInt(idPedidoSaida), Integer.parseInt(idMesa));	
		daoMesa.atualizarStatus(Integer.parseInt(idMesa), "A");
		Mesa mesaIn = daoMesa.procurarMesa(Integer.parseInt(idMesa));
		dsMesa = mesaIn.getDsMesa();
	}
	acao="listar";
} else if (acao.equalsIgnoreCase("atu")) {
	pedidoSaida.setIdPedidoSaida(Integer.parseInt(idPedidoSaida));
	daoPedidoSaida.mostrarVlFrete(pedidoSaida.getIdPedidoSaida());
	pedidoSaida.setVlFrete(daoPedidoSaida.mostrarVlFrete(pedidoSaida.getIdPedidoSaida()));
	daoPedidoSaida.atualizarCabecalho(pedidoSaida);
	daoPedidoSaida.atualizarQuantPessoas(pedidoSaida.getIdPedidoSaida(), pedidoSaida.getQuantPessoa());
	numPedido = Integer.parseInt(idPedidoSaida);
	Mesa mesaAtu = daoMesa.procurarMesa(Integer.parseInt(idMesa));
	dsMesa = mesaAtu.getDsMesa();
	acao="listar";
}
%>
<body onload="document.forms[0].elements[2].focus();" >
<hr>
<table border="0" width="100%">
   <tr>
    <th class="label" align="left">Número do Pedido</th>
    <td align="left"><input disabled type="text" name="numPedido" value="<%=numPedido%>" size="5" maxlength="5"></td>
     <th class="label" align="left">Mesa</th>
    <td align="left"><input disabled type="text" name="dsMesa" value="<%=dsMesa%>" size="20" maxlength="20"></td>
  </tr>
</table><hr>
<table width="100%" border="0">
<tr>
 <th class="grid">Cadastrar Itens</th>
</tr>
<tr>
 <td><%@include file="../../WEB-INF/jspf/grids/itensPedidoSubItemPizzariaMesa.jspf"%>
 </td>
 </tr>
 <tr>
 <th class="grid">Itens Selecionados</th>
</tr>
<tr>
 <td>
  <iframe src="itensPedidoItemSubItem.jsp?idPedidoSaida=<%=idPedidoSaida%>&idMesa=<%=idMesa%>" src2="" name="itensPedidoItemSubItem" width="100%" height="100%" scrolling="auto" align="top" frameborder="0" hspace="0" vspace="0" marginheight="0" marginwidth="0"></iframe>
 </td>
 </tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
    <br>
	<td><input class="button" type="button" value="Finalizar Pedido" onClick="javascript: redirecionar(<%=idPedidoSaida%>);" />
</tr>
</table>
<%@include file="../../fimConexao.jsp"%>
