<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.Produto" %>
<%@ page import="afero.model.OrcamentoItem" %>
<%@ page import="afero.model.Orcamento" %>
<%@ page import="afero.model.Unidade" %>
<%@ page import="afero.model.Estoque" %>
<%@ page import="afero.model.Preco" %>
<%@ page import="afero.model.Loja" %>
<%@ page import="afero.persistence.ProdutoDAO" %>
<%@ page import="afero.persistence.OrcamentoDAO" %>
<%@ page import="afero.persistence.UnidadeDAO" %>
<%@ page import="afero.persistence.EstoqueDAO" %>
<%@ page import="afero.persistence.LojaDAO" %>
<%@ page import="afero.persistence.PrecoDAO" %>
<%@ page import="afero.persistence.OrcamentoItemDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@page import="afero.util.Utilitaria"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/></script>

<script>

function soma(){
  var desconto = parseFloat(document.getElementById("desconto").value);
  var desc = desconto * document.getElementById("valorTotal").value / 100;
  document.getElementById("valorTotal").value =document.getElementById("valorTotal").value - desc;
}
function recarregar() {
  document.forms[0].action="itensOrcamento.jsp?acao=atu";
  document.forms[0].submit();
}
function salvar() {
  document.forms[0].submit();
}

function confirmaExcluir(cont, id, id1) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'itensOrcamento.jsp?acao=exc&idOrcamento='+id1+'&idOrcamentoItem=' + id;   
  }  
}
</script>
<%
String idLojaUsuario = (String)session.getAttribute("idLoja");
List list = null;
List listarEstoque = null;
List listarOrcamentoDAO = null;
ProdutoDAO dao;
EstoqueDAO daoEstoque;
OrcamentoItemDAO daoOrcamentoItem;
Produto prod = null;
Estoque estoque =null;
OrcamentoItem orcamentoItem = null;
String nomeProduto = request.getParameter("nomeProduto");
if(nomeProduto == null)nomeProduto = "";
String status = request.getParameter("status");
if(status == null)status = "A";
String acao = request.getParameter("acao");
if(acao == null)acao="listar";
String clausula = "";
int cont = 0;
String preco = "0";
float desconto = 0;
double valorTotal = 0;
double totalizador = 0;
float pDesc = 0;
String idOrcamento = request.getParameter("idOrcamento");
if(acao.equalsIgnoreCase("exc")){
	String idOrcamentoItem = request.getParameter("idOrcamentoItem");
	OrcamentoItem orcExcluir = new OrcamentoItem();
	OrcamentoItemDAO daoOrcamentoItemExcluir = new OrcamentoItemDAO(conn);
	orcExcluir.setIdOrcamentoItem(Integer.parseInt(request.getParameter("idOrcamentoItem")));
	daoOrcamentoItemExcluir.excluir(orcExcluir);
	acao="listar";
}
if(acao.equalsIgnoreCase("atu")){
	Orcamento orc = new Orcamento();
	OrcamentoDAO daoOrcamento = new OrcamentoDAO(conn);
	orc = daoOrcamento.procurarOrcamento(Integer.parseInt(idOrcamento));
	if(request.getParameter("valorTotal")!= null){
		valorTotal = Utilitaria.toNumber(request.getParameter("valorTotal")).doubleValue();	
		orc.setVlOrc(valorTotal);
	}
	if(request.getParameter("desconto") != null){
		desconto = Float.parseFloat(request.getParameter("desconto"));
		orc.setVlDesc(desconto);
		totalizador = Utilitaria.toNumber(request.getParameter("total")).doubleValue();	
		orc.setVlOrc(totalizador - (totalizador *(desconto/100)));
	}
	daoOrcamento.atualizarItem(orc);
	
}
if(acao.equalsIgnoreCase("listar")) {
	Orcamento orcamentoListar = new Orcamento();
	OrcamentoDAO daoOrcamentoListar = new OrcamentoDAO(conn);
	orcamentoListar = daoOrcamentoListar.procurarOrcamentoItem(Integer.parseInt(idOrcamento));
	valorTotal = orcamentoListar.getVlOrc();
	desconto = orcamentoListar.getVlDesc();
}
%>
<body onload="document.forms[0].elements[0].focus();" >
<form action="itensOrcamento.jsp?acao=atu" method="post">
<input type="hidden" name="acao" value="<%=acao%>"/>
<input type="hidden" name="cont" value="<%=cont%>"/>
<input type="hidden" name="idOrcamento" value="<%=idOrcamento%>"/>
<hr>
<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr">
      <th class="grid"><center></center></th>
      <th class="grid">Loja</th>
      <th class="grid"><center>Descrição do Produto</center></th>
      <th class="grid">Quant.</th>
      <th class="grid"> Desc.(%)</th>
      <th class="grid">Vl.Unit.(R$)</th>
      <th class="grid">Vl.Item(R$)</th>
      <th class="grid">Und</th>
      <th class="grid">Excluir</th>
      
    </tr>
