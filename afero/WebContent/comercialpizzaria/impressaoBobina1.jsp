<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page session="true" errorPage="/erro.jsp" %>
<%@page import="java.sql.*, java.util.*" %>
<%@page import="afero.util.*" %>
<%@page import="afero.model.EntidadeEndereco"%>
<%@page import="afero.model.EntidadeTelefone"%>
<%@page import="afero.model.TipoLogradouro"%>
<%@page import="afero.model.PedidoSaida"%>
<%@page import="afero.model.PedidoSaidaItem"%>
<%@page import="afero.model.OrcamentoPedidoSaida"%>
<%@page import="afero.model.OrdemServico"%>
<%@page import="afero.model.OrcamentoItem"%>
<%@page import="afero.model.Entidade"%>
<%@page import="afero.model.EntidadeFisica"%>
<%@page import="afero.model.Entrega"%>
<%@page import="afero.model.Colaborador"%>
<%@page import="afero.model.Loja"%>
<%@page import="afero.persistence.LojaDAO"%>
<%@page import="afero.persistence.EntidadeDAO"%>
<%@page import="afero.persistence.EntidadeTelefoneDAO"%>
<%@page import="afero.persistence.TipoLogradouroDAO"%>
<%@page import="afero.persistence.PedidoSaidaDAO"%>
<%@page import="afero.persistence.EntregaDAO"%>
<%@page import="afero.persistence.OrcamentoDAO"%>
<%@page import="afero.persistence.EntidadeEnderecoDAO"%>
<%@page import="afero.persistence.ColaboradorDAO"%>
<%@page import="afero.persistence.OrcamentoPedidoSaidaDAO"%>
<%@page import="afero.persistence.OrdemServicoDAO"%>
<%@page import="afero.persistence.PedidoSaidaItemDAO"%>
<%@page import="afero.persistence.PedidoSaidaSubItemDAO"%>
<%@page import="afero.persistence.PedidoSaidaSubItensDAO"%>
<%@page import="afero.persistence.EntidadeFisicaDAO"%>
<%@page import="afero.model.PedidoSaidaSub"%>
<%@page import="afero.model.PedidoSaidaSubItem"%>
<%@page import="afero.model.PedidoSaidaSubItens"%>
<%@ page import="afero.util.Utilitaria"%>
<%@ page import="afero.util.ConverteDate"%>
<%@ page import="afero.model.Produto"%>
<%@ page import="afero.model.Unidade"%>
<%@ page import="afero.model.Estoque"%>
<%@ page import="afero.model.Preco"%>
<%@ page import="afero.persistence.ProdutoDAO"%>
<%@ page import="afero.persistence.UnidadeDAO"%>
<%@ page import="afero.persistence.EstoqueDAO"%>
<%@ page import="afero.persistence.PrecoDAO"%>
<%@ page import="afero.persistence.OrcamentoItemDAO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@page import="afero.util.Utilitaria"%>
<%-- Definindo parâmetros da página --%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<%!
    private String cbe(String texto, int tamanho) {
        if (texto == null) {
            texto = "";
        }

        return Utilitaria.retirarAcentos(Utilitaria.completarBrancosEsquerda(texto, tamanho));
    }

    private String cbe(int numero, int tamanho) {
        return Utilitaria.retirarAcentos(Utilitaria.completarBrancosEsquerda(String.valueOf(numero), tamanho));
    }

    private String cb(String texto, int tamanho) {
        if (texto == null) {
            texto = "";
        }

        return Utilitaria.retirarAcentos(Utilitaria.completarBrancos(texto, tamanho));
    }

    private String cb(int tamanho) {
        return Utilitaria.retirarAcentos(Utilitaria.completarBrancos("", tamanho));
    }

    private String cz(String texto, int tamanho) {
        if (texto == null) {
            texto = "";
        }

        return Utilitaria.completarZeros(texto, tamanho);
    }

    private String cz(int numero, int tamanho) {
        if (numero < 0) {
            numero = 0;
        }

        return Utilitaria.completarZeros(String.valueOf(numero), tamanho);
    }

    private String cz(long numero, int tamanho) {
        if (numero < 0) {
            numero = 0;
        }

        return Utilitaria.completarZeros(String.valueOf(numero), tamanho);
    }

    private String cz(int tamanho) {
        return Utilitaria.completarZeros("", tamanho);
    }
