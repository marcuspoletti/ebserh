<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.PedidoSaida" %>
<%@ page import="afero.model.Entrega" %>
<%@ page import="afero.model.Orcamento" %>
<%@ page import="afero.model.Entidade" %>
<%@ page import="afero.model.EntidadeContato" %>
<%@ page import="afero.persistence.OrcamentoDAO" %>
<%@ page import="afero.persistence.EntidadeContatoDAO" %>
<%@ page import="afero.model.EntidadeFisica" %>
<%@ page import="afero.model.EntidadeContato" %>
<%@ page import="afero.model.EntidadeTelefone" %>
<%@page import="afero.model.TipoLogradouro"%>
<%@ page import="afero.model.EntidadeJuridica" %>
<%@ page import="afero.model.EntidadeEndereco" %>
<%@ page import="afero.persistence.EntidadeFisicaDAO" %>
<%@ page import="afero.persistence.EntidadeJuridicaDAO" %>
<%@ page import="afero.persistence.EntidadeEnderecoDAO" %>
<%@page import="afero.persistence.TipoLogradouroDAO"%>
<%@ page import="afero.persistence.EntregaDAO" %>
<%@ page import="afero.persistence.EntidadeDAO" %>
<%@ page import="afero.persistence.OrdemServicoDAO" %>
<%@ page import="afero.persistence.EntidadeTelefoneDAO" %>
<%@ page import="afero.persistence.PedidoSaidaDAO" %>
<%@page import="afero.util.Utilitaria"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Date" %>
<%@ page import="afero.util.ConverteDate" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>


function localizar() {
  document.forms[0].submit();
}  

function novaPesquisa() {
  document.all.nomeEntidade.value = '';
  document.all.status.value = ''; //não está limpando
  document.forms[0].submit();
}  
</script>

<%
String idLoja = request.getParameter("idLoja");
ConverteDate converte = new ConverteDate();
PedidoSaidaDAO dao = null;
String nomeEntidade = request.getParameter("nomeEntidade");
String acao = request.getParameter("acao");
String dataIni = request.getParameter("dataIni");
String dataFim = request.getParameter("dataFim");
String idMotorista = request.getParameter("idMotorista");
String idEntregador = request.getParameter("idEntregador");
String status =request.getParameter("status");
String clausula = "";

clausula = " WHERE ps.idEntrega <> 1 AND ps.status = '"+status+"' AND ps.dtEntrega BETWEEN '"+converte.DMYToYMDI(dataIni)+" 00:00:00' AND '"+converte.DMYToYMDI(dataFim)+" 23:59:59'"; 
    
if(!idLoja.equalsIgnoreCase("0")){
	clausula = clausula + " AND ps.idLoja = " + Integer.parseInt(idLoja);
}
if(!idMotorista.equalsIgnoreCase("0")){
	clausula = clausula + " AND idMotorista = "+Integer.parseInt(idMotorista);
}
if(!idEntregador.equalsIgnoreCase("0")){
	clausula = clausula + " AND idEntregador = "+Integer.parseInt(idEntregador);
}
//seleciona todos os registros do banco de dados
List list;
dao = new PedidoSaidaDAO(conn);
clausula = clausula+" ORDER BY ps.dtEntrega desc";
list = dao.listarPedidoSaida(clausula);

int cont = 0;
%>
<body onload="document.forms[0].elements[0].focus();" >

<%-- mostra todos os registros do banco de dados --%>
<table border="0" width="100%">
    <tr>
      <th class="grid" width="2%">&nbsp;</th>
      <th class="grid" width="2%"><center>Número do Orçamento</center></th>
      <th class="grid" width="2%"><center>Pedido</center></th>
      <th class="grid" width="5%"><center>Nome do Cliente</center></th>
      <th class="grid" width="5%"><center>Endereço</center></th>
      <th class="grid" width="5%"><center>Telefone</center></th>
      <th class="grid" width="5%"><center>Vl. Entrega R$</center></th>
      <th class="grid" width="5%"><center>Valor R$</center></th>
      <th class="grid" width="2%">Status</th>
    </tr>
