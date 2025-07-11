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
import afero.model.OrdemServico;
import afero.model.PedidoSaida;
import afero.model.Produto;
import afero.model.Unidade;
import afero.model.PedidoSaidaItem;
import afero.model.SubRelatorioOrdemServico;
import afero.model.ListaObjeto;
import afero.model.ListaServico;
import afero.model.OrdemServicoItem;
import afero.model.OrdemServicoObjeto;
import afero.model.Entidade;
import afero.model.ConfigServico;
import afero.model.Loja;
import afero.model.Cidade;
import afero.model.Estado;
import afero.model.EntidadeEndereco;
import afero.model.EntidadeFisica;
import afero.model.RelatorioObjetoOrdemServico;
import afero.model.EntidadeJuridica;
import afero.model.SubRelatorioOrdemServicoProduto;
import afero.persistence.EntidadeFisicaDAO;
import afero.persistence.EntidadeJuridicaDAO;
import afero.persistence.EntidadeDAO;
import afero.persistence.UnidadeDAO;
import afero.persistence.PedidoSaidaItemDAO;
import afero.persistence.PedidoSaidaDAO;
import afero.persistence.EntidadeEnderecoDAO;
import afero.persistence.CidadeDAO;
import afero.util.ConnectionFactory;
import afero.persistence.AferoDAOException;
import afero.persistence.OrdemServicoDAO;
import afero.persistence.LojaDAO;
import afero.persistence.ProdutoDAO;
import afero.persistence.EstadoDAO;
import afero.persistence.ConfigServicoDAO;
import afero.persistence.ListaObjetoDAO;
import afero.persistence.ListaServicoDAO;
import afero.persistence.OrdemServicoItemDAO;
import afero.persistence.OrdemServicoObjetoDAO;
import afero.util.Utilitaria;


