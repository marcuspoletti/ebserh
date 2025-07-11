<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="aferopet.model.GrupoMedicamento"%>
<%@page import="aferopet.persistence.GrupoMedicamentoDAO"%>
<%@page import="afero.persistence.SubGrupoDAO"%>
<%@page import="afero.persistence.GrupoDAO"%>
<%@page import="afero.model.SubGrupo"%>
<%@page import="afero.model.Grupo"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/></script>

<script>
function salvar() {
  if (document.all.descricao.value == '') {
    window.alert("O campo descricão é obrigatório.");
    document.all.descricao.focus();
   }if (document.all.idDivisao.value == '0') {
	    window.alert("O campo Divisão é obrigatório.");
	    document.all.idDivisao.focus();
	   
   }else {
  	document.forms[0].submit();
  }
}
function recarregar(acao) {
	  document.forms[0].action='formGrupoMedicamento.jsp?acao='+acao;
	  document.forms[0].submit();
	}
function cancelar() {
  document.forms[0].action="formGrupoMedicamento.jsp";
  document.forms[0].submit();
}

function voltar() {
  document.forms[0].action = 'listarGrupoMedicamento.jsp?acao=voltar'
	document.forms[0].submit();
}  
</script>
</head>
<%
//variáveis capturadas da página listarTipoEntidae.jsp
String acao = request.getParameter("acao");
String idGrupoMedicamento = request.getParameter("idGrupoMedicamento");
int idDivisao = 0;
int idSubGrupo =0;
int idGrupo = 0;
String dsGrupo = "";
String dsSubGrupo = "";
String cdDivisao = request.getParameter("idDivisao");
if(cdDivisao == null)cdDivisao="0";
if (acao == null) acao = "inc";
if (idGrupoMedicamento == null) idGrupoMedicamento = "";
String descricao = "";
String status ="A";
if (acao.equalsIgnoreCase("inc")){
	
	cdDivisao = request.getParameter("idDivisao");
	if(cdDivisao == null)cdDivisao = "0";
	idDivisao = Integer.parseInt(cdDivisao);
	if(idDivisao != 0){
		Divisao divisao = new Divisao();
		DivisaoDAO daoDivisao = new DivisaoDAO(conn);
		divisao = daoDivisao.procurarDivisao(idDivisao);
		SubGrupo subGrupo = new SubGrupo();
	    SubGrupoDAO daoSubGrupo = new SubGrupoDAO(conn); 
	    subGrupo= daoSubGrupo.procurarSubGrupo(divisao.getIdSubGrupo());
	    Grupo grupo = new Grupo();
	    GrupoDAO daoGrupo = new GrupoDAO(conn);
	    grupo = daoGrupo.procurarGrupo(divisao.getIdGrupo());
	    dsGrupo = grupo.getDsGrupo();
	    dsSubGrupo = subGrupo.getDsSubGrupo();
	}else{
		idDivisao=0;
	}
	
}
descricao = dsSubGrupo;
//verifica se acao foi atualizar
if (acao.equalsIgnoreCase("atu")) {
  GrupoMedicamentoDAO dao = new GrupoMedicamentoDAO(conn);
  GrupoMedicamento grupoMedicamento = dao.procurarGrupoMedicamento(Integer.parseInt(idGrupoMedicamento));
	descricao  = grupoMedicamento.getDsGrupoMedicamento();
	status = grupoMedicamento.getStatus();
	cdDivisao = request.getParameter("idDivisao");
	if(cdDivisao == null)cdDivisao = "0";
	idDivisao = Integer.parseInt(cdDivisao);
	if(idDivisao != 0){
		Divisao divisao = new Divisao();
		DivisaoDAO daoDivisao = new DivisaoDAO(conn);
		divisao = daoDivisao.procurarDivisao(idDivisao);
		SubGrupo subGrupo = new SubGrupo();
	    SubGrupoDAO daoSubGrupo = new SubGrupoDAO(conn); 
	    subGrupo= daoSubGrupo.procurarSubGrupo(divisao.getIdSubGrupo());
	    Grupo grupo = new Grupo();
	    GrupoDAO daoGrupo = new GrupoDAO(conn);
	    grupo = daoGrupo.procurarGrupo(divisao.getIdGrupo());
	    dsGrupo = grupo.getDsGrupo();
	    dsSubGrupo = subGrupo.getDsSubGrupo();
	}else{
		idDivisao=0;
	}
}
%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Cadastro de Grupo de Medicamento</h1>
<form method="post" action="listarGrupoMedicamento.jsp?acao=<%=acao%>&idGrupoMedicamento=<%=idGrupoMedicamento%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="idGrupoMedicamento" value="<%=idGrupoMedicamento%>"/>

<table border="0" width="100%">
   <tr>
      		<th class="label">Divisão*</th>
     		<td><select name="idDivisao" onchange="recarregar('<%=acao%>');" required="true">
                  <option value='0'>Selecione...</option>
                  <%@include file="../WEB-INF/jspf/combo/comboDivisao.jspf"%></select>
                   <script>comboSelect(document.forms[0].idDivisao, '<%= idDivisao %>');</script></td>
  </tr>
   <tr>
                   <th class="label">Subgrupo*</th>
                   <td><input disabled type="text" id="dsSubGrupo" name="dsSubGrupo" <%if (dsSubGrupo != null) { %>value="<%=dsSubGrupo%>"<% }%>  size="60" maxlength="60"></td>
  </tr>
                         
  <tr>
                  <th class="label">Grupo*</th>
    		<td><input disabled type="text" id="dsGrupo" name="dsGrupo" <%if (dsGrupo != null) { %>value="<%=dsGrupo%>"<% }%>  size="60" maxlength="60"></td>
 </tr>
  <tr>
    <th class="label">Descrição*</th>
    <td><input type="text" id="descricao" name="descricao" <%if (descricao != null) { %>value="<%=descricao%>"<% }%>  size="30" maxlength="30"></td>
  </tr>
  <tr>
    <th class="label">Ativo</th>
      <td class="label_radio"><input type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Sim
      <input type="radio" class="radio" name="status" value="I" <%= (status.equals("I")? "checked": "") %>>Não</td>    
  </tr>
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