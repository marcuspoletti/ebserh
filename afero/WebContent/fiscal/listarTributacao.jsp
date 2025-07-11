<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.Tributacao" %>
<%@ page import="afero.model.Estado" %>
<%@ page import="afero.persistence.TributacaoDAO" %>
<%@ page import="afero.persistence.EstadoDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="afero.util.Utilitaria"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function confirmaExcluir(cont, id, id1, id2, id3) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarTributacao.jsp?acao=exc&idTributacao='+id+'&idCatTributaria='+id1+'&crt='+id2+'&cdEstado='+id3;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.nomeTributacao.value = '';
  document.forms[0].submit();
}  
</script>

<%
TributacaoDAO dao;
TributacaoDAO daoExclusao;

String clausula = "";
String acao = request.getParameter("acao");
if (acao == null) acao = "listar";
String idCatTributaria = request.getParameter("idCatTributaria");
String idTributacao = request.getParameter("idTributacao");
if (idTributacao == null)idTributacao= "0";
if (acao == null) acao = "inc";
if (idCatTributaria == null)idCatTributaria= "0";
String cdEstado = request.getParameter("cdEstado");
if(cdEstado == null)cdEstado = "0";
String crt = request.getParameter("crt");
if(crt == null)crt="1";
int cdCstIcms = 0;
int cdCsosn = 0;
String origem = "0";
String modBCIcms = "0";
float pReduBCIcms = 0;
float pBCOperacao = 0;
float pMargemIcms = 0;
float aliquotaIcms = 0;
String modBCIcmsST = "0";
float pReduBCIcmsST = 0;
float pMargemIcmsST = 0;
float aliquotaIcmsST = 0;
int cdEstadoIcmsST = 0;
float aliquotaCredito = 0;
String observacao = "";
float percCargaTrib =0;
String dtMod = "";

String cdCatTributaria = "0";
String idEstado = "0";
String scrt = request.getParameter("scrt");


String usuario = (String)session.getAttribute("Login");

