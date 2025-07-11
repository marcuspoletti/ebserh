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
<%@ page import="afero.util.ConverteDate" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<%

OrdemServicoDAO dao;
OrdemServicoDAO daoExclusao;
LojaDAO lojaDAO;
Loja buscaLoja;
EntidadeDAO entidadeDAO;
Entidade entidade;
String clausula = "";
String idOrdemServico = "0";
ConverteDate converte = new ConverteDate();
int idLoja = Integer.parseInt((String)session.getAttribute("idLoja"));
String dataIni = request.getParameter("dataIni");
String dataFim = request.getParameter("dataFim");
String status =request.getParameter("status");




clausula = " WHERE status = '"+status+"' AND dtOS BETWEEN '"+converte.DMYToYMDI(dataIni)+" 00:00:00' AND '"+converte.DMYToYMDI(dataFim)+" 23:59:59'"; 
    
if(idLoja > 0){
	clausula = clausula + " AND idLoja = " + idLoja;
}

%>


<body onload="document.forms[0].elements[0].focus();" >
<form action="frameOrdemServico.jsp">

<%
List<OrdemServico> list;
dao = new OrdemServicoDAO(conn);
clausula = clausula +" ORDER BY idOrdemServico ";
list = dao.listar(clausula);
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
		<td class="grid"><center><a target="_blank" href="../servicos/formOrdemServico.jsp?acao=atu&idOrdemServico=<%=ordemServico.getIdOrdemServico() %>" ><%=cpfCnpf %></a></center></td>
		<td class="grid"><center><%=nomeEntidade %></center></td>
		<td class="grid"><center><%=ConverteDate.dateToString(ordemServico.getDtOS()) %></center></td>
		<td class="grid"><center><%=ordemServico.getPessoaResponsavel() %></center></td>
		<td class="grid" width="5%"><center><%=msgStatus%></center></td>
		<td class="grid" width="5%"><center><%=Utilitaria.formatarNumero(valorTotal, 2)%></center></td>
	</tr>
<%}%>
</table>
</form>