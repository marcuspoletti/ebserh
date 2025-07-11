<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.PedidosItens"%>
<%@ page import="afero.model.ClienteMaiorQuantVenda"%>
<%@ page import="afero.model.Entrega"%>
<%@ page import="afero.model.EntidadeFisica"%>
<%@ page import="afero.model.TipoLogradouro"%>
<%@ page import="afero.model.EntidadeEndereco"%>
<%@ page import="afero.model.EntidadeJuridica"%>
<%@ page import="afero.model.EntidadeTelefone"%>
<%@ page import="afero.model.Entidade"%>
<%@ page import="afero.persistence.EntregaDAO"%>
<%@ page import="afero.persistence.TipoLogradouroDAO"%>
<%@ page import="afero.persistence.EntidadeTelefoneDAO"%>
<%@ page import="afero.persistence.EntidadeEnderecoDAO"%>
<%@ page import="afero.persistence.EntidadeFisicaDAO"%>
<%@ page import="afero.persistence.EntidadeJuridicaDAO"%>
<%@ page import="afero.persistence.EntidadeDAO"%>
<%@ page import="afero.persistence.PedidoItensDAO" %>
<%@page import="afero.util.Utilitaria"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.Date"%>
<%@ page import="afero.util.ConverteDate"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script>
function recarregar() {
  document.forms[0].action='listagemTopClientes.jsp';
  document.forms[0].submit();
}
</script>
<%
String idLoja = (String)session.getAttribute("idLoja");
String quantClientes = "100";
if(request.getParameter("quantClientes") != null){
	quantClientes = request.getParameter("quantClientes");
}
String clausula = "";
String maiorMenorQuantidade = request.getParameter("maiorMenorQuantidade");
if(maiorMenorQuantidade == null)maiorMenorQuantidade ="desc";

ConverteDate converte = new ConverteDate();
PedidoItensDAO dao = null;
String dataIni = request.getParameter("dataIni");
String dataFim = request.getParameter("dataFim");
dao = new PedidoItensDAO(conn);
if (dataIni == null) {
 dataIni = dao.dataAtualPedido();
}
if (dataFim == null) {
  dataFim = dao.dataAtualPedido();
}
clausula = " WHERE ps.dtPed BETWEEN '"+converte.DMYToYMDI(dataIni)+" 00:00:00' AND '"+converte.DMYToYMDI(dataFim)+" 23:59:59' AND ps.status='A' AND e.status = 'A' AND ps.idLoja = " + Integer.parseInt(idLoja)+
           " GROUP BY e.cdEntidade ORDER BY count(ps.idPedidoSaida) "+maiorMenorQuantidade+" limit "+Integer.parseInt(quantClientes);
//seleciona todos os registros do banco de dados
List list = dao.listarClientesMaiorVenda(clausula);
%>
<h1 class="cabecalho_pagina">Top Clientes</h1>
<form action="listagemTopClientes.jsp" method="post">
<iframe width=174 height=189 name="gToday:normal:"../js/calendar/agenda.js"
            id="gToday:normal:"../js/calendar/agenda.js" src="../js/calendar/ipopeng.htm"
            scrolling="no" frameborder="0" style="visibility:visible; z-index:999; 
    position:absolute; top:-500px; left:-500px;">
</iframe>
<table border="0" width="100%">
    
     <tr>
      <td class='grid'>Quant. Clientes 
      <input type="text" name="quantClientes" value="<%=quantClientes%>"  size="4" maxlength="4"></td>
    </tr>
    <tr>
      <td class='grid'>Data Inicial 
	<input type="text" name="dataIni" size="15" value="<%= dataIni %>" onblur="chkData(this,'dd/MM/yyyy')" maxlength="10" class="inputs"><a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dataIni);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
      </td>
      <td class='grid'>Data Final 
	<input type="text"  name="dataFim" size="15" value="<%= dataFim %>" maxlength="10" onblur="chkData(this,'dd/MM/yyyy')" class="inputs"><a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dataFim);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
      </td>  
      
      <td class="label_radio"><input type="radio" class="radio" name="maiorMenorQuantidade" value="desc" <%= (maiorMenorQuantidade.equals("desc")? "checked": "") %>>Maior Quant.
      <input type="radio" class="radio" name="maiorMenorQuantidade" value="asc" <%= (maiorMenorQuantidade.equals("asc")? "checked": "") %>>Menor Quant.</td>    					  
    <td align="center">
        <input type="button" value="Atualizar" class="botao" onclick="recarregar();">
        <input type="button" value="Imprimir" class="botao" onclick="print();">
    </td>
    </tr>
    

</table>
<table border="0" width="100%">
    <tr>
      <th class="grid" width="2%">&nbsp;</th>
      <th class="grid" width="2%">Cód Cliente</th>
      <th class="grid" width="2%"><center>Nome</center></th>
      <th class="grid" width="2%"><center>Endereço</center></th>
      <th class="grid" width="2%"><center>Telefone</center></th>
     <th class="grid" width="2%"><center>Dt. Cadastro</center></th> 
      <th class="grid" width="2%">Quant. Pedido</th>
      <th class="grid" width="2%">Maior Valor Ped.</th>
      <th class="grid" width="2%">Total Valor Ped.</th>
      <th class="grid" width="2%">Dt. Último Ped.</th>
    </tr>
