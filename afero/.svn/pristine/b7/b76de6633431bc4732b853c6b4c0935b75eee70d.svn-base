<%@page import ="afero.model.Ncm" %>
<%@page import ="afero.persistence.NcmDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<%
List ncms;
String codigo = request.getParameter("q");
			
NcmDAO ncmDAO = new NcmDAO(conn);
ncms = ncmDAO.listarNcmAutoComplete(codigo);


for(Iterator it = ncms.iterator();it.hasNext();) {
	Ncm ncm = (Ncm)it.next();
	out.println(ncm.getCdNcm() + "-"+ncm.getDsNcm());
}
	
		
	
	
%>
<%@include file="../fimConexao.jsp"%>