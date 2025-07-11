<%@page import="afero.model.PedidoSaida"%>
<%@page import="afero.model.Loja"%>
<%@page import="afero.model.Preco"%>
<%@page import="afero.model.Entrega"%>
<%@page import="afero.model.Estado"%>
<%@page import="afero.util.Produtos"%>
<%@page import="afero.auxiliar.Det"%>
<%@page import="afero.auxiliar.IUrls"%>
<%@page import="afero.model.Entidade"%>
<%@page import="java.util.List" %>
<%@page import="java.util.Iterator"%>
<%@page import="afero.model.TipoLogradouro"%>
<%@page import="afero.model.Estoque"%>
<%@page import="afero.model.Unidade"%>
<%@page import="afero.model.EntidadeEndereco"%>
<%@page import="afero.model.EntidadeTelefone"%>
<%@page import="afero.model.EntidadeEmail"%>
<%@page import="afero.model.EntidadeFisica"%>
<%@page import="afero.model.EntidadeJuridica"%>
<%@page import="afero.model.Cidade"%>
<%@page import="afero.model.Crt"%>
<%@page import="afero.model.Cnae"%>
<%@page import="afero.model.PedidoSaidaItem"%>
<%@page import="afero.auxiliar.Destinatario"%>
<%@page import="afero.util.Utilitaria"%>
<%@page import="afero.model.Entidade"%>
<%@page import="afero.model.RetornoNotaFiscal"%>

<%@page import="afero.auxiliar.Emitente"%>

<%@page import="afero.auxiliar.EnderEmit"%>
<%@page import="afero.auxiliar.IntegracaoWS"%>
<%@page import="afero.persistence.EntidadeDAO"%>
<%@page import="afero.persistence.RetornoNotaFiscalDAO"%>
<%@page import="afero.persistence.EntregaDAO"%>
<%@page import="afero.persistence.EstadoDAO"%>
<%@page import="afero.persistence.EntidadeEmailDAO"%>
<%@page import="afero.persistence.ProdutoDAO"%>
<%@page import="afero.persistence.TipoLogradouroDAO"%>
<%@page import="afero.persistence.EntidadeTelefoneDAO"%>
<%@page import="afero.persistence.EntidadeEnderecoDAO"%>
<%@page import="afero.persistence.UnidadeDAO"%>
<%@page import="afero.persistence.EntidadeFisicaDAO"%>
<%@page import="afero.persistence.EntidadeJuridicaDAO"%>
<%@page import="afero.persistence.PedidoSaidaItemDAO"%>
<%@page import="afero.persistence.LojaDAO"%>
<%@page import="afero.integracao.xprocess.persistence.NfeDAO"%>
<%@page import="afero.persistence.ProdutoDAO"%>
<%@page import="afero.persistence.EstoqueDAO"%>
<%@page import="afero.persistence.CidadeDAO"%>
<%@page import="afero.persistence.CrtDAO"%>
<%@page import="afero.persistence.PrecoDAO"%>
<%@page import="afero.persistence.CnaeDAO"%>
<%@page import="afero.persistence.PedidoSaidaDAO"%>
<%@page import="com.thoughtworks.xstream.XStream"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONException"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.io.ByteArrayInputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.nio.charset.*"%>
<%@page import="java.io.IOException"%>
<%@page import="afero.util.ConverteDate"%>
<%@page import="org.yaml.snakeyaml.Yaml"%>
<%@include file="../seguranca.jsp"%>
<%@include file="../iniConexao.jsp"%>
<link type="text/css" rel="Stylesheet" href="../css/afero.css" />

<%
String idLoja = (String)session.getAttribute("idLoja");
String idPedidoSaida = request.getParameter("idPedidoSaida");
String mensagem = "";
LojaDAO daoLoja = new LojaDAO(conn);
Loja loja = daoLoja.procurarLoja(Integer.parseInt(idLoja));
JSONObject jsonNota = new JSONObject();
JSONArray items = new JSONArray();

