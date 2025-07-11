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
<%@page import="afero.model.RelatorioMeses"%>
<%@page import="afero.model.PlanoConta"%>
<%@page import="afero.persistence.PlanoContaDAO"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />


<%
OrcamentoEmpresaItemDAO daoMeses;
ConverteDate conDate = new ConverteDate();
String mensagem = request.getParameter("mensagem");
if(mensagem == null)mensagem = "";
String acao = request.getParameter("acao");
if (acao == null) acao = "listar";
String idOrcamentoEmpresa = request.getParameter("idOrcamentoEmpresa");
String meses = request.getParameter("mes");
if(idOrcamentoEmpresa == null)idOrcamentoEmpresa = "0";
if(meses == null)meses = "0";
String ano = request.getParameter("ano");
if(ano == null)ano = "2010";

//seleciona todos os registros do banco de dados
List listMeses;
daoMeses = new OrcamentoEmpresaItemDAO(conn);
listMeses = daoMeses.listarRelatorioMes(Integer.parseInt(idOrcamentoEmpresa), Integer.parseInt(meses), Integer.parseInt(ano));
int cont = 0;
%>
<body onload="document.forms[0].elements[0].focus();" >
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
String operacao = "";
String mes = "";
float valorMes = 0;
for ( Iterator itMeses = listMeses.iterator(); itMeses.hasNext(); ) {
	RelatorioMeses relatorioMeses = (RelatorioMeses) itMeses.next();
	PlanoContaDAO daoPlanoConta = new PlanoContaDAO(conn);
	PlanoConta planoConta = daoPlanoConta.procurarPlanoConta(relatorioMeses.getPlanoConta());
    cont++;
    if(relatorioMeses.getDc().equals("D")){
    	operacao = "DÉBITO";
    	
    }else if(relatorioMeses.getDc().equals("C")){
    	operacao = "CRÉDITO";
    }
    if(relatorioMeses.getMes() == 1){
    	mes = "Janeiro";
    	valorMes = relatorioMeses.getValor(); 
    }else if(relatorioMeses.getMes() == 2){
    	mes = "Fevereiro";
    	valorMes = relatorioMeses.getValor(); 
    }else if(relatorioMeses.getMes() == 3){
    	mes = "Março";
    	valorMes = relatorioMeses.getValor(); 
    }else if(relatorioMeses.getMes() == 4){
    	mes = "Abril";
    	valorMes = relatorioMeses.getValor(); 
    }else if(relatorioMeses.getMes() == 5){
    	mes = "Maio";
    	valorMes = relatorioMeses.getValor(); 
    }else if(relatorioMeses.getMes() == 6){
    	mes = "Junho";
    	valorMes = relatorioMeses.getValor(); 
    }else if(relatorioMeses.getMes() == 7){
    	mes = "Julho";
    	valorMes = relatorioMeses.getValor(); 
    }else if(relatorioMeses.getMes() == 8){
    	mes = "Agosto";
    	valorMes = relatorioMeses.getValor(); 
    }else if(relatorioMeses.getMes() == 9){
    	mes = "Setembro";
    	valorMes = relatorioMeses.getValor(); 
    }else if(relatorioMeses.getMes() == 10){
    	mes = "Outubro";
    	valorMes = relatorioMeses.getValor(); 
    }else if(relatorioMeses.getMes() == 11){
    	mes = "Novembro";
    	valorMes = relatorioMeses.getValor(); 
    }else if(relatorioMeses.getMes() == 12){
    	mes = "Dezembro";
    	valorMes = relatorioMeses.getValor(); 
    }
%>

    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid" width="15"><center><%=mes%></center></td>
      <td class = "grid" width="15"><center><%=planoConta.getNmPlanoConta()%></center></td>
      <td class = "grid" width="15"><center><%=Utilitaria.formatarNumero(relatorioMeses.getValor(),2).toString()%></center></td>
      <td class = "grid" width="15"><center><%=operacao%></center></td>
      
      
      
  	</tr>
<%
}
%>   
</table>
