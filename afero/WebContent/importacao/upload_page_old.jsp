<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<%@page import="java.io.InputStream" %>
<%@page import="java.util.List" %>
<%@page import="afero.model.Produto" %>
<%@page import="afero.model.Estoque" %>
<%@page import="afero.model.Preco" %>
<%@page import="afero.persistence.ProdutoDAO"%>
<%@page import="afero.persistence.EstoqueDAO"%>
<%@page import="afero.persistence.PrecoDAO"%>
<%@page import="java.util.*" %>
<%@page import="java.io.ByteArrayOutputStream" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<%@page language = "java"%>

<h1 class="cabecalho_pagina">Imp. Arquivo (.CSV)</h1>
<hr>
<body onload="document.forms[0].elements[0].focus();" >
<% 
//Parametros
//Dados Produtos
String dsProduto = "";
String nmProduto = "";
String tipoProduto = "PT";
String status ="A";
String dtCad = "";
String dtMod = "";
String nomeProduto = "";
int idDivisao = 0;
String usuarioProduto = "afero";
String cdBarra = "0";
int idSubGrupo = 0;
int idGrupo = 0;
//Dados Estoque
String idLoja = (String)session.getAttribute("idLoja");
String qtEstoque = "0";
String qtMinimo = "0";
String qtMaximo = "0";
String usuarioEstoque = "afero";
String idEstoque = "";
//Dados Preço
String idPreco = "";
String idUnidade = "2";
String precoUnitario ="0";
String custoReal = "0";
String custoDireto = "0";
String custoMedioGeral = "0";
String usuarioPreco = "afero";
String precoPadrao = "S";
//Fim Parametros
String contentType = request.getContentType (); 
if (contentType!= null){ 
InputStream in = request.getInputStream ();
ByteArrayOutputStream baos = new ByteArrayOutputStream ();
int tamanho = request.getContentLength();
byte b[] = new byte [tamanho];
int byteRead = 0; 
while ((byteRead = in.read(b, 0, tamanho))!= -1){ 
     baos.write (b, 0, byteRead); 
}
String dados = new String (baos.toByteArray ());
int k = 0; 
StringTokenizer st2 = new StringTokenizer(dados, ""); 
int dynamicArraySize = st2.countTokens() * 5;

String newDados = dados;//.replace(";",","); 
StringTokenizer st = new StringTokenizer(newDados, ";"); 
String[] values = new String[dynamicArraySize]; 
while (st.hasMoreTokens()){
  if(!st.nextToken().toString().equalsIgnoreCase("Content-Type: application/octet-stream")||
		  !st.nextToken().toString().equalsIgnoreCase("filename=importacao.csv") || !st.nextToken().toString().equalsIgnoreCase("name=file")){
     values[k] = st.nextToken("; \n"); 
     k++;
  }
}
int newSize = 1;
//Instanciando as classes DAO
ProdutoDAO dao = new ProdutoDAO(conn);
PrecoDAO daoPreco = new PrecoDAO(conn);
EstoqueDAO daoEstoque = new EstoqueDAO(conn);
//Instanciando as classes DAO
List <Produto> impProduto = new ArrayList <Produto>();
int j = 0; 
int cdProduto = 0;
int cdEstoque = 0;
for(int i=newSize;i < k; i++){ 
//Instanciando Produto, Estoque, Preço
Produto produto = new Produto();
Estoque estoque = new Estoque();
Preco preco = new Preco();
 //Fim de Intancia
 //Produto
produto.setIdDivisao(174);
produto.setIdSubGrupo(38);
produto.setIdGrupo(12);
produto.setStatus(status);
produto.setTipoProduto(tipoProduto);
produto.setUsuario(usuarioProduto);
//produto.setNmProduto(values[i].trim());
System.out.println(values[i].trim());
i++;
if(!values[i].trim().equalsIgnoreCase("") || !values[i].trim().equalsIgnoreCase(" ")){
         produto.setCdBarra(values[i].trim());
}else{
	produto.setCdBarra("0");
}
System.out.println(values[i].trim());
i++;
//produto.setDsProduto(values[i].trim());
System.out.println(values[i].trim());
i++;
//Preço
preco.setCustoDireto(Float.parseFloat(custoDireto));
preco.setCustoMedioGeral(Float.parseFloat(custoMedioGeral));
preco.setCustoReal(Float.parseFloat(custoReal));
preco.setIdUnidade(Integer.parseInt(idUnidade));
preco.setPrecoPadrao(precoPadrao);
preco.setUsuario(usuarioPreco);
//preco.setPreco(Float.parseFloat(values[i].trim()));
System.out.println(values[i].trim());
i++;
estoque.setIdLoja(Integer.parseInt(idLoja));
estoque.setQtMaximo(Double.parseDouble(qtMaximo));
estoque.setQtMinimo(Double.parseDouble(qtMinimo));
//estoque.setQtEstoque(Double.parseDouble(values[i].trim()));
System.out.println(values[i].trim());
estoque.setStatus(status);
estoque.setUsuario(usuarioEstoque);
//cdProduto = dao.incluirProd(produto);
//estoque.setIdProduto(cdProduto);
//cdEstoque = daoEstoque.incluirProduto(estoque);
//preco.setIdEstoque(cdEstoque);
//daoPreco.incluir(preco);
newSize = i; 
j++; 
}
}else{
%>
<table border="0" width="100%">
<tr>
  <th class="grid"><font color="red">ERRO NA IMPORTAÇÂO !!!</font></th>
</tr>
</table>
<%	
}
 
%>
</body>
<%@include file="../fimConexao.jsp"%>
<br><br>