<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.Colaborador" %>
<%@ page import="afero.model.Usuario" %>
<%@ page import="afero.auxiliar.Seguranca" %>
<%@ page import="afero.persistence.UsuarioDAO" %>
<%@ page import="afero.persistence.ColaboradorDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Date" %>
<%@ page import="afero.util.ConverteDate" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function confirmaExcluir(cont, id, id1) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = "listarColaborador.jsp?acao=exc&idColaborador=" + id +"&idUsuario=" + id1;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.nomeColaborador.value = '';
  document.all.status.value = ''; //não está limpando
  document.forms[0].submit();
}  
</script>

<%
Seguranca seguranca = new Seguranca();
String mensagem = request.getParameter("mensagem");
if(mensagem == null) mensagem="";
ColaboradorDAO dao;
UsuarioDAO usuarioDAO;
UsuarioDAO daoUsuario; 
UsuarioDAO daoPesquisaUsuario;
ConverteDate conDate = new ConverteDate();

String acao = request.getParameter("acao");
if (acao == null) acao = "listar";

String idLoja = "";
String idTipoColaborador = "";
String idColaborador = "";
String idUsuario = "";
String idGrupoUsuario = "";
String nomeColaborador = "";
String nome = "";
String apelido = "";
String cpf = "";
String nroRg = "";
String endereco = "";
String bairro = "";
String cep = "";
String cidade = "";
String estado = "";
String cmpEndereco = "";
String status = "A";
String clausula = "";
String orgRg = "";
String ufRg = "";
String telefone = "";
String celular = "";
String email = "";
String login = "";
String senha = "";
String user = "";
int idUsuarioDAO = 0;

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
	nomeColaborador = request.getParameter("nomeColaborador");
	idColaborador = request.getParameter("idColaborador");
	idUsuario = request.getParameter("idUsuario");
	idLoja = request.getParameter("idLoja");
	idTipoColaborador = request.getParameter("idTipoColaborador");
	nome = request.getParameter("nome");
	apelido = request.getParameter("apelido");
	cpf = request.getParameter("cpf");
	nroRg = request.getParameter("nroRg");
	endereco = request.getParameter("endereco");
	bairro = request.getParameter("bairro");
	cep = request.getParameter("cep");
	cidade = request.getParameter("cidade");
	estado = request.getParameter("estado");
	cmpEndereco = request.getParameter("cmpEndereco");
  status =request.getParameter("status");
  orgRg = request.getParameter("orgRg");
  ufRg = request.getParameter("ufRg");
  telefone = request.getParameter("telefone");
  celular = request.getParameter("celular");
  email = request.getParameter("email");
  login = request.getParameter("login");
  user = request.getParameter("user");
  daoUsuario = new UsuarioDAO(conn);
  idUsuarioDAO = daoUsuario.procurarLogin(login);
  idGrupoUsuario = request.getParameter("idGrupoUsuario");
  senha = request.getParameter("senha");
  if (senha == null) senha ="";
  if (user == null) user = "";
  if (login == null) login = "";
  if (idGrupoUsuario == null) idGrupoUsuario = "0";
  if (idTipoColaborador == null) idTipoColaborador = "0";
  if (idLoja == null) idLoja = "0";
  if (idUsuario == null) idUsuario = "0";
  if (apelido == null) apelido = "";
  if (nome == null) nome = "";
  if (cpf == null) cpf= "";
  if (status == null) status = "A";
  if (nroRg == null) nroRg = "";
  if (endereco == null) endereco = "";
  if (cmpEndereco == null) cmpEndereco = "";
  if (bairro == null) bairro = "";
  if (cep == null) cep = "";
  if (cidade == null) cidade = "";
  if (estado == null) estado = "";
  if (email == null) email = "";
  if (celular == null) celular= "";
  if (telefone == null) telefone= "";
  if (ufRg == null) ufRg= "";
  if (orgRg == null) orgRg= "";

  user = (String)session.getAttribute("Login");
  Colaborador colaborador = new Colaborador();
  Usuario usuario = new Usuario();

