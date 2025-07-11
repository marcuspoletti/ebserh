<html>
<head>
<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.Entidade" %>
<%@ page import="afero.model.Cidade" %>
<%@ page import="afero.model.EntidadeFisica" %>
<%@ page import="afero.model.EntidadeEndereco" %>
<%@ page import="afero.model.EntidadeTelefone" %>
<%@ page import="afero.model.EntidadeEmail" %>
<%@ page import="afero.model.Classificacao" %>
<%@ page import="afero.model.TipoEntidade" %>
<%@ page import="afero.persistence.EntidadeDAO"%>
<%@ page import="afero.persistence.CidadeDAO"%>
<%@ page import="afero.persistence.EntidadeFisicaDAO" %>
<%@ page import="afero.persistence.EntidadeEnderecoDAO" %>
<%@ page import="afero.persistence.EntidadeTelefoneDAO" %>
<%@ page import="afero.persistence.EntidadeEmailDAO" %>
<%@ page import="afero.persistence.ClassificacaoDAO" %>
<%@ page import="afero.persistence.TipoEntidadeDAO" %>
<%@ page import="afero.util.ConverteDate" %>
<%@ page import="afero.util.BuscaCep" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<link type="text/css" rel="Stylesheet" href="../css/abas.css" />
<script language=JavaScript src="../js/abas.js" type=text/javascript></script>
<script src="../js/common.js" /></script>
<script>
function salvar() {
   if (document.all.cdEntidade.value == '') {
      window.alert("O campo Código da entidade é obrigatório.");
      document.all.cdEntidade.focus();
   } else if (document.all.nome.value == '') {
    window.alert("O campo Nome é obrigatório.");
    document.all.nome.focus();
   } else if (document.all.cpfCnpj.value == '') {
    window.alert("O campo CPF é obrigatório.");
    document.all.cpfCnpj.focus();
   } else {
  	document.forms[0].submit();
  }
}

function cancelar() {
  document.forms[0].action="formEntidadeFisicaSimplificado.jsp";
  document.forms[0].submit();
}
function cep() {
	  document.forms[0].action="formEntidadeFisicaSimplificado.jsp?buscaCep="+'S';
	  document.forms[0].submit();
}

function voltar() {
  document.forms[0].action = 'listarEntidadeFisicaSimplificado.jsp?acao=voltar'
	document.forms[0].submit();
}

function comboSelect(combo, key) {
  var err = window.onerror; 
  window.onerror = new Function('return true'); 
  if (!combo) return; 
  combo.selectedIndex=-1; 
  for (var i = 0; i < combo.options.length; i++) {
    if (combo.multiple) {
      combo.options[i].selected=((","+key+",").indexOf(","+combo.options[i].value+",") != -1); 
    } else {
      combo.options[i].selected=(combo.options[i].value == key);
    }
  }
  window.onerror = err;
}  

