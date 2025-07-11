<%@ page contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="afero.model.OrdemServicoObjeto" %>
<%@ page import="afero.persistence.OrdemServicoObjetoDAO" %>
<%@ page import="afero.util.Utilitaria" %>
<%@ page import="afero.util.ConverteDate" %>

<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />
<script>
function confirmaExcluir(cont, id) {  
  if (confirm("Deseja mesmo apagar o registro [" + cont + "]?")) {  
       location.href = 'listarOrdemServicoObjeto.jsp?acao=exc&idOrdemServicoObjeto=' + id;   
  }  
}
</script>

<%
OrdemServicoObjetoDAO dao;
OrdemServicoObjetoDAO daoExclusao;

String acao = request.getParameter("acao");

String idOrdemServicoObjeto;
String idOrdemServico;
String idListaObjeto;
String campo1;
String campo2;
String campo3;
String campo4;
String observacao;
String dtGarantia;
String nrControle;
String dtMod;
String usuario = (String) session.getAttribute("Login");

if (acao.equalsIgnoreCase("inc") || acao.equalsIgnoreCase("atu") || acao.equalsIgnoreCase("exc")) {
	
	idOrdemServicoObjeto = request.getParameter("idOrdemServicoObjeto");
	idOrdemServico = request.getParameter("idOrdemServico");
	idListaObjeto = request.getParameter("idListaObjeto");
	campo1 = request.getParameter("campo1");
	campo2 = request.getParameter("campo2");
	campo3 = request.getParameter("campo3");
	campo4 = request.getParameter("campo4");
	observacao = request.getParameter("observacao");
	dtGarantia = request.getParameter("dtGarantia");
	nrControle = request.getParameter("nrControle");
	dtMod = request.getParameter("dtMod");
	
	if(idOrdemServicoObjeto == null) idOrdemServicoObjeto = "0";
	if(idOrdemServico == null) idOrdemServico = "0";
	if(idListaObjeto == null) idListaObjeto = "0";
	if(campo1 == null) campo1 = "";
	if(campo2 == null) campo2 = "";
	if(campo3 == null) campo3 = "";
	if(campo4 == null) campo4 = "";
	if(observacao == null) observacao = "";
	if(dtGarantia == null) dtGarantia = "";
	if(nrControle == null) nrControle = "";
	if(dtMod == null) dtMod = "";

	OrdemServicoObjeto ordemServicoObjeto = new OrdemServicoObjeto();
  
	try {
	  if (!acao.equalsIgnoreCase("inc")){
		  ordemServicoObjeto.setIdOrdemServicoObjeto(Integer.parseInt(idOrdemServicoObjeto));
	  }
	  
	  	ordemServicoObjeto.setIdOrdemServicoObjeto(Integer.parseInt(idOrdemServicoObjeto));
	  	ordemServicoObjeto.setIdOrdemServico(Integer.parseInt(idOrdemServico));
	  	ordemServicoObjeto.setIdListaObjeto(Integer.parseInt(idListaObjeto));
	  	ordemServicoObjeto.setCampo1(campo1);
	  	ordemServicoObjeto.setCampo2(campo2);
	  	ordemServicoObjeto.setCampo3(campo3);
	  	ordemServicoObjeto.setCampo4(campo4);
	  	ordemServicoObjeto.setObservacao(observacao);
	  	if(dtGarantia != ""){
	  	//	ordemServicoObjeto.setDtGarantia(ConverteDate.stringToDate(dtGarantia));
	  	}
	  	ordemServicoObjeto.setNrControle(Integer.parseInt(nrControle));
	  	if(dtMod != ""){
	  	//	ordemServicoObjeto.setDtMod(ConverteDate.stringToDate(dtMod));
	  	}
	  		
	  	
      if (!acao.equalsIgnoreCase("exc")){
    	 ordemServicoObjeto.setIdOrdemServicoObjeto(Integer.parseInt(idOrdemServicoObjeto));
      }      
      
	} catch (NumberFormatException nfe) {
		throw new Exception("Código inválido");
	}

	dao = new OrdemServicoObjetoDAO(conn);
	daoExclusao = new OrdemServicoObjetoDAO(conn);

  if (acao.equalsIgnoreCase("inc")) {  
	  //inclui no banco de dados
  	dao.incluir(ordemServicoObjeto);

  } else if (acao.equalsIgnoreCase("atu")) {
	  //atualiza no banco de dados
    	 dao.atualiza(ordemServicoObjeto);
  }else if (acao.equalsIgnoreCase("exc")){
	  //exclui no banco de dados
		  dao.excluir(ordemServicoObjeto);
  }
}