try {
     if (!acao.equalsIgnoreCase("inc")){
		  colaborador.setIdColaborador(Integer.parseInt(idColaborador));
		  usuario.setIdUsuario(Integer.parseInt(idUsuario));
    }
    usuario.setIdGrupoUsuario(Integer.parseInt(idGrupoUsuario));
    usuario.setEmail(email);
    //seguranca
    seguranca.setUsuario(login);
    seguranca.setSenha(senha);
    String senhaCode = seguranca.md5(seguranca.getUsuario()+seguranca.getSenha());
    //fim seguranca
    usuario.setLogin(login);
    usuario.setSenha(senhaCode);
    usuario.setStatus(status);
    usuario.setUsuario(user);
    colaborador.setApelido(apelido);
    colaborador.setBairro(bairro);
    colaborador.setCep(cep);
    colaborador.setCidade(cidade);
    colaborador.setEstado(estado);
    colaborador.setCmpEndereco(cmpEndereco);
    colaborador.setCpf(cpf);
    colaborador.setEndereco(endereco);
    colaborador.setNome(nome);
    colaborador.setStatus(status);
    colaborador.setNroRg(nroRg);
    colaborador.setIdLoja(Integer.parseInt(idLoja));
    colaborador.setIdTipoColaborador(Integer.parseInt(idTipoColaborador));
    colaborador.setTelefone(telefone);
    colaborador.setEmail(email);
    colaborador.setOrgRg(orgRg);
    colaborador.setUfRg(ufRg);
    colaborador.setCelular(celular);      
    colaborador.setUsuario(user);
   // colaborador.setIdColaborador(Integer.parseInt(idColaborador));
	  
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}

  dao = new ColaboradorDAO(conn);
  usuarioDAO = new UsuarioDAO(conn);
  daoPesquisaUsuario = new UsuarioDAO(conn);
 
  if (acao.equalsIgnoreCase("inc")) {
	  //inclui no banco de dados
    if(idUsuarioDAO != 0){
    	response.sendRedirect("formColaborador.jsp?acao=inc&mensagem=Login Existente");
    }else{
    	usuarioDAO.incluir(usuario);
    	colaborador.setIdUsuario(daoPesquisaUsuario.procurarLogin(login));
      	dao.incluir(colaborador);
    }
	
  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
	  dao.atualizar(colaborador);
	  usuarioDAO.atualizar(usuario);
  } else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  if(!dao.exclusaoIdColaboradorCompra(Integer.parseInt(idColaborador)) && !dao.exclusaoIdColaboradorOrcamento(Integer.parseInt(idColaborador)) &&
			  !dao.exclusaoIdColaboradorPedido(Integer.parseInt(idColaborador))){
		  dao.excluir(colaborador);
		  usuarioDAO.excluir(usuario); 
	  }else{
		  response.sendRedirect("listarColaborador.jsp?mensagem=Exclusão Inválida! Item já possui lançamentos.&acao=listar");
	  }
  }
} else {
 if (!acao.equalsIgnoreCase("voltar")) {
    nomeColaborador = request.getParameter("nomeColaborador");
    status = request.getParameter("status");
    if (status == null) status = "";
  }

  if (nomeColaborador!= null) {
    clausula = " WHERE apelido LIKE '"+nomeColaborador+"%'";
  } 
  if (!status.isEmpty()) {
    if (clausula.isEmpty()) {
      clausula = " WHERE status='"+status+"'";
    } else {
      clausula = clausula+" AND status='"+status+"'";
    }
  }
}

//seleciona todos os registros do banco de dados
List list;
dao = new ColaboradorDAO(conn);
clausula = clausula+" ORDER BY apelido ";
list = dao.listarColaborador(clausula);

int cont = 0;
%>
<h1 class="cabecalho_pagina">Cadastro de Colaborador</h1>

|<a class="button" href="formColaborador.jsp?acao=inc">Novo Cadastro</a>|<br>
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<body onload="document.forms[0].elements[0].focus();" >
<form action="listarColaborador.jsp">
<table colspan="2">
  <tr>
    <th class='label'>Nome do Colaborador</th>
    <td><input type="text" name="nomeColaborador" <%if (nomeColaborador != null) { %>value="<%=nomeColaborador %>"<% }%>  size="40" maxlength="40"></td>
    <td><input class="button" type="button" value="Localizar" onClick="javascript: localizar();" /></td>
    <td><input class="button" type="button" value="Nova pesquisa" onClick="javascript: novaPesquisa();" /></td>
  </tr>
  <tr>
    <th class="label">Status</th>
    <td class="label_radio">
      <input type="radio" class="radio" name="status" value="" <%= (status.equals("")? "checked": "") %>>Todos
      <input type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Ativo
      <input type="radio" class="radio" name="status" value="I" <%= (status.equals("I")? "checked": "") %>>Inativo</td>
  </tr>
</table>
<hr>

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr>
      <th class="grid">&nbsp;</th>
      <th class="grid"><center>Cód. Colaborador</center></th>
      <th class="grid"><center>Colaborador</center></th>
      <th class="grid">Status</th>
      <th class="grid">Excluir</th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	Colaborador colaborador = (Colaborador) it.next();
	cont++;

%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid" width="2%"><center><%=colaborador.getIdColaborador()%></center></td>
      <td class = "grid"><center><a href="formColaborador.jsp?acao=atu&idColaborador=<%=colaborador.getIdColaborador()%>"><%=colaborador.getApelido()%> / <%=colaborador.getNome()%></a></center></td>
      <td class = "grid" width="5%"><center><%=colaborador.getStatus()%></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=colaborador.getIdColaborador()%>, <%=colaborador.getIdUsuario()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
  	</tr>

<%
}
%>   
</table>
</form>
<p align="right">|<a class="button" href="formColaborador.jsp?acao=inc">Novo Cadastro</a>|
<%@include file="../fimConexao.jsp"%>