<%
int cont = 0;
String dsLogradouro = "";
String endereco = "";
String cmpEndereco = "";
String cep = "";
String bairro ="";
String referencia = "";
String cidadeUf = "";
String tel = "";
List listarTelefone;
for (Iterator it = list.iterator(); it.hasNext();) {
	ClienteMaiorQuantVenda clienteMaiorQuantVenda = (ClienteMaiorQuantVenda) it.next();
	EntidadeDAO daoEntidade = new EntidadeDAO(conn);
	Entidade entidade = daoEntidade.procurarEntidade(clienteMaiorQuantVenda.getCodClient());
	if(entidade.getTpInsc().equalsIgnoreCase("F")){
		EntidadeFisicaDAO daoEntidadeFisica = new EntidadeFisicaDAO(conn);
		EntidadeFisica entidadeFisica = daoEntidadeFisica.procurarEntidadeFisica(entidade.getCdEntidade());
		TipoLogradouroDAO logradouro = new TipoLogradouroDAO(conn);
		EntidadeEndereco entidadeEndereco = null;
		EntidadeEnderecoDAO daoEntidadeEndereco= new EntidadeEnderecoDAO(conn);
		entidadeEndereco = daoEntidadeEndereco.procurarEntidadeEnderecoPadraoPizzaria(entidade.getCdEntidade());
		EntidadeTelefoneDAO daoEntidadeFone = new EntidadeTelefoneDAO(conn);
		EntidadeTelefone entidadeFone = null;
		listarTelefone = daoEntidadeFone.listarTelefone(entidade.getCdEntidade());
		int contador = 0;
		for ( Iterator itTelefone = listarTelefone.iterator(); itTelefone.hasNext(); ) {
			entidadeFone = (EntidadeTelefone) itTelefone.next();
			if(entidadeFone.getNroTelefone() != null){
				//contador++;
				//if(contador <= 2){
					tel += entidadeFone.getNroTelefone() + " / ";
				//}
			}
		}
		TipoLogradouro logra = logradouro.procurarTipoLogradouro(entidadeEndereco.getCdTipoLogradouro());
		dsLogradouro = logra.getDsTipoLogradouro();
		endereco = dsLogradouro + " " +entidadeEndereco.getDsEndereco() + " " +"nº"+ " "+entidadeEndereco.getNroEndereco();
		cmpEndereco = entidadeEndereco.getCmpEndereco();
		cep = entidadeEndereco.getCepEndereco();
		bairro =entidadeEndereco.getBaiEndereco();
		referencia = entidadeEndereco.getRefEndereco();
		cidadeUf = "";
		if(cep == null)cep="";
		if(bairro == null)bairro="";
	
	}else if(entidade.getTpInsc().equalsIgnoreCase("J")){
	        EntidadeJuridicaDAO daoEntidadeJuridica = new EntidadeJuridicaDAO(conn);
	        EntidadeJuridica entidadeJuridica = daoEntidadeJuridica.procurarEntidadeJuridica(entidade.getCdEntidade());
	        TipoLogradouroDAO logradouro = new TipoLogradouroDAO(conn);
			EntidadeEndereco entidadeEndereco = null;
			EntidadeEnderecoDAO daoEntidadeEndereco= new EntidadeEnderecoDAO(conn);
			entidadeEndereco = daoEntidadeEndereco.procurarEntidadeEnderecoPadraoPizzaria(entidade.getCdEntidade());
			EntidadeTelefoneDAO daoEntidadeFone = new EntidadeTelefoneDAO(conn);
			EntidadeTelefone entidadeFone = null;
			listarTelefone = daoEntidadeFone.listarTelefone(entidade.getCdEntidade());
			int contador = 0;
			for ( Iterator itTelefone = listarTelefone.iterator(); itTelefone.hasNext(); ) {
				entidadeFone = (EntidadeTelefone) itTelefone.next();
				if(entidadeFone.getNroTelefone() != null){
					//contador++;
					//if(contador <= 2){
						tel += entidadeFone.getNroTelefone() + " / ";
					//}
				}
			}
			TipoLogradouro logra = logradouro.procurarTipoLogradouro(entidadeEndereco.getCdTipoLogradouro());
			dsLogradouro = logra.getDsTipoLogradouro();
			endereco = dsLogradouro + " " +entidadeEndereco.getDsEndereco() + " " +"nº"+ " "+entidadeEndereco.getNroEndereco();
			cmpEndereco = entidadeEndereco.getCmpEndereco();
			cep = entidadeEndereco.getCepEndereco();
			bairro =entidadeEndereco.getBaiEndereco();
			referencia = entidadeEndereco.getRefEndereco();
			cidadeUf = "";
			if(cep == null)cep="";
			if(bairro == null)bairro="";
	}
	cont++;
%>
    
   <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid" width="2%"><center><%=clienteMaiorQuantVenda.getCodClient()%></center></td>
      <td class = "grid" width="6%"><center><%=clienteMaiorQuantVenda.getNomeCliente()%></center></td>
      <td class = "grid" width="6%"><center><%=endereco +" Bairro: "+bairro + " Cep:"+cep%></center></td>
      <td class = "grid" width="6%"><center><%=tel%></center></td>
      <td class = "grid" width="2%"><center><%=ConverteDate.dateToString(clienteMaiorQuantVenda.getDataCadastro())%></center></td> 
      <td class = "grid" width="2%"><center><%=clienteMaiorQuantVenda.getQuantPedido()%></center></td>
      <td class = "grid" width="2%"><center><%=Utilitaria.formatarNumero(clienteMaiorQuantVenda.getVlPed(),2)%></center></td>
      <td class = "grid" width="2%"><center><%=Utilitaria.formatarNumero(clienteMaiorQuantVenda.getTotalPed(),2)%></center></td>
      <td class = "grid" width="2%"><center><%=ConverteDate.dateToString(clienteMaiorQuantVenda.getUltimoPedido())%></center></td> 
     
  </tr>
<%
	tel = "";
}
%>      
</table>
</form>
<%@include file="../fimConexao.jsp"%>