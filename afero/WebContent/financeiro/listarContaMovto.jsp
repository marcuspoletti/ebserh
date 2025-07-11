<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.ContaMovto" %>
<%@ page import="afero.model.Conta"%>
<%@ page import="afero.persistence.ContaMovtoDAO" %>
<%@ page import="afero.persistence.ContaDAO"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="afero.util.Utilitaria"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="afero.util.ConverteDate" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script src="../js/common.js"/></script>
<script>
function confirmaExcluir(cont, id) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarContaMovto.jsp?acao=exc&idConta=' + id;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.idLojaLocalizar.value = '1';
  document.all.idContaLocalizar.value = '1';
  document.all.historicoLocalizar.value = '';
  document.all.statusLocalizar[0].value = '';
  document.all.statusLocalizar[1].value = '';
  document.all.statusLocalizar[2].value = '';
  document.forms[0].submit();
}  
</script>

<%
String idLojaLocalizar = request.getParameter("idLojaLocalizar");
if(idLojaLocalizar == null) idLojaLocalizar="1";
String idContaLocalizar = request.getParameter("idContaLocalizar");
if(idContaLocalizar == null) idContaLocalizar="1";
String historicoLocalizar = request.getParameter("historicoLocalizar");
if(historicoLocalizar == null) historicoLocalizar = "";
String statusLocalizar = request.getParameter("statusLocalizar");
if(statusLocalizar == null) statusLocalizar = "";
String clausula = "";
ContaMovtoDAO dao;
ContaMovtoDAO daoExclusao;
ConverteDate conDate = new ConverteDate();
ContaDAO daoConta = new ContaDAO(conn);
String idUsuario = (String)session.getAttribute("idUsuario");
//if (idLojaLocalizar.isEmpty() || idLojaLocalizar.equals("0")) idLojaLocalizar = "".valueOf(colaborador.getIdLoja());
String mensagem = request.getParameter("mensagem");
if(mensagem == null)mensagem = "";
String acao = request.getParameter("acao");
if (acao == null) acao = "listar";
String idLoja = "0";
String idContaMovto = "0";
String idConta = "0";
String dc = "C";
double valor = 0;
String formaMovto = "D";
String dtLanc = "";
String dtComp = "";
String idTransferencia = "0";
String nrDoc = "0";
String idPlanoConta = "0";
String idCentroCusto = "0";
String historico = "";
String divideValor = "N";
String idColaborador = "0";
double vlSaldoAnterior = 0;
double vlSaldoAtual = 0;
String conciliado = "N";
String status = "L";
String dtCad = "";
String dtMod = "";
ConverteDate converte = new ConverteDate();
String dtLanc1Localizar = "";
String dtLanc2Localizar = "";
String data = "";
try {
	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");      
	data = sdf.format(new Date());
} catch (NumberFormatException nfe) {
	throw new Exception("Data inválida");
} catch (Exception e) {
	throw new Exception(e.getMessage());
}


