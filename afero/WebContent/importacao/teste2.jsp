<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>

<%
try {
DiskFileUpload fu = new DiskFileUpload();

List fileItems = fu.parseRequest(request);

Iterator i = fileItems.iterator();

FileItem fi = (FileItem)i.next();

InputStream in = fi.getInputStream();

File file = new File("c:/arquivoSaida");

FileOutputStream fos = new FileOutputStream(file);

int c;
while((c = in.read()) != -1)
fos.write(c);

fos.close();
out.println("arquivo salvo: c:/arquivoSaida.csv");
}
catch(Exception e) {
out.println(e.toString());
}
%>

