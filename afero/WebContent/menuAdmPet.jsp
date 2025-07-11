<%@page contentType="text/html;charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page session="true" errorPage="/erro.jsp"%>
<%@ page import="afero.util.IDadosSistema"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="expires" content="0" />
<meta http-equiv="cache-control" content="no-cache" />
<title><%=IDadosSistema.Sis_nom%> | <%=IDadosSistema.Sis_tit%>
	- <%=IDadosSistema.Sis_cod%> v.<%=IDadosSistema.Sis_ver%></title>
<link rel="StyleSheet" type="text/css" href="css/afero.css"/>
<script src="/js/common.js"/></script>
<%@include file="seguranca.jsp"%>
<script language="javascript">

function myFunc(a,b,c) {
   alert("Ocorreu um erro: "+a+" \r\n(P?gina: "+b+"  -   Linha: "+c+")"); 
   return true;
}
window.onerror= myFunc; 
</script>
</head>
<body style="margin: 0 0 0 0">
<%
  String usuario = (String)session.getAttribute("Login");
  String ultimoAcesso = "";
%>
<table border="0" width="100%" height="100%" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
	<tr height="50" valign="top">
		<td colspan="2" width="100%" valign="top">
		<table border="0" width="100%" height="80" cellspacing="0" cellpadding="0" 
		   background="images/barra1280.jpg">
			<tr>
				<td style=" width: 90%; height: 80px"></td>
				<td bgcolor="#FFFFFF" align="center" ><img src="images/logomarca_ajusoft.jpg" style="width: 96px; height: 70px"></td>
			</tr>
			<tr>
				<td></td>
				<td bgcolor="#FFFFFF" >&nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr height="18">
		<th bgcolor="#000000" colspan="2" align="right" style="line-height: normal; color: #FFFFFF; font-style: normal; font-size: 9px; font-family: Verdana, Arial, Sans-Serif">&nbsp;<%="Usuário: "+usuario%>&nbsp;-&nbsp;<%="Último acesso: "+ultimoAcesso%>&nbsp;</th>
	</tr>
	<tr>
	
	<td colspan="2" >
		  <iframe src="" name="principal" width="100%"
			height="100%" scrolling="auto" align="top" frameborder="0" hspace="0"
			vspace="0" marginheight="0" marginwidth="2"></iframe>
	 </td>
	</tr>
</table>

<script language=JavaScript src="js/dropdown/milonic_src.js"
	type=text/javascript></script>
<script language=JavaScript src="js/dropdown/mmenudom.js"></script>
<script language=JavaScript src="js/dropdown/contextmenu.js"
	type=text/javascript></script>
<script language=JavaScript src="js/dropdown/dragdrop.js"
	type=text/javascript></script>
<script language=JavaScript src="js/dropdown/tooltips.js"
	type=text/javascript></script>
