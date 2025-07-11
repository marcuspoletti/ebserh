<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.OrcamentoEmpresaItem" %>
<%@ page import="afero.model.PlanoConta" %>
<%@ page import="afero.model.OrcamentoEmpresa" %>
<%@ page import="afero.persistence.OrcamentoEmpresaItemDAO" %>
<%@ page import="afero.persistence.OrcamentoEmpresaDAO" %>
<%@page import="afero.util.Utilitaria"%>
<%@ page import="afero.persistence.PlanoContaDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Date" %>
<%@ page import="afero.util.ConverteDate" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script type="text/javascript">
function confirmaExcluir(cont, id, id1) {  
	if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
	       location.href = 'frameOrcamentoItemCredito.jsp?acao=exc&idOrcamentoEmpresaItem=' + id + '&idOrcamentoEmpresa='+id1;  
	  }  
	}
</script>
<% 
//seleciona todos os registros do banco de dados
int contCredito = 0;
List list;
OrcamentoEmpresaItemDAO dao;
OrcamentoEmpresaItemDAO daoExclusao;
OrcamentoEmpresaItemDAO daoOrc = new OrcamentoEmpresaItemDAO(conn);
String acao = request.getParameter("acao");
if (acao == null) acao = "listar";
String idOrcamentoEmpresaItem = request.getParameter("idOrcamentoEmpresaItem");
String idOrcamentoEmpresa = request.getParameter("idOrcamentoEmpresa");
String idPlanoConta = "0";
String dtMov ="";
String dtComp = daoOrc.dataAtual();
String clausula = "";
String usuario = (String) session.getAttribute("Login");
double valor = 0;
dao = new OrcamentoEmpresaItemDAO(conn);

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
	
	idOrcamentoEmpresaItem = request.getParameter("idOrcamentoEmpresaItem");
	idOrcamentoEmpresa = request.getParameter("idOrcamentoEmpresa");
	idPlanoConta =request.getParameter("idPlanoConta");
	if(request.getParameter("valor") != null){
		valor = Utilitaria.toNumber(request.getParameter("valor")).doubleValue();	
	}
	dtComp = request.getParameter("dtComp");
    if(idOrcamentoEmpresaItem == null)idOrcamentoEmpresaItem = "0";
    if(idOrcamentoEmpresa == null)idOrcamentoEmpresa = "0";
    if(idPlanoConta == null)idPlanoConta = "0";
    if(dtComp == null)dtComp = daoOrc.dataAtual();
    OrcamentoEmpresaItem orcEmpItem = new OrcamentoEmpresaItem(); 
  
	try {
	  if (!acao.equalsIgnoreCase("inc")){
		  orcEmpItem.setIdOrcamentoEmpresaItem(Integer.parseInt(idOrcamentoEmpresaItem));
	  }
	  
	  orcEmpItem.setIdOrcamentoEmpresa(Integer.parseInt(idOrcamentoEmpresa));
	  orcEmpItem.setIdPlanoConta(Integer.parseInt(idPlanoConta));
	  orcEmpItem.setDtComp(ConverteDate.stringToDate(dtComp));
	  orcEmpItem.setUsuario(usuario);
	  orcEmpItem.setValor(valor);
	  //orcEmpItem.setDtMov(ConverteDate.stringToDate(dtMov));
      if (!acao.equalsIgnoreCase("exc")){
    	  orcEmpItem.setIdOrcamentoEmpresaItem(Integer.parseInt(idOrcamentoEmpresaItem)); 
      }
      
	}catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}


  dao = new OrcamentoEmpresaItemDAO(conn);
  daoExclusao = new OrcamentoEmpresaItemDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {  
	  //inclui no banco de dados
  	dao.incluir(orcEmpItem);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
    	 dao.atualizar(orcEmpItem);
  }else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
	  //if(!daoExclusao.exclusaoIdBanco(Integer.parseInt(idBanco))){
          dao.excluir(orcEmpItem);
	  //}else{
		//  response.sendRedirect("listarOrcamentoEmpresaItem.jsp?mensagem=Exclusão Inválida! Item já possui lançamentos.&acao=listar");
  }
	  
}
clausula +=" where idOrcamentoEmpresa = "+Integer.parseInt(idOrcamentoEmpresa) +" order by oei.dtComp ";
list = dao.listarOrcamentoEmpresaItem(clausula);

%>
<form action="frameOrcamentoItemCredito.jsp" method="post" >
<input type="hidden" name="idOrcamentoEmpresa" value="<%=idOrcamentoEmpresa%>">
<input type="hidden" name="acao" value="<%=acao%>">
<table border="0" width="100%">

    <tr>
      <th class="grid" width="2%">&nbsp;</th>
      <th class="grid" width="10%"><center>Plano de Conta</center></th>
      <th class="grid" width="10%"><center>Valor (R$)</center></th>
      <th class="grid" width="10%">Data</th>
      <th class="grid" width="3%">Excluir</th>
    </tr>

<% 
for ( Iterator it = list.iterator(); it.hasNext(); ) {
	OrcamentoEmpresaItem orcEmpresaItem = (OrcamentoEmpresaItem) it.next();
	PlanoContaDAO daoPlanoConta = new PlanoContaDAO(conn);
	PlanoConta planoConta = daoPlanoConta.procurarPlanoConta(orcEmpresaItem.getIdPlanoConta());
    
	
%>
<%if(planoConta.getDc().equalsIgnoreCase("C")){
	   contCredito++; %>
    <tr>
      <td class = "grid" width="2%"><center><%=contCredito%></center></td>
      <td class = "grid" width="10%"><center><a target="_blank" href="formOrcamentoEmpresaItem.jsp?acao=atu&idOrcamentoEmpresaItem=<%=orcEmpresaItem.getIdOrcamentoEmpresaItem()%>"><%=planoConta.getNmPlanoConta()%> </a></center></td>
      <td class = "grid" width="10%"><center><%=Utilitaria.formatarNumero(orcEmpresaItem.getValor(),2).toString()%></center></td>
      <td class = "grid" width="10%"><center><%=ConverteDate.dateToString(orcEmpresaItem.getDtComp())%></center></td>
      <td class = "grid" width="3%"><center><a href="javascript: confirmaExcluir(<%=contCredito%>,<%=orcEmpresaItem.getIdOrcamentoEmpresaItem()%>, <%=idOrcamentoEmpresa%>);"><img border = "0" src="../images/delete.gif"></a></center></td>
  </tr>
	<%}%>
<%} %>
</form>
</table>
<%@include file="../fimConexao.jsp"%>