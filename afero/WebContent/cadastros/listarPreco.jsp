<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.Estoque" %>
<%@ page import="afero.model.Preco" %>
<%@ page import="afero.model.Produto" %>
<%@ page import="afero.model.Loja" %>
<%@ page import="afero.persistence.EstoqueDAO" %>
<%@ page import="afero.persistence.PrecoDAO" %>
<%@ page import="afero.persistence.ProdutoDAO" %>
<%@ page import="afero.persistence.LojaDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<%@page import="afero.util.Utilitaria"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function confirmaExcluir(cont, id) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarPreco.jsp?acao=exc&idPreco=' + id;   
  }  
}
</script>
<script src="../js/common.js"/></script>
<%

PrecoDAO dao;
PrecoDAO daoPreco;
PrecoDAO daoPrecoUpdate;
Preco precoUpdate;
String acao = request.getParameter("acao");
if (acao == null) acao = "listar";

String idEstoque = "";
String idPreco = "";
String idUnidade = "";
String precoUnitario ="";
String usuario = (String)session.getAttribute("Login");
if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu")) {
    String [] idProdutoVetor = request.getParameterValues("idProduto");
    String idProduto = "";
    idPreco = request.getParameter("idPreco");
    if(idPreco == null)idPreco="0";
    for(int I=0;I<idProdutoVetor.length;I++){
       idProduto = request.getParameter("idProduto_"+idProdutoVetor[I]);
       idEstoque = request.getParameter("idEstoque_"+idProdutoVetor[I]);
	   idUnidade = request.getParameter("idUnidade_"+idProdutoVetor[I]);
       Preco preco = new Preco();
       if(idProduto != null){
      	 if(!idEstoque.equals("0") && !idUnidade.equals("0")){
    	  
					try {
			   			 precoUnitario = request.getParameter("preco_"+idProdutoVetor[I]);
	 			 		 if (!acao.equalsIgnoreCase("inc")){
							  preco.setIdPreco(Integer.parseInt(idPreco));
						  }
	 					  preco.setIdEstoque(Integer.parseInt(idEstoque));
	 					  preco.setIdUnidade(Integer.parseInt(idUnidade));
	 					  preco.setPreco(Utilitaria.toNumber(precoUnitario).floatValue());
	 				 	  preco.setUsuario(usuario);
					}catch (NumberFormatException nfe) {
						throw new Exception("Código inválido");
					}
    	   
  					dao = new PrecoDAO(conn);
  					daoPreco = new PrecoDAO(conn);
  					daoPrecoUpdate = new PrecoDAO(conn);
  					
 		 			if (acao.equalsIgnoreCase("inc")) {
	  					//inclui no banco de dados
 		 				precoUpdate = daoPreco.procurarPrecoList(Integer.parseInt(idEstoque), Integer.parseInt(idProdutoVetor[I]));
 	  					if(precoUpdate != null){
 	  						daoPrecoUpdate.atualizar(precoUpdate);
 	  					}
  						dao.incluir(preco);
  					 } 
 					 if (acao.equalsIgnoreCase("atu")) {
	  					//atualiza no banco de dados
					    dao.atualizar(preco);
  					 }
    		      
	}else{
		   response.sendRedirect("formPreco.jsp?mensagem=Selecione a Unidade e Estoque");
	}
   }
       
}
   
} 
if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	       Preco preExcluir = new Preco();
	       PrecoDAO daoExcluir = new PrecoDAO(conn);
	       preExcluir.setIdPreco(Integer.parseInt(request.getParameter("idPreco")));
	       daoExcluir.excluir(preExcluir);
 }

//seleciona todos os registros do banco de dados
List list;
dao = new PrecoDAO(conn);
String clausula = "";
list = dao.listarPreco(clausula);
Produto produto = null;
Preco preListar = null;
Estoque estListar = null;
Loja loja = null;
%>
<h1 class="cabecalho_pagina">Cadastro de Preço</h1>

|<a class="button" href="formPreco.jsp?acao=inc">Novo Cadastro</a>|<br>
<hr>
<body onload="document.forms[0].elements[0].focus();" >
<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr">
      <th class="grid">&nbsp;</th>
      <th class="grid"><center>Descrição do Produto</center></th>
      <th class="grid"><center>Loja</center></th>
      <th class="grid"><center>Preco</center></th>
      <!--<th class="grid">Excluir</th> -->
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
    rowLast = rowNum+gridSize+1; 
    if (rowLast >= rowCount && rowCount > 0) rowLast = rowCount;
    if (rowNum > rowLast) rowNum = 0;
    list = list.subList(rowNum, rowLast);
  }
  hasNext = true;
}

//Utiliza o ResultSet para trazer os registros do banco de dados
for ( Iterator it = list.iterator(); hasNext && cont < gridSize; hasNext = it.hasNext()) {
	preListar = (Preco) it.next();
	estListar = new Estoque();
	EstoqueDAO daoEstoqueListar = new EstoqueDAO(conn);
	estListar = daoEstoqueListar.procurarEstoque(preListar.getIdEstoque());
	ProdutoDAO daoProduto = new ProdutoDAO(conn);
	LojaDAO daoLoja = new LojaDAO(conn);
	loja = daoLoja.procurarLoja(estListar.getIdLoja());
	produto = daoProduto.procurarProduto(estListar.getIdProduto());
	cont++;

%>
    <tr>
      <td class = "grid" width="2%"><center><%=rowNum+cont%></center></td>
      <td class = "grid"><center><%=produto.getDsProduto()%></center></td>
      <td class = "grid"><center><%=loja.getApelido()%></center></td>
      <td class = "grid"><center><%=Utilitaria.formatarNumero(preListar.getPreco(),2).toString()%></center></td>
    <!--<td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=rowNum+cont%>,<%=preListar.getIdPreco()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>--> 
  	</tr>
<%
}
%>   
</table>
<br >
<%  if (rowNum != 0 || hasNext) { %>
        <center>
<%      if (rowNum != 0) { %>
<a class="link" href="listarPreco.jsp?rowNum=<%=0%>">Primeira</a>&nbsp&nbsp
|&nbsp&nbsp<a class="link" href="listarPreco.jsp?rowNum=<%=rowNum-gridSize%>">< Anterior</a>&nbsp&nbsp
<%      } else { %>
Primeira&nbsp&nbsp|&nbsp&nbsp< Anterior&nbsp
<%      } %>
<%      if (hasNext) { %>
|&nbsp&nbsp<a class="link" href="listarPreco.jsp?rowNum=<%=rowNum+gridSize%>">Próxima ></a>&nbsp&nbsp
|&nbsp&nbsp<a class="link" href="listarPreco.jsp?rowNum=<%=rowCount-gridSize%>">Última</a>
<%      } else { %>
|&nbsp&nbsp Próxima >&nbsp&nbsp|&nbsp&nbspÚltima
<%      } %>
        </center>
<%  } %>
<%@include file="../fimConexao.jsp"%>
