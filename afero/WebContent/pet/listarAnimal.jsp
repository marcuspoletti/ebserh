<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="aferopet.model.Animal" %>
<%@ page import="afero.model.Entidade" %>
<%@ page import="aferopet.persistence.AnimalDAO" %>
<%@ page import="afero.persistence.EntidadeDAO" %>
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
       location.href = 'listarAnimal.jsp?acao=exc&idAnimal=' + id;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.nomeAnimal.value = '';
  document.all.nomeEntidade.value = ''; //não está limpando
  document.forms[0].submit();
}  
</script>

<%
AnimalDAO dao;
AnimalDAO daoExclusao;
EntidadeDAO dao1;
ConverteDate conDate = new ConverteDate();
String mensagem = request.getParameter("mensagem");
if(mensagem == null) mensagem = "";
String acao = request.getParameter("acao");
if (acao == null) acao = "listar";

String idAnimal = "";
String cdEntidade = "";
String cdTipoEspecie = "";
String idTipoRaca = "";
String nmAnimal = "";
String dtNascimento = "";
String sexo = "";
String porte = "";
String cor = "";
String registro = "";
String microchip = "";
String passaporte = "";
String origem = "";
String estado = "";
String alergia = "";
String observacao = "";
String pedigree = "";
String obito = "";
String status = "";
String dtCad = "";
String dtMod = "";
String usuario = "";
String clausula = "";
String nomeAnimal = "";
String nomeEntidade = "";

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
	EntidadeDAO daoEntidade = new EntidadeDAO(conn);
	Entidade entidade = new Entidade();
	idAnimal = request.getParameter("idAnimal");
	cdEntidade = request.getParameter("cdEntidade");
	cdTipoEspecie = request.getParameter("cdTipoEspecie");
	idTipoRaca = request.getParameter("idTipoRaca");
  nmAnimal = request.getParameter("nmAnimal");
  dtNascimento = request.getParameter("dtNascimento");
  sexo = request.getParameter("sexo");
  porte = request.getParameter("porte");
  cor = request.getParameter("cor");
  registro = request.getParameter("registro");
  microchip = request.getParameter("microchip");
  passaporte = request.getParameter("passaporte");
  origem = request.getParameter("origem");
  estado = request.getParameter("estado");
  alergia = request.getParameter("alergia");
  observacao = request.getParameter("observacao");
  pedigree = request.getParameter("pedigree");
  obito = request.getParameter("obito");
  status = request.getParameter("status");
  if (idAnimal == null) idAnimal = "0";
  if (cdEntidade == null) cdEntidade = "0";
  if (cdTipoEspecie == null) cdTipoEspecie = "0";
  if (idTipoRaca == null) idTipoRaca = "0";
  if (nmAnimal == null) nmAnimal = "";
  if (dtNascimento == null) dtNascimento = "";
  if (sexo == null) sexo = "";
  if (porte == null) porte = "";
  if (cor == null) cor = "";
  if (registro == null) registro = "";
  if (microchip == null) microchip = "";
  if (passaporte == null) passaporte = "";
  if (origem == null) origem = "";
  if (estado == null) estado = "";
  if (alergia == null) alergia = "";
  if (observacao == null) observacao = "";
  if (pedigree == null) pedigree = "";
  if (obito == null) obito = "";
  if (status == null) status = "A";

  usuario = (String)session.getAttribute("Login");
  Animal animal = new Animal();
  
	try {
	  if (!acao.equalsIgnoreCase("inc")){
		  animal.setIdAnimal(Integer.parseInt(idAnimal));
	  }
	  
	  animal.setCdEntidade(Integer.parseInt(cdEntidade));
	  animal.setCdTipoEspecie(Integer.parseInt(cdTipoEspecie));
	  animal.setIdTipoRaca(Integer.parseInt(idTipoRaca));
	  animal.setNmAnimal(nmAnimal);
	  if (!dtNascimento.equals(""))
		  animal.setDtNascimento(ConverteDate.stringToDate(dtNascimento));
	  animal.setSexo(sexo);
	  animal.setPorte(porte);
	  animal.setCor(cor);
	  animal.setRegistro(registro);
	  animal.setMicrochip(microchip);
	  animal.setPassaporte(passaporte);
	  animal.setOrigem(origem);
	  animal.setEstado(estado);
	  animal.setAlergia(alergia);
	  animal.setPedigree(pedigree);
	  animal.setObito(obito);
	  animal.setObservacao(observacao);
    animal.setStatus(status);
    animal.setUsuario(usuario);
      
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}


  dao = new AnimalDAO(conn);
  daoExclusao = new AnimalDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {
	  
	  //inclui no banco de dados
  	dao.incluir(animal);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
	 
	  dao.atualizar(animal);

  } else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados]
	  if(!daoExclusao.exclusaoIdAnimal(Integer.parseInt(idAnimal))){
		  dao.excluir(animal);
	  }else{
		  response.sendRedirect("listarAnimal.jsp?mensagem=Exclusão Inválida! Item já possui lançamentos.&acao=listar");
	  }
	  
  }
} else {
  if (!acao.equalsIgnoreCase("voltar")) {
    nomeAnimal = request.getParameter("nomeAnimal");
    if(nomeAnimal == null) nomeAnimal = "";
    nomeEntidade = request.getParameter("nomeEntidade");
    if(nomeEntidade == null) nomeEntidade = "";
  }

  if (nomeAnimal!= null) {
    clausula = " WHERE a.nmAnimal LIKE '"+nomeAnimal+"%'";
	  if (nomeEntidade!= null) {
		    clausula += " AND e.nome LIKE '"+nomeEntidade+"%'";
		  }	  
  } else {
	  if (nomeEntidade!= null) {
		    clausula = " WHERE e.nome LIKE '"+nomeEntidade+"%'";
		  }	  
  }
  
}

