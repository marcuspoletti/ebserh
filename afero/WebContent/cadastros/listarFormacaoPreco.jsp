<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.FormacaoPreco" %>
<%@ page import="afero.util.Utilitaria" %>
<%@ page import="afero.persistence.FormacaoPrecoDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Date" %>
<%@ page import="afero.util.ConverteDate" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function confirmaExcluir(cont, id) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarFormacaoPreco.jsp?acao=exc&idFormacaoPreco=' + id;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.nomeFormacaoPreco.value = '';
  document.all.status.value = ''; //não está limpando
  document.forms[0].submit();
}  
</script>

<%
FormacaoPrecoDAO dao;
ConverteDate conDate = new ConverteDate();
String mensagem = request.getParameter("mensagem");
if(mensagem == null) mensagem="";
String acao = request.getParameter("acao");
if (acao == null) acao = "listar";

String idFormacaoPreco = "0";
String dsFormacaoPreco = "";
String usuario = (String)session.getAttribute("Login");
String dtMod = "";
String pFrete = "0";
String pIPI = "0";
String pOutrasDespesas = "0";
String pICMSEntrada = "0";
String pICMSSaida = "0";
String pCustoOperacional = "0";
String pOutrosImpostos = "0";
String pComissao = "0";
String pLucro = "0";
String status = "A";
String nomeFormacaoPreco = "";
String clausula = "";

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
	idFormacaoPreco = request.getParameter("idFormacaoPreco");
	dsFormacaoPreco = request.getParameter("dsFormacaoPreco");
	pFrete = request.getParameter("pFrete");
	pIPI   = request.getParameter("pIPI");
	pOutrasDespesas = request.getParameter("pOutrasDespesas");
	pICMSEntrada = request.getParameter("pICMSEntrada");
	pICMSSaida  = request.getParameter("pICMSSaida");
	pCustoOperacional = request.getParameter("pCustoOperacional");
	pOutrosImpostos = request.getParameter("pOutrosImpostos");
	pComissao = request.getParameter("pComissao");
	pLucro = request.getParameter("pLucro");
	status = request.getParameter("status");
         if(idFormacaoPreco == null)idFormacaoPreco="0";
         if(dsFormacaoPreco == null)dsFormacaoPreco="";
         if(pFrete == null)pFrete="0";
         if(pIPI == null)pIPI="0";
         if(pOutrasDespesas == null)pOutrasDespesas="0";
         if(pICMSEntrada == null)pICMSEntrada="0";
         if(pICMSSaida == null)pICMSSaida="0";
         if(pCustoOperacional == null)pCustoOperacional="0";
         if(pOutrosImpostos == null)pOutrosImpostos="0";
         if(pComissao == null)pComissao="0";
         if(pLucro == null)pLucro="0";
         if(status == null)status="A";
   
  

   FormacaoPreco formacaoPreco = new FormacaoPreco();

	try {
	  if (!acao.equalsIgnoreCase("inc")){
		  formacaoPreco.setIdFormacaoPreco(Integer.parseInt(idFormacaoPreco));
	  }
	  formacaoPreco.setDsFormacapPreco(dsFormacaoPreco);
	  formacaoPreco.setpFrete(Utilitaria.toNumber(pFrete).floatValue());
	  formacaoPreco.setpIpi(Utilitaria.toNumber(pIPI).floatValue());
	  formacaoPreco.setpOutrasDespesas(Utilitaria.toNumber(pOutrasDespesas).floatValue());
	  formacaoPreco.setpIcmsEntrada(Utilitaria.toNumber(pICMSEntrada).floatValue());
	  formacaoPreco.setpIcmsSaida(Utilitaria.toNumber(pICMSSaida).floatValue());
	  formacaoPreco.setpCustoOperacional(Utilitaria.toNumber(pCustoOperacional).floatValue());
	  formacaoPreco.setpOutrosImpostos(Utilitaria.toNumber(pOutrosImpostos).floatValue());
	  formacaoPreco.setpComissao(Utilitaria.toNumber(pComissao).floatValue());
	  formacaoPreco.setpLucro(Utilitaria.toNumber(pLucro).floatValue());
	  formacaoPreco.setStatus(status);
	  formacaoPreco.setUsuario(usuario);
	  
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}

  dao = new FormacaoPrecoDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {
	  //inclui no banco de dados
  	dao.incluir(formacaoPreco);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
	  dao.atualizar(formacaoPreco);

  } else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  if(!dao.exclusaoIdFormacaoPreco(Integer.parseInt(idFormacaoPreco))){
		  dao.excluir(formacaoPreco);
	  }else{
		  response.sendRedirect("listarFormacaoPreco.jsp?mensagem=Exclusão Inválida! Item já possui lançamentos.&acao=listar");
	  }
  }
} else {
 if (!acao.equalsIgnoreCase("voltar")) {
	 nomeFormacaoPreco = request.getParameter("nomeFormacaoPreco");
  }

  if (nomeFormacaoPreco!= null) {
    clausula = " WHERE dsFormacaoPreco LIKE '"+nomeFormacaoPreco+"%'";
  } 

}

//seleciona todos os registros do banco de dados
List list;
dao = new FormacaoPrecoDAO(conn);
clausula = clausula+" ORDER BY dsFormacaoPreco ";
list = dao.listarFormacaoPreco(clausula);

int cont = 0;
%>
<h1 class="cabecalho_pagina">Cadastro de Formação de Preço</h1>

|<a class="button" href="formFormacaoPreco.jsp?acao=inc">Novo Cadastro</a>|<br>
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<body onload="document.forms[0].elements[0].focus();" >
<form action="listarFormacaoPreco.jsp">
<table colspan="2">
  <tr>
    <th class='label'>Descrição da Formação Preço</th>
    <td><input type="text" name="nomeFormacaoPreco" <%if (nomeFormacaoPreco != null) { %>value="<%=nomeFormacaoPreco%>"<% }%>  size="40" maxlength="40"></td>
    <td><input class="button" type="button" value="Localizar" onClick="javascript: localizar();" /></td>
    <td><input class="button" type="button" value="Nova pesquisa" onClick="javascript: novaPesquisa();" /></td>
  </tr>
</table>
<hr>

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr>
      <th class="grid">&nbsp;</th>
      <th class="grid"><center>Descrição da Formação Preço</center></th>
      <th class="grid"><center>Frete</center></th>
      <th class="grid"><center>IPI</center></th>
      <th class="grid"><center>Outras Despesas</center></th>
      <th class="grid"><center>Status</center></th>
      <th class="grid">Excluir</th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	FormacaoPreco formPreco = (FormacaoPreco) it.next();
	cont++;

%>
   <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid" width="15%"><center><a href="formFormacaoPreco.jsp?acao=atu&idFormacaoPreco=<%=formPreco.getIdFormacaoPreco()%>"><%=formPreco.getDsFormacapPreco()%></a></center></td>
      <td class = "grid" width="5%"><center><%=Utilitaria.formatarNumero(formPreco.getpFrete(),2)%></center></td>
      <td class = "grid" width="5%"><center><%=Utilitaria.formatarNumero(formPreco.getpIpi(),2)%></center></td>
      <td class = "grid" width="5%"><center><%=Utilitaria.formatarNumero(formPreco.getpOutrasDespesas(),2)%></center></td>
      <td class = "grid" width="5%"><center><%=formPreco.getStatus()%></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=formPreco.getIdFormacaoPreco()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
  	</tr>
<%
}
%>      
</table>
</form>
<p align="right">|<a class="button" href="formFormacaoPreco.jsp?acao=inc">Novo Cadastro</a>|
<%@include file="../fimConexao.jsp"%>