<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.Estoque" %>
<%@ page import="afero.model.Loja" %>
<%@ page import="afero.model.Produto" %>
<%@ page import="afero.persistence.EstoqueDAO" %>
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
       location.href = 'listarEstoque.jsp?acao=exc&idEstoque=' + id;   
  }  
}
</script>
<script src="../js/common.js"/>"></script>
<%
EstoqueDAO daoPesquisa;
EstoqueDAO dao;
EstoqueDAO daoExclusao;
Estoque estoquePesquisa;
String acao = request.getParameter("acao");
if (acao == null) acao = "listar";
String mensagem = request.getParameter("mensagem");
if(mensagem == null)mensagem = "";
String idEstoque = "";
String idLoja = "";
String usuario = (String)session.getAttribute("Login");

if (acao.equalsIgnoreCase("inc")) {
    idLoja = request.getParameter("idLoja");
    if(idLoja != null){
   	 	String [] idProdutoVetor = request.getParameterValues("idProduto");
    	String idProduto = "";
    	String qtEstoque = "";
    	String qtMinimo = "";
    	String qtMaximo = "";
    	idEstoque = request.getParameter("idEstoque");
    	if(idEstoque == null)idEstoque = "0";
    	if(idLoja == null)idLoja = "0";
    	for(int I=0;I<idProdutoVetor.length;I++) {
       		idProduto = request.getParameter("idProduto_"+idProdutoVetor[I]);
       		if(idProduto != null){
       			//qtEstoque = request.getParameter("qtEstoque_"+idProdutoVetor[I]);
       			qtMinimo = request.getParameter("qtMinima_"+idProdutoVetor[I]);
      			qtMaximo =  request.getParameter("qtMaxima_"+idProdutoVetor[I]);
     	 		Estoque estoque = new Estoque();
				try {
	 				 if (!acao.equalsIgnoreCase("inc")) {
						  estoque.setIdEstoque(Integer.parseInt(idEstoque));
				  	 }
	 			 	estoque.setIdLoja(Integer.parseInt(idLoja));
	 			 	estoque.setUsuario(usuario);
	 			 	estoque.setIdProduto(Integer.parseInt(idProduto));
	 			 	estoque.setQtEstoque(0);
	 			 	estoque.setQtMinimo(Utilitaria.toNumber(qtMinimo).doubleValue());
	 				estoque.setQtMaximo(Utilitaria.toNumber(qtMaximo).doubleValue());
	 				estoque.setStatus("A");
	 				estoque.setUsuario(usuario);
				} catch (NumberFormatException nfe) {
					throw new Exception("Código inválido");
				}

  			dao =  new EstoqueDAO(conn);
        daoPesquisa = new EstoqueDAO(conn);
        
 				if (acao.equalsIgnoreCase("inc")) {
	  				//inclui no banco de dados
	  				estoquePesquisa = daoPesquisa.procurarEstoqueLojaProduto(Integer.parseInt(idLoja),Integer.parseInt(idProdutoVetor[I]));
	  				if(estoquePesquisa != null){
	  					estoquePesquisa.setIdLoja(Integer.parseInt(idLoja));
	  					estoquePesquisa.setUsuario(usuario);
	  					estoquePesquisa.setIdProduto(Integer.parseInt(idProduto));
	  					estoquePesquisa.setQtEstoque(0);
	  					estoquePesquisa.setQtMinimo(Utilitaria.toNumber(qtMinimo).doubleValue());
	  					estoquePesquisa.setQtMaximo(Utilitaria.toNumber(qtMaximo).doubleValue());
	  					estoquePesquisa.setStatus("A");
	  					estoquePesquisa.setUsuario(usuario);
	  					dao.atualizarQuantMaxMin(estoquePesquisa);
	  				}else {
	  					dao.incluir(estoque);
	  				}
  					
  		 		}
   	 		}
    	}
    	
	}else {		
		response.sendRedirect("formEstoque.jsp?mensagem=Selecione Loja para Cadastrar o Estoque");
	}
}

daoExclusao = new EstoqueDAO(conn);

if (acao.equalsIgnoreCase("exc")) {
	  //exclui no banco de dados
	  if( ! daoExclusao.exclusaoIdEstoque(Integer.parseInt(request.getParameter("idEstoque")))) {
	    Estoque estExcluir = new Estoque();
	    EstoqueDAO daoExcluir = new EstoqueDAO(conn);
	    estExcluir.setIdEstoque(Integer.parseInt(request.getParameter("idEstoque")));
	    daoExcluir.excluir(estExcluir);
	  } else {
		  response.sendRedirect("listarEstoque.jsp?mensagem=Exclusão Inválida! Item já possui lançamentos.&acao=listar");
	  }
 }

//seleciona todos os registros do banco de dados
List list;
dao = new EstoqueDAO(conn);
list = dao.listarEstoque();
Produto produto = null;
Loja loja = null;

%>
<h1 class="cabecalho_pagina">Cadastro de Estoque</h1>

<a class="button" href="atualizarEstoque.jsp?acao=inc">Nova Atualização</a><br>
<body onload="document.forms[0].elements[0].focus();" >
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr>
      <th class="grid">&nbsp;</th>
      <th class="grid"><center>Descrição do Produto</center></th>
      <th class="grid">Loja</th>
      <th class="grid">Excluir</th>
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
if(list !=null) {
for ( Iterator it = list.iterator(); hasNext && cont < gridSize; hasNext = it.hasNext()) {
	Estoque est = (Estoque) it.next();
	ProdutoDAO daoProduto = new ProdutoDAO(conn);
	produto = daoProduto.procurarProduto(est.getIdProduto());
	LojaDAO daoLoja = new LojaDAO(conn);
	loja = daoLoja.procurarLoja(est.getIdLoja());
	cont++;

%>
    <tr>
      <td class = "grid" width="2%"><center><%=rowNum+cont%></center></td>
      <td class = "grid"><center><%=produto.getDsProduto()%></center></td>
      <td class = "grid"><center><%=loja.getApelido() %></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=rowNum+cont%>,<%=est.getIdEstoque()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
  	</tr>
<%
}
}
%>   
</table>
<br >
<%  if (rowNum != 0 || hasNext) { %>
        <center>
<%      if (rowNum != 0) { %>
<a class="link" href="listarEstoque.jsp?rowNum=<%=0%>">Primeira</a>&nbsp&nbsp
|&nbsp&nbsp<a class="link" href="listarEstoque.jsp?rowNum=<%=rowNum-gridSize%>">< Anterior</a>&nbsp&nbsp
<%      } else { %>
Primeira&nbsp&nbsp|&nbsp&nbsp< Anterior&nbsp
<%      } %>
<%      if (hasNext) { %>
|&nbsp&nbsp<a class="link" href="listarEstoque.jsp?rowNum=<%=rowNum+gridSize%>">Próxima ></a>&nbsp&nbsp
|&nbsp&nbsp<a class="link" href="listarEstoque.jsp?rowNum=<%=rowCount-gridSize%>">Última</a>
<%      } else { %>
|&nbsp&nbsp Próxima >&nbsp&nbsp|&nbsp&nbspÚltima
<%      } %>
        </center>
<%  } %>
<%@include file="../fimConexao.jsp"%>
