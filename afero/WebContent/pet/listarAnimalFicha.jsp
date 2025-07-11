<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="aferopet.model.AnimalFicha" %>
<%@ page import="aferopet.model.Animal" %>
<%@ page import="afero.model.Entidade" %>
<%@ page import="afero.model.EntidadeTelefone" %>
<%@ page import="afero.persistence.EntidadeTelefoneDAO" %>
<%@ page import="aferopet.persistence.AnimalDAO" %>
<%@ page import="afero.persistence.EntidadeDAO" %>
<%@ page import="aferopet.persistence.AnimalFichaDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Date" %>
<%@ page import="afero.util.ConverteDate" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>

<%--<%@page import="com.sun.org.apache.bcel.internal.generic.SWITCH"%><link type="text/css" rel="Stylesheet" href="../css/afero.css" /> --%>

<script>
function confirmaExcluir(cont, id) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarAnimalFicha.jsp?acao=exc&idAnimalFicha=' + id;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.descricaoFiltro.value = '';
  document.all.tipoFiltro[1].checked = true; //não está limpando
  document.forms[0].submit();
}  
</script>

<%
AnimalFichaDAO dao;
AnimalFichaDAO daoExclusao;
AnimalDAO dao1;
EntidadeDAO dao2;
EntidadeTelefoneDAO dao3;
ConverteDate conDate = new ConverteDate();
String mensagem = request.getParameter("mensagem");
if(mensagem == null) mensagem = "";
String acao = request.getParameter("acao");
if (acao == null) acao = "listar";
String idAnimal = request.getParameter("idAnimal");
if (idAnimal == null) idAnimal = "0";

String idAnimalFicha = "";
//String idAnimal = "";
String dtAtend = "";
String descricao = "";
String peso = "0";
String altura = "0";
String observacao = "";
String exame = "";
String tipoAtividade = "";
String dtMod = "";
String usuario = "";
String clausula = "";
String descricaoFiltro = "";
String tipoFiltro = "";

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
	AnimalDAO daoAnimal = new AnimalDAO(conn);
	Animal grupoAnimalFicha = new Animal();
	idAnimalFicha = request.getParameter("idAnimalFicha");
	//idAnimal = request.getParameter("idAnimal");
	dtAtend = request.getParameter("dtAtend");
	descricao = request.getParameter("descricao");
	peso = request.getParameter("peso");
	altura = request.getParameter("altura");
	observacao = request.getParameter("observacao");
	exame = request.getParameter("exame");
	tipoAtividade = request.getParameter("tipoAtividade");
  if (idAnimalFicha == null) idAnimalFicha = "0";
  //if (idAnimal == null) idAnimal = "0";
  if (dtAtend == null) dtAtend = "";
  if (descricao == null) descricao = "";
  if (peso == null || peso.isEmpty()) peso = "0";
  if (altura == null || altura.isEmpty()) altura = "0";
  if (observacao == null) observacao = "";
  if (exame == null) exame = "";
  if (tipoAtividade == null) tipoAtividade = "C";

  usuario = (String)session.getAttribute("Login");
  AnimalFicha animalFicha = new AnimalFicha();
  
	try {
	  if (!acao.equalsIgnoreCase("inc")) {
		  animalFicha.setIdAnimalFicha(Integer.parseInt(idAnimalFicha));
	  }
	  
	  animalFicha.setIdAnimal(Integer.parseInt(idAnimal));
	  if (!dtAtend.equals(""))
	  	animalFicha.setDtAtend(ConverteDate.stringToDate(dtAtend));
	  animalFicha.setDescricao(descricao);
	  animalFicha.setPeso(Integer.parseInt(peso));
	  animalFicha.setAltura(Integer.parseInt(altura));
	  animalFicha.setObservacao(observacao);
    animalFicha.setExame(exame);
    animalFicha.setTipoAtividade(tipoAtividade);
    animalFicha.setUsuario(usuario);
      
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}

  dao = new AnimalFichaDAO(conn);
  daoExclusao = new AnimalFichaDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {
	  
	  //inclui no banco de dados
  	dao.incluir(animalFicha);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
	 
	  dao.atualizar(animalFicha);

  } else if (acao.equalsIgnoreCase("exc")) {
	  //exclui no banco de dados]
	  if(!daoExclusao.exclusaoIdAnimalFicha(Integer.parseInt(idAnimalFicha))) {
		  dao.excluir(animalFicha);
	  } else {
		  response.sendRedirect("listarAnimalFicha.jsp?mensagem=Exclusão Inválida! Item já possui lançamentos.&acao=listar");
	  }
	  
  }
} else {
  if (!acao.equalsIgnoreCase("voltar")) {
    descricaoFiltro = request.getParameter("descricaoFiltro");
    tipoFiltro = request.getParameter("tipoFiltro");
    if (tipoFiltro == null) tipoFiltro = "";
  }
}

if (descricaoFiltro != null && !descricaoFiltro.isEmpty()) {
	  clausula = " WHERE idAnimal = "+idAnimal+" AND descricao LIKE '%"+descricaoFiltro+"%'";
	} else {
		clausula = " WHERE idAnimal = "+idAnimal;
	}  
	if (tipoFiltro.isEmpty()) {
		clausula += " AND tipoAtividade is not null ";  
	} else {
	  clausula += " AND tipoAtividade='"+tipoFiltro+"'";  
	}

//seleciona todos os registros do banco de dados
List list;
dao = new AnimalFichaDAO(conn);
clausula = clausula+" ORDER BY dtAtend DESC ";
list = dao.listarAnimalFicha(clausula);

