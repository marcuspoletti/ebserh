<%@page import="afero.util.ConverteDate"%>
<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.OrdemServico" %>
<%@ page import="afero.model.ConfigServico" %>
<%@ page import="afero.model.Loja" %>
<%@ page import="afero.model.Entidade" %>
<%@ page import="afero.model.EntidadeFisica" %>
<%@ page import="afero.model.EntidadeJuridica" %>
<%@ page import="afero.persistence.OrdemServicoDAO" %>
<%@ page import="afero.persistence.ConfigServicoDAO" %>
<%@ page import="afero.persistence.LojaDAO" %>
<%@ page import="afero.persistence.EntidadeDAO" %>
<%@ page import="afero.persistence.EntidadeFisicaDAO" %>
<%@ page import="afero.persistence.EntidadeJuridicaDAO" %>
<%@ page import="afero.util.Utilitaria" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function confirmaExcluir(cont, id) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarOrdemServico.jsp?acao=exc&idOrdemServico=' + id;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.numOrdemServ.value = '';
  document.all.nomeLocalizar.value = '';
  document.all.cpfLocalizar.value = '';
  document.all.telefone.value = '';
  document.all.tpInsc.value = 'J';
  document.all.status.value = 'A';
  document.all.dsCampo1.value = '';
  document.all.dsCampo2.value = '';
  document.all.dsCampo3.value = '';
  document.all.dsCampo4.value = '';
  document.forms[0].submit();
}  
</script>
<%
//Pesquisa
String numOrdemServ = "";
if(request.getParameter("numOrdemServ")!= null)numOrdemServ = request.getParameter("numOrdemServ");
String nomeLocalizar = "";
if(request.getParameter("nomeLocalizar")!= null)nomeLocalizar = request.getParameter("nomeLocalizar");
String cpfLocalizar = "";
if(request.getParameter("cpfLocalizar")!= null)cpfLocalizar = request.getParameter("cpfLocalizar");
String telefone = "";
if(request.getParameter("telefone")!= null)telefone = request.getParameter("telefone");
String tpInsc = request.getParameter("tpInsc");
if(tpInsc == null)tpInsc = "J";

//Fim Pesquisa
OrdemServicoDAO dao;
OrdemServicoDAO daoExclusao;
LojaDAO lojaDAO;
Loja buscaLoja;
EntidadeDAO entidadeDAO;
Entidade entidade;

String mensagem = request.getParameter("mensagem");
if(mensagem == null)mensagem = "";
String acao = request.getParameter("acao");
if (acao == null) acao = "listar";

int idLojaPesquisa = Integer.parseInt((String)session.getAttribute("idLoja"));

String clausula = "";

String idOrdemServico = "0";
int idLoja = Integer.parseInt((String)session.getAttribute("idLoja"));
String cdEntidade = "0";
String idColaborador = "0";
String idMecanico = "0";
String cdTipoAtendimento = "0";
String tipo = "";
String dtOrc = null;
String dtOS = null;
String dtAprov = null;
String dtEntrega = null;
String pessoaResponsavel = "";
String dtInicio = null;
String dtConclusao = null;
String dtEntRealizada = null;
String cdCondPagto = "0";
String prazoEntrega = "0";
String prazoValidade = "0";
String prazoGarantia = "0";
String cmpOS1 = "";
String cmpOS2 = "";
String cmpOS3 = "";
String cmpOS4 = "";
String observacao = "";
String vlServ = "0";
String vlProd = "0";
String vlFrete = "0";
String vlDesc = "0";
String vlTotalOrdemServico = "0";
String status = request.getParameter("status");
if(request.getParameter("status")== null)status = "A";
String dtMod = null;
String usuario = (String)session.getAttribute("Login");
String dsCampo1 = request.getParameter("dsCampo1");
if(dsCampo1 == null)dsCampo1 = "";
String dsCampo2 = request.getParameter("dsCampo2");
if(dsCampo2 == null)dsCampo2 = "";
String dsCampo3 = request.getParameter("dsCampo3");
if(dsCampo3 == null)dsCampo3 = "";
String dsCampo4 = request.getParameter("dsCampo4");
if(dsCampo4 == null)dsCampo4 = "";
String horaEntrada = request.getParameter("horaEntrada");
if(horaEntrada == null)horaEntrada = "00:00";
String horaSaida = request.getParameter("horaSaida");
if(horaSaida == null)horaSaida = "00:00";