function selecionarAba(aba) {
	document.all.selectAba.value == aba;
}
</script>
</head>
<%
	//variáveis capturadas da página listarEntidadeFisicaSimplificado.jsp
	String buscaCep = request.getParameter("buscaCep");
         if(buscaCep == null){
        	 buscaCep = "N";
         }
	String cdEntidade = request.getParameter("cdEntidade");
	String acao = request.getParameter("acao");
	String selectAba = request.getParameter("selectAba");
	if (acao == null) acao = "inc";
	if (cdEntidade == null) cdEntidade = "";
	if (selectAba == null) selectAba = "1";

	String nome = "";
	if(request.getParameter("nome")!= null)nome = request.getParameter("nome");
	String tpInsc = "F";
	String cpfCnpj = "000.000.000-00";
	if(request.getParameter("cpfCnpj")!= null)cpfCnpj = request.getParameter("cpfCnpj");
	String site = "";
	if(request.getParameter("site")!= null)site = request.getParameter("site");
	String status = "A";
	String observacao = "";
	if(request.getParameter("observacao")!= null)observacao = request.getParameter("observacao");
	String bloqueio = "N";
	String dtMod = "";
	String dtCad = "";
	String usuario = "";
	if(request.getParameter("usuario")!= null)usuario = request.getParameter("usuario");
	String dtNascimento = "";
	if(request.getParameter("dtNascimento")!= null)dtNascimento = request.getParameter("dtNascimento");
	String dtCasamento = "";
	if(request.getParameter("dtCasamento")!= null)dtCasamento = request.getParameter("dtCasamento");
	String cargo = "";
	if(request.getParameter("cargo")!= null)cargo = request.getParameter("cargo");
	String departamento = "";
	if(request.getParameter("departamento")!= null)departamento = request.getParameter("departamento");
	String empresa = "";
	if(request.getParameter("empresa")!= null)empresa = request.getParameter("empresa");
	String sexo = "M";
	if(request.getParameter("sexo")!= null)sexo = request.getParameter("sexo");
	String cdEstadoCivil = "1";
	if(request.getParameter("cdEstadoCivil")!= null)cdEstadoCivil = request.getParameter("cdEstadoCivil");
	String cdEscolaridade = "7";
	if(request.getParameter("cdEscolaridade")!= null)cdEscolaridade = request.getParameter("cdEscolaridade");
	String cpfConjuge = "";
	if(request.getParameter("cpfConjuge")!= null)cpfConjuge = request.getParameter("cpfConjuge");
	String conjuge = "";
	if(request.getParameter("conjuge")!= null)conjuge = request.getParameter("conjuge");
	String mae = "";
	if(request.getParameter("mae")!= null)mae = request.getParameter("mae");
	String pai = "";
	if(request.getParameter("pai")!= null)pai = request.getParameter("pai");
	String nroRg = "";
	if(request.getParameter("nroRg")!= null)nroRg = request.getParameter("nroRg");
	String orgRg = "";
	if(request.getParameter("orgRg")!= null)orgRg = request.getParameter("orgRg");
	String ufRg = "";
	if(request.getParameter("ufRg")!= null)ufRg = request.getParameter("ufRg");
	String dtRg = "";
	if(request.getParameter("dtRg")!= null)dtRg = request.getParameter("dtRg");
	String hobby = "";
	if(request.getParameter("hobby")!= null)hobby = request.getParameter("hobby");
	String time = "";
	if(request.getParameter("time")!= null)time = request.getParameter("time");
	String  idEntidadeEndereco = "";
	if(request.getParameter("idEntidadeEndereco")!= null)idEntidadeEndereco = request.getParameter("idEntidadeEndereco");
	int cdTipoEndereco = 1;
	if(request.getParameter("cdTipoEndereco")!= null)cdTipoEndereco = Integer.parseInt(request.getParameter("cdTipoEndereco"));
	int cdTipoLogradouro = 0;
	if(request.getParameter("cdTipoLogradouro")!= null)cdTipoLogradouro = Integer.parseInt(request.getParameter("cdTipoLogradouro"));
	int idCidade = 0;
	if(request.getParameter("idCidade")!= null)idCidade = Integer.parseInt(request.getParameter("idCidade"));
	String dsEndereco = "";
	if(request.getParameter("dsEndereco")!= null)dsEndereco = request.getParameter("dsEndereco");
	String nroEndereco = "";
	if(request.getParameter("nroEndereco")!= null)nroEndereco = request.getParameter("nroEndereco");
	String cmpEndereco = "";
	if(request.getParameter("cmpEndereco")!= null)cmpEndereco = request.getParameter("cmpEndereco");
	String baiEndereco = "";
	if(request.getParameter("baiEndereco")!= null)baiEndereco = request.getParameter("baiEndereco");
	String cepEndereco = "";
	if(request.getParameter("cepEndereco")!= null)cepEndereco = request.getParameter("cepEndereco");
	String cxpEndereco = "";
	if(request.getParameter("cxpEndereco")!= null)cxpEndereco = request.getParameter("cxpEndereco");
	String refEndereco = "";
	if(request.getParameter("refEndereco")!= null)refEndereco = request.getParameter("refEndereco");
	String enderecoPadrao ="S";
	if(request.getParameter("enderecoPadrao")!= null)enderecoPadrao = request.getParameter("enderecoPadrao");

	String  idEntidadeTelefone = "";
	if(request.getParameter("idEntidadeTelefone")!= null)idEntidadeTelefone = request.getParameter("idEntidadeTelefone");
	int cdTipoTelefone = 1;
	if(request.getParameter("cdTipoTelefone")!= null)cdTipoTelefone = Integer.parseInt(request.getParameter("cdTipoTelefone"));

	String nroTelefone = "";
	if(request.getParameter("nroTelefone")!= null)nroTelefone = request.getParameter("nroTelefone");
	String ramTelefone = "";
	if(request.getParameter("ramTelefone")!= null)ramTelefone = request.getParameter("ramTelefone");
	String telefonePadrao ="S";
	if(request.getParameter("telefonePadrao")!= null)telefonePadrao = request.getParameter("telefonePadrao");

	String  idEntidadeEmail = "";
	if(request.getParameter("idEntidadeEmail")!= null)idEntidadeEmail = request.getParameter("idEntidadeEmail");
	int cdTipoEmail = 1;
	if(request.getParameter("cdTipoEmail")!= null)cdTipoEmail = Integer.parseInt(request.getParameter("cdTipoEmail"));
	String dsEmail = "";
	if(request.getParameter("dsEmail")!= null)dsEmail = request.getParameter("dsEmail");
	String emailPadrao ="S";
	if(request.getParameter("emailPadrao")!= null)emailPadrao = request.getParameter("emailPadrao");
	
	
  String mensagem = request.getParameter("mensagem");
  

	int contAbas = 1;

	//verifica se acao foi atualizar
	if (acao.equalsIgnoreCase("atu")) {
		EntidadeDAO dao = new EntidadeDAO(conn);
		Entidade entidade = dao.procurarEntidade(Integer.parseInt(cdEntidade));
		nome = entidade.getNome();
		site = entidade.getSite();
		tpInsc = entidade.getTpInsc();
		status = entidade.getStatus();
		observacao = entidade.getObservacao();
		bloqueio = entidade.getBloqueio();
		dtMod = ConverteDate.dateToString(entidade.getDtMod());
		dtCad = ConverteDate.dateToString(entidade.getDtCad());
		usuario = entidade.getUsuario();
		
		EntidadeFisicaDAO dao1 = new EntidadeFisicaDAO(conn);
		EntidadeFisica entidadeFisica = dao1.procurarEntidadeFisica(Integer.parseInt(cdEntidade));
		cpfCnpj = entidadeFisica.getCpf(); 
	  dtNascimento = ConverteDate.dateToStr(entidadeFisica.getDtNascimento(),"dd/MM/yyyy");
	  if (dtNascimento == null) dtNascimento = "";
	  dtCasamento = ConverteDate.dateToStr(entidadeFisica.getDtCasamento(),"dd/MM/yyyy");
	  if (dtCasamento == null) dtCasamento = "";
	  cargo = entidadeFisica.getCargo();
	  departamento = entidadeFisica.getDepartamento();
	  empresa = entidadeFisica.getEmpresa();
	  sexo = entidadeFisica.getSexo();
	  cdEstadoCivil = Integer.toString(entidadeFisica.getCdEstadoCivil());
	  cdEscolaridade = Integer.toString(entidadeFisica.getCdEscolaridade());
	  cpfConjuge = entidadeFisica.getCpfConjuge();
	  conjuge = entidadeFisica.getConjuge();
	  mae = entidadeFisica.getMae();
	  pai = entidadeFisica.getPai();
	  nroRg = entidadeFisica.getNroRg();
	  orgRg = entidadeFisica.getOrgRg();
	  ufRg = entidadeFisica.getUfRg();
	  dtRg = ConverteDate.dateToStr(entidadeFisica.getDtRg(),"dd/MM/yyyy");
	  if (dtRg == null) dtRg = "";
	  hobby = entidadeFisica.getHobby();
	  time = entidadeFisica.getTime();

	  EntidadeEnderecoDAO dao2 = new EntidadeEnderecoDAO(conn);
	  EntidadeEndereco entidadeEndereco = dao2.procurarEntidadeEnderecoPadrao(Integer.parseInt(cdEntidade));
	  idEntidadeEndereco = String.valueOf(entidadeEndereco.getIdEntidadeEndereco());
	  cdTipoEndereco = entidadeEndereco.getCdTipoEndereco();
	  cdTipoLogradouro = entidadeEndereco.getCdTipoLogradouro();
	  idCidade = entidadeEndereco.getIdCidade();
		dsEndereco  = entidadeEndereco.getDsEndereco();
		nroEndereco  = entidadeEndereco.getNroEndereco();
		cmpEndereco  = entidadeEndereco.getCmpEndereco();
		baiEndereco  = entidadeEndereco.getBaiEndereco();
		cepEndereco  = entidadeEndereco.getCepEndereco();
		cxpEndereco  = entidadeEndereco.getCxpEndereco();
		refEndereco  = entidadeEndereco.getRefEndereco();
		enderecoPadrao = entidadeEndereco.getPadrao();

	  EntidadeTelefoneDAO dao3 = new EntidadeTelefoneDAO(conn);
	  EntidadeTelefone entidadeTelefone = dao3.procurarEntidadeTelefonePadrao(Integer.parseInt(cdEntidade));
	  idEntidadeTelefone = String.valueOf(entidadeTelefone.getIdEntidadeTelefone());
	  cdTipoTelefone = entidadeTelefone.getCdTipoTelefone();
		nroTelefone  = entidadeTelefone.getNroTelefone();
		ramTelefone  = entidadeTelefone.getRamTelefone();
		emailPadrao = entidadeTelefone.getPadrao();

	  EntidadeEmailDAO dao4 = new EntidadeEmailDAO(conn);
	  EntidadeEmail entidadeEmail = dao4.procurarEntidadeEmailPadrao(Integer.parseInt(cdEntidade));
	  idEntidadeEmail = String.valueOf(entidadeEmail.getIdEntidadeEmail());
	  cdTipoEmail = entidadeEmail.getCdTipoEmail();
		dsEmail  = entidadeEmail.getDsEmail();
		emailPadrao = entidadeEmail.getPadrao();

	  contAbas = 2;
	}

	TipoEntidadeDAO dao5 = new TipoEntidadeDAO(conn);
	List listTipoEntidade = dao5.listarTipoEntidade("");
	if(buscaCep.equalsIgnoreCase("S")){
		  BuscaCep cep = new BuscaCep();
		  if(cep.getCidade(cepEndereco).equalsIgnoreCase(cepEndereco)){
			  mensagem = " CEP INCORRETO ";
		  }else{
			  dsEndereco  =  cep.getEndereco(cepEndereco);
			  baiEndereco =  cep.getBairro(cepEndereco);
			  String cidadeBusca = cep.getCidade(cepEndereco);
			  CidadeDAO daoCidade = new CidadeDAO(conn);
			  Cidade cidade = daoCidade.procurarCidadeString(cidadeBusca.toUpperCase());
			  if(cidade.getIdCidade() > 0){
			   idCidade = cidade.getIdCidade();
			  }else{
				  idCidade = 0;  
			  }
			  
		  }
		  buscaCep = "N";
			
	  }