%>
<html>

<body bgcolor="white"><form style="display: inline">
<script src="<c:url value="/js/common.js"/>"></script>
<script>
function imprimir() {
  var frm = document.forms[0];
  var tipoEscolhido = getValueRadio(frm.elements["tipo"]);
  setCookie("tipo_impressora", tipoEscolhido);
  if (tipoEscolhido == "B") {
    setCookie("modelo_impressora", frm.modelo.value);
    setCookie("porta_impressora", frm.porta.value);
  }
  document.getElementById('botao').style.display = 'none';
  if (tipoEscolhido == "N") {
    print();
  } else {
    try {
        var texto = document.getElementById("texto_bobina").innerHTML;
        ImprimeTextoBematech(frm.porta.value, frm.modelo.value, texto);
    } catch (e) {
        alert("Impressora Bematech não instalada: " + e.message);
    }
  }
  document.getElementById('botao').style.display = 'block';
}

function showDetalhes(valor) {
  if (valor == "N") {
    document.getElementById('detalhes').style.display = 'none';
  } else {
    document.getElementById('detalhes').style.display = 'inline';
    document.getElementById('detalhes').style.align = 'center';
  }
}
</script>
<%@include file="bematech.jspf"%>
<%
String tipo = "N";
String modelo = "1";
String porta = "LPT1";
/**
Cookie[] cookies = request.getCookies();
for (int i = 0; i < cookies.length; i++) {
    if ("tipo_impressora".equals(cookies[i].getName())) {
        tipo = cookies[i].getValue();
    }
    if ("modelo_impressora".equals(cookies[i].getName())) {
        modelo = cookies[i].getValue();
    }
    if ("porta_impressora".equals(cookies[i].getName())) {
        porta = cookies[i].getValue();
    }
}
*/
%>
<%--
<div id="botao" align="center" style="font-size: 8pt; width: 400px">Impressora: 
        <input type="radio" name="tipo" value="N" onclick="showDetalhes(this.value)" <%= "N".equals(tipo)? "checked": "" %>> Normal
        <input type="radio" name="tipo" value="B" onclick="showDetalhes(this.value)" <%= "B".equals(tipo)? "checked": "" %>> Bematech<br>
        <div id="detalhes" style="display: <%= "N".equals(tipo)? "none": "inline" %>"><center>
                Porta: <select name="porta" style="font-size: 8pt">
                    <option value="LPT1">LPT1</option>
                    <option value="COM1">COM1</option>
                    <option value="COM2">COM2</option>
                </select><script>comboSelect(document.forms[0].porta, "<%= porta %>");</script><br>
                Modelo: <select name="modelo" style="font-size: 8pt">
                    <option value="1">MP20CI, MP20MI e MP20S</option>
                    <option value="0">MP20TH, MP2000CI, MP2000TH</option>
        </select><script>comboSelect(document.forms[0].modelo, "<%= modelo %>");</script></center></div>
        <center><input id="botao" type="button" value="Imprimir" style="font-size: 8pt" onclick="imprimir()"></center>
</div>
</form>
 --%>
