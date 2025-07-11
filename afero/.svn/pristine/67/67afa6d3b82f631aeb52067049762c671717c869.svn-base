package afero.servlet;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

import afero.model.Recibo;
import afero.model.Entidade;
import afero.model.PedidoSaida;
import afero.model.Loja;
import afero.model.Cidade;
import afero.model.Estado;
import afero.model.EntidadeEndereco;
import afero.model.EntidadeFisica;
import afero.model.RelatorioObjetoOrdemServico;
import afero.model.EntidadeJuridica;
import afero.persistence.EntidadeFisicaDAO;
import afero.persistence.EntidadeJuridicaDAO;
import afero.persistence.EntidadeDAO;
import afero.persistence.EntidadeEnderecoDAO;
import afero.persistence.CidadeDAO;
import afero.util.ConnectionFactory;
import afero.persistence.AferoDAOException;
import afero.persistence.LojaDAO;
import afero.persistence.EstadoDAO;
import afero.persistence.ReciboDAO;
import afero.persistence.PedidoSaidaDAO;
import afero.util.Utilitaria;


public class ReciboServlet extends HttpServlet {
	
	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReciboServlet() {
        super();
     
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
    	
    	
		String pathLogo = "";
		String cliente = "";
		String endereco = "";
		String complemento = "";
		String contato = "";
		String cidade = "";
		String Uf = "";
		String bairro = "";
		String cep = "";
		String razaoSocial = "";
		String enderecoRazaoSocial = "";
		String cnpjRazaoSocial = "";
		String idLoja = request.getParameter("idLoja");
		String idPedidoSaida = request.getParameter("idPedidoSaida");
		String idCliente = request.getParameter("idCliente");
		
		
		try{
			Recibo recibo = new Recibo();
			ReciboDAO daoRecibo = new ReciboDAO(ConnectionFactory.getConnection());
			recibo.setCdEntidade(Integer.parseInt(idCliente));
			
			
			LojaDAO daoLoja = new LojaDAO(ConnectionFactory.getConnection());
			Loja loja = daoLoja.procurarLoja(Integer.parseInt(idLoja));
			razaoSocial = loja.getRazaoSocial().toUpperCase();
			if(loja.getCmpEndereco() != null){
				enderecoRazaoSocial = loja.getEndereco()+ " " + loja.getCmpEndereco() + " - " + loja.getBairro() + " - "+ loja.getCidade() + "/" + loja.getEstado() +
				                      loja.getCep();
			}else{
				enderecoRazaoSocial = loja.getEndereco()+" - " + loja.getBairro() + " - "+ loja.getCidade() + "/" + loja.getEstado() +
                loja.getCep();
			}
			cnpjRazaoSocial = loja.getCnpj();
			recibo.setEmitente(loja.getRazaoSocial());
			recibo.setEndereco(enderecoRazaoSocial);
			recibo.setIdLoja(loja.getIdLoja());
			EntidadeDAO daoEntidade = new EntidadeDAO(ConnectionFactory.getConnection());
			Entidade entidade = daoEntidade.procurarEntidade(Integer.parseInt(idCliente));
			if(entidade.getTpInsc().equalsIgnoreCase("F")){
				EntidadeFisicaDAO daoEntidadeFisica = new EntidadeFisicaDAO(ConnectionFactory.getConnection()); 
				EntidadeFisica entidadeFisica = daoEntidadeFisica.procurarEntidadeFisica(entidade.getCdEntidade());
				cliente = entidadeFisica.getNome().toUpperCase();
				recibo.setCpfCnpj(entidadeFisica.getCpf());
			}else{
				EntidadeJuridicaDAO daoEntidadeJuridica = new EntidadeJuridicaDAO(ConnectionFactory.getConnection()); 
				EntidadeJuridica entidadeJuridica = daoEntidadeJuridica.procurarEntidadeJuridica(entidade.getCdEntidade());
				cliente = entidadeJuridica.getRazaoSocial().toUpperCase();
				recibo.setCpfCnpj(entidadeJuridica.getCnpj());
			}
			EntidadeEnderecoDAO daoEntidadeEndereco = new EntidadeEnderecoDAO(ConnectionFactory.getConnection());
			EntidadeEndereco entidadeEndereco = daoEntidadeEndereco.procurarEntidadeEnderecoPadrao(entidade.getCdEntidade());
			endereco = entidadeEndereco.getDsEndereco() + ", "+ entidadeEndereco.getNroEndereco();
			complemento = entidadeEndereco.getCmpEndereco();
			CidadeDAO daoCidade = new CidadeDAO(ConnectionFactory.getConnection());
			if(entidadeEndereco.getIdCidade() != 0){
				Cidade cidadeBusca = daoCidade.procurarCidade(entidadeEndereco.getIdCidade());
				cidade = cidadeBusca.getNmCidade();
				EstadoDAO daoEstado = new EstadoDAO(ConnectionFactory.getConnection());
				Estado estado = daoEstado.procurarEstado(cidadeBusca.getCdEstado());
				Uf = estado.getSiglaEstado();
			}else{
				cidade = "";
				Uf = "";
			}
			bairro = entidadeEndereco.getBaiEndereco();
			cep = entidadeEndereco.getCepEndereco();
			recibo.setCidade(cidade);
			PedidoSaidaDAO daoPedidoSaida = new PedidoSaidaDAO(ConnectionFactory.getConnection());
			PedidoSaida pedidoSaida = daoPedidoSaida.procurarPedidoSaida(Integer.parseInt(idPedidoSaida));
			recibo.setDtEmissao(pedidoSaida.getDtPed());
			recibo.setDtMov(pedidoSaida.getDtMov());
			recibo.setValor(pedidoSaida.getVlPed());
			recibo.setUsuario(pedidoSaida.getUsuario());
			recibo.setReferente("Não preencheu este campo");
			recibo.setObservacao(pedidoSaida.getObservacao());
			daoRecibo.incluir(recibo);
		}catch(Exception e){
			e.printStackTrace();
			
		}
		
		RelatorioObjetoOrdemServico relatorioObjetoOrdemServico = new RelatorioObjetoOrdemServico();
		Map<String, Object> parametros = new HashMap<String, Object>();
		try {
			List <RelatorioObjetoOrdemServico> listObjeto = new ArrayList<RelatorioObjetoOrdemServico>();
			listObjeto.add(relatorioObjetoOrdemServico);
			JRDataSource jrds = new JRBeanCollectionDataSource(listObjeto);
			parametros.put("cliente", cliente);
			parametros.put("endereco", endereco);
			parametros.put("complemento", complemento);
			parametros.put("contato", contato);
			parametros.put("cidade", cidade);
			parametros.put("Uf", Uf);
			parametros.put("bairro", bairro);
			parametros.put("cep", cep);
			parametros.put("razaoSocial", razaoSocial);
			parametros.put("enderecoRazaoSocial", enderecoRazaoSocial);
			parametros.put("cnpjRazaoSocial", cnpjRazaoSocial);
			String relatorioJasper = "ordemServico.jasper";
			String rootDir = getServletContext().getRealPath("relatorio");
			String reportFileName = rootDir + java.io.File.separator + relatorioJasper;
			pathLogo =  rootDir + java.io.File.separator + "logomarca.jpg";
			parametros.put("logo", pathLogo);
			JasperPrint print = JasperFillManager.fillReport(reportFileName, parametros, jrds);
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			baos.write(JasperExportManager.exportReportToPdf(print));
			response.reset();
			response.setContentType("application/pdf");
			response.setContentLength(baos.size());
			ServletOutputStream outStream = response.getOutputStream();
			baos.writeTo(outStream);
			outStream.flush();
			outStream.close();
			baos.close();
		} catch (JRException e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		} 
    }
    
    protected void Service(HttpServletRequest request, HttpServletResponse response) {}
    	
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response){}
}