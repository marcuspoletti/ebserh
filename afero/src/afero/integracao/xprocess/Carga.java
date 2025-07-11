package afero.integracao.xprocess;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.zip.GZIPOutputStream;
import org.apache.commons.codec.binary.Base64;

import afero.persistence.AferoDAOException;
import afero.util.ConnectionFactory;
import afero.util.Utilitaria;

import java.sql.Connection;

public class Carga extends HttpServlet {
	
	
	
	
	
	private Connection conn;
	
	

    public Carga() throws AferoDAOException{
    	try {
    		conn = ConnectionFactory.getConnection();

    	}catch (Exception e) {
    		throw new AferoDAOException("Erro: " + ":\n" + e.getMessage());
    	}
    }

    public void doGet(HttpServletRequest request,
        HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    public void doPost(HttpServletRequest request,
        HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request,
        HttpServletResponse response) throws ServletException, IOException {

        try {
            byte[] bytes = gerar(request, conn).getBytes();

            response.setDateHeader("Expires", 30);
            response.setContentLength(bytes.length);
            response.setContentType("text/plain");
            response.setCharacterEncoding("ISO-8859-1");
            response.getOutputStream().write(bytes);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    public String gerar(HttpServletRequest request, Connection con) throws Exception { 
        try {
            String id_empresa = request.getParameter("id_empresa");
            String tipo = request.getParameter("tipo");

            if ("SECAO".equals(tipo)) {
			    String txtSecao = "";
                return compactarZipBase64(txtSecao);
            } else if ("PRODUTOS".equals(tipo)) {
			    String txtProduto = "";
                return compactarZipBase64(txtProduto);
            } else if ("MODALIDADES".equals(tipo)) {
			    String txtModalidade = "";
                return compactarZipBase64(txtModalidade);
            } else if ("VENDEDORES".equals(tipo)) {
			    String txtVendedor = "";
                return compactarZipBase64(txtVendedor);
            } else if ("EMPRESA".equals(tipo)) {
            	GerarArquivoEmpresa gerarEmpresa = new GerarArquivoEmpresa();
            	String empresa = gerarEmpresa.procurarLoja(Utilitaria.toNumber(id_empresa).intValue(),con);
            	//gerarEmpresa.GerarArquivoTxt(empresa);
			    String txtEmpresa = "/EMPRESA.txt";
                return txtEmpresa;
            } else {
                return null;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return compactarZipBase64("ERRO\n\n"+e.getMessage());
        }

    }
	
    private String compactarZipBase64(String conteudo) throws Exception {
        ByteArrayOutputStream bt = new ByteArrayOutputStream();
        GZIPOutputStream gz = new GZIPOutputStream(bt);
        gz.write(conteudo.getBytes("ISO-8859-1"));
        gz.close();
        String encodedBytes = new String(Base64.encodeBase64(bt.toByteArray()), "ISO-8859-1");
        bt.close();
        return encodedBytes;
    }
	
}