%>
<body onload="DefinirAbas(<%=contAbas%>); AlternarAbas(<%=selectAba%>,<%=selectAba%>,<%=contAbas%>); document.forms[0].elements[4].focus(); ">
<h1 class="cabecalho_pagina">Cadastro de Entidade Física (simplificado)</h1>
<hr><% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<form method="post" action="listarEntidadeFisicaSimplificado.jsp?acao=<%=acao%>&cdEntidade=<%=cdEntidade%>">
<input type="hidden" name="acao" value="<%=acao%>" /> 
<input type="hidden" name="cdEntidade" value="<%=cdEntidade%>" /> 
<input type="hidden" name="idEntidadeEndereco" value="<%=idEntidadeEndereco%>" /> 
<input type="hidden" name="idEntidadeTelefone" value="<%=idEntidadeTelefone%>" /> 
<input type="hidden" name="idEntidadeEmail" value="<%=idEntidadeEmail%>" /> 
<iframe width=174 height=189 name="gToday:normal:"../js/calendar/agenda.js"
            id="gToday:normal:"../js/calendar/agenda.js" src="../js/calendar/ipopeng.htm"
            scrolling="no" frameborder="0" style="visibility:visible; z-index:999; 
    position:absolute; top:-500px; left:-500px;">
    </iframe><!-- define abas -->
