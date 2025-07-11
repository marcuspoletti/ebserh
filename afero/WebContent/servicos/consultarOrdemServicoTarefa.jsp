<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>

<%@page import="afero.model.Unidade"%>
<%@ page import="afero.model.OrdemServicoItem" %>
<%@ page import="afero.model.ListaTarefa" %>
<%@ page import="afero.model.ListaServico" %>
<%@ page import="afero.persistence.OrdemServicoItemDAO" %>
<%@ page import="afero.persistence.ListaServicoDAO" %>
<%@page import="afero.persistence.OrdemServicoObjetoDAO" %>
<%@page import="afero.persistence.ConfigServicoDAO"%>
<%@page import="afero.persistence.UnidadeDAO"%>
<%@ page import="afero.persistence.ListaTarefaDAO" %>
<%@ page import="afero.util.Utilitaria" %>
<%@ page import="afero.util.ConverteDate" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script>

//Depois ver...
function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.dsPesquisaObjeto.value = '';
  document.all.status.value = ''; //não está limpando
  document.forms[0].submit();
}  

function addPd(){
	window.opener.location.reload();
	self.close();
}
</script>
<%
ListaTarefaDAO dao;
OrdemServicoItemDAO daoServicoItem;
OrdemServicoItem ordemServicoItem;
OrdemServicoObjetoDAO daoObjeto;
OrdemServicoObjetoDAO daoExclusao;
String acao = request.getParameter("acao");
if (acao == null) acao = "listar";
String dsPesquisaTarefa = request.getParameter("dsPesquisaTarefa");
String status = request.getParameter("status");
if(status == null)status = "";
String idOrdemServico = request.getParameter("idOrdemServico");
String idOrdemServicoItem = request.getParameter("idOrdemServicoItem");
String idOrdemServicoObjeto = request.getParameter("idOrdemServicoObjeto");
String idListaTarefa = request.getParameter("idListaTarefa");
int idLoja = Integer.parseInt((String)session.getAttribute("idLoja"));
int idColaborador = Integer.parseInt((String)session.getAttribute("idColaborador"));
String clausula = "";

//IdOrdemServico
String usuario = (String)session.getAttribute("Login");

if(dsPesquisaTarefa != null){
	clausula += " WHERE dsListaTarefa like '"+dsPesquisaTarefa+"%' AND idLoja = "+idLoja;
}else {
	clausula += " WHERE idLoja = "+idLoja;
}

if(status != null && status != ""){
	clausula += " AND status = '"+status+"'";
}
//seleciona todos os registros do banco de dados
List list;
dao = new ListaTarefaDAO(conn);
clausula = clausula +" ORDER BY idLoja ";
list = dao.listarTarefa(clausula);


daoServicoItem = new OrdemServicoItemDAO (conn);
List listServico = daoServicoItem.listarServicoObjeto(Integer.parseInt(idOrdemServico));

