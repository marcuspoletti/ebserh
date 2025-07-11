<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.Divisao"%>
<%@page import="afero.model.Grupo"%>
<%@page import="afero.model.SubGrupo"%>
<%@page import="afero.util.ConverteDate"%>
<%@page import="afero.persistence.DivisaoDAO"%>
<%@page import="afero.persistence.GrupoDAO"%>
<%@page import="afero.persistence.SubGrupoDAO"%>
<%@page import ="java.util.*" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/></script>

<script>
function salvar() {
  if (document.all.dsDivisao.value == '') {
    window.alert("O campo Descrição da Divisão é obrigatório.");
    document.all.dsDivisao.focus();
   }if (document.all.idSubGrupo.value == 0) {
    window.alert("O campo SubGrupo é obrigatório.");
    document.all.idSubGrupo.focus();
   }else {
  	document.forms[0].submit();
  }
}

function cancelar() {
  document.forms[0].action="formDivisao.jsp";
  document.forms[0].submit();
}

function recarregar(acao) {
  document.forms[0].action='formDivisao.jsp?acao='+acao;
  document.forms[0].submit();
}


function voltar() {
  document.forms[0].action = 'listarDivisao.jsp?acao=voltar'
	document.forms[0].submit();
}  
</script>
</head>
<%
String ok = request.getParameter("ok");
if(ok == null)ok = "true";
String acao = request.getParameter("acao");
String idDivisao = request.getParameter("idDivisao");
String dsDivisao = request.getParameter("dsDivisao");
String status = request.getParameter("status");
String usuario = (String)session.getAttribute("Login");
ConverteDate converte = new ConverteDate();
int idGrupo = 0;
int idSubGrupo = 0;
String dtCad = "";
String dtMod = "";
String dsGrupo = "";
if (acao == null) acao = "inc";
if(idDivisao == null) idDivisao = "";
if(dsDivisao == null)dsDivisao = "";
if(status == null)status = "A";
String cdSubGrupo = request.getParameter("idSubGrupo");
if(acao.equalsIgnoreCase("inc")&& ok.equals("true")){
	if(cdSubGrupo != null){
		if(cdSubGrupo != "0"){
			idSubGrupo = Integer.parseInt(cdSubGrupo);
			SubGrupoDAO daoSubGrupo = new SubGrupoDAO(conn);
			if(idSubGrupo !=0){
				SubGrupo subGrupo = daoSubGrupo.procurarSubGrupo(idSubGrupo);
				idGrupo = subGrupo.getIdGrupo();
				GrupoDAO daoGrupoAux = new GrupoDAO(conn);
				Grupo grupoAux = daoGrupoAux.procurarGrupo(idGrupo);
				dsGrupo = grupoAux.getDsGrupo();
			}
		}
	}else{
	 cdSubGrupo = "";
    }
}
if(ok.equals("false")){
	idSubGrupo = Integer.parseInt(cdSubGrupo);
	if(idSubGrupo != 0){
		SubGrupoDAO daoSubGrupo = new SubGrupoDAO(conn);
		SubGrupo subGrupo = daoSubGrupo.procurarSubGrupo(idSubGrupo);
		idGrupo = subGrupo.getIdGrupo();
		GrupoDAO daoGrupoAux = new GrupoDAO(conn);
		Grupo grupoAux = daoGrupoAux.procurarGrupo(idGrupo);
		dsGrupo = grupoAux.getDsGrupo();
		DivisaoDAO dao = new DivisaoDAO(conn);
		Divisao divisao = dao.procurarDivisao(Integer.parseInt(idDivisao));
		dtMod = divisao.getDtMod().toString();
		dtCad = divisao.getDtCad().toString();
		status = divisao.getStatus();
		dsDivisao =divisao.getDsDivisao();
	}
	
}





//verifica se acao foi atualizar


	if (acao.equalsIgnoreCase("atu") && ok.equals("true")){
	    DivisaoDAO dao = new DivisaoDAO(conn);
	    GrupoDAO daoGrupo = new GrupoDAO(conn);
	    Divisao divisao = dao.procurarDivisao(Integer.parseInt(idDivisao));
	    Grupo grupo;
		idSubGrupo = divisao.getIdSubGrupo();
		dtMod = divisao.getDtMod().toString();
		dtCad = divisao.getDtCad().toString();
		status = divisao.getStatus();
		dsDivisao =divisao.getDsDivisao();
		idGrupo = divisao.getIdGrupo();
		grupo = daoGrupo.procurarGrupo(idGrupo);
		dsGrupo = grupo.getDsGrupo();
		ok = "false";
	}

%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Divisão</h1>
<form method="post" action="listarDivisao.jsp?acao=<%=acao%>&idDivisao=<%=idDivisao%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="idDivisao" value="<%=idDivisao%>"/>
<input type="hidden" name="idGrupo" value="<%=idGrupo%>"/>
<input type="hidden" name="ok" value="<%=ok%>"/>
<input type="hidden" name="usuario" value="<%=usuario%>"/>


<table border="0" width="100%">

  <tr>
      <th class="label">Subgrupo*</th>
      <td><select name="idSubGrupo"  onchange="recarregar('<%=acao%>');" required="true">
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboSubGrupo.jspf"%></select>
          <script>comboSelect(document.forms[0].idSubGrupo, '<%= idSubGrupo %>');</script>
      </td>

  </tr>
   <tr>
    <th class="label">Grupo*</th>
    <td><input type="text" id="dsGrupo" name="dsGrupo" disabled="disabled"<%if (dsGrupo != null) { %>value="<%=dsGrupo%>"<% }%>  size="60" maxlength="60"></td>
  </tr>

  <tr>
    <th class="label">Descrição*</th>
    <td><input type="text" id="dsDivisao" name="dsDivisao" <%if (dsDivisao != null) { %>value="<%=dsDivisao%>"<% }%>  size="60" maxlength="60"></td>
  </tr>
  <tr>
    <th class="label">Ativo</th>
      <td class="label_radio"><input type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Sim
      <input type="radio" class="radio" name="status" value="I" <%= (status.equals("I")? "checked": "") %>>Não</td>    
  </tr>
  <%if(acao.equals("atu") && ok.equals("true")){%>
  
  	<tr>
   	 	<td class="label_menor"><center>&nbsp Registro: <%if (dtCad != null) { %><%=converte.DMYToYMD(dtCad)%><% }%>&nbsp</center></td>
  	    <td class="label_menor"><center>&nbsp Modificação: <%if (dtMod != null) { %><%=converte.DMYToYMD(dtMod)%><% }%>&nbsp</center></td>
	</tr>

  <% }%>
</table><hr>
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