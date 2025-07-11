<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.ChegueEmitido"%>
<%@ page import="afero.model.DuplicataParcela"%>
<%@ page import="afero.model.Colaborador"%>
<%@ page import="afero.model.Entidade"%>
<%@ page import="afero.model.Loja"%>
<%@ page import="afero.model.Conta"%>
<%@ page import="afero.persistence.ChegueEmitidoDAO"%>
<%@ page import="afero.persistence.DuplicataParcelaDAO"%>
<%@ page import="afero.persistence.ColaboradorDAO"%>
<%@ page import="afero.persistence.EntidadeDAO"%>
<%@ page import="afero.persistence.LojaDAO"%>
<%@ page import="afero.persistence.ContaDAO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.Date" %>
<%@ page import="afero.util.ConverteDate"%>
<%@ page import="afero.util.Utilitaria"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/>"</script>

<script>
function confirmaExcluir(cont, id) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarChegueEmitido.jsp?acao=exc&idChegueEmitido=' + id;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.idLojaLocalizar.value = '';
  document.all.nmFavorecido.value = '';
  document.all.idContaLocalizar.value = '0';
  document.all.statusLocalizar[0].value = 'A';
  document.all.statusLocalizar[1].value = '';
  document.all.statusLocalizar[2].value = '';
  document.all.statusLocalizar[3].value = '';
  document.all.statusLocalizar[4].value = '';
  document.forms[0].submit();
}  
</script>

<%
String idLojaLocalizar = request.getParameter("idLojaLocalizar");
if(idLojaLocalizar == null)idLojaLocalizar="0";
String nmFavorecido = "";
String idContaLocalizar = request.getParameter("idContaLocalizar");
if(idContaLocalizar == null)idContaLocalizar="0";
String statusLocalizar = "A";

ChegueEmitidoDAO dao;
ChegueEmitidoDAO daoExclusao;
ConverteDate conDate = new ConverteDate();
ColaboradorDAO daoColaborador = new ColaboradorDAO(conn);
String idUsuario = (String)session.getAttribute("idUsuario");
Colaborador colaborador = daoColaborador.procurarColaboradorUsuario(Integer.parseInt(idUsuario));
if (idLojaLocalizar.isEmpty() || idLojaLocalizar.equals("0")) idLojaLocalizar = "".valueOf(colaborador.getIdLoja());
String mensagem = request.getParameter("mensagem");
if(mensagem == null)mensagem = "";
String acao = request.getParameter("acao");
if (acao == null) acao = "listar";

