<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="java.sql.*,java.util.*" %>
<%@ page import="afero.util.*" %>
<%@ page import="afero.model.CondPagto"%>
<%@ page import="afero.model.EntidadeEndereco"%>
<%@ page import="afero.model.EntidadeTelefone"%>
<%@ page import="afero.model.TipoLogradouro"%>
<%@ page import="afero.model.PedidoSaida"%>
<%@ page import="afero.model.PedidoSaidaItem"%>
<%@ page import="afero.model.OrcamentoPedidoSaida"%>
<%@ page import="afero.model.OrdemServico"%>
<%@ page import="afero.model.OrcamentoItem"%>
<%@ page import="afero.model.Entidade"%>
<%@ page import="afero.model.EntidadeFisica"%>
<%@ page import="afero.model.Entrega"%>
<%@ page import="afero.model.Colaborador"%>
<%@ page import="afero.model.Loja"%>
<%@ page import="afero.persistence.CondPagtoDAO"%>
<%@ page import="afero.persistence.LojaDAO"%>
<%@ page import="afero.persistence.EntidadeDAO"%>
<%@ page import="afero.persistence.EntidadeTelefoneDAO"%>
<%@ page import="afero.persistence.TipoLogradouroDAO"%>
<%@ page import="afero.persistence.PedidoSaidaDAO"%>
<%@ page import="afero.persistence.PedidoSaidaSubDAO"%>
<%@ page import="afero.persistence.EntregaDAO"%>
<%@ page import="afero.persistence.OrcamentoDAO"%>
<%@ page import="afero.persistence.EntidadeEnderecoDAO"%>
<%@ page import="afero.persistence.ColaboradorDAO"%>
<%@ page import="afero.persistence.OrcamentoPedidoSaidaDAO"%>
<%@ page import="afero.persistence.OrdemServicoDAO"%>
<%@ page import="afero.persistence.PedidoSaidaItemDAO"%>
<%@ page import="afero.persistence.PedidoSaidaSubItemDAO"%>
<%@ page import="afero.persistence.PedidoSaidaSubItensDAO"%>
<%@ page import="afero.persistence.EntidadeFisicaDAO"%>
<%@ page import="afero.model.PedidoSaidaSub"%>
<%@ page import="afero.model.PedidoSaidaSubItem"%>
<%@ page import="afero.model.PedidoSaidaSubItens"%>
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
<%@ page import="afero.util.Utilitaria"%>
<%@ page import="afero.util.ImpressaoBobina"%>
<%@ page import="afero.util.IDadosSistema"%>
<%@ include file="../../seguranca.jsp"%>
<%@ include file="../../iniConexao.jsp"%>

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

		return Utilitaria.retirarAcentos(Utilitaria.completarBrancos(texto,	tamanho));
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
<script src="../js/common.js"/></script>