PedidoSaidaDAO daoPedidoSaida = new PedidoSaidaDAO(conn);
PedidoSaida pedidoSaidaHora = new PedidoSaida();
pedidoSaidaHora = daoPedidoSaida.procurarPedidoSaidaNota(Integer.parseInt(idPedidoSaida));
double vlTotalNota = Utilitaria.toNumber(Utilitaria.formatarNumero(daoPedidoSaida.valorTotalPedidoNota(Integer.parseInt(idPedidoSaida)),2)).doubleValue();
//Loja
try{
	EnderEmit ender = new EnderEmit();
	Emitente emi = new Emitente();
	jsonNota.put("natureza_operacao", "Venda");
	jsonNota.put("forma_pagamento", 0);
	jsonNota.put("data_emissao",ConverteDate.DateToDateSql(ConverteDate.stringToDate(daoPedidoSaida.dataAtualPedido())));
	jsonNota.put("data_entrada_saida", ConverteDate.DateToDateSql(ConverteDate.stringToDate(daoPedidoSaida.dataAtualPedido())));
	jsonNota.put("tipo_documento", "1");
	jsonNota.put("presenca_comprador","1");
	jsonNota.put("consumidor_final","1");
	jsonNota.put("finalidade_emissao", "1");
	
	
	if(loja.getCnpj() != null){
		emi.setCNPJ(Utilitaria.soNumeros(loja.getCnpj()));
		jsonNota.put("cnpj_emitente", Utilitaria.soNumeros(emi.getCNPJ()));
	}else{
		mensagem += " Tem que ser obrigatório o CNPJ/CPF \n";
	}
	
	if(loja.getRazaoSocial().length() <= 60){
		emi.setxNome(loja.getRazaoSocial());
	}else{
		mensagem += " A Razão Social só pode ter o tamanho máximo de 60 caracteres. Por isso foi abreviado. \n";
		emi.setxNome(Utilitaria.abreviarStr(loja.getRazaoSocial(), 60));
	}
	jsonNota.put("nome_emitente", emi.getxNome());
	
	if(loja.getApelido() != null){
		if(loja.getApelido().length() <= 60){
	emi.setxFant(loja.getApelido());
		}else if(loja.getApelido().length() > 60){
	mensagem += " O nome fantasia só pode ter o tamanho máximo de 60 caracteres. Por isso foi abreviado. \n";
	emi.setxFant(Utilitaria.abreviarStr(loja.getApelido(), 60));
		}
		jsonNota.put("nome_fantasia_emitente", emi.getxFant());
	}else{
		mensagem += " Não é obrigatório ter o nome fantasia \n";
	}
	
	if(loja.getEndereco() != null){
		if(loja.getEndereco().length()<=60){
	ender.setxLgr(loja.getEndereco());
		}else if(loja.getEndereco().length()>60){
	ender.setxLgr(Utilitaria.abreviarStr(loja.getEndereco(), 60));
		}
		
		jsonNota.put("logradouro_emitente", ender.getxLgr());
	}else{
		mensagem += " É obrigatório ter o Logradouro \n";
	}
	
	if(loja.getNro() != null){
		if(loja.getNro().length()<=60){
	ender.setNro(loja.getNro());
		}else if(loja.getNro().length()>60){
	           ender.setNro(Utilitaria.abreviarStr(loja.getEndereco(), 60));
		}
		jsonNota.put("numero_emitente", ender.getNro());
	}else{
		mensagem += " É obrigatório ter o Número do Endereço \n";
	}
	
	if(loja.getBairro() != null){
		if(loja.getBairro().length()<=60){
	ender.setxBairro(loja.getBairro());
		}else if(loja.getBairro().length()>60){
	           ender.setxBairro(Utilitaria.abreviarStr(loja.getBairro(), 60));
		}
		jsonNota.put("bairro_emitente", Utilitaria.retirarAcentos(ender.getxBairro()));
	}else{
		mensagem += " É obrigatório ter o Bairro \n";
	}
	
	if(loja.getIdCidade() != null){
		Cidade cidade = null;
		CidadeDAO daoCidade = new CidadeDAO(conn);
		cidade = daoCidade.procurarCidade(loja.getIdCidade());
		ender.setcMun("".valueOf(cidade.getCdMunicipio()));
		if(cidade.getNmCidade().length()<=60){
	ender.setxMun(cidade.getNmCidade());
		}else if(loja.getCep().length()>60){
	ender.setxMun(Utilitaria.abreviarStr(cidade.getNmCidade(), 60));
		}
		
		jsonNota.put("municipio_emitente", Utilitaria.retirarAcentos(ender.getxMun()));
		EstadoDAO daoEstado = new EstadoDAO(conn);
		Estado estado = daoEstado.procurarEstado(cidade.getCdEstado());
		jsonNota.put("uf_emitente", estado.getSiglaEstado());
	}else{
		mensagem += " É obrigatório ter a Cidade \n";
	}
	
	if(loja.getCep() != null){
		if(loja.getCep().length()<=8){
	ender.setCEP(loja.getCep());
		}else if(loja.getCep().length()>8){
	           ender.setCEP(Utilitaria.abreviarStr(loja.getCep(), 8));
		}
		jsonNota.put("cep_emitente", Utilitaria.soNumeros(ender.getCEP()));
	}else{
		mensagem += " É obrigatório ter o CEP \n";
	}
	
	if(loja.getInscEstadual() != null){
		if(loja.getInscEstadual().length() <= 14){
	emi.setIE(Utilitaria.soNumeros(loja.getInscEstadual()));
		}else if(loja.getInscEstadual().length() > 60){
	emi.setIE(Utilitaria.abreviarStr(Utilitaria.soNumeros(loja.getInscEstadual()), 14));
		}
		jsonNota.put("inscricao_estadual_emitente", Utilitaria.soNumeros(emi.getIE()));
		
	}else{
		mensagem += " Tem que ser obrigatório a Inscrição Estadual \n";
	}
	
	
	/* /* if(loja.getInscMunicipal() != null){
		if(loja.getInscMunicipal().length() <= 15){
	emi.setIM(Utilitaria.soNumeros(loja.getInscEstadual()));
		}else if(loja.getInscMunicipal().length() > 60){
	emi.setIE(Utilitaria.abreviarStr(Utilitaria.soNumeros(loja.getInscMunicipal()), 14));
		}
		
	}else{
		mensagem += " Tem que ser obrigatório a Inscrição Estadual \n";
	} */ 
	
	
	
	
	
	
	/* if(loja.getCmpEndereco() != null){
		if(loja.getCmpEndereco().length()<=60){
	ender.setxCpl(loja.getCmpEndereco());
		}else if(loja.getCmpEndereco().length()>60){
	           ender.setxCpl(Utilitaria.abreviarStr(loja.getCmpEndereco(), 60));
		}
	} */

/*	
	if(loja.getNroTelefone() != null){
		if(loja.getCep().length()<=14){
	ender.setFone(loja.getNroTelefone());
		}else if(loja.getNroTelefone().length()>14){
	           ender.setFone(Utilitaria.abreviarStr(loja.getNroTelefone(), 14));
		}
	}
*/	
	ender.setxPais("Brasil");
	ender.setcPais("1058");
	
/*	
	if(loja.getIdCrt() != null){
		CrtDAO daoCrt = new CrtDAO(conn);
		Crt crt = daoCrt.procurarCrt(loja.getIdCrt());
		emi.setCRT("".valueOf(crt.getCodigo()));
	}else{
		mensagem += " É obrigatório ter o CRT \n";	
	}
	
	if(loja.getIdCnae() != null){
	 CnaeDAO daoCnae = new CnaeDAO(conn);
	 Cnae cnae = daoCnae.procurarCnae(loja.getIdCnae());
	 emi.setCNAE(Utilitaria.abreviarStr(Utilitaria.soNumeros(loja.getInscEstadual()), 7));
	}else{
		mensagem += " É obrigatório ter o CNAE \n";
	}
*/	
	
       } catch (Exception ex) {
           ex.printStackTrace();
       }
