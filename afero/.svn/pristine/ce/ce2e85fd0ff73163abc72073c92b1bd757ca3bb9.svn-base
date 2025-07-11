<%@page import="javax.xml.ws.RequestWrapper"%>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<%@page import="java.io.FileReader" %>
<%@page import="java.io.FileNotFoundException" %>
<%@page import="java.io.IOException" %>
<%@page import="java.util.List" %>
<%@page import="afero.model.Produto" %>
<%@page import="java.io.File" %>
<%@page import="java.io.FileOutputStream" %>
<%@page import="java.io.InputStream" %>
<%@page import="java.io.FileNotFoundException" %>
<%@page import="org.apache.tomcat.util.http.fileupload.FileItem"%>  
<%@page import="org.apache.tomcat.util.http.fileupload.FileUpload"%>
<%@page import="org.apache.tomcat.util.http.fileupload.FileUploadException"%>  
<%@page import="org.apache.tomcat.util.http.fileupload.DiskFileUpload"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@page import="org.apache.tomcat.util.http.fileupload.DefaultFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@page import="afero.model.Produto" %>
<%@page import="afero.model.Estoque" %>
<%@page import="afero.model.Preco" %>
<%@page import="afero.persistence.ProdutoDAO"%>
<%@page import="afero.persistence.EstoqueDAO"%>
<%@page import="afero.persistence.PrecoDAO"%>
<%@page import="java.util.*"%>
<%@page import="java.io.BufferedReader" %>
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
String cdBarra = "1";
int idSubGrupo = 1;
int idGrupo = 1;
//Dados Estoque
String idLoja = (String)session.getAttribute("idLoja");
String qtEstoque = "0";
String qtMinimo = "0";
String qtMaximo = "0";
String usuarioEstoque = "afero";
String idEstoque = "";
//Dados Preço
String idPreco = "";
String idUnidade = "1";
String precoUnitario ="0";
String custoReal = "0";
String custoDireto = "0";
String custoMedioGeral = "0";
String usuarioPreco = "afero";
String precoPadrao = "S";
String arquivoTemp = "c:/temp/arquivoUpload.csv";
//Fim Parametros

try {
	DiskFileUpload fu = new DiskFileUpload();

	List fileItems = fu.parseRequest(request);

	Iterator i = fileItems.iterator();

	FileItem fi = (FileItem)i.next();

	InputStream in = fi.getInputStream();

	File file = new File(arquivoTemp);

	FileOutputStream fos = new FileOutputStream(file);

	int c;
	while((c = in.read()) != -1)
	fos.write(c);

	fos.close();
	out.println("arquivo salvo: "+arquivoTemp);
	}
	catch(Exception e) {
	out.println(e.toString());
	}

try{
	ProdutoDAO dao = new ProdutoDAO(conn);
	PrecoDAO daoPreco = new PrecoDAO(conn);
	EstoqueDAO daoEstoque = new EstoqueDAO(conn);
	int cdProduto = 0;
	int cdEstoque = 0;
	String line = null;      
    int i =0;
    FileReader fr = new FileReader(arquivoTemp);  
    // BufferedReader para o FileReader:      
    BufferedReader br = new BufferedReader(fr);      
     while ((line = br.readLine()) != null) {      
          if ((line != null) || (!line.isEmpty())){
        	 System.out.println(line); 
        	 String[] fields = new String[line.length()]; 
        	 fields = line.split(";");
        	 Produto produto = new Produto();
        	 Estoque estoque = new Estoque();
        	 Preco preco = new Preco();
        	 
        	 produto.setIdDivisao(1);
        	 produto.setIdSubGrupo(1);
        	 produto.setIdGrupo(1);
        	 produto.setStatus(status);
        	 produto.setTipoProduto(tipoProduto);
        	 produto.setUsuario(usuarioProduto);  
        	 produto.setNmProduto(fields[i]);//0
        	 i++;
        	 produto.setCdBarra(fields[i]);//1
        	 i++;
        	 produto.setDsProduto(fields[i]);//2
        	 i++;
        	 
        	 //preco.setCustoDireto(Float.parseFloat(custoDireto));
        	 //preco.setCustoMedioGeral(Float.parseFloat(custoMedioGeral));
        	 //preco.setCustoReal(Float.parseFloat(custoReal));
        	 //preco.setIdUnidade(Integer.parseInt(idUnidade));
        	 preco.setPrecoPadrao(precoPadrao);
        	 preco.setUsuario(usuarioPreco);
        	 preco.setPreco(Float.parseFloat(fields[i]));//3
        	 i++;
        	 
        	 estoque.setIdLoja(Integer.parseInt(idLoja));
        	 estoque.setQtMaximo(Double.parseDouble(qtMaximo));
        	 estoque.setQtMinimo(Double.parseDouble(qtMinimo));
        	 estoque.setQtEstoque(Double.parseDouble(fields[i]));//4
        	 estoque.setStatus(status);
        	 estoque.setUsuario(usuarioEstoque);
        	 i++;
        	 
        	 idUnidade = fields[i];//5
    		 if (idUnidade.equalsIgnoreCase("Un")) {
    			 idUnidade = "1";
       		 } else if (idUnidade.equalsIgnoreCase("Cx")) {
       			idUnidade = "2";
       		 } else if (idUnidade.equalsIgnoreCase("Pç")) {
       			idUnidade = "3";
       		 } else if (idUnidade.equalsIgnoreCase("Pct")) {
       			idUnidade = "4";
       		 } else if (idUnidade.equalsIgnoreCase("Hr")) {
       			idUnidade = "5";
       		 } else if (idUnidade.equalsIgnoreCase("Fr")) {
       			idUnidade = "6";
       		 } else if (idUnidade.equalsIgnoreCase("Kg")) {
       			idUnidade = "7";
       		 } else if (idUnidade.equalsIgnoreCase("Met")) {
       			idUnidade = "8";
       		 } else if (idUnidade.equalsIgnoreCase("Ml")) {
       			idUnidade = "9";
       		 } else if (idUnidade.equalsIgnoreCase("Sc")) {
       			idUnidade = "10";
       		 } else {
        		idUnidade = "1";
       		 }
        	 i++;
        	 custoDireto = fields[i];//6
        	 custoReal = fields[i];//6
        	 i++;
        	 custoMedioGeral = fields[i];//7
        	 
        	 preco.setIdUnidade(Integer.parseInt(idUnidade));        	 
        	 preco.setCustoDireto(Float.parseFloat(custoDireto));
        	 preco.setCustoReal(Float.parseFloat(custoReal));
        	 preco.setCustoMedioGeral(Float.parseFloat(custoMedioGeral));        	 
        	 
        	 //inclui o produto
        	 cdProduto = dao.incluirProd(produto);

        	 //inclui o estoque do produto
        	 estoque.setIdProduto(cdProduto);
        	 cdEstoque = daoEstoque.incluirProduto(estoque);
        	 
        	 //inclui o preço do produto
        	 preco.setIdEstoque(cdEstoque);
        	 daoPreco.incluir(preco);
        	 
        	 i=0;
        	  
          }
      }     
     fr.close();
     br.close();
	  %>
		<table border="0" width="100%">
			<tr>
 				<th class="grid"><font color="red">IMPORTAÇÂO FINALIZADA!!!</font></th>
			</tr>
		</table>
	  <%	
  }catch(Exception e) {
	  //throw new Exception(e);
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