<%@page import ="afero.model.Cest" %>
<%@page import ="afero.persistence.CestDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<%
List cests;
String codigo = request.getParameter("q");
			
CestDAO cestDAO = new CestDAO(conn);
cests = cestDAO.listarCestAutoComplete(codigo);


for(Iterator it = cests.iterator();it.hasNext();) {
	Cest cest = (Cest)it.next();
	out.println(cest.getNrCest()+"-"+cest.getDsCest());
}
	
		
	
	
%>
<%@include file="../fimConexao.jsp"%>