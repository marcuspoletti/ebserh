<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.OrdemServicoItem" %>
<%@ page import="afero.persistence.OrdemServicoItemDAO" %>

<%@ page import="afero.util.Utilitaria" %>
<%@ page import="afero.util.ConverteDate" %>

<%@include file="../seguranca.jsp" %>
<%@include file="../iniConexao.jsp" %>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function confirmaExcluir(cont, id) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarOrdemServicoItem.jsp?acao=exc&idOrdemServicoItem=' + id;   
  }  
}

function addServ(){
	window.opener.location.reload();
	self.close();
}
</script>
<%
OrdemServicoItemDAO dao;

String acao = request.getParameter("acao");
String idOrdemServicoItem = request.getParameter("idOrdemServicoItem");

String idOrdemServicoObjeto = "1";
String idListaServico = "2";
String dsCompServico = "";
String comp = "0";
String larg = "0";
String quant = "0";
String valor = "0";
String pDesc = "0";
String vlUni = "0";
String idColaborador = "0";
String dtMod = null;
String usuario = (String) session.getAttribute("Login");

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu")) {
	
	idOrdemServicoObjeto = request.getParameter("idOrdemServicoObjeto");
	idListaServico = request.getParameter("idListaServico");
	dsCompServico = request.getParameter("dsCompServico");
	comp = request.getParameter("comp");
	larg = request.getParameter("larg");
	quant = request.getParameter("quant");
	valor = request.getParameter("valor");
	pDesc = request.getParameter("pDesc");
	vlUni = request.getParameter("vlUni");
	idColaborador = request.getParameter("idColaborador");
	dtMod = request.getParameter("dtMod");
	
		
	if(idOrdemServicoItem == null) idOrdemServicoItem = "0";
	if(idOrdemServicoObjeto == null) idOrdemServicoObjeto = "0";
	if(idListaServico == null) idListaServico = "0";
	if(dsCompServico == null) dsCompServico = "";
	if(comp == null) comp = "0";
	if(larg == null) larg = "0";
	if(quant == null) quant = "0";
	if(valor == null) valor = "0";
	if(pDesc == null) pDesc = "0";
	if(vlUni == null) vlUni = "0";
	if(idColaborador == null) idColaborador = "0";
	if(dtMod == null) dtMod = "";
	
	
	OrdemServicoItem ordemServicoItem = new OrdemServicoItem();
	
	try {
	  if (!acao.equalsIgnoreCase("inc")){
		  ordemServicoItem.setIdOrdemServicoItem(Integer.parseInt(idOrdemServicoItem));
	  }
	  
	  	ordemServicoItem.setIdOrdemServicoObjeto(Integer.parseInt(idOrdemServicoObjeto));
	  	ordemServicoItem.setIdListaServico(Integer.parseInt(idListaServico));
	  	ordemServicoItem.setDsCompServico(dsCompServico);
	  	ordemServicoItem.setComp(Utilitaria.toNumber(comp).floatValue());
	  	ordemServicoItem.setLarg(Utilitaria.toNumber(larg).floatValue());
	  	ordemServicoItem.setQuant(Utilitaria.toNumber(quant).floatValue());
	  	ordemServicoItem.setValor(Utilitaria.toNumber(valor).floatValue());
	  	ordemServicoItem.setpDesc(Utilitaria.toNumber(pDesc).floatValue());
	  	ordemServicoItem.setVlUni(Utilitaria.toNumber(vlUni).floatValue());	  	
	  	ordemServicoItem.setIdColaborador(Integer.parseInt(idColaborador));
	  	ordemServicoItem.setUsuario(usuario);
	  	
	  	
	  		      
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}

	dao = new OrdemServicoItemDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {  
	  //inclui no banco de dados
	  dao.incluir(ordemServicoItem);
	  %>
	  	<script language="javascript">
	  	
	  	window.opener.document.getElementById('idOrdemServicoObjeto').value = <%=ordemServicoItem.getIdOrdemServicoObjeto() %>;   
	  	addServ();
	  	</script>
	  <%
  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
	  dao.atualiza(ordemServicoItem);
	  
	  %>
	  	<script language="javascript">addServ();</script>
	  <%	  
  }
}%>