ConfigServicoDAO daoConfigServico = new ConfigServicoDAO(conn);
ConfigServico configServico = daoConfigServico.procurarConfigServico(" WHERE idLoja = "+idLoja);

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
	
	idOrdemServico = request.getParameter("idOrdemServico");
	cdEntidade = request.getParameter("cdEntidade");
	idColaborador = request.getParameter("idColaborador");
	cdTipoAtendimento = request.getParameter("cdTipoAtendimento");
	tipo = request.getParameter("tipo");
	
	if(request.getParameter("dtOrc") != null){
		dtOrc = request.getParameter("dtOrc");
	}
	if(request.getParameter("dtOS") != null){
		dtOS = request.getParameter("dtOS");
	}
	if(request.getParameter("dtAprov") != null){
		dtAprov = request.getParameter("dtAprov");
	}
	if(request.getParameter("dtEntrega") != null){
		dtEntrega = request.getParameter("dtEntrega");
	}
	
	pessoaResponsavel = request.getParameter("pessoaResponsavel");
	
	if(request.getParameter("dtInicio") != null){
		dtInicio = request.getParameter("dtInicio");
	}
	if(request.getParameter("dtConclusao") != null){
		dtConclusao = request.getParameter("dtConclusao");
	}
	if(request.getParameter("dtEntRealizada") != null){
		dtEntRealizada = request.getParameter("dtEntRealizada");
	}
	
	cdCondPagto = request.getParameter("cdCondPagto");
	prazoEntrega = request.getParameter("prazoEntrega");
	prazoValidade = request.getParameter("prazoEntrega");
	prazoGarantia = request.getParameter("prazoGarantia");
	cmpOS1 = request.getParameter("cmpOS1");
	cmpOS2 = request.getParameter("cmpOS2");
	cmpOS3 = request.getParameter("cmpOS3");
	cmpOS4 = request.getParameter("cmpOS4");
	observacao = request.getParameter("observacao");
	vlServ = request.getParameter("vlServ");
	vlProd = request.getParameter("vlProd");
	vlFrete = request.getParameter("vlFrete");
	vlDesc = request.getParameter("vlDesc");
	vlTotalOrdemServico =  request.getParameter("vlTotal");
	status = request.getParameter("status");
	
	if(request.getParameter("dtMod") != null){
		dtMod = request.getParameter("dtMod");
	}
	usuario = request.getParameter("usuario");
	
	if(request.getParameter("horaEntrada") != null){
		horaEntrada = request.getParameter("horaEntrada");
	}
	if(request.getParameter("horaSaida") != null){
		horaSaida = request.getParameter("horaSaida");
	}
	
	if(request.getParameter("idMecanico") != null){
		idMecanico = request.getParameter("idMecanico");
	}
	if(cdEntidade == null) cdEntidade = "0";
	if(idColaborador == null) idColaborador = "0";
	if(cdTipoAtendimento == null) cdTipoAtendimento = "0";
	if(tipo == null) tipo = "";

	if(pessoaResponsavel == null) pessoaResponsavel = "";

	if(cdCondPagto == null) cdCondPagto = "0";
	if(prazoEntrega == null) prazoEntrega = "0";
	if(prazoValidade == null) prazoValidade = "0";
	if(prazoGarantia == null) prazoGarantia = "0";
	if(cmpOS1 == null) cmpOS1 = "";
	if(cmpOS2 == null) cmpOS2 = "";
	if(cmpOS3 == null) cmpOS3 = "";
	if(cmpOS4 == null) cmpOS4 = "";
	if(observacao == null) observacao = "";
	if(vlServ == null) vlServ = "0";
	if(vlProd == null) vlProd = "0";
	if(vlFrete == null) vlFrete = "0";
	if(vlDesc == null) vlDesc = "0";
	if(status == null) status = "A";
	if(vlTotalOrdemServico  == null)vlTotalOrdemServico = "0";

	OrdemServico ordemServico = new OrdemServico();
  
	try {
	  if (!acao.equalsIgnoreCase("inc")){
		ordemServico.setIdOrdemServico(Integer.parseInt(idOrdemServico));
	  }
	  ordemServico.setIdLoja(idLoja);
	  ordemServico.setCdEntidade(Integer.parseInt(cdEntidade));
	  ordemServico.setIdColaborador(Integer.parseInt(idColaborador));
	  ordemServico.setCdTipoAtendimento(Integer.parseInt(cdTipoAtendimento));
	  ordemServico.setTipo(tipo);
	 
	  
	  if(dtOrc != null && dtOrc != ""){
		  ordemServico.setDtOrc(ConverteDate.stringToDate(dtOrc));
	  }
	  if(dtOS != null && dtOS != ""){
		  ordemServico.setDtOS(ConverteDate.stringToDate(dtOS));
	  }
	  if(dtAprov != null && dtAprov != ""){
		  ordemServico.setDtAprov(ConverteDate.stringToDate(dtAprov));
	  }
	  if(dtEntrega != null && dtEntrega != ""){
		  ordemServico.setDtEntrega(ConverteDate.stringToDate(dtEntrega));
	  }
	  
	  ordemServico.setPessoaResponsavel(pessoaResponsavel);
	  
	  if(dtInicio != null && dtInicio != ""){
		  ordemServico.setDtInicio(ConverteDate.stringToDate(dtInicio));
	  }
	  if(dtConclusao != null && dtConclusao != ""){
		  ordemServico.setDtConclusao(ConverteDate.stringToDate(dtConclusao));
	  }
	  if(dtEntRealizada != null && dtEntRealizada != ""){
		  ordemServico.setDtEntRealizada(ConverteDate.stringToDate(dtEntRealizada));
	  }
	  
	  ordemServico.setCdCondPagto(Integer.parseInt(cdCondPagto));
	  ordemServico.setPrazoEntrega(Integer.parseInt(prazoEntrega));
	  ordemServico.setPrazoValidade(Integer.parseInt(prazoValidade));
	  ordemServico.setPrazoGarantia(Integer.parseInt(prazoGarantia));
	  ordemServico.setCmpOS1(cmpOS1);
	  ordemServico.setCmpOS2(cmpOS2);
	  ordemServico.setCmpOS3(cmpOS3);
	  ordemServico.setCmpOS4(cmpOS4);
	  ordemServico.setObservacao(observacao);
	  ordemServico.setVlServ(Utilitaria.toNumber(vlServ).doubleValue());
	  ordemServico.setVlProd(Utilitaria.toNumber(vlProd).doubleValue());
	  ordemServico.setVlFrete(Utilitaria.toNumber(vlFrete).floatValue());
	  ordemServico.setVlDesc(Utilitaria.toNumber(vlDesc).floatValue());
	  ordemServico.setVlTotalOrdemServico(Utilitaria.toNumber(vlTotalOrdemServico).floatValue());
	  ordemServico.setStatus(status);
	  if(dtOrc != null){
		  ordemServico.setDtMod(ConverteDate.stringToDate(dtMod));
	  }
	  ordemServico.setUsuario(usuario);
	  ordemServico.setHoraEntrada(horaEntrada);
	  ordemServico.setHoraSaida(horaSaida);
	  ordemServico.setIdMecanico(Integer.parseInt(idMecanico));

	  	
      if (!acao.equalsIgnoreCase("exc")){
    	       ordemServico.setIdOrdemServico(Integer.parseInt(idOrdemServico));
  		
      }      
      
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}

	dao = new OrdemServicoDAO(conn);
	daoExclusao = new OrdemServicoDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {  
	  //inclui no banco de dados
	  dao.incluir(ordemServico);
	  
	  // Pegar ultimo idOrdemServico;
	  int idOS = dao.ultimoInsert();
	  dao.atualizarHoraEntradaHoraSaida(idOS, ordemServico.getHoraEntrada(), ordemServico.getHoraSaida());
	  dao.atualizarIdMecanico(idOS, Integer.parseInt(idMecanico));
	  %>
	  	<script language="JavaScript">location.href='formAddObjetosOS.jsp?acao=inc&idOrdemServico=<%=idOS %>'</script>
	 <%
  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
    	 dao.atualiza(ordemServico);
	 dao.atualizarValorTotal(ordemServico.getIdOrdemServico(), Utilitaria.toNumber(Utilitaria.formatarNumero(ordemServico.getVlTotalOrdemServico(),2)).floatValue());
	 dao.atualizarHoraEntradaHoraSaida(ordemServico.getIdOrdemServico(), ordemServico.getHoraEntrada(), ordemServico.getHoraSaida());
	 dao.atualizarIdMecanico(ordemServico.getIdOrdemServico(), Integer.parseInt(idMecanico));
	  
  }else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  if(dao.existeObjeto(Integer.parseInt(idOrdemServico))){
 		 mensagem = "Existem objetos vinculados a Ordem de Serviço. Exclusão Inválida !!!";  
 	   }else if(dao.existePedido(Integer.parseInt(idOrdemServico))){
 		 mensagem = "Existem Pedidos de Produtos vinculados a Ordem de Serviço. Exclusão Inválida !!!";  
 	   }else{
 		  dao.excluir(ordemServico);
 	   }
		  
  }
  
}else{
 if (!acao.equalsIgnoreCase("voltar")) {
    status = request.getParameter("status");
    if (status == null) status = "A";
  }
 

 
 if(idLojaPesquisa != 0){
	 if(clausula.isEmpty()){
		 clausula += " WHERE o.idLoja  = "+idLojaPesquisa;
	 }else{
		 clausula += " AND o.idLoja  = "+idLojaPesquisa;
	 }
	
 }
 
 if(nomeLocalizar != null){
	 if(!nomeLocalizar.equalsIgnoreCase("")){
		clausula += " AND e.nome like '"+nomeLocalizar+"%' "; 
	 }
 }
 
 if(cpfLocalizar != null || !cpfLocalizar.equalsIgnoreCase("")){
	 if(tpInsc.equalsIgnoreCase("F")){
		clausula += " AND f.cpf like '"+cpfLocalizar+"%' ";  
	 }else{
		clausula += " AND f.cnpj like '"+cpfLocalizar+"%' "; 
	 }
	   
 }
 if(telefone != null || !telefone.equalsIgnoreCase("")){
	clausula += " AND l.nroTelefone like '"+telefone+"%' ";  
 }
 if(numOrdemServ != null) {
	 if (!numOrdemServ.equalsIgnoreCase("")){
 		clausula += " AND o.idOrdemServico = "+Integer.parseInt(numOrdemServ);
	 }
 }
 if (!status.isEmpty()) {
      clausula = clausula+" AND o.status='"+status+"'";
  }
 if(configServico != null){
 	if((dsCampo1 != null || dsCampo1 != "") || (dsCampo2 != null || dsCampo2 != "") || (dsCampo3 != null || dsCampo3 != "") || (dsCampo4 != null || dsCampo4 != "")){
	 
		 if((dsCampo1 != "" || dsCampo1 != null)){

			 clausula += " AND o.cmpOS1 like '"+dsCampo1+"%'";
		 }
		 if((dsCampo2 != "" || dsCampo2 != null)){
			 clausula += " AND o.cmpOS2 like '"+dsCampo2+"%'";
		 }
		 if((dsCampo3 != "" || dsCampo3 != null)){
			 clausula += " AND o.cmpOS3 like '"+dsCampo3+"%'";
		 }
	 	if((dsCampo4 != "" || dsCampo4 != null)){
			 clausula += " AND o.cmpOS4 like '"+dsCampo4+"%'";
	 	} 
 	}
 }
 

}
%>
<h1 class="cabecalho_pagina">Ordem de Serviço</h1>