<%
String impressao = request.getParameter("impressao");
if(impressao == null)impressao = "";
String idLojaUsuario = (String)session.getAttribute("idLoja");
List listar;
TipoLogradouroDAO logradouro = new TipoLogradouroDAO(conn);
PedidoSaidaDAO daoPedidoSaida = new PedidoSaidaDAO(conn);
String acao = request.getParameter("acao");
if(acao == null)acao="listar";
List list = null;
List listarEstoque = null;
List listarOrcamentoDAO = null;
List listUpdate = null;
ProdutoDAO dao;
Produto prod = null;
Estoque estoque =null;
int cont = 0;
String preco = "0";
ConverteDate converte = new ConverteDate();
String idPedidoSaida = request.getParameter("idPedidoSaida");
PedidoSaida pedidoSaida = daoPedidoSaida.procurarPedidoSaidaItem(Integer.parseInt(idPedidoSaida));
int idColaborador =pedidoSaida.getIdColaborador();
Colaborador colaborador = new Colaborador();
ColaboradorDAO daoColaborador = new ColaboradorDAO(conn);
colaborador = daoColaborador.procurarColaborador(idColaborador);
String dsColaborador = colaborador.getApelido();
int idLoja = pedidoSaida.getIdLoja();
Loja lojaListar = new Loja();
LojaDAO daoLoja = new LojaDAO(conn);
lojaListar = daoLoja.procurarLoja(idLoja);
String dsLoja = lojaListar.getApelido() +" / "+ lojaListar.getRazaoSocial(); 
int idEntrega = pedidoSaida.getIdEntrega();
String pessResp = pedidoSaida.getPessoaResponsavel();
if(pessResp == null)pessResp = "";
Entrega entrega = new Entrega();
EntregaDAO daoEntrega = new EntregaDAO(conn);
entrega = daoEntrega.procurarEntrega(idEntrega);
String dsEntrega = entrega.getDsEntrega();
float valorEntrega = entrega.getTxEntrega();
int cdEntidade =pedidoSaida.getCdEntidade();
Entidade entidade = new Entidade();
EntidadeDAO daoEntidade = new EntidadeDAO(conn);
entidade = daoEntidade.procurarEntidade(cdEntidade);
String dsEntidade = entidade.getNome();
EntidadeFisicaDAO daoFisica = new EntidadeFisicaDAO(conn);
EntidadeFisica fisica = daoFisica.procurarEntidadeFisica(cdEntidade);
EntidadeEndereco entidadeEndereco = null;
EntidadeEnderecoDAO daoEntidadeEndereco= new EntidadeEnderecoDAO(conn);
entidadeEndereco = daoEntidadeEndereco.procurarEntidadeEnderecoPadrao(cdEntidade);
EntidadeTelefoneDAO daoEntidadeFone = new EntidadeTelefoneDAO(conn);
EntidadeTelefone entidadeFone = null;
listar = daoEntidadeFone.listarTelefone(cdEntidade);
String telefone = "";
int contador = 0;
for ( Iterator it = listar.iterator(); it.hasNext(); ) {
	entidadeFone = (EntidadeTelefone) it.next();
	if(entidadeFone.getNroTelefone() != null){
		contador++;
		if(contador <= 2){
			telefone = telefone + " " +entidadeFone.getNroTelefone();
		}
		
	}
	
}
TipoLogradouro logra = logradouro.procurarTipoLogradouro(entidadeEndereco.getCdTipoLogradouro());

String dsLogradouro = logra.getDsTipoLogradouro();
String endereco = dsLogradouro + " " +entidadeEndereco.getDsEndereco() + " " +"nº"+ " "+entidadeEndereco.getNroEndereco();
String cmpEndereco = entidadeEndereco.getCmpEndereco();
String cep = entidadeEndereco.getCepEndereco();
String bairro =entidadeEndereco.getBaiEndereco();
String referencia = entidadeEndereco.getRefEndereco();
String cidadeUf = "";
String status = pedidoSaida.getStatus();
String operacao = pedidoSaida.getOperacao();
String dtPed =converte.dateToStr(pedidoSaida.getDtPed(),"dd/MM/yyyy HH:mm:ss");
String dtEntrega = "";
if(pedidoSaida.getDtEntrega() != null){
dtEntrega =converte.dateToString(pedidoSaida.getDtEntrega());
}
String anotacao = pedidoSaida.getAnotacao();
String hrEntrega = "";
if(pedidoSaida.getHrEntrega() != null){
hrEntrega = pedidoSaida.getHrEntrega();
}
if(hrEntrega == null)hrEntrega="";
if(anotacao == null)anotacao="";
String observacao = pedidoSaida.getObservacao();
if(observacao == null)observacao="";
double valorTotal = pedidoSaida.getVlPed();
float desconto = pedidoSaida.getVlDesc();
%>
<%