<table>
	<tr>
		<td>
		<table width="100%" height="27" align="left" cellpadding="0" cellspacing="0">
			<tr>
				<td width="98%" height="50">
				<table width="100%" height="50" class="abas-tb-tabela" cellpadding="0" cellspacing="0" id="busca">
					<tr>
						<!-- exibi a alternativa td_aba1 no browser -->
						<td height="50" width="120" class="abas-menu" id="td_aba1"
							onClick="AlternarAbas('1','1',<%=contAbas%>);"><font size=2>Dados Básicos
						</td>

<%if(acao.equalsIgnoreCase("atu")) { %>
						<!-- exibi a alternativa td_aba2 no browser -->
						<td height="50" width="120" class="abas-menu" id="td_aba2"
							onClick="AlternarAbas('2','2',<%=contAbas%>)"><font size=2>Dependentes
						</td>
<%} %>
						<td width="270" style="border-bottom: 1px solid #000000">
						  &nbsp;
						<td>
					</tr>
					<tr>
						<td width="98%" class="abas-tb-conteudo" colspan="7">
						<!-- exibi o conteúdo div_aba1 no browser -->
						<div id="div_aba1" class="abas-conteudo" style="display: none">
						<% selectAba = "1"; %>
						<table width="98%">
						 	<tr>
								<th class="label">Código da Entidade</th>
