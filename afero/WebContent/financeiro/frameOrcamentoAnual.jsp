<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Date" %>
<%@ page import="afero.util.*" %>
<%@ page import="afero.util.ConverteDate" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<%@page import="afero.model.OrcamentoEmpresaItem"%>
<%@page import="afero.persistence.OrcamentoEmpresaItemDAO"%>
<%@page import="afero.model.RelatorioOrcamentoEmpresaItem"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />


<%
OrcamentoEmpresaItemDAO dao;
ConverteDate conDate = new ConverteDate();
String mensagem = request.getParameter("mensagem");
if(mensagem == null)mensagem = "";
String acao = request.getParameter("acao");
if (acao == null) acao = "listar";
String idOrcamentoEmpresa = request.getParameter("idOrcamentoEmpresa");

//seleciona todos os registros do banco de dados
List list;
List listAno;
dao = new OrcamentoEmpresaItemDAO(conn);
list = dao.listarRelatorioOrcamentoEmpresaItem(Integer.parseInt(idOrcamentoEmpresa));
int cont = 0;
%>
<body onload="document.forms[0].elements[0].focus();" >
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
String operacao = "";
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	RelatorioOrcamentoEmpresaItem relatorioOrcamentoEmpresaItem = (RelatorioOrcamentoEmpresaItem) it.next();
    cont++;
    if(relatorioOrcamentoEmpresaItem.getDc().equals("D")){
    	operacao = "DÉBITO";
    	
    }else if(relatorioOrcamentoEmpresaItem.getDc().equals("C")){
    	operacao = "CRÉDITO";
    }
%>

    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid" width="15"><center><a href="frameMesAnual.jsp?idOrcamentoEmpresa=<%=idOrcamentoEmpresa%>&ano=<%=relatorioOrcamentoEmpresaItem.getAno()%>" target="frameMes"><%=relatorioOrcamentoEmpresaItem.getAno()%></a></center></td>
       <td class = "grid" width="15"><center><%=Utilitaria.formatarNumero(relatorioOrcamentoEmpresaItem.getValor(),2).toString()%></center></td>
      <td class = "grid" width="15"><center><%=operacao%></center></td>
     
      
  	</tr>
<%
}
%>   
</table>
