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
<%@page import="afero.model.RelatorioMesAnual"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />


<%
OrcamentoEmpresaItemDAO dao;
ConverteDate conDate = new ConverteDate();
String mensagem = request.getParameter("mensagem");
if(mensagem == null)mensagem = "";
String acao = request.getParameter("acao");
if (acao == null) acao = "listar";
String idOrcamentoEmpresa = request.getParameter("idOrcamentoEmpresa");
if(idOrcamentoEmpresa == null)idOrcamentoEmpresa = "0";
String ano = request.getParameter("ano");
if(ano == null)ano="2010";

//seleciona todos os registros do banco de dados
List list;
dao = new OrcamentoEmpresaItemDAO(conn);
list = dao.listarRelatorioMesAnual(Integer.parseInt(idOrcamentoEmpresa), Integer.parseInt(ano));
int cont = 0;
%>
<body onload="document.forms[0].elements[0].focus();" >
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
String operacao = "";
String mes = "" ; 
float valorMes = 0;
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	RelatorioMesAnual relatorioMesAnual = (RelatorioMesAnual) it.next();
    cont++;
    if(relatorioMesAnual.getDc().equals("D")){
    	operacao = "DÉBITO";
    	
    }else if(relatorioMesAnual.getDc().equals("C")){
    	operacao = "CRÉDITO";
    }
    if(relatorioMesAnual.getMes() == 1){
    	mes = "Janeiro" + "/" + ano;
    	valorMes = relatorioMesAnual.getValor(); 
    }else if(relatorioMesAnual.getMes() == 2){
    	mes = "Fevereiro"+ "/" + ano;
    	valorMes = relatorioMesAnual.getValor(); 
    }else if(relatorioMesAnual.getMes() == 3){
    	mes = "Março"+ "/" + ano;
    	valorMes = relatorioMesAnual.getValor(); 
    }else if(relatorioMesAnual.getMes() == 4){
    	mes = "Abril"+ "/" + ano;
    	valorMes = relatorioMesAnual.getValor(); 
    }else if(relatorioMesAnual.getMes() == 5){
    	mes = "Maio"+ "/" + ano;
    	valorMes = relatorioMesAnual.getValor(); 
    }else if(relatorioMesAnual.getMes() == 6){
    	mes = "Junho"+ "/" + ano;
    	valorMes = relatorioMesAnual.getValor(); 
    }else if(relatorioMesAnual.getMes() == 7){
    	mes = "Julho"+ "/" + ano;
    	valorMes = relatorioMesAnual.getValor(); 
    }else if(relatorioMesAnual.getMes() == 8){
    	mes = "Agosto"+ "/" + ano;
    	valorMes = relatorioMesAnual.getValor(); 
    }else if(relatorioMesAnual.getMes() == 9){
    	mes = "Setembro"+ "/" + ano;
    	valorMes = relatorioMesAnual.getValor(); 
    }else if(relatorioMesAnual.getMes() == 10){
    	mes = "Outubro"+ "/" + ano;
    	valorMes = relatorioMesAnual.getValor(); 
    }else if(relatorioMesAnual.getMes() == 11){
    	mes = "Novembro"+ "/" + ano;
    	valorMes = relatorioMesAnual.getValor(); 
    }else if(relatorioMesAnual.getMes() == 12){
    	mes = "Dezembro"+ "/" + ano;
    	valorMes = relatorioMesAnual.getValor(); 
    }
%>

    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid" width="15"><center><a href="frameMeses.jsp?idOrcamentoEmpresa=<%=idOrcamentoEmpresa%>&mes=<%=relatorioMesAnual.getMes()%>&ano=<%=ano%>" target="frameMes2"><%=mes%></a></center></td>
      <td class = "grid" width="15"><center><%=Utilitaria.formatarNumero(valorMes,2).toString()%></center></td>
      <td class = "grid" width="15"><center><%=operacao%></center></td>
      
      
  	</tr>
<%
}
%>   
</table>