<%if(acao.equalsIgnoreCase("atu")) { %>
								<td><input type="text" name="cdEntidade" <%if (cdEntidade != null) { %>
									value="<%=cdEntidade%>" <% }%> size="10" maxlength="10" disabled="disabled"></td>
<%} else { %>
								<td><input type="text" name="cdEntidade" <%if (cdEntidade != null) { %>
									value="<%=cdEntidade%>" <% }%> size="10" maxlength="10" disabled="disabled"></td>
<%} %>
							</tr>
							<tr>
								<th class="label">Nome da Entidade*</th>
								<td><input type="text" name="nome" <%if (nome != null) { %>
									value="<%=nome%>" <% }%> size="60" maxlength="60"></td>
							</tr>
						    <tr>
								<th class="label">CPF</th>
								<td><input type="text" name="cpfCnpj" value="<%=cpfCnpj%>"
									size="20" maxlength="20" onblur="chkCPFCNPJ(this)"></td>
							</tr>
						 	<tr>
								<th class="label">Data de nascimento</th>
                        		<td>
	                        	<input type="text" name="dtNascimento" size="15" value="<%= dtNascimento %>" onblur="chkData(this,'dd/MM/yyyy')" maxlength="10" class="inputs">
		                    	<a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dtNascimento,[[1900,1,1],[2015,12,31]]);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
            		            </td>
							</tr>
							<tr>
								<th class="label">Sexo</th>
								<td class="label_radio">
								  <input type="radio" class="radio" name="sexo" value="M" <%=(sexo.equals("M")? "checked": "") %>>Masculino 
									<input type="radio" class="radio" name="sexo" value="F"	<%=(sexo.equals("F")? "checked": "") %>>Feminino</td>
							</tr>
						  <tr>
					    	<th class="label">RG</th>
								<td><table>
									<tr>						  
								    <td><input type="text" id="nroRg" name="nroRg" <%if (nroRg!= null) { %>value="<%=nroRg%>"<% }%>  size="15" maxlength="15" ></td>
								    <th class="label">Org. RG</th>
								    <td><input type="text" id="orgRg" name="orgRg" <%if (orgRg!= null) { %>value="<%=orgRg%>"<% }%>  size="20" maxlength="20" ></td>
								    <th class="label">UF RG</th>
								    <td><select name="ufRg" style="width: 172px">
								        <option value=''>Selecione...</option>
								        <%@include file="../WEB-INF/jspf/combo/comboUf.jspf" %></select>
								        <script>comboSelect(document.forms[0].ufRg, '<%= ufRg %>');</script>
								    </td>
										<th class="label">Data emissão RG</th>
			            	<td style="width: 164px">
			               	<input type="text" name="dtRg" size="15" value="<%= dtRg %>" onblur="chkData(this,'dd/MM/yyyy')" maxlength="10" class="inputs">
				               	<a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dtRg);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
			            	</td>
			                </tr>
			                </table></td>
			              </tr>
						  <tr>
						    <th class="label">Tipo Endereço</th>
						    <td><select name="cdTipoEndereco" style="width: 172px">
						        <option value='1'>Selecione...</option>
						        <%@include file="../WEB-INF/jspf/combo/comboTipoEndereco.jspf" %></select>
						        <script>comboSelect(document.forms[0].cdTipoEndereco, '<%= cdTipoEndereco %>');</script>
						    </td>
						  </tr>
						  <tr>
						    <th class="label">Tipo Logradouro</th>
						    <td><select name="cdTipoLogradouro" style="width: 172px">
						        <option value='1'>Selecione...</option>
						        <%@include file="../WEB-INF/jspf/combo/comboTipoLogradouro.jspf" %></select>
						        <script>comboSelect(document.forms[0].cdTipoLogradouro, '<%= cdTipoLogradouro %>');</script>
						    </td>
						  </tr>
						  <tr>
						    <th class="label">Endereço*</th>
						    <td><input type="text" id="dsEndereco" name="dsEndereco" <%if (dsEndereco != null) { %>value="<%=dsEndereco%>"<% }%>  size="40" maxlength="40"></td>
						  </tr>
						  <tr>
						    <th class="label">Número</th>
						    <td><input type="text" id="nroEndereco" name="nroEndereco" <%if (nroEndereco != null) { %>value="<%=nroEndereco%>"<% }%>  size="5" maxlength="5"></td>
						  </tr>
						  <tr>
						    <th class="label">Complemento</th>
						    <td><input type="text" id="cmpEndereco" name="cmpEndereco" <%if (cmpEndereco != null) { %>value="<%=cmpEndereco%>"<% }%>  size="20" maxlength="20"></td>
						  </tr>
						  <tr>
						    <th class="label">Bairro</th>
						    <td><input type="text" id="baiEndereco" name="baiEndereco" <%if (baiEndereco != null) { %>value="<%=baiEndereco%>"<% }%>  size="40" maxlength="40"></td>
						  </tr>
						  <tr>
						    <th class="label">CEP</th>
						    <td><input type="text" id="cepEndereco" name="cepEndereco" <%if (cepEndereco != null) { %>value="<%=cepEndereco%>"<% }%>  size="10" maxlength="10">
						    <input class="button" type="button" value="Consultar CEP" onClick="javascript: cep();" /></td>
						  </tr>
						  
						  <tr>
						    <th class="label">Cidade</th>
						    <td><select name="idCidade" style="width: 172px">
						        <option value='1'>Selecione...</option>
						        <%@include file="../WEB-INF/jspf/combo/comboCidade.jspf" %></select>
						        <script>comboSelect(document.forms[0].idCidade, '<%= idCidade %>');</script>
						    </td>
						  </tr>
						  <tr>
						    <th class="label">Caixa Postal</th>
						    <td><input type="text" id="cxpEndereco" name="cxpEndereco" <%if (cxpEndereco != null) { %>value="<%=cxpEndereco%>"<% }%>  size="10" maxlength="10"></td>
						  </tr>
						  <tr>
						    <th class="label">Referência</th>
						    <td><input type="text" id="refEndereco" name="refEndereco" <%if (refEndereco != null) { %>value="<%=refEndereco%>"<% }%>  size="50" maxlength="50"> 
