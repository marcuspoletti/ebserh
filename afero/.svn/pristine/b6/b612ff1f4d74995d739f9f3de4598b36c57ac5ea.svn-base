<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@page import="afero.model.Colaborador"%>
<%@page import="afero.model.Estoque"%>
<%@page import="afero.model.Loja"%>
<%@page import="afero.model.Preco"%>
<%@page import="afero.model.Usuario"%>
<%@page import="afero.model.Produto"%>
<%@page import="afero.model.PedidoSaidaSub"%>
<%@page import="afero.model.PedidoSaidaSubItem"%>
<%@page import="afero.persistence.PedidoSaidaSubDAO"%>
<%@page import="afero.persistence.PedidoSaidaSubItemDAO"%>
<%@page import="afero.persistence.UsuarioDAO"%>
<%@page import="afero.persistence.EstoqueDAO"%>
<%@page import="afero.persistence.PrecoDAO"%>
<%@page import="afero.persistence.ColaboradorDAO"%>
<%@page import="afero.persistence.ProdutoDAO"%>
<%@page import="afero.persistence.LojaDAO"%>
<%@ page import="afero.model.Mesa" %>
<%@ page import="afero.persistence.MesaDAO" %>
<%@page import ="java.util.*" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<html>
<body>
<%
String mensagem = "";

boolean garcomOk;
if(request.getParameter("garcomOk")!= null){
	garcomOk = Boolean.parseBoolean(request.getParameter("garcomOk"));
}else{
  garcomOk = true;
}
boolean senhaGarcomOk;
if(request.getParameter("senhaGarcomOk") != null){
	senhaGarcomOk = Boolean.parseBoolean(request.getParameter("senhaGarcomOk"));
}else{
	senhaGarcomOk=false;
}
boolean mesaOk;
if(request.getParameter("mesaOk") != null){
	mesaOk = Boolean.parseBoolean(request.getParameter("mesaOk"));
}else{
	mesaOk=false;
}
boolean produtoOk;
if(request.getParameter("produtoOk") != null){
	produtoOk = Boolean.parseBoolean(request.getParameter("produtoOk"));
}else{
	produtoOk=false;
}
boolean quantOk;
if(request.getParameter("quantOk") != null){
	quantOk = Boolean.parseBoolean(request.getParameter("quantOk"));
}else{
	quantOk=false;
}
String idLoja = (String)session.getAttribute("idLoja");
String idPedidoSaida = request.getParameter("idPedidoSaida");
if(idPedidoSaida == null)idPedidoSaida = "0";
String user = (String)session.getAttribute("Login");
String comandoGarcom = request.getParameter("comandoGarcom");
//if(comandoGarcom == null)comandoGarcom=null;
String comandoGarcomSenha = request.getParameter("comandoGarcomSenha");
//if(comandoGarcomSenha == null)comandoGarcomSenha=null;
String comandoMesa = request.getParameter("comandoMesa");
String comandoProduto = request.getParameter("comandoProduto");
String comandoQuant = request.getParameter("comandoQuant");
//if(comandoMesa == null)comandoMesa=null;
String comando = "N";
if(request.getParameter("comando") != null){
   comando = request.getParameter("comando");	
}
if(comando.length() == 0)comando="N";
String garcom = request.getParameter("garcom");
String mesaDesc = request.getParameter("mesa");
if(mesaDesc == null)mesaDesc="";
String idMesa = request.getParameter("idMesa");
if(idMesa == null)idMesa="0";
if(garcom == null)garcom="";
String idGarcom = request.getParameter("idGarcom");
if(idGarcom == null)idGarcom="0";
String idProduto = request.getParameter("idProduto");
if(idProduto == null)idProduto="0";
String quantProduto = request.getParameter("quantProduto");
if(quantProduto == null)quantProduto="0";
Produto produto = null;