dao1 = new AnimalDAO(conn);
Animal animal = dao1.procurarAnimal(Integer.parseInt(idAnimal));
dao2 = new EntidadeDAO(conn);
Entidade entidade = dao2.procurarEntidade(animal.getCdEntidade());
dao3 = new EntidadeTelefoneDAO(conn);
EntidadeTelefone entidadeTelefone = dao3.procurarEntidadeTelefonePadrao(animal.getCdEntidade());

%>
<h1 class="cabecalho_pagina">Cadastro de Animal - Ficha Clínica</h1>

|<a class="button" href="formAnimalFicha.jsp?acao=inc&idAnimal=<%=idAnimal%>">Novo Registro</a>|&nbsp;&nbsp;&nbsp;
|<a class="button" href="formAnimalRetorno.jsp?acao=inc&idAnimal=<%=idAnimal%>">Novo Retorno</a>|&nbsp;&nbsp;&nbsp;
|<a class="button" href="listarAnimal.jsp?acao=voltar">Voltar</a>|<br>
<body onload="document.forms[0].elements[0].focus();" >
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<form action="listarAnimalFicha.jsp">
<input type="hidden" name="idAnimal" value="<%=idAnimal%>">
<table width="100%">
  <tr>
    <td align="left" style="font-size:12px">Animal: <a style="font-size:14px" target="_blank" href="formAnimal.jsp?acao=atu&idAnimal=<%=animal.getIdAnimal()%>"><%=animal.getNmAnimal() %></a></td>
    <td align="center" style="font-size:12px">Proprietário: <%=entidade.getNome()%></td>
    <td align="right" style="font-size:12px">Telefone: <%=entidadeTelefone.getNroTelefone()%></td>
  </tr>
</table>
<hr>
<table colspan="2">
  <tr>
    <th class='label'>Atendimento</th>
    <td><input type="text" name="descricaoFiltro" <%if (descricaoFiltro != null) { %>value="<%=descricaoFiltro%>"<% }%> size="70" maxlength="100"></td>
    <td><input class="button" type="button" value="Localizar" onClick="javascript: localizar();" /></td>
    <td><input class="button" type="button" value="Nova pesquisa" onClick="javascript: novaPesquisa();" /></td>
  </tr>
  <tr>
    <th class="label">Tipo Atividade</th>
      <td class="label_radio">
      <input type="radio" class="radio" name="tipoFiltro" value="" <%= (tipoFiltro.equals("")? "checked": "") %>>Todos
      <input type="radio" class="radio" name="tipoFiltro" value="C" <%= (tipoFiltro.equals("C")? "checked": "") %>>Primeira Consulta
      <input type="radio" class="radio" name="tipoFiltro" value="R" <%= (tipoFiltro.equals("R")? "checked": "") %>>Retorno</td>    
  </tr>  
</table>
<hr>

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr">
      <th class="grid">&nbsp;</th>
      <th class="grid"><center>Data</center></th>
      <th class="grid"><center>Descrição Atendimento</center></th>
      <th class="grid">Tipo</th>
      <th class="grid">Excluir</th>
    </tr>
<%
int cont = 0;
int gridSize = 15;
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

String msgStatus = "";
//Utiliza o ResultSet para trazer os registros do banco de dados
for ( Iterator it = list.iterator(); hasNext && cont < gridSize; hasNext = it.hasNext()) {
	AnimalFicha animalFicha = (AnimalFicha) it.next();
	if (animalFicha.getTipoAtividade().equals("C")) {
		msgStatus = "Primeira Consulta";
	} else if (animalFicha.getTipoAtividade().equals("R")) {
		msgStatus = "Retorno";
	}
	
	cont++;

%>
    <tr>
      <td class = "grid" width="2%"><center><%=rowNum+cont%></center></td>
      <td class = "grid" width="10%"><center><a href="formAnimalFicha.jsp?acao=atu&idAnimalFicha=<%=animalFicha.getIdAnimalFicha()%>"><%=ConverteDate.dateToString(animalFicha.getDtAtend())%></a></center></td>
      <td class = "grid"><center><%=animalFicha.getDescricao()%></center></td>
      <td class = "grid" width="15%"><center><%=msgStatus%></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=rowNum+cont%>,<%=animalFicha.getIdAnimalFicha()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
  	</tr>
<%
}
%>   
</table>
</form>
<p align="right">|<a class="button" href="formAnimalFicha.jsp?acao=inc&idAnimal=<%=idAnimal%>">Novo Registro</a>|
<%  if (rowNum != 0 || hasNext) { %>
        <center>
<%      if (rowNum != 0) { %>
<a class="link" href="listarAnimalFicha.jsp?rowNum=<%=0%>&descricaoFiltro=<%=descricaoFiltro%>">Primeira</a>&nbsp&nbsp
|&nbsp&nbsp<a class="link" href="listarAnimalFicha.jsp?rowNum=<%=rowNum-gridSize%>&descricaoFiltro=<%=descricaoFiltro%>">< Anterior</a>&nbsp&nbsp
<%      } else { %>
Primeira&nbsp&nbsp|&nbsp&nbsp< Anterior&nbsp
<%      } %>
<%      if (hasNext) { %>
|&nbsp&nbsp<a class="link" href="listarAnimalFicha.jsp?rowNum=<%=rowNum+gridSize%>&descricaoFiltro=<%=descricaoFiltro%>">Próxima ></a>&nbsp&nbsp
|&nbsp&nbsp<a class="link" href="listarAnimalFicha.jsp?rowNum=<%=rowCount-gridSize%>&descricaoFiltro=<%=descricaoFiltro%>">Última</a>
<%      } else { %>
|&nbsp&nbsp Próxima >&nbsp&nbsp|&nbsp&nbspÚltima
<%      } %>
        </center>
<%  } %>
</body>
<%@include file="../fimConexao.jsp"%>
