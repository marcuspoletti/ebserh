<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.EntidadeContato" %>
<%@ page import="afero.persistence.EntidadeContatoDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="afero.util.ConverteDate" %>
<%@ page import="java.text.ParseException" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function confirmaExcluir(cont, cd, id) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarEntidadeContatoSimplificado.jsp?acao=exc&cdEntidade=' + cd + '&idEntidadeContato=' + id;   
  }  
}  
</script>

<%
EntidadeContatoDAO dao;

String acao = request.getParameter("acao");
String acaoAnterior = request.getParameter("acaoAnterior");
String selectAba = request.getParameter("selectAba");
if (acao == null) acao = "listar";
if (acaoAnterior == null) acaoAnterior = "atu";
if (selectAba == null) selectAba = "1";
String dtMod = "";
String dtCad = "";
String usuario ="";

String cdEntidade = request.getParameter("cdEntidade");

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
  String idEntidadeContato = request.getParameter("idEntidadeContato");
  String cdTipoNivel = request.getParameter("cdTipoNivel");
  String nmContato = request.getParameter("nmContato");
  String dtNascimento = request.getParameter("dtNascimento");
  String cargo = request.getParameter("cargo");
  String departamento = request.getParameter("departamento");
  String sexo = request.getParameter("sexo");
  String telefone1 = request.getParameter("telefone1");
  String ramal1 = request.getParameter("ramal1");
  String telefone2 = request.getParameter("telefone2");
  String ramal2 = request.getParameter("ramal2");
  String fax = request.getParameter("fax");
  String celular = request.getParameter("celular");
  String email = request.getParameter("email");
  String hobby = request.getParameter("hobby");
  String time = request.getParameter("time");
  String status = request.getParameter("status");
  usuario = (String)session.getAttribute("Login");
  if (idEntidadeContato == null) idEntidadeContato = "";
  if (cdEntidade == null) cdEntidade = "";
  if (cdTipoNivel == null) cdTipoNivel = "1";
  if (nmContato == null) nmContato = "";
  if (dtNascimento == null) dtNascimento = "";
  if (cargo == null) cargo = "";
  if (departamento == null) departamento = "";
  if (sexo == null) sexo = "M";
  if (telefone1 == null) telefone1 = "";
  if (ramal1 == null) ramal1 = "";
  if (telefone2 == null) telefone2 = "";
  if (ramal2 == null) ramal2 = "";
  if (fax == null) fax = "";
  if (celular == null) celular = "";
  if (email == null) email = "";
  if (hobby == null) hobby = "";
  if (time == null) time = "";
  if (status == null) status = "";
  if (status == null) status = "A";

  EntidadeContato entidadeContato = new EntidadeContato();

	try {
	  if (!acao.equalsIgnoreCase("inc")){
		  entidadeContato.setIdEntidadeContato(Integer.parseInt(idEntidadeContato));
	  }
	  if (!acao.equalsIgnoreCase("exc")){  
		  entidadeContato.setCdEntidade(Integer.parseInt(cdEntidade));
		  entidadeContato.setCdTipoNivel(Integer.parseInt(cdTipoNivel));
		}
	  entidadeContato.setNmContato(nmContato);
	  if (!dtNascimento.equals(""))
	  	entidadeContato.setDtNascimento(ConverteDate.stringToDate(dtNascimento));
	  entidadeContato.setCargo(cargo);
	  entidadeContato.setDepartamento(departamento);
	  entidadeContato.setSexo(sexo);
	  entidadeContato.setTelefone1(telefone1);
	  entidadeContato.setRamal1(ramal1);
	  entidadeContato.setTelefone2(telefone2);
	  entidadeContato.setRamal2(ramal2);
	  entidadeContato.setFax(fax);
	  entidadeContato.setCelular(celular);
	  entidadeContato.setEmail(email);
	  entidadeContato.setHobby(hobby);
	  entidadeContato.setTime(time);
	  entidadeContato.setStatus(status);
	  entidadeContato.setUsuario(usuario);
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	} catch (ParseException pe) {
		throw new Exception("Data inválida");
	}

  dao = new EntidadeContatoDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {
	  //inclui no banco de dados
  	dao.incluir(entidadeContato);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
	  dao.atualizar(entidadeContato);

  } else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  dao.excluir(entidadeContato);
  }
}

//seleciona todos os registros do banco de dados
dao = new EntidadeContatoDAO(conn);
List list = dao.listarEntidadeContato(" WHERE e.cdEntidade = "+cdEntidade);

int cont = 0;
%>
<h1  class="cabecalho_pagina">Cadastro de Contato - Entidade</h1>

|<a class="button" href="formEntidadeContatoSimplificado.jsp?cdEntidade=<%=cdEntidade %>&acao=inc">Novo Contato</a>|&nbsp;&nbsp;&nbsp;
|<a class="button" href="formEntidadeJuridicaSimplificado.jsp?cdEntidade=<%=cdEntidade %>&acao=<%=acaoAnterior %>&selectAba=<%=selectAba%>">Voltar</a>|<br>

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr">
      <th class="grid">&nbsp;</th>
      <th class="grid"><center>Contato</center></th>
      <th class="grid">Status</th>
      <th class="grid">Excluir</th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	EntidadeContato entidadeContato = (EntidadeContato) it.next();
	cont++;
%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid"><center><a href="formEntidadeContatoSimplificado.jsp?idEntidadeContato=<%=entidadeContato.getIdEntidadeContato()%>&acao=atu">
      	<%=entidadeContato.getNmContato()%></a></center></td>
      <td class = "grid" width="5%"><center><%=entidadeContato.getStatus()%></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=entidadeContato.getCdEntidade()%>,<%=entidadeContato.getIdEntidadeContato()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
    </tr>
<%
}
%>   
</table>
<%@include file="../fimConexao.jsp"%>