StringBuffer textoBobina = new StringBuffer();

// Recuperando os dados do cliente e nr do pedido
textoBobina.append("      Pedido de Venda N. ").append("00"+idPedidoSaida).append("\n"+"E");
textoBobina.append("=======================================\n");
textoBobina.append("Operador...: ").append((String)pedidoSaida.getUsuario()).append("\n");
textoBobina.append("Dt Pedido..: ").append(dtPed).append("\n");
textoBobina.append("Impressao..: ").append(Utilitaria.dateString(new java.util.Date(), "dd/MM/yyyy HH:mm")).append("\n");
textoBobina.append("------------DADOS DA EMPRESA------------\n");
textoBobina.append("Empresa.:").append(Utilitaria.abreviarStr(lojaListar.getRazaoSocial(), 35)).append("\n");
textoBobina.append("CPF/CNPJ:").append(lojaListar.getCnpj()).append("\n");
//Endereco endCliente = midas.obterEndereco(rs.getInt("id_end_entrega"));
if (lojaListar.getEndereco() != null) {
    textoBobina.append("Endereco:").append(Utilitaria.abreviarStr(lojaListar.getEndereco(), 30)).append("\n");
    textoBobina.append("Bairro..:").append(lojaListar.getBairro()).append("\n");
    textoBobina.append("Cidade..:").append(lojaListar.getCidade()).append("\n");
    textoBobina.append("UF......:").append(lojaListar.getEstado()).append("\n");
    textoBobina.append("Telefone:").append(lojaListar.getNroTelefone()).append("\n");
} else {
    textoBobina.append("Sem endereco de entrega definido.\n");
}

textoBobina.append("------------DADOS DO CLIENTE------------\n");
textoBobina.append("Cliente.:").append(Utilitaria.abreviarStr(dsEntidade, 35)).append("\n");
//textoBobina.append("CPF/CNPJ:").append(fisica.getCpf()).append("\n");
textoBobina.append("Endereco:").append(Utilitaria.abreviarStr(endereco,40)).append("\n");
textoBobina.append("Bairro..:").append(Utilitaria.abreviarStr(bairro,40)).append("\n");
textoBobina.append("Telefone:").append(telefone).append("\n");
textoBobina.append("----------------------------------------\n");
textoBobina.append("PRODUTO                        VALOR(R$)\n");
textoBobina.append("=======================================\n");

