<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.Orcamento" %>
<%@ page import="afero.model.OrdemServico" %>
<%@ page import="afero.model.Entidade" %>
<%@ page import="afero.persistence.OrcamentoDAO" %>
<%@ page import="afero.persistence.EntidadeDAO" %>
<%@ page import="afero.persistence.OrdemServicoDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Date" %>
<%@ page import="afero.util.ConverteDate" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>


function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.nomeEntidade.value = '';
  document.all.status.value = ''; //não está limpando
  document.forms[0].submit();
}  
</script>

<%
String idLojaUsuario = (String)session.getAttribute("idLoja");
OrdemServicoDAO dao = null;
String status = request.getParameter("status");
if(status == null)status = "";
String nomeEntidade = request.getParameter("nomeEntidade");
String acao = request.getParameter("acao");
if(acao == null)acao="listar";
String clausula = "";
 if (!acao.equalsIgnoreCase("voltar")) {
	 nomeEntidade = request.getParameter("nomeEntidade");
	 if(nomeEntidade==null)nomeEntidade="";
    status = request.getParameter("status");
    if (status == null) status = "";
  }

  if (nomeEntidade!= null) {
    clausula = " WHERE e.nome LIKE '"+nomeEntidade+"%'";
  } 
  if (!status.isEmpty()) {
    if (clausula.isEmpty()) {
      clausula = " WHERE os.status='"+status+"'";
    } else {
      clausula = clausula+" AND os.status='"+status+"'";
    }
  }
  
  clausula = clausula+" AND o.idLoja= "+ Integer.parseInt(idLojaUsuario);
//seleciona todos os registros do banco de dados
List list;
dao = new OrdemServicoDAO(conn);
clausula = clausula+" ORDER BY os.dtAprov desc";
list = dao.listarOrdemServico(clausula);
%>
<h1 class="cabecalho_pagina">Consulta de Ordens de Serviços</h1>
<body onload="document.forms[0].elements[0].focus();" >
<form method="post" action="consultarOrdemdeServico.jsp">
<table colspan="2">
  <tr>
    <th class='label'>Nome do Cliente</th>
    <td><input type="text" name="nomeEntidade" <%if (nomeEntidade != null) { %>value="<%=nomeEntidade %>"<% }%>  size="40" maxlength="40"></td>
    <td><input class="button" type="button" value="Localizar" onClick="javascript: localizar();" /></td>
    <td><input class="button" type="button" value="Nova pesquisa" onClick="javascript: novaPesquisa();" /></td>
  </tr>
  <tr>
    <th class="label">Status</th>
    <td class="label_radio">
      <input type="radio" class="radio" name="status" value="" <%= (status.equals("")? "checked": "") %>>Todos
      <input type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Aberto
      <input type="radio" class="radio" name="status" value="F" <%= (status.equals("F")? "checked": "") %>>Fechado</td>
  </tr>
</table>
<hr>

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr">
      <th class="grid">&nbsp;</th>
      <th class="grid"><center>Número do Pedido</center></th>
      <th class="grid"><center>Ordem de Serviço</center></th>
      <th class="grid"><center>Nome do Cliente</center></th>
      <th class="grid">Status</th>
    </tr>