|<a class="button" href="formOrdemServico.jsp?acao=inc">Novo Cadastro</a>|<br>

<body onload="document.forms[0].elements[0].focus();" >
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<form action="listarOrdemServico.jsp">
<table colspan="2">
<%if(configServico != null){ %>
<tr>
<th class="label"><%=configServico.getDsCampo1() %></th>
<td><input type="text"  id="dsCampo1" name="dsCampo1" value="<%=dsCampo1%>" size="40" maxlength="20" /></td>
</tr>
<tr>
<th class="label"><%=configServico.getDsCampo2() %></th>
<td><input type="text"  id="dsCampo2" name="dsCampo2" value="<%=dsCampo2%>" size="40" maxlength="20" /></td>
</tr>
<tr>
<th class="label"><%=configServico.getDsCampo3()%></th>
<td><input type="text"  id="dsCampo3" name="dsCampo3" value="<%=dsCampo3%>" size="40" maxlength="20" /></td>
</tr>
<tr>
<th class="label"><%=configServico.getDsCampo4() %></th>
<td><input type="text"  id="dsCampo4" name="dsCampo4" value="<%=dsCampo4%>" size="40" maxlength="20" /></td>
</tr>
<%}%>
<tr>
    <th class="label">Núm. Ordem Serv.</th>
    <td><input type="text" name="numOrdemServ" <%if (numOrdemServ != null) { %>value="<%=numOrdemServ %>"<% }%> size="10" maxlength="10"></td>
  </tr>