%>
<%
PedidoSaidaSubItem pedidoSaidaItem = null;
PedidoSaidaSubItens pedidoSubItens = null;
PedidoSaidaSubItemDAO daoPedidoSaidaItem;
PedidoSaidaSubItensDAO daoPedidoSaidaSubItens;
Produto prodSubItens = null;
List listSubItens = null;
List listarEstoqueSubItens = null;
ProdutoDAO daoProdutoSubItens = null;
EstoqueDAO daoEstoque;
EstoqueDAO daoEstoqueSubItens;
Estoque estoqueSubList = null;
float total = 0;
daoPedidoSaidaItem = new PedidoSaidaSubItemDAO(conn);
daoPedidoSaidaSubItens = new PedidoSaidaSubItensDAO(conn);
list = daoPedidoSaidaItem.procurarPedidoSaidaItem(Integer.parseInt(idPedidoSaida));
if(list != null){
 for ( Iterator it = list.iterator(); it.hasNext(); ) {
	pedidoSaidaItem = (PedidoSaidaSubItem) it.next();
	dao = new ProdutoDAO(conn);
	prod = dao.procurarProduto(pedidoSaidaItem.getIdProduto());
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
			preco = Utilitaria.formatarNumero(pedidoSaidaItem.getVlUni(), 2).toString();
			UnidadeDAO daoUnidade = new UnidadeDAO(conn);
			Unidade unidadeListar = daoUnidade.procurarUnidade(precoListar.getIdUnidade());	
			
			textoBobina.append(Utilitaria.abreviarStr(prod.getDsProduto(),30)).append(" ").append(preco).append("\n");
			if(pedidoSaidaItem.getDsCompProduto() != null){
			   textoBobina.append(Utilitaria.abreviarStr(pedidoSaidaItem.getDsCompProduto(),40)).append("\n");
			}
%>
	
	         
		
		<%float precoItem = Utilitaria.toNumber(preco).floatValue() * pedidoSaidaItem.getQuant(); %>
		<%total = total +  precoItem;%>
	
<%
      listSubItens = daoPedidoSaidaSubItens.listarPedidoSaidaSubItensList(pedidoSaidaItem.getIdPedidoSaidaItem());
      if(listSubItens != null){
         for ( Iterator itSubItens = listSubItens.iterator(); itSubItens.hasNext(); ) {
       	      pedidoSubItens = (PedidoSaidaSubItens) itSubItens.next();
       	      daoProdutoSubItens = new ProdutoDAO(conn);
       	      prodSubItens = daoProdutoSubItens.procurarProduto(pedidoSaidaItem.getIdProduto());
       	      daoEstoqueSubItens = new EstoqueDAO(conn);
       	      listarEstoqueSubItens = daoEstoqueSubItens.procurarEstoquePreco(pedidoSaidaItem.getIdProduto(), Integer.parseInt(idLojaUsuario));
       	      if(listarEstoqueSubItens != null){
       	  	for (Iterator itListarSubItens = listarEstoqueSubItens.iterator(); itListarSubItens.hasNext();){
       	  		//cont++;
       	  		estoqueSubList = (Estoque) itListarSubItens.next();
       	  		LojaDAO lojaSubItens = new LojaDAO(conn);
       	  		Loja lojaEstoqueSubItens = lojaSubItens.procurarLoja(estoqueSubList.getIdLoja());
       	  		PrecoDAO daoPrecoListarSubItens = new PrecoDAO(conn);
       	  		Preco precoListarSubList = daoPrecoListarSubItens.procurarPrecoEstoque(estoque.getIdEstoque());
       	  		if(precoListar!=null){
       	  			
       	  			//preco = Utilitaria.formatarNumero(precoListar.getPreco(), 2).toString();
       	  			preco = Utilitaria.formatarNumero(pedidoSubItens.getVlUni(), 2).toString();
       	  			UnidadeDAO daoUnidadeSubList = new UnidadeDAO(conn);
       	  			Unidade unidadeListarSubList = daoUnidadeSubList.procurarUnidade(precoListar.getIdUnidade());
       	  			
       	  		textoBobina.append(Utilitaria.abreviarStr(prodSubItens.getDsProduto(),30)).append(" ").append("FATIA").append("\n");
       	  			
     %>
  <%--<tr> --%>
    <%--<td class="texto"  width="3%"><center><%=pedidoSubItens.getQuant()%></center></td>
     <td class="texto"  width="5%"><center><%=prodSubItens.getDsProduto()%></center></td>
     <td class="texto"  width="3%"><center><%="FATIA"%></center></td>
     <td class="texto"  width="3%"><center><%="FATIA"%></center></td> --%> 
     <%float precoItemSub = Utilitaria.toNumber(preco).floatValue() * pedidoSubItens.getQuant(); %>
    <%--<td class="texto"  width="3%"><center><%="FATIA"%></center></td>
     <td class="texto"  width="3%"><center><%=unidadeListarSubList.getDsUnidade()%></center></td> --%> 

     <%//total = total +  precoItemSub;%>
 <%--</tr> --%>
     <%
   	   
      	}
      }
       	      }
         }
      }
     
     %>
	<input type="hidden" name="idPreco" value="<%=precoListar.getIdPreco()%>" />
	<%
		}
	}
	}
}
%>

	<input type="hidden" id="cont" value="<%=cont%>" />
	<% 
}
%>
<%
textoBobina.append("=================OBSERVAÇÃO=============\n");
textoBobina.append("REF.       :"+Utilitaria.abreviarStr(anotacao, 30)).append("\n");
textoBobina.append("OBS / TROCO:"+Utilitaria.abreviarStr(observacao,30)).append("\n");
textoBobina.append("=================PAGAMENTO==============\n");
textoBobina.append("TOTAL DO PEDIDO(R$):-->"+Utilitaria.formatarNumero(total,2)).append("\n");
textoBobina.append("DESCONTO(%)        :-->"+desconto).append("\n");
textoBobina.append("VALOR C/O DESC.(R$):-->"+Utilitaria.formatarNumero(valorTotal,2)).append("\n");
textoBobina.append("TAXA DE ENTREGA(R$):-->"+Utilitaria.formatarNumero(valorEntrega,2)).append("\n");
textoBobina.append("VALOR TOTAL(R$)    :-->"+Utilitaria.formatarNumero((valorTotal + valorEntrega),2)).append("\n");
textoBobina.append("\n");
textoBobina.append("\n");
textoBobina.append("     "+"______________________________"+"     ").append("\n");
textoBobina.append("          "+Utilitaria.abreviarStr(dsEntidade.toUpperCase(),30)).append("\n");

