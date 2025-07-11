<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="afero.auxiliar.GerarArquivoEmitente"%>
<%
	String arquivo = request.getParameter("arquivo");
	String msg = request.getParameter("msg");
	if (arquivo == null)
		arquivo = "emitente.txt";
	if (msg == null)
		msg = "";
	String selectStr1 = "";
	try {
		selectStr1 = " WHERE status='A'";
		GerarArquivoEmitente gap = new GerarArquivoEmitente();
		msg = gap.gerarArquivo(arquivo, selectStr1);
	} catch (Exception e) {
		msg = e.getMessage();
	}
	out.print(msg);
%>