//Pedido
  
      PedidoSaida pedido = new PedidoSaida();
      pedido.setIdPedidoSaida(Integer.parseInt(idPedidoSaida));
      PedidoSaidaDAO daoPedido = new PedidoSaidaDAO(conn);
      pedido = daoPedido.procurarPedidoSaida(pedido.getIdPedidoSaida());
      if (pedido.getCdEntidade() > 0){
    	  //Destinatário
    	  Destinatario dest = new Destinatario();
    	  Entidade entidade = new Entidade();
    	  EntidadeDAO daoEntidade = new EntidadeDAO(conn);
    	  entidade = daoEntidade.procurarEntidade(pedido.getCdEntidade());
    	  if(entidade.getTpInsc().equalsIgnoreCase("F")){
    		  EntidadeFisica entidadeFisica = new EntidadeFisica();
    		  EntidadeFisicaDAO daoEntidadeFisica = new EntidadeFisicaDAO(conn);
    		  entidadeFisica = daoEntidadeFisica.procurarEntidadeFisica(entidade.getCdEntidade());
    		  if(entidade.getNome() != null){
    		 	 if(entidade.getNome().length()<=60){
    				  dest.setxNome(entidade.getNome());  
    		 	 }else{
    				  dest.setxNome(Utilitaria.abreviarStr(entidade.getNome(), 60));
    		 	 }
    		 	
    		  }else{
    			  mensagem += " É obrigatório ter o Nome do Destinatário \n";
    		  }
    		  jsonNota.put("nome_destinatario", Utilitaria.retirarAcentos(dest.getxNome()));
    		  if(entidadeFisica.getCpf() != null){
    		  	if(entidadeFisica.getCpf().length()<=14){
    				 dest.setCNPJ_CPF(entidadeFisica.getCpf());  
    		  	}else{
    				  dest.setCNPJ_CPF(Utilitaria.soNumeros(entidadeFisica.getCpf()));
    		 	}
    		  	jsonNota.put("cpf_destinatario", dest.getCNPJ_CPF());
    		  }else{
    			  mensagem += " É obrigatório ter o CPF do Destinatário \n"; 
    		  }
    		  //jsonNota.isNull("inscricao_estadual_destinatario");
    		  
    		  EntidadeTelefone entidadeTelefone = new EntidadeTelefone();
	           EntidadeTelefoneDAO daoEntidadeTelefone = new EntidadeTelefoneDAO(conn);
	           entidadeTelefone = daoEntidadeTelefone.procurarEntidadeTelefonePadrao(entidade.getCdEntidade());
	           
	           if(entidadeTelefone.getNroTelefone().length()<=14){
	        	   	dest.setFone(entidadeTelefone.getNroTelefone());
	           }else{
	        	   	dest.setFone(Utilitaria.abreviarStr(entidadeTelefone.getNroTelefone(), 14));
	           }
	           jsonNota.put("telefone_destinatario", Utilitaria.soNumeros(dest.getFone()));
    		  
    		  EntidadeEndereco endereco = new EntidadeEndereco();
    		  EntidadeEnderecoDAO daoEndereco = new EntidadeEnderecoDAO(conn);
    		  endereco = daoEndereco.procurarEntidadeEnderecoPadrao(entidadeFisica.getCdEntidade());
    		  TipoLogradouro tipoLogradouro = new TipoLogradouro();
    		  TipoLogradouroDAO daoTipoLogradouro = new TipoLogradouroDAO(conn);
    		  tipoLogradouro = daoTipoLogradouro.procurarTipoLogradouro(endereco.getCdTipoLogradouro());
    		  
    		  if(tipoLogradouro.getDsTipoLogradouro().length()<=60){
    			  dest.setxLgr(tipoLogradouro.getDsTipoLogradouro()); 
    		  }else{
    			  dest.setxLgr(Utilitaria.abreviarStr(tipoLogradouro.getDsTipoLogradouro(), 60));
    		  }
    		  jsonNota.put("logradouro_destinatario",Utilitaria.retirarAcentos(dest.getxLgr()+ " " +endereco.getDsEndereco()));
    		  
    		  if(endereco.getNroEndereco().length()<=60){
    			  dest.setNro(endereco.getNroEndereco());
    		  }else{
    			  dest.setNro(Utilitaria.abreviarStr(endereco.getNroEndereco(), 60));
    		  }
    		  
    		  dest.setEnderDest(endereco.getDsEndereco());
    		  jsonNota.put("numero_destinatario",dest.getNro());
    		  
    		  /*
    		  if(endereco.getCmpEndereco().length()<=60){
    			  dest.setxCpl(endereco.getCmpEndereco());
    		  }else{
    			  dest.setxCpl(Utilitaria.abreviarStr(endereco.getCmpEndereco(), 60));
    		  }
    		  */
    		  if(endereco.getBaiEndereco().length()<=60){
    			  dest.setxBairro(endereco.getBaiEndereco());
    		  }else{
    			  dest.setxBairro(Utilitaria.abreviarStr(endereco.getBaiEndereco(), 60));
    		  }
    		  jsonNota.put("bairro_destinatario",Utilitaria.retirarAcentos(dest.getxBairro()));
    		  
    		  Cidade cidade = null;
    		  CidadeDAO daoCidade = new CidadeDAO(conn);
    		  cidade = daoCidade.procurarCidade(endereco.getIdCidade());
    		  
    		  if(cidade.getNmCidade().length()<=60){
    			  dest.setxMun(cidade.getNmCidade());
    		  }else{
    			  dest.setxMun(Utilitaria.abreviarStr(cidade.getNmCidade(), 60));
    		  }
    		  jsonNota.put("municipio_destinatario",dest.getxMun());
    		  
    		  if(cidade.getCdMunicipio().length()<=7){
    			  dest.setcMun(cidade.getCdMunicipio());
    		  }else{
    			  dest.setcMun(Utilitaria.abreviarStr(cidade.getCdMunicipio(), 7));
    		  }
    		  
    		  
    		  Estado estado = new Estado();
    		  EstadoDAO daoEstado = new EstadoDAO(conn);
    		  estado = daoEstado.procurarEstado(cidade.getCdEstado());
    		  
    		  if(estado.getSiglaEstado().length()<=2){
    			  dest.setUF(estado.getSiglaEstado());
    		  }else{
    			  dest.setUF(Utilitaria.abreviarStr(estado.getSiglaEstado(), 2));
    		  }
    		  jsonNota.put("uf_destinatario",dest.getUF());
    		  dest.setxPais("Brasil");
    		  jsonNota.put("pais_destinatario",dest.getxPais());
    		  
    		  if(endereco.getCepEndereco().length()<=8){
	        	   	dest.setCEP(endereco.getCepEndereco());
	           }else{
	        		dest.setCEP(Utilitaria.soNumeros(endereco.getCepEndereco()));
	           }
    		  jsonNota.put("cep_destinatario",Utilitaria.soNumeros(dest.getCEP()));
    		  
    		  dest.setcPais("1058");
    		  
    		  EntidadeEmail entidadeEmail = new EntidadeEmail();
    		  EntidadeEmailDAO daoEntidadeEmail = new EntidadeEmailDAO(conn);
    		  entidadeEmail = daoEntidadeEmail.procurarEntidadeEmailPadrao(entidade.getCdEntidade());
    		  
    		  if(entidadeEmail.getDsEmail().length()<=60){
    			  dest.setEmail(entidadeEmail.getDsEmail());
    		  }else{
    			  dest.setEmail(Utilitaria.abreviarStr(entidadeEmail.getDsEmail(), 60));
    		  }
    		  
    		  if (entidadeEmail.getDsEmail().length() > 0){
    			  jsonNota.put("email_destinatario",entidadeEmail.getDsEmail());  
    		  }else{
    			  jsonNota.put("email_destinatario",IUrls.emailNota);  
    		  }
    		 
    		  jsonNota.put("icms_base_calculo", 0);
      		  jsonNota.put("icms_valor_total", 0);
      		  jsonNota.put("icms_valor_total", 0);
      		  jsonNota.put("icms_base_calculo_st", 0);
      		  jsonNota.put("icms_valor_total_st", 0);
      		  jsonNota.put("valor_frete", 0);
      		  jsonNota.put("valor_seguro", 0);
      		 double vlFDesc = 0;
      		 if(pedidoSaidaHora.getVlDesc() != 0){
      			
      			vlFDesc = vlTotalNota * (pedidoSaidaHora.getVlDesc()/100);
      			jsonNota.put("valor_desconto", vlFDesc);
      		 }
        		 double vlFTotal = 0;
        		 if(pedidoSaidaHora.getVlDesc() != 0){
        			 vlFTotal = vlTotalNota - vlFDesc;
        			
        		 }else{
        			 vlFTotal =  pedidoSaidaHora.getVlPed();
        		 }
      		  
      		  
      		  jsonNota.put("valor_total", vlFTotal);//Utilitaria.trocarCaracteres(Utilitaria.formatarNumero(
       				//pedidoSaidaHora.getVlPed(), 2),",", "."));
      		  jsonNota.put("valor_produtos", vlFTotal);//Utilitaria.trocarCaracteres(Utilitaria.formatarNumero(
       				//pedidoSaidaHora.getVlPed(), 2),",", "."));
      		  jsonNota.put("valor_ipi", 0);
      		  jsonNota.put("modalidade_frete", 0);
      		if(pedido.getObservacao() != null){
     			jsonNota.put("informacoes_adicionais_contribuinte", pedido.getObservacao()); 
     		 }
    	           dest.setIndIEDest("2");
    	           dest.setIE(null);
    		  dest.setIM(null);
    		  dest.setISUF(null);
    		  
    	  }else  if(entidade.getTpInsc().equalsIgnoreCase("J")){
    		  EntidadeJuridica entidadeJuridica = new EntidadeJuridica();
    		  EntidadeJuridicaDAO daoEntidadeJuridica = new EntidadeJuridicaDAO(conn);
    		  entidadeJuridica = daoEntidadeJuridica.procurarEntidadeJuridica(pedido.getCdEntidade());
    		  if(entidadeJuridica.getRazaoSocial() != null){
     		 	 if(entidadeJuridica.getRazaoSocial().length()<=60){
     				  dest.setxNome(entidadeJuridica.getRazaoSocial());  
     		 	 }else{
     				  dest.setxNome(Utilitaria.abreviarStr(entidadeJuridica.getRazaoSocial(), 60));
     		 	 }
     		 	System.out.println("LOG NOME ------------>\n");
    		 	System.out.println("\n");
    		 	System.out.println(entidadeJuridica.getRazaoSocial());
    		 	System.out.println("\n");
    		 	System.out.println("FIM LOG NOME ------------>\n");
     		  }else{
     			  mensagem += " É obrigatório ter o Nome do Destinatário \n";
     		  }
    		  
    		  jsonNota.put("nome_destinatario", Utilitaria.retirarAcentos(dest.getxNome()));
    		  
     		  if(entidadeJuridica.getCnpj() != null){
     		  	if(entidadeJuridica.getCnpj().length()<=14){
     				 dest.setCNPJ_CPF(entidadeJuridica.getCnpj());  
     		  	}else{
     				  dest.setCNPJ_CPF(Utilitaria.soNumeros(entidadeJuridica.getCnpj()));
     		 	}
     		  }else{
     			  mensagem += " É obrigatório ter o CPF do Destinatário \n"; 
     		  }
     		  jsonNota.put("cnpj_destinatario", dest.getCNPJ_CPF());
     		  
    		  jsonNota.put("inscricao_estadual_destinatario", entidadeJuridica.getInscEstadual());

    		  EntidadeTelefone entidadeTelefone = new EntidadeTelefone();
	           EntidadeTelefoneDAO daoEntidadeTelefone = new EntidadeTelefoneDAO(conn);
	           entidadeTelefone = daoEntidadeTelefone.procurarEntidadeTelefonePadrao(entidade.getCdEntidade());
	           
	           if(entidadeTelefone.getNroTelefone().length()<=14){
	        	   	dest.setFone(entidadeTelefone.getNroTelefone());
	           }else{
	        	   	dest.setFone(Utilitaria.abreviarStr(entidadeTelefone.getNroTelefone(), 14));
	           }
	           jsonNota.put("telefone_destinatario", Utilitaria.soNumeros(dest.getFone()));
    		  
    		  
     		  EntidadeEndereco endereco = new EntidadeEndereco();
     		  EntidadeEnderecoDAO daoEndereco = new EntidadeEnderecoDAO(conn);
     		  endereco = daoEndereco.procurarEntidadeEnderecoPadrao(entidadeJuridica.getCdEntidade());
     		  TipoLogradouro tipoLogradouro = new TipoLogradouro();
     		  TipoLogradouroDAO daoTipoLogradouro = new TipoLogradouroDAO(conn);
     		  tipoLogradouro = daoTipoLogradouro.procurarTipoLogradouro(endereco.getCdTipoLogradouro());
     		  
     		  if(tipoLogradouro.getDsTipoLogradouro().length()<=60){
     			  dest.setxLgr(tipoLogradouro.getDsTipoLogradouro() + " " + endereco.getDsEndereco()); 
     		  }else{
     			  dest.setxLgr(Utilitaria.abreviarStr(tipoLogradouro.getDsTipoLogradouro()+ " " + endereco.getDsEndereco(), 60));
     		  }
     		  jsonNota.put("logradouro_destinatario", Utilitaria.retirarAcentos(dest.getxLgr()));
     		  
     		  
     		  if(endereco.getNroEndereco().length()<=60){
     			  dest.setNro(endereco.getNroEndereco());
     		  }else{
     			  dest.setNro(Utilitaria.abreviarStr(endereco.getNroEndereco(), 60));
     		  }
     		  jsonNota.put("numero_destinatario", Utilitaria.retirarAcentos(dest.getNro()));
     		  
     		  dest.setEnderDest(endereco.getDsEndereco());
     		  
     		  /*
     		  if(endereco.getCmpEndereco().length()<=60){
     			  dest.setxCpl(endereco.getCmpEndereco());
     		  }else{
     			  dest.setxCpl(Utilitaria.abreviarStr(endereco.getCmpEndereco(), 60));
     		  }
     		  */
     		  if(endereco.getBaiEndereco().length()<=60){
     			  dest.setxBairro(endereco.getBaiEndereco());
     		  }else{
     			  dest.setxBairro(Utilitaria.abreviarStr(endereco.getBaiEndereco(), 60));
     		  }
     		  jsonNota.put("bairro_destinatario", Utilitaria.retirarAcentos(dest.getxBairro()));
     		  
     		 Cidade cidade = null;
    		  CidadeDAO daoCidade = new CidadeDAO(conn);
    		  cidade = daoCidade.procurarCidade(endereco.getIdCidade());
    		  
    		  if(cidade.getNmCidade().length()<=60){
    			  dest.setxMun(cidade.getNmCidade());
    		  }else{
    			  dest.setxMun(Utilitaria.abreviarStr(cidade.getNmCidade(), 60));
    		  }
    		  jsonNota.put("municipio_destinatario", Utilitaria.retirarAcentos(dest.getxMun()));
    		 
    		 if(cidade.getCdMunicipio() != null){
    		  if(cidade.getCdMunicipio().length()<=7){
    			  dest.setcMun(cidade.getCdMunicipio());
    		  }else{
    			  dest.setcMun(Utilitaria.abreviarStr(cidade.getCdMunicipio(), 7));
    		  }
    		 }else{
    			 mensagem += "É obrigatório o código do Municipio. \n ";
    		 }
    		  
    		  Estado estado = new Estado();
    		  EstadoDAO daoEstado = new EstadoDAO(conn);
    		  estado = daoEstado.procurarEstado(cidade.getCdEstado());
    		  
    		  if(estado.getSiglaEstado().length()<=2){
    			  dest.setUF(estado.getSiglaEstado());
    		  }else{
    			  dest.setUF(Utilitaria.abreviarStr(estado.getSiglaEstado(), 2));
    		  }
    		  jsonNota.put("uf_destinatario", dest.getUF());
    		  jsonNota.put("indicador_inscricao_estadual_destinatario", "9");
    		  jsonNota.put("pais_destinatario", "Brasil");
    		  if(endereco.getCepEndereco().length()<=8){
	        	   	dest.setCEP(endereco.getCepEndereco());
	           }else{
	        		dest.setCEP(Utilitaria.soNumeros(endereco.getCepEndereco()));
	           }
	           jsonNota.put("cep_destinatario", Utilitaria.soNumeros(dest.getCEP()));
    		  
    		  
     		  dest.setxPais("Brasil");
     		  dest.setcPais("1058");
     		  
     		 jsonNota.put("icms_base_calculo", 0);
     		 jsonNota.put("icms_valor_total", 0);
     		 jsonNota.put("icms_valor_total", 0);
     		 jsonNota.put("icms_base_calculo_st", 0);
     		 jsonNota.put("icms_valor_total_st", 0);
     		 jsonNota.put("valor_frete", 0);
     		 jsonNota.put("valor_seguro", 0);
     		 double vlDesc = 0;
   		 if(pedidoSaidaHora.getVlDesc() != 0){
   			
   			vlDesc = Utilitaria.toNumber(Utilitaria.formatarNumero(pedidoSaidaHora.getVlDesc(),2)).doubleValue() * (Utilitaria.toNumber(Utilitaria.formatarNumero(vlTotalNota,2)).doubleValue()/100);
   			jsonNota.put("valor_desconto", Utilitaria.toNumber(Utilitaria.formatarNumero(vlDesc,2)).doubleValue());
   		 }
     		 double vlTotal = 0;
     		 if(pedidoSaidaHora.getVlDesc() != 0){
     			vlTotal = Utilitaria.toNumber(Utilitaria.formatarNumero(vlTotalNota,2)).doubleValue() - Utilitaria.toNumber(Utilitaria.formatarNumero(vlDesc,2)).doubleValue();
     			
     		 }else{
     			vlTotal =  Utilitaria.toNumber(Utilitaria.formatarNumero(pedidoSaidaHora.getVlPed(),2)).doubleValue();
     		 }
     		 jsonNota.put("valor_total",Utilitaria.toNumber(Utilitaria.formatarNumero(vlTotal,2)).doubleValue());
     		 jsonNota.put("valor_produtos",Utilitaria.toNumber(Utilitaria.formatarNumero(vlTotal,2)).doubleValue());
     		 jsonNota.put("valor_ipi", 0);
     		 jsonNota.put("modalidade_frete", 0);
     		 
     		 if(pedido.getObservacao() != null){
     			jsonNota.put("informacoes_adicionais_contribuinte", pedido.getObservacao()); 
     		 }
     		
     		  
     		  EntidadeEmail entidadeEmail = new EntidadeEmail();
     		  EntidadeEmailDAO daoEntidadeEmail = new EntidadeEmailDAO(conn);
     		  entidadeEmail = daoEntidadeEmail.procurarEntidadeEmailPadrao(entidade.getCdEntidade());
     		  
     		  if(entidadeEmail.getDsEmail().length()<=60){
     			  dest.setEmail(entidadeEmail.getDsEmail());
     		  }else{
     			  dest.setEmail(Utilitaria.abreviarStr(entidadeEmail.getDsEmail(), 60));
     		  }
     		  if(entidadeEmail.getDsEmail() != null){
     			 jsonNota.put("email_destinatario", entidadeEmail.getDsEmail());  
     		  }else{
     			 jsonNota.put("email_destinatario", IUrls.emailNota);
     		  }
     		 
     	           dest.setIndIEDest("2");
     	           dest.setIE(null);
     		  dest.setIM(null);
     		  dest.setISUF(null);
     		 
    	  }
    	  Integer cont = 1;
    	  JSONObject itensArray = null;
    	  Produtos produto = null;
    	  PedidoSaidaItem itemPedidoSaida = new PedidoSaidaItem();
    	  PedidoSaidaItemDAO daoItemPedidoSaida = new PedidoSaidaItemDAO(conn);
    	  List list;
    	  List<Produtos>listProdutos = null;
    	  Produtos produtos = new Produtos();
    	  list = daoItemPedidoSaida.procurarPedidoSaidaItem(Integer.parseInt(idPedidoSaida));
    	  double valorDesconto = pedidoSaidaHora.getVlDesc();
    	  double valorTotalDesconto = 0;
    	  double valorTotalDescontoNota = 0;
    	  for ( Iterator it = list.iterator(); it.hasNext(); ) {
    		  itemPedidoSaida = (PedidoSaidaItem) it.next();
    		  itensArray = new JSONObject();
    		  ProdutoDAO daoProduto = new ProdutoDAO(conn);
    		        itensArray.put("numero_item", cont.toString());
			//if(itemPedidoSaida.getIdProduto() > 0){
			NfeDAO daoNfe = new NfeDAO(conn);
			Produtos produtosItens = new Produtos();

			produto = daoNfe.procurarProdutoNCM(itemPedidoSaida
					.getIdProduto());
			produtosItens = daoNfe
					.RelatorioNfeIdProduto(itemPedidoSaida
							.getIdProduto());
			itensArray.put("codigo_produto", produto.getIdProduto());
			if (produto.getNmProduto() != null) {
				if (produto.getNmProduto().length() <= 120) {
					produtos.setxProd(produto.getNmProduto());
				} else {
					produtos.setxProd(Utilitaria.abreviarStr(
							produto.getNmProduto(), 120));
				}

			}
			itensArray.put("descricao", produtos.getxProd());

			
			//Início CFOP
			if(dest.getUF().equalsIgnoreCase("SE")){
				if (produtosItens.getCFOPPFisica() != null) {
					produtos.setCFOP(Utilitaria.soNumeros(produtosItens
							.getCFOPPFisica()));
					itensArray.put("cfop",produtos.getCFOP());

				}	
			}else{
				if (produtosItens.getCFOPPJuridica() != null) {
					produtos.setCFOP(Utilitaria.soNumeros(produtosItens
							.getCFOPPJuridica()));
					itensArray.put("cfop", produtos.getCFOP());

				}else{
					mensagem += "Verificar o CFOP do produto";
				}
			}
			
			
			//Fim CFOP

			Estoque estoque = new Estoque();
			EstoqueDAO daoEstoque = new EstoqueDAO(conn);
			estoque = daoEstoque.procurarEstoqueLojaProduto(
					loja.getIdLoja(), produto.getIdProduto());
			Preco preco = new Preco();
			PrecoDAO daoPreco = new PrecoDAO(conn);
			preco = daoPreco.procurarPrecoEstoqueLoja(
					estoque.getIdEstoque(), loja.getIdLoja());
			Unidade unidade = new Unidade();
			UnidadeDAO daoUnidade = new UnidadeDAO(conn);
			unidade = daoUnidade.procurarUnidade(preco.getIdUnidade());

			if (unidade.getDsUnidade() != null) {
				if (unidade.getDsUnidade().length() <= 6) {
					produtos.setuCom(unidade.getDsUnidade());
				} else {
					produtos.setuCom((Utilitaria.abreviarStr(
							unidade.getDsUnidade(), 6)));
				}
			}

			itensArray.put("unidade_comercial", "UN");

			itensArray.put("quantidade_comercial",itemPedidoSaida.getQuant());
					
			
			if(produtosItens.getCSTOrigMercadoria().length() == 1){
				itensArray.put("icms_origem",produtosItens.getCSTOrigMercadoria());
			}else{
				itensArray.put("icms_origem",produtosItens.getCSTOrigMercadoria());
			}
			
			if(produtosItens.getCSTTribICMS().length() == 1){
				itensArray.put("icms_situacao_tributaria","0"+produtosItens.getCSTTribICMS());	
			}else{
				itensArray.put("icms_situacao_tributaria",produtosItens.getCSTTribICMS());
			}
			if(produtosItens.getCodCSTCOFINS().length() == 1){
				itensArray.put("cofins_situacao_tributaria","0"+produtosItens.getCodCSTCOFINS());
			}else{
				itensArray.put("cofins_situacao_tributaria",produtosItens.getCodCSTCOFINS());
			}
			if(produtosItens.getCodCSTPIS().length() == 1){
				itensArray.put("pis_situacao_tributaria","0"+produtosItens.getCodCSTPIS());
			}else{
				itensArray.put("pis_situacao_tributaria",produtosItens.getCodCSTPIS());
			}
			double valorUni = 0;
			double valorDescUni = 0;
			if(Utilitaria.formatarNumero(itemPedidoSaida.getVlUni(), 2) != null){
				if(valorDesconto != 0){
					valorDescUni = (Utilitaria.toNumber(Utilitaria.formatarNumero(itemPedidoSaida.getVlUni(),2)).doubleValue() * (Utilitaria.toNumber(Utilitaria.formatarNumero(valorDesconto,2)).doubleValue()/100));
					valorUni = (Utilitaria.toNumber(Utilitaria.formatarNumero(itemPedidoSaida.getVlUni(),2)).doubleValue() - Utilitaria.toNumber(Utilitaria.formatarNumero(valorDescUni,2)).doubleValue());
				}else{
	     				valorUni =  Utilitaria.toNumber(Utilitaria.formatarNumero(itemPedidoSaida.getVlUni(),2)).doubleValue();
	     		 	}
	     		 	
				itensArray.put("valor_unitario_comercial",Utilitaria.toNumber(Utilitaria.formatarNumero(itemPedidoSaida.getVlUni(),2)).doubleValue());

				itensArray.put("valor_unitario_tributavel",Utilitaria.toNumber(Utilitaria.formatarNumero(itemPedidoSaida.getVlUni(),2)).doubleValue());
						
				
			}else {
				mensagem += " É obrigatório ter o valor unitário \n";
			}
			
			
			itensArray.put("inclui_no_total", "1");
			itensArray.put("unidade_tributavel", "UN");

			if (produto.getCdNcm() != null) {
				if (produto.getCdNcm().length() <= 8) {
					produtos.setNCM(Utilitaria.soNumeros(produto
							.getCdNcm()));
				} else {
					produtos.setNCM((Utilitaria.abreviarStr(
							produto.getCdNcm(), 8)));
				}

			}
			itensArray.put("codigo_ncm",
					Utilitaria.soNumeros(produto.getCdNcm()));

			itensArray.put("quantidade_tributavel",itemPedidoSaida.getQuant());
					

							
							
							
			 double valor = (itemPedidoSaida.getQuant() * Utilitaria.toNumber(Utilitaria.formatarNumero(itemPedidoSaida.getVlUni(),2)).doubleValue());
			 double vlIDesc = 0;
			 double vlITotal = 0;
	   		 if(valorDesconto != 0){
	   			vlIDesc = Utilitaria.toNumber(Utilitaria.formatarNumero(valor,2)).doubleValue() * (Utilitaria.toNumber(Utilitaria.formatarNumero(valorDesconto,2)).doubleValue()/100);
	   			valorTotalDesconto += Utilitaria.toNumber(Utilitaria.formatarNumero(vlIDesc,2)).doubleValue() ;
	   			valorTotalDescontoNota +=Utilitaria.toNumber(Utilitaria.formatarNumero(valor,2)).doubleValue();
	   		 }else{
	     		    
	     			vlITotal =  valor;
	     		 }
	     		itensArray.put("valor_desconto",Utilitaria.toNumber(Utilitaria.formatarNumero(vlIDesc,2)).doubleValue());
			itensArray.put("valor_bruto",Utilitaria.toNumber(Utilitaria.formatarNumero(valor,2)).doubleValue());
					

			items.put(itensArray);
			System.out.println(itensArray.toString());
			jsonNota.put("items", items);
			if(valorDesconto != 0){
				jsonNota.put("valor_total",(Utilitaria.toNumber(Utilitaria.formatarNumero(valorTotalDescontoNota,2)).doubleValue() - Utilitaria.toNumber(Utilitaria.formatarNumero(valorTotalDesconto,2)).doubleValue() ));
	     		         jsonNota.put("valor_produtos",(Utilitaria.toNumber(Utilitaria.formatarNumero(valorTotalDescontoNota,2)).doubleValue()));
	     		         jsonNota.put("valor_desconto",(Utilitaria.toNumber(Utilitaria.formatarNumero(valorTotalDesconto,2)).doubleValue()));
	   		 }
			
			
			
                           cont++;
			
		}
    	         RetornoNotaFiscal retornoNotaFiscal =  new RetornoNotaFiscal();
    	         RetornoNotaFiscalDAO daoRetornoNotaFiscal = new RetornoNotaFiscalDAO(conn);
		String retorno = "";
		String url = IUrls.urlProducao+idPedidoSaida;
		IntegracaoWS integracao = new IntegracaoWS();
		mensagem += integracao.enviarNotaFiscal(url, jsonNota.toString());
		
		String urlConsultar = IUrls.urlConsulta+idPedidoSaida;
		mensagem += " - Consulta: "+integracao.consultaNotaFiscal(urlConsultar);
		retornoNotaFiscal.setId_pedido_saida(Integer.parseInt(idPedidoSaida));
		retornoNotaFiscal.setMensagem_retorno(mensagem);
		String usuario = (String)session.getAttribute("Login");
		retornoNotaFiscal.setUsuario(usuario);
		daoRetornoNotaFiscal.incluir(retornoNotaFiscal);
		try{
		    StringBuffer tratamentoRetorno = new StringBuffer();
		    tratamentoRetorno.append(mensagem);
		    String caminho_danfe   	   = tratamentoRetorno.substring(tratamentoRetorno.indexOf("---") + 1, tratamentoRetorno.indexOf(".pdf") + 1);
		    String caminho_xml_nota_fiscal     = "".valueOf(tratamentoRetorno.lastIndexOf("caminho_xml_nota_fiscal"));
		    //String chave_nfe      		 = (String) data.get("chave_nfe");
		    //String mensagem_sefaz        	 = (String) data.get("mensagem_sefaz");
		    //String numero			 = (String) data.get("numero");
		    //String serie      		 = (String) data.get("serie");
		    //String status        	 	 = (String) data.get("status");
		    System.out.println(caminho_danfe);
		    System.out.println(caminho_xml_nota_fiscal);
		    
		}catch(Exception e){
		    System.out.println("ERRO:"+e.getMessage());
		}
		

	}

	//Gerar Arquivo
	FileWriter writeFile = null;

	try {
		
		writeFile = new FileWriter("C:/notas/envios/" + idPedidoSaida
				+ ".nfe");
		//Escreve no arquivo conteudo do Objeto JSON
		writeFile.write(jsonNota.toString(0));
		//writeFile.write(jsonNota.getString("forma_pagamento"));
		writeFile.close();
	} catch (IOException e) {
		e.printStackTrace();
	}
%>
<% if (mensagem != null) { %><div class="mensagem"><center><%= mensagem %></center></div><hr><% } %>
<%@include file="../fimConexao.jsp"%>

<p align="right">|<a class="button" href="javascript:void()" onclick="window.close()">Fechar</a>|