%>
<%--
	<tr>

		<th align="right" class="texto" width="5%">TOTAL DO PEDIDO:</th>
		<td class="texto_or"><b>R$ <%=Utilitaria.formatarNumero(total,2)%></b></td>
	</tr>

	<tr>
		<th align="right" class="texto" width="5%">
		<center style="width: 132px">DESCONTO (%):</center>
		</th>
		<td class="texto_or"><b><%=desconto%></b></td>
	</tr>
 
	<tr>
		<th align="right" class="texto" width="5%">
		<center>VALOR C/ O DESCONTO :</center>
		</th>
		<td class="texto_or"><b>R$ <%=Utilitaria.formatarNumero(valorTotal,2)%></b></td>
	</tr>

	<tr>

		<th align="right" class="texto" width="5%">TAXA DE ENTREGA:</th>
		<td class="texto_or"><b>R$ <%=Utilitaria.formatarNumero(valorEntrega,2)%></b></td>
	</tr>
	

	<tr>
		<th align="right" class="texto" width="5%">VALOR TOTAL:</th>
		<td class="texto_or"><b>R$ <%=Utilitaria.formatarNumero((valorTotal + valorEntrega),2)%></b></td>
	</tr>
--%>
<%--
	<tr>
		<br>
		<th align="right" class="texto">Anotações:</th>
		<td class="texto_or" name="anotacao" cols="80" rows="3"><b><%=anotacao%></b></td>
	</tr>
 --%>
<%--	
</table>
<br>
<br>
<table align='center'>
<tr>
 
   <th align="center" class="texto"><%="_____________________________________________"%></th>
</tr>
<tr>
 <th align="center" class="texto"><%=dsEntidade.toUpperCase()%></th>
</tr>

</table>
<br>

--%>
<%--
<%
 if(impressao.equalsIgnoreCase("ok")){
	  daoPedidoSaida.atualizarImpressaoPedido(Integer.parseInt(idPedidoSaida));
%>  <script type="text/javascript">
          javascript:window.print();
   </script>

<% 

 }
%>
 --%>
 <table>
   <tr>
      <td align="center"><a href="javascript:window.print();">Imprimir</a></td>
   </tr>
 </table>
<pre id="texto_bobina">
<%= textoBobina %>
</pre>
</body></html>
<%-- Fim do Conteúdo da Página --%>
<%@include file="../fimConexao.jsp"%>