<%
	ImpressaoBobina bobina = new ImpressaoBobina();
	String impressao = request.getParameter("impressao");
	if (impressao == null)
		impressao = "";
	String idLojaUsuario = (String) session.getAttribute("idLoja");
	List listar;
	TipoLogradouroDAO logradouro = new TipoLogradouroDAO(conn);
	PedidoSaidaDAO daoPedidoSaida = new PedidoSaidaDAO(conn);
	PedidoSaidaSubDAO daoPedidoSaidaSub = new PedidoSaidaSubDAO(conn);
	String acao = request.getParameter("acao");
	if (acao == null)
		acao = "listar";
	List list = null;
	List listarEstoque = null;
	List listarOrcamentoDAO = null;
	List listUpdate = null;
	ProdutoDAO dao;
	Produto prod = null;
	Estoque estoque = null;
	int cont = 0;
	String preco = "0";
	ConverteDate converte = new ConverteDate();
	String idPedidoSaida = request.getParameter("idPedidoSaida");
	PedidoSaida pedidoSaida = daoPedidoSaida.procurarPedidoSaidaItem(Integer.parseInt(idPedidoSaida));
	int idColaborador = pedidoSaida.getIdColaborador();
	Colaborador colaborador = new Colaborador();
	ColaboradorDAO daoColaborador = new ColaboradorDAO(conn);
	colaborador = daoColaborador.procurarColaborador(idColaborador);
	String dsColaborador = colaborador.getApelido();
	int idLoja = pedidoSaida.getIdLoja();
	Loja lojaListar = new Loja();
	LojaDAO daoLoja = new LojaDAO(conn);
	lojaListar = daoLoja.procurarLoja(idLoja);
	String dsLoja = lojaListar.getApelido() + " / "	+ lojaListar.getRazaoSocial();
	int idEntrega = pedidoSaida.getIdEntrega();
	String pessResp = pedidoSaida.getPessoaResponsavel();
	if (pessResp == null)
		pessResp = "";
	Entrega entrega = new Entrega();
	EntregaDAO daoEntrega = new EntregaDAO(conn);
	entrega = daoEntrega.procurarEntrega(idEntrega);
	String dsEntrega = entrega.getDsEntrega();
	float valorEntrega = entrega.getTxEntrega();//daoPedidoSaidaSub.mostrarVlFrete(Integer.parseInt(idPedidoSaida));
	int cdEntidade = pedidoSaida.getCdEntidade();
	Entidade entidade = new Entidade();
	EntidadeDAO daoEntidade = new EntidadeDAO(conn);
	entidade = daoEntidade.procurarEntidade(cdEntidade);
	String dsEntidade = entidade.getNome();
	EntidadeFisicaDAO daoFisica = new EntidadeFisicaDAO(conn);
	EntidadeFisica fisica = daoFisica.procurarEntidadeFisica(cdEntidade);
	EntidadeEndereco entidadeEndereco = null;
	EntidadeEnderecoDAO daoEntidadeEndereco = new EntidadeEnderecoDAO(conn);
	entidadeEndereco = daoEntidadeEndereco.procurarEntidadeEnderecoPadrao(cdEntidade);
	EntidadeTelefoneDAO daoEntidadeFone = new EntidadeTelefoneDAO(conn);
	EntidadeTelefone entidadeFone = null;
	listar = daoEntidadeFone.listarTelefone(cdEntidade);
	String telefone = "";
	String descricao;
	int contador = 0;
	for (Iterator it = listar.iterator(); it.hasNext();) {
		entidadeFone = (EntidadeTelefone) it.next();
		if (entidadeFone.getNroTelefone() != null) {
	contador++;
	if (contador <= 2) {
		telefone = telefone + " "
				+ Utilitaria.formatarTelefone(Utilitaria.soNumeros(entidadeFone.getNroTelefone()));
	}

		}
		

	}
	TipoLogradouro logra = logradouro.procurarTipoLogradouro(entidadeEndereco.getCdTipoLogradouro());

	String dsLogradouro = logra.getAbrevTipoLogradouro();
	//String endereco = dsLogradouro + " " + entidadeEndereco.getDsEndereco();
	//String cmpEndereco = "nº " + entidadeEndereco.getNroEndereco()
	//		+ " - " + entidadeEndereco.getCmpEndereco();
	String endereco = entidadeEndereco.getDsEndereco();
	String cmpEndereco = entidadeEndereco.getNroEndereco().isEmpty() ? 
	entidadeEndereco.getCmpEndereco() : 
	"nº " + entidadeEndereco.getNroEndereco()	+ " - " + entidadeEndereco.getCmpEndereco();
	String cep = entidadeEndereco.getCepEndereco();
	String bairro = entidadeEndereco.getBaiEndereco();
	String referencia = entidadeEndereco.getRefEndereco();
	String cidadeUf = "";
	String status = pedidoSaida.getStatus();
	String operacao = pedidoSaida.getOperacao();
	String dtPed = converte.dateToStr(pedidoSaida.getDtPed(),	"dd/MM/yyyy HH:mm:ss");
	String dtEntrega = "";
	if (pedidoSaida.getDtEntrega() != null) {
		dtEntrega = converte.dateToString(pedidoSaida.getDtEntrega());
	}
	String anotacao = pedidoSaida.getAnotacao();
	String hrEntrega = "";
	if (pedidoSaida.getHrEntrega() != null) {
		hrEntrega = pedidoSaida.getHrEntrega();
	}
	if (hrEntrega == null)
		hrEntrega = "";
	if (anotacao == null)
		anotacao = "";
	String observacao = pedidoSaida.getObservacao();
	if (observacao == null)
		observacao = "";
	double valorTotal = pedidoSaida.getVlPed();
	float desconto = pedidoSaida.getVlDesc();
	//float total = daoPedidoSaida.valorTotal(Integer.parseInt(idPedidoSaida));
	float total = 0.0f;
	CondPagto condPagto = null;
	CondPagtoDAO daoCondPagto = new CondPagtoDAO(conn);
	condPagto = daoCondPagto.procurarCondPagto(pedidoSaida.getCdCondPagto());

	StringBuffer textoBobina = new StringBuffer();

	// Recuperando os dados do cliente e nr do pedido
	textoBobina.append("      Pedido de Venda N. ").append("00" + idPedidoSaida).append("\n");
	textoBobina.append("========================================\n");
	textoBobina.append("Operador...: ").append((String) pedidoSaida.getUsuario()).append("\n");
	textoBobina.append("Dt Pedido..: ").append(dtPed).append("\n");
	textoBobina.append("Impressao..: ").append(Utilitaria.dateString(new java.util.Date(),
			"dd/MM/yyyy HH:mm")).append("\n");
	textoBobina.append("------------DADOS DA EMPRESA------------\n");
	textoBobina.append(Utilitaria.abreviarStr(lojaListar.getRazaoSocial(), 40)).append("\n");
	if (lojaListar.getEndereco() != null) {
		textoBobina.append(Utilitaria.abreviarStr(lojaListar.getEndereco(), 40)).append("\n");
		textoBobina.append(lojaListar.getBairro() + " - CEP:"
				+ lojaListar.getCep()).append("\n");
		textoBobina.append(lojaListar.getCidade() + " - "
				+ lojaListar.getEstado()).append("\n");
		textoBobina.append("Tel.: ").append(lojaListar.getNroTelefone()).append("\n");
	} else {
		textoBobina.append("Sem endereco de entrega definido.\n");
	}
	//textoBobina.append("CNPJ: ").append(lojaListar.getCnpj()).append("\n");

	textoBobina.append("------------DADOS DO CLIENTE------------\n");
	textoBobina.append(Utilitaria.abreviarStr(dsEntidade, 40)).append("\n");
	textoBobina.append(Utilitaria.abreviarStr(endereco, 40)).append("\n");
	textoBobina.append(Utilitaria.abreviarStr(cmpEndereco, 40)).append("\n");
	textoBobina.append(Utilitaria.abreviarStr(bairro, 40)).append("\n");
	textoBobina.append("Tel.:").append(telefone).append("\n");
	textoBobina.append("Ref.:" + Utilitaria.abreviarStr(anotacao, 35)).append("\n");
	textoBobina.append("========================================\n");
	textoBobina.append("PRODUTO            QTD. Vl.Unit Vl.Total\n");
	textoBobina.append("========================================\n");

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

	daoPedidoSaidaItem = new PedidoSaidaSubItemDAO(conn);
	daoPedidoSaidaSubItens = new PedidoSaidaSubItensDAO(conn);
	list = daoPedidoSaidaItem.procurarPedidoSaidaItem(Integer.parseInt(idPedidoSaida));
	boolean priItemOk = true;
	boolean subItemOk = false;
	if (list != null) {
		for (Iterator it = list.iterator(); it.hasNext();) {
	if (!priItemOk) {
		textoBobina.append("----------------------------------------\n");
	} else {
		priItemOk = false;
	}
	pedidoSaidaItem = (PedidoSaidaSubItem) it.next();
	float precoItem = pedidoSaidaItem.getVlUni() * pedidoSaidaItem.getQuant();
	total = total + precoItem;

	listSubItens = daoPedidoSaidaSubItens.listarPedidoSaidaSubItensListCompProduto(pedidoSaidaItem.getIdPedidoSaidaItem());
	subItemOk = false;
	if (listSubItens != null) {
		for (Iterator itSubItens = listSubItens.iterator(); itSubItens.hasNext();) {
			pedidoSubItens = (PedidoSaidaSubItens) itSubItens.next();
			daoProdutoSubItens = new ProdutoDAO(conn);
			prodSubItens = daoProdutoSubItens.procurarProduto(pedidoSubItens.getIdProduto());
			daoEstoqueSubItens = new EstoqueDAO(conn);
			listarEstoqueSubItens = daoEstoqueSubItens.procurarEstoquePreco(prodSubItens.getIdProduto(),
							Integer.parseInt(idLojaUsuario));
			if (listarEstoqueSubItens != null) {
				for (Iterator itListarSubItens = listarEstoqueSubItens.iterator(); itListarSubItens.hasNext();) {
					//cont++;
					estoqueSubList = (Estoque) itListarSubItens.next();
					LojaDAO lojaSubItens = new LojaDAO(conn);
					Loja lojaEstoqueSubItens = lojaSubItens.procurarLoja(estoqueSubList.getIdLoja());
					PrecoDAO daoPrecoListarSubItens = new PrecoDAO(conn);
					Preco precoListarSubList = daoPrecoListarSubItens.procurarPrecoEstoque(estoqueSubList.getIdEstoque());
					if (precoListarSubList != null) {
						//preco = Utilitaria.formatarNumero(precoListar.getPreco(), 2).toString();
						preco = Utilitaria.formatarNumero(pedidoSubItens.getVlUni(), 2).toString();
						UnidadeDAO daoUnidadeSubList = new UnidadeDAO(conn);
						Unidade unidadeListarSubList = daoUnidadeSubList.procurarUnidade(precoListarSubList.getIdUnidade());
						if (pedidoSubItens.getDsCompProduto() == null) {
							descricao = Utilitaria.abreviarStr(prodSubItens.getDsProduto(),	19).trim();
						} else {
							descricao = Utilitaria.abreviarStr(prodSubItens.getDsProduto(),	19).trim() + " " +
													Utilitaria.abreviarStr(pedidoSubItens.getDsCompProduto(),	19).trim();
						}
						if (descricao.trim().length()>20) {
							textoBobina.append(cb(descricao.substring(0,19), 20)
									+ cb(Utilitaria.formatarNumero(pedidoSubItens.getQuant(),	0), 4)
									+ "\n");
							textoBobina.append(cb(descricao.substring(20), 20)
									+ "\n");
						} else {
							textoBobina.append(cb(descricao, 20)
									+ cb(Utilitaria.formatarNumero(pedidoSubItens.getQuant(),	0), 4)
									+ "\n");
						}
						subItemOk = true;
					}
				}

			}
		}
	}
	if (!subItemOk) {
		daoProdutoSubItens = new ProdutoDAO(conn);
		prodSubItens = daoProdutoSubItens.procurarProduto(pedidoSaidaItem.getIdProduto());
		//textoBobina.append(cb(Utilitaria.abreviarStr(prodSubItens.getDsProduto(),	35), 36)
		//		+ cb(Utilitaria.formatarNumero(pedidoSaidaItem.getQuant(),	0), 4)
		//		+ "\n");
		if (pedidoSaidaItem.getDsCompProduto() == null) {
			descricao = Utilitaria.abreviarStr(prodSubItens.getDsProduto(),	19).trim();
		} else {
			descricao = Utilitaria.abreviarStr(prodSubItens.getDsProduto(),	19).trim() + " " +
									Utilitaria.abreviarStr(pedidoSaidaItem.getDsCompProduto(),	19).trim();
		}
		if (descricao.trim().length()>20) {
			textoBobina.append(cb(descricao.substring(0,19), 20)
				+ cb(Utilitaria.formatarNumero(pedidoSaidaItem.getQuant(),	0), 4)
				+ cb(Utilitaria.formatarNumero(pedidoSaidaItem.getVlUni(),	2), 8)
				+ cb(Utilitaria.formatarNumero(pedidoSaidaItem.getQuant()*pedidoSaidaItem.getVlUni(),	2), 8)
				+ "\n");
			textoBobina.append(cb(descricao.substring(20), 20)
				+ "\n");
		} else {
			textoBobina.append(cb(descricao, 20)
				+ cb(Utilitaria.formatarNumero(pedidoSaidaItem.getQuant(),	0), 4)
				+ cb(Utilitaria.formatarNumero(pedidoSaidaItem.getVlUni(),	2), 8)
				+ cb(Utilitaria.formatarNumero(pedidoSaidaItem.getQuant()*pedidoSaidaItem.getVlUni(),	2), 8)
				+ "\n");
		}
	}
	//if (!pedidoSaidaItem.getDsCompProduto().isEmpty()) {
	//	textoBobina.append(Utilitaria.abreviarStr(pedidoSaidaItem.getDsCompProduto(), 40)	+ "\n");
	//}
	
		}
	}

	textoBobina.append("-----------------PAGAMENTO--------------\n");
	textoBobina.append("TOTAL DO PEDIDO(R$):-->" + Utilitaria.formatarNumero(total, 2)).append("\n");
	textoBobina.append("DESCONTO(%)        :-->" + Utilitaria.formatarNumero(desconto, 2)).append("\n");
	textoBobina.append("VALOR C/ DESC.(R$) :-->" + Utilitaria.formatarNumero(valorTotal, 2)).append("\n");
	textoBobina.append("TAXA DE ENTREGA(R$):-->" + Utilitaria.formatarNumero(valorEntrega, 2)).append("\n");
	valorTotal+=valorEntrega;
	textoBobina.append("VALOR TOTAL(R$)    :-->" + Utilitaria.formatarNumero((valorTotal), 2)).append("\n");
	textoBobina.append("\n");
