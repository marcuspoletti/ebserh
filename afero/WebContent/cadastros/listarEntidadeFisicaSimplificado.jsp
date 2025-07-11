<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.Entidade" %>
<%@ page import="afero.model.EntidadeFisica" %>
<%@ page import="afero.model.EntidadeEndereco" %>
<%@ page import="afero.model.EntidadeTelefone" %>
<%@ page import="afero.model.EntidadeEmail" %>
<%@ page import="afero.model.Classificacao" %>
<%@ page import="afero.persistence.EntidadeDAO" %>
<%@ page import="afero.persistence.EntidadeFisicaDAO" %>
<%@ page import="afero.persistence.EntidadeEnderecoDAO" %>
<%@ page import="afero.persistence.EntidadeTelefoneDAO" %>
<%@ page import="afero.persistence.EntidadeEmailDAO" %>
<%@page import="afero.persistence.ClassificacaoDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="afero.util.ConverteDate" %>
<%@ page import="java.text.ParseException" %>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<script>
function confirmaExcluir(cont, id) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarEntidadeFisicaSimplificado.jsp?acao=exc&cdEntidade=' + id;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.nomeLocalizar.value = '';
  document.all.cpfLocalizar.value = '';
  document.all.telefoneLocalizar.value = '';
  document.all.statusLocalizar.value = 'A'; //não está limpando
  document.forms[0].submit();
}  
</script>

<%
EntidadeDAO dao;
EntidadeFisicaDAO dao1;
EntidadeEnderecoDAO dao2;
EntidadeTelefoneDAO dao3;
EntidadeEmailDAO dao4;

String acao = request.getParameter("acao");
if (acao == null) acao = "listar";

String nomeLocalizar = "";
String cpfLocalizar = "";
String telefoneLocalizar = "";
String statusLocalizar = "A";
String mensagem = "";

// Dados básicos
String nome = "";
String tpInsc = "F"; 
String site = ""; 
String[] categorias = null;
String status = "A";
String observacao = "";
String bloqueio = "N";
String dtMod = "";
String dtCad = "";
String usuario ="";
String clausula = "";
String cpfCnpj = ""; 

// Dados complementares
String dtNascimento = "";
String dtCasamento = "";
String cargo = "";
String departamento = "";
String empresa = "";
String sexo = "M";
String cdEstadoCivil = "1";
String cdEscolaridade = "7";
String cpfConjuge = "";
String conjuge = "";
String mae = "";
String pai = "";
String nroRg = "";
String orgRg = "";
String ufRg = "";
String dtRg = "";
String hobby = "";
String time = "";