String mensagem = request.getParameter("mensagem");
if(mensagem == null)mensagem="";

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
	idCatTributaria = request.getParameter("idCatTributaria");
	idTributacao = request.getParameter("idTributacao");
	crt = request.getParameter("crt");
	cdEstado = request.getParameter("cdEstado");	
	if(request.getParameter("cdCstIcms")!= null){
		   cdCstIcms = Integer.parseInt(request.getParameter("cdCstIcms"));
	}else{
		   cdCstIcms = 0;	
	}
	if(request.getParameter("cdCsosn")!= null){
		cdCsosn = Integer.parseInt(request.getParameter("cdCsosn"));
	}else{
		cdCsosn = 0;	
	}
	origem = request.getParameter("origem");
	modBCIcms = request.getParameter("modBCIcms");
	if(request.getParameter("pReduBCIcms")!= null){
		pReduBCIcms = Utilitaria.toNumber(request.getParameter("pReduBCIcms")).floatValue();
	}else{
		pReduBCIcms = 0;	
	}
	if(request.getParameter("pBCOperacao")!= null){
		pBCOperacao = Utilitaria.toNumber(request.getParameter("pBCOperacao")).floatValue();
	}else{
		pBCOperacao = 0;	
	}
	if(request.getParameter("pMargemIcms")!= null){
		pMargemIcms = Utilitaria.toNumber(request.getParameter("pMargemIcms")).floatValue();
	}else{
		pMargemIcms = 0;	
	}
	if(request.getParameter("aliquotaIcms")!= null){
		aliquotaIcms = Utilitaria.toNumber(request.getParameter("aliquotaIcms")).floatValue();
	}else{
		aliquotaIcms = 0;	
	}
	modBCIcmsST = request.getParameter("modBCIcmsST");
	if(request.getParameter("pReduBCIcmsST")!= null){
		pReduBCIcmsST = Utilitaria.toNumber(request.getParameter("pReduBCIcmsST")).floatValue();
	}else{
		pReduBCIcmsST = 0;	
	}
	if(request.getParameter("pMargemIcmsST")!= null){
		pMargemIcmsST = Utilitaria.toNumber(request.getParameter("pMargemIcmsST")).floatValue();
	}else{
		pMargemIcmsST = 0;	
	}
	if(request.getParameter("aliquotaIcmsST")!= null){
		aliquotaIcmsST = Utilitaria.toNumber(request.getParameter("aliquotaIcmsST")).floatValue();
	}else{
		aliquotaIcmsST = 0;	
	}
	if(request.getParameter("cdEstadoIcmsST")!= null){
		cdEstadoIcmsST = Integer.parseInt(request.getParameter("cdEstadoIcmsST"));
	}else{
		cdEstadoIcmsST = 0;	
	}
	if(request.getParameter("aliquotaCredito")!= null){
		aliquotaCredito = Utilitaria.toNumber(request.getParameter("aliquotaCredito")).floatValue();
	}else{
		aliquotaCredito = 0;	
	}
	if(request.getParameter("observacao")!= null){
		observacao = request.getParameter("observacao");
	}else{
		observacao = "";
	}
	if(request.getParameter("percCargaTrib")!= null){
		percCargaTrib = Utilitaria.toNumber(request.getParameter("percCargaTrib")).floatValue();
	}else{
		percCargaTrib = 0;	
	}
	
	
   Tributacao tributacao = new Tributacao();

	try {
	   if (!acao.equalsIgnoreCase("inc")){
		   tributacao.setIdTributacao(Integer.parseInt(idTributacao));
             }
	   tributacao.setIdCatTributacao(Integer.parseInt(idCatTributaria));
	   tributacao.setCrt(crt);
	   tributacao.setCdEstado(Integer.parseInt(cdEstado));
	   tributacao.setCdCstIcms(cdCstIcms);
	   tributacao.setCdCsosn(cdCsosn);
	   tributacao.setOrigem(origem);
	   tributacao.setModBCIcms(modBCIcms);
	   tributacao.setpReduBCIcms(pReduBCIcms);
	   tributacao.setpBCOperacao(pBCOperacao);
	   tributacao.setpMargemIcms(pMargemIcms);
	   tributacao.setAliquotaIcms(aliquotaIcms);
	   tributacao.setModBCIcmsST(modBCIcmsST);
	   tributacao.setpReduBCIcmsST(pReduBCIcmsST);
	   tributacao.setpMargemIcmsST(pMargemIcmsST);
	   tributacao.setAliquotaIcmsST(aliquotaIcmsST);
	   tributacao.setCdEstadoIcmsST(cdEstadoIcmsST);
	   tributacao.setAliquotaCredito(aliquotaCredito);
	   tributacao.setObservacao(observacao);
	   tributacao.setPercCargaTrib(percCargaTrib);
	   tributacao.setUsuario(usuario);
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}

  dao = new TributacaoDAO(conn);
  daoExclusao = new TributacaoDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {
	  //inclui no banco de dados
  	dao.incluir(tributacao);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
	  dao.atualizar(tributacao);

  } else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  //if(!daoExclusao.exclusaoIdTributacao(Integer.parseInt(idTributacao))) {
		  daoExclusao.excluir(tributacao);
	 // }else{
				//response.sendRedirect("listarTributacao.jsp?mensagem=Exclusão Inválida! Item já possui lançamentos.&acao=listar");
	 //}

   }
} else {
	if (!acao.equalsIgnoreCase("voltar")) {
		if(request.getParameter("cdCatTributaria") != null){
			cdCatTributaria = request.getParameter("cdCatTributaria");
		}else{
			cdCatTributaria = "0";
		}
		if(request.getParameter("idEstado") != null){
			idEstado =  request.getParameter("idEstado");
		}else{
			idEstado = "0";
		}
		
		if(!cdCatTributaria.equals("0")){
			clausula = " WHERE idCatTributaria = "+Integer.parseInt(cdCatTributaria);
			if(!idEstado.equals("0")){
				clausula+=" AND cdEstado ="+Integer.parseInt(idEstado)+" AND crt="+scrt;
			}else{
				clausula+=" AND crt="+scrt;
			}
		}else{
			if(!idEstado.equals("0")){
				clausula+=" WHERE cdEstado ="+Integer.parseInt(idEstado)+" AND crt="+scrt;
			}else{
				clausula+=" WHERE crt="+scrt;
			}
		}
		
	}
}