<%
//Utiliza o ResultSet para trazer os registros do banco de dados
 float total = 0;
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
      <td class = "grid" width="10%"><center><%=prod.getDsProduto() %></center></td>
      <td class="grid" width="3%" name="quantidade" size="10" maxlength="10"><%=orcamentoItem.getQuant()%></td>
      <td class="grid" width="3%" name="pDesc" size="10" maxlength="10"><%=Utilitaria.formatarNumero(orcamentoItem.getPDesc(),2)%></td>
      <td class="grid" width="3%" name="vlUni" size="10" maxlength="10"><%=Utilitaria.formatarNumero(orcamentoItem.getVlUni(),2)%></td>
      <%float precoItem = Utilitaria.toNumber(preco).floatValue() * orcamentoItem.getQuant(); %>
      <td class="grid" width="3%" name="preco_<%=precoListar.getIdPreco()%>" size="10" maxlength="10"><%=Utilitaria.formatarNumero(precoItem,2)%></td>
      <td class = "grid" width="3%"><center><%=unidadeListar.getDsUnidade()%></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=cont%>,<%=orcamentoItem.getIdOrcamentoItem()%>,<%=orcamentoItem.getIdOrcamento()%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
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
    
      <th class="grid" width="5%"><center>TOTAL:</center></th>
      <td><input type="text" id="total" value="<%=Utilitaria.formatarNumero(total,2)%>" onblur="soma()"></td>
  </tr>
  <tr>
      <th class="grid" width="5%"><center>DESCONTO :(%)</center></th>
      <td><input type="text" id="desconto" name ="desconto" value="<%=desconto%>" onblur="recarregar()"></td>
  </tr>
  <%
     valorTotal = total - (total *(desconto/100));
     Orcamento orc = new Orcamento();
	 OrcamentoDAO daoOrcamento = new OrcamentoDAO(conn);
	 orc = daoOrcamento.procurarOrcamento(Integer.parseInt(idOrcamento));
     orc.setVlOrc(valorTotal);
     orc.setVlDesc(desconto);
	 daoOrcamento.atualizarItem(orc);
  %>
  <tr>
      <th class="grid" width="5%"><center>Valor Total:</center></th>
  
      <td><input type="text" id="valorTotal" name="valorTotal" value="<%=Utilitaria.formatarNumero(valorTotal,2)%>"></td>
   
  </tr>
  <input type="hidden"  id="total"  name="total"value="<%=Utilitaria.formatarNumero(total,2)%>"/>
  <input type="hidden"  id="valorTotal" name="total"value="<%=Utilitaria.formatarNumero(valorTotal,2)%>"/>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
<tr>
	<td>  <br>
	<input class="button" type="button" value="Gravar" onClick="javascript: salvar();" /></td>
</tr>
</table>
<%@include file="../fimConexao.jsp"%>
</form>