<%@page import="afero.util.Utilitaria"%>
<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.Produto"%>
<%@page import="afero.model.Colaborador"%>
<%@page import="afero.model.Preco"%>
<%@page import="afero.model.SubGrupo"%>
<%@page import="afero.model.Grupo"%>
<%@page import="afero.model.Estoque"%>
<%@page import="afero.util.ConverteDate"%>
<%@page import="afero.persistence.ProdutoDAO"%>
<%@page import="afero.persistence.ColaboradorDAO"%>
<%@page import="afero.persistence.PrecoDAO"%>
<%@page import="afero.persistence.EstoqueDAO"%>
<%@page import="afero.persistence.SubGrupoDAO"%>
<%@page import="afero.persistence.GrupoDAO"%>
<%@page import="afero.util.Utilitaria"%>
<%@page import ="java.util.*" %>
<%@include file="../../seguranca.jsp"%>
<%@include file="../../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../../css/afero.css" />
<link type="text/css" rel="Stylesheet" href="../../css/abas.css" />
<script language=JavaScript src="../../js/abas.js" type=text/javascript></script>
<script src="../../js/common.js"/></script>

<script>
function salvar() {
  if (document.all.idDivisao.value == '0') {
    	window.alert("O campo Divisão é obrigatório.");
    	document.all.idDivisao.focus();
   } else if(document.all.dsProduto.value == '') {
   		window.alert("O campo Descrição do Produto é obrigatório.");
   		document.all.dsProduto.focus();
   } else if(document.all.nmProduto.value == '') {
   		window.alert("O campo Nome do Produto é obrigatório.");
   		document.all.nmProduto.focus();
   } else {
  	document.forms[0].submit();
  }
}

function cancelar() {
  document.forms[0].action="formProduto.jsp";
  document.forms[0].submit();
}

function recarregar(acao) {
  document.forms[0].action='formProduto.jsp?acao='+acao;
  document.forms[0].submit();
}


function voltar() {
  document.forms[0].action = 'listarProduto.jsp?acao=voltar'
	document.forms[0].submit();
}  
</script>
</head>
<%

//abas
String selectAba = request.getParameter("selectAba");
if (selectAba == null) selectAba = "1";

int contAbas = 1;

//abas


String ok = request.getParameter("ok");
if(ok == null)ok = "true";
String acao = request.getParameter("acao");
String idProduto = request.getParameter("idProduto");
ConverteDate converte = new ConverteDate();
int idDivisao = 0;
int idSubGrupo =0;
int idGrupo = 0;
String dtCad = "";
String cdBarra = "";
String dtMod = "";
String dsProduto = "";
String nmProduto = "";
String tipoProduto = "PP";
String statusProduto = "A";
String usuarioProduto=(String)session.getAttribute("Login");
String dsGrupo = "";
String dsSubGrupo = "";
String cdDivisao = "";

//Estoque
String idUsuario = (String)session.getAttribute("idUsuario");
ColaboradorDAO daoColaborador = new ColaboradorDAO(conn);
Colaborador colaborador = daoColaborador.procurarColaboradorUsuario(Integer.parseInt(idUsuario));
String idLoja = "".valueOf(colaborador.getIdLoja());

String qtEstoque = "0";
String qtMinima = "0";
String qtMaxima = "0";
String idEstoque = request.getParameter("idEstoque");
if(idEstoque == null) idEstoque="0";
String statusEstoque = request.getParameter("statusEstoque");
if (statusEstoque == null) statusEstoque = "A";
String usuarioEstoque = (String)session.getAttribute("Login");

//Estoque

//Preço
String idPreco = request.getParameter("idPreco");
String idUnidade = request.getParameter("idUnidade");
if(idPreco == null)idPreco="0";
String preco = "0";
String custoDireto = "0";
String custoReal = "0";
String custoMedioGeral = "0";
String usuarioPreco = (String)session.getAttribute("Login");
String precoPadrao = "S";
String idFormacaoPreco = request.getParameter("idFormacaoPreco");
if(idFormacaoPreco == null)idFormacaoPreco="0";
//Preço
if (acao == null) acao = "inc";
if(idProduto == null) idProduto = "0";
if(statusProduto == null)statusProduto = "A";
if(idUnidade == null)idUnidade="2";