//seleciona todos os registros do banco de dados
List list;
dao = new TributacaoDAO(conn);
list = dao.listarTributacao(clausula);
int cont = 0;
%>
<h1 class="cabecalho_pagina">Cadastro de Tributário</h1>
|<a class="button" href="formTributacao.jsp?acao=inc">Novo Cadastro</a>|<br>
<body onload="document.forms[0].elements[0].focus();" >
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><%}%>
<form action="listarTributacao.jsp">
<table colspan="2">
  <tr>
      <th class="label">Categoria Trib.*</th>
      <td><select name=cdCatTributaria>
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboCatTributaria.jspf"%></select>
          <script>comboSelect(document.forms[0].idCatTributaria, '<%= idCatTributaria %>');</script>
      </td>
  </tr>  
  <tr>
      <th class="label">Estado*</th>
      <td><select name="idEstado">
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboEstado.jspf"%></select>
          <script>comboSelect(document.forms[0].cdEstado, '<%= cdEstado %>');</script>
      </td>
  </tr>  
  <tr>
    <th class="label">CRT*</th>
      <td class="label_radio"><input type="radio" class="radio" name="scrt" value="1" <%= (crt.equals("1")? "checked": "") %>>Simples Nacional
      <input type="radio" class="radio" name="scrt" value="2" <%= (crt.equals("2")? "checked": "") %>>Regime Normal</td>
       <td><input class="button" type="button" value="Localizar" onClick="javascript: localizar();" /></td>
  </tr>

  
 
</table>
<hr>

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr>
      <th class="grid">&nbsp;</th>
      <th class="grid"><center>Cód. Tributação</center></th>
      <th class="grid"><center>Desc. da Cat. Trib.</center></th>
      <th class="grid"><center>CRT</center></th>
      <th class="grid"><center>Estado</center></th>
      <th class="grid">Excluir</th>
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
String dscCrt = "";
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	
	Tributacao tributacao = (Tributacao) it.next();
	EstadoDAO daoEstadoListar = new EstadoDAO(conn);
	Estado estadoListar = daoEstadoListar.procurarEstado(tributacao.getCdEstado());
	if(tributacao.getCrt().equals("1")){
	         dscCrt = "SIMPLES NACIONAL";	
	}else if(tributacao.getCrt().equals("2")){
		dscCrt = "REGIME NORMAL";
	}
	cont++;

%>
    <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
       <td class = "grid" width="2%"><center><%=tributacao.getIdTributacao()%></center></td>
      <td class = "grid" width="2%"><center><a href="formTributacao.jsp?acao=atu&idTributacao=<%=tributacao.getIdTributacao()%>"><%=tributacao.getIdCatTributacao()%></a></center></td>
      <td class = "grid" width="2%"><center><a href="formTributacao.jsp?acao=atu&idTributacao=<%=tributacao.getIdTributacao()%>"><%=dscCrt%></a></center></td>
      <td class = "grid" width="2%"><center><a href="formTributacao.jsp?acao=atu&idTributacao=<%=tributacao.getIdTributacao()%>"><%=estadoListar.getSiglaEstado()%></a></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=tributacao.getIdTributacao()%>, <%=tributacao.getIdCatTributacao()%>, <%=tributacao.getCrt()%>, <%=tributacao.getCdEstado()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
  	</tr>
<%
}
%>   
</table>
</form>
<p align="right">|<a class="button" href="formTributacao.jsp?acao=inc">Novo Cadastro</a>|
<%@include file="../fimConexao.jsp"%>