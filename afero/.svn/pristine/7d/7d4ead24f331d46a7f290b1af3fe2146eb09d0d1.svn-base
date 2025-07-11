<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.CatTributaria" %>
<%@ page import="afero.persistence.CatTributariaDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="afero.util.Utilitaria"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function confirmaExcluir(cont, id) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarCatTributaria.jsp?acao=exc&idCatTributaria=' + id;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.nomeCatTributaria.value = '';
  document.forms[0].submit();
}  
</script>

<%
CatTributariaDAO dao;
CatTributariaDAO daoExclusao;


String acao = request.getParameter("acao");
if (acao == null) acao = "listar";

String dsCatTributaria = "";
String nomeCatTributaria = "";
String clausula = "";

String idCatTributaria = "0";
String cdCstIpi = "0";
String pIpi = "0";
String classeEnquadramento = "";
String codigoEnquadramento = "0";
String cnpjProdutor = "";
String cdCstPis = "0";
String pPis = "0";
String cdCstCofins = "0";
String pCofins = "0";
String status = "A";
String dtMod = "";
String usuario = (String)session.getAttribute("Login");

String mensagem = request.getParameter("mensagem");
if(mensagem == null)mensagem="";

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
    idCatTributaria = request.getParameter("idCatTributaria");
    dsCatTributaria = request.getParameter("dsCatTributaria");
    cdCstIpi = request.getParameter("cdCstIpi");
    pIpi = request.getParameter("pIpi");
    classeEnquadramento = request.getParameter("classeEnquadramento");
    codigoEnquadramento = request.getParameter("codigoEnquadramento");
    cnpjProdutor = request.getParameter("cnpjProdutor");
    cdCstPis = request.getParameter("cdCstPis");
    pPis = request.getParameter("pPis");
    cdCstCofins = request.getParameter("cdCstCofins");
    pCofins = request.getParameter("pCofins");
    status =  request.getParameter("status");
    nomeCatTributaria = request.getParameter("nomeCatTributaria");
    
    
    if(idCatTributaria == null)idCatTributaria = "0";
    if(dsCatTributaria == null)dsCatTributaria = "";
    if(cdCstIpi == null)cdCstIpi = "0";
    if(pIpi == null)pIpi ="0";
    if(classeEnquadramento == null)classeEnquadramento = "";
    if(codigoEnquadramento == null)codigoEnquadramento = "0";
    if(cnpjProdutor == null)cnpjProdutor ="";
    if(cdCstPis == null)cdCstPis = "0";
    if(pPis == null)pPis = "0";
    if(cdCstCofins == null)cdCstCofins ="0";
    if(pCofins == null)pCofins = "0";
    if(status == null)status ="A";
    
   
  

   CatTributaria catTributaria = new CatTributaria();

	try {
	   if (!acao.equalsIgnoreCase("inc")){
		   catTributaria.setIdCatTributaria(Utilitaria.toNumber(idCatTributaria).intValue());
             }
	   catTributaria.setDsCatTributaria(dsCatTributaria);
	   catTributaria.setCdCstIpi(Utilitaria.toNumber(cdCstIpi).intValue());
	   catTributaria.setpIpi(Utilitaria.toNumber(pIpi).floatValue());
	   catTributaria.setClasseEnquadramento(classeEnquadramento);
	   catTributaria.setCodigoEnquadramento(codigoEnquadramento);
	   catTributaria.setCnpjProdutor(cnpjProdutor);
	   catTributaria.setCdCstPis(Utilitaria.toNumber(cdCstPis).intValue());
	   catTributaria.setpPis(Utilitaria.toNumber(pPis).floatValue());
	   catTributaria.setCdCstCofins(Utilitaria.toNumber(cdCstCofins).intValue());
	   catTributaria.setpCofins(Utilitaria.toNumber(pCofins).floatValue());
	   catTributaria.setStatus(status);
	   catTributaria.setUsuario(usuario);
	   
	   
     
	  
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}

  dao = new CatTributariaDAO(conn);
  daoExclusao = new CatTributariaDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {
	  //inclui no banco de dados
  	dao.incluir(catTributaria);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
	  dao.atualizar(catTributaria);

  } else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  if(!daoExclusao.exclusaoIdCatTributaria(Integer.parseInt(idCatTributaria))) {
		  daoExclusao.excluir(catTributaria);
	  }else{
				response.sendRedirect("listarCatTributaria.jsp?mensagem=Exclusão Inválida! Item já possui lançamentos.&acao=listar");
	 }

   }
} else {
	if (!acao.equalsIgnoreCase("voltar")) {
		nomeCatTributaria = request.getParameter("nomeCatTributaria");
	}

	if (nomeCatTributaria != null) {
			clausula = " WHERE dsCatTributaria LIKE '" + nomeCatTributaria + "%'";
	}
}

//seleciona todos os registros do banco de dados
List list;
dao = new CatTributariaDAO(conn);
clausula = clausula + " ORDER BY dsCatTributaria ";
list = dao.listarCatTributaria(clausula);
int cont = 0;
%>
<h1 class="cabecalho_pagina">Cadastro de Tributário</h1>
|<a class="button" href="formCatTributaria.jsp?acao=inc">Novo Cadastro</a>|<br>
<body onload="document.forms[0].elements[0].focus();" >
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><%}%>
<form action="listarCatTributaria.jsp">
<table colspan="2">
  <tr>
    <th class='label'>Desc. do Cat. Trib.</th>
    <td><input type="text" name="nomeCatTributaria" <%if (nomeCatTributaria != null) { %>value="<%=nomeCatTributaria %>"<% }%>  size="40" maxlength="40"></td>
    <td><input class="button" type="button" value="Localizar" onClick="javascript: localizar();" /></td>
    <td><input class="button" type="button" value="Nova pesquisa" onClick="javascript: novaPesquisa();" /></td>
  </tr>
</table>
<hr>

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr>
      <th class="grid">&nbsp;</th>
      <th class="grid"><center>Cód. Cat. Trib</center></th>
      <th class="grid"><center>Desc. da Cat. Trib.</center></th>
      <th class="grid">Excluir</th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	CatTributaria catTributaria = (CatTributaria) it.next();
	cont++;

%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
       <td class = "grid" width="15%"><center><%=catTributaria.getIdCatTributaria()%></center></td>
      <td class = "grid"><center><a href="formCatTributaria.jsp?acao=atu&idCatTributaria=<%=catTributaria.getIdCatTributaria()%>"><%=catTributaria.getDsCatTributaria()%></a></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=catTributaria.getIdCatTributaria()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
  	</tr>
<%
}
%>   
</table>
</form>
<p align="right">|<a class="button" href="formCatTributaria.jsp?acao=inc">Novo Cadastro</a>|
<%@include file="../fimConexao.jsp"%>