if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
	idLoja = request.getParameter("idLoja");
	if(idLoja == null)idLoja = "0";
	idContaMovto = request.getParameter("idContaMovto");
	if(idContaMovto == null)idContaMovto = "0";
	idConta = request.getParameter("idConta");
	if(idConta == null)idConta = "0";
	dc = request.getParameter("dc");
	if(dc == null)dc = "D";
	if(request.getParameter("valor")!= null){
		valor = Utilitaria.toNumber(request.getParameter("valor")).doubleValue();
	}
	formaMovto = request.getParameter("formaMovto");
	if(formaMovto == null)formaMovto = "D";
	dtLanc = request.getParameter("dtLanc");
	if(dtLanc == null)dtLanc="";
	dtComp = request.getParameter("dtComp");
	if(dtComp == null)dtComp="";
	idTransferencia = request.getParameter("idTransferencia");
	if(idTransferencia == null)idTransferencia="0";
	nrDoc = request.getParameter("nrDoc");
	if(nrDoc == null)nrDoc="0";
	idPlanoConta = request.getParameter("idPlanoConta");
	if(idPlanoConta == null)idPlanoConta="0";
	idCentroCusto = request.getParameter("idCentroCusto");
	if(idCentroCusto == null)idCentroCusto="0";
	historico = request.getParameter("historico");
	if(historico == null)historico="";
	divideValor = request.getParameter("divideValor");
	if(divideValor == null)divideValor="N";
	idColaborador = request.getParameter("idColaborador");
	if(idColaborador == null)idColaborador="0";
	if(request.getParameter("vlSaldoAnterior")!= null){
		vlSaldoAnterior = Utilitaria.toNumber(request.getParameter("vlSaldoAnterior")).doubleValue();
	}
	if(request.getParameter("vlSaldoAtual")!= null){
		vlSaldoAtual = Utilitaria.toNumber(request.getParameter("vlSaldoAtual")).doubleValue();
	}
	conciliado = request.getParameter("conciliado");
	if(conciliado == null)conciliado="N";
	status = request.getParameter("status");
	if(status == null)status="L";
	//if(usuario == null)usuario = (String)session.getAttribute("Login");
    
	
	
	ContaMovto contaMovto = new ContaMovto();
  
	try {
	  if (!acao.equalsIgnoreCase("inc")){
		  contaMovto.setIdContaMovto(Integer.parseInt(idContaMovto));
	  }
	  contaMovto.setIdConta(Integer.parseInt(idConta));
	  if (formaMovto.equals("D")) {
		  dc = "C";
	  } else {
		  dc = "D";
	  }
	  contaMovto.setDc(dc);
	  contaMovto.setValor(valor);
	  contaMovto.setFormaMovto(formaMovto);
	  if(dtLanc != ""){
		  contaMovto.setDtLanc(ConverteDate.stringToDate(dtLanc));
	  }
	  if(dtComp != ""){
		  contaMovto.setDtComp(ConverteDate.stringToDate(dtComp));
	  }
	  contaMovto.setIdTransferencia(Integer.parseInt(idTransferencia));
	  contaMovto.setNrDoc(nrDoc);
	  contaMovto.setIdPlanoConta(Integer.parseInt(idPlanoConta));
	  contaMovto.setIdCentroCusto(Integer.parseInt(idCentroCusto));
	  contaMovto.setHistorico(historico);
	  contaMovto.setDivideValor(divideValor);
	  contaMovto.setIdColaborador(Integer.parseInt(idColaborador));
	  contaMovto.setVlSaldoAnterior(vlSaldoAnterior);
	  contaMovto.setVlSaldoAtual(vlSaldoAtual);
	  contaMovto.setConciliado(conciliado);
	  contaMovto.setStatus(status);
	  
    if (!acao.equalsIgnoreCase("exc")){
   	  contaMovto.setIdConta(Integer.parseInt(idConta));
    }
      
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}


  dao = new ContaMovtoDAO(conn);
  daoExclusao = new ContaMovtoDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {  
	  //inclui no banco de dados
  	dao.incluir(contaMovto);
	  response.sendRedirect("listarContaMovto.jsp?acao=listar&idContaLocalizar="+idContaLocalizar);
  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
    	 dao.atualizar(contaMovto);
   	  response.sendRedirect("listarContaMovto.jsp?acao=listar&idContaLocalizar="+idContaLocalizar);
  } else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  if(!daoExclusao.exclusaoIdContaMovto(Integer.parseInt(idContaMovto))){
		  dao.excluir(contaMovto);
	  } else{
		  response.sendRedirect("listarContaMovto.jsp?mensagem=Exclusão Inválida! Item já possui lançamentos.&acao=listar");
	  }
	  
  }
} else {
  if (!acao.equalsIgnoreCase("voltar")) {
	 historicoLocalizar = request.getParameter("historicoLocalizar");
		dtLanc1Localizar = request.getParameter("dtLanc1Localizar");
		if (dtLanc1Localizar == null)
			dtLanc1Localizar = data;
		dtLanc2Localizar = request.getParameter("dtLanc2Localizar");
		if (dtLanc2Localizar == null)
			dtLanc2Localizar = data;
   statusLocalizar = request.getParameter("statusLocalizar");
   if (statusLocalizar == null) statusLocalizar = "";
  }
  if (historicoLocalizar!= null) {
    clausula = " WHERE cm.historico LIKE '"+historicoLocalizar+"%'";
  } 
	if (dtLanc1Localizar != null && !dtLanc1Localizar.isEmpty() && dtLanc2Localizar != null && !dtLanc2Localizar.isEmpty()) {
		if (clausula.isEmpty()) {
			  clausula = " WHERE cm.dtLanc BETWEEN '"+converte.DMYToYMDI(dtLanc1Localizar)+" 00:00:00' AND '"+converte.DMYToYMDI(dtLanc2Localizar)+" 23:59:59'"; 
		} else {
			clausula += " AND cm.dtLanc BETWEEN '"+converte.DMYToYMDI(dtLanc1Localizar)+" 00:00:00' AND '"+converte.DMYToYMDI(dtLanc2Localizar)+" 23:59:59'";
		}
	} else if (dtLanc1Localizar != null && !dtLanc1Localizar.isEmpty() && dtLanc2Localizar != null && dtLanc2Localizar.isEmpty()) {
		if (clausula.isEmpty()) {
			  clausula = " WHERE cm.dtLanc >= '"+converte.DMYToYMDI(dtLanc1Localizar)+" 00:00:00'"; 
		} else {
			clausula += " AND cm.dtLanc >= '"+converte.DMYToYMDI(dtLanc1Localizar)+" 00:00:00'";
		}
	} else if (dtLanc1Localizar != null && dtLanc1Localizar.isEmpty() && dtLanc2Localizar != null && !dtLanc2Localizar.isEmpty()) {
		if (clausula.isEmpty()) {
			  clausula = " WHERE cm.dtLanc <= '"+converte.DMYToYMDI(dtLanc2Localizar)+" 23:59:59'"; 
		} else {
			clausula += " AND cm.dtLanc <= '"+converte.DMYToYMDI(dtLanc2Localizar)+" 23:59:59'";
		}
	}
  if (!statusLocalizar.isEmpty()) {
    if (clausula.isEmpty()) {
      clausula = " WHERE cm.status='"+statusLocalizar+"'";
    } else {
      clausula = clausula+" AND cm.status='"+statusLocalizar+"'";
    }
  }
  if (clausula.isEmpty()) {
	  clausula = " WHERE cm.idConta="+idContaLocalizar;
	} else {
  	clausula = clausula+" AND cm.idConta="+idContaLocalizar;
	}
  if (clausula.isEmpty()) {
	    clausula = " WHERE c.idLoja="+idLojaLocalizar;
	} else {
  	clausula = clausula+" AND c.idLoja="+idLojaLocalizar;
	}
}

