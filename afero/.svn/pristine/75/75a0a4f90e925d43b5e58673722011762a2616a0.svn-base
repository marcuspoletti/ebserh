package com.human.gateway.client.service;

import java.util.List;

import org.apache.commons.httpclient.methods.PostMethod;

import com.human.gateway.client.bean.SimpleMessage;
import com.human.gateway.client.exception.ClientHumanException;
import com.human.gateway.client.service.base.BaseService;
import com.human.gateway.client.util.HttpClientHelper;

/**
 * Classe responsavel pelos servicos destinados a consulta de 
 * mensagens de sms no gateway.
 * @author fabio.souza
 *
 */
public class QueryMessageService extends BaseService {

	private static final String GATEWAY_URI = "/GatewayIntegration/msgSms.do";
	private static final String GATEWAY_HOST = "api.zenvia360.com.br";
	private static final int GATEWAY_PORT = 80;
	private static final String DISPATCH_RECEIVED = "listReceived";
	
	/**
	 * Construtor da classe que permite fornecer a conta e a senha 
	 * para autenticacao no gateway.
	 * @param account
	 * @param password
	 */
	public QueryMessageService(String account, String password) {
		super(account, password);
		this.getHttp().setHost(GATEWAY_HOST);
		this.getHttp().setUri(GATEWAY_URI);
		this.getHttp().setPort(GATEWAY_PORT);
	}	
	
	/**
	 * Construtor da classe que permite fornecer a conta, a senha e o helper de conexao
	 * para autenticacao no gateway.
	 * @param account
	 * @param password
	 * @param httpHelper
	 */
	public QueryMessageService(String account, String password,	HttpClientHelper httpHelper) {
		super(account, password, httpHelper);
	}

	/**
	 * Busca por mensagens recebidas(MO) no gateway.
	 * @return Lista de mensagens recebidas(MO). Caso nenhuma mensagem 
	 * seja encontrada sera retornada uma lista vazia. 
	 * @throws ClientHumanException
	 */
	public List<SimpleMessage> listReceivedSMS() throws ClientHumanException {
		validateAccountAndPassword();
		PostMethod post = new PostMethod();
		post.addParameter(PARAM_ACCOUNT, this.getAccount());
		post.addParameter(PARAM_CODE, this.getPassword());
		post.addParameter(PARAM_DISPATCH, DISPATCH_RECEIVED);
		List<SimpleMessage> messages = this.getHttp().requestAndGetMessages(post);
		return messages;		
	}	
	
}
