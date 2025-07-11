package com.human.gateway.client.service;

import java.io.FileNotFoundException;
import java.util.List;

import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.multipart.FilePart;
import org.apache.commons.httpclient.methods.multipart.Part;
import org.apache.commons.httpclient.methods.multipart.StringPart;
import org.apache.commons.lang.StringUtils;

import com.human.gateway.client.bean.FileResource;
import com.human.gateway.client.bean.ListResource;
import com.human.gateway.client.bean.Message;
import com.human.gateway.client.bean.MultipleMessage;
import com.human.gateway.client.bean.Response;
import com.human.gateway.client.enumerator.LayoutTypeEnum;
import com.human.gateway.client.exception.ClientHumanException;
import com.human.gateway.client.service.base.BaseService;
import com.human.gateway.client.service.base.IMultipleBaseService;
import com.human.gateway.client.util.HttpClientHelper;

/**
 * Classe responsavel pelos servicos destinados ao envio de 
 * multiplas mensagens de sms para o gateway.
 * 
 * @author tiago martins
 * @version 2.0
 * @since 20-may-2011
 */
public class MultipleMessageService extends BaseService implements IMultipleBaseService {
	
	private static final String GATEWAY_URI = "/GatewayIntegration/msgSms.do";
	private static final String GATEWAY_HOST = "api.zenvia360.com.br";
	private static final int GATEWAY_PORT = 80;
	private static final String SEND_MULTIPLE = "sendMultiple";
	private static final String CHECK_MULTIPLE = "checkMultiple";
	public static final String PARAM_FILE = "file";
	public static final String PARAM_LIST = "list";
	public static final String PARAM_TYPE = "type";
	public static final String PARAM_ID_LIST = "idList";	
		
	/**
	 * Construtor da classe que permite fornecer a conta, senha e a instancia da conexao
	 * para autenticacao no gateway.
	 * 
	 * @param account
	 * @param password
	 */
	public MultipleMessageService(String account, String password) {
		super(account, password);
		this.getHttp().setHost(GATEWAY_HOST);
		this.getHttp().setUri(GATEWAY_URI);
		this.getHttp().setPort(GATEWAY_PORT);
	}
	
	/**
	 * Construtor da classe que permite fornecer a conta, a senha e o helper de conexao
	 * para autenticacao no gateway.
	 * 
	 * @param account
	 * @param password
	 * @param httpHelper
	 */
	public MultipleMessageService(String account, String password, HttpClientHelper httpHelper) {
		super(account, password, httpHelper);
	}
	
	@Override
	public List<Response> send(Message message) throws ClientHumanException {
		MultipleMessage multipleMessage = (MultipleMessage) message;
		validateAccountAndPassword();
				
		validateSend(multipleMessage);
		
		if (multipleMessage instanceof ListResource) {
			PostMethod post = new PostMethod();
			
			post.addParameter(PARAM_DISPATCH, SEND_MULTIPLE);
			post.addParameter(PARAM_ACCOUNT, this.getAccount());
			post.addParameter(PARAM_CODE, this.getPassword());
			post.addParameter(PARAM_CALLBACK_OPTION, String.valueOf(message.getCallback().getId()));
            post.addParameter(PARAM_TYPE, multipleMessage.getType().getType().toString());
			post.addParameter(PARAM_LIST, multipleMessage.getContent());
			
			return this.sendRequest(post);
		} else if (multipleMessage instanceof FileResource) {
			FileResource fileResource = (FileResource) multipleMessage;
			
			FilePart filePart;
			try {
				filePart = new FilePart(PARAM_FILE, fileResource.getFile());
			} catch (FileNotFoundException e) {
				throw new ClientHumanException("File not found.");
			}
			Part[] parts = {new StringPart(PARAM_DISPATCH, SEND_MULTIPLE),
						    new StringPart(PARAM_ACCOUNT, this.getAccount()),
						    new StringPart(PARAM_CODE, this.getPassword()),
						    new StringPart(PARAM_CALLBACK_OPTION, multipleMessage.getCallback().toString()),
						    new StringPart(PARAM_TYPE, multipleMessage.getType().getType().toString()),
							filePart};
			
			return this.sendRequest(parts);
		} else {
			throw new ClientHumanException("Message is invalid.");
		}
	}
	
	@Override
	public List<Response> query(String[] ids) throws ClientHumanException {
		if ((ids == null) || (ids.length == 0)) {
			throw new ClientHumanException("Id is empty.");
		} else if (ids.length == 1) {
			SimpleMessageService sMessageService = new SimpleMessageService(this.getAccount(), this.getPassword());
			return sMessageService.query(ids[0]);
		}
		validateAccountAndPassword();
						
		PostMethod post = new PostMethod();
		
		post.addParameter(PARAM_ACCOUNT, this.getAccount());
		post.addParameter(PARAM_CODE, this.getPassword());
		post.addParameter(PARAM_DISPATCH, CHECK_MULTIPLE);
		
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < ids.length; i++) {
			if (i == (ids.length-1)) {
				sb.append(ids[i]);
			} else {
				sb.append(ids[i]).append(";");
			}
		}
		post.addParameter(PARAM_ID_LIST, sb.toString());
		
		return this.sendRequest(post);
	}
	
	/**
	 * Valida os dados para envio de mensagem multipla
	 * 
	 * @param message
	 * @return
	 * @throws ClientHumanException
	 */
	private boolean validateSend(MultipleMessage message) throws ClientHumanException {
		String content = message.getContent();
		if (StringUtils.isEmpty(content)) {
			throw new ClientHumanException("Was not informed to send a list of messages.");
		}
		
		String[] line = null;
		if (content.contains("\r\n")) {
			line = content.split("\r\n");
		} else {
			line = content.split("\n");
		}
		
		for (int i = 0; i < line.length; i++) {
			validateMessage(message.getType(), line[i]);
		}
		return true;
	}
	
	/**
	 * Valida parametros gerais da mensagem (campos obrigatorios, tamanho do texto,
	 * etc).
	 * @throws ClientHumanException 
	 */
	private void validateMessage(LayoutTypeEnum type, String linha) throws ClientHumanException {
		String[] fields = linha.split(";");
		
		if (LayoutTypeEnum.TYPE_A.equals(type)) {
			if (fields.length != 2) {
				throw new ClientHumanException("File format invalid.");
			}
			
			this.validateMessage(fields[0], fields[1]);
		} else if (LayoutTypeEnum.TYPE_B.equals(type)) {
			if (fields.length != 3) {
				throw new ClientHumanException("File format invalid.");
			}

			this.validateMessage(fields[0], fields[1], fields[2]);
		} else if (LayoutTypeEnum.TYPE_C.equals(type)) {
			if (fields.length != 3) {
				throw new ClientHumanException("File format invalid.");
			}
			
			this.validateMessage(fields[0], fields[1], fields[2], null);
		} else if (LayoutTypeEnum.TYPE_D.equals(type)) {
			if (fields.length != 4) {
				throw new ClientHumanException("File format invalid.");
			}
			
			this.validateMessage(fields[0], fields[1], fields[2], fields[3]);
		} else if (LayoutTypeEnum.TYPE_E.equals(type)) {
			if (fields.length != 5) {
				throw new ClientHumanException("File format invalid.");
			}
			
			this.validateMessage(fields[0], fields[1], fields[2], fields[3], fields[4]);
		} else {
			throw new ClientHumanException("Type of file format invalid.");
		}
	}
}