//seleciona todos os registros do banco de dados
List list;
dao = new ContaMovtoDAO(conn);
clausula = clausula+" ORDER BY cm.dtLanc, cm.idContaMovto ";
list = dao.listarContaMovto(clausula);

int cont = 0;
%>
<h1 class="cabecalho_pagina">Movimentação de Conta</h1>

|<a class="button" href="formContaMovto.jsp?acao=inc&idContaLocalizar=<%=idContaLocalizar%>">Novo Cadastro</a>|<br>

<body onload="document.forms[0].elements[0].focus();" >
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<iframe width=174 height=189 name="gToday:normal:"../js/calendar/agenda.js"
            id="gToday:normal:"../js/calendar/agenda.js" src="../js/calendar/ipopeng.htm"
            scrolling="no" frameborder="0" style="visibility:visible; z-index:999; 
    position:absolute; top:-500px; left:-500px;">
</iframe>
<form action="listarContaMovto.jsp" method="get">
<table colspan="2">
  <tr>
    <th class="label">Loja</th>
    <td><select name="idLojaLocalizar" >
        <%@include file="../WEB-INF/jspf/combo/comboLoja.jspf" %></select>
        <script>comboSelect(document.forms[0].idLojaLocalizar, '<%=idLojaLocalizar%>');</script>
    </td>
    <th class="label">Conta</th>
    <td><select name="idContaLocalizar" >
        <%@include file="../WEB-INF/jspf/combo/comboConta.jspf" %></select>
        <script>comboSelect(document.forms[0].idContaLocalizar, '<%=idContaLocalizar%>');</script>
    </td>
    <td><input class="button" type="button" value="Localizar" onClick="javascript: localizar();" /></td>
    <td><input class="button" type="button" value="Nova pesquisa" onClick="javascript: novaPesquisa();" /></td>
  </tr>
  <tr>
    <th class='label'>Histórico</th>
    <td><input type="text" name="historicoLocalizar" <%if (historicoLocalizar != null) { %>value="<%=historicoLocalizar %>"<% }%>  size="40" maxlength="40"></td>
		<th class="label">Período</th>
    <td class='grid'> de
			<input type="text" name="dtLanc1Localizar" size="15" value="<%= dtLanc1Localizar %>" onblur="chkData(this,'dd/MM/yyyy')" maxlength="10" class="inputs"><a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dtLanc1Localizar);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
				 a 
			<input type="text" name="dtLanc2Localizar" size="15" value="<%= dtLanc2Localizar %>" maxlength="10" onblur="chkData(this,'dd/MM/yyyy')" class="inputs"><a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dtLanc2Localizar);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
    </td>
    </tr>
  <tr>
    <th class="label">Status</th>
    <td class="label_radio">
      <input type="radio" class="radio" name="statusLocalizar" value="" <%= (statusLocalizar.equals("")? "checked": "") %>>Todos
      <input type="radio" class="radio" name="statusLocalizar" value="R" <%= (statusLocalizar.equals("R")? "checked": "") %>>Realizado
      <input type="radio" class="radio" name="statusLocalizar" value="P" <%= (statusLocalizar.equals("P")? "checked": "") %>>Previsto</td>
  </tr>
