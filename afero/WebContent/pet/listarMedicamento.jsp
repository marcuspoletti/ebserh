<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="aferopet.model.Medicamento" %>
<%@ page import="aferopet.model.GrupoMedicamento" %>
<%@ page import="aferopet.persistence.MedicamentoDAO" %>
<%@ page import="aferopet.persistence.GrupoMedicamentoDAO" %>
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
       location.href = 'listarMedicamento.jsp?acao=exc&idMedicamento=' + id;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.nomeMedicamento.value = '';
  document.all.tipoMedicamento.value = ''; //não está limpando
  document.forms[0].submit();
}  
</script>

<%
MedicamentoDAO dao;
MedicamentoDAO daoExclusao;
GrupoMedicamentoDAO dao1;
ConverteDate conDate = new ConverteDate();
String mensagem = request.getParameter("mensagem");
if(mensagem == null) mensagem = "";
String acao = request.getParameter("acao");
if (acao == null) acao = "listar";

String idMedicamento = "";
String idGrupoMedicamento = "";
String idProduto = "";
String nmMedicamento = "";
String principioAtivo = "";
String apresentacao = "";
String dosePAtivo = "";
String doseApresentacao = "";
String uso = "";
String indicacao = "";
String fabricante = "";
String observacao = "";
String status = "";
String dtCad = "";
String dtMod = "";
String usuario = "";
String clausula = "";
String nomeMedicamento = "";

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
	GrupoMedicamentoDAO daoGrupoMedicamento = new GrupoMedicamentoDAO(conn);
	GrupoMedicamento grupoMedicamento = new GrupoMedicamento();
	idMedicamento = request.getParameter("idMedicamento");
	idGrupoMedicamento = request.getParameter("idGrupoMedicamento");
	idProduto = request.getParameter("idProduto");
  nmMedicamento = request.getParameter("nmMedicamento");
  principioAtivo = request.getParameter("principioAtivo");
  apresentacao = request.getParameter("apresentacao");
  dosePAtivo = request.getParameter("dosePAtivo");
  doseApresentacao = request.getParameter("doseApresentacao");
  uso = request.getParameter("uso");
  indicacao = request.getParameter("indicacao");
  fabricante = request.getParameter("fabricante");
  observacao = request.getParameter("observacao");
  status = request.getParameter("status");
  if (idMedicamento == null) idMedicamento = "0";
  if (idGrupoMedicamento == null) idGrupoMedicamento = "0";
  if (idProduto == null) idProduto = "0";
  if (nmMedicamento == null) nmMedicamento = "";
  if (principioAtivo == null) principioAtivo = "";
  if (apresentacao == null) apresentacao = "";
  if (dosePAtivo == null) dosePAtivo = "";
  if (doseApresentacao == null) doseApresentacao = "";
  if (uso == null) uso = "";
  if (indicacao == null) indicacao = "";
  if (fabricante == null) fabricante = "";
  if (observacao == null) observacao = "";
  if (status == null) status = "A";

  usuario = (String)session.getAttribute("Login");
  Medicamento medicamento = new Medicamento();
  
	try {
	  if (!acao.equalsIgnoreCase("inc")){
		  medicamento.setIdMedicamento(Integer.parseInt(idMedicamento));
	  }
	  
	  medicamento.setIdGrupoMedicamento(Integer.parseInt(idGrupoMedicamento));
	  medicamento.setIdProduto(Integer.parseInt(idProduto));
	  medicamento.setNmMedicamento(nmMedicamento);
	  medicamento.setPrincipioAtivo(principioAtivo);
	  medicamento.setApresentacao(apresentacao);
	  medicamento.setDosePAtivo(dosePAtivo);
	  medicamento.setDoseApresentacao(doseApresentacao);
	  medicamento.setUso(uso);
	  medicamento.setIndicacao(indicacao);
	  medicamento.setFabricante(fabricante);
	  medicamento.setObservacao(observacao);
    medicamento.setStatus(status);
    medicamento.setUsuario(usuario);
      
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}


  dao = new MedicamentoDAO(conn);
  daoExclusao = new MedicamentoDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {
	  
	  //inclui no banco de dados
  	dao.incluir(medicamento);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
	 
	  dao.atualizar(medicamento);

  } else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados]
	  if(!daoExclusao.exclusaoIdMedicamento(Integer.parseInt(idMedicamento))){
		  dao.excluir(medicamento);
	  }else{
		  response.sendRedirect("listarMedicamento.jsp?mensagem=Exclusão Inválida! Item já possui lançamentos.&acao=listar");
	  }
	  
  }
} else {
  if (!acao.equalsIgnoreCase("voltar")) {
    nomeMedicamento = request.getParameter("nomeMedicamento");
    if(nomeMedicamento == null) nomeMedicamento = "";
  }

  if (nomeMedicamento!= null) {
    clausula = " WHERE nmMedicamento LIKE '"+nomeMedicamento+"%'";
  } 
  
}