String idChegueEmitido = "";
String idLoja = "";
String idConta = "";
String nrChegue = "";
String valor = "";
String dtEmissao = "";
String dtVenc = "";
String favorecido = "";
String cpfCnpj = "";
String dtPagto = "";
String idContaMovto = "";
String status = "A";
String dtCad = "";
String dtMod = "";
String usuario = (String) session.getAttribute("Login");
String clausula = "";
ConverteDate converte = new ConverteDate();
ChegueEmitidoDAO daoChegueEmitido = new ChegueEmitidoDAO(conn);

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
	
	idChegueEmitido = request.getParameter("idChegueEmitido");
	idLoja = request.getParameter("idLoja");
	idConta = request.getParameter("idConta");
	nrChegue = request.getParameter("nrChegue");
	valor = request.getParameter("valor");
	dtEmissao = request.getParameter("dtEmissao");
	dtVenc = request.getParameter("dtVenc");
	favorecido = request.getParameter("favorecido");
	cpfCnpj = request.getParameter("cpfCnpj");
	dtPagto = request.getParameter("dtPagto");
	idContaMovto = request.getParameter("idContaMovto");
	status = request.getParameter("status");
	dtCad = request.getParameter("dtCad");
	dtMod = request.getParameter("dtMod");
	usuario = (String) session.getAttribute("Login");

	if(acao == null) acao = "inc";
	if(idChegueEmitido == null) idChegueEmitido = "0";
	if(idLoja == null)idLoja = "0";
	if(idConta == null)idConta = "0";
	if(nrChegue == null)nrChegue="0";
	if(dtEmissao == null)dtEmissao = "";
	if(dtVenc == null)dtVenc = "";
	if(favorecido == null)favorecido = "";
	if(cpfCnpj == null)cpfCnpj = "";
	if(dtPagto == null)dtPagto = "";
	if(idContaMovto == null)idContaMovto="0";
	if(valor == null)valor = "0";
	if(status == null)status="A";
	if(dtCad == null)dtCad = "";
	if(dtMod == null)dtMod = "";
	
	ChegueEmitido chegueEmitido = new ChegueEmitido();
  
	try {
	  if (!acao.equalsIgnoreCase("inc")){
		  chegueEmitido.setIdChegueEmitido(Utilitaria.toNumber(idChegueEmitido).intValue());
	  }
	  
	  chegueEmitido.setIdLoja(Utilitaria.toNumber(idLoja).intValue());
	  chegueEmitido.setIdConta(Utilitaria.toNumber(idConta).intValue());
	  chegueEmitido.setNrChegue(Utilitaria.toNumber(nrChegue).intValue());
	  chegueEmitido.setFavorecido(favorecido);
	  chegueEmitido.setIdContaMovto(Utilitaria.toNumber(idContaMovto).intValue());
	  chegueEmitido.setCpfCnpj(cpfCnpj);
	  chegueEmitido.setStatus(status);
      if(dtEmissao != ""){
    	  chegueEmitido.setDtEmissao(ConverteDate.stringToDate(dtEmissao));  
      }
      if(dtVenc != ""){
    	  chegueEmitido.setDtVenc(ConverteDate.stringToDate(dtVenc));   
      }
      if(dtPagto != ""){
    	  chegueEmitido.setDtPagto(ConverteDate.stringToDate(dtPagto)); 
      }
      chegueEmitido.setValor(Utilitaria.toNumber(valor).doubleValue());
      chegueEmitido.setUsuario(usuario);
      if (!acao.equalsIgnoreCase("exc")){
    	  chegueEmitido.setIdChegueEmitido(Utilitaria.toNumber(idChegueEmitido).intValue());
      }
      
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}


  dao = new ChegueEmitidoDAO(conn);
  daoExclusao = new ChegueEmitidoDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {  
	  //inclui no banco de dados
  	dao.incluir(chegueEmitido);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
    	 dao.atualizar(chegueEmitido);
  }else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  dao.excluir(chegueEmitido); 
  }
} else {
 if(!acao.equalsIgnoreCase("voltar")) {
    nmFavorecido= request.getParameter("nmFavorecido");
    idContaLocalizar = request.getParameter("idContaLocalizar");
		if(idContaLocalizar == null) idContaLocalizar = "0";
    statusLocalizar = request.getParameter("statusLocalizar");
    if (statusLocalizar == null) statusLocalizar = "A";
    //idLojaLocalizar = request.getParameter("idLojaLocalizar");
		//if(idLojaLocalizar == null) idLojaLocalizar = "0";
  }
  if (nmFavorecido != null && !nmFavorecido.isEmpty()) {
    clausula = " WHERE ch.favorecido LIKE'"+nmFavorecido+"%'";
  } 
  if (!idContaLocalizar.isEmpty() && !idContaLocalizar.equals("0")) {
	  if (clausula.isEmpty()) {
	    clausula = " WHERE idConta="+idContaLocalizar;
	  } else {
	    clausula = clausula+" AND idConta="+idContaLocalizar;
	  }
	}
  if (!statusLocalizar.isEmpty()) {
	  if (clausula.isEmpty()) {
	    clausula = " WHERE status='"+statusLocalizar+"'";
	  } else {
	    clausula = clausula+" AND status='"+statusLocalizar+"'";
	  }
	}
  if (clausula.isEmpty()) {
	    clausula = " WHERE idLoja="+idLojaLocalizar;
  } else {
    clausula = clausula+" AND idLoja="+idLojaLocalizar;
  }
}

//seleciona todos os registros do banco de dados
List list;
dao = new ChegueEmitidoDAO(conn);
clausula = clausula+" order by ch.favorecido";
list = dao.listarChegueEmitido(clausula);

int cont = 0;
%>
<h1 class="cabecalho_pagina">Chegues Emitidos</h1>

|<a class="button" href="formChegueEmitido.jsp?acao=inc">Novo Cadastro</a>|<br>

<body onload="document.forms[0].elements[0].focus();" >
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<form action="listarChegueEmitido.jsp">
<table colspan="4">
  <tr>
    <th class="label">Loja</th>
    <td><select name="idLojaLocalizar" >
        <%@include file="../WEB-INF/jspf/combo/comboLoja.jspf" %></select>
        <script>comboSelect(document.forms[0].idLojaLocalizar, '<%=idLojaLocalizar%>');</script>
    </td>
    <th class="label">Conta</th>
    <td><select name="idContaLocalizar" >
        <option value='0'>Selecione...</option>
        <%@include file="../WEB-INF/jspf/combo/comboConta.jspf" %></select>
        <script>comboSelect(document.forms[0].idContaLocalizar, '<%=idContaLocalizar%>');</script>
    </td>
    <td><input class="button" type="button" value="Localizar" onClick="javascript: localizar();" /></td>
    <td><input class="button" type="button" value="Nova pesquisa" onClick="javascript: novaPesquisa();" /></td>
  </tr>
  <tr>
    <th class='label'>Favorecido</th>
    <td><input type="text" name="nmFavorecido" <%if (nmFavorecido != null) { %>value="<%=nmFavorecido %>"<% }%>  size="60" maxlength="40"></td>
    <th class="label">Status</th>
    <td class="label_radio">
      <input type="radio" class="radio" name="statusLocalizar" value="" <%= (statusLocalizar.equals("")? "checked": "") %>>Todos
      <input type="radio" class="radio" name="statusLocalizar" value="A" <%= (statusLocalizar.equals("A")? "checked": "") %>>A Pagar
      <input type="radio" class="radio" name="statusLocalizar" value="P" <%= (statusLocalizar.equals("P")? "checked": "") %>>Pago ao favorecido
      <input type="radio" class="radio" name="statusLocalizar" value="D" <%= (statusLocalizar.equals("D")? "checked": "") %>>Devolvido
      <input type="radio" class="radio" name="statusLocalizar" value="Q" <%= (statusLocalizar.equals("Q")? "checked": "") %>>Devolvido/Quitado
    </td>
  </tr>