//seleciona todos os registros do banco de dados
List list;
dao = new AnimalDAO(conn);
clausula = clausula+" ORDER BY a.nmAnimal ";
list = dao.listarAnimal(clausula);

%>
<h1 class="cabecalho_pagina">Cadastro de Animal</h1>

|<a class="button" href="formAnimal.jsp?acao=inc">Novo Cadastro</a>|<br>
<body onload="document.forms[0].elements[0].focus();" >
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<form action="listarAnimal.jsp">
<table colspan="2">
  <tr>
    <th class='label'>Nome do Animal</th>
    <td><input type="text" name="nomeAnimal" <%if (nomeAnimal != null) { %>value="<%=nomeAnimal%>"<% }%> size="40" maxlength="50"></td>
  </tr>
  <tr>
    <th class='label'>Nome do Proprietário</th>
    <td><input type="text" name="nomeEntidade" <%if (nomeEntidade != null) { %>value="<%=nomeEntidade%>"<% }%> size="40" maxlength="50"></td>
    <td><input class="button" type="button" value="Localizar" onClick="javascript: localizar();" /></td>
    <td><input class="button" type="button" value="Nova pesquisa" onClick="javascript: novaPesquisa();" /></td>
  </tr>
  
</table>
<hr>

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr">
      <th class="grid">&nbsp;</th>
      <th class="grid"><center>Nome do Animal</center></th>
      <th class="grid">Nome do Proprietário</th>
      <th class="grid">Status</th>
      <th class="grid">Ficha</th>
      <th class="grid">Retorno</th>
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

//Utiliza o ResultSet para trazer os registros do banco de dados
for ( Iterator it = list.iterator(); hasNext && cont < gridSize; hasNext = it.hasNext()) {
	Animal animal = (Animal) it.next();
  dao1 = new EntidadeDAO(conn);
	Entidade entidade = dao1.procurarEntidade(animal.getCdEntidade());
	cont++;

%>
    <tr>
      <td class = "grid" width="2%"><center><%=rowNum+cont%></center></td>
      <td class = "grid"><center><a href="formAnimal.jsp?acao=atu&idAnimal=<%=animal.getIdAnimal()%>"><%=animal.getNmAnimal() %></a></center></td>
      <td class = "grid"><center><%=entidade.getNome()%></center></td>
      <td class = "grid" width="5%"><center><%=animal.getStatus()%></center></td>
      <td class = "grid" width="5%"><center><a href="listarAnimalFicha.jsp?acao=listar&idAnimal=<%=animal.getIdAnimal()%>"><img border = "0" src="../images/ficha.gif"></a></center></td>
      <td class = "grid" width="5%"><center><a href="listarAnimalRetorno.jsp?acao=listar&idAnimal=<%=animal.getIdAnimal()%>"><img border = "0" src="../images/recado.gif"></a></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=rowNum+cont%>,<%=animal.getIdAnimal()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
  	</tr>
<%
}
%>   
</table>
</form>
<p align="right">|<a class="button" href="formAnimal.jsp?acao=inc">Novo Cadastro</a>|
<%  if (rowNum != 0 || hasNext) { %>
        <center>
<%      if (rowNum != 0) { %>
<a class="link" href="listarAnimal.jsp?rowNum=<%=0%>&nomeAnimal=<%=nomeAnimal%>">Primeira</a>&nbsp&nbsp
|&nbsp&nbsp<a class="link" href="listarAnimal.jsp?rowNum=<%=rowNum-gridSize%>&nomeAnimal=<%=nomeAnimal%>">< Anterior</a>&nbsp&nbsp
<%      } else { %>
Primeira&nbsp&nbsp|&nbsp&nbsp< Anterior&nbsp
<%      } %>
<%      if (hasNext) { %>
|&nbsp&nbsp<a class="link" href="listarAnimal.jsp?rowNum=<%=rowNum+gridSize%>&nomeAnimal=<%=nomeAnimal%>">Próxima ></a>&nbsp&nbsp
|&nbsp&nbsp<a class="link" href="listarAnimal.jsp?rowNum=<%=rowCount-gridSize%>&nomeAnimal=<%=nomeAnimal%>">Última</a>
<%      } else { %>
|&nbsp&nbsp Próxima >&nbsp&nbsp|&nbsp&nbspÚltima
<%      } %>
        </center>
<%  } %>
</body>
<%@include file="../fimConexao.jsp"%>