<script language=javascript>
	_menuCloseDelay=300           // The time delay for menus to remain visible on mouse out
	_menuOpenDelay=0              // The time delay before menus open on mouse over
	_followSpeed=5                // Follow scrolling speed
	_followRate=50                // Follow scrolling Rate
	_subOffsetTop=5               // Sub menu top offset
	_subOffsetLeft=-10            // Sub menu left offset
	_scrollAmount=3               // Only needed for Netscape 4.x
	_scrollDelay=20               // Only needed for Netcsape 4.x

	with(menuPrincipal=new mm_style()) {
		onbgcolor="#dddddd";
		oncolor="black";
		offbgcolor="#112233";
		offcolor="white";
		bordercolor="black";
		borderstyle="solid";
		borderwidth=1;
		separatorcolor="black";
		separatorsize="1";
		padding=2;
		fontsize="8pt";
		fontstyle="normal";
		fontfamily="Verdana, Tahoma, Arial";
		pagecolor="white";
		pagebgcolor="#112233";
		headercolor="#000000";
		headerbgcolor="#ffffff";
		subimage="js/dropdown/arrow_d.gif";
		subimagepadding="2";
	}

	with(menuStyle=new mm_style()) {
		onbgcolor="#dddddd";
		oncolor="black";
		offbgcolor="#112233";
		offcolor="white";
		bordercolor="black";
		borderstyle="solid";
		borderwidth=1;
		separatorcolor="black";
		separatorsize="1";
		padding=4;
		fontsize="8pt";
		fontstyle="normal";
		fontfamily="Verdana, Tahoma, Arial";
		pagecolor="white";
		pagebgcolor="#112233";
		headercolor="#000000";
		headerbgcolor="#ffffff";
		subimage="js/dropdown/arrow_d.gif";
		subimagepadding="2";
	}

	with(milonic=new menuname("Main Menu")) {
		style=menuPrincipal;
		top=80;
		left=0;
		itemwidth="100px";
		alwaysvisible=1;
		followscroll="1";
		orientation="horizontal";
		aI("text= Arquivo ;showmenu=id100001;");
		aI("text= Cadastros ;showmenu=id100002;");
		aI("text= Compras ;showmenu=id100003;");
		aI("text= Estoque ;showmenu=id100004;");
		aI("text= Orçamento ;showmenu=id100005;");
		//aI("text= OS ;showmenu=id100006;");
		aI("text= Comercial ;showmenu=id100007;");
		aI("text= Painéis ;showmenu=id100008;");
		aI("text= Financeiro ;showmenu=id100009;");
		aI("text= Pet ;showmenu=id100010;");
	}

	with(milonic=new menuname("id100001")) {
	  style=menuStyle;
	  overflow="scroll";
		aI("text= Propriedades do Sistema;url=;target=;status=Propriedades gerais do sistema;");
		aI("text=;url=;target=;status=;");
		aI("text= Sair ;url=logout.jsp;target=;status=Sair do sistema;");
	}
	
	with(milonic=new menuname("id100002")) {
		style=menuStyle;
		overflow="scroll";
		aI("text=Lojas;url=cadastros/listarLoja.jsp;target=principal;status=Cadastrar Lojas");
		aI("text=Colaboradores;url=cadastros/listarColaborador.jsp;target=principal;status=Cadastrar colaboradores");
		aI("text=Entidades Física (simplificado);url=cadastros/listarEntidadeFisicaSimplificado.jsp;target=principal;status=Cadastrar entidades física");
		aI("text=Entidades Jurídica (simplificado);url=cadastros/listarEntidadeJuridicaSimplificado.jsp;target=principal;status=Cadastrar entidades jurídica");
		aI("text=Entidades Física;url=cadastros/listarEntidadeFisica.jsp;target=principal;status=Cadastrar entidades física");
		aI("text=Entidades Jurídica;url=cadastros/listarEntidadeJuridica.jsp;target=principal;status=Cadastrar entidades jurídica");
		aI("text=Consultar Entidades;url=cadastros/consultarClientes.jsp;target=principal;status=Consultar Entidades");
		aI("text=Produtos;url=cadastros/listarProduto.jsp;target=principal;status=Cadastrar produtos");
		//aI("text=Estoque;url=cadastros/listarEstoque.jsp;target=principal;status=Cadastrar estoques por loja");
		//aI("text=Preços;url=cadastros/listarPreco.jsp;target=principal;status=Cadastrar preços");
		aI("text=Tipos de Colaborador;url=cadastros/listarTipoColaborador.jsp;target=principal;status=Cadastrar tipos de colaborador");
		aI("text=Cidades;url=cadastros/listarCidade.jsp;target=principal;status=Cadastrar cidades");
		aI("text=Grupos;url=cadastros/listarGrupo.jsp;target=principal;status=Cadastrar grupos de produtos");
		aI("text=Subgrupos;url=cadastros/listarSubGrupo.jsp;target=principal;status=Cadastrar subgrupos de grupos");
		aI("text=Divisões;url=cadastros/listarDivisao.jsp;target=principal;status=Cadastrar divisões de subgrupos");
		aI("text=Unidades de Medida;url=cadastros/listarUnidade.jsp;target=principal;status=Cadastrar unidades de medida");
		aI("text=Relação entre Unidades;url=cadastros/listarRelacaoUnidade.jsp;target=principal;status=Cadastrar Relação entre unidades");
		aI("text=Taxas de Entrega;url=cadastros/listarEntrega.jsp;target=principal;status=Cadastrar taxas de entrega");
		aI("text=Usuários;url=cadastros/listarUsuario.jsp;target=principal;status=Cadastrar usuários");
		aI("text=Atualizar Login;url=cadastros/atualizacaoLogin.jsp;target=principal;status=Atualizar Login");
	}
	
	with(milonic=new menuname("id100003")) {
	  style=menuStyle;
	  overflow="scroll";
	  aI("text=Pedidos de Compras;url=compras/formCompras.jsp;target=principal;status=Cadastrar pedidos de compra");
	  aI("text=Consultar Pedidos de Compra;url=compras/consultarPedidoEntrada.jsp;target=principal;status=Consultar pedidos de compra");
	}
	
	with(milonic=new menuname("id100004")) {
	  style=menuStyle;
	  overflow="scroll";
	  aI("text=Atualizar Estoque;url=cadastros/atualizarEstoque.jsp;target=principal;status=Atualizar Estoque");
	  aI("text=Extrato do Produto;url=estoque/consultarExtratoProduto.jsp;target=principal;status=Extrato do Produto");
	  aI("text=Lista de Compras;url=painel/listaCompras.jsp;target=principal;status=Lista de Compras");
	  aI("text=Lista de Estoque;url=estoque/listarProdutoEstoque.jsp;target=principal;status=Lista de; Estoque");
	  aI("text=Consultar Preço de Produtos;url=estoque/consultarProduto.jsp;target=principal;status=Consultar preço de produtos");
	  aI("text=Consultar Estoque de Produtos;url=estoque/consultarProdutoEstoquePreco.jsp;target=principal;status=Consultar estoque de produtos");
	  aI("text=Consultar Preço de Produtos por Divisão;url=estoque/consultarProdutoDivisao.jsp;target=principal;status=Consultar Preço de Produtos por Divisão");
	  aI("text=Movimentação Saída;url=estoque/formPedidoSaida.jsp;target=principal;status=Movimentação");
	  aI("text=Consultar Movimentações Saída;url=estoque/consultarPedidoSaida.jsp;target=principal;status=Consultar Movimentações");
	}
	
	with(milonic=new menuname("id100005")) {
	  style=menuStyle;
	  overflow="scroll";
	  aI("text=Orçamento;url=orcamento/formOrcamento.jsp;target=principal;status=Cadastrar Orçamento");
	  aI("text=Consultar Orçamento;url=orcamento/consultarOrcamento.jsp;target=principal;status=Consultar Orçamento");
	  aI("text=Orçamento X Pedido;url=orcamento/consultarOrcamentoParaPedido.jsp;target=principal;status=Orçamento X Pedido");
	}
	
	//with(milonic=new menuname("id100006")) {
	 // style=menuStyle;
	  //overflow="scroll";
	  //aI("text=Consultar Ordens de Serviços;url=ordemservico/consultarOrdemdeServico.jsp;target=principal;status=Consultar ordens de serviços");
	//}
	
	with(milonic=new menuname("id100007")) {
	  style=menuStyle;
	  overflow="scroll";
	  aI("text=Pedido Balcão;url=comercial/formPedido.jsp;target=principal;status=Cadastrar pedido balcão");
	  aI("text=Consultar Pedidos de Venda;url=comercial/consultarPedidoSaida.jsp;target=principal;status=Consultar pedidos de venda");
	}

	with(milonic=new menuname("id100008")) {
	  style=menuStyle;
	  overflow="scroll";
	  aI("text=Produtos mais Vendidos;url=painel/maisVendidos.jsp;target=principal;status=Produtos mais Vendidos");
	  aI("text=Painel de Pedidos Balcão;url=painel/painelPedidoBalcao.jsp;target=principal;status=Painel Pedidos Balcão");
	  aI("text=Painel de Pedidos;url=painel/painelPedido.jsp;target=principal;status=Painel Pedidos");
	  aI("text=Painel de Compras;url=painel/painelCompras.jsp;target=principal;status=Painel Compras");
	  aI("text=Painel de Orçamentos;url=painel/painelOrcamento.jsp;target=principal;status=Painel Orçamentos");
	  aI("text=Painel de Entregas;url=painel/painelEntrega.jsp;target=principal;status=Painel de Entregas");
	  aI("text=Painel de Entregas Balcão;url=painel/painelEntregaBalcao.jsp;target=principal;status=Painel de Entregas Balcão");
	  aI("text=Painel de Mapa de Entregas;url=painel/painelMapaEntrega.jsp;target=principal;status=Painel de Mapa de Entregas");
	   
	}

	with(milonic=new menuname("id100009")) {
	  style=menuStyle;
	  overflow="scroll";
	  aI("text=Cadastro de Bancos;url=financeiro/listarBanco.jsp;target=principal;status=Cadastro de Bancos");
	  aI("text=Cadastro de Contas;url=financeiro/listarConta.jsp;target=principal;status=Cadastro de Contas");
	  aI("text=Cadastro de Tipos de Conta;url=financeiro/listarTipoConta.jsp;target=principal;status=Cadastro de Tipos de Conta");
	  aI("text=Cadastro de Tipos de Documento;url=financeiro/listarTipoDocumento.jsp;target=principal;status=Cadastro de Tipos de Documento");
	  aI("text=Cadastro de Formas de Pagamento;url=financeiro/listarFormaPagto.jsp;target=principal;status=Cadastro de Formas de Pagamento");
	  //aI("text=Cadastro de Tipos de Frequência;url=financeiro/listarTipoFrequencia.jsp;target=principal;status=Cadastro de Tipos de Frequência");
	  aI("text=Cadastro de Plano de Contas;url=financeiro/listarPlanoConta.jsp;target=principal;status=Cadastro de Plano de Contas");
	  aI("text=Cadastro de Centros de Custo;url=financeiro/listarCentroCusto.jsp;target=principal;status=Cadastro de Centro de Custo");
	  aI("text=Chegues Recebidos;url=financeiro/listarChequeRecebido.jsp;target=principal;status=Chegues Recebidos");
	  aI("text=Chegues Emitidos;url=financeiro/listarChegueEmitido.jsp;target=principal;status=Chegues Emitidos");
	  aI("text=Contas a Receber;url=financeiro/listarDuplicataReceber.jsp;target=principal;status=Contas a Receber");
	  aI("text=Contas a Pagar;url=financeiro/listarDuplicataPagar.jsp;target=principal;status=Contas a Pagar");
	  //aI("text=Movimentação de Conta;url=financeiro/listarContaMovto.jsp;target=principal;status=Movimentação de Conta");
		//aI("text=Transferencia de Contas;url=financeiro/listarTransferencia.jsp;target=principal;status=Transferencia de Contas");
    //aI("text=Cadastro de Orçamentos da Empresa;url=financeiro/listarOrcamentoEmpresa.jsp;target=principal;status=Cadastro do Orçamentos da Empresa");

	}
	
	with(milonic=new menuname("id100010")) {
		  style=menuStyle;
		  overflow="scroll";
		  aI("text=Cadastro de Tipos de Espécie;url=pet/listarTipoEspecie.jsp;target=principal;status=Cadastro de Tipos de Espécie");
		  aI("text=Cadastro de Tipos de Raça;url=pet/listarTipoRaca.jsp;target=principal;status=Cadastro de Tipos de Raça");
		  aI("text=Cadastro de Grupos de Medicamentos;url=pet/listarGrupoMedicamento.jsp;target=principal;status=Cadastro de Grupos de Medicamentos");
		  aI("text=Cadastro de Medicamentos;url=pet/listarMedicamento.jsp;target=principal;status=Cadastro de Medicamentos");
		  aI("text=Cadastro de Animais;url=pet/listarAnimal.jsp;target=principal;status=Cadastro de Animais");
		  aI("text=Painel de Visualizações rápidas;url=painelPet/painel.jsp;target=principal;status=Painel de Visualizações rápidas");
		  //aI("text=Lista de Retorno;url=pet/listarRetorno.jsp;target=principal;status=Lista de Retorno");
		}

	drawMenus();
	
</script>
</body>
</html>