<%if(acao.equalsIgnoreCase("atu")) { %>
							|<a class="button" href="listarEntidadeEnderecoSimplificado.jsp?cdEntidade=<%=cdEntidade%>&acao=listar&selectAba=<%=selectAba%>&acaoAnterior=<%=acao%>">Cadastrar outro</a>|<br>
<%} %>
							</td>
						  </tr>

						  <tr>
						    <th class="label">Tipo Telefone</th>
						    <td><select name="cdTipoTelefone" style="width: 172px">
						        <option value='1'>Selecione...</option>
						        <%@include file="../WEB-INF/jspf/combo/comboTipoTelefone.jspf" %></select>
						        <script>comboSelect(document.forms[0].cdTipoTelefone, '<%= cdTipoTelefone %>');</script>
						    </td>
						  </tr>
						  <tr>
						    <th class="label">Telefone*</th>
						    <td><input type="text" id="nroTelefone" name="nroTelefone" <%if (nroTelefone != null) { %>value="<%=nroTelefone%>"<% }%>  size="15" maxlength="15"></td>
						  </tr>
						  <tr>
						    <th class="label">Ramal</th>
						    <td><input type="text" id="ramTelefone" name="ramTelefone" <%if (ramTelefone != null) { %>value="<%=ramTelefone%>"<% }%>  size="5" maxlength="5"> 
<%if(acao.equalsIgnoreCase("atu")) { %>
								|<a class="button" href="listarEntidadeTelefoneSimplificado.jsp?cdEntidade=<%=cdEntidade%>&acao=listar&selectAba=<%=selectAba%>&acaoAnterior=<%=acao%>">Cadastrar outro</a>|<br>
<%} %>
							</td>
							</tr>

						  <tr>
						    <th class="label">Tipo Email</th>
						    <td><select name="cdTipoEmail" style="width: 172px">
						        <option value='1'>Selecione...</option>
						        <%@include file="../WEB-INF/jspf/combo/comboTipoEmail.jspf" %></select>
						        <script>comboSelect(document.forms[0].cdTipoEmail, '<%= cdTipoEmail %>');</script>
						    </td>
						  </tr>
						  <tr>
						    <th class="label">Email*</th>
						    <td><input type="text" id="dsEmail" name="dsEmail" <%if (dsEmail != null) { %>value="<%=dsEmail%>"<% }%>  size="60" maxlength="100"> 
