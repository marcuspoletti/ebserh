<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="afero.auxiliar.GerarArquivoCliente"%>
<%
	String arquivo = request.getParameter("arquivo");
	String msg = request.getParameter("msg");
	if (arquivo == null)
		arquivo = "cliente.txt";
	if (msg == null)
		msg = "";
	String selectStr1 = "";
	try {
		selectStr1 = " WHERE (cdEntidade IN (SELECT cdEntidade FROM tbclassificacao t WHERE idTipoEntidade=1)) AND status='A'";
		GerarArquivoCliente gap = new GerarArquivoCliente();
		msg = gap.gerarArquivo(arquivo, selectStr1);
	} catch (Exception e) {
		msg = e.getMessage();
	}
	out.print(msg);
%>