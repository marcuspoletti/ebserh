<html>
<head>
<%@page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="afero.model.ConfigServico" %>
<%@page import="afero.persistence.ConfigServicoDAO" %>
<%@page import="afero.util.Utilitaria" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script src="../js/common.js"/></script>
<script>
function salvar() {
	if (document.all.cdCfopProduto.value == 0) {
		window.alert("O campo CFOP Produto é obrigatório.");
		document.all.idLoja.focus();
	}else if (document.all.cdCfopServico.value == 0) {
		window.alert("O campo CFOP Serviço é obrigatório.");
		document.all.idLoja.focus();
	}else {
		document.forms[0].submit();
	}
}

function cancelar() {
  document.forms[0].action='formConfigServico.jsp';
  document.forms[0].submit();
}

</script>
</head>
<%

String acao = request.getParameter("acao");
if (acao == null) acao = "inc";
int idLoja = Integer.parseInt((String)session.getAttribute("idLoja"));
if(acao.equalsIgnoreCase("atu")){
	idLoja = Integer.parseInt(request.getParameter("idLoja"));
}

String tipoOS = "";
String dsCampo1 = "";
String dsCampo2 = "";
String dsCampo3 = "";
String dsCampo4 = "";
String msg1 = "";
String msg2 = "";
String msg3 = "";
String msg4 = "";
String msg5 = "";
float pCSocial = 0;
float pCofins = 0;
float pPis = 0;
float pIrrf = 0;
float tetoIrrf = 0;
float pInss = 0;
float pIss = 0;
int cdCfopServico = 0;
int cdCfopProduto = 0;
String dsCmpOb1 = "";
String dsCmpOb2 = "";
String dsCmpOb3 = "";
String dsCmpOb4 = "";