public class OrdemServicoProdutoServlet extends HttpServlet {
	
	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OrdemServicoProdutoServlet() {
        super();
     
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
    	
    	//Serviço
    	String dsCompServico = "";
		float quant = 0;
		float vlUni = 0;
		float valor = 0;
		String dsServico = "";
		String codigo = "";
		float desconto = 0;
		//Cabeçalho
		float custoDeslocamento = 0;
		float desc = 0;
		float valorTotal = 0;
		//Produto
		float quantProd = 0;
		String dsProduto = "";
		float descProd = 0;
		float vlUnitProd =0;
		float vlTotalProd = 0;
		String und = "";
		//
		String pathLogo = "";
		String campoOS1 = "";
		String campoOS2 = "";
		String campoOS3 = "";
		String campoOS4 = "";
		String dsListaObjeto = "";
		String respDsListaObjeto = "";
		String listaObjetoCampo1 = "";
		String respListaObjetoCampo1 = "";
		String listaObjetoCampo2 = "";
		String respListaObjetoCampo2 = "";
		String respListaObjetoCampo3 = "";
		String respListaObjetoCampo4 = "";
		String listaObjetoCampo3 = "";
		String listaObjetoCampo4 = "";
		String respCampos1 = "";
		String respCampos2 = "";
		String respCampos3 = "";
		String respCampos4 = "";
		String observacao = "";
		String ordemServicoOrcamento = "";
		String cliente = "";
		String endereco = "";
		String complemento = "";
		String cpf_cnpj = "";
		String contato = "";
		String cidade = "";
		String Uf = "";
		String bairro = "";
		String cep = "";
		String razaoSocial = "";
		String enderecoRazaoSocial = "";
		String cnpjRazaoSocial = "";
		String idLoja = request.getParameter("idLoja");
		String idOrdemServico = request.getParameter("idOrdemServico");
		String clausulaOrdemServico = " WHERE idOrdemServico = "+Integer.parseInt(idOrdemServico);
		String clausulaConfigServico = " WHERE idLoja = "+Integer.parseInt(idLoja);
		String clausulaOrdemServicoObjeto = " WHERE idOrdemServico = "+Integer.parseInt(idOrdemServico);
		String clausulaObjeto = " WHERE idListaObjeto  = ";
		String clausulaOrdemServicoItem = " WHERE idOrdemServicoObjeto = ";
		String clausulaListaServico = " WHERE idListaServico = ";
		String clausulaPedidoItem = " WHERE idPedidoSaida = ";
		ArrayList<SubRelatorioOrdemServico> subRelatorio = new ArrayList<SubRelatorioOrdemServico>();
		ArrayList<SubRelatorioOrdemServicoProduto> subRelatorioProduto = new ArrayList<SubRelatorioOrdemServicoProduto>();
		
		try{
			ConfigServicoDAO daoConfigServico = new ConfigServicoDAO(ConnectionFactory.getConnection());
			ConfigServico configServico = daoConfigServico.procurarConfigServico(clausulaConfigServico);
			OrdemServicoDAO daoOrdemServico = new OrdemServicoDAO(ConnectionFactory.getConnection());
			OrdemServico ordemServico = daoOrdemServico.procurarOrdemServico(clausulaOrdemServico);
			campoOS1 = configServico.getDsCampo1()+":";
			campoOS2 = configServico.getDsCampo2()+":";
			campoOS3 = configServico.getDsCampo3()+":";
			campoOS4 = configServico.getDsCampo4()+":";
			respCampos1 = ordemServico.getCmpOS1();
			respCampos2 = ordemServico.getCmpOS2();
			respCampos3 = ordemServico.getCmpOS3();
			respCampos4 = ordemServico.getCmpOS4();
			observacao  = ordemServico.getObservacao();
			desc = ordemServico.getVlDesc();
			custoDeslocamento = ordemServico.getVlFrete();
			valorTotal = daoOrdemServico.getValorTotal(ordemServico.getIdOrdemServico());
			OrdemServicoObjetoDAO daoOrdemServicoObjeto = new OrdemServicoObjetoDAO(ConnectionFactory.getConnection());
			OrdemServicoObjeto ordemServicoObjeto = daoOrdemServicoObjeto.procurarOrdemServicoObjeto(clausulaOrdemServicoObjeto);
			ListaObjetoDAO daoListaObjeto = new ListaObjetoDAO(ConnectionFactory.getConnection());
			ListaObjeto listaObjeto = daoListaObjeto.procurarListaObjeto(clausulaObjeto+ordemServicoObjeto.getIdListaObjeto());
			dsListaObjeto = "Descrição:";
			respDsListaObjeto = listaObjeto.getDsListaObjeto();
			listaObjetoCampo1 = configServico.getDsCmpOb1()+":";
			listaObjetoCampo2 = configServico.getDsCmpOb2()+":";
			listaObjetoCampo3 = configServico.getDsCmpOb3()+":";
			listaObjetoCampo4 = configServico.getDsCmpOb4()+":";
			respListaObjetoCampo1 = ordemServicoObjeto.getCampo1();
			respListaObjetoCampo2 = ordemServicoObjeto.getCampo2();
			respListaObjetoCampo3 = ordemServicoObjeto.getCampo3();
			respListaObjetoCampo4 = ordemServicoObjeto.getCampo4();
			
			if(ordemServico.getTipo().equalsIgnoreCase("O")){
				ordemServicoOrcamento = " ORÇAMENTO ";
			}else{
				ordemServicoOrcamento = " ORDEM DE SERVIÇO ";
			}
			
			OrdemServicoItemDAO daoOrdemServicoItem = new OrdemServicoItemDAO(ConnectionFactory.getConnection());
			List<OrdemServicoItem> ordemServicoItem = daoOrdemServicoItem.listar(clausulaOrdemServicoItem+ordemServicoObjeto.getIdOrdemServicoObjeto());
			
			for( Iterator it = ordemServicoItem.iterator(); it.hasNext(); ){
				OrdemServicoItem itemServico = (OrdemServicoItem) it.next();
				SubRelatorioOrdemServico subRelatorioOrdemServico = new SubRelatorioOrdemServico();
				subRelatorioOrdemServico.setDsCompServico(itemServico.getDsCompServico());
				subRelatorioOrdemServico.setDesconto(itemServico.getpDesc());
				subRelatorioOrdemServico.setQuant(itemServico.getQuant());
				subRelatorioOrdemServico.setVlUni(itemServico.getVlUni());
				subRelatorioOrdemServico.setValor(itemServico.getValor());
				ListaServicoDAO daoListaServico = new ListaServicoDAO(ConnectionFactory.getConnection());
				ListaServico listaServico = daoListaServico.procurarListaServico(clausulaListaServico+itemServico.getIdListaServico());
				subRelatorioOrdemServico.setDsServico(listaServico.getDsListaServico());
				subRelatorioOrdemServico.setCodigo(listaServico.getCdListaServico());
				subRelatorio.add(subRelatorioOrdemServico);
			}
			
			PedidoSaidaDAO daoPedidoSaida = new PedidoSaidaDAO(ConnectionFactory.getConnection());
			Integer idPedidoSaida = daoPedidoSaida.ProcurarOrdemDeServicoGetIdPedidoSaida(Integer.parseInt(idOrdemServico));
			PedidoSaidaItemDAO daoPedidoItem = new PedidoSaidaItemDAO(ConnectionFactory.getConnection());
			List itensPedido = daoPedidoItem.listarPedidoSaidaItem(clausulaPedidoItem+idPedidoSaida);
			
			
			for(Iterator itItens = itensPedido.iterator(); itItens.hasNext();){
				PedidoSaidaItem pedidoSaidaItem = (PedidoSaidaItem) itItens.next();
				SubRelatorioOrdemServicoProduto ordemServicoProduto = new SubRelatorioOrdemServicoProduto();
				ordemServicoProduto.setQuant(pedidoSaidaItem.getQuant());
				ordemServicoProduto.setDesc(pedidoSaidaItem.getPDesc());
				ordemServicoProduto.setVlUnit(pedidoSaidaItem.getVlUni());
				ordemServicoProduto.setTotalItem(pedidoSaidaItem.getValor());
				ProdutoDAO daoProduto = new ProdutoDAO(ConnectionFactory.getConnection());
				Produto produto = daoProduto.pesquisarProduto(pedidoSaidaItem.getIdProduto());
				ordemServicoProduto.setDescProduto(produto.getDsProduto());
				UnidadeDAO daoUnidade = new UnidadeDAO(ConnectionFactory.getConnection());
				Unidade unidade = daoUnidade.procurarUnidade(pedidoSaidaItem.getIdUnidade());
				ordemServicoProduto.setUnd(unidade.getDsUnidade());
				subRelatorioProduto.add(ordemServicoProduto);
			}
			
			LojaDAO daoLoja = new LojaDAO(ConnectionFactory.getConnection());
			Loja loja = daoLoja.procurarLoja(Integer.parseInt(idLoja));
			razaoSocial = loja.getRazaoSocial().toUpperCase();
			String cidadeLoja = daoLoja.getCidadeLoja(Integer.parseInt(idLoja));
			if(loja.getCmpEndereco() != null){
				enderecoRazaoSocial = loja.getEndereco()+ " " + loja.getCmpEndereco() + " - " + loja.getBairro() + " - "+ cidadeLoja + "/" + loja.getEstado() +
				                      " " +loja.getCep();
			}else{
				enderecoRazaoSocial = loja.getEndereco()+" - " + loja.getBairro() + " - "+ cidadeLoja + "/" + loja.getEstado() + " "+
                loja.getCep();
			}
			cnpjRazaoSocial = loja.getCnpj();
			if(loja.getNroTelefone() != null)cnpjRazaoSocial += " TEL: " +loja.getNroTelefone();
			if(loja.getNroFax() != null ){
				if(!loja.getNroFax().equalsIgnoreCase("")){
					cnpjRazaoSocial += " FAX: "+loja.getNroFax();
				}
			}
			EntidadeDAO daoEntidade = new EntidadeDAO(ConnectionFactory.getConnection());
			Entidade entidade = daoEntidade.procurarEntidade(ordemServico.getCdEntidade());
			if(entidade.getTpInsc().equalsIgnoreCase("F")){
				EntidadeFisicaDAO daoEntidadeFisica = new EntidadeFisicaDAO(ConnectionFactory.getConnection()); 
				EntidadeFisica entidadeFisica = daoEntidadeFisica.procurarEntidadeFisica(entidade.getCdEntidade());
				cliente = entidadeFisica.getNome().toUpperCase();
				cpf_cnpj = entidadeFisica.getCpf();
			}else{
				EntidadeJuridicaDAO daoEntidadeJuridica = new EntidadeJuridicaDAO(ConnectionFactory.getConnection()); 
				EntidadeJuridica entidadeJuridica = daoEntidadeJuridica.procurarEntidadeJuridica(entidade.getCdEntidade());
				cliente = entidadeJuridica.getRazaoSocial().toUpperCase();
				cpf_cnpj = entidadeJuridica.getCnpj();
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
			contato = ordemServico.getPessoaResponsavel();
		}catch(Exception e){
			e.printStackTrace();
			
		}
		RelatorioObjetoOrdemServico relatorioObjetoOrdemServico = new RelatorioObjetoOrdemServico();
		Map<String, Object> parametros = new HashMap<String, Object>();
		try {
			relatorioObjetoOrdemServico.setCampoOS1(campoOS1);
			relatorioObjetoOrdemServico.setCampoOS2(campoOS2);
			relatorioObjetoOrdemServico.setCampoOS3(campoOS3);
			relatorioObjetoOrdemServico.setCampoOS4(campoOS4);
			relatorioObjetoOrdemServico.setRespCampos1(respCampos1);
			relatorioObjetoOrdemServico.setRespCampos2(respCampos2);
			relatorioObjetoOrdemServico.setRespCampos3(respCampos3);
			relatorioObjetoOrdemServico.setRespCampos4(respCampos4);
			relatorioObjetoOrdemServico.setDsListaObjeto(dsListaObjeto);
			relatorioObjetoOrdemServico.setRespDsListaObjeto(respDsListaObjeto);
			relatorioObjetoOrdemServico.setListaObjetoCampo1(listaObjetoCampo1);
			relatorioObjetoOrdemServico.setListaObjetoCampo2(listaObjetoCampo2);
			relatorioObjetoOrdemServico.setListaObjetoCampo3(listaObjetoCampo3);
			relatorioObjetoOrdemServico.setListaObjetoCampo4(listaObjetoCampo4);
			relatorioObjetoOrdemServico.setRespListaObjetoCampo1(respListaObjetoCampo1);
			relatorioObjetoOrdemServico.setRespListaObjetoCampo2(respListaObjetoCampo2);
			relatorioObjetoOrdemServico.setRespListaObjetoCampo3(respListaObjetoCampo3);
			relatorioObjetoOrdemServico.setRespListaObjetoCampo4(respListaObjetoCampo4);
			relatorioObjetoOrdemServico.setObservacao(observacao);
			relatorioObjetoOrdemServico.setCustoDeslocamento(custoDeslocamento);
			relatorioObjetoOrdemServico.setValorTotal(valorTotal);
			relatorioObjetoOrdemServico.setDesconto(desc);
			
			List <RelatorioObjetoOrdemServico> listObjeto = new ArrayList<RelatorioObjetoOrdemServico>();
			listObjeto.add(relatorioObjetoOrdemServico);
			JRDataSource jrdsSubProduto = new JRBeanCollectionDataSource(subRelatorioProduto);
			JRDataSource jrdsSub = new JRBeanCollectionDataSource(subRelatorio);
			JRDataSource jrds = new JRBeanCollectionDataSource(listObjeto);
			parametros.put("ordemServicoOrcamento", ordemServicoOrcamento);
			parametros.put("cliente", cliente);
			parametros.put("endereco", endereco);
			parametros.put("complemento", complemento);
			parametros.put("cpf_cnpj", cpf_cnpj);
			parametros.put("contato", contato);
			parametros.put("cidade", cidade);
			parametros.put("Uf", Uf);
			parametros.put("bairro", bairro);
			parametros.put("cep", cep);
			parametros.put("razaoSocial", razaoSocial);
			parametros.put("enderecoRazaoSocial", enderecoRazaoSocial);
			parametros.put("cnpjRazaoSocial", cnpjRazaoSocial);
			String relatorioJasper = "ordemServicoProdutoServico.jasper";
			String rootDir = getServletContext().getRealPath("relatorio");
			String reportFileName = rootDir + java.io.File.separator + relatorioJasper;
			pathLogo =  rootDir + java.io.File.separator + "logomarca.jpg";
			parametros.put("logo", pathLogo);
			String SUBREPORT_DIR = rootDir  + java.io.File.separator;
			parametros.put("SUBREPORT_DIR", SUBREPORT_DIR);
			parametros.put("itensServico", subRelatorio);
			parametros.put("SUBREPORT_DIRR", SUBREPORT_DIR);
			parametros.put("itensProduto", subRelatorioProduto);
			
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