%>
<h1 class="cabecalho_pagina">Lista de Serviços e Tarefas</h1>
<body onload="document.forms[0].elements[0].focus();" >
<form action="consultarOrdemServicoTarefa.jsp">
<input type="hidden" name="idOrdemServico" value="<%=idOrdemServico%>"/>
<input type="hidden" name="idOrdemServicoItem" value="<%=idOrdemServicoItem%>"/>
<input type="hidden" name="idOrdemServicoObjeto" value="<%=idOrdemServicoObjeto%>"/>
<input type="hidden" name="acao" value="<%=acao%>"/>
<%if(idOrdemServicoItem != null && idListaTarefa == null){ %>
<table colspan="2">
   <tr>
    <th class='label'>Descrição Tarefa</th>
    <td><input type="text" name="dsPesquisaTarefa" <%if (dsPesquisaTarefa != null) { %>value="<%=dsPesquisaTarefa %>"<% }%>  size="40" maxlength="40"></td>
  </tr>
  <tr>
    <th class="label">Status</th>
    <td class="label_radio">
      <input type="radio" class="radio" name="status" value="" <%= (status.equals("")? "checked": "") %>>Todos
      <input type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Ativo
      <input type="radio" class="radio" name="status" value="I" <%= (status.equals("I")? "checked": "") %>>Inativo
    </td>
     <td><input class="button" type="button" value="Localizar" onClick="javascript: localizar();" /></td>
    <td><input class="button" type="button" value="Nova pesquisa" onClick="javascript: novaPesquisa();" /></td>
  </tr>
</table>
<%} %>
<hr>
<%if(idOrdemServicoItem == null){%>
<table border="0" width="100%">
	<tr>
		<th class="grid"></th>
	         <th class="grid"><%="Adic."%></th>
		<th class="grid">Desc. Ordem de Serviço</th>
		<th class="grid">Desc. Serviço</th>
		<th class="grid">Comp.</th>
		<th class="grid">Larg.</th>
		<th class="grid">Quant.</th>
		<th class="grid">Valor(R$)</th>
		<th class="grid">Desc(%)</th>
		<th class="grid">Vl. Unit(R$)</th>
	</tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
int contServ = 0;
String nomeServico = "";
for ( Iterator itServ = listServico.iterator(); itServ.hasNext(); ) {
	
	
	ordemServicoItem = (OrdemServicoItem) itServ.next();
	ListaServico listaServico = null;
	ListaServicoDAO daoListaServico = new ListaServicoDAO(conn);
	listaServico = daoListaServico.procurarListaServico(" WHERE idListaServico = "+ordemServicoItem.getIdListaServico());
	nomeServico = listaServico.getDsListaServico();
	contServ++;
	

%>
	<tr>
		<td class="grid"><%=contServ%></td>
		<td class="grid"><a href="consultarOrdemServicoTarefa.jsp?acao=<%=acao %>&idOrdemServico=<%=idOrdemServico %>&idOrdemServicoItem=<%=ordemServicoItem.getIdOrdemServicoItem()%>&idOrdemServicoObjeto=<%=idOrdemServicoObjeto%>"><img border = "0" src="../images/soma.jpg"></a></td>
		<td class="grid"><%=ordemServicoItem.getDsCompServico()%></td>
		<td class="grid"><%=nomeServico%></td>
		<td class="grid"><%=ordemServicoItem.getComp()%></td>
		<td class="grid"><%=ordemServicoItem.getLarg()%></td>
		<td class="grid"><%=ordemServicoItem.getQuant()%></td>
		<td class="grid"><%=Utilitaria.formatarNumero(ordemServicoItem.getValor(), 2)%></td>
		<td class="grid"><%=Utilitaria.formatarNumero(ordemServicoItem.getpDesc(), 2)%></td>
		<td class="grid"><%=Utilitaria.formatarNumero(ordemServicoItem.getVlUni(), 2)%></td>
		
	</tr>
<%} %>

</table>
<%} %>
<%if(idOrdemServicoItem != null && idListaTarefa == null){ %>

<table border="0" width="100%">
	<tr>
		<th class="grid"></th>
	         <th class="grid"><%="Adic."%></th>
		<th class="grid">Descrição</th>
		<th class="grid">Preço</th>
		<th class="grid">Unidade</th>
		<th class="grid">Status</th>
	</tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
int cont = 0;
String msgStatus = "";
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	
	ListaTarefa listaTarefa = (ListaTarefa) it.next();
	UnidadeDAO daoUnidade = new UnidadeDAO(conn);
	Unidade unidade = daoUnidade.procurarUnidade(listaTarefa.getIdUnidade());
	if(listaTarefa.getStatus().equalsIgnoreCase("A")){
		msgStatus = "Ativo";
	}else{
		msgStatus = "Inativo";
	}
	cont++;
	

%>
	<tr>
		<td class="grid"><%=cont%></td>
		<td class="grid"><a href="formOrdemServicoTarefa.jsp?acao=<%=acao %>&idOrdemServico=<%=idOrdemServico %>&idOrdemServicoItem=<%=idOrdemServicoItem %>&idListaTarefa=<%=listaTarefa.getIdListaTarefa() %>&idOrdemServicoObjeto=<%=idOrdemServicoObjeto%>"><img border = "0" src="../images/soma.jpg"></a></td>
		<td class="grid"><%=listaTarefa.getDsListaTarefa()%></td>
		<td class="grid"><%=Utilitaria.formatarNumero(listaTarefa.getPreco(), 2)%></td>
		<td class="grid"><%=unidade.getDsUnidade() %></td>
		<td class="grid"><%=msgStatus%></td>
		
	</tr>
<%} %>
<%} %>

</table>
</form>
</body>