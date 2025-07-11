<%@page import="afero.persistence.AferoDAOException"%>
<%@page import="afero.util.ConnectionFactory"%>
<%@page import="java.sql.Connection"%>
<%
Connection conn = null;

try {
	
	conn = ConnectionFactory.getConnection();

} catch (Exception e) {
	throw new AferoDAOException("Erro: " + ":\n" + e.getMessage());
}
 
%>