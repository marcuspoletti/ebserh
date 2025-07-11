<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.Produto" %>
<%@ page import="afero.model.Preco" %>
<%@ page import="afero.model.Divisao" %>
<%@ page import="afero.model.Estoque" %>
<%@ page import="afero.model.Loja" %>
<%@ page import="afero.model.Produto" %>
<%@ page import="afero.persistence.ProdutoDAO" %>
<%@ page import="afero.persistence.PrecoDAO" %>
<%@ page import="afero.persistence.DivisaoDAO"%>
<%@ page import="afero.persistence.EstoqueDAO"%>
<%@ page import="afero.persistence.ProdutoDAO"%>
<%@ page import="afero.persistence.LojaDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.Date"%>
<%@ page import="afero.util.ConverteDate" %>
<%@ page import="afero.util.Utilitaria" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<link rel="stylesheet" href="../css/screen.css" type="text/css" media="screen" title="default" />



<script>
function confirmaExcluir(cont, id, id1, id2) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarProduto.jsp?acao=exc&idProduto=' + id+'&idEstoque='+id1+'&idPreco='+id2;   
  }  
}

function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.nomeProduto.value = '';
  document.all.tipoProduto.value = ''; //não está limpando
  document.forms[0].submit();
}  
</script>

<%
int cdProduto = 0;
int cdEstoque = 0;
ProdutoDAO dao;
ProdutoDAO daoExclusao;
DivisaoDAO dao1;
PrecoDAO daoPreco;
EstoqueDAO daoEstoque;
EstoqueDAO daoEstoqueExclusao;
ConverteDate conDate = new ConverteDate();
String mensagem = request.getParameter("mensagem");
if(mensagem == null) mensagem = "";
String acao = request.getParameter("acao");
if (acao == null) acao = "listar";

String dsProduto = "";
String nmProduto = "";
String tipoProduto = "";
String status ="";
String dtCad = "";
String dtMod = "";
String nomeProduto = "";
String clausula = "";
String idProduto = "";
String idDivisao = "";
String usuarioProduto = "";
String cdBarra = "";
int idSubGrupo = 0;
int idGrupo = 0;

//Dados Estoque
String idLoja = (String)session.getAttribute("idLoja");
String qtEstoque = "";
String qtMinimo = "";
String qtMaximo = "";
String usuarioEstoque = "";
String idEstoque = "";
//Dados Estoque
//Dados Preço
  String idPreco = "";
  String idUnidade = "";
  String precoUnitario ="";
  String custoReal = "";
  String custoDireto = "";
  String custoMedioGeral = "";
  String usuarioPreco = "";
  String precoPadrao = "";