//	textoBobina.append("Cond.Pagto.:" + condPagto.getDsCondPagto() + "\n");
	textoBobina.append("OBS / TROCO:" + Utilitaria.abreviarStr(observacao, 30)).append("\n");
	textoBobina.append("\n");
	textoBobina.append("\n");
	textoBobina.append("     " + "______________________________" + "     ").append("\n");
	textoBobina.append("     " + Utilitaria.abreviarStr(dsEntidade.toUpperCase(),	30)).append("\n");
	textoBobina.append("========================================\n");
	textoBobina.append("     Aplicativo " + IDadosSistema.Sis_nom	+ " - Ver.: " + IDadosSistema.Sis_ver + "\n");
	textoBobina.append("========================================\n");
	textoBobina.append("           AJUSOFT / SEBRAETEC          \n");
	textoBobina.append("\n");

%>

 <table>
   <tr>
      <td align="center"><a href="javascript:window.print();">Imprimir</a></td>
   </tr>
 </table>
<pre style="font-size: 12pt; font-weight: bold;" id="texto_bobina">
<%=textoBobina.toString()%>
<%--<%bobina.Impressao(textoBobina.toString());--%>
<%--<%=bobina.ImpLine(textoBobina.toString())--%>
<%--<%bobina.imprimirTextoBobina(textoBobina.toString())--%>
</pre>
</body></html>
<%-- Fim do Conteúdo da Página --%>
<%@include file="../../fimConexao.jsp"%>