//Comandas
String quantFatias = "0";
String impProducao =  "N";

//Comandas
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

//verifica se acao foi atualizar
if (acao.equalsIgnoreCase("atu")){
	
	    cdDivisao = request.getParameter("idDivisao");
	    if(cdDivisao != null){
	    	Divisao divisao = new Divisao();
			DivisaoDAO daoDivisao = new DivisaoDAO(conn);
			if(!cdDivisao.equalsIgnoreCase("0")){
				divisao = daoDivisao.procurarDivisao(Integer.parseInt(cdDivisao));
				idSubGrupo = divisao.getIdSubGrupo();
			         idGrupo = divisao.getIdGrupo();
		    	         SubGrupo subGrupo = new SubGrupo();
		    	         SubGrupoDAO daoSubGrupo = new SubGrupoDAO(conn); 
		    	         subGrupo= daoSubGrupo.procurarSubGrupo(idSubGrupo);
		    	         Grupo grupo = new Grupo();
		    	         GrupoDAO daoGrupo = new GrupoDAO(conn);
		    	         grupo = daoGrupo.procurarGrupo(idGrupo);
		    	         dsGrupo = grupo.getDsGrupo();
		    	         dsSubGrupo = subGrupo.getDsSubGrupo();
				idDivisao = divisao.getIdDivisao();
			}else{
				 idSubGrupo = 0;
			          idGrupo = 0;
				 dsGrupo = "";
		    	          dsSubGrupo = "";
				idDivisao = 0;
			}
			ProdutoDAO dao = new ProdutoDAO(conn);
	    	         Produto produto = dao.procurarProduto(Integer.parseInt(idProduto));
			dtCad = produto.getDtCad().toString();
			dtMod = produto.getDtMod().toString();
			statusProduto = produto.getStatus();
			dsProduto = produto.getDsProduto();
			nmProduto = produto.getNmProduto();
			tipoProduto = produto.getTipoProduto();
			usuarioProduto = produto.getUsuario();
			cdBarra  = produto.getCdBarra();
			//Comandas
			if(dao.getImpProducao(Integer.parseInt(idProduto)) != null){
				impProducao = dao.getImpProducao(Integer.parseInt(idProduto));		
			}
			quantFatias = "".valueOf(dao.getQuantFatias(Integer.parseInt(idProduto)));
	    	
	    }else{
	    	ProdutoDAO dao = new ProdutoDAO(conn);
	    	Produto produto = dao.procurarProduto(Integer.parseInt(idProduto));
		idSubGrupo = produto.getIdSubGrupo();
		idGrupo = produto.getIdGrupo();
	    	SubGrupo subGrupo = new SubGrupo();
	    	SubGrupoDAO daoSubGrupo = new SubGrupoDAO(conn); 
	    	subGrupo= daoSubGrupo.procurarSubGrupo(idSubGrupo);
	    	Grupo grupo = new Grupo();
	    	GrupoDAO daoGrupo = new GrupoDAO(conn);
	    	grupo = daoGrupo.procurarGrupo(idGrupo);
	    	dsGrupo = grupo.getDsGrupo();
	    	dsSubGrupo = subGrupo.getDsSubGrupo();
		idDivisao = produto.getIdDivisao();
		dtCad = produto.getDtCad().toString();
		dtMod = produto.getDtMod().toString();
		statusProduto = produto.getStatus();
		dsProduto = produto.getDsProduto();
		nmProduto = produto.getNmProduto();
		tipoProduto = produto.getTipoProduto();
		usuarioProduto = produto.getUsuario();
		cdBarra  = produto.getCdBarra();
		//Comandas
		if(dao.getImpProducao(Integer.parseInt(idProduto)) != null){
			impProducao = dao.getImpProducao(Integer.parseInt(idProduto));		
		}
		quantFatias = "".valueOf(dao.getQuantFatias(Integer.parseInt(idProduto)));
	    }
	    
	    //Estoque
	    Estoque estoqueList  = null;
	    EstoqueDAO daoEstoqueListar = new EstoqueDAO(conn);
	    estoqueList = daoEstoqueListar.procurarEstoqueLojaProdutoSstatus(Integer.parseInt(idLoja), Integer.parseInt(idProduto));
		if (estoqueList != null) {
			idEstoque = "".valueOf(estoqueList.getIdEstoque());
		         qtEstoque = "".valueOf(estoqueList.getQtEstoque());
			qtMinima = "".valueOf(estoqueList.getQtMinimo());
			qtMaxima = "".valueOf(estoqueList.getQtMaximo());
			statusEstoque = estoqueList.getStatus();
		} else {
			qtEstoque = "0";
			qtMinima = "0";
			qtMaxima = "0";
		}
		//Estoque
		
		//Preço
		  PrecoDAO daoPrecoListar = new PrecoDAO(conn);
		  Preco precoListar = daoPrecoListar.procurarPrecoList(Integer.parseInt(idEstoque), Integer.parseInt(idProduto));
	 	  if (precoListar != null) {
	 		idPreco = "".valueOf(precoListar.getIdPreco());
		    preco = "".valueOf(precoListar.getPreco());
		    custoDireto="".valueOf(precoListar.getCustoDireto());
	             custoReal="".valueOf(precoListar.getCustoReal());
		    custoMedioGeral="".valueOf(precoListar.getCustoMedioGeral());
		    idUnidade = "".valueOf(precoListar.getIdUnidade());
	    }else {
			  preco = "0";
			  custoDireto="0";
			  custoReal="0";
			  custoMedioGeral="0";
			  idUnidade = "2";
		  }
	 	//Preço
	    contAbas = 4;
		
}
%>
<body onload="DefinirAbas(<%=contAbas%>); AlternarAbas(<%=selectAba%>,<%=selectAba%>,<%=selectAba%>,<%=contAbas%>); document.forms[0].elements[2].focus(); " >
<h1 class="cabecalho_pagina">Cadastro de Produto (Comandas)</h1>
<form method="post" action="listarProduto.jsp?acao=<%=acao%>&idProduto=<%=idProduto%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="idPreco" value="<%=idPreco%>"/>
<input type="hidden" name="idEstoque" value="<%=idEstoque%>"/>
<input type="hidden" name="idProduto" value="<%=idProduto%>"/>
<input type="hidden" name="idLoja" value="<%=idLoja%>"/>
<input type="hidden" name="usuarioProduto" value="<%=usuarioProduto%>"/>
<input type="hidden" name="usuarioEstoque" value="<%=usuarioEstoque%>"/>
<input type="hidden" name="usuarioPreco" value="<%=usuarioPreco%>"/>
<input type="hidden" name="precoPadrao" value="<%=precoPadrao%>"/>
<!-- Começando as Abas -->

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

						<!-- exibi a alternativa td_aba2 no browser -->
					
