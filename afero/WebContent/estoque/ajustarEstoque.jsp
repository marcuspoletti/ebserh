<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.PedidoEntrada"%>
<%@page import="afero.model.PedidoSaida"%>
<%@page import="afero.model.Produto"%>
<%@page import="afero.model.Estoque"%>
<%@page import="afero.persistence.PedidoEntradaItemDAO"%>
<%@page import="afero.persistence.PedidoSaidaItemDAO"%>
<%@page import="afero.persistence.ProdutoDAO"%>
<%@page import="afero.persistence.EstoqueDAO"%>
<%@page import="afero.util.Utilitaria"%>
<%@ page import="afero.util.ConverteDate" %>
<%@page import="java.util.Calendar" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script language=JavaScript src="../js/abas.js" type=text/javascript></script>
<script src="../js/common.js" /></script>
<script>

function localizar() {
  
  document.forms[0].submit();
}  


function recarregar() {
  document.forms[0].action='ajustarEstoque.jsp';
  document.forms[0].submit();
}
</script>
<%
List listProduto;
String cdLoja = request.getParameter("idLoja");
int idLoja = 0;
if (cdLoja == null) {
	idLoja = 0;
}else {
	idLoja = Integer.parseInt(cdLoja);
}

if(idLoja != 0){
float quantidadeEntrada = 0;
float quantidadeSaida = 0;
PedidoEntradaItemDAO daoPedidoEntrada = new PedidoEntradaItemDAO(conn);
PedidoSaidaItemDAO daoPedidoSaida = new PedidoSaidaItemDAO(conn);
ProdutoDAO daoProduto = new ProdutoDAO(conn);
String clausula =" ORDER BY dsProduto ";
listProduto = daoProduto.listarProduto(clausula);
for ( Iterator it = listProduto.iterator();it.hasNext();) {
	String saldo = "";
	Produto prod = (Produto) it.next();
	quantidadeEntrada = daoPedidoEntrada.quantDeEntradaPorItem(prod.getIdProduto(), idLoja);
	quantidadeSaida = daoPedidoSaida.quantDeSaidaPorItem(prod.getIdProduto(), idLoja);
	EstoqueDAO daoEstoque = new EstoqueDAO(conn);
	daoEstoque.atualizarQuantidade(prod.getIdProduto(), idLoja, (quantidadeEntrada)-(quantidadeSaida));
	
}
}
  
  
%>
<script>
function atualizar() {
  document.forms[0].submit();
}
</script>

<%-- Início do Conteúdo da Página --%>
<div class="cabecalho_pagina">Ajustar Estoque</div>
<hr>
<form action="ajustarEstoque.jsp">


<table border="0" width="100%">
<tr>
      <th class="label">Loja</th>
      <td><select id="idLoja"name="idLoja" onchange="recarregar();" >
          <option value='0'>Todos...</option>
          <%@include file="../WEB-INF/jspf/combo/comboLoja.jspf" %></select>
          <script>comboSelect(document.forms[0].idLoja, '<%= idLoja %>');</script>
      </td>
  </tr>
 </table>
<table border="0" width="100%">
    <tr>
    <td align="center">
        <input type="button" value="Atualizar" class="botao" onclick="atualizar();">
    </td>
    </tr>

</table>
</form>
<br><br>
<%@include file="../fimConexao.jsp"%>