<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.Entidade" %>
<%@ page import="afero.model.EntidadeJuridica" %>
<%@ page import="afero.model.EntidadeEndereco" %>
<%@ page import="afero.model.EntidadeTelefone" %>
<%@ page import="afero.model.EntidadeEmail" %>
<%@ page import="afero.model.Classificacao" %>
<%@ page import="afero.model.TipoEntidade" %>
<%@ page import="afero.model.AreaAtuacao" %>
<%@ page import="afero.model.RamoAtividade" %>
<%@ page import="afero.persistence.EntidadeDAO" %>
<%@ page import="afero.persistence.EntidadeJuridicaDAO" %>
<%@ page import="afero.persistence.EntidadeEnderecoDAO" %>
<%@ page import="afero.persistence.EntidadeTelefoneDAO" %>
<%@ page import="afero.persistence.EntidadeEmailDAO" %>
<%@ page import="afero.persistence.ClassificacaoDAO" %>
<%@ page import="afero.persistence.AreaAtuacaoDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="afero.util.ConverteDate" %>
<%@ page import="java.text.ParseException" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function confirmaExcluir(cont, id) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarEntidadeJuridicaSimplificado.jsp?acao=exc&cdEntidade=' + id;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.nomeLocalizar.value = '';
  document.all.cnpjLocalizar.value = '';
  document.all.telefoneLocalizar.value = '';
  document.all.statusLocalizar.value = 'A'; //não está limpando
  document.forms[0].submit();
}  
</script>

<%
EntidadeDAO dao;
EntidadeJuridicaDAO dao1;
EntidadeEnderecoDAO dao2;
EntidadeTelefoneDAO dao3;
EntidadeEmailDAO dao4;

String acao = request.getParameter("acao");
if (acao == null) acao = "listar";

String nomeLocalizar = "";
String cnpjLocalizar = "";
String telefoneLocalizar = "";
String statusLocalizar = "A";
String mensagem = "";

// Dados básicos
String nome = "";
String tpInsc = "J"; 
String site = ""; 
String[] categorias = null;
String[] atividades = null;
String status ="A";
String observacao = "";
String bloqueio = "N";
String dtMod = "";
String dtCad = "";
String usuario ="";
String clausula = "";
String cpfCnpj = ""; 

// Dados complementares
String razaoSocial = "";
String dtAbertura = "";
String inscEstadual = "";
String codCnae = "";

