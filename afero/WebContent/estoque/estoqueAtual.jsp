<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.PedidoSaida" %>
<%@ page import="afero.model.MapaEntregaData" %>
<%@ page import="afero.model.Entrega" %>
<%@ page import="afero.model.Estoque" %>
<%@ page import="afero.model.Orcamento" %>
<%@ page import="afero.model.EntradaProdutos" %>
<%@ page import="afero.model.Entidade" %>
<%@ page import="afero.persistence.OrcamentoDAO" %>
<%@ page import="afero.persistence.EntregaDAO" %>
<%@ page import="afero.persistence.EntidadeDAO" %>
<%@ page import="afero.persistence.OrdemServicoDAO" %>
<%@ page import="afero.persistence.PedidoSaidaDAO" %>
<%@ page import="afero.persistence.EstoqueDAO" %>
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
double minimo = 0;
double maximo = 0;
double atual = 0;
String idLoja = request.getParameter("idLoja");
String idProduto = request.getParameter("idProduto");
ConverteDate converte = new ConverteDate();
EstoqueDAO dao = null;
dao = new EstoqueDAO(conn);
Estoque estoque = dao.procurarEstoque(Integer.parseInt(idProduto), Integer.parseInt(idLoja));
if(estoque != null){
%>
<body onload="document.forms[0].elements[0].focus();" >

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr">
      <th class="grid" width="3%"><center>Estoque Mínimo</center></th>
      <th class="grid" width="2%"><center>Estoque Maximo</center></th>
      <th class="grid" width="2%"><center>Estoque Atual</center></th>
    </tr>    
   <tr>
      <%if(estoque.getQtMinimo() <= 0){
    	  minimo = 0;
      }else{
    	  minimo =estoque.getQtMinimo(); 
      }
      if(estoque.getQtMaximo() <= 0){
    	  maximo = 0;
      }else{
    	  maximo =estoque.getQtMaximo(); 
      }
      if(estoque.getQtEstoque() <= 0){
    	  atual = estoque.getQtEstoque();
      }else{
    	  atual =estoque.getQtEstoque(); 
      }
      %>
      <td class = "grid" width="2%"><center><%=Utilitaria.formatarNumero(minimo,2)%></center></td>
      <td class = "grid" width="2%"><center><%=Utilitaria.formatarNumero(maximo,2)%></center></td>
      <td class = "grid" width="2%"><center><b><%=Utilitaria.formatarNumero(atual,2)%></b></center></td>
  	</tr>

</table>
<%}%>
<%@include file="../fimConexao.jsp"%>