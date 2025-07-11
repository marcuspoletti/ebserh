<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.Recibo" %>
<%@ page import="afero.persistence.ReciboDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Date" %>
<%@ page import="afero.util.ConverteDate" %>
<%@ page import="afero.util.Utilitaria" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function confirmaExcluir(cont, id) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarRecibo.jsp?acao=exc&idRecibo=' + id;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.numRecibo.value = '';
  document.all.favorecido.value = ''; //não está limpando
  document.forms[0].submit();
}  
</script>
<script src="../js/common.js"/></script>
<%
ReciboDAO dao;
ConverteDate conDate = new ConverteDate();
String numRecibo = "0";
String clausula = "";
String acao = request.getParameter("acao");
if (acao == null) acao = "listar";

String idRecibo = "0";
int idLoja = 0;
int cdEntidade = 0;
String favorecido = "";
double valor = 0;
String referente = "";
String observacao = "";
String emitente = "";
String endereco = "";
String cpfCnpj = "";
String cidade = "";
String dtEmissao = null;
String usuario = "";

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
    idRecibo = request.getParameter("idRecibo");
    idLoja = Integer.parseInt(request.getParameter("idLoja"));
    cdEntidade = Integer.parseInt(request.getParameter("cdEntidade"));
    favorecido = request.getParameter("favorecido");
    valor = Double.parseDouble(request.getParameter("valor"));
    referente = request.getParameter("referente");
    observacao = request.getParameter("observacao");
    emitente = request.getParameter("emitente");
    endereco = request.getParameter("endereco");
    cpfCnpj = request.getParameter("cpfCnpj");
    cidade = request.getParameter("cidade");
    dtEmissao = request.getParameter("dtEmissao");
    usuario = request.getParameter("usuario");
  if (idRecibo == null) idRecibo = "";
  if (request.getParameter("idLoja") == null)idLoja=0;
  if (request.getParameter("cdEntidade") == null)cdEntidade=0;
  if (favorecido == null) favorecido = "";
  if (request.getParameter("valor") == null)valor = 0;
  if (referente == null) referente = "";
  if (observacao == null) observacao = "";
  if (emitente == null) emitente = "";
  if (endereco == null) endereco = "";
  if (cpfCnpj == null) cpfCnpj = "";
  if (cidade == null) cidade = "";
  if (dtEmissao == null) dtEmissao = "";
  if (usuario == null) usuario = "";
  
  usuario = (String)session.getAttribute("Login");
  Recibo recibo = new Recibo();

	try {
	  if (!acao.equalsIgnoreCase("inc")){
		  recibo.setIdRecibo(Integer.parseInt(idRecibo));
	  }
	  recibo.setCdEntidade(cdEntidade);
	  recibo.setCidade(cidade);
	  recibo.setCpfCnpj(cpfCnpj);
	  recibo.setDtEmissao(ConverteDate.stringToDate(dtEmissao));
	  recibo.setEmitente(emitente);
	  recibo.setEndereco(endereco);
	  recibo.setFavorecido(favorecido);
	  recibo.setValor(valor);
	  recibo.setObservacao(observacao);
	  recibo.setUsuario(usuario);
	  recibo.setReferente(referente);
	  recibo.setUsuario(usuario);
	  recibo.setIdLoja(idLoja);
	  recibo.setCdEntidade(cdEntidade);
	  
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}

  dao = new ReciboDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {
	  //inclui no banco de dados
  	dao.incluir(recibo);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
	  dao.atualizar(recibo);

  } else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  dao.excluir(recibo);
  }
} else {

 if (!acao.equalsIgnoreCase("voltar")) {
     if(request.getParameter("numRecibo") != null){
    	 if(request.getParameter("numRecibo") != ""){
    		numRecibo  = request.getParameter("numRecibo");
    	 }
     }else{
    	 numRecibo = "0"; 
     }
    favorecido = request.getParameter("favorecido");
    if (favorecido == null) favorecido = "";
  }

  if (numRecibo != null){
    clausula = " WHERE r.idRecibo = "+Integer.parseInt(numRecibo);
  } 
  if (!favorecido.isEmpty()) {
    if (clausula.isEmpty()) {
      clausula = " WHERE r.favorecido like '"+favorecido+"%'";
    } else {
      clausula = clausula+" AND r.favorecido like '"+favorecido+"%'";
    }
  }
}

//seleciona todos os registros do banco de dados
List list;
dao = new ReciboDAO(conn);
clausula = clausula+" ORDER BY r.favorecido ";
list = dao.listarRecibo(clausula);

int cont = 0;
%>
<h1 class="cabecalho_pagina">Listar Recibo</h1>

<hr>
<body onload="document.forms[0].elements[0].focus();" >
<form action="listarRecibo.jsp">
<table colspan="2">
  <tr>
    <th class='label'>Número do Recibo</th>
    <td><input type="text" name="numRecibo" <%if (!idRecibo.equalsIgnoreCase("0")) { %>value="<%=idRecibo %>"<% }%>  size="40" maxlength="40"></td>
    <td><input class="button" type="button" value="Localizar" onClick="javascript: localizar();" /></td>
    <td><input class="button" type="button" value="Nova pesquisa" onClick="javascript: novaPesquisa();" /></td>
  </tr>
  <tr>
    <th class="label">Favorecido</th>
    <td><input type="text" name="favorecido" value="<%=favorecido %>"size="40" maxlength="40"></td>
     
  </tr>
</table>
<hr>

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr>
      <th class="grid">&nbsp;</th>
      <th class="grid"><center>Recibo</center></th>
      <th class="grid">Favorecido</th>
      <th class="grid">Referente</th>
      <th class="grid">Velor (R$)</th>
      <th class="grid">Excluir</th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	Recibo recibo = (Recibo) it.next();
	cont++;

%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid"><center><a href="formRecibo.jsp?acao=atu&idRecibo=<%=recibo.getIdRecibo()%>"><%=recibo.getIdRecibo()%></a></center></td>
      <td class = "grid" width="5%"><center><%=recibo.getFavorecido()%></center></td>
      <td class = "grid" width="5%"><center><%=recibo.getReferente()%></center></td>
      <td class = "grid" width="5%"><center><%=Utilitaria.formatarNumero(recibo.getValor(), 2).toString()%></center></td>
     <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=recibo.getIdRecibo()%>);"><img border = "0" src="../images/delete.gif"></a></center></td> -->
  </tr>
<%
}
%>   
</table>
</form>
<%@include file="../fimConexao.jsp"%>