//Dados Preço
//Fiscal
String cdCatTributaria = "0";
String cdNcm = "0";
String cdCfopSaidaDentro = "0";
String cdCfopSaidaFora = "0";
String cdBarraTrib = "";
String cdExTipi = "";
String cdGenero = "";
String cdCest = "0";
//Fiscal
if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
	DivisaoDAO daoDivisao = new DivisaoDAO(conn);
	Divisao divisao = new Divisao();
	idProduto = request.getParameter("idProduto");
	
	if(!acao.equalsIgnoreCase("exc")){
		idDivisao = request.getParameter("idDivisao");
		divisao = daoDivisao.procurarDivisao(Integer.parseInt(idDivisao));
		idSubGrupo = divisao.getIdSubGrupo();
		idGrupo = divisao.getIdGrupo();
	}
	
  tipoProduto = request.getParameter("tipoProduto");
  status =request.getParameter("statusProduto");//mexe
  nmProduto = request.getParameter("nmProduto");
  dsProduto = request.getParameter("dsProduto");
  nomeProduto = request.getParameter("nomeProduto");
  usuarioProduto = request.getParameter("usuarioProduto");
  cdBarra = request.getParameter("cdBarra");
  if (idDivisao == null) idDivisao = "0";
  if (dsProduto == null) dsProduto = "";
  if (status == null) status = "A";
  if (nomeProduto == null) nomeProduto ="";
  if (tipoProduto == null) tipoProduto ="PP";
  if (idProduto == null) idProduto = "0";
  if (cdBarra == null) cdBarra = "";
  
  //Estoque
  idEstoque = request.getParameter("idEstoque");
  qtMinimo = request.getParameter("qtMinima");
  qtMaximo =  request.getParameter("qtMaxima");
  usuarioEstoque = request.getParameter("usuarioEstoque");
  if (idEstoque == null) idEstoque="0";
  if (qtMinimo == null) qtMinimo = "0";
  if (qtMaximo == null) qtMaximo = "0";
  //Estoque
  
  //Preço
  idPreco = request.getParameter("idPreco");
  idUnidade = request.getParameter("idUnidade");
  precoUnitario = request.getParameter("preco");
  custoReal = request.getParameter("custoReal");
  custoDireto = request.getParameter("custoDireto");
  custoMedioGeral = request.getParameter("custoMedioGeral");
  usuarioPreco = request.getParameter("usuarioPreco");
  precoPadrao = request.getParameter("precoPadrao");
  if (idPreco == null) idPreco="0";
  if (idUnidade == null) idUnidade="2";
  if (precoUnitario == null) precoUnitario="0";
  if (custoReal == null)custoReal = "0";
  if (custoDireto == null)custoDireto = "0";
  if (custoMedioGeral == null)custoMedioGeral = "0";
  if (precoPadrao == null)precoPadrao="S";
  //Preço
  //Fiscal
  cdCatTributaria = request.getParameter("cdCatTributaria");
  if(cdCatTributaria == null)cdCatTributaria="0";
  String codigo = request.getParameter("cdNcm"); 
  cdCest = request.getParameter("cdCest");
  if(!acao.equalsIgnoreCase("exc")){
  	if((codigo.length() > 1)){
  	      cdNcm = codigo.substring(0, (codigo.indexOf("-")));
  	}
  }
  if(!acao.equalsIgnoreCase("exc")){
	  	if((cdCest.length() > 1)){
	  		cdCest = cdCest.substring(0, (cdCest.indexOf("-")));
	  	}
  }
  cdCfopSaidaDentro = request.getParameter("cdCfopSaidaDentro");
  if(cdCfopSaidaDentro == null)cdCfopSaidaDentro="0";
  cdCfopSaidaFora = request.getParameter("cdCfopSaidaFora");
  if(cdCfopSaidaFora == null)cdCfopSaidaFora="0";
  cdBarraTrib = request.getParameter("cdBarraTrib");
  if(cdBarraTrib == null)cdBarraTrib="";
  cdExTipi = request.getParameter("cdExTipi");
  if(cdExTipi == null)cdExTipi="";
  cdGenero = request.getParameter("cdGenero");
  if(cdGenero == null)cdGenero="";
  //Fiscal
  Produto produto = new Produto();
  Estoque estoque = new Estoque();
  Preco preco = new Preco();
	try {
	  if (!acao.equalsIgnoreCase("inc")){
		  produto.setIdProduto(Integer.parseInt(idProduto));
		  estoque.setIdEstoque(Integer.parseInt(idEstoque));
		  preco.setIdPreco(Integer.parseInt(idPreco));
	  }
	  //Dados Produto
	  produto.setTipoProduto(tipoProduto);
	  produto.setNmProduto(nmProduto);
	  produto.setDsProduto(dsProduto);
	  if (!acao.equalsIgnoreCase("exc")){
		  produto.setIdDivisao(Integer.parseInt(idDivisao));
		  produto.setIdSubGrupo(idSubGrupo);
		  produto.setIdGrupo(idGrupo);  
	  }
           produto.setStatus(status);
           produto.setUsuario(usuarioProduto);
           produto.setCdBarra(cdBarra);
           //Fiscal
             if(!cdCatTributaria.equals("0")){
            	 produto.setIdCatTributaria(Integer.parseInt(cdCatTributaria));
             }
             if(!cdNcm.equals("0")){
            	 produto.setCdNcm(cdNcm);
             }
             if(!cdCest.equals("0")){
            	 produto.setCdCest(cdCest);
             }
             if(!cdCfopSaidaDentro.equals("0")){
            	 produto.setCdCfopSaidaDentro(Integer.parseInt(cdCfopSaidaDentro));
             }
             if(!cdCfopSaidaFora.equals("0")){
            	 produto.setCdCfopSaidaFora(Integer.parseInt(cdCfopSaidaFora));
             }
             produto.setCdBarraTrib(cdBarraTrib);
             produto.setCdExTipi(cdExTipi);
             produto.setCdGenero(cdGenero);
           //Fiscal
    //Dados Estoque
	  estoque.setIdLoja(Integer.parseInt(idLoja));
	  estoque.setUsuario(usuarioEstoque);
	  estoque.setIdProduto(Integer.parseInt(idProduto));
	  estoque.setQtEstoque(0);
	  estoque.setQtMinimo(Utilitaria.toNumber(qtMinimo).doubleValue());
	  estoque.setQtMaximo(Utilitaria.toNumber(qtMaximo).doubleValue());
	  estoque.setStatus(status);
	  //DadosEstoque
	  
	  //Dados Preco
	  preco.setIdEstoque(Integer.parseInt(idEstoque));
	  preco.setIdUnidade(Integer.parseInt(idUnidade));
	  preco.setPreco(Utilitaria.toNumber(precoUnitario).floatValue());
	  preco.setCustoDireto(Utilitaria.toNumber(custoDireto).floatValue());
	  preco.setCustoReal(Utilitaria.toNumber(custoReal).floatValue());
	  preco.setCustoMedioGeral(Utilitaria.toNumber(custoMedioGeral).floatValue());
	  preco.setUsuario(usuarioPreco);
	  preco.setPrecoPadrao(precoPadrao);
    //Dados Preco
    
	}catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}


  dao = new ProdutoDAO(conn);
  daoExclusao = new ProdutoDAO(conn);
  daoPreco = new PrecoDAO(conn);
  daoEstoque = new EstoqueDAO(conn);
  daoEstoqueExclusao = new EstoqueDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {
	  //inclui no banco de dados
  	         cdProduto = dao.incluirProd(produto);
		estoque.setIdProduto(cdProduto);
		cdEstoque = daoEstoque.incluirProduto(estoque);
		preco.setIdEstoque(cdEstoque);
		daoPreco.incluir(preco);
		//Incluir Fiscal
		if(!cdCatTributaria.equals("0")){
			dao.atualizarDadosFiscalIdCatTributaria(produto);
		}
		if(!cdNcm.equals("0")){
			dao.atualizarDadosFiscalCdNcm(produto);	
		}
		if(!cdCfopSaidaDentro.equals("0")){
       		dao.atualizarDadosFiscalCdCfopSaidaDentro(produto);
        }
        if(!cdCfopSaidaFora.equals("0")){
            dao.atualizarDadosFiscalCdCfopSaidaFora(produto);
        }
        dao.atualizarDadosFiscalCdBarraTrib(produto);
        dao.atualizarDadosFiscalCdGenero(produto);
        dao.atualizarDadosFiscalCdExTipi(produto);
        

  }else if (acao.equalsIgnoreCase("atu")){
	  //atualiza no banco de dados
	  dao.atualizar(produto);
	  cdEstoque = estoque.getIdEstoque();
	  if (estoque.getIdEstoque() == 0) {
			estoque.setIdProduto(produto.getIdProduto());
			cdEstoque = daoEstoque.incluirProduto(estoque);	
			  
	  }else {
		  daoEstoque.atualizarQuantMaxMin(estoque);
	  }
	 if (preco.getIdPreco() == 0) {
			preco.setIdEstoque(cdEstoque);
			daoPreco.incluir(preco);
	  } else {
	  	daoPreco.atualizar(preco);
	  }
           //Atualizar Dados Fiscal
	 if(!cdCatTributaria.equals("0")){
		 dao.atualizarDadosFiscalIdCatTributaria(produto);
	 }
	 if(!cdNcm.equals("0")){
		 dao.atualizarDadosFiscalCdNcm(produto);
	 }
	 if(!cdCest.equals("0")){
		 dao.atualizarDadosFiscalCdCest(produto);
	 }
	 if(!cdCfopSaidaDentro.equals("0")){
			 dao.atualizarDadosFiscalCdCfopSaidaDentro(produto);
	}
	if(!cdCfopSaidaFora.equals("0")){
			dao.atualizarDadosFiscalCdCfopSaidaFora(produto);
	}
	dao.atualizarDadosFiscalCdBarraTrib(produto);
    dao.atualizarDadosFiscalCdGenero(produto);
    dao.atualizarDadosFiscalCdExTipi(produto);
  } else if (acao.equalsIgnoreCase("exc")) {
	  //exclui no banco de dados
	  if(!daoExclusao.exclusaoIdProdutoComprarItem(Integer.parseInt(idProduto)) && !daoExclusao.exclusaoIdProdutoPedidoItem(Integer.parseInt(idEstoque)) &&
			  !daoExclusao.exclusaoIdProdutoOrcamentoItem(Integer.parseInt(idProduto)) && !daoExclusao.exclusaoIdProdutoOrcamentoSubItem(Integer.parseInt(idProduto))
			  && !daoExclusao.exclusaoIdProdutoPedidoSubItem(Integer.parseInt(idProduto))){
		  		  
		  	//Preco
	      Preco preExcluir = new Preco();
	      PrecoDAO daoPrecoExcluir = new PrecoDAO(conn);
	      preExcluir.setIdPreco(Integer.parseInt(idPreco));
	      daoPrecoExcluir.excluir(preExcluir);

	      //Estoque
	      Estoque estExcluir = new Estoque();
	      EstoqueDAO daoExcluir = new EstoqueDAO(conn);
	      estExcluir.setIdEstoque(Integer.parseInt(idEstoque));
	      daoExcluir.excluir(estExcluir);
		
		  	//Preco
	      dao.excluir(produto);
	      daoExcluir.excluir(estExcluir);
	      
	  }else{
		  response.sendRedirect("listarProduto.jsp?mensagem=Exclusão Inválida! Item já possui lançamentos.&acao=listar");
	  }
	  
  }
} else {
 if (!acao.equalsIgnoreCase("voltar")) {
    nomeProduto = request.getParameter("nomeProduto");
    tipoProduto = request.getParameter("tipoProduto");
    if(nomeProduto == null) nomeProduto = "";
    if(tipoProduto == null) tipoProduto = "";
    
  }

  if (nomeProduto!= null) {
    clausula = " WHERE dsProduto LIKE '"+nomeProduto+"%'";
  } 
  if (!tipoProduto.isEmpty()) {
    if (clausula.isEmpty()) {
      clausula = " WHERE tipoProduto='"+tipoProduto+"'";
    } else {
      clausula = clausula+" AND tipoProduto='"+tipoProduto+"'";
    }
  }
  
}
if (acao.equalsIgnoreCase("inc") && mensagem.isEmpty()) {
	response.sendRedirect("formProduto.jsp?acao=atu&idProduto=" + cdProduto);
}
//seleciona todos os registros do banco de dados
List list;
dao = new ProdutoDAO(conn);
clausula = clausula+" ORDER BY dsProduto ";
list = dao.listarProduto(clausula);

