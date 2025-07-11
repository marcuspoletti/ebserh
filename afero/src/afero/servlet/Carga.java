package afero.servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.Date;
import java.util.zip.GZIPOutputStream;
import org.apache.commons.codec.binary.Base64;
import afero.integracao.xprocess.GerarArquivoVendedores;
import afero.integracao.xprocess.GerarArquivoEmpresa;
import afero.integracao.xprocess.GerarArquivoModalidade;
import afero.integracao.xprocess.GerarArquivoProdutos;
import afero.integracao.xprocess.GerarArquivoSecao;
import afero.persistence.AferoDAOException;
import afero.util.ConnectionFactory;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public class Carga extends HttpServlet {
	
	
	




	private Connection conn;
	private ServletRequest session;
	//private int idLoja = Integer.parseInt((String)session.getAttribute("idLoja"));


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
        	System.out.println(request.getParameter("tipo"));
            throw new ServletException(e);
        }
    }

    public String gerar(HttpServletRequest request, Connection con) throws Exception {
        try {
            String id_empresa = request.getParameter("id_empresa");
            String tipo = request.getParameter("tipo");
            String cdUF = request.getParameter("cdUF");
			String nrPedido = request.getParameter("nrPedido");
            if ("DATA_HORA_X2".equals(tipo)) {
                return compactarZipBase64(dataAtual());
			} else if ("AUTORIZADOR".equals(tipo)) {
                return compactarZipBase64(autorizador());
			} else if ("GERENTES".equals(tipo)) {
                return compactarZipBase64("");
			} else if ("CODIGO_BARRAS".equals(tipo)) {
                return compactarZipBase64("");
			} else if ("PARAMETROS".equals(tipo)) {
                return compactarZipBase64("");
			} else if ("STATUS_PEDIDO".equals(tipo)) {
                return compactarZipBase64("FECHADO");
            } else if ("HASH_PEDIDO".equals(tipo)) {
                return compactarZipBase64(getHashPedido(con,nrPedido,Integer.parseInt(id_empresa)));
			}else if ("SECAO".equals(tipo)) {
            	GerarArquivoSecao gerarSecao = new GerarArquivoSecao();
			    String txtSecao = gerarSecao.listarDivisao(Integer.parseInt(id_empresa), con);
                return compactarZipBase64(txtSecao);
            } else if ("PRODUTOS".equals(tipo)) {
            	GerarArquivoProdutos gerarProdutos = new GerarArquivoProdutos();
			    String txtProduto = gerarProdutos.listarProdutos(con, Integer.parseInt(id_empresa));
                return compactarZipBase64(txtProduto);
            } else if ("MODALIDADES".equals(tipo)) {
            	GerarArquivoModalidade gerarModalidade = new GerarArquivoModalidade();
			    String txtModalidade = gerarModalidade.listarModalidadePedido(con);
                return compactarZipBase64(txtModalidade);
            } else if ("VENDEDORES".equals(tipo)) {
            	GerarArquivoVendedores gerarVendedores = new GerarArquivoVendedores();
			    String txtVendedor = gerarVendedores.listarVendedores(Integer.parseInt(id_empresa), con);
                return compactarZipBase64(txtVendedor);
            } else if ("EMPRESA".equals(tipo)) {
				return "";
            } else {
                return null;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return compactarZipBase64("ERRO\n\n"+e.getMessage());
        }

    }

    private String getHashPedido(Connection con, String nrPedido,int idEmpresa) throws Exception{
    	String retorno = "";
        PreparedStatement ps = conn.prepareStatement(
            "select CONCAT(cast(sum(ps.idProduto) as char), " +
            "cast(cast((100 * sum(ps.quant)) as SIGNED ) as char), " +
            "cast(cast((100*sum(ps.valor)) as SIGNED ) as char) , " +
            "cast(cast((100*sum(if(ps.pDesc > 0, ps.pDesc, p.vlDesc))) as SIGNED ) as char)) as hash " +
            "from tbpedidosaidaitem ps " +
            "JOIN tbpedidosaida p on ps.idPedidoSaida = p.idPedidoSaida " +
            "JOIN tbproduto pr on ps.idProduto = pr.idProduto " +
            "LEFT JOIN tbcattributaria cat on pr.idCatTributaria = cat.idCatTributaria " +
            "LEFT JOIN tbtributacao t on cat.idCatTributaria = t.idCatTributaria " +
            "LEFT JOIN tbcsticms icms on t.cdCstIcms = icms.cdCstIcms " +
            "LEFT JOIN tbcolaborador c on p.idColaborador = c.idColaborador  " +
            "LEFT JOIN tbunidade u on ps.idUnidade = u.idUnidade " +
            "where p.idPedidoSaida = ? AND p.integracao = 'S'");
        ps.setInt(1, Integer.parseInt(nrPedido));
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            retorno = rs.getString("hash");
        }
        rs.close();
        ps.close();
        return retorno;
    }
        

    private String autorizador(){
        return 
			"[{\"idAutorizador\":552,\"cdAutorizador\":\"SVRS\",\"cdModelo\":\"65\",\"tpAmbiente\":1,\"dsServico\":\"NFeRetAutorizacao\",\"dsVersao\":\"3.10\",\"dsUrl\":\"https://nfce.svrs.rs.gov.br/ws/NfeRetAutorizacao/NFeRetAutorizacao.asmx\",\"orderBy\":\"\",\"addWhere\":\"\"}," + 
			"{\"idAutorizador\":554,\"cdAutorizador\":\"SVRS\",\"cdModelo\":\"65\",\"tpAmbiente\":1,\"dsServico\":\"NfeInutilizacao\",\"dsVersao\":\"3.10\",\"dsUrl\":\"https://nfce.svrs.rs.gov.br/ws/nfeinutilizacao/nfeinutilizacao2.asmx\",\"orderBy\":\"\",\"addWhere\":\"\"}," + 
			"{\"idAutorizador\":558,\"cdAutorizador\":\"SVRS\",\"cdModelo\":\"65\",\"tpAmbiente\":1,\"dsServico\":\"NfeConsultaProtocolo\",\"dsVersao\":\"4.00\",\"dsUrl\":\"https://nfce.svrs.rs.gov.br/ws/NfeConsulta/NfeConsulta4.asmx\",\"orderBy\":\"\",\"addWhere\":\"\"}," + 
			"{\"idAutorizador\":557,\"cdAutorizador\":\"SVRS\",\"cdModelo\":\"65\",\"tpAmbiente\":1,\"dsServico\":\"NFeRetAutorizacao\",\"dsVersao\":\"4.00\",\"dsUrl\":\"https://nfce.svrs.rs.gov.br/ws/NfeRetAutorizacao/NFeRetAutorizacao4.asmx\",\"orderBy\":\"\",\"addWhere\":\"\"}," + 
			"{\"idAutorizador\":563,\"cdAutorizador\":\"SVRS\",\"cdModelo\":\"65\",\"tpAmbiente\":2,\"dsServico\":\"NFeAutorizacao\",\"dsVersao\":\"3.10\",\"dsUrl\":\"https://nfce-homologacao.svrs.rs.gov.br/ws/NfeAutorizacao/NFeAutorizacao.asmx\",\"orderBy\":\"\",\"addWhere\":\"\"}," + 
			"{\"idAutorizador\":565,\"cdAutorizador\":\"SVRS\",\"cdModelo\":\"65\",\"tpAmbiente\":2,\"dsServico\":\"NfeConsultaProtocolo\",\"dsVersao\":\"3.10\",\"dsUrl\":\"https://nfce-homologacao.svrs.rs.gov.br/ws/NfeConsulta/NfeConsulta2.asmx\",\"orderBy\":\"\",\"addWhere\":\"\"}," + 
			"{\"idAutorizador\":567,\"cdAutorizador\":\"SVRS\",\"cdModelo\":\"65\",\"tpAmbiente\":2,\"dsServico\":\"NfeStatusServico\",\"dsVersao\":\"3.10\",\"dsUrl\":\"https://nfce-homologacao.svrs.rs.gov.br/ws/NfeStatusServico/NfeStatusServico2.asmx\",\"orderBy\":\"\",\"addWhere\":\"\"}," + 
			"{\"idAutorizador\":573,\"cdAutorizador\":\"SVRS\",\"cdModelo\":\"65\",\"tpAmbiente\":2,\"dsServico\":\"RecepcaoEvento\",\"dsVersao\":\"4.00\",\"dsUrl\":\"https://nfce-homologacao.svrs.rs.gov.br/ws/recepcaoevento/recepcaoevento4.asmx\",\"orderBy\":\"\",\"addWhere\":\"\"}," + 
			"{\"idAutorizador\":553,\"cdAutorizador\":\"SVRS\",\"cdModelo\":\"65\",\"tpAmbiente\":1,\"dsServico\":\"NfeConsultaProtocolo\",\"dsVersao\":\"3.10\",\"dsUrl\":\"https://nfce.svrs.rs.gov.br/ws/NfeConsulta/NfeConsulta2.asmx\",\"orderBy\":\"\",\"addWhere\":\"\"}," + 
			"{\"idAutorizador\":560,\"cdAutorizador\":\"SVRS\",\"cdModelo\":\"65\",\"tpAmbiente\":1,\"dsServico\":\"NfeStatusServico\",\"dsVersao\":\"4.00\",\"dsUrl\":\"https://nfce.svrs.rs.gov.br/ws/NfeStatusServico/NfeStatusServico4.asmx\",\"orderBy\":\"\",\"addWhere\":\"\"}," + 
			"{\"idAutorizador\":569,\"cdAutorizador\":\"SVRS\",\"cdModelo\":\"65\",\"tpAmbiente\":2,\"dsServico\":\"NFeRetAutorizacao\",\"dsVersao\":\"4.00\",\"dsUrl\":\"https://nfce-homologacao.svrs.rs.gov.br/ws/NfeRetAutorizacao/NFeRetAutorizacao4.asmx\",\"orderBy\":\"\",\"addWhere\":\"\"}," + 
			"{\"idAutorizador\":570,\"cdAutorizador\":\"SVRS\",\"cdModelo\":\"65\",\"tpAmbiente\":2,\"dsServico\":\"NfeConsultaProtocolo\",\"dsVersao\":\"4.00\",\"dsUrl\":\"https://nfce-homologacao.svrs.rs.gov.br/ws/NfeConsulta/NfeConsulta4.asmx\",\"orderBy\":\"\",\"addWhere\":\"\"}," + 
			"{\"idAutorizador\":561,\"cdAutorizador\":\"SVRS\",\"cdModelo\":\"65\",\"tpAmbiente\":1,\"dsServico\":\"RecepcaoEvento\",\"dsVersao\":\"4.00\",\"dsUrl\":\"https://nfce.svrs.rs.gov.br/ws/recepcaoevento/recepcaoevento4.asmx\",\"orderBy\":\"\",\"addWhere\":\"\"}," + 
			"{\"idAutorizador\":572,\"cdAutorizador\":\"SVRS\",\"cdModelo\":\"65\",\"tpAmbiente\":2,\"dsServico\":\"NfeStatusServico\",\"dsVersao\":\"4.00\",\"dsUrl\":\"https://nfce-homologacao.svrs.rs.gov.br/ws/NfeStatusServico/NfeStatusServico4.asmx\",\"orderBy\":\"\",\"addWhere\":\"\"}," + 
			"{\"idAutorizador\":551,\"cdAutorizador\":\"SVRS\",\"cdModelo\":\"65\",\"tpAmbiente\":1,\"dsServico\":\"NFeAutorizacao\",\"dsVersao\":\"3.10\",\"dsUrl\":\"https://nfce.svrs.rs.gov.br/ws/NfeAutorizacao/NFeAutorizacao.asmx\",\"orderBy\":\"\",\"addWhere\":\"\"}," + 
			"{\"idAutorizador\":564,\"cdAutorizador\":\"SVRS\",\"cdModelo\":\"65\",\"tpAmbiente\":2,\"dsServico\":\"NFeRetAutorizacao\",\"dsVersao\":\"3.10\",\"dsUrl\":\"https://nfce-homologacao.svrs.rs.gov.br/ws/NfeRetAutorizacao/NFeRetAutorizacao.asmx\",\"orderBy\":\"\",\"addWhere\":\"\"}," + 
			"{\"idAutorizador\":566,\"cdAutorizador\":\"SVRS\",\"cdModelo\":\"65\",\"tpAmbiente\":2,\"dsServico\":\"NfeInutilizacao\",\"dsVersao\":\"3.10\",\"dsUrl\":\"https://nfce-homologacao.svrs.rs.gov.br/ws/nfeinutilizacao/nfeinutilizacao2.asmx\",\"orderBy\":\"\",\"addWhere\":\"\"}," + 
			"{\"idAutorizador\":555,\"cdAutorizador\":\"SVRS\",\"cdModelo\":\"65\",\"tpAmbiente\":1,\"dsServico\":\"NfeStatusServico\",\"dsVersao\":\"3.10\",\"dsUrl\":\"https://nfce.svrs.rs.gov.br/ws/NfeStatusServico/NfeStatusServico2.asmx\",\"orderBy\":\"\",\"addWhere\":\"\"}," + 
			"{\"idAutorizador\":568,\"cdAutorizador\":\"SVRS\",\"cdModelo\":\"65\",\"tpAmbiente\":2,\"dsServico\":\"NFeAutorizacao\",\"dsVersao\":\"4.00\",\"dsUrl\":\"https://nfce-homologacao.svrs.rs.gov.br/ws/NfeAutorizacao/NFeAutorizacao4.asmx\",\"orderBy\":\"\",\"addWhere\":\"\"}," + 
			"{\"idAutorizador\":604,\"cdAutorizador\":\"SVRS\",\"cdModelo\":\"65\",\"tpAmbiente\":1,\"dsServico\":\"RecepcaoEvento\",\"dsVersao\":\"3.10\",\"dsUrl\":\"https://nfce.svrs.rs.gov.br/ws/recepcaoevento/recepcaoevento.asmx\",\"orderBy\":\"\",\"addWhere\":\"\"}," + 
			"{\"idAutorizador\":571,\"cdAutorizador\":\"SVRS\",\"cdModelo\":\"65\",\"tpAmbiente\":2,\"dsServico\":\"NfeInutilizacao\",\"dsVersao\":\"4.00\",\"dsUrl\":\"https://nfce-homologacao.svrs.rs.gov.br/ws/nfeinutilizacao/nfeinutilizacao4.asmx\",\"orderBy\":\"\",\"addWhere\":\"\"}," + 
			"{\"idAutorizador\":562,\"cdAutorizador\":\"SVRS\",\"cdModelo\":\"65\",\"tpAmbiente\":2,\"dsServico\":\"RecepcaoEvento\",\"dsVersao\":\"3.10\",\"dsUrl\":\"https://nfce-homologacao.svrs.rs.gov.br/ws/recepcaoevento/recepcaoevento.asmx\",\"orderBy\":\"\",\"addWhere\":\"\"}," + 
			"{\"idAutorizador\":559,\"cdAutorizador\":\"SVRS\",\"cdModelo\":\"65\",\"tpAmbiente\":1,\"dsServico\":\"NfeInutilizacao\",\"dsVersao\":\"4.00\",\"dsUrl\":\"https://nfce.svrs.rs.gov.br/ws/nfeinutilizacao/nfeinutilizacao4.asmx\",\"orderBy\":\"\",\"addWhere\":\"\"}," + 
			"{\"idAutorizador\":556,\"cdAutorizador\":\"SVRS\",\"cdModelo\":\"65\",\"tpAmbiente\":1,\"dsServico\":\"NFeAutorizacao\",\"dsVersao\":\"4.00\",\"dsUrl\":\"https://nfce.svrs.rs.gov.br/ws/NfeAutorizacao/NFeAutorizacao4.asmx\",\"orderBy\":\"\",\"addWhere\":\"\"}]";
    }
	
	private String dataAtual() throws Exception {
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        Date date = new Date();
        return sdf.format(date);
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
