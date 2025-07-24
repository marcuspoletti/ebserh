<%@page import="util.ConnectionFactory"%>
<%@page import="java.sql.Connection"%>
<%
Connection conn = null;

try {
	
	conn = ConnectionFactory.getConnection();

} catch (Exception e) {
	throw new Exception("Erro: " + ":\n" + e.getMessage());
}
 
%>