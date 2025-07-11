<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.PedidoSaida"%>
<%@page import="afero.persistence.PedidoSaidaDAO"%>
<%@ page import="afero.util.ConverteDate" %>
<%@page import="java.util.Calendar" %>
<%@ page import="afero.integracao.xprocess.NfeProdutoServico" %>
<%@ page import="afero.integracao.xprocess.RelatorioCupom" %>
<%@ page import="afero.integracao.xprocess.persistence.NfeProdutoServicoDAO" %>
<%@page import="afero.util.Utilitaria"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Date" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script language=JavaScript src="../js/abas.js" type=text/javascript></script>
<script src="../js/common.js" /></script>
<script>

function localizar() {
  
  document.forms[0].submit();
}  

function atualizar() {
  document.forms[0].submit();
}

</script>
<%
String cdLoja = request.getParameter("idLoja");
int idLoja = 0;
if (cdLoja == null) {
	idLoja = Integer.parseInt((String)session.getAttribute("idLoja"));
} else {
	idLoja = Integer.parseInt(cdLoja);
}
  String tipo = "os" ;
  int secs           = 120;
  Calendar dataAtual = Calendar.getInstance();
  ConverteDate converte = new ConverteDate();
  try {
    secs = Integer.parseInt("120");
  }
  catch (Exception e) {}
  PedidoSaidaDAO daoPedidoSaida = new PedidoSaidaDAO(conn);
  String dataIni = request.getParameter("dataIni");
  String dataFim = request.getParameter("dataFim");
  int mes        = dataAtual.get(Calendar.MONTH) + 1;

  if (dataIni == null) {
   dataIni = daoPedidoSaida.dataAtualPedido();
  }
  if (dataFim == null) {
    dataFim = daoPedidoSaida.dataAtualPedido();
  }
 
  
  NfeProdutoServicoDAO dao;
  String acao = request.getParameter("acao");
  String clausula = "";

  clausula = " WHERE n.demi BETWEEN '"+converte.DMYToYMDI(dataIni)+" 00:00:00' AND '"+converte.DMYToYMDI(dataFim)+" 23:59:59'"; 
      
  if(idLoja != 0){
  	clausula = clausula + " AND n.id_empresa = " + idLoja;
  }

  //seleciona todos os registros do banco de dados
  List list;
  dao = new NfeProdutoServicoDAO(conn);
  clausula = clausula+" GROUP BY p.idNfe,n.serie, p.nitem, p.cprod ORDER BY n.demi, n.nnf ";
  list = dao.RelatorioProdutosNfe(clausula);
  int cont = 0;
%>


<%-- Início do Conteúdo da Página --%>
<div class="cabecalho_pagina">Cupons Emitidos (Produtos)</div>
<hr>
<form action="relatorioFrenteLoja.jsp">
<iframe width=174 height=189 name="gToday:normal:"../js/calendar/agenda.js"
            id="gToday:normal:"../js/calendar/agenda.js" src="../js/calendar/ipopeng.htm"
            scrolling="no" frameborder="0" style="visibility:visible; z-index:999; 
    position:absolute; top:-500px; left:-500px;">
    </iframe>

<table border="0" width="100%">
<tr>
      <th class="label">Loja</th>
      <td><select id="idLoja"name="idLoja">
          <option value='0'>Todos...</option>
          <%@include file="../WEB-INF/jspf/combo/comboLoja.jspf" %></select>
          <script>comboSelect(document.forms[0].idLoja, '<%=idLoja%>');</script>
      </td>
  </tr>
 </table>
<table border="0" width="100%">
    <tr>
      <td class='grid'>Data Inicial 
	<input type="text" name="dataIni" size="15" value="<%= dataIni %>" onblur="chkData(this,'dd/MM/yyyy')" maxlength="10" class="inputs"><a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dataIni);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
      </td>
      <td class='grid'>Data Final 
	<input type="text"  name="dataFim" size="15" value="<%= dataFim %>" maxlength="10" onblur="chkData(this,'dd/MM/yyyy')" class="inputs"><a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dataFim);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
      </td>

     
    <td align="center">
        <input type="button" value="Atualizar" class="botao" onclick="atualizar();">
        <input type="button" value="Imprimir" class="botao" onclick="print();">
    </td>
    </tr>

</table>
</form>
<table width="100%" border="0">
<tr>
 <th class="grid" colspan="26">Cupons Emitidos no Periodo</th>
</tr>
  <tr>
      <th class="grid" width="2%">&nbsp;</th>
      <th class="grid" width="2%">Data de Emissão</th>
      <th class="grid" width="2%"><center>Número do Cupom</center></th>
      <th class="grid" width="2%"><center>Série</center></th>
      <th class="grid" width="2%"><center>Pedido</center></th>
      <th class="grid" width="5%"><center>Codigo do Produto</center></th>
      <th class="grid" width="5%"><center>Descricão do Produto</center></th>
      <th class="grid" width="3%">NCM</th>
      <th class="grid" width="3%">Código de Barras</th>
      <th class="grid" width="3%"><center>CFOP</center></th>
      <th class="grid" width="3%"><center>Unid.</center></th>
      <th class="grid" width="5%"><center>Quantidade</center></th>
      <th class="grid" width="5%"><center>Valor Unitário</center></th>
      <th class="grid" width="3%">Valor Total Bruto</th>
      <th class="grid" width="3%"><center>Valor Desconto</center></th>
      <th class="grid" width="5%"><center>CST</center></th>
      <th class="grid" width="3%">Perc.Redução BC ICMS ST</th>
      <th class="grid" width="3%"><center>Valor BC ICMS</center></th>
      <th class="grid" width="3%"><center>Alíquota do Imposto</center></th>
      <th class="grid" width="5%"><center>Valor do Icms</center></th>
      <th class="grid" width="3%">Código Enquadramento Legal IPI</th>
      <th class="grid" width="3%">Grupo IPI CST</th>
      <th class="grid" width="5%"><center>Valor BC IPI</center></th>
      <th class="grid" width="3%">Alíquota do IPI</th>
      <th class="grid" width="3%">Valor do IPI</th>

    </tr>
