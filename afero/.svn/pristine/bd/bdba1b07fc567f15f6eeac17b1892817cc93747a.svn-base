<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.Orcamento"%>
<%@page import="afero.model.OrcamentoItem"%>
<%@page import="afero.model.Entidade"%>
<%@page import="afero.model.Entrega"%>
<%@page import="afero.model.Colaborador"%>
<%@page import="afero.model.Loja"%>
<%@page import="afero.persistence.LojaDAO"%>
<%@page import="afero.persistence.EntidadeDAO"%>
<%@page import="afero.persistence.EntregaDAO"%>
<%@page import="afero.persistence.OrcamentoDAO"%>
<%@page import="afero.persistence.ColaboradorDAO"%>
<%@ page import="afero.util.Utilitaria" %>
<%@ page import="afero.util.ConverteDate" %>
<%@ page import="afero.model.Produto" %>
<%@ page import="afero.model.Unidade" %>
<%@ page import="afero.model.Estoque" %>
<%@ page import="afero.model.Preco" %>
<%@ page import="afero.persistence.ProdutoDAO" %>
<%@ page import="afero.persistence.UnidadeDAO" %>
<%@ page import="afero.persistence.EstoqueDAO" %>
<%@ page import="afero.persistence.PrecoDAO" %>
<%@ page import="afero.persistence.OrcamentoItemDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@page import="afero.util.Utilitaria"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/>"</script>
<script>
function salvar() {
  document.forms[0].submit();
} 
</script>
<%
List list = null;
List listarEstoque = null;
List listarOrcamentoDAO = null;
String acao = request.getParameter("acao");
if(acao == null)acao = "listar";
ProdutoDAO dao;
EstoqueDAO daoEstoque;
OrcamentoItemDAO daoOrcamentoItem;
Produto prod = null;
Estoque estoque =null;
OrcamentoItem orcamentoItem = null;
int cont = 0;
String preco = "0";
ConverteDate converte = new ConverteDate();
String idOrcamento = request.getParameter("idOrcamento");
OrcamentoDAO daoOrcamento = new OrcamentoDAO(conn);
Orcamento orc = daoOrcamento.procurarOrcamentoItem(Integer.parseInt(idOrcamento));
int idColaborador = orc.getIdColaborador();
Colaborador colaborador = new Colaborador();
ColaboradorDAO daoColaborador = new ColaboradorDAO(conn);
colaborador = daoColaborador.procurarColaborador(idColaborador);
String dsColaborador = colaborador.getNome();
int idLoja = orc.getIdLoja();
Loja lojaListar = new Loja();
LojaDAO daoLoja = new LojaDAO(conn);
lojaListar = daoLoja.procurarLoja(idLoja);
String dsLoja = lojaListar.getApelido() +" / "+ lojaListar.getRazaoSocial(); 
int idEntrega = orc.getIdEntrega();
Entrega entrega = new Entrega();
EntregaDAO daoEntrega = new EntregaDAO(conn);
entrega = daoEntrega.procurarEntrega(idEntrega);
String dsEntrega = entrega.getDsEntrega();
float valorEntrega = entrega.getTxEntrega();
int cdEntidade = orc.getCdEntidade();
Entidade entidade = new Entidade();
EntidadeDAO daoEntidade = new EntidadeDAO(conn);
entidade = daoEntidade.procurarEntidade(cdEntidade);
String dsEntidade = entidade.getNome();
int prazoValidade = orc.getPrazoValidade();

String status = request.getParameter("status");
if(status==null){
	status=orc.getStatus();
}
String dtOrc =converte.dateToString(orc.getDtOrc());
String dtEntrega =converte.dateToString(orc.getDtEntrega());
String observacao = orc.getObservacao();
double valorTotal = orc.getVlOrc();
float desconto = orc.getVlDesc();
String pessoaResponsavel = orc.getPessoaResponsavel();