Entidade entidade = new Entidade();

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
  // Dados básicos
  String cdEntidade = request.getParameter("cdEntidade");
  String idTipoEntidade = request.getParameter("idTipoEntidade");
  nome = request.getParameter("nome");
  tpInsc = request.getParameter("tpInsc");
  site = request.getParameter("site");
  categorias = request.getParameterValues("categoria");
  status = request.getParameter("status");
  observacao = request.getParameter("observacao");
  bloqueio = request.getParameter("bloqueio");
  dtMod = request.getParameter("dtMod");
  dtCad = request.getParameter("dtCad");
  usuario = request.getParameter("usuario");
  cpfCnpj = request.getParameter("cpfCnpj");
  
  if (cdEntidade == null) cdEntidade = "";
  if (idTipoEntidade == null) idTipoEntidade = "0";
  if (nome == null) nome = "";
  if (tpInsc == null) tpInsc = "F";
  if (site == null) site = "";
  if (status == null) status = "A";
  if (observacao == null) observacao = "";
  if (bloqueio == null) bloqueio = "N";
  if (dtMod == null) dtMod = "";
  if (dtCad == null) dtCad = "";
  if (cpfCnpj == null) cpfCnpj = "";

  // Dados complementares
  dtNascimento = request.getParameter("dtNascimento");
  dtCasamento = request.getParameter("dtCasamento");
  cargo = request.getParameter("cargo");
  departamento = request.getParameter("departamento");
  empresa = request.getParameter("empresa");
  sexo = request.getParameter("sexo");
  cdEstadoCivil = request.getParameter("cdEstadoCivil");
  cdEscolaridade = request.getParameter("cdEscolaridade");
  cpfConjuge = request.getParameter("cpfConjuge");
  conjuge = request.getParameter("conjuge");
  mae = request.getParameter("mae");
  pai = request.getParameter("pai");
  nroRg = request.getParameter("nroRg");
  orgRg = request.getParameter("orgRg");
  ufRg = request.getParameter("ufRg");
  dtRg = request.getParameter("dtRg");
  hobby = request.getParameter("hobby");
  time = request.getParameter("time");
  if (dtNascimento == null) dtNascimento = "";
  if (dtCasamento == null) dtCasamento = "";
  if (cargo == null) cargo = "";
  if (departamento == null) departamento = "";
  if (empresa == null) empresa = "";
  if (sexo == null) sexo = "M";
  if (cdEstadoCivil == null) cdEstadoCivil = "1";
  if (cdEscolaridade == null) cdEscolaridade = "7";
  if (cpfConjuge == null) cpfConjuge = "";
  if (conjuge == null) conjuge = "";
  if (mae == null) mae = "";
  if (pai == null) pai = "";
  if (nroRg == null) nroRg = "";
  if (orgRg == null) orgRg = "";
  if (ufRg == null) ufRg = "";
  if (dtRg == null) dtRg = "";
  if (hobby == null) hobby = "";
  if (time == null) time = "";

  // Endereço padrão
  String idEntidadeEndereco = request.getParameter("idEntidadeEndereco");
  String cdTipoEndereco = request.getParameter("cdTipoEndereco");
  String cdTipoLogradouro = request.getParameter("cdTipoLogradouro");
  String idCidade = request.getParameter("idCidade");
  String dsEndereco = request.getParameter("dsEndereco");
  String nroEndereco = request.getParameter("nroEndereco");
  String cmpEndereco = request.getParameter("cmpEndereco");
  String baiEndereco = request.getParameter("baiEndereco");
  String cepEndereco = request.getParameter("cepEndereco");
  String cxpEndereco = request.getParameter("cxpEndereco");
  String refEndereco = request.getParameter("refEndereco");
  String enderecoPadrao = request.getParameter("enderecoPadrao");
  if (idEntidadeEndereco == null) idEntidadeEndereco = "";
  if (cdTipoEndereco == null) cdTipoEndereco = "1";
  if (cdTipoLogradouro == null) cdTipoLogradouro = "34";
  if (idCidade == null) idCidade = "1";
  if (dsEndereco == null) dsEndereco = "";
  if (nroEndereco == null) nroEndereco = "";
  if (cmpEndereco == null) cmpEndereco = "";
  if (baiEndereco == null) baiEndereco = "";
  if (cepEndereco == null) cepEndereco = "";
  if (cxpEndereco == null) cxpEndereco = "";
  if (refEndereco == null) refEndereco = "";
  if (enderecoPadrao == null) enderecoPadrao = "S";
  
  // Telefone padrão
  String idEntidadeTelefone = request.getParameter("idEntidadeTelefone");
  String cdTipoTelefone = request.getParameter("cdTipoTelefone");
  String nroTelefone = request.getParameter("nroTelefone");
  String ramTelefone = request.getParameter("ramTelefone");
  String telefonePadrao = request.getParameter("telefonePadrao");
  if (idEntidadeTelefone == null) idEntidadeTelefone = "";
  if (cdTipoTelefone == null) cdTipoTelefone = "1";
  if (nroTelefone == null) nroTelefone = "";
  if (ramTelefone == null) ramTelefone = "";
  if (telefonePadrao == null) telefonePadrao = "S";

  // Email padrão
  String idEntidadeEmail = request.getParameter("idEntidadeEmail");
  String cdTipoEmail = request.getParameter("cdTipoEmail");
  String dsEmail = request.getParameter("dsEmail");
  String emailPadrao = request.getParameter("emailPadrao");
  if (idEntidadeEmail == null) idEntidadeEmail = "";
  if (cdTipoEmail == null) cdTipoEmail = "1";
  if (dsEmail == null) dsEmail = "";
  if (emailPadrao == null) emailPadrao = "S";

  usuario = (String)session.getAttribute("Login");
  
  EntidadeFisica entidadeFisica = new EntidadeFisica();
  EntidadeEndereco entidadeEndereco = new EntidadeEndereco();
  EntidadeTelefone entidadeTelefone = new EntidadeTelefone();
  EntidadeEmail entidadeEmail = new EntidadeEmail();

	try {
	  if (!acao.equalsIgnoreCase("inc")){
		  entidade.setCdEntidade(Integer.parseInt(cdEntidade));
		  entidadeFisica.setCdEntidade(Integer.parseInt(cdEntidade));
		  entidadeEndereco.setIdEntidadeEndereco(Integer.parseInt(idEntidadeEndereco));
		  entidadeTelefone.setIdEntidadeTelefone(Integer.parseInt(idEntidadeTelefone));
		  entidadeEmail.setIdEntidadeEmail(Integer.parseInt(idEntidadeEmail));
	  }
	  // Dados básicos
	  entidade.setNome(nome);
	  entidade.setTpInsc(tpInsc);
	  entidade.setSite(site);
	  entidade.setStatus(status);
	  entidade.setObservacao(observacao);
	  entidade.setBloqueio(bloqueio);
	  entidade.setUsuario(usuario);

		// Dados complementares
	  entidadeFisica.setCpf(cpfCnpj);
	  if (!dtNascimento.equals(""))
	  	entidadeFisica.setDtNascimento(ConverteDate.stringToDate(dtNascimento));
	  if (!dtCasamento.equals(""))
	  entidadeFisica.setDtCasamento(ConverteDate.stringToDate(dtCasamento));
	  entidadeFisica.setCargo(cargo);
	  entidadeFisica.setDepartamento(departamento);
	  entidadeFisica.setEmpresa(empresa);
	  entidadeFisica.setSexo(sexo);
	  entidadeFisica.setCdEstadoCivil(Integer.parseInt(cdEstadoCivil));
    entidadeFisica.setCdEscolaridade(Integer.parseInt(cdEscolaridade));	  
    entidadeFisica.setCpfConjuge(cpfConjuge);
    entidadeFisica.setConjuge(conjuge);
    entidadeFisica.setMae(mae);
    entidadeFisica.setPai(pai);
		entidadeFisica.setNroRg(nroRg);
		entidadeFisica.setOrgRg(orgRg);
		entidadeFisica.setUfRg(ufRg);
	  if (!dtRg.equals(""))
			entidadeFisica.setDtRg(ConverteDate.stringToDate(dtRg));   
		entidadeFisica.setHobby(hobby);
		entidadeFisica.setTime(time); 
	  entidadeFisica.setUsuario(usuario);

		// Endereço padrão
	  if (!cdEntidade.equals(""))
	  		entidadeEndereco.setCdEntidade(Integer.parseInt(cdEntidade));
	  entidadeEndereco.setCdTipoEndereco(Integer.parseInt(cdTipoEndereco));
	  entidadeEndereco.setCdTipoLogradouro(Integer.parseInt(cdTipoLogradouro));
	  entidadeEndereco.setIdCidade(Integer.parseInt(idCidade));
	  entidadeEndereco.setDsEndereco(dsEndereco);
	  entidadeEndereco.setNroEndereco(nroEndereco);
	  entidadeEndereco.setCmpEndereco(cmpEndereco);
	  entidadeEndereco.setBaiEndereco(baiEndereco);
	  entidadeEndereco.setCepEndereco(cepEndereco);
	  entidadeEndereco.setCxpEndereco(cxpEndereco);
	  entidadeEndereco.setRefEndereco(refEndereco);
	  entidadeEndereco.setPadrao(enderecoPadrao);
	  entidadeEndereco.setUsuario(usuario);
	  
		// Telefone padrão
	  if (!cdEntidade.equals(""))
	  		entidadeTelefone.setCdEntidade(Integer.parseInt(cdEntidade));
	  entidadeTelefone.setCdTipoTelefone(Integer.parseInt(cdTipoTelefone));
	  entidadeTelefone.setNroTelefone(nroTelefone);
	  entidadeTelefone.setRamTelefone(ramTelefone);
	  entidadeTelefone.setPadrao(telefonePadrao);
	  entidadeTelefone.setUsuario(usuario);

		// Email padrão
	  if (!cdEntidade.equals(""))
	  		entidadeEmail.setCdEntidade(Integer.parseInt(cdEntidade));
	  entidadeEmail.setCdTipoEmail(Integer.parseInt(cdTipoEmail));
	  entidadeEmail.setDsEmail(dsEmail);
	  entidadeEmail.setPadrao(emailPadrao);
	  entidadeEmail.setUsuario(usuario);
	  
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	} catch (ParseException pe) {
		throw new Exception("Data inválida");
	}

  dao = new EntidadeDAO(conn);
  dao1 = new EntidadeFisicaDAO(conn);
  dao2 = new EntidadeEnderecoDAO(conn);
  dao3 = new EntidadeTelefoneDAO(conn);
  dao4 = new EntidadeEmailDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {
    EntidadeFisicaDAO daoPesquisaEntidade = new EntidadeFisicaDAO(conn);
		if (!cpfCnpj.equals("000.000.000-00") && daoPesquisaEntidade.procurarCpf(cpfCnpj) != 0 ) { 
      mensagem = "CPF já cadastrado";
      response.sendRedirect("formEntidadeFisicaSimplificado.jsp?acao=inc&mensagem="+mensagem);
    } else {
	    //inclui no banco de dados
    	int codEntidade = dao.incluir(entidade);
    	entidade.setCdEntidade(codEntidade);
    	entidadeFisica.setCdEntidade(codEntidade);
    	entidadeEndereco.setCdEntidade(codEntidade);
    	entidadeTelefone.setCdEntidade(codEntidade);
    	entidadeEmail.setCdEntidade(codEntidade);
    	dao1.incluir(entidadeFisica);
    	dao2.incluir(entidadeEndereco);
    	dao3.incluir(entidadeTelefone);
    	dao4.incluir(entidadeEmail);
  	}

  } else if (acao.equalsIgnoreCase("atu")) {
    EntidadeFisicaDAO daoPesquisaEntidade = new EntidadeFisicaDAO(conn);
		if (!cpfCnpj.equals("000.000.000-00") && daoPesquisaEntidade.procurarCpf(cpfCnpj) != entidade.getCdEntidade()) { 
      mensagem = "CPF já cadastrado";
      response.sendRedirect("formEntidadeFisicaSimplificado.jsp?acao=atu&cdEntidade="+entidade.getCdEntidade()+"&mensagem="+mensagem);
    } else {
		  //atualiza no banco de dados
		  dao.atualizar(entidade);
	  	dao1.atualizar(entidadeFisica);
	  	dao2.atualizar(entidadeEndereco);
	  	dao3.atualizar(entidadeTelefone);
	  	dao4.atualizar(entidadeEmail);
  	}

  } else if (acao.equalsIgnoreCase("exc")) {
	  //exclui no banco de dados
  	//dao4.excluir(entidadeEmail);
  	//dao3.excluir(entidadeTelefone);
  	//dao2.excluir(entidadeEndereco);
  	//dao1.excluir(entidadeFisica);
	  //dao.excluir(entidade);
  }
} else {
 if (!acao.equalsIgnoreCase("voltar")) {
    nomeLocalizar  = request.getParameter("nomeLocalizar");
    cpfLocalizar  = request.getParameter("cpfLocalizar");
    statusLocalizar = request.getParameter("statusLocalizar");
    telefoneLocalizar = request.getParameter("telefoneLocalizar");
    if (nomeLocalizar == null) nomeLocalizar = "";
    if (cpfLocalizar == null) cpfLocalizar = "";
    if (statusLocalizar == null) statusLocalizar = "A";
    if (telefoneLocalizar == null) telefoneLocalizar = "";
  }

 if(!telefoneLocalizar.equals("")){
	  if(tpInsc.equalsIgnoreCase("F")){
		  clausula = "JOIN tbentidadetelefone ec ON (f.cdEntidade = ec.cdEntidade) and (ec.nroTelefone like '"+telefoneLocalizar+"%') ";
         		  
	  }
	  
 }
 
 // if (nomeLocalizar!= null) {
  //  clausula = " WHERE e.nome LIKE '"+nomeLocalizar+"%'";
  //} 
  //if (!cpfLocalizar.equals("")) {
   // if (clausula.isEmpty()) {
   //   clausula = " WHERE f.cpf LIKE '"+cpfLocalizar+"%'";
    //} else {
     // clausula = clausula+" AND f.cpf LIKE '"+cpfLocalizar+"%'";
   // }
  //}
  //if (!statusLocalizar.equals("T")) {
   // if (clausula.isEmpty()) {
    //  clausula = " WHERE e.status='"+statusLocalizar+"'";
   // } else {
   //   clausula = clausula+" AND e.status='"+statusLocalizar+"'";
   // }
 // }
//}

//if (clausula.isEmpty()) {
//  clausula = " WHERE e.tpInsc='"+tpInsc+"'";
//} else {
//  clausula = clausula+" AND e.tpInsc='"+tpInsc+"'";
//}
if (nomeLocalizar!= null) {
    clausula += " WHERE e.nome LIKE '"+nomeLocalizar+"%'";
  } 
  if (!cpfLocalizar.equals("")) {
    if (clausula.isEmpty()) {
    	if(tpInsc.equalsIgnoreCase("F")){
    		clausula += " WHERE f.cpf LIKE '"+cpfLocalizar+"%'";
    	}
    } else {
    	if(tpInsc.equalsIgnoreCase("F")){
    		clausula = clausula+" AND f.cpf LIKE '"+cpfLocalizar+"%'";
    	}
      
    }
  }
  if (!statusLocalizar.equals("T")) {
    if (clausula.isEmpty()) {
      clausula += " WHERE e.status='"+statusLocalizar+"'";
    } else {
      clausula = clausula+" AND e.status='"+statusLocalizar+"'";
    }
  }

if (clausula.isEmpty()) {
  clausula += " WHERE e.tpInsc='"+tpInsc+"'";
} else {
  clausula = clausula+" AND e.tpInsc='"+tpInsc+"'";
}
}
if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu")) {
  //atualiza categorias
  ClassificacaoDAO daoClassificacao;
  daoClassificacao = new ClassificacaoDAO(conn);
	daoClassificacao.excluir(entidade);
  if (categorias != null) {
  	int idTipoEntidade;
    for (int i = 0; i < categorias.length; i++) {
    	if (categorias[i] != null) {
				try {
				idTipoEntidade = Integer.parseInt(categorias[i]);
				} catch (NumberFormatException nfe) {
					throw new Exception("Código inválido");
				}
			  daoClassificacao = new ClassificacaoDAO(conn);
				daoClassificacao.incluir(new Classificacao(entidade.getCdEntidade(), idTipoEntidade));
			}
    }
  }
}