//seleciona todos os registros do banco de dados
List list;
dao = new MedicamentoDAO(conn);
clausula = clausula+" ORDER BY nmMedicamento ";
list = dao.listarMedicamento(clausula);

%>
<h1 class="cabecalho_pagina">Cadastro de Medicamento</h1>

|<a class="button" href="formMedicamento.jsp?acao=inc">Novo Cadastro</a>|<br>
<body onload="document.forms[0].elements[0].focus();" >
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<form action="listarMedicamento.jsp">
<table colspan="2">
  <tr>
    <th class='label'>Descrição do Medicamento</th>
    <td><input type="text" name="nomeMedicamento" <%if (nomeMedicamento != null) { %>value="<%=nomeMedicamento%>"<% }%> size="40" maxlength="50"></td>
    <td><input class="button" type="button" value="Localizar" onClick="javascript: localizar();" /></td>
    <td><input class="button" type="button" value="Nova pesquisa" onClick="javascript: novaPesquisa();" /></td>
  </tr>
  
</table>
<hr>

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr">
      <th class="grid">&nbsp;</th>
      <th class="grid"><center>Descrição do Medicamento</center></th>
      <th class="grid">Grupo do Medicamento</th>
      <th class="grid">Status</th>
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
	Medicamento medicamento = (Medicamento) it.next();
  dao1 = new GrupoMedicamentoDAO(conn);
	GrupoMedicamento grupoMedicamento = dao1.procurarGrupoMedicamento(medicamento.getIdGrupoMedicamento());
	cont++;

%>
    <tr>
      <td class = "grid" width="2%"><center><%=rowNum+cont%></center></td>
      <td class = "grid"><center><a href="formMedicamento.jsp?acao=atu&idMedicamento=<%=medicamento.getIdMedicamento()%>"><%=medicamento.getNmMedicamento() %></a></center></td>
      <td class = "grid"><center><%=grupoMedicamento.getDsGrupoMedicamento()%></center></td>
      <td class = "grid" width="5%"><center><%=medicamento.getStatus()%></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=rowNum+cont%>,<%=medicamento.getIdMedicamento()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
  	</tr>
<%
}
%>   
</table>
</form>
<p align="right">|<a class="button" href="formMedicamento.jsp?acao=inc">Novo Cadastro</a>|
<%  if (rowNum != 0 || hasNext) { %>
        <center>
<%      if (rowNum != 0) { %>
<a class="link" href="listarMedicamento.jsp?rowNum=<%=0%>&nomeMedicamento=<%=nomeMedicamento%>">Primeira</a>&nbsp&nbsp
|&nbsp&nbsp<a class="link" href="listarMedicamento.jsp?rowNum=<%=rowNum-gridSize%>&nomeMedicamento=<%=nomeMedicamento%>">< Anterior</a>&nbsp&nbsp
<%      } else { %>
Primeira&nbsp&nbsp|&nbsp&nbsp< Anterior&nbsp
<%      } %>
<%      if (hasNext) { %>
|&nbsp&nbsp<a class="link" href="listarMedicamento.jsp?rowNum=<%=rowNum+gridSize%>&nomeMedicamento=<%=nomeMedicamento%>">Próxima ></a>&nbsp&nbsp
|&nbsp&nbsp<a class="link" href="listarMedicamento.jsp?rowNum=<%=rowCount-gridSize%>&nomeMedicamento=<%=nomeMedicamento%>">Última</a>
<%      } else { %>
|&nbsp&nbsp Próxima >&nbsp&nbsp|&nbsp&nbspÚltima
<%      } %>
        </center>
<%  } %>
</body>
<%@include file="../fimConexao.jsp"%>