<%if(acao.equalsIgnoreCase("atu")) { %>
								|<a class="button" href="listarEntidadeEmailSimplificado.jsp?cdEntidade=<%=cdEntidade%>&acao=listar&selectAba=<%=selectAba%>&acaoAnterior=<%=acao%>">Cadastrar outro</a>|<br>

<%} %>							</td>
							</tr>

							<tr>
								<th class="label">Categorias</th>
								<td class="label_radio">
								<%for ( Iterator it = listTipoEntidade.iterator(); it.hasNext(); ) {
										TipoEntidade tipoEntidade = (TipoEntidade) it.next();	
										boolean ckd = false;
										ClassificacaoDAO dao6 = new ClassificacaoDAO(conn);
										if (acao.equalsIgnoreCase("atu") && dao6.possuiClassificacao(Integer.parseInt(cdEntidade), tipoEntidade.getIdTipoEntidade())) ckd = true; %>
									<input type="checkbox" class="checkbox" name="categoria" value="<%=tipoEntidade.getIdTipoEntidade() %>" <%=(ckd? "checked": "") %>> <%=tipoEntidade.getDsTipoEntidade() %>&nbsp;&nbsp;
								<%} %>
								</td>
							</tr>						
							<tr>
								<th class="label">Observação</th>
								<td><input type="text" name="observacao"
									<%if (observacao != null) { %> value="<%=observacao%>" <% }%>
									size="100" maxlength="100"></td>
							</tr>
							<tr>
								<th class="label">Bloqueio de crédito</th>
								<td class="label_radio">
								  <input type="radio" class="radio" name="bloqueio" value="S" <%=(bloqueio.equals("S")? "checked": "") %>>Sim 
									<input type="radio" class="radio" name="bloqueio" value="N" <%=(bloqueio.equals("N")? "checked": "") %>>Não</td>
							</tr>
							<tr>
								<th class="label">Ativo</th>
								<td class="label_radio">
								  <input type="radio" class="radio" name="status" value="A" <%=(status.equals("A")? "checked": "") %>>Sim 
									<input type="radio" class="radio" name="status" value="I"	<%=(status.equals("I")? "checked": "") %>>Não</td>
							</tr>
							<%
								if (acao.equalsIgnoreCase("atu")) {
							%>
							<tr>
								<td>
								</td>
								<td>
								<table>
									<tr>
										<td class="grid_semborda">Registro: <%
											if (dtCad != null) {
										%><%=dtCad%>
										<%
											}
										%></td><td>&nbsp;</td>
										<td class="grid_semborda">Modificação: <%
											if (dtMod != null) {
										%><%=dtMod%>
										<%
											}
										%></td><td>&nbsp;</td>
										<td class="grid_semborda">Usuário: <%
											if (usuario != null) {
										%><%=usuario%>
										<%
											}
										%></td><td>&nbsp;</td>
									</tr>
								</table>
								</td>
							</tr>
							<%
								}
							%>
						</table>
						</div>

						<!-- exibi o conteúdo div_aba2 no browser -->
						<div id="div_aba2" class="abas-conteudo" style="display: none">
						<% selectAba = "2"; %>
						<table>
							<tr>
								<td><br>|<a class="button" href="listarEntidadeDependenteSimplificado.jsp?cdEntidade=<%=cdEntidade%>&acao=listar&selectAba=<%=selectAba%>&acaoAnterior=<%=acao%>">Cadastro Dependente</a>|<br></td>
							</tr>
						</table>
						</div>

						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
	</tr>
</table>
<!-- fim define abas -->

<hr>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><input class="button" type="button" value="Salvar" onClick="javascript: salvar();" /> 
		<input class="button" type="button" value="Cancelar" onClick="javascript: cancelar();" />
		<input class="button" type="button" value="Voltar" onClick="javascript: voltar();" /></td>
		<td class="campo_obrigatorio">* Campos Obrigatórios</td>
	</tr>
</table>
</form>
<%@include file="../fimConexao.jsp"%>

</body>
</html>