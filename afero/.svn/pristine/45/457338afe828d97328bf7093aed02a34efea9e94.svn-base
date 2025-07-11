<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.OrcamentoSub"%>
<%@page import="afero.model.Entrega"%>
<%@page import="afero.model.Colaborador"%>
<%@page import="afero.model.Loja"%>
<%@page import="afero.persistence.LojaDAO"%>
<%@page import="afero.persistence.EntregaDAO"%>
<%@page import="afero.persistence.OrcamentoSubDAO"%>
<%@page import="afero.persistence.ColaboradorDAO"%>
<%@ page import="afero.util.ConverteDate" %>
<%@ page import="afero.util.Utilitaria" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/>"</script>
<script>
function salvar() {
  	document.forms[0].submit();
}
function cancelar() {
  document.forms[0].action="formOrcamento.jsp";
  document.forms[0].submit();
}
function redirecionar(id) {
  document.forms[0].action='exibirOrcamento.jsp?idOrcamento='+id;
  document.forms[0].submit();

}
</script>
</head>
<%
OrcamentoSubDAO daoOrcamento=null;
Loja loja = null;
Colaborador colaborador = null;
Entrega entrega = null;
double vlOrc = 0;
int numOrcamento = 0;
String acao  = request.getParameter("acao");
String statusConsulta = request.getParameter("statusConsulta");
if(statusConsulta == null)statusConsulta="A";
String idOrcamento = request.getParameter("idOrcamento");
numOrcamento = Integer.parseInt(idOrcamento);
String idLoja = request.getParameter("idLoja");
LojaDAO daoLoja = new LojaDAO(conn);
loja = daoLoja.procurarLoja(Integer.parseInt(idLoja));
String dsLoja = loja.getApelido() +  " / "  + loja.getRazaoSocial();
String cdEntidade = request.getParameter("cdEntidade");
if(cdEntidade == null)cdEntidade="0";
String idEntrega = request.getParameter("idEntrega");
EntregaDAO daoEntrega = new EntregaDAO (conn);
entrega = daoEntrega.procurarEntrega(Integer.parseInt(idEntrega));
String dsEntrega = entrega.getDsEntrega();
float txEntrega = entrega.getTxEntrega();
String idColaborador = request.getParameter("idColaborador");
ColaboradorDAO daoColaborador = new ColaboradorDAO(conn);
colaborador = daoColaborador.procurarColaborador(Integer.parseInt(idColaborador));
String dsColaborador = colaborador.getApelido() + " / " + colaborador.getNome();
int prazoValidade = 0;
if(request.getParameter("prazoValidade") != null){
   prazoValidade = Utilitaria.toNumber(request.getParameter("prazoValidade")).intValue();
}

String idOrdemServico = request.getParameter("idOrdemServico");
if(idOrdemServico == null)idOrdemServico = "0";
String cdCondPagto = request.getParameter("cdCondPagto");
if(cdCondPagto == null)cdCondPagto="0";
int prazoEntrega = 0;
if(request.getParameter("prazoEntrega") != null){
  prazoEntrega = Utilitaria.toNumber(request.getParameter("prazoEntrega")).intValue();	
}
int prazoGarantia = 0;
if(request.getParameter("prazoGarantia") != null){
	prazoGarantia = Utilitaria.toNumber(request.getParameter("prazoGarantia")).intValue();
}
String cmpOc1 = request.getParameter("cmpOc1");
if(cmpOc1 == null)cmpOc1="";
String cmpOc2 = request.getParameter("cmpOc2");
if(cmpOc2 == null)cmpOc2="";
String cmpOc3 = request.getParameter("cmpOc3");
if(cmpOc3 == null)cmpOc3="";
String cmpOc4 = request.getParameter("cmpOc4");
if(cmpOc4 == null)cmpOc4="";

String observacao = request.getParameter("observacao");
if(observacao == null)observacao="";
String status = request.getParameter("status");
if(status == null)status = "R";
String usuario = request.getParameter("usuario");
if(usuario == null)usuario = "";
String dtOrc = request.getParameter("dtOrc");
if(dtOrc == null)dtOrc="";
String dtEntrega = request.getParameter("dtCasamento");
String pessoaResponsavel = request.getParameter("pessoaResponsavel");
OrcamentoSub orcamento = new OrcamentoSub();
orcamento.setIdLoja(Integer.parseInt(idLoja));
orcamento.setCdEntidade(Integer.parseInt(cdEntidade));
orcamento.setIdEntrega(Integer.parseInt(idEntrega));
orcamento.setIdColaborador(Integer.parseInt(idColaborador));
orcamento.setObservacao(observacao);
orcamento.setStatus(status);
orcamento.setUsuario(usuario);
orcamento.setPrazoValidade(prazoValidade);

orcamento.setIdOrdemServico(Integer.parseInt(idOrdemServico));
orcamento.setCdCondPagto(Integer.parseInt(cdCondPagto));
orcamento.setPrazoEntrega(prazoEntrega);
orcamento.setPrazoGarantia(prazoGarantia);
orcamento.setCmpOc1(cmpOc1);
orcamento.setCmpOc2(cmpOc2);
orcamento.setCmpOc3(cmpOc3);
orcamento.setCmpOc4(cmpOc4);

orcamento.setDtEntrega(ConverteDate.stringToDate(dtEntrega));
orcamento.setPessoaResponsavel(pessoaResponsavel);
daoOrcamento = new OrcamentoSubDAO(conn);
if(acao.equalsIgnoreCase("inc")){
	daoOrcamento.incluir(orcamento);
	numOrcamento = daoOrcamento.idOrcamentoCorrente();
	idOrcamento = String.valueOf(numOrcamento);
	acao="listar";
}else if(acao.equalsIgnoreCase("atu")){
	orcamento.setIdOrcamento(Integer.parseInt(idOrcamento));
	daoOrcamento.atualizarCabecalho(orcamento);
	numOrcamento = Integer.parseInt(idOrcamento);
	acao="listar";
}
%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Orçamento </h1>
<hr>
<table border="0" width="100%">
   <tr>
    <th class="label">Número do Orçamento</th>
    <td><input disabled type="text" name="numOrcamento" value="<%=numOrcamento%>" size="5" maxlength="5"></td>
  </tr>
</table>
<table width="100%" border="0">
<tr>
 <th class="grid">Cadastrar Itens</th>
</tr>
<tr>
 <td><%@include file="../WEB-INF/jspf/grids/itensOrcamentoSub.jspf"%>
 </td>
 </tr>
 <tr>
 <th class="grid">Itens Selecionados</th>
</tr>
<tr>
 <td>
  <iframe src="itensOrcamento.jsp?idOrcamento=<%=idOrcamento%>" src2="" name="itensOrcamento" width="100%" height=200 scrolling="auto" align="top" frameborder="0" hspace="0" vspace="0" marginheight="0" marginwidth="0"></iframe>
 </td>
 </tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
	<td><input class="button" type="button" value="Finalizar Orçamento" onClick="javascript: redirecionar(<%=idOrcamento%>);" />
</tr>
<tr><td><br>
</td></tr>
</table>
<%@include file="../fimConexao.jsp"%>
</html>