<%
int numOrcamento = 0;
String dsStatus = "";
double valorTotal = 0.0;
double valorTotalEntrega = 0.0;
List listarTelefone;
String dsLogradouro = "";
String endereco = "";
String cmpEndereco = "";
String cep = "";
String bairro ="";
String referencia = "";
String tel = "";
String contato = "";
//Utiliza o ResultSet para trazer os registros do banco de dados
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	PedidoSaida pedidoSaida = (PedidoSaida) it.next();
	PedidoSaida pedSaida = dao.procurarPedidoSaida(pedidoSaida.getIdPedidoSaida());
	numOrcamento = dao.getIdOrcamento(pedidoSaida.getIdPedidoSaida());
	EntidadeDAO daoEntidade = new EntidadeDAO(conn);
	Entrega entrega = new Entrega();
	EntregaDAO daoEntrega = new EntregaDAO(conn);
	entrega = daoEntrega.procurarEntrega(pedSaida.getIdEntrega());
	Entidade entidade = null;
	entidade = daoEntidade.procurarEntidade(pedSaida.getCdEntidade());
	if(entidade.getTpInsc().equalsIgnoreCase("F")){
		TipoLogradouroDAO logradouro = new TipoLogradouroDAO(conn);
		EntidadeEndereco entidadeEndereco = null;
		EntidadeEnderecoDAO daoEntidadeEndereco= new EntidadeEnderecoDAO(conn);
		entidadeEndereco = daoEntidadeEndereco.procurarEntidadeEnderecoPadrao(entidade.getCdEntidade());
		EntidadeTelefoneDAO daoEntidadeFone = new EntidadeTelefoneDAO(conn);
		EntidadeTelefone entidadeFone = null;
		listarTelefone = daoEntidadeFone.listarTelefone(entidade.getCdEntidade());
		for ( Iterator itTelefone = listarTelefone.iterator(); itTelefone.hasNext(); ) {
			entidadeFone = (EntidadeTelefone) itTelefone.next();
			if(entidadeFone.getNroTelefone() != null){
				
					tel += entidadeFone.getNroTelefone() + " / ";
			}
		}
		TipoLogradouro logra = logradouro.procurarTipoLogradouro(entidadeEndereco.getCdTipoLogradouro());
		dsLogradouro = logra.getDsTipoLogradouro();
		endereco = dsLogradouro + " " +entidadeEndereco.getDsEndereco() + " " +"nº"+ " "+entidadeEndereco.getNroEndereco();
		cmpEndereco = entidadeEndereco.getCmpEndereco();
		cep = entidadeEndereco.getCepEndereco();
		bairro =entidadeEndereco.getBaiEndereco();
		referencia = entidadeEndereco.getRefEndereco();
	}else if(entidade.getTpInsc().equalsIgnoreCase("J")){
		//EntidadeJuridica entidadeJ = (EntidadeJuridica) it.next();
		nomeEntidade = entidade.getNome();
		TipoLogradouroDAO logradouro = new TipoLogradouroDAO(conn);
		EntidadeEndereco entidadeEndereco = null;
		EntidadeContatoDAO contatoDAO = new EntidadeContatoDAO(conn);
		if(contatoDAO.pesquisarEntidadeContato(entidade.getCdEntidade())){
		 EntidadeContato entidadeContato = contatoDAO.procurarEntidadeContato(entidade.getCdEntidade());
		 contato = entidadeContato.getNmContato();
		}
		if(contato == null)contato="";
		EntidadeEnderecoDAO daoEntidadeEndereco= new EntidadeEnderecoDAO(conn);
		entidadeEndereco = daoEntidadeEndereco.procurarEntidadeEnderecoPadrao(entidade.getCdEntidade());
		EntidadeTelefoneDAO daoEntidadeFone = new EntidadeTelefoneDAO(conn);
		EntidadeTelefone entidadeFone = null;
		listarTelefone = daoEntidadeFone.listarTelefone(entidade.getCdEntidade());
		int contador = 0;
		for ( Iterator itTelefone = listarTelefone.iterator(); itTelefone.hasNext(); ) {
			entidadeFone = (EntidadeTelefone) itTelefone.next();
			if(entidadeFone.getNroTelefone() != null){
				contador++;
				if(contador <= 2){
					tel += " " +entidadeFone.getNroTelefone();
				}
			}
		}
		TipoLogradouro logra = logradouro.procurarTipoLogradouro(entidadeEndereco.getCdTipoLogradouro());
		dsLogradouro = logra.getDsTipoLogradouro();
		endereco = dsLogradouro + " " +entidadeEndereco.getDsEndereco() + " " +"nº"+ " "+entidadeEndereco.getNroEndereco();
		cmpEndereco = entidadeEndereco.getCmpEndereco();
		cep = entidadeEndereco.getCepEndereco();
		bairro =entidadeEndereco.getBaiEndereco();
		referencia = entidadeEndereco.getRefEndereco();
		if(cep == null)cep="";
		if(bairro == null)bairro="";
		
	}
	cont++;
	if(pedSaida.getStatus().equalsIgnoreCase("A")){
		dsStatus="Atendido";
	}else if(pedSaida.getStatus().equalsIgnoreCase("P")){
		dsStatus="Pendente";
	}else if(pedSaida.getStatus().equalsIgnoreCase("F")){
		dsStatus="Faturado";
	}else if(pedSaida.getStatus().equalsIgnoreCase("C")){
		dsStatus="Cancelado";
	}
    valorTotal = valorTotal + (pedSaida.getVlPed());
    valorTotalEntrega = valorTotalEntrega + (entrega.getTxEntrega());
%>
    
   <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <%if(numOrcamento == 0){ %>
      	<td class = "grid" width="2%"><font color="red"><center><%="PEDIDO"%></center></font></td>
      <%}else{ %>
      	 <td class = "grid" width="2%"><center><%=numOrcamento%></center></td>
      <%} %>
      <td class = "grid" width="2%"><center><a target="_blank" href="exibirPedido.jsp?idPedidoSaida=<%=pedSaida.getIdPedidoSaida()%>"><%=pedSaida.getIdPedidoSaida()%></a></center></td>
      <td class = "grid" width="30%"><center><%=entidade.getNome()%></center></td>
      <td class = "grid" width="30%"><center><%=endereco +" Bairro: "+bairro + " Cep:"+cep%></center></td>
      <td class = "grid" width="30%"><center><%=tel%></center></td>
      <td class = "grid" width="5%"><center><%=Utilitaria.formatarNumero(entrega.getTxEntrega(),2)%></center></td>
      <td class = "grid" width="5%"><center><%=Utilitaria.formatarNumero(pedSaida.getVlPed(),2)%></center></td>
      <td class = "grid" width="3%"><font color="red"><center><%=dsStatus%></center></font></td>
  </tr>
<%
       tel = "";
}
%>      
</table>
<table border="0" width="100%">
<tr>
<th class="grid"><center>Valor Total Entrega</center></th>
<td class="grid"><center><font color="red"><b><%=Utilitaria.formatarNumero(valorTotalEntrega,2)%></b></font></center></td>
<th class="grid"><center>Valor Total</center></th>
<td class="grid"><center><font color="red"><b><%=Utilitaria.formatarNumero(valorTotal,2)%></b></font></center></td>
</tr>
</table>
<%@include file="../fimConexao.jsp"%>