<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.Duplicata"%>
<%@ page import="afero.model.Entidade"%>
<%@page import="afero.model.Transferencia"%>
<%@ page import="afero.model.Conta"%>
<%@ page import="afero.persistence.DuplicataDAO"%>
<%@page import="afero.persistence.TransferenciaDAO"%>
<%@ page import="afero.persistence.EntidadeDAO"%>
<%@ page import="afero.persistence.ContaDAO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.Date" %>
<%@ page import="afero.util.ConverteDate"%>
<%@ page import="afero.util.Utilitaria"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function confirmaExcluir(cont, id) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarTransferencia.jsp?acao=exc&idTransferencia=' + id;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function recarregar(acao) {
  document.forms[0].action='listarTransferencia.jsp?acao='+acao;
  document.forms[0].submit();
}
function novaPesquisa() {
  document.all.status.value = 'A'; //não está limpando
  document.forms[0].submit();
}  
</script>

<%
String idContaDePesquisar = request.getParameter("idContaDePesuisar");
String idContaParaPesquisar = request.getParameter("idContaParaPesuisar");
TransferenciaDAO dao;
TransferenciaDAO daoExclusao;
ContaDAO daoConta;
ConverteDate conDate = new ConverteDate();
String mensagem = request.getParameter("mensagem");
if(mensagem == null)mensagem = "";
String acao = request.getParameter("acao");
int idTransferencia = 0;
if(request.getParameter("idTransferencia")!=null){
	idTransferencia = Utilitaria.toNumber(request.getParameter("idTransferencia")).intValue();
}
if (acao == null) acao = "listar";
int idContaDe= 0;
int idContaPara = 0;
double valor = 0;
String formaMovto = "";
String dtLanc = "";
String lancaAutomatico= "N";
String historico = "";
int cdTipoFrequencia = 0;
String informaParcelas = "N";
int quantParcelas = 0;
String dtUltimoLanc = "";
int idColaborador = 0;
String status = "A";
String dtMod = "";
String usuario = (String) session.getAttribute("Login");
String clausula = "";

ConverteDate converte = new ConverteDate();


if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
	
	if(request.getParameter("idTransferencia")!= null){
		idTransferencia = Utilitaria.toNumber(request.getParameter("idTransferencia")).intValue();	
	}
	if(request.getParameter("idContaDe") != null){
		idContaDe = Utilitaria.toNumber(request.getParameter("idContaDe")).intValue();
	}
	if(request.getParameter("idContaPara") != null){
		idContaPara = Utilitaria.toNumber(request.getParameter("idContaPara")).intValue();	
	}
	if(request.getParameter("valor") != null){
		valor = Utilitaria.toNumber(request.getParameter("valor")).doubleValue();
	}	
	if(request.getParameter("formaMovto") != null){
		formaMovto = request.getParameter("formaMovto");
	}
	dtLanc = request.getParameter("dtLanc");

	if(request.getParameter("lancaAutomatico") != null){
		lancaAutomatico = request.getParameter("lancaAutomatico") ;	
	}
	historico = request.getParameter("historico");
	if(request.getParameter("cdTipoFrequencia") != null){
		cdTipoFrequencia = Utilitaria.toNumber(request.getParameter("cdTipoFrequencia")).intValue();	
	}
	if(request.getParameter("informaParcelas") != null){
		informaParcelas = request.getParameter("informaParcelas");
	}
	
	quantParcelas = Integer.parseInt(request.getParameter("quantParcelas"));
	
	dtUltimoLanc = request.getParameter("dtUltimoLanc");

	if(request.getParameter("idColaborador") != null){
		idColaborador = Utilitaria.toNumber(request.getParameter("idColaborador")).intValue();	
	}
	if(request.getParameter("status") != null){
		status = request.getParameter("status");
	}
	if(request.getParameter("dtMod") != null){
		dtMod = request.getParameter("dtMod");
	}
	
	if (acao == null) acao = "inc";
	
		
	Transferencia trans = new Transferencia();
  
	try {
	  if (!acao.equalsIgnoreCase("inc")){
		  trans.setIdTransferencia(idTransferencia);
	  }
	  trans.setIdContaDe(idContaDe);
	  trans.setIdContaPara(idContaPara);
	  trans.setValor(valor);
	  trans.setFormaMovto(formaMovto);
	  trans.setDtLanc(ConverteDate.stringToDate(dtLanc));
	  trans.setLancaAutomatico(lancaAutomatico);
	  trans.setHistorico(historico);
	  trans.setCdTipoFrequencia(cdTipoFrequencia);
	  trans.setInformaParcelas(informaParcelas);
	  trans.setQuantParcelas(quantParcelas);
	  trans.setDtUltimoLanc(ConverteDate.stringToDate(dtUltimoLanc));
	  trans.setIdColaborador(idColaborador);
	  trans.setStatus(status);
	  trans.setUsuario(usuario);
	  
      if (!acao.equalsIgnoreCase("exc")){
    	  trans.setIdTransferencia(idTransferencia);
      }
    	  
      
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}


  dao = new TransferenciaDAO(conn);
  daoExclusao = new TransferenciaDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {  
	  //inclui no banco de dados
  	dao.incluir(trans);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
    	 dao.atualizar(trans);
  }else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  
		  dao.excluir(trans);
  }
}else {
 if(!acao.equalsIgnoreCase("voltar")) {
	idContaDePesquisar = request.getParameter("idContaDePesquisar");
	idContaParaPesquisar = request.getParameter("idContaParaPesquisar");
	if(idContaDePesquisar == null)idContaDePesquisar="0";
	if(idContaParaPesquisar == null)idContaParaPesquisar="0";
    status = request.getParameter("status");
    if (status == null) status = "";
  }
  if (!idContaDePesquisar.equalsIgnoreCase("0") && idContaParaPesquisar.equalsIgnoreCase("0")) {
    clausula = " WHERE t.idContaDe= "+Integer.parseInt(idContaDePesquisar)+ " AND idContaPara is not null ";
  }else if(idContaDePesquisar.equalsIgnoreCase("0") && !idContaParaPesquisar.equalsIgnoreCase("0")){
	  clausula = " WHERE t.idContaPara= "+Integer.parseInt(idContaParaPesquisar) + " AND idContaDe is not null ";  
  }else if(idContaDePesquisar.equalsIgnoreCase("0") && !idContaParaPesquisar.equalsIgnoreCase("0")){
	  clausula = " WHERE t.idContaDe= "+Integer.parseInt(idContaDePesquisar)+" AND t.idContaPara= "+Integer.parseInt(idContaParaPesquisar);  
  }
  if(!status.isEmpty()) {
    if (clausula.isEmpty()) {
      clausula = " WHERE t.status='"+status+"'";
    }else {
      clausula = clausula +" AND t.status='"+status+"'";
   }
  }
  if(status.equals("")){
	 if (clausula.isEmpty()) {
	      clausula = " WHERE t.status is not null ";
	 }else {
	      clausula = clausula +" AND t.status is not null ";
	 }
  }
}

