<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.RetornoNotaFiscal" %>
<%@ page import="afero.persistence.RetornoNotaFiscalDAO" %>
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
	  document.all.idPedidoLocalizar.value = ''; //não está limpando
	  document.forms[0].submit();
}  
</script>

<%
String idPedidoLocalizar;
if(request.getParameter("idPedidoLocalizar") == null || request.getParameter("idPedidoLocalizar") == ""){
	idPedidoLocalizar = "0";
} else {
	idPedidoLocalizar = request.getParameter("idPedidoLocalizar");
}
ConverteDate converte = new ConverteDate();
String acao = request.getParameter("acao");
RetornoNotaFiscalDAO daoRetornoNotaFiscalDAO; 
String clausula = "";
 
  
//seleciona todos os registros do banco de dados
List list;
daoRetornoNotaFiscalDAO = new RetornoNotaFiscalDAO(conn);
clausula = clausula+" WHERE idPedidoSaida = "+Integer.parseInt(idPedidoLocalizar)+" ORDER BY dtRegistro desc";
list = daoRetornoNotaFiscalDAO.listarRetornoNotaFiscal(clausula);

int cont = 0;
%>
<body onload="document.forms[0].elements[0].focus();" >
<form method="post" action="consultarCancelamento.jsp">
<table colspan="2">
  <tr>
    <th class='label'>Número da Referencia da Autorização</th>
    <td><input type="text" name="idPedidoLocalizar" <%if (idPedidoLocalizar != "0") { %>value="<%=idPedidoLocalizar%>"<% }%>  size="20" maxlength="20"></td>
    <td><input class="button" type="button" value="Localizar" onClick="javascript: localizar();" /></td>
    <td><input class="button" type="button" value="Nova pesquisa" onClick="javascript: novaPesquisa();" /></td>
  </tr>
</table>
<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr>
      <th class="grid" width="2%">&nbsp;</th>
      <th class="grid" width="2%"><center>Cód do retorno da Nota</center></th>
      <th class="grid" width="2%"><center>Referência</center></th>
      <th class="grid" width="5%"><center>Mensagem</center></th>
      <th class="grid" width="2%">Data</th>
      <th class="grid" width="2%">Usuário</th>
      <th class="grid" width="2%">Cancelamento</th>
    </tr>
<%
RetornoNotaFiscal retornoNotaFiscal = new RetornoNotaFiscal();
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	retornoNotaFiscal = (RetornoNotaFiscal) it.next();
	String tempoPecorrido = daoRetornoNotaFiscalDAO.PeriodoNotaFiscal(retornoNotaFiscal.getId_pedido_saida(), retornoNotaFiscal.getId_retorno_nota_fiscal());
	Integer tempoNota = Integer.parseInt(tempoPecorrido);

%>
    
   <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid" width="2%"><center><%=retornoNotaFiscal.getId_retorno_nota_fiscal()%></center></td>
      <td class = "grid" width="3%"><font color="red"><center><%=retornoNotaFiscal.getId_pedido_saida()%></center></font></td>
      <td class = "grid" width="3%"><font color="red"><center><%=retornoNotaFiscal.getMensagem_retorno()%></center></font></td>
      <td class = "grid" width="3%"><font color="red"><center><%=converte.dateToString(retornoNotaFiscal.getDt_registro())%></center></font></td>
      <td class = "grid" width="3%"><font color="red"><center><%=retornoNotaFiscal.getUsuario()%></center></font></td>     
      <%if(tempoNota <= 24){%>
      	<td class = "grid" width="3%"><center><a target="_blank" href="../notafiscal/listarCancelamento.jsp?idRetornoNotaFiscal=<%=retornoNotaFiscal.getId_retorno_nota_fiscal()%>&referencia=<%=retornoNotaFiscal.getId_pedido_saida()%>&acao=<%="inc"%>"><img border = "0" src="../images/delete.gif"></a></center></td>
     <%}else{%> 
        <td class = "grid" width="2%"><center><%="-"%></center></td>
      <%}%>
  </tr>
<%
 cont++;
}
%>      
</table></form>
<%@include file="../fimConexao.jsp"%>