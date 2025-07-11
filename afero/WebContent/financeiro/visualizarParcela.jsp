<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="afero.model.Duplicata"%>
<%@ page import="afero.model.DuplicataParcela"%>
<%@ page import="afero.model.Entidade" %>
<%@ page import="afero.persistence.DuplicataDAO"%>
<%@ page import="afero.persistence.DuplicataParcelaDAO"%>
<%@ page import="afero.persistence.EntidadeDAO" %>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Iterator"%>
<%@page import="afero.util.ConverteDate"%>
<%@ page import="afero.util.Utilitaria"%>
<%@page import="java.util.Date" %>
<%@include file="../seguranca.jsp" %>
<%@include file="../iniConexao.jsp" %>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script language=JavaScript src="../js/abas.js" type=text/javascript></script>
<script src="../js/common.js" /></script>
<html>
<head>

<script type="text/javascript">

function Salvar() {
 	 document.forms[0].submit();
  	}


function Cancelar(id) {
  document.forms[0].action="listarDuplicataParcela.jsp?idDuplicata="+id;
  document.forms[0].submit();
}

function Voltar() {
	  document.forms[0].action="listarDuplicataPagar.jsp";
	  document.forms[0].submit();
	}
function recarregar(acao) {
  document.forms[0].action='listarDuplicataPagar.jsp?acao='+acao;
  document.forms[0].submit();
}
</script>

<%
//Pegar idDuplicata
int idDuplicata = Integer.parseInt(request.getParameter("idDuplicata"));
int idDuplicataParcela = Integer.parseInt(request.getParameter("idDuplicataParcela"));
String clausula = "";
ConverteDate converte = new ConverteDate();

// Todos dados do banco

List list;
DuplicataParcelaDAO dao = new DuplicataParcelaDAO(conn);
clausula = " WHERE dp.idDuplicata = "+idDuplicata +" and dp.idDuplicataParcela = "+idDuplicataParcela+";";
list = dao.listarDuplicataParcela(clausula);