<%
int cont = 0;
int gridSize = 20;
String rowNumStr = request.getParameter("rowNum");
int rowNum = (rowNumStr == null ? 0: Integer.parseInt(rowNumStr));
if (rowNum < 0) rowNum = 0;
boolean hasNext = false;
int rowCount = list.size();
int rowLast = 0;
if (rowCount > 0) {
  if (rowCount > gridSize) {
    rowLast = rowNum+gridSize; 
    if (rowLast >= rowCount && rowCount > 0) rowLast = rowCount;
    if (rowNum > rowLast) rowNum = 0;
    list = list.subList(rowNum, rowLast);
  }
  hasNext = true;
}
//Utiliza o ResultSet para trazer os registros do banco de dados
String dsStatus="";
int numPedido = 0;
OrdemServicoDAO daoOrdemServico = new OrdemServicoDAO(conn);
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	OrdemServico ordemServico = (OrdemServico) it.next();;
	OrcamentoDAO daoOrc = new OrcamentoDAO(conn);
	Orcamento orc = daoOrc.procurarOrcamento(ordemServico.getIdOrcamento());
	numPedido = daoOrdemServico.getPedidoSaida(ordemServico.getIdOrcamento());
	EntidadeDAO daoEntidade = new EntidadeDAO(conn);
	Entidade entidade = null;
	entidade = daoEntidade.procurarEntidade(orc.getCdEntidade());
	cont++;
   if(ordemServico.getStatus().equals("F")){
		if(ordemServico.getStatus().equalsIgnoreCase("A")){
			dsStatus="Aberta";
		}else if(ordemServico.getStatus().equalsIgnoreCase("F")){
			dsStatus="Fechada";
		}
%>
  
   <tr>
      <td class = "grid_licenca" width="2%"><center><%=rowNum+cont%></center></td>
      <td class = "grid_licenca" width="5%"><center><%=numPedido%></center></td>
      <td class = "grid_licenca" width="5%"><center><a target="_blank" href="ordemServico.jsp?idOrcamento=<%=ordemServico.getIdOrcamento()%>&idOrdemServico=<%=ordemServico.getIdOrdemServico()%>"><%=ordemServico.getIdOrdemServico()%></a></center></td>
      <td class = "grid_licenca" width="30%"><center><%=entidade.getNome()%></center></td>
      <td class = "grid_licenca" width="3%"><center><%=dsStatus%></center></td>
  	</tr>
<%
   }else if(ordemServico.getStatus().equals("A")){
	   if(ordemServico.getStatus().equalsIgnoreCase("A")){
			dsStatus="Aberta";
		}else if(ordemServico.getStatus().equalsIgnoreCase("F")){
			dsStatus="Fechada";
		}
%>
    <tr>
      <td class = "grid_lista_espera" width="2%"><center><%=rowNum+cont%></center></td>
      <td class = "grid_lista_espera" width="5%"><center><%=numPedido%></center></td>
      <td class = "grid_lista_espera" width="5%"><center><a target="_blank" href="ordemServico.jsp?idOrcamento=<%=ordemServico.getIdOrcamento()%>&idOrdemServico=<%=ordemServico.getIdOrdemServico()%>"><%=ordemServico.getIdOrdemServico()%></a></center></td>
      <td class = "grid_lista_espera" width="30%"><center><%=entidade.getNome()%></center></td>
      <td class = "grid_lista_espera" width="3%"><center><%=dsStatus%></center></td>
  	</tr>
<% 
   }
}
%>      
</table>
</form>
<%  if (rowNum != 0 || hasNext) { %>
        <center>
<%      if (rowNum != 0) { %>
<a class="link" href="consultarOrdemdeServico.jsp?rowNum=<%=0%>&nomeEntidade=<%=nomeEntidade%>&status=<%=status%>">Primeira</a>&nbsp&nbsp
|&nbsp&nbsp<a class="link" href="consultarOrdemdeServico.jsp?rowNum=<%=rowNum-gridSize%>&nomeEntidade=<%=nomeEntidade%>&status=<%=status%>">< Anterior</a>&nbsp&nbsp
<%      } else { %>
Primeira&nbsp&nbsp|&nbsp&nbsp< Anterior&nbsp
<%      } %>
<%      if (hasNext) { %>
|&nbsp&nbsp<a class="link" href="consultarOrdemdeServico.jsp?rowNum=<%=rowNum+gridSize%>&nomeEntidade=<%=nomeEntidade%>&status=<%=status%>">Próxima ></a>&nbsp&nbsp
|&nbsp&nbsp<a class="link" href="consultarOrdemdeServico.jsp?rowNum=<%=rowCount-gridSize%>&nomeEntidade=<%=nomeEntidade%>&status=<%=status%>">Última</a>
<%      } else { %>
|&nbsp&nbsp Próxima >&nbsp&nbsp|&nbsp&nbspÚltima
<%      } %>
        </center>
<%  } %>
<%@include file="../fimConexao.jsp"%>