if(acao.equalsIgnoreCase("atu")){
	if(status.equals("R")){
		orc.setStatus("R");
		daoOrcamento.atualizar(orc);
	}else if(status.equals("NA")){
		orc.setStatus("NA");
		daoOrcamento.atualizar(orc);
	}
}
%>
<body onload="document.forms[0].elements[2].focus();" >
<form action="exibirOrcamento.jsp?acao=atu" method="post">
<h1 class="cabecalho_pagina">Cadastro de Orçamento</h1>
<input type="hidden" name="idOrcamento" value="<%=idOrcamento%>"/>
<table border="0" width="100%">
   <tr>
    <th class="label">Loja</th>
    <td><input disabled type="text" name="dsLoja" <%if (dsLoja != null) { %>value="<%=dsLoja%>"<% }%>  size="60" maxlength="60"></td>
  </tr>
     <tr>
    <th class="label">Colaborador</th>
    <td><input disabled type="text" name="dsColaborador" <%if (dsColaborador != null) { %>value="<%=dsColaborador%>"<% }%>  size="60" maxlength="60"></td>
  </tr>
    <tr>
    <th class="label">Cliente</th>
    <td><input disabled type="text" name="dsEntidade" <%if (dsEntidade != null) { %>value="<%=dsEntidade%>"<% }%>  size="60" maxlength="60"></td>
  </tr>
    <tr>
    <th class="label">Pessoa Responsável</th>
    <td><input disabled type="text" name="pessoaResponsavel" <%if (pessoaResponsavel != null) { %>value="<%=pessoaResponsavel%>"<% }%>  size="60" maxlength="60"></td>
  </tr>
  <tr>
    <th class="label">Entrega</th>
    <td><input disabled type="text" name="dsEntrega" <%if (dsEntrega != null) { %>value="<%=dsEntrega%>"<% }%>  size="60" maxlength="60"></td>
  </tr>
   <tr>
    <th class="label">Data do Orçamento</th>
    <td><input disabled type="text" name="dtOrc" <%if (dtOrc != null) { %>value="<%=dtOrc%>"<% }%>  size="30" maxlength="30"></td>
  </tr>
     <tr>
    <th class="label">Data da Entrega</th>
    <td><input disabled type="text" name="dtEntrega" <%if (dtEntrega != null) { %>value="<%=dtEntrega%>"<% }%>  size="30" maxlength="30"></td>
  </tr>
   <tr>
    <th class="label">Prazo de Validade</th>
    <td><input disabled type="text" name="prazoValidade" value="<%=prazoValidade%>"  size="10" onkeyup="FormataValor(this,event)" maxlength="10"></td>
  </tr>
  <tr>
      <th class="label">Observação</th>
      <td><textarea disabled="disabled"name="observacao" cols="60" rows="5"><%=observacao %></textarea></td>
  </tr>
  <tr>
    <th class="label">Status</th>
    <td class="label_radio">
      <input  disabled type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Aprovado
      <input type="radio" class="radio" name="status" value="R" <%= (status.equals("R")? "checked": "") %>>Recusado<br>
      <input type="radio" class="radio" name="status" value="NA" <%= (status.equals("NA")? "checked": "") %>>Não Avaliado</td>
  </tr>