//Utiliza o ResultSet para trazer os registros do banco de dados
String voltarDC =request.getParameter("voltarDC");
DuplicataParcela dp = null;
String msgStatus = "";
int cont = 0;
Entidade entidade = null;
EntidadeDAO daoEntidade = new EntidadeDAO(conn);
String nomeConta;
FormaPagtoDAO daoformaPagto = new FormaPagtoDAO(conn);
ContaDAO daoConta = new ContaDAO(conn);
for (Iterator it = list.iterator(); it.hasNext(); ) {
	dp = (DuplicataParcela) it.next();
	Conta contaConta = daoConta.procurarConta(dp.getIdConta());
         entidade = daoEntidade.procurarEntidade(dp.getIdConta());
	nomeConta = entidade.getNome();
	

	cont++;

// Todos os atributos 


int nrParcela = dp.getNrParcela();
int idConta = dp.getIdConta();
String dtVenc = "";
if(dp.getDtVenc() != null){
	dtVenc = converte.dateToString(dp.getDtVenc());
}
double valor = dp.getValor();
int cdFormaPagto = dp.getCdFormaPagto();
String dtEmissao = "";
if(dp.getDtEmissao() != null){
	dtEmissao = converte.dateToString(dp.getDtEmissao());
}
String dtComp = "";
if(dp.getDtComp()!= null){
	dtComp = converte.dateToString(dp.getDtComp());
}

int idPlanoConta = dp.getIdPlanoConta();
int idCentroCusto = dp.getIdCentroCusto();
String historico = dp.getHistorico();
String divideValor = dp.getDivideValor();
String dtOperacao = "";
if(dp.getDtOperacao() != null){
	dtOperacao = converte.dateToString(dp.getDtOperacao());
}
double vlOperacao = dp.getVlOperacao();
float txJuros = dp.getVlJuros();
float txMulta = dp.getVlMulta();
float txDesc = dp.getVlDesc();
String nossoNumero = "";
if(dp.getNossoNumero() != null){
	nossoNumero =  dp.getNossoNumero();
}
String dtQuitacao = "";
if(dp.getDtQuitacao() != null){
	dtQuitacao = converte.dateToString(dp.getDtQuitacao());	
}
String formaQuitacao = dp.getFormaQuitacao();
int idColaborador = dp.getIdColaborador();
String atualizaFinanceiro = "N";
if(dp.getAtualizaFinanceiro()!=null){
	atualizaFinanceiro = dp.getAtualizaFinanceiro();
}
int idContaMovto = dp.getIdContaMovto();
String status = dp.getStatus();
String dtMov = "";
if(dp.getDtMov() != null){
	dtMov = converte.dateToString(dp.getDtMov());
}
String usuario = dp.getUsuario();
if (divideValor == null) divideValor = "N";
String nrDoc = "";
if(dp.getNrDoc() != null){
	nrDoc = dp.getNrDoc();
}
%>

</head>
<h1 class="cabecalho_pagina">Duplicata Parcela</h1>
<body onload="document.forms[0].elements[2].focus();">
	<input type="hidden" name="voltarDC" value="<%=voltarDC%>"/>
	<input type="hidden" name="idConta" value="<%=idConta%>"/>
	<input type="hidden" name="dtMov" value="<%=dtMov%>"/>
	<iframe width=174 height=189 name="gToday:normal:"../js/calendar/agenda.js"
            id="gToday:normal:"../js/calendar/agenda.js" src="../js/calendar/ipopeng.htm"
            scrolling="no" frameborder="0" style="visibility:visible; z-index:999; 
    position:absolute; top:-500px; left:-500px;">
    </iframe>
	<form action="listarDuplicataParcela.jsp?acao=atu&idDuplicata=<%=idDuplicata %>&idDuplicataParcela=<%=idDuplicataParcela %>&voltarDC=<%=voltarDC%>" method="post">    
	<input type="hidden" name="usuario" value="<%=usuario%>"/>
	
		<table>
			<tr>
				<th class="label">Nº Duplicata</th>
				<td><input disabled  type="text" size="15" maxlength="15" name="idDuplicata" value="<%=idDuplicata%>"/></td>
			</tr>
			<tr>
				<th class="label">Nº Duplicata Parcela</th>
				<td><input disabled type="text" size="15" maxlength="15" name="idDuplicataParcela" value="<%=idDuplicataParcela%>"/></td>
			</tr>
			<tr>
				<th class="label">Nº Parcela</th>
				<td><input  type="text" size="3" maxlength="2" name="nrParcela" value="<%=nrParcela %>" /></td>
			</tr>
			<tr>
				<th class="label">Nº da Conta*</th>
				<td>
				<select name="idConta" value="<%=idConta%>">
	          		<option value="0">Selecione...</option>
	          		<%@include file="../WEB-INF/jspf/combo/comboConta.jspf" %></select>
	          		<script>comboSelect(document.forms[0].idConta, '<%=idConta %>');</script>
	          	</td>
			</tr>
			
			<tr>
				<th class="label">Data de Vencimento</th>
				<td><input  name="dtVenc" type="text" size="10" maxlength="10" onblur="chkData(this,'dd/MM/yyyy')" value="<%=dtVenc %>"/>
			 <a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dtVenc);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
				
			</tr>
			
			<tr>
				<th class="label">Valor</th>
				<td><input name="valor"  type="text" size="10" maxlength="40" onkeyup="FormataValor(this,event)" value="<%=Utilitaria.formatarNumero(valor, 2) %>"/></td>
			</tr>
			<tr>
				<th class="label">Forma de Pagamento</th>
				<td><select name="cdFormaPagto" value="<%=cdFormaPagto%>">
					<option value="0">Selecione...</option>
					<%@include file="../WEB-INF/jspf/combo/comboFormaPagto.jspf" %></select>
					<script>comboSelect(document.forms[0].cdFormaPagto, '<%=cdFormaPagto%>');</script>
				</td>
			</tr>
			
			<tr>
				<th class="label">Data de Emissão</th>
				<td><input class="inputs" name="dtEmissao" type="text" size="10" maxlength="10" onblur="chkData(this,'dd/MM/yyyy')" value="<%=dtEmissao %>"  <%if (dtEmissao != null) { %>value="<%=dtEmissao%>"<% }%>/>
			 	<a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dtEmissao);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
			 	</td>
			</tr>
			<tr>
				<th class="label">Data de Compensação</th>
				<td><input class="inputs" name="dtComp" type="text" size="10" maxlength="10" onblur="chkData(this,'dd/MM/yyyy')" value="<%=dtComp %>" <%if (dtComp != null) { %>value="<%=dtComp%>"<% }%> />
			 	<a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dtComp);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
				</td>
			</tr>
			
			<tr>
				<th class="label">Nº do Documento*</th>
				<td><input disabled="disabled" name="nrDoc"  type="text" size="15" maxlength="20" value="<%=nrDoc %>"/></td>
			</tr>
			
			<tr>
				<th class="label">Plano de Conta</th>
				<td><select name="idPlanoConta" value="<%=idPlanoConta %>">
	          		<option value='0'>Selecione...</option>
	          		<%@include file="../WEB-INF/jspf/combo/comboPlanoConta.jspf" %></select>
	          		<script>comboSelect(document.forms[0].idPlanoConta, '<%=idPlanoConta%>');</script>
				</td>
			</tr>
			<tr>
				<th class="label">Centro de Custo*</th>
				<td><select name="idCentroCusto"  value="<%=idCentroCusto %>">
	          		<option value='0'>Selecione...</option>
	          		<%@include file="../WEB-INF/jspf/combo/comboCentroCusto.jspf" %></select>
	          		<script>comboSelect(document.forms[0].idCentroCusto, '<%=idCentroCusto%>');</script>
				</td>
			</tr>
			<tr>
				<th class="label">Histórico</th>
				<td><textarea name="historico" cols="60" rows="5" maxlength="200" ><%=historico %></textarea></td>
			</tr>
			<tr>
				<th class="label">Divide Valor</th>
				<td class="label_radio">
					<input type="radio" class="radio" name="divideValor" value="S" <%=(divideValor.equals("S")? "checked": "") %> />Sim
					<input type="radio" class="radio" name="divideValor" value="N" <%=(divideValor.equals("N")? "checked": "") %>/>Não
				</td>
			</tr>
			<tr>
				<th class="label">Data da Operação</th>
				<td><input disabled class="inputs" name="dtOperacao" type="text" size="10" maxlength="10"  onblur="chkData(this,'dd/MM/yyyy')" value="<%=dtOperacao %>" />
				</td>
			</tr>
			<tr>
				<th class="label">Valor da Operação</th>
				<td><input name="vlOperacao" type="text" size="13" maxlength="40" value="<%=Utilitaria.formatarNumero(valor, 2) %>"></td>
			</tr>
			<tr>
				<th class="label">Taxa de Juros</th>
				<td><input name="vlJuros"  type="text" size="15" maxlength="40" onkeyup="FormataValor(this, event)" value="<%=Utilitaria.formatarNumero(txJuros, 2)%>"/></td>
			</tr>
			<tr>
				<th class="label">Taxa de Multa</th>
				<td><input name="vlMulta" type="text" size="15" maxlength="40" onkeyup="FormataValor(this, event)" value="<%=Utilitaria.formatarNumero(txMulta, 2) %>"/></td>
			</tr>
			<tr>
				<th class="label">Taxa de Desconto</th>
				<td><input name="vlDesc"  type="text" size="15" maxlength="40" onkeyup="FormataValor(this, event)" value="<%=Utilitaria.formatarNumero(txDesc , 2)%>"/></td>
			</tr>
			<tr>
				<th class="label">Nosso Número</th>
				<td><input name="nossoNumero"  type="text" size="20" maxlength="20" value="<%=nossoNumero %>" /></td>
			</tr>
			<tr>
				<th class="label">Data de Quitação</th>
				<td>
					<input type="text" name="dtQuitacao" size="15" onblur="chkData(this,'dd/MM/yyyy')" maxlength="10" class="inputs" value="<%=dtQuitacao %>"  <%if (dtQuitacao != null) { %>value="<%=dtQuitacao%>"<%} %> >
		 			<a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.forms[0].dtQuitacao);return false;" HIDEFOCUS><img class="PopcalTrigger" align="absmiddle" src="../js/calendar/calbtn.gif" width="34" height="22" border="0" alt=""></a>
				</td>
			</tr>
			<%-- 
			<tr>
				<th class="label">Forma de Quitação</th>
				<td><input name="formaQuitacao"  type="text" size="15" value="<%=formaQuitacao %>" /></td>
			</tr>
			--%>
			<%--
			<tr>
				<th class="label">Atendente</th>
				<td><select disabled name="idColaborador" value="<%=idColaborador %>">
					<option value="0">Selecione...</option>
					<%@include file="../WEB-INF/jspf/combo/comboColaborador.jspf" %></select>
					<script>comboSelect(document.forms[0].idColaborador, '<%=idColaborador %>');</script>
				</td>
			</tr>
			 --%>
			<tr>
				<th class="label">Atualiza Financeiro</th>
				<td class="label_radio">
					<input type="radio" class="radio" name="atualizaFinanceiro" value="S" <%=(atualizaFinanceiro.equals("S")? "checked": "") %>>Sim
					<input type="radio" class="radio" name="atualizaFinanceiro" value="N" <%=(atualizaFinanceiro.equals("N")? "checked": "") %>>Não
				</td>
			</tr>
			<%--
			<tr>
				<th class="label">Conta Movimento*</th>
				<td><select name="idContaMovto" value="<%=idContaMovto %>">
					<option value="0">Selecione...</option>
					<script>comboSelect(document.forms[0].idContaMovto, '<%=idContaMovto%>');</script>
				</td>
			</tr>
			 --%>
			<tr>
				<th class="label">Status</th>
				<td class="label_radio">
					<input type="radio" class="radio" name="status" value="A" <%= (status.equals("A")? "checked": "") %>>Ativo
					<input type="radio" class="radio" name="status" value="I" <%= (status.equals("I")? "checked": "") %>>Cancelado
					<input type="radio" class="radio" name="status" value="DQ" <%= (status.equals("DQ")? "checked": "") %>>Quitado
					<input type="radio" class="radio" name="status" value="RP" <%= (status.equals("RP")? "checked": "") %>>Reparcelado
				</td>
			</tr>
			<tr>
				<th class="label">Última Modificação</th>
				<td class="label_menor"  name="dtMov" size="10" maxlength="10"/><center><%=dtMov %></center></td>
			</tr>
			<tr>
				<th class="label">Usuário*</th>
				<td class="label_menor"  name="usuario"   size="20" maxlength="20" class=""/><center><%=usuario %></center></td>
			</tr>
		</table>
		
	</form>
<%}%>
</body>
</html>