if (acao.equalsIgnoreCase("inc") && mensagem.isEmpty()) {
	response.sendRedirect("formEntidadeFisicaSimplificado.jsp?acao=atu&cdEntidade=" + entidade.getCdEntidade());
}

//seleciona todos os registros do banco de dados
List list;
dao1 = new EntidadeFisicaDAO(conn);
clausula = clausula+" ORDER BY e.nome ";
list = dao1.listarEntidadeFisica(clausula);

%>
<h1 class="cabecalho_pagina">Cadastro de Entidade Física (simplificado)</h1>

|<a class="button" href="formEntidadeFisicaSimplificado.jsp?acao=inc">Novo Cadastro</a>|<br>
<hr>
<body onload="document.forms[0].elements[0].focus();" >
<form action="listarEntidadeFisicaSimplificado.jsp">
<table colspan="2">
  <tr>
    <th class="label">Nome</th>
    <td><input type="text" name="nomeLocalizar" <%if (nomeLocalizar != null) { %>value="<%=nomeLocalizar %>"<% }%> size="40" maxlength="60"></td>
    <td><input class="button" type="button" value="Localizar" onClick="javascript: localizar();" /></td>
    <td><input class="button" type="button" value="Nova pesquisa" onClick="javascript: novaPesquisa();" /></td>
  </tr>
   <tr>
    <th class="label">CPF</th>
    <td><input type="text" id="cpfLocalizar" name="cpfLocalizar" <%if (cpfLocalizar != null) { %>value="<%=cpfLocalizar%>"<% }%> size="14" maxlength="14" onblur="chkCPFCNPJ(this)"></td>
  </tr>
   <tr>
    <th class="label">Telefone</th>
    <td><input type="text" id="telefoneLocalizar" name="telefoneLocalizar" <%if (telefoneLocalizar != null) { %>value="<%=telefoneLocalizar%>"<% }%> size="14" maxlength="14")"></td>
  </tr>
  <tr>
    <th class="label">Status</th>
    <td class="label_radio">
      <input type="radio" class="radio" name="statusLocalizar" value="A" <%= (statusLocalizar.equals("A")? "checked": "") %>>Ativo
      <input type="radio" class="radio" name="statusLocalizar" value="I" <%= (statusLocalizar.equals("I")? "checked": "") %>>Inativo
      <input type="radio" class="radio" name="statusLocalizar" value="T" <%= (statusLocalizar.equals("T")? "checked": "") %>>Todos</td>
  </tr>