</table>
<hr>

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr>
      <th class="grid">&nbsp;</th>
      <th class="grid"><center>Data</center></th>
      <th class="grid"><center>Tipo</center></th>
      <th class="grid"><center>Histórico</center></th>
      <th class="grid"><center>Doc.</center></th>
      <th class="grid">Valor</th>
      <th class="grid">Saldo</th>
      <th class="grid">Status</th>
      <th class="grid">Excluir</th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
String msgTipo = "";
String msgStatus = "";
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	ContaMovto contaMovtoLista = (ContaMovto) it.next();
	if (contaMovtoLista.getFormaMovto().equals("D")) {
		msgTipo = "Depósito";
	} else if (contaMovtoLista.getFormaMovto().equals("R")) {
		msgTipo = "Retirada";
	} else if (contaMovtoLista.getFormaMovto().equals("T")) {
		msgTipo = "Transferência";
	}
	if (contaMovtoLista.getStatus().equals("R")) {
		msgStatus = "Realizado";
	} else if (contaMovtoLista.getStatus().equals("P")) {
		msgStatus = "Previsto";
	}
  cont++;

%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <%if(contaMovtoLista.getDtLanc() != null){%>
      	<td class = "grid" width="10%"><center><%=converte.dateToString(contaMovtoLista.getDtLanc())%></center></td>
      <%}else{ %>
        <td class = "grid" width="10%"><center>-</center></td>
      <%} %>
      <td class = "grid" width="10%"><center><%=msgTipo%></center></td>
      <td class = "grid"><center><a href="formContaMovto.jsp?acao=atu&idContaMovto=<%=contaMovtoLista.getIdContaMovto()%>&idContaLocalizar=<%=idContaLocalizar%>"><%=contaMovtoLista.getHistorico()%> </a></center></td>
      <td class = "grid" ><center><%=contaMovtoLista.getNrDoc()%></center></td>
      <td class = "grid" width="10%"><p align="right"><%=Utilitaria.formatarNumero(contaMovtoLista.getValor(),2)%> <%=contaMovtoLista.getDc()%></p></td>
      <%if(contaMovtoLista.getVlSaldoAtual() >= 0){%>
     		<td class = "grid" width="10%"><p align="right"><%=Utilitaria.formatarNumero(contaMovtoLista.getVlSaldoAtual(),2)%> C</p></td>
      <%}else{ %>
     		<td class = "grid" width="10%"><p align="right"><%=Utilitaria.formatarNumero(contaMovtoLista.getVlSaldoAtual()*(-1),2)%> D</p></td>
      <%} %>
      <td class = "grid" width="5%"><center><%=msgStatus%></center></td>
      <%if(!contaMovtoLista.getStatus().equalsIgnoreCase("R")){ %>
      	<td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=contaMovtoLista.getIdContaMovto()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
      <%}else{%>
      	<td class = "grid" width="3%"><center>-</center></td>
      <%} %>
   </tr>
<%
}
%>   
</table>
</form>
<p align="right">|<a class="button" href="formContaMovto.jsp?acao=inc&idContaLocalizar=<%=idContaLocalizar%>">Novo Cadastro</a>|