</table>
<hr>

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr">
      <th class="grid">&nbsp;</th>
      <th class="grid"><center>Conta</center></th>
      <th class="grid"><center>Cheque</center></th>
      <th class="grid"><center>Favorecido</center></th>
      <th class="grid"><center>Emissão</center></th>
      <th class="grid"><center>Vencimento</center></th>
      <th class="grid"><center>Valor</center></th>
      <th class="grid"><center>Compesação</center></th>
      <th class="grid">Status</th>
      <th class="grid">Excluir</th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
String msgStatus = "";
Conta conta = null;
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	ChegueEmitido chegueEmitidoListar = (ChegueEmitido) it.next();
	ContaDAO daoConta = new ContaDAO(conn);
	conta = daoConta.procurarConta(chegueEmitidoListar.getIdConta());
	if (chegueEmitidoListar.getStatus().equalsIgnoreCase("A")){
		msgStatus = "A pagar";
	} else if(chegueEmitidoListar.getStatus().equalsIgnoreCase("P")) {
		msgStatus = "Pago";
	} else if(chegueEmitidoListar.getStatus().equalsIgnoreCase("D")) {
		msgStatus = "Devolvido";
	} else if(chegueEmitidoListar.getStatus().equalsIgnoreCase("Q")) {
		msgStatus = "Devolvido/Quitado";
	}
	
	cont++;

%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid"><center><%=conta.getNmConta()%></center></td>
      <%if(chegueEmitidoListar.getStatus().equalsIgnoreCase("A")){ %>
      	<td class = "grid"><center><a href="formChegueEmitido.jsp?acao=atu&idChegueEmitido=<%=chegueEmitidoListar.getIdChegueEmitido()%>"><%=chegueEmitidoListar.getNrChegue()%> </a></center></td>
      <%}else{ %>
      	<td class = "grid"><center><a href="mostrarChequeEmitido.jsp?acao=atu&idChegueEmitido=<%=chegueEmitidoListar.getIdChegueEmitido()%>"><%=chegueEmitidoListar.getNrChegue()%> </a></center></td>
      <%} %>
      <td class = "grid"><center><%=chegueEmitidoListar.getFavorecido()%></center></td>
      <%if(chegueEmitidoListar.getDtEmissao() != null){ %>
      	<td class = "grid" width="10%"><center><%=converte.dateToString(chegueEmitidoListar.getDtEmissao())%></center></td>
      <%}else{ %>
        <td class = "grid" width="10%"><center>-</center></td>
      <%} %>
      <%if(chegueEmitidoListar.getDtVenc() != null){%>
      	<td class = "grid" width="10%"><center><%=converte.dateToString(chegueEmitidoListar.getDtVenc())%></center></td>
      <%}else{ %>
        <td class = "grid" width="10%"><center>-</center></td>
      <%} %>
      <td class = "grid" width="10%"><center><%=Utilitaria.formatarNumero(chegueEmitidoListar.getValor(),2)%></center></td>
      <% if(chegueEmitidoListar.getDtPagto() != null){%>
       	<td class = "grid" width="10%"><center><%=converte.dateToString(chegueEmitidoListar.getDtPagto())%></center></td>
      <%}else{ %>
        <td class = "grid" width="10%"><center>-</center></td>
      <%} %>
      <td class = "grid" width="5%"><center><%=msgStatus%></center></td>
      <%if(chegueEmitidoListar.getStatus().equalsIgnoreCase("A")){ %>
      	<td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=chegueEmitidoListar.getIdChegueEmitido()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
      <%}else{%>
      	<td class = "grid" width="3%"><center>-</center></td>
      <%} %>
  	</tr>
<%
}
%>   
</table>
</form>
<p align="right">|<a class="button" href="formChegueEmitido.jsp?acao=inc">Novo Cadastro</a>|