<%@ page import="java.io.File"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.io.FileInputStream"%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.io.PrintWriter"%>
<%
//	File arquivo = new File(getServletContext().getRealPath("/"),
//			request.getParameter("arquivo"));
	File arquivo = new File(request.getParameter("path"),request.getParameter("arquivo"));
	if (!arquivo.exists()) {
%>
<script type="text/javascript">  
            alert('Arquivo desejado não encontrado. Verifique a geração do arquivo.');  
        </script>
<%
	} else {
		response.setContentType("application/octet-stream");
		// comento a linha abaixo para não forçar o download. vai abrir na própria janela.  
		response.setHeader(
				"Content-Disposition",
				"attachment; filename="
						+ request.getParameter("arquivo"));

		InputStream in = new FileInputStream(arquivo);
		PrintWriter output = response.getWriter();

		int bit = 256;

		try {
			while ((bit) > 0) {
				bit = in.read();
				if (bit!=-1)
					output.write(bit);
			}

		} catch (IOException e) {
			e.printStackTrace(System.out);
		}

		output.flush();
		output.close();
		in.close();
	}
%>