</table>
<hr>

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr">
      <th class="grid">&nbsp;</th>
      <th class="grid"><center>Nome</center></th>
      <th class="grid">CPF</th>
      <th class="grid">Status</th>
       <!-- <th class="grid">Excluir</th> -->
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
	EntidadeFisica entidadeFisica = (EntidadeFisica) it.next();
	cont++;
  //EntidadeDAO dao1 = new EntidadeDAO(conn);
 // Entidade estado = dao1.procurarEstado(.getCdEstado());
%>
    <tr>
      <td class = "grid" width="2%"><center><%=rowNum+cont%></center></td>
      <td class = "grid"><center><a href="formEntidadeFisicaSimplificado.jsp?acao=atu&cdEntidade=<%=entidadeFisica.getCdEntidade()%>"><%=entidadeFisica.getNome()%></a></center></td>
      <td class = "grid" width="10%"><center><%=entidadeFisica.getCpf()%></center></td>
      <td class = "grid" width="5%"><center><%=entidadeFisica.getStatus()%></center></td>
     <!-- <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=rowNum+cont%>,<%=entidadeFisica.getCdEntidade()%>);"><img border = "0" src="../images/delete.gif"></a></center></td> --> 
  	</tr>
<%
}
%>   
</table>
</form>
<p align="right">|<a class="button" href="formEntidadeFisicaSimplificado.jsp?acao=inc">Novo Cadastro</a>|
<%  if (rowNum != 0 || hasNext) { %>
        <center>
<%      if (rowNum != 0) { %>
<a class="link" href="listarEntidadeFisicaSimplificado.jsp?rowNum=<%=0%>&nomeLocalizar=<%=nomeLocalizar%>&cpfLocalizar=<%=cpfLocalizar%>&telefoneLocalizar=<%=telefoneLocalizar%>&statusLocalizar=<%=statusLocalizar%>">Primeira</a>&nbsp&nbsp
|&nbsp&nbsp<a class="link" href="listarEntidadeFisicaSimplificado.jsp?rowNum=<%=rowNum-gridSize%>&nomeLocalizar=<%=nomeLocalizar%>&cpfLocalizar=<%=cpfLocalizar%>&telefoneLocalizar=<%=telefoneLocalizar%>&statusLocalizar=<%=statusLocalizar%>">< Anterior</a>&nbsp&nbsp
<%      } else { %>
Primeira&nbsp&nbsp|&nbsp&nbsp< Anterior&nbsp
<%      } %>
<%      if (hasNext) { %>
|&nbsp&nbsp<a class="link" href="listarEntidadeFisicaSimplificado.jsp?rowNum=<%=rowNum+gridSize%>&nomeLocalizar=<%=nomeLocalizar%>&cpfLocalizar=<%=cpfLocalizar%>&telefoneLocalizar=<%=telefoneLocalizar%>&statusLocalizar=<%=statusLocalizar%>">Próxima ></a>&nbsp&nbsp
|&nbsp&nbsp<a class="link" href="listarEntidadeFisicaSimplificado.jsp?rowNum=<%=rowCount-gridSize%>&nomeLocalizar=<%=nomeLocalizar%>&cpfLocalizar=<%=cpfLocalizar%>&telefoneLocalizar=<%=telefoneLocalizar%>&statusLocalizar=<%=statusLocalizar%>">Última</a>
<%      } else { %>
|&nbsp&nbsp Próxima >&nbsp&nbsp|&nbsp&nbspÚltima
<%      } %>
        </center>
<%  } %>
<%@include file="../fimConexao.jsp"%>