<%

double totalBruto = 0;
//double totalUni = 0;
double totalICMS = 0;
double totalIpi = 0;

//Utiliza o ResultSet para trazer os registros do banco de dados
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	RelatorioCupom relatorioCupom = (RelatorioCupom) it.next();
	cont++;
	//totalUni   += Double.parseDouble(relatorioCupom.getVuncom());
	totalBruto += Double.parseDouble(relatorioCupom.getVprod());
	totalICMS  += Double.parseDouble(relatorioCupom.getImposto_vicms());
	totalIpi   += Double.parseDouble(relatorioCupom.getIpi_vipi());
%>
   <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid" width="2%"><center><%=ConverteDate.YMDToDMY(Utilitaria.substring(relatorioCupom.getDataEmissao(),0,10))%></center></td>
      <td class = "grid" width="2%"><font color="red"><center><%=relatorioCupom.getNnf()%></center></font></td>
      <td class = "grid" width="2%"><font color="red"><center><%=relatorioCupom.getSerie()%></center></font></td>
      <td class = "grid" width="2%"><center><%=relatorioCupom.getIdPedidoSaida()%></center></td>
      <td class = "grid" width="2%"><center><%=relatorioCupom.getCprod()%></center></td>
      <td class = "grid" width="30%"><center><%=relatorioCupom.getXprod()%></center></td>
      <td class = "grid" width="5%"><center><%=relatorioCupom.getNcm()%></center></td>
      <td class = "grid" width="3%"><center><%=relatorioCupom.getCean()%></center></td>
      <td class = "grid" width="3%"><center><%=relatorioCupom.getCfop()%></center></td>
      <td class = "grid" width="2%"><center><%=relatorioCupom.getUcom()%></center></td>
      <td class = "grid" width="2%"><center><%=Utilitaria.limpar(Utilitaria.left(relatorioCupom.getQcom(),2),"0123456789")%></center></td>
      <td class = "grid" width="2%"><center><%=Utilitaria.formatarNumero(Double.parseDouble(Utilitaria.substring(relatorioCupom.getVuncom(),0,4)),2)%></center></td>
      <td class = "grid" width="2%"><center><%=Utilitaria.formatarNumero(Double.parseDouble(relatorioCupom.getVprod()),2)%></center></td>
      <td class = "grid" width="3%"><center><%=Utilitaria.formatarNumero(Double.parseDouble(relatorioCupom.getVdesc()),2)%></center></td>
      <td class = "grid" width="2%"><center><%=relatorioCupom.getImposto_cst()%></center></td>
      <td class = "grid" width="2%"><center><%=Utilitaria.formatarNumero(Double.parseDouble(relatorioCupom.getImposto_predbc()),2)%></center></td>
      <td class = "grid" width="30%"><center><%=Utilitaria.formatarNumero(Double.parseDouble(relatorioCupom.getImposto_vbc()),2)%></center></td>
      <td class = "grid" width="30%"><center><%=Utilitaria.formatarNumero(Double.parseDouble(relatorioCupom.getImposto_picms()),2)%></center></td>
      <td class = "grid" width="3%"><center><%=Utilitaria.formatarNumero(Double.parseDouble(relatorioCupom.getImposto_vicms()),2)%></center></td>
      <td class = "grid" width="2%"><center><%=relatorioCupom.getIpi_cenq ()%></center></td>
      <td class = "grid" width="3%"><center><%=relatorioCupom.getIpi_cst()%></center></td>
      <td class = "grid" width="3%"><center><%=Utilitaria.formatarNumero(Double.parseDouble(relatorioCupom.getIpi_vbc()),2)%></center></td>
      <td class = "grid" width="2%"><center><%=Utilitaria.formatarNumero(Double.parseDouble(relatorioCupom.getIpi_pipi()),2)%></center></td>
      <td class = "grid" width="2%"><center><%=Utilitaria.formatarNumero(Double.parseDouble(relatorioCupom.getIpi_vipi()),2)%></center></td>
  </tr>
<%
}
%>      
</table>
<table border="0" width="100%">

<tr>
<th class="grid"><center>Valor Total(R$)</center></th>
<td class="grid"><center><font color="red"><b><%=Utilitaria.formatarNumero(totalBruto,2)%></b></font></center></td>
</tr>
<tr>
<th class="grid"><center>Valor Total ICMS(R$)</center></th>
<td class="grid"><center><font color="red"><b><%=Utilitaria.formatarNumero(totalICMS,2)%></b></font></center></td>
</tr>
<tr>
<th class="grid"><center>Valor Total IPI(R$)</center></th>
<td class="grid"><center><font color="red"><b><%=Utilitaria.formatarNumero(totalIpi,2)%></b></font></center></td>
</tr>

</table>
<%@include file="../fimConexao.jsp"%>