if(!comando.equalsIgnoreCase("N")){
if(comando != null && garcomOk){
   comandoGarcom = comando;
}
if(comandoGarcom != null && garcomOk){
	ColaboradorDAO dao = new ColaboradorDAO(conn);
	Colaborador colaborador = null;
	if(dao.existeIdColaboradorPedido(Integer.parseInt(comandoGarcom))){
	    colaborador = dao.procurarColaborador(Integer.parseInt(comandoGarcom));
	    idGarcom = "".valueOf(colaborador.getIdColaborador());
	    garcom = colaborador.getApelido();
	    mensagem = " DIGITE A SENHA. ";
		response.sendRedirect("front.jsp?produtoOk="+produtoOk+"&comandoProduto="+comandoProduto+"&quantOk="+quantOk+"&comandoQuant="+comandoQuant+"&idGarcom="+idGarcom+"&idMesa="+idMesa+"&mesa="+mesaDesc+"&garcom="+garcom+"&comandoMesa="+comandoMesa+"&comandoGarcomSenha="+comandoGarcomSenha+"&comandoGarcom="+comandoGarcom+"&mensagem="+mensagem+"&garcomOk="+garcomOk+"&senhaGarcomOk="+senhaGarcomOk+"&mesaOk="+mesaOk);
		
	}else if(!dao.existeIdColaboradorPedido(Integer.parseInt(comandoGarcom))){
		comandoGarcom = "N";
		mensagem = " GARÇOM INEXISTENTE. ";
		response.sendRedirect("front.jsp?produtoOk="+produtoOk+"&comandoProduto="+comandoProduto+"&quantOk="+quantOk+"&comandoQuant="+comandoQuant+"&idGarcom="+idGarcom+"&idMesa="+idMesa+"&mesa="+mesaDesc+"&garcom="+garcom+"&comandoMesa="+comandoMesa+"&comandoGarcomSenha="+comandoGarcomSenha+"&comandoGarcom="+comandoGarcom+"&mensagem="+mensagem+"&garcomOk="+garcomOk+"&senhaGarcomOk="+senhaGarcomOk+"&mesaOk="+mesaOk);
		
	}
}else if(garcomOk){
	mensagem = " FALTA DIGITAR O CÓDIGO DO GARÇOM. ";
	comandoGarcom ="N";
	response.sendRedirect("front.jsp?produtoOk="+produtoOk+"&comandoProduto="+comandoProduto+"&quantOk="+quantOk+"&comandoQuant="+comandoQuant+"&idGarcom="+idGarcom+"&idMesa="+idMesa+"&mesa="+mesaDesc+"&garcom="+garcom+"&comandoMesa="+comandoMesa+"&comandoGarcomSenha="+comandoGarcomSenha+"&comandoGarcom="+comandoGarcom+"&mensagem="+mensagem+"&garcomOk="+garcomOk+"&senhaGarcomOk="+senhaGarcomOk+"&mesaOk="+mesaOk);
	garcomOk = true;
	
	
}
if(comandoGarcom != null && senhaGarcomOk){
	comandoGarcomSenha = comando;
}
if(comandoGarcomSenha != null && senhaGarcomOk){
	ColaboradorDAO dao = new ColaboradorDAO(conn);
	Colaborador colaborador = dao.procurarColaborador(Integer.parseInt(comandoGarcom));
	idGarcom = "".valueOf(colaborador.getIdColaborador());
	garcom = colaborador.getApelido();
	UsuarioDAO usuarioDAO = new UsuarioDAO(conn);
	Usuario usuario = usuarioDAO.procurarUsuario(colaborador.getIdUsuario());
	if(comandoGarcomSenha.equalsIgnoreCase(usuario.getSenha())){
		mensagem = " DIGITE A MESA. ";
		response.sendRedirect("front.jsp?produtoOk="+produtoOk+"&comandoProduto="+comandoProduto+"&quantOk="+quantOk+"&comandoQuant="+comandoQuant+"&idGarcom="+idGarcom+"&idMesa="+idMesa+"&mesa="+mesaDesc+"&garcom="+garcom+"&comandoMesa="+comandoMesa+"&comandoGarcomSenha="+comandoGarcomSenha+"&comandoGarcom="+comandoGarcom+"&mensagem="+mensagem+"&garcomOk="+garcomOk+"&senhaGarcomOk="+senhaGarcomOk+"&mesaOk="+mesaOk);
	}else{
		mensagem = " SENHA INCORRETA !!! ";
		comandoGarcomSenha = "N";
		response.sendRedirect("front.jsp?produtoOk="+produtoOk+"&comandoProduto="+comandoProduto+"&quantOk="+quantOk+"&comandoQuant="+comandoQuant+"&idGarcom="+idGarcom+"&idMesa="+idMesa+"&mesa="+mesaDesc+"&garcom="+garcom+"&comandoMesa="+comandoMesa+"&comandoGarcomSenha="+comandoGarcomSenha+"&comandoGarcom="+comandoGarcom+"&mensagem="+mensagem+"&garcomOk="+garcomOk+"&senhaGarcomOk="+senhaGarcomOk+"&mesaOk="+mesaOk);
		
	}
}else if(senhaGarcomOk){
	mensagem = " FALTA DIGITAR A SENHA DO GARÇOM. ";
	comandoGarcomSenha = "N";
	response.sendRedirect("front.jsp?produtoOk="+produtoOk+"&comandoProduto="+comandoProduto+"&quantOk="+quantOk+"&comandoQuant="+comandoQuant+"&idGarcom="+idGarcom+"&idMesa="+idMesa+"&mesa="+mesaDesc+"&garcom="+garcom+"&comandoMesa="+comandoMesa+"&comandoGarcomSenha="+comandoGarcomSenha+"&comandoGarcom="+comandoGarcom+"&mensagem="+mensagem+"&garcomOk="+garcomOk+"&senhaGarcomOk="+senhaGarcomOk+"&mesaOk="+mesaOk);
	
}
if(comandoGarcomSenha != null && mesaOk){
	comandoMesa = comando;
}
if(comandoMesa != null && mesaOk){
	MesaDAO daoMesa = new MesaDAO(conn);
	if(daoMesa.existeIdMesa(Integer.parseInt(comandoMesa))){
		Mesa mesa = daoMesa.procurarMesa(Integer.parseInt(comandoMesa));
		PedidoSaidaSubDAO daoPedidoSaida = new PedidoSaidaSubDAO(conn);
		PedidoSaidaSub pedidoSaida = new PedidoSaidaSub();
		mesaDesc = mesa.getDsMesa();
		idMesa = "".valueOf(mesa.getIdMesa());
		if(mesa.getStatus().equalsIgnoreCase("I")){
			mensagem = " MESA ESTA INATIVA. ";
			comandoMesa = "N";
			response.sendRedirect("front.jsp?produtoOk="+produtoOk+"&comandoProduto="+comandoProduto+"&quantOk="+quantOk+"&comandoQuant="+comandoQuant+"&idGarcom="+idGarcom+"&idMesa="+idMesa+"&mesa="+mesaDesc+"&garcom="+garcom+"&comandoMesa="+comandoMesa+"&comandoGarcomSenha="+comandoGarcomSenha+"&comandoGarcom="+comandoGarcom+"&mensagem="+mensagem+"&garcomOk="+garcomOk+"&senhaGarcomOk="+senhaGarcomOk+"&mesaOk="+mesaOk);
		}else if(mesa.getStatus().equalsIgnoreCase("R") || mesa.getStatus().equalsIgnoreCase("L")){
			daoMesa.atualizarStatus(Integer.parseInt(idMesa), "A");
			pedidoSaida.setCdEntidade(1);
			pedidoSaida.setIdEntrega(1);
			pedidoSaida.setIdLoja(Integer.parseInt(idLoja));
			pedidoSaida.setIdColaborador(Integer.parseInt(idGarcom));
			pedidoSaida.setStatus("P");
			pedidoSaida.setTipoPedido("PM");
			pedidoSaida.setOperacao("S");
			pedidoSaida.setStatusPag("N");
			pedidoSaida.setUsuario(user);
			pedidoSaida.setImpPedido("N");
			pedidoSaida.setAnotacao("");
			pedidoSaida.setObservacao("");
			pedidoSaida.setHrEntrega("00:00");
			pedidoSaida.setPessoaResponsavel("");
			daoPedidoSaida.incluir(pedidoSaida);
			idPedidoSaida = "".valueOf(daoPedidoSaida.idPedidoSaida());
			daoPedidoSaida.atualizarMesaPedido(Integer.parseInt(idPedidoSaida), Integer.parseInt(idMesa));
			daoPedidoSaida.atualizarTipoPedido(Integer.parseInt(idPedidoSaida), pedidoSaida.getTipoPedido());
			mensagem = " DIGITE O CÓDIGO DO PRODUTO ";
			response.sendRedirect("front.jsp?idPedidoSaida="+idPedidoSaida+"&produtoOk="+produtoOk+"&comandoProduto="+comandoProduto+"&quantOk="+quantOk+"&comandoQuant="+comandoQuant+"&idGarcom="+idGarcom+"&idMesa="+idMesa+"&mesa="+mesaDesc+"&garcom="+garcom+"&comandoMesa="+comandoMesa+"&comandoGarcomSenha="+comandoGarcomSenha+"&comandoGarcom="+comandoGarcom+"&mensagem="+mensagem+"&garcomOk="+garcomOk+"&senhaGarcomOk="+senhaGarcomOk+"&mesaOk="+mesaOk);
		}else if(mesa.getStatus().equalsIgnoreCase("A") || mesa.getStatus().equalsIgnoreCase("C")){
			mensagem = " DIGITE O CÓDIGO DO PRODUTO ";
			pedidoSaida = daoPedidoSaida.procurarMesa(Integer.parseInt(idMesa));
			response.sendRedirect("front.jsp?idPedidoSaida="+pedidoSaida.getIdPedidoSaida()+"&produtoOk="+produtoOk+"&comandoProduto="+comandoProduto+"&quantOk="+quantOk+"&comandoQuant="+comandoQuant+"&idGarcom="+idGarcom+"&idMesa="+idMesa+"&mesa="+mesaDesc+"&garcom="+garcom+"&comandoMesa="+comandoMesa+"&comandoGarcomSenha="+comandoGarcomSenha+"&comandoGarcom="+comandoGarcom+"&mensagem="+mensagem+"&garcomOk="+garcomOk+"&senhaGarcomOk="+senhaGarcomOk+"&mesaOk="+mesaOk);
		}
		
	}else{
		mensagem = " MESA INEXISTENTE. ";
		comandoMesa = "N";
		response.sendRedirect("front.jsp?produtoOk="+produtoOk+"&comandoProduto="+comandoProduto+"&quantOk="+quantOk+"&comandoQuant="+comandoQuant+"&idGarcom="+idGarcom+"&idMesa="+idMesa+"&mesa="+mesaDesc+"&garcom="+garcom+"&comandoMesa="+comandoMesa+"&comandoGarcomSenha="+comandoGarcomSenha+"&comandoGarcom="+comandoGarcom+"&mensagem="+mensagem+"&garcomOk="+garcomOk+"&senhaGarcomOk="+senhaGarcomOk+"&mesaOk="+mesaOk);
		
		
	}
	
}else if(mesaOk){
	mensagem = " FALTA DIGITAR A MESA. ";
	comandoMesa = "N";
	response.sendRedirect("front.jsp?produtoOk="+produtoOk+"&comandoProduto="+comandoProduto+"&quantOk="+quantOk+"&comandoQuant="+comandoQuant+"&idGarcom="+idGarcom+"&idMesa="+idMesa+"&mesa="+mesaDesc+"&garcom="+garcom+"&comandoMesa="+comandoMesa+"&comandoGarcomSenha="+comandoGarcomSenha+"&comandoGarcom="+comandoGarcom+"&mensagem="+mensagem+"&garcomOk="+garcomOk+"&senhaGarcomOk="+senhaGarcomOk+"&mesaOk="+mesaOk);
	
}
if(comandoMesa != null && produtoOk){
	comandoProduto = comando;
}
if(comandoProduto != null && produtoOk){
	ProdutoDAO daoProduto = new ProdutoDAO(conn);
	if(daoProduto.existeIdProduto(comandoProduto)){
		ColaboradorDAO dao = new ColaboradorDAO(conn);
		Colaborador colaborador = dao.procurarColaborador(Integer.parseInt(idGarcom));
		produto = daoProduto.procurarProdutoFront(comandoProduto, colaborador.getIdLoja());
		MesaDAO daoMesa = new MesaDAO(conn);
		Mesa mesa = daoMesa.procurarMesa(Integer.parseInt(comandoMesa));
		PedidoSaidaSubDAO daoPedidoSaida = new PedidoSaidaSubDAO(conn);
		PedidoSaidaSub pedidoSaida = new PedidoSaidaSub();
		pedidoSaida = daoPedidoSaida.procurarMesa(Integer.parseInt(idMesa));
		idMesa = "".valueOf(mesa.getIdMesa());
		mensagem = produto.getDsProduto().toUpperCase() + "DIGITE A QUANTIDADE";
		response.sendRedirect("front.jsp?idPedidoSaida="+pedidoSaida.getIdPedidoSaida()+"&produtoOk="+produtoOk+"&comandoProduto="+comandoProduto+"&quantOk="+quantOk+"&comandoQuant="+comandoQuant+"&idGarcom="+idGarcom+"&idMesa="+idMesa+"&mesa="+mesaDesc+"&garcom="+garcom+"&comandoMesa="+comandoMesa+"&comandoGarcomSenha="+comandoGarcomSenha+"&comandoGarcom="+comandoGarcom+"&mensagem="+mensagem+"&garcomOk="+garcomOk+"&senhaGarcomOk="+senhaGarcomOk+"&mesaOk="+mesaOk);
		
	}else if(comandoProduto.equalsIgnoreCase("99")){
		response.sendRedirect("front.jsp?produtoOk="+produtoOk+"&comandoProduto="+comandoProduto+"&quantOk="+quantOk+"&comandoQuant="+comandoQuant+"&idGarcom="+idGarcom+"&idMesa="+idMesa+"&mesa="+mesaDesc+"&garcom="+garcom+"&comandoMesa="+comandoMesa+"&comandoGarcomSenha="+comandoGarcomSenha+"&comandoGarcom="+comandoGarcom+"&mensagem="+mensagem+"&garcomOk="+garcomOk+"&senhaGarcomOk="+senhaGarcomOk+"&mesaOk="+mesaOk);
	
	}else{
		mensagem = " CÓDIGO DE PRODUTO INEXISTENTE. ";
		comandoProduto = "N";
		mesaOk = true;
		response.sendRedirect("front.jsp?produtoOk="+produtoOk+"&comandoProduto="+comandoProduto+"&quantOk="+quantOk+"&comandoQuant="+comandoQuant+"&idGarcom="+idGarcom+"&idMesa="+idMesa+"&mesa="+mesaDesc+"&garcom="+garcom+"&comandoMesa="+comandoMesa+"&comandoGarcomSenha="+comandoGarcomSenha+"&comandoGarcom="+comandoGarcom+"&mensagem="+mensagem+"&garcomOk="+garcomOk+"&senhaGarcomOk="+senhaGarcomOk+"&mesaOk="+mesaOk);
		
	}
}else if(produtoOk){
	mensagem = " FALTA DIGITAR O CÓDIGO DO PRODUTO. ";
	comandoProduto = "N";
	response.sendRedirect("front.jsp?produtoOk="+produtoOk+"&comandoProduto="+comandoProduto+"&quantOk="+quantOk+"&comandoQuant="+comandoQuant+"&idGarcom="+idGarcom+"&idMesa="+idMesa+"&mesa="+mesaDesc+"&garcom="+garcom+"&comandoMesa="+comandoMesa+"&comandoGarcomSenha="+comandoGarcomSenha+"&comandoGarcom="+comandoGarcom+"&mensagem="+mensagem+"&garcomOk="+garcomOk+"&senhaGarcomOk="+senhaGarcomOk+"&mesaOk="+mesaOk);
	
	
}
if(comandoProduto != null && quantOk){
	comandoQuant = comando;
}

if(comandoQuant != null && quantOk){
	if(comandoQuant.equalsIgnoreCase("99")){
		response.sendRedirect("front.jsp?produtoOk="+produtoOk+"&comandoProduto="+comandoProduto+"&quantOk="+quantOk+"&comandoQuant="+comandoQuant+"&idGarcom="+idGarcom+"&idMesa="+idMesa+"&mesa="+mesaDesc+"&garcom="+garcom+"&comandoMesa="+comandoMesa+"&comandoGarcomSenha="+comandoGarcomSenha+"&comandoGarcom="+comandoGarcom+"&mensagem="+mensagem+"&garcomOk="+garcomOk+"&senhaGarcomOk="+senhaGarcomOk+"&mesaOk="+mesaOk);
	
	}else{
		ColaboradorDAO dao = new ColaboradorDAO(conn);
		Colaborador colaborador = dao.procurarColaborador(Integer.parseInt(idGarcom));
		ProdutoDAO daoProduto = new ProdutoDAO(conn);
		Produto produtoPreco = daoProduto.procurarProdutoFront(comandoProduto, colaborador.getIdLoja());
		PrecoDAO daoPreco = new PrecoDAO(conn);
		Preco preco = daoPreco.procurarPrecoEstoqueLoja(produtoPreco.getIdProduto(), colaborador.getIdLoja());
		MesaDAO daoMesa = new MesaDAO(conn);
		Mesa mesa = daoMesa.procurarMesa(Integer.parseInt(comandoMesa));
		PedidoSaidaSubDAO pedidoSaida = new PedidoSaidaSubDAO(conn);
		PedidoSaidaSub pedido = pedidoSaida.procurarMesa(Integer.parseInt(comandoMesa));
		PedidoSaidaSubItem itemPedido = new PedidoSaidaSubItem();
		itemPedido.setIdProduto(produtoPreco.getIdProduto());
		itemPedido.setIdUnidade(preco.getIdUnidade());
		itemPedido.setIdPedidoSaida(pedido.getIdPedidoSaida());
		itemPedido.setImpProducao("S");
		itemPedido.setpDesc(0);
		itemPedido.setQuant(Float.parseFloat(comandoQuant));
		itemPedido.setUsuario(user);
		itemPedido.setValor(preco.getPreco());
		itemPedido.setVlUni(preco.getPreco());
		PedidoSaidaSubItemDAO daoItemPedido = new PedidoSaidaSubItemDAO(conn);
		daoItemPedido.incluir(itemPedido);
		//response.sendRedirect("itensPedido.jsp?idPedidoSaida="+pedido.getIdPedidoSaida()+"&produtoOk="+produtoOk+"&comandoProduto="+comandoProduto+"&quantOk="+quantOk+"&comandoQuant="+comandoQuant+"&idGarcom="+idGarcom+"&idMesa="+idMesa+"&mesa="+mesaDesc+"&garcom="+garcom+"&comandoMesa="+comandoMesa+"&comandoGarcomSenha="+comandoGarcomSenha+"&comandoGarcom="+comandoGarcom+"&mensagem="+mensagem+"&garcomOk="+garcomOk+"&senhaGarcomOk="+senhaGarcomOk+"&mesaOk="+mesaOk);
		mensagem = " DIGITE O CÓDIGO DO PRODUTO ";
		response.sendRedirect("front.jsp?idPedidoSaida="+pedido.getIdPedidoSaida()+"&produtoOk="+produtoOk+"&comandoProduto="+comandoProduto+"&quantOk="+quantOk+"&comandoQuant="+comandoQuant+"&idGarcom="+idGarcom+"&idMesa="+idMesa+"&mesa="+mesaDesc+"&garcom="+garcom+"&comandoMesa="+comandoMesa+"&comandoGarcomSenha="+comandoGarcomSenha+"&comandoGarcom="+comandoGarcom+"&mensagem="+mensagem+"&garcomOk="+garcomOk+"&senhaGarcomOk="+senhaGarcomOk+"&mesaOk="+mesaOk);
		mesaOk = true;
	}
	
}else if(quantOk){
	mensagem = " FALTA DIGITAR A QUANTIDADE DO PRODUTO. ";
	comandoQuant = "N";
	response.sendRedirect("front.jsp?produtoOk="+produtoOk+"&comandoProduto="+comandoProduto+"&quantOk="+quantOk+"&comandoQuant="+comandoQuant+"&idGarcom="+idGarcom+"&idMesa="+idMesa+"&mesa="+mesaDesc+"&garcom="+garcom+"&comandoMesa="+comandoMesa+"&comandoGarcomSenha="+comandoGarcomSenha+"&comandoGarcom="+comandoGarcom+"&mensagem="+mensagem+"&garcomOk="+garcomOk+"&senhaGarcomOk="+senhaGarcomOk+"&mesaOk="+mesaOk);
	
}
}else{
	response.sendRedirect("front.jsp");
}

%>
</body>
<%@include file="../fimConexao.jsp"%>
</html>