Entidade entidade = new Entidade();

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
  // Dados básicos
  String cdEntidade = request.getParameter("cdEntidade");
  String idTipoEntidade = request.getParameter("idTipoEntidade");
  nome = request.getParameter("nome");
  tpInsc = request.getParameter("tpInsc");
  site = request.getParameter("site");
  categorias = request.getParameterValues("categoria");
  atividades = request.getParameterValues("atividade");
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
  if (tpInsc == null) tpInsc = "J";
  if (site == null) site = "";
  if (status == null) status = "A";
  if (observacao == null) observacao = "";
  if (bloqueio == null) bloqueio = "N";
  if (dtMod == null) dtMod = "";
  if (dtCad == null) dtCad = "";
  if (cpfCnpj == null) cpfCnpj = "";

  // Dados complementares
  razaoSocial = request.getParameter("razaoSocial");
  dtAbertura = request.getParameter("dtAbertura");
  inscEstadual = request.getParameter("inscEstadual");
  codCnae = request.getParameter("codCnae");
  if (razaoSocial == null) razaoSocial = "";
  if (dtAbertura == null) dtAbertura = "";
  if (inscEstadual == null) inscEstadual = "";
  if (codCnae == null) codCnae = "";

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
  
  EntidadeJuridica entidadeJuridica = new EntidadeJuridica();
  EntidadeEndereco entidadeEndereco = new EntidadeEndereco();
  EntidadeTelefone entidadeTelefone = new EntidadeTelefone();
  EntidadeEmail entidadeEmail = new EntidadeEmail();

	try {
	  if (!acao.equalsIgnoreCase("inc")){
		  entidade.setCdEntidade(Integer.parseInt(cdEntidade));
		  entidadeJuridica.setCdEntidade(Integer.parseInt(cdEntidade));
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
	  entidadeJuridica.setCnpj(cpfCnpj);
	  entidadeJuridica.setRazaoSocial(razaoSocial);
	  if (!dtAbertura.equals(""))
	  	entidadeJuridica.setDtAbertura(ConverteDate.stringToDate(dtAbertura));
	  entidadeJuridica.setInscEstadual(inscEstadual);
	  entidadeJuridica.setCodCnae(codCnae);
	  entidadeJuridica.setUsuario(usuario);

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
  dao1 = new EntidadeJuridicaDAO(conn);
  dao2 = new EntidadeEnderecoDAO(conn);
  dao3 = new EntidadeTelefoneDAO(conn);
  dao4 = new EntidadeEmailDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {
    EntidadeJuridicaDAO daoPesquisaEntidade = new EntidadeJuridicaDAO(conn);
		if (!cpfCnpj.equals("00.000.000/0000-00") && daoPesquisaEntidade.procurarCnpj(cpfCnpj) !=0 ) { 
      mensagem = "CNPJ já cadastrado";
      response.sendRedirect("formEntidadeJuridicaSimplificado.jsp?acao=inc&mensagem="+mensagem);
    } else {
	    //inclui no banco de dados
  	  int codEntidade = dao.incluir(entidade);
    	entidade.setCdEntidade(codEntidade);
  	  entidadeJuridica.setCdEntidade(codEntidade);
  	  entidadeEndereco.setCdEntidade(codEntidade);
  	  entidadeTelefone.setCdEntidade(codEntidade);
  	  entidadeEmail.setCdEntidade(codEntidade);
  	  dao1.incluir(entidadeJuridica);
  	  dao2.incluir(entidadeEndereco);
  	  dao3.incluir(entidadeTelefone);
  	  dao4.incluir(entidadeEmail);
  	}

  } else if (acao.equalsIgnoreCase("atu")) {
    EntidadeJuridicaDAO daoPesquisaEntidade = new EntidadeJuridicaDAO(conn);
		if (!cpfCnpj.equals("00.000.000/0000-00") && daoPesquisaEntidade.procurarCnpj(cpfCnpj) != entidade.getCdEntidade()) { 
      mensagem = "CNPJ já cadastrado";
      response.sendRedirect("formEntidadeJuridicaSimplificado.jsp?acao=atu&cdEntidade="+entidade.getCdEntidade()+"&mensagem="+mensagem);
    } else {
		  //atualiza no banco de dados
		  dao.atualizar(entidade);
	  	dao1.atualizar(entidadeJuridica);
	  	dao2.atualizar(entidadeEndereco);
	  	dao3.atualizar(entidadeTelefone);
	  	dao4.atualizar(entidadeEmail);
  	}

  } else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
  	//dao4.excluir(entidadeEmail);
  	//dao3.excluir(entidadeTelefone);
  	//dao2.excluir(entidadeEndereco);
  	//dao1.excluir(entidadeJuridica);
	  //dao.excluir(entidade);
  }
} else {
 if (!acao.equalsIgnoreCase("voltar")) {
    nomeLocalizar  = request.getParameter("nomeLocalizar");
    cnpjLocalizar  = request.getParameter("cnpjLocalizar");
    statusLocalizar = request.getParameter("statusLocalizar");
    telefoneLocalizar = request.getParameter("telefoneLocalizar");
    if (nomeLocalizar == null) nomeLocalizar = "";
    if (cnpjLocalizar == null) cnpjLocalizar = "";
    if (statusLocalizar == null) statusLocalizar = "A";
    if (telefoneLocalizar == null) telefoneLocalizar = "";
  }
 if(!telefoneLocalizar.equals("")){
	  if(tpInsc.equalsIgnoreCase("F")){
		  clausula = "JOIN tbentidadetelefone ec ON (f.cdEntidade = ec.cdEntidade) and (ec.nroTelefone like '"+telefoneLocalizar+"%') ";
         		  
	  }else{
		  clausula = "JOIN tbentidadetelefone ec ON (j.cdEntidade = ec.cdEntidade) and (ec.nroTelefone like '"+telefoneLocalizar+"%') ";
	  }
	  
 }
 if (nomeLocalizar!= null) {
	    clausula += " WHERE e.nome LIKE '"+nomeLocalizar+"%'";
	  } 
	  if (!cnpjLocalizar.equals("")) {
	    if (clausula.isEmpty()) {
	    	if(tpInsc.equalsIgnoreCase("F")){
	    		clausula += " WHERE f.cpf LIKE '"+cnpjLocalizar+"%'";
	    	}else{
	    		clausula += " WHERE j.cnpj LIKE '"+cnpjLocalizar+"%'";
	    	}  
	    } else {
	    	if(tpInsc.equalsIgnoreCase("F")){
	    		clausula = clausula+" AND f.cpf LIKE '"+cnpjLocalizar+"%'";
	    	}else{
	    		clausula = clausula+" AND j.cnpj LIKE '"+cnpjLocalizar+"%'";
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

//  if (nomeLocalizar!= null) {
  //  clausula = " WHERE e.nome LIKE '"+nomeLocalizar+"%'";
 // } 
  //if (!cnpjLocalizar.equals("")) {
   // if (clausula.isEmpty()) {
    //  clausula = " WHERE j.cnpj LIKE '"+cnpjLocalizar+"%'";
   // } else {
    //  clausula = clausula+" AND j.cnpj LIKE '"+cnpjLocalizar+"%'";
   // }
 // }
  //if (!statusLocalizar.equals("T")) {
 //   if (clausula.isEmpty()) {
  //    clausula = " WHERE e.status='"+statusLocalizar+"'";
  //  } else {
  //    clausula = clausula+" AND e.status='"+statusLocalizar+"'";
  //  }
 // }
//}

//if (clausula.isEmpty()) {
  //clausula = " WHERE e.tpInsc='"+tpInsc+"'";
//} else {
 // clausula = clausula+" AND e.tpInsc='"+tpInsc+"'";
//}

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

  //atualiza atividades
  AreaAtuacaoDAO daoAreaAtuacao;
  daoAreaAtuacao = new AreaAtuacaoDAO(conn);
	daoAreaAtuacao.excluir(entidade);
  if (atividades != null) {
  	int idRamoAtividade;
    for (int i = 0; i < atividades.length; i++) {
    	if (atividades[i] != null) {
				try {
				idRamoAtividade = Integer.parseInt(atividades[i]);
				} catch (NumberFormatException nfe) {
					throw new Exception("Código inválido");
				}
			  daoAreaAtuacao = new AreaAtuacaoDAO(conn);
				daoAreaAtuacao.incluir(new AreaAtuacao(entidade.getCdEntidade(), idRamoAtividade));
			}
    }
  }
}

if (acao.equalsIgnoreCase("inc") && mensagem.isEmpty()) {
	response.sendRedirect("formEntidadeJuridicaSimplificado.jsp?acao=atu&cdEntidade=" + entidade.getCdEntidade());
}

//seleciona todos os registros do banco de dados
List list;
dao1 = new EntidadeJuridicaDAO(conn);
clausula = clausula+" ORDER BY e.nome ";
list = dao1.listarEntidadesJuridica(clausula);

%>
<h1 class="cabecalho_pagina">Cadastro de Entidade Jurídica (simplificado)</h1>

|<a class="button" href="formEntidadeJuridicaSimplificado.jsp?acao=inc">Novo Cadastro</a>|<br>
<hr>
<body onload="document.forms[0].elements[0].focus();" >
<form action="listarEntidadeJuridicaSimplificado.jsp">
<table colspan="2">
  <tr>
    <th class="label">Nome</th>
    <td><input type="text" name="nomeLocalizar" <%if (nomeLocalizar != null) { %>value="<%=nomeLocalizar %>"<% }%> size="40" maxlength="60"></td>
    <td><input class="button" type="button" value="Localizar" onClick="javascript: localizar();" /></td>
    <td><input class="button" type="button" value="Nova pesquisa" onClick="javascript: novaPesquisa();" /></td>
  </tr>
   <tr>
    <th class="label">CNPJ</th>
    <td><input type="text" id="cnpjLocalizar" name="cnpjLocalizar" <%if (cnpjLocalizar != null) { %>value="<%=cnpjLocalizar%>"<% }%> size="18" maxlength="18" onblur="chkCPFCNPJ(this)"></td>
  </tr>
     <tr>
    <th class="label">Telefone</th>
    <td><input type="text" id="telefoneLocalizar" name="telefoneLocalizar" <%if (telefoneLocalizar != null) { %>value="<%=telefoneLocalizar%>"<% }%> size="14" maxlength="14"></td>
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
      <th class="grid">CNPJ</th>
      <th class="grid">Status</th>
   <!--    <th class="grid">Excluir</th> -->
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
	EntidadeJuridica entidadeJuridica = (EntidadeJuridica) it.next();
	cont++;
  //EntidadeDAO dao1 = new EntidadeDAO(conn);
 // Entidade estado = dao1.procurarEstado(.getCdEstado());
%>
    <tr>
      <td class = "grid" width="1%"><center><%=rowNum+cont%></center></td>
      <td class = "grid" width="30%"><center><a href="formEntidadeJuridicaSimplificado.jsp?acao=atu&cdEntidade=<%=entidadeJuridica.getCdEntidade()%>"><%=entidadeJuridica.getNome()%></a></center></td>
      <td class = "grid" width="5%"><center><%=entidadeJuridica.getCnpj()%></center></td>
      <td class = "grid" width="2%"><center><%=entidadeJuridica.getStatus()%></center></td>
     <!-- <td class = "grid" width="2%"><center><a href="javascript: confirmaExcluir(<%=rowNum+cont%>,<%=entidadeJuridica.getCdEntidade()%>);"><img border = "0" src="../images/delete.gif"></a></center></td> --> 
  	</tr>
<%
}
%>   
</table>
</form>
<p align="right">|<a class="button" href="formEntidadeJuridicaSimplificado.jsp?acao=inc">Novo Cadastro</a>|
<%  if (rowNum != 0 || hasNext) { %>
        <center>
<%      if (rowNum != 0) { %>
<a class="link" href="listarEntidadeJuridicaSimplificado.jsp?rowNum=<%=0%>&nomeLocalizar=<%=nomeLocalizar%>&cnpjLocalizar=<%=cnpjLocalizar%>&telefoneLocalizar=<%=telefoneLocalizar%>&statusLocalizar=<%=statusLocalizar%>">Primeira</a>&nbsp&nbsp
|&nbsp&nbsp<a class="link" href="listarEntidadeJuridicaSimplificado.jsp?rowNum=<%=rowNum-gridSize%>&nomeLocalizar=<%=nomeLocalizar%>&cnpjLocalizar=<%=cnpjLocalizar%>&telefoneLocalizar=<%=telefoneLocalizar%>&statusLocalizar=<%=statusLocalizar%>">< Anterior</a>&nbsp&nbsp
<%      } else { %>
Primeira&nbsp&nbsp|&nbsp&nbsp< Anterior&nbsp
<%      } %>
<%      if (hasNext) { %>
|&nbsp&nbsp<a class="link" href="listarEntidadeJuridicaSimplificado.jsp?rowNum=<%=rowNum+gridSize%>&nomeLocalizar=<%=nomeLocalizar%>&cnpjLocalizar=<%=cnpjLocalizar%>&telefoneLocalizar=<%=telefoneLocalizar%>&statusLocalizar=<%=statusLocalizar%>">Próxima ></a>&nbsp&nbsp
|&nbsp&nbsp<a class="link" href="listarEntidadeJuridicaSimplificado.jsp?rowNum=<%=rowCount-gridSize%>&nomeLocalizar=<%=nomeLocalizar%>&cnpjLocalizar=<%=cnpjLocalizar%>&telefoneLocalizar=<%=telefoneLocalizar%>&statusLocalizar=<%=statusLocalizar%>">Última</a>
<%      } else { %>
|&nbsp&nbsp Próxima >&nbsp&nbsp|&nbsp&nbspÚltima
<%      } %>
        </center>
<%  } %>
<%@include file="../fimConexao.jsp"%>