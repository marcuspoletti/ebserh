<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.OrdemServicoTarefa" %>
<%@ page import="afero.persistence.OrdemServicoTarefaDAO" %>
<%@ page import="afero.util.Utilitaria" %>
<%@ page import="afero.util.ConverteDate" %>
<%@include file="../seguranca.jsp" %>
<%@include file="../iniConexao.jsp" %>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<script>
function confirmaExcluir(cont, id) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarOrdemServicoTarefa.jsp?acao=exc&idOrdemServicoTarefa=' + id;   
  }  
}

function addServ(){
	window.opener.location.reload();
	self.close();
}
</script>
<%
OrdemServicoTarefaDAO dao;

String acao = request.getParameter("acao");
String idOrdemServicoItem = request.getParameter("idOrdemServicoItem");
String idOrdemServicoObjeto = request.getParameter("idOrdemServicoObjeto");
String idListaTarefa = request.getParameter("idListaTarefa");
String dsCompTarefa = "";
String quant = "0";
String valor = "0";
String pDesc = "0";
String vlUni = "0";
int idColaborador = Integer.parseInt((String)session.getAttribute("idColaborador"));

String dtMod = null;
String usuario = (String) session.getAttribute("Login");

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu")) {
	
	idOrdemServicoItem = request.getParameter("idOrdemServicoItem");
	idListaTarefa = request.getParameter("idListaTarefa");
	dsCompTarefa = request.getParameter("dsCompTarefa");
	quant = request.getParameter("quant");
	valor = request.getParameter("valor");
	pDesc = request.getParameter("pDesc");
	vlUni = request.getParameter("vlUni");
	dtMod = request.getParameter("dtMod");
		
	if(idOrdemServicoItem == null) idOrdemServicoItem = "0";
	if(idListaTarefa == null) idListaTarefa = "0";
	if(dsCompTarefa == null) dsCompTarefa = "";
	if(quant == null) quant = "0";
	if(valor == null) valor = "0";
	if(pDesc == null) pDesc = "0";
	if(vlUni == null) vlUni = "0";
	if(dtMod == null) dtMod = "";
	
	OrdemServicoTarefa ordemServicoTarefa = new OrdemServicoTarefa();
	
	try {
	  
		ordemServicoTarefa.setIdOrdemServicoItem(Integer.parseInt(idOrdemServicoItem));
	         ordemServicoTarefa.setIdListaTarefa(Integer.parseInt(idListaTarefa));
	         ordemServicoTarefa.setDsCompTarefa(dsCompTarefa);
	         ordemServicoTarefa.setQuant(Utilitaria.toNumber(quant).floatValue());
	         ordemServicoTarefa.setValor(Utilitaria.toNumber(valor).floatValue());
	         ordemServicoTarefa.setpDesc(Utilitaria.toNumber(pDesc).floatValue());
	         ordemServicoTarefa.setVlUni(Utilitaria.toNumber(vlUni).floatValue());	  	
	         ordemServicoTarefa.setIdColaborador(idColaborador);
	         ordemServicoTarefa.setUsuario(usuario);
	  	
	  		      
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}

	dao = new OrdemServicoTarefaDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {  
	  //inclui no banco de dados
	  dao.incluir(ordemServicoTarefa);
	  %>
	  	<script language="javascript">
	  	
	  	window.opener.document.getElementById('idOrdemServicoObjeto').value = <%=idOrdemServicoObjeto%>;   
	  	addServ();
	  	</script>
	  <%
  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
	  dao.atualiza(ordemServicoTarefa);
	  %>
	  	<script language="javascript">addServ();</script>
	  <%	  
  }
}%>