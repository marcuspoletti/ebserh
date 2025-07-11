<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.Aniversariantes"%>
<%@ page import="afero.model.EntidadeEmail"%>
<%@ page import="afero.model.EntidadeFisica"%>
<%@ page import="afero.model.TipoLogradouro"%>
<%@ page import="afero.model.EntidadeEndereco"%>
<%@ page import="afero.model.EntidadeTelefone"%>
<%@ page import="afero.model.Entidade"%>
<%@ page import="afero.persistence.TipoLogradouroDAO"%>
<%@ page import="afero.persistence.EntidadeTelefoneDAO"%>
<%@ page import="afero.persistence.EntidadeEnderecoDAO"%>
<%@ page import="afero.persistence.EntidadeFisicaDAO"%>
<%@ page import="afero.persistence.EntidadeDAO"%>
<%@ page import="afero.persistence.EntidadeEmailDAO"%>
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
  document.forms[0].action='listaAniversariantesFisicas.jsp';
  document.forms[0].submit();
}
</script>
<%
String clausula = "";


ConverteDate converte = new ConverteDate();
EntidadeDAO dao = null;
String dataMes = "0";
if(request.getParameter("dataMes") != null){
	dataMes = request.getParameter("dataMes");
}

dao = new EntidadeDAO(conn);

clausula = " WHERE MONTH(ef.dtNascimento)="+dataMes+
                   " AND e.status = 'A'";
//seleciona todos os registros do banco de dados
List list = dao.listarAniversariantesFisica(clausula);
%>
<h1 class="cabecalho_pagina">Aniversariantes (Pessoas Físicas)</h1>
<form action="listaAniversariantesFisicas.jsp" method="post">

<table border="0" width="100%">
    
    <tr>
      <th class="label">Mês</th>
      <td><select name="dataMes" style="width: 172px">
          <option value='0'>Selecione...</option>
          <%@include file="../WEB-INF/jspf/combo/comboMes.jspf"%></select>
          <script>comboSelect(document.forms[0].dataMes, '<%=dataMes%>');</script>
      </td>
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
      <th class="grid" width="2%"><center>Dt. Nascimento</center></th> 
      <th class="grid" width="2%"><center>Nome</center></th>
      <th class="grid" width="2%"><center>Endereço</center></th>
      <th class="grid" width="2%"><center>Telefone</center></th>
      <th class="grid" width="2%"><center>Email</center></th>
      
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
	Aniversariantes aniversariantes = (Aniversariantes) it.next();
	EntidadeDAO daoEntidade = new EntidadeDAO(conn);
	Entidade entidade = daoEntidade.procurarEntidade(aniversariantes.getCdEntidade());
	if(entidade.getTpInsc().equalsIgnoreCase("F")){
		EntidadeFisicaDAO daoEntidadeFisica = new EntidadeFisicaDAO(conn);
		EntidadeFisica entidadeFisica = daoEntidadeFisica.procurarEntidadeFisica(entidade.getCdEntidade());
		TipoLogradouroDAO logradouro = new TipoLogradouroDAO(conn);
		EntidadeEndereco entidadeEndereco = null;
		EntidadeEnderecoDAO daoEntidadeEndereco= new EntidadeEnderecoDAO(conn);
		entidadeEndereco = daoEntidadeEndereco.procurarEntidadeEnderecoPadraoPizzaria(entidade.getCdEntidade());
		EntidadeTelefoneDAO daoEntidadeFone = new EntidadeTelefoneDAO(conn);
		EntidadeEmailDAO daoEntidadeEmail = new EntidadeEmailDAO(conn);
		EntidadeEmail entidadeEmail = daoEntidadeEmail.procurarEntidadeEmailPadrao(entidadeFisica.getCdEntidade());
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
		aniversariantes.setEmail(entidadeEmail.getDsEmail());
	
	}
	cont++;
%>
    
   <tr>
      <td class = "grid" width="2%"><center><%=cont%></center></td>
      <td class = "grid" width="2%"><center><%=aniversariantes.getCdEntidade()%></center></td>
      <td class = "grid" width="2%"><center><%=ConverteDate.dateToString(aniversariantes.getDataNascimento())%></center></td> 
      <td class = "grid" width="6%"><center><%=aniversariantes.getNomeCliente()%></center></td>
      <td class = "grid" width="6%"><center><%=endereco +" Bairro: "+bairro + " Cep:"+cep%></center></td>
      <td class = "grid" width="6%"><center><%=tel%></center></td>
      <td class = "grid" width="6%"><center><%=aniversariantes.getEmail()%></center></td>
      
      
     
  </tr>
<%
	tel = "";
}
%>      
</table>
</form>
<%@include file="../fimConexao.jsp"%>