if(acao.equalsIgnoreCase("atu")){
	
	ConfigServico configServico =  new ConfigServico();
	ConfigServicoDAO dao = new ConfigServicoDAO(conn);
	
	configServico =  dao.procurarConfigServico(" WHERE idLoja = "+idLoja);
	
	tipoOS = configServico.getTipoOS();
	dsCampo1 = configServico.getDsCampo1();
	dsCampo2 = configServico.getDsCampo2();
	dsCampo3 = configServico.getDsCampo3();
	dsCampo4 = configServico.getDsCampo4();
	msg1 = configServico.getMsg1();
	msg2 = configServico.getMsg2();
	msg3 = configServico.getMsg3();
	msg4 = configServico.getMsg4();
	msg5 = configServico.getMsg5();
	pCSocial = configServico.getpCSocial();
	pCofins = configServico.getpCofins();		
	pPis = configServico.getpPis();		
	pIrrf = configServico.getpIrrf();		
	tetoIrrf = configServico.getTetoIrrf();		
	pInss = configServico.getpInss();		
	pIss = configServico.getpIss();
	cdCfopServico = configServico.getCdCfopServico();		
	cdCfopProduto = configServico.getCdCfopProduto();
	dsCmpOb1 = configServico.getDsCmpOb1();
	dsCmpOb2 = configServico.getDsCmpOb2();
	dsCmpOb3 = configServico.getDsCmpOb3();
	dsCmpOb4 = configServico.getDsCmpOb4();

}
%>
<body onload="document.forms[0].elements[2].focus();" >
<h1 class="cabecalho_pagina">Configurações de Serviço</h1>
<form method="post" action="listarConfigServico.jsp?acao=<%=acao%>">
<input type="hidden" name="acao" value="<%=acao%>"/>
<table border="0" width="100%">

	<tr>
		<th class="label">Tipo</th>
		<td class="label_radio">
			<input type="radio" class="radio" name="tipoOS" value="O" <%= (tipoOS.equals("O")? "checked": "") %>>Orçamento
			<input checked type="radio" class="radio" name="tipoOS" value="S" <%= (tipoOS.equals("S")? "checked": "") %>>Ordem de Serviço
		</td>
	</tr>
	<tr>
		<th class="label">Campo 1( O.S. )</th>
		<td><input type="text"  id="dsCampo1" name="dsCampo1" value="<%=dsCampo1%>" size="40" maxlength="20" /></td>
	</tr>
	<tr>
		<th class="label">Campo 2( O.S. )</th>
		<td><input type="text"  id="dsCampo2" name="dsCampo2" value="<%=dsCampo2%>" size="40" maxlength="20" /></td>
	</tr>
	<tr>
		<th class="label">Campo 3( O.S. )</th>
		<td><input type="text"  id="dsCampo3" name="dsCampo3" value="<%=dsCampo3%>" size="40" maxlength="20" /></td>
	</tr>
	<tr>
		<th class="label">Campo 4( O.S. )</th>
		<td><input type="text"  id="dsCampo4" name="dsCampo4" value="<%=dsCampo4%>" size="40" maxlength="20" /></td>
	</tr>
	<tr>
		<th class="label">Mensagem 1</th>
		<td><textarea  id="msg1" name="msg1" cols="40" rows="3" maxlength="100"><%=msg1 %></textarea></td>
	</tr>
	<tr>
		<th class="label">Mensagem 2</th>
		<td><textarea  id="msg2" name="msg2" cols="40" rows="3" maxlength="100"><%=msg2 %></textarea></td>
	</tr>
	<tr>
		<th class="label">Mensagem 3</th>
		<td><textarea  id="msg3" name="msg3" cols="40" rows="3" maxlength="100"><%=msg3 %></textarea></td>
	</tr>
	<tr>
		<th class="label">Mensagem 4</th>
		<td><textarea  id="msg4" name="msg4" cols="40" rows="3" maxlength="100"><%=msg4 %></textarea></td>
	</tr>
	<tr>
		<th class="label">Mensagem 5</th>
		<td><textarea  id="msg5" name="msg5" cols="40" rows="3" maxlength="100"><%=msg5 %></textarea></td>
	</tr>
	<tr>
		<th class="label">C. Social (%)</th>
		<td><input type="text" name="pCSocial" value="<%=pCSocial %>" size="10" onkeyup="FormataValor(this,event)" maxlength="10"></td>
	</tr>
	<tr>
		<th class="label">Cofins (%)</th>
		<td><input type="text" name="pCofins" value="<%=pCofins %>" onkeyup="FormataValor(this,event)" size="10" maxlength="10"></td>
	</tr>
	<tr>
		<th class="label">PIS (%)</th>
		<td><input type="text" name="pCSocial" value="<%=pCSocial %>" size="10" onkeyup="FormataValor(this,event)" maxlength="10"></td>
	</tr>
	<tr>
		<th class="label">IRRF (%)</th>
		<td><input type="text" name="pIrrf" value="<%=pIrrf %>" size="10" onkeyup="FormataValor(this,event)" maxlength="10"></td>
	</tr>
	<tr>
		<th class="label">Teto IRRF (%)</th>
		<td><input type="text" name="tetoIrrf" value="<%=tetoIrrf %>" size="10" onkeyup="FormataValor(this,event)" maxlength="10"></td>
	</tr>
	<tr>
		<th class="label">INSS (%)</th>
		<td><input type="text" name="pInss" value="<%=pInss %>" size="10" onkeyup="FormataValor(this,event)" maxlength="10"></td>
	</tr>
	<tr>
		<th class="label">ISS (%)</th>
		<td><input type="text" name="pIss" value="<%=pIss %>" size="10" onkeyup="FormataValor(this,event)" maxlength="10"></td>
	</tr>
	<tr>
      <th class="label">CFOP Produto*</th>
      <td><select name="cdCfopProduto">
          <option value=''>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboCfopProduto.jspf"  %></select>
          <script>comboSelect(document.forms[0].cdCfopProduto, '<%= cdCfopProduto %>');</script>
      </td>
  </tr>
  <tr>
      <th class="label">CFOP Serviço*</th>
      <td><select name="cdCfopServico">
          <option value=''>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboCfopServico.jspf"  %></select>
          <script>comboSelect(document.forms[0].cdCfopServico, '<%= cdCfopServico %>');</script>
      </td>
  </tr>
	<tr>
		<th class="label">Campo 1( Objeto )</th>
		<td><input type="text"  id="dsCmpOb1" name="dsCmpOb1" value="<%=dsCmpOb1%>" size="40" maxlength="20" /></td>
	</tr>
	<tr>
		<th class="label">Campo 2( Objeto )</th>
		<td><input type="text"  id="dsCmpOb2" name="dsCmpOb2" value="<%=dsCmpOb2%>" size="40" maxlength="20" /></td>
	</tr>
	<tr>
		<th class="label">Campo 3( Objeto )</th>
		<td><input type="text"  id="dsCmpOb3" name="dsCmpOb3" value="<%=dsCmpOb3%>" size="40" maxlength="20" /></td>
	</tr>
	<tr>
		<th class="label">Campo 4( Objeto )</th>
		<td><input type="text"  id="dsCmpOb4" name="dsCmpOb4" value="<%=dsCmpOb4%>" size="40" maxlength="20" /></td>
	</tr>
</table><hr>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			<input class="button" type="button" value="Salvar" onClick="javascript: salvar();" />
			<input class="button" type="button" value="Cancelar" onClick="javascript: cancelar();" />
		</td>
		<td class="campo_obrigatorio">* Campos Obrigatórios</td>
	</tr>
</table>
</form>
<%@include file="../fimConexao.jsp"%>
</body>
</html>