<%if(acao.equalsIgnoreCase("atu")) { %>
	                     <td height="50" width="120" class="abas-menu" id="td_aba2"
							onClick="AlternarAbas('2','2',<%=contAbas%>);"><font size=2>Estoque
						</td>
						<!-- exibi a alternativa td_aba3 no browser -->
						<td height="50" width="120" class="abas-menu" id="td_aba3"
							onClick="AlternarAbas('3','3',<%=contAbas%>)"><font size=2>Preço
						</td>
						<td height="50" width="120" class="abas-menu" id="td_aba4"
							onClick="AlternarAbas('4','4',<%=contAbas%>)"><font size=2>Comandas
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
								<th class="label">Código do Produto</th>
					<%if(acao.equalsIgnoreCase("atu")) { %>
								<td><input type="text" name="idProduto" <%if (idProduto != null) { %>
									value="<%=idProduto%>" <% }%> size="10" maxlength="10" disabled="disabled"></td>
					<%} else { %>
								<td><input type="text" name="idProduto" <%if (idProduto != null) { %>
									value="<%=idProduto%>" <% }%> size="10" maxlength="10" disabled="disabled"></td>
					<%} %>
						  </tr>
						  <tr>
      								<th class="label">Divisão*</th>
     							    <td><select name="idDivisao" onchange="recarregar('<%=acao%>');" required="true">
                                    <option value='0'>Selecione...</option>
                                    <%@include file="../../WEB-INF/jspf/combo/comboDivisao.jspf"%></select>
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
    							<th class="label">Nome Produto*</th>
    							<td><input type="text" id="nmProduto" name="nmProduto" <%if (nmProduto != null) { %>value="<%=nmProduto%>"<% }%>  size="60" maxlength="50"></td>
  						</tr>

  						<tr>
    							<th class="label">Descrição Produto*</th>
    							<td><input type="text" id="dsProduto" name="dsProduto" <%if (dsProduto != null) { %>value="<%=dsProduto%>"<% }%>  size="60" maxlength="100"></td>
  						</tr>
  						<tr>
    							<th class="label">Código de Barras</th>
    							<td><input type="text" id="cdBarra" name="cdBarra" <%if (cdBarra != null) { %>value="<%=cdBarra%>"<% }%>  size="60" maxlength="60"></td>
  					    </tr>
  						<tr>
    							<th class="label">Tipo do Produto</th>
      							<td class="label_radio"><input type="radio" class="radio" name="tipoProduto" value="SP" <%= (tipoProduto.equals("SP")? "checked": "") %>>Serviço Próprio
      							<input type="radio" class="radio" name="tipoProduto" value="ST" <%= (tipoProduto.equals("ST")? "checked": "") %>>Serviço de Terceiros
      							<input type="radio" class="radio" name="tipoProduto" value="PP" <%= (tipoProduto.equals("PP")? "checked": "") %>>Produto Próprio<br>
      							<input type="radio" class="radio" name="tipoProduto" value="PT" <%= (tipoProduto.equals("PT")? "checked": "") %>>Produto de Terceiros
      							<input type="radio" class="radio" name="tipoProduto" value="MP" <%= (tipoProduto.equals("MP")? "checked": "") %>>Matéria Prima   
  						</tr>
  						<tr>
    							<th class="label">Ativo</th>
      							<td class="label_radio"><input type="radio" class="radio" name="statusProduto" value="A" <%= (statusProduto.equals("A")? "checked": "") %>>Sim
      							<input type="radio" class="radio" name="statusProduto" value="I" <%= (statusProduto.equals("I")? "checked": "") %>>Não</td>    
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
											if (usuarioProduto != null) {
										%><%=usuarioProduto%>
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
						<table width="98%">
							<tr>
								<th class="label">Estoque Mínimo</th>
								<td><input type="text" name="qtMinima" <%if (qtMinima != null) { %>
									value="<%=Utilitaria.formatarNumero(Float.parseFloat(qtMinima),2)%>" <% }%> onkeyup="FormataValor(this,event)" size="40" maxlength="40"></td>
							</tr>
							<tr>
								<th class="label">Estoque Máximo</th>
								<td><input type="text" name="qtMaxima" <%if (qtMaxima != null) { %>
									value="<%=Utilitaria.formatarNumero(Float.parseFloat(qtMaxima),2)%>" <% }%> onkeyup="FormataValor(this,event)" size="40" maxlength="40"></td>
							</tr>
							<tr>
								<th class="label">Estoque Atual</th>
								<td><input disabled type="text" name="qtEstoque" <%if (qtEstoque != null) { %>
									value="<%=Utilitaria.formatarNumero(Float.parseFloat(qtEstoque),2)%>" <% }%> onkeyup="FormataValor(this,event)" size="40" maxlength="40"></td>
							</tr>
						</table>
						</div>

						<!-- exibi o conteúdo div_aba3 no browser -->
						<div id="div_aba3" class="abas-conteudo" style="display: none">
						<% selectAba = "3"; %>
						<table>
						        <tr>
								<th class="label">Preço de Venda</th>
								<td><input type="text" name="preco" <%if (preco != null) { %>
									value="<%=Utilitaria.formatarNumero(Float.parseFloat(preco),2)%>" <% }%> onkeyup="FormataValor(this,event)" size="40" maxlength="40"></td>
							</tr>
							 <tr>
								<th class="label">Preço de Custo Real</th>
								<td><input type="text" name="custoReal" <%if (custoReal != null) { %>
									value="<%=Utilitaria.formatarNumero(Float.parseFloat(custoReal),2)%>" <% }%> onkeyup="FormataValor(this,event)" size="40" maxlength="40"></td>
							</tr>
							 <tr>
								<th class="label">Preço de Custo Direto</th>
								<td><input type="text" name="custoDireto" <%if (custoDireto != null) { %>
									value="<%=Utilitaria.formatarNumero(Float.parseFloat(custoDireto),2)%>" <% }%> onkeyup="FormataValor(this,event)" size="40" maxlength="40"></td>
							</tr>
							 <tr>
								<th class="label">Custo Médio</th>
								<td><input type="text" name="custoMedioGeral" <%if (custoMedioGeral != null) { %>
									value="<%=Utilitaria.formatarNumero(Float.parseFloat(custoMedioGeral),2)%>" <% }%> onkeyup="FormataValor(this,event)" size="40" maxlength="40"></td>
							</tr>
							<tr>
						    <th class="label">Tab. Form. Preço</th>
						    <td><select name="idFormacaoPreco" style="width: 172px">
						        <option value='0'>Selecione...</option>
						        <%@include file="../../WEB-INF/jspf/combo/comboFormacaoPreco.jspf" %></select>
						        <script>comboSelect(document.forms[0].idFormacaoPreco, '<%= idFormacaoPreco%>');</script>
						    </td>
						  </tr>
						  <tr>
						    <th class="label">Unidade*</th>
						    <td><select name="idUnidade" style="width: 172px">
						        <option value='1'>Selecione...</option>
						        <%@include file="../../WEB-INF/jspf/combo/comboUnidadeDe.jspf" %></select>
						        <script>comboSelect(document.forms[0].idUnidade, '<%= idUnidade%>');</script>
						    </td>
						  </tr>
						</table>
						</div>
						<div id="div_aba4" class="abas-conteudo" style="display: none">
						<% selectAba = "4"; %>
						<table>
						        <tr>
								<th class="label">Quant. Fatias</th>
								<td><input type="text" name="quantFatias" <%if (quantFatias != null) { %>
									value="<%=Utilitaria.formatarNumero(Integer.parseInt(quantFatias),0)%>" <% }%> onkeyup="FormataValor(this,event,0)" size="40" maxlength="40"></td>
							</tr>
							 <tr>
								<th class="label">Imp. Produção</th>
      							         <td class="label_radio"><input type="radio" class="radio" name="impProducao" value="S" <%= (impProducao.equals("S")? "checked": "") %>>Sim
      							         <input type="radio" class="radio" name="impProducao" value="N" <%=(impProducao.equals("N")? "checked": "") %>>Não</td>
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
<!-- Teminando as Abas -->
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
	<td><input class="button" type="button" value="Salvar" onClick="javascript: salvar();" />
	<input class="button" type="button" value="Cancelar" onClick="javascript: cancelar();" />
	<input class="button" type="button" value="Voltar" onClick="javascript: voltar();" /></td>
	<td class="campo_obrigatorio">* Campos Obrigatórios</td>
</tr>
</table>
</form>
<%@include file="../../fimConexao.jsp"%>
</body>
</html>