<%@page import ="afero.model.Ncm" %>
<%@page import ="afero.persistence.NcmDAO" %>
<%@ page import="java.sql.*" %>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<%
String codigo = request.getParameter("cdNcm");
	if (codigo != null && !codigo.equals("")) {
		String sep1 = "#";
		String data = "";
		try {
			String cdNcm = "";
			try {
				cdNcm = codigo;
			} catch (Exception ex) {
				throw new Exception ("código inválido");
			}
                  NcmDAO ncmDAO = new NcmDAO(conn);
 		Ncm ncm = ncmDAO.procurarNcm(cdNcm);
 		if (ncm.getCdNcm() != null) {
 			data = ncm.getCdNcm()+sep1+ncm.getDsNcm()+sep1+"OK#";
 		} else {
 			throw new Exception ("registro não encontrado");
 		}
		} catch (Exception e) {
			data = sep1+sep1+e.getMessage()+"#";
		}
	out.println(data.trim());
	} else {
		out.println("");
	}
	
	
	
%>
<%@include file="../fimConexao.jsp"%>