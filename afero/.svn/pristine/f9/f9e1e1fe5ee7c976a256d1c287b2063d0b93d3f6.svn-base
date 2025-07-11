<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="aferopet.model.AnimalRetorno"%>
<%@page import="aferopet.model.Animal"%>
<%@page import="afero.model.Entidade"%>
<%@page import="afero.model.EntidadeTelefone"%>
<%@page import="aferopet.persistence.AnimalRetornoDAO"%>
<%@page import="aferopet.persistence.AnimalDAO"%>
<%@page import="afero.persistence.EntidadeDAO"%>
<%@page import="afero.persistence.EntidadeTelefoneDAO"%>
<%@page import="afero.util.Utilitaria"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Date" %>
<%@ page import="afero.util.ConverteDate" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<%
ConverteDate converte = new ConverteDate();
AnimalRetornoDAO dao = null;
String acao = request.getParameter("acao");
String dataIni = request.getParameter("dataIni");
String dataFim = request.getParameter("dataFim");
String clausula = "";

clausula = " WHERE status = 'A' AND dtRetorno BETWEEN '"+converte.DMYToYMDI(dataIni)+" 00:00:00' AND '"+converte.DMYToYMDI(dataFim)+" 23:59:59'"; 
    


//seleciona todos os registros do banco de dados
List list;
dao = new AnimalRetornoDAO(conn);
clausula = clausula+" ORDER BY dtRetorno ";
list = dao.listarAnimalRetorno(clausula);

int cont = 0;
%>
<body onload="document.forms[0].elements[0].focus();" >

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr">
      <th class="grid" width="2%">&nbsp;</th>
      <th class="grid"><center>Animal</center></th>
      <th class="grid"><center>Proprietário</center></th>
      <th class="grid"><center>Descrição Atividade</center></th>
      <th class="grid"><center>Data de Retorno</center></th>
      <th class="grid"><center>Telefone</center></th>
    </tr>
<%

//Utiliza o ResultSet para trazer os registros do banco de dados
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	AnimalRetorno animalRetorno = (AnimalRetorno) it.next();
	AnimalDAO daoAnimal = new AnimalDAO(conn);
	Animal animal = daoAnimal.procurarAnimal(animalRetorno.getIdAnimal());
	EntidadeDAO daoEntidade = new EntidadeDAO(conn);
	Entidade entidade = null;
	entidade = daoEntidade.procurarEntidade(animal.getCdEntidade());
	EntidadeTelefoneDAO daoEntidadeTelefone = new EntidadeTelefoneDAO(conn);
	EntidadeTelefone entidadeTelefone = daoEntidadeTelefone.procurarEntidadeTelefonePadrao(entidade.getCdEntidade());
	cont++;
%>
    
   <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid" width="2%"><center><a target="_blank" href="../pet/formAnimal.jsp?acao=atu&idAnimal=<%=animal.getIdAnimal()%>"><%=animal.getNmAnimal()%></a></center></td>
      <td class = "grid" width="30%"><center><%=entidade.getNome()%></center></td>
      <td class = "grid" width="30%"><center><%=animalRetorno.getDescricao()%></center></td>
      <td class = "grid" width="5%"><center><%=converte.dateToString(animalRetorno.getDtRetorno())%></center></td>
      <td class = "grid" width="10%"><font color="red"><center><%=entidadeTelefone.getNroTelefone()%></center></font></td>
  	</tr>
<%
}
%>      
</table>
<table border="0" width="100%">
</table>
<%@include file="../fimConexao.jsp"%>