//seleciona todos os registros do banco de dados
List list;
dao = new TransferenciaDAO(conn);
//clausula = clausula; //+" order by t.dtUltmoLanc DESC";
list = dao.listarTransferencia(clausula);
dao = new TransferenciaDAO(conn);

int cont = 0;
%>
<h1 class="cabecalho_pagina">Transferências entre Contas</h1>

|<a class="button" href="formTransferencia.jsp?acao=inc">Novo Cadastro</a>|<br>

<body onload="document.forms[0].elements[0].focus();" >
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<form action="listarTransferencia.jsp">
<table colspan="2">
  <tr>
      <th class="label">Conta De*</th>
      <td><select name="idContaDePesquisar" >
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboConta.jspf" %></select>
          <script>comboSelect(document.forms[0].idContaDePesquisar, '<%=idContaDePesquisar%>');</script>
      </td>
  </tr>
    <tr>
      <th class="label">Conta Para*</th>
      <td><select name="idContaParaPesquisar">
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboContaPara.jspf" %></select>
          <script>comboSelect(document.forms[0].idContaParaPesquisar, '<%=idContaParaPesquisar%>');</script>
      </td>
  </tr>
  <tr>
    <th class="label">Status</th>
    <td class="label_radio">
      <input type="radio" class="radio" name="status" value="" <%= (status.equals("")? "checked": "") %>>Todos
      <input type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Ativo
      <input type="radio" class="radio" name="status" value="I" <%= (status.equals("I")? "checked": "") %>>Inativo
      <input type="radio" class="radio" name="status" value="EF" <%= (status.equals("EF")? "checked": "") %>>Efetuada</td>
      <td><input class="button" type="button" value="Localizar" onClick="javascript: localizar();" />
      <input class="button" type="button" value="Nova pesquisa" onClick="javascript: novaPesquisa();" /></td>
   </tr>
</table>
<hr>

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr">
      <th class="grid">&nbsp;</th>
      <th class="grid"><center>Origem</center></th>
      <th class="grid"><center>Destino</center></th>
      <th class="grid"><center>Vencimento</center></th>
      <th class="grid"><center>Valor</center></th>
      <th class="grid">Status</th>
      <th class="grid">Excluir</th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
ContaDAO daoContaListagem = new ContaDAO(conn);
Conta contaOrigem = null;
Conta contaDestino = null;
String msgStatus = "";
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	Transferencia transfListagem = (Transferencia) it.next();
	if(transfListagem.getStatus().equals("I")){
		msgStatus = "INATIVO";
	}else if(transfListagem.getStatus().equals("A")){
		msgStatus = "ATIVO";
	}else{
		msgStatus = "EFETUADA";
	}
	
	contaOrigem = daoContaListagem.procurarConta(transfListagem.getIdContaDe());
	contaDestino = daoContaListagem.procurarConta(transfListagem.getIdContaPara());
	cont++;

%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid"><center><%=contaOrigem.getNmConta()+" -   AG:  "+ contaOrigem.getAgencia()+"  CONTA: "+contaOrigem.getContaCorrente()%></center></td>
      <td class = "grid"><center><%=contaDestino.getNmConta()+" -   AG:  "+ contaDestino.getAgencia()+"  CONTA: "+contaDestino.getContaCorrente()%></center></td>
      <%if(!transfListagem.getStatus().equalsIgnoreCase("EF")){ %>
           <td class = "grid" width="10%"><center><a href="formTransferencia.jsp?acao=atu&idTransferencia=<%=transfListagem.getIdTransferencia()%>"><%=converte.dateToString(transfListagem.getDtUltimoLanc())%></a></center></td>
       <%}else{ %>
       	 	<td class = "grid" width="10%"><center><%=converte.dateToString(transfListagem.getDtUltimoLanc())%></center></td>     
       <%} %>
      <td class = "grid" width="10%"><center><%=Utilitaria.formatarNumero(transfListagem.getValor(),2)%></center></td>
      <td class = "grid" width="5%"><center><%=msgStatus%></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=transfListagem.getIdTransferencia()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
  	</tr>
<%}%>   

</table>
</form>
<p align="right">|<a class="button" href="formTransferencia.jsp?acao=inc">Novo Cadastro</a>|