<tr>
    <th class="label">Nome</th>
    <td><input type="text" name="nomeLocalizar" <%if (nomeLocalizar != null) { %>value="<%=nomeLocalizar %>"<% }%> size="40" maxlength="40"></td>
  </tr>
   <tr>
    <th class="label">CPF/CNPJ</th>
    <td><input type="text" id="cpfLocalizar" name="cpfLocalizar" <%if (cpfLocalizar != null) { %>value="<%=cpfLocalizar%>"<% }%>  size="40" maxlength="40" onblur="chkCPFCNPJ(this)"></td>
  </tr>
     <tr>
    <th class="label">Telefone</th>
    <td><input type="text" id="telefone" name="telefone" <%if (telefone != null) { %>value="<%=telefone%>"<% }%>  size="14" maxlength="14" onblur="chkCPFCNPJ(this)"></td>
  </tr>
  <tr>
    <th class="label">Tipo de Entidade</th>
    <td class="label_radio">
      <input type="radio" class="radio" name="tpInsc" value="J" <%= (tpInsc.equals("J")? "checked": "") %>>Pessoa Juridica
      <input type="radio" class="radio" name="tpInsc" value="F" <%= (tpInsc.equals("F")? "checked": "") %>>Pessoa Fisica
  </tr>
  <tr>
  	<th class="label">Status</th>
  			<td class="label_radio" <%if(acao.equalsIgnoreCase("inc")){ %>disabled<%} %>>
			<input type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Aberta
			<input type="radio" class="radio" name="status" value="F" <%= (status.equals("F")? "checked": "") %>>Fechada
			<input type="radio" class="radio" name="status" value="C" <%= (status.equals("C")? "checked": "") %>>Cancelada
	</td>
  	<td><input class="button" type="button" value="Localizar" onClick="javascript: localizar();" /></td>
  	<td><input class="button" type="button" value="Nova pesquisa" onClick="javascript: novaPesquisa();" /></td>
  </tr>
</table>
<hr>
<%-- mostra todos os registros do banco de dados --%>
<%
List<OrdemServico> list;
dao = new OrdemServicoDAO(conn);
clausula = clausula +" ORDER BY idOrdemServico ";
list = dao.listarOrdemServicoCliente(clausula, tpInsc);
int cont = 0;
%>
<table border="0" width="100%">
	<tr>
		<th class="grid">&nbsp;</th>
		<th class="grid"><center>Orc./Ordem de Serviço</center></th>
		<th class="grid"><center>CPF / CNPJ</center></th>
		<th class="grid"><center>Entidade</center></th>
		<th class="grid"><center>Data</center></th>
		<th class="grid"><center>Responsável</center></th>
		<th class="grid">Status</th>
		<th class="grid">Total(R$)</th>
		<th class="grid">Impressão</th>
		<th class="grid">PDF</th>
		<th class="grid">Excluir</th>
	</tr>
<%
//seleciona todos os registros do banco de dados
String msgStatus = "";
lojaDAO = new LojaDAO(conn);
buscaLoja = new Loja();
String nomeLoja = "";

entidadeDAO = new EntidadeDAO(conn);
entidade = new Entidade();
String nomeEntidade = "";
String cpfCnpf = "";
float valorTotal = 0;
for ( Iterator<OrdemServico> it = list.iterator(); it.hasNext(); ) {
	
	OrdemServico ordemServico = (OrdemServico) it.next();
	valorTotal = dao.getValorTotal(ordemServico.getIdOrdemServico());
	if(ordemServico.getStatus().equalsIgnoreCase("A")){
		msgStatus = "Aberta";
	}else if(ordemServico.getStatus().equalsIgnoreCase("C")){
		msgStatus = "Cancelada";
	}else if(ordemServico.getStatus().equalsIgnoreCase("F")){
		msgStatus = "Fechada";
	}
	cont++;
		//buscar nomeloja e nomeEntidade
		buscaLoja = lojaDAO.procurarLoja(ordemServico.getIdLoja());
		nomeLoja = buscaLoja.getApelido();
		
		entidade = entidadeDAO.procurarEntidade(ordemServico.getCdEntidade());
		nomeEntidade = entidade.getNome();
		if(entidade.getTpInsc().equalsIgnoreCase("F")){
			EntidadeFisicaDAO daoEntidadeFisica = new EntidadeFisicaDAO(conn);
			EntidadeFisica entidadeFisica = daoEntidadeFisica.procurarEntidadeFisica(entidade.getCdEntidade());
			cpfCnpf = entidadeFisica.getCpf();
		}else{
			EntidadeJuridicaDAO daoEntidadeJuridica = new EntidadeJuridicaDAO(conn);
			EntidadeJuridica entidadeJuridica = daoEntidadeJuridica.procurarEntidadeJuridica(entidade.getCdEntidade());
			cpfCnpf = entidadeJuridica.getCnpj();
		}
	%>
	<tr>
		<td class = "grid" width="2%"><center><%=cont%></center></td>
		
		<%if(ordemServico.getTipo().equalsIgnoreCase("O")){ %>
		<td class="grid"><center><%="Orçamento"%></center></td>
		<%}else{ %>
		<td class="grid"><center><%="Ordem de Serviço"%></center></td>
		<%} %>
		<td class="grid"><center><a href="formOrdemServico.jsp?acao=atu&idOrdemServico=<%=ordemServico.getIdOrdemServico() %>" ><%=cpfCnpf %></a></center></td>
		<td class="grid"><center><%=nomeEntidade %></center></td>
		<td class="grid"><center><%=ConverteDate.dateToString(ordemServico.getDtOrc()) %></center></td>
		<td class="grid"><center><%=ordemServico.getPessoaResponsavel() %></center></td>
		<td class="grid" width="5%"><center><%=msgStatus%></center></td>
		<td class="grid" width="5%"><center><%=Utilitaria.formatarNumero(valorTotal, 2)%></center></td>
		<td class="grid"><center><a target="_blank" href="impOrdemServico.jsp?acao=atu&idOrdemServico=<%=ordemServico.getIdOrdemServico() %>" ><img border = "0" src="../images/imprimir.gif"></a></center></td>
		<td class="grid"><center><a target="_blank" href="../servlet/OrdemServicoServlet?idOrdemServico=<%=ordemServico.getIdOrdemServico() %>&idLoja=<%=ordemServico.getIdLoja() %>&idCliente=<%=entidade.getCdEntidade()%>" ><img border = "0" src="../images/pdf.gif"></a></center></td>
		<td class="grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=ordemServico.getIdOrdemServico() %>);"><img border = "0" src="../images/delete.gif"></a></center></td>
	</tr>
<%}%>
</table>
</form>
<p align="right">|<a class="button" href="formOrdemServico.jsp?acao=inc">Novo Cadastro</a>|