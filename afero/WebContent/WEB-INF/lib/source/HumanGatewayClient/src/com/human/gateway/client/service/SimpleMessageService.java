package com.human.gateway.client.service;

import java.util.List;

import org.apache.commons.httpclient.methods.PostMethod;

import com.human.gateway.client.bean.Message;
import com.human.gateway.client.bean.Response;
import com.human.gateway.client.bean.SimpleMessage;
import com.human.gateway.client.exception.ClientHumanException;
import com.human.gateway.client.service.base.BaseService;
import com.human.gateway.client.service.base.ISimpleBaseService;
import com.human.gateway.client.util.HttpClientHelper;

/**
 * Classe responsavel pelos servicos destinados ao envio de 
 * mensagens sms individuais para o gateway.
 * 
 * @author tiago martins
 * @version 2.0
 * @since 20-may-2011
 */
public class SimpleMessageService extends BaseService implements ISimpleBaseService {
	
	private static final String GATEWAY_URI = "/GatewayIntegration/msgSms.do";
	private static final String GATEWAY_HOST = "api.zenvia360.com.br";
	private static final int GATEWAY_PORT = 80;
	private static final String SEND = "send";
	private static final String CHECK = "check";

	/**
	 * Construtor da classe que permite fornecer a conta e a senha
	 * para autenticacao no gateway.
	 * 
	 * @param account
	 * @param password
	 */
	public SimpleMessageService(String account, String password) {
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
	public SimpleMessageService(String account, String password, HttpClientHelper httpHelper) {
		super(account, password, httpHelper);
	}
	
	
	@Override
	public List<Response> send(Message message) throws ClientHumanException {
		SimpleMessage simpleMessage = (SimpleMessage) message;
		
		validateAccountAndPassword();
		
		String format = null;
		if (simpleMessage.getSchedule() != null) {
			format = this.getDateFormat().format(simpleMessage.getSchedule());
		}
		
		validateMessage(simpleMessage.getTo(), simpleMessage.getMessage(), simpleMessage.getId(), simpleMessage.getFrom(), format);
				
		PostMethod post = new PostMethod();
		post.addParameter(PARAM_DISPATCH, SEND);
		post.addParameter(PARAM_ACCOUNT, this.getAccount());
		post.addParameter(PARAM_CODE, this.getPassword());
		post.addParameter(PARAM_MSG, simpleMessage.getMessage());
		post.addParameter(PARAM_TO, simpleMessage.getTo());
		
		if (simpleMessage.getFrom() != null) {
			post.addParameter(PARAM_FROM, simpleMessage.getFrom());
		}
		if (simpleMessage.getId() != null) {
			post.addParameter(PARAM_ID, simpleMessage.getId());
		}
		if (format != null) {
			post.addParameter(PARAM_SCHEDULE, format);
		}
		post.addParameter(PARAM_CALLBACK_OPTION, String.valueOf(simpleMessage.getCallback().getId()));
		
		return this.sendRequest(post);
	}
	
	@Override
	public List<Response> query(String id) throws ClientHumanException {
		validateAccountAndPassword();

		if (id == null || id.trim().isEmpty()) {
			throw new ClientHumanException("Id is empty.");
		}
				
		PostMethod post = new PostMethod();
		
		post.addParameter(PARAM_ACCOUNT, this.getAccount());
		post.addParameter(PARAM_CODE, this.getPassword());
		
		post.addParameter(PARAM_DISPATCH, CHECK);
		post.addParameter(PARAM_ID, id);
		
		return this.sendRequest(post);
	}
}