</table><hr>
<table border="0" width="100%">
    <tr">
      <th class="grid"><center></center></th>
      <th class="grid">Loja</th>
      <th class="grid"><center>Descrição do Produto</center></th>
      <th class="grid">Quantidade</th>
      <th class="grid">% Desc.</th>
      <th class="grid">Vl.Unitário</th>
      <th class="grid">Total</th>
      <th class="grid">Unidade</th>
      
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
 float total = 0;

 String idLojaUsuario = (String)session.getAttribute("idLoja");
 daoOrcamentoItem = new OrcamentoItemDAO(conn);
 list = daoOrcamentoItem.procurarOrcamentoItem(Integer.parseInt(idOrcamento));
 if(list != null){
  for ( Iterator it = list.iterator(); it.hasNext(); ) {
	orcamentoItem = (OrcamentoItem) it.next();
	dao = new ProdutoDAO(conn);
	prod = dao.procurarProduto(orcamentoItem.getIdProduto());
	daoEstoque = new EstoqueDAO(conn);
	listarEstoque = daoEstoque.procurarEstoquePreco(prod.getIdProduto(), Integer.parseInt(idLojaUsuario));
	if(listarEstoque != null){
	for (Iterator itListar = listarEstoque.iterator(); itListar.hasNext();){
		cont++;
		estoque = (Estoque) itListar.next();
		LojaDAO loja = new LojaDAO(conn);
		Loja lojaEstoque = loja.procurarLoja(estoque.getIdLoja());
		PrecoDAO daoPrecoListar = new PrecoDAO(conn);
		Preco precoListar = daoPrecoListar.procurarPrecoEstoque(estoque.getIdEstoque());
		if(precoListar!=null){
			
			//preco = Utilitaria.formatarNumero(precoListar.getPreco(), 2).toString();
			preco = Utilitaria.formatarNumero(orcamentoItem.getVlUni(), 2).toString();
			UnidadeDAO daoUnidade = new UnidadeDAO(conn);
			Unidade unidadeListar = daoUnidade.procurarUnidade(precoListar.getIdUnidade());	
%>
    <tr>
      <td class = "grid" width="1%"><center><%=cont%></center></td>
      <td class = "grid" width="5%"><center><%=lojaEstoque.getApelido()%></center></td>
      <td class = "grid" width="5%"><center> <%=prod.getDsProduto() %></center></td>
      <td class="grid" width="3%" name="quantidade" size="10" maxlength="10"><%=Utilitaria.formatarNumero(orcamentoItem.getQuant(),0)%></td>
      <td class="grid" width="3%" name="pDesc" size="10" maxlength="10"><%=Utilitaria.formatarNumero(orcamentoItem.getPDesc(),2)%></td>
      <td class="grid" width="3%" name="vlUni" size="10" maxlength="10"><%=Utilitaria.formatarNumero(orcamentoItem.getVlUni(),2)%></td>
      <%float precoItem = Utilitaria.toNumber(preco).floatValue() * orcamentoItem.getQuant(); %>
      <td class="grid" width="3%" name="preco_<%=precoListar.getIdPreco()%>" size="10" maxlength="10"><%=Utilitaria.formatarNumero(precoItem,2)%></td>
      <td class = "grid" width="3%"><center><%=unidadeListar.getDsUnidade()%></center></td>
      <%total = total +  precoItem;%>
  </tr>
  <input type="hidden" name="idPreco" value="<%=precoListar.getIdPreco()%>"/>
<%
		}
	}
	}
}
%>
   
   <input type="hidden"  id="cont" value="<%=cont%>"/>
<% 
 }
%> 
  <br>
<tr>
      
      <th class="grid" width="5%"><center>TOTAL DO PEDIDO:</center></th>
      <td><input type="text" id="total" value="<%=Utilitaria.formatarNumero(total,2)%>" ></td>
  </tr>
       <tr>
      
      <th class="grid" width="5%"><center>DESCONTO :(%)</center></th>
      <td><input type="text" id="valorEntrega" value="<%=desconto%>" ></td>
  </tr> 
   <tr>
      
      <th class="grid" width="5%"><center>VALOR C/ O DESCONTO :</center></th>
      <td><input type="text" id="valorEntrega" value="<%=Utilitaria.formatarNumero(valorTotal,2)%>" ></td>
  </tr>
   <tr>
      
      <th class="grid" width="5%"><center>TAXA DE ENTREGA : <%=dsEntrega%></center></th>
      <td><input type="text" id="valorEntrega" value="<%=Utilitaria.formatarNumero(valorEntrega,2)%>" ></td>
  </tr>  
  <%
    valorTotal += valorEntrega;
  %>
   <tr>
      <th class="grid" width="5%"><center>VALOR TOTAL:</center></th>
      <td><input type="text" id="valorTotal" value="<%=Utilitaria.formatarNumero((valorTotal),2)%>" ></td>
  </tr>
</table>
<br>

</form>
<%@include file="../fimConexao.jsp"%>
</body>
</html>