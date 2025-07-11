<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.persistence.ConfigGeralDAO" %>
<%@ page import="afero.persistence.LojaDAO" %>
<%@ page import="afero.model.ConfigGeral" %>
<%@ page import="afero.model.Loja" %>
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
       location.href = "listarConfigGeral.jsp?acao=exc&idLoja=" + id;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.nomeLoja.value = '';
  document.forms[0].submit();
}  
</script>

<%

String mensagem = request.getParameter("mensagem");
if(mensagem == null) mensagem="";
ConfigGeralDAO dao;

String acao = request.getParameter("acao");
if (acao == null) acao = "listar";

String clausula = "";

String idLoja = "0";
String menuModulo    = "";
String emailServidor = "";
String emailPorta    = "";
String emailUsuario  = "";
String emailSenha    = "";
String integracao    = "";

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
	idLoja        = request.getParameter("idLoja");
	menuModulo    = request.getParameter("menuModulo");
	emailServidor = request.getParameter("emailServidor");
	emailPorta    = request.getParameter("emailPorta");
         emailUsuario  = request.getParameter("emailUsuario");
	emailSenha    = request.getParameter("emailSenha");
	integracao    = request.getParameter("integracao");
    if(idLoja == null)idLoja = "0";
    if(menuModulo == null)menuModulo = "";
    if(emailServidor == null)emailServidor = "";
    if(emailPorta == null)emailPorta = "";
    if(emailUsuario == null)emailUsuario="";
    if(emailSenha == null)emailSenha = "";
    if(integracao == null)integracao = "N";

  ConfigGeral configGeral = new ConfigGeral();
  

try {
    
     configGeral.setIdLoja(Integer.parseInt(idLoja));
     configGeral.setMenuModulo(menuModulo);
     configGeral.setEmailServidor(emailServidor);
     configGeral.setEmailSenha(emailSenha);
     configGeral.setEmailPorta(emailPorta);
     configGeral.setEmailUsuario(emailUsuario);
     configGeral.setIntegraPedidoSaidaFinan(integracao);
	  
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}

  dao = new ConfigGeralDAO(conn);
 
 
  if (acao.equalsIgnoreCase("inc")) {
	  //inclui no banco de dados
    if(idLoja.equalsIgnoreCase("0")){
    	response.sendRedirect("formConfigGeral.jsp?acao=inc&mensagem=Loja Inexistente !!!");
    }else{
    	dao.incluir(configGeral);
    	dao.atualizaIntegraPedidoSaidaFinan(configGeral.getIdLoja(), integracao);
    }
	
  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
	  dao.atualiza(configGeral);
	  dao.atualizaIntegraPedidoSaidaFinan(configGeral.getIdLoja(), integracao);

  } else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	 dao.excluir(configGeral);
  }
} 

//seleciona todos os registros do banco de dados
List list;
dao = new ConfigGeralDAO(conn);
clausula += " ORDER BY idLoja ";
list = dao.listarConfigGeral(clausula);

int cont = 0;
%>
<h1 class="cabecalho_pagina">Cadastro de Configuração Geral</h1>

|<a class="button" href="formConfigGeral.jsp?acao=inc">Novo Cadastro</a>|<br>
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<body onload="document.forms[0].elements[0].focus();" >
<form action="listarConfigGeral.jsp">
<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr>
      <th class="grid">&nbsp;</th>
      <th class="grid"><center>ID LOJA</center></th>
      <th class="grid"><center>Nome Loja</center></th>
      <th class="grid"><center>Servidor(Email)</center></th>
       <th class="grid"><center>Porta(Email)</center></th>
       <th class="grid"><center>Usuário(Email)</center></th>
       <th class="grid"><center>Int. do Ped. Saida com Financeiro</center></th>
      <th class="grid">Excluir</th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
String integracaoConsulta = "";
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	ConfigGeral listConfigGeral = (ConfigGeral) it.next();
	LojaDAO daoLoja = new LojaDAO(conn);
	Loja loja = daoLoja.procurarLoja(listConfigGeral.getIdLoja());
	integracaoConsulta = dao.procurarIntegracaoPedSaidaFinan(loja.getIdLoja());
	if(integracaoConsulta.equalsIgnoreCase("N")){
		integracaoConsulta = "NÃO";
	}else if(integracaoConsulta.equalsIgnoreCase("S")){
		integracaoConsulta = "SIM";
	}
	cont++;

%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid" width="2%"><center><%=loja.getIdLoja()%></center></td>
      <td class = "grid" width="10%"><center><%=loja.getRazaoSocial()%></center></td>
      <td class = "grid" width="5%"><a href="formConfigGeral.jsp?acao=atu&idLoja=<%=loja.getIdLoja()%>"><center><%=listConfigGeral.getEmailServidor()%></center></a></td>
      <td class = "grid" width="5%"><center><%=listConfigGeral.getEmailPorta()%></center></td>
      <td class = "grid" width="5%"><center><%=listConfigGeral.getEmailUsuario()%></center></td>
      <td class = "grid" width="5%"><center><%=integracaoConsulta%></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=listConfigGeral.getIdLoja()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
  </tr>

<%
}
%>   
</table>
</form>
<p align="right">|<a class="button" href="formConfigGeral.jsp?acao=inc">Novo Cadastro</a>|
<%@include file="../fimConexao.jsp"%>