%>
<h1 class="cabecalho_pagina">Cadastro de Produto</h1>
|<a class="button" href="formProduto.jsp?acao=inc">Novo Cadastro</a>|<br>
<body onload="document.forms[0].elements[0].focus();" >

<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<form action="listarProduto.jsp">
<table colspan="2">
  <tr>
    <th class='label'>Descrição do Produto</th>
    <td><input type="text" name="nomeProduto" <%if (nomeProduto != null) { %>value="<%=nomeProduto%>"<% }%> size="40" maxlength="50"></td>
    <td><input class="button" type="button" value="Localizar" onClick="javascript: localizar();" /></td>
    <td><input class="button" type="button" value="Nova pesquisa" onClick="javascript: novaPesquisa();" /></td>
  </tr>
  <tr>
    <th class="label">Tipo do Produto</th>
    <td class="label_radio">
      <input type="radio" class="radio" name="tipoProduto" value="" <%= (tipoProduto.equals("")? "checked": "") %>>Todos
      <input type="radio" class="radio" name="tipoProduto" value="SP" <%= (tipoProduto.equals("SP")? "checked": "") %>>Serviço Próprio
      <input type="radio" class="radio" name="tipoProduto" value="ST" <%= (tipoProduto.equals("ST")? "checked": "") %>>Serviço de Terceiros<br>
      <input type="radio" class="radio" name="tipoProduto" value="PP" <%= (tipoProduto.equals("PP")? "checked": "") %>>Produto Próprio
      <input type="radio" class="radio" name="tipoProduto" value="PT" <%= (tipoProduto.equals("PT")? "checked": "") %>>Produto de Terceiros
      <input type="radio" class="radio" name="tipoProduto" value="MP" <%= (tipoProduto.equals("MP")? "checked": "") %>>Matéria Prima </td>
  </tr>
  
</table>
<hr>

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr>
      <th class="grid">&nbsp;</th>
      <th class="grid"><center>Descrição do Produto</center></th>
      <th class="grid">Divisão</th>
      <th class="grid">Tipo do Produto</th>
      <th class="grid">Status</th>
      <th class="grid">Excluir</th>
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
	Produto prod = (Produto) it.next();
         dao1 = new DivisaoDAO(conn);
	Divisao divisao = dao1.procurarDivisao(prod.getIdDivisao());
	daoEstoque = new EstoqueDAO(conn);
	int idEstoqueList = daoEstoque.getIdEstoque(Integer.parseInt(idLoja), prod.getIdProduto());
	Preco precoList = null;
	daoPreco = new PrecoDAO(conn);
	precoList = daoPreco.procurarPrecoEstoque(idEstoqueList);
	int idPrecoList = 0;
	if (precoList != null) {
		idPrecoList = precoList.getIdPreco();
	}
	
	cont++;

%>
    <tr>
      <td class = "grid" width="2%"><center><%=rowNum+cont%></center></td>
      <td class = "grid"><center><a href="formProduto.jsp?acao=atu&idProduto=<%=prod.getIdProduto()%>&idEstoque=<%=idEstoqueList%>&idPreco=<%=idPrecoList%>"><%=prod.getDsProduto() %></a></center></td>
      <td class = "grid" width="25%"><center><%=divisao.getDsDivisao()%></center></td>
      <td class = "grid" width="5%"><center><%=prod.getTipoProduto()%></center></td>
      <td class = "grid" width="5%"><center><%=prod.getStatus()%></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=rowNum+cont%>,<%=prod.getIdProduto()%>,<%=idEstoqueList%>,<%=idPrecoList%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
  	</tr>
<%
}
%>   
</table>
</form>
</br>
<div>
  <div style="width:50%; text-align: left; float:left;">
|<a class="button" href="../exportacao/formGerarArquivoProduto.jsp?acao=exp">Exportar</a>|  </div>
  <div style="width:50%; text-align: right; float:left;">
|<a class="button" href="formProduto.jsp?acao=inc">Novo Cadastro</a>|
  </div>
</div>
<%  if (rowNum != 0 || hasNext) { %>
        <center>
<%      if (rowNum != 0) { %>
<a class="link" href="listarProduto.jsp?rowNum=<%=0%>&nomeProduto=<%=nomeProduto%>&tipoProduto=<%=tipoProduto%>">Primeira</a>&nbsp&nbsp
|&nbsp&nbsp<a class="link" href="listarProduto.jsp?rowNum=<%=rowNum-gridSize%>&nomeProduto=<%=nomeProduto%>&tipoProduto=<%=tipoProduto%>">< Anterior</a>&nbsp&nbsp
<%      } else { %>
Primeira&nbsp&nbsp|&nbsp&nbsp< Anterior&nbsp
<%      } %>
<%      if (hasNext) { %>
|&nbsp&nbsp<a class="link" href="listarProduto.jsp?rowNum=<%=rowNum+gridSize%>&nomeProduto=<%=nomeProduto%>&tipoProduto=<%=tipoProduto%>">Próxima ></a>&nbsp&nbsp
|&nbsp&nbsp<a class="link" href="listarProduto.jsp?rowNum=<%=rowCount-gridSize%>&nomeProduto=<%=nomeProduto%>&tipoProduto=<%=tipoProduto%>">Última</a>
<%      } else { %>
|&nbsp&nbsp Próxima >&nbsp&nbsp|&nbsp&nbspÚltima
<%      } %>
        </center>
<%  } %>
<%@include file="../fimConexao.jsp"%>


