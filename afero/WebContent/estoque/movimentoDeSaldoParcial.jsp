<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.PedidoSaida" %>
<%@ page import="afero.model.MapaEntregaData" %>
<%@ page import="afero.model.Entrega" %>
<%@ page import="afero.model.Orcamento" %>
<%@ page import="afero.model.EntradaProdutos" %>
<%@ page import="afero.model.Entidade" %>
<%@ page import="afero.persistence.OrcamentoDAO" %>
<%@ page import="afero.persistence.EntregaDAO" %>
<%@ page import="afero.persistence.EntidadeDAO" %>
<%@ page import="afero.persistence.OrdemServicoDAO" %>
<%@ page import="afero.persistence.PedidoSaidaDAO" %>
<%@ page import="afero.persistence.PedidoEntradaItemDAO" %>
<%@ page import="afero.model.EntradaProdutos" %>
<%@ page import="afero.model.SaidasProdutos" %>
<%@ page import="afero.model.Entidade" %>
<%@ page import="afero.persistence.EntregaDAO" %>
<%@ page import="afero.persistence.EntidadeDAO" %>
<%@ page import="afero.persistence.OrdemServicoDAO" %>
<%@ page import="afero.persistence.PedidoSaidaDAO" %>
<%@ page import="afero.persistence.PedidoSaidaItemDAO" %>
<%@ page import="afero.persistence.PedidoEntradaItemDAO" %>
<%@page import="afero.util.Utilitaria"%>
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
String idLoja = request.getParameter("idLoja");
String idProduto = request.getParameter("idProduto");
ConverteDate converte = new ConverteDate();
PedidoEntradaItemDAO dao = null;
PedidoSaidaItemDAO daoSaida = null;
String nomeEntidade = request.getParameter("nomeEntidade");
String acao = request.getParameter("acao");
String dataIni = request.getParameter("dataIni");
String dataFim = request.getParameter("dataFim");
String status =request.getParameter("status");
String clausula = "";
String clausulaSaida = "";

clausula = " WHERE  p.idProduto = "+Integer.parseInt(idProduto)+" AND pe.dtPed BETWEEN '"+converte.DMYToYMDI(dataIni)+" 00:00:00' AND '"+converte.DMYToYMDI(dataFim)+" 23:59:59'"; 
    
if(!idLoja.equalsIgnoreCase("0")){
	clausula = clausula + " AND pe.idLoja= " + Integer.parseInt(idLoja);
}
clausula = clausula + " order by pe.dtPed ";
//seleciona todos os registros do banco de dados
List list;
dao = new PedidoEntradaItemDAO(conn);
list = dao.listarEntrada(clausula);

int cont = 0;
%>
<body onload="document.forms[0].elements[0].focus();" >

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
<%
String dsStatus = "";
float total = 0;
//Utiliza o ResultSet para trazer os registros do banco de dados
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	EntradaProdutos entradaProd = (EntradaProdutos) it.next();
if(entradaProd.getStatus().equalsIgnoreCase("A")){
  total+=entradaProd.getQuant();
}else if(entradaProd.getStatus().equalsIgnoreCase("F")){
	total+=entradaProd.getQuant();
}
}

//SAIDAS

clausulaSaida = " WHERE  p.idProduto = "+Integer.parseInt(idProduto)+" AND ps.dtPed BETWEEN '"+converte.DMYToYMDI(dataIni)+" 00:00:00' AND '"+converte.DMYToYMDI(dataFim)+" 23:59:59'"; 
    
if(!idLoja.equalsIgnoreCase("0")){
	clausulaSaida = clausulaSaida + " AND ps.idLoja= " + Integer.parseInt(idLoja);
}
clausulaSaida = clausulaSaida + " order by ps.dtPed ";
//seleciona todos os registros do banco de dados
List listSaida;
daoSaida = new PedidoSaidaItemDAO(conn);
listSaida = daoSaida.listarSaidaItem(clausulaSaida);
float totalSaida = 0;

//Utiliza o ResultSet para trazer os registros do banco de dados
for ( Iterator it = listSaida.iterator(); it.hasNext(); ) {
	SaidasProdutos saidasProd = (SaidasProdutos) it.next();
	if(saidasProd.getStatus().equalsIgnoreCase("A")){
		totalSaida+=saidasProd.getQuant();
		}else if(saidasProd.getStatus().equalsIgnoreCase("F")){
			totalSaida+=saidasProd.getQuant();
		}
	
}
%>
<tr>
  <td class = "grid" width="2%" colspan="4"><center><font color='red'><b>Total</b></font></center></td>
   <td class = "grid" width="2%"><center><font color='red'><b><%=Utilitaria.formatarNumero((total-totalSaida),2)%></b></font></center></td>
</tr>      
</table>
<%@include file="../fimConexao.jsp"%>