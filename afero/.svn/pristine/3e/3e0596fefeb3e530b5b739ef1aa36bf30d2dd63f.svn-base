/**
 * 
 */
package com.human.gateway.client.service.base;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.multipart.Part;
import org.apache.commons.lang.StringUtils;

import com.human.gateway.client.bean.ProxyConfiguration;
import com.human.gateway.client.bean.Response;
import com.human.gateway.client.exception.ClientHumanException;
import com.human.gateway.client.util.HttpClientHelper;

/**
 * Classe abstrata que serve como base para todo o 
 * tipo de envio de requisicao para o gateway de sms.
 * 
 * @author tiago martins
 * @version 2.0
 * @since 20-may-2011
 */
public abstract class BaseService {
	
	public static final String PARAM_TO = "to";
	public static final String PARAM_MSG = "msg";
	public static final String PARAM_ID = "id";
	public static final String PARAM_FROM = "from";
	public static final String PARAM_SCHEDULE = "schedule";
	public static final String PARAM_CALLBACK_OPTION = "callbackOption";
	
	public static final String PARAM_CODE = "code";
	public static final String PARAM_ACCOUNT = "account";
	public static final String PARAM_DISPATCH = "dispatch";
	
	
	/**
	 * Tamanho maximo da mensagem considerando "from"
	 */
	public static final int BODY_MAX_LENGTH = 150;

	/**
	 * Tamanho maximo para o campo ID
	 */
	public static final int ID_MAX_LENGTH = 20;

	/**
	 * Pattern para formatacao de data
	 */
	public static final String DATE_FORMAT = "dd/MM/yyyy HH:mm:ss";
	
	private String account;
	private String password;
	private HttpClientHelper http;
	private SimpleDateFormat dateFormat;
	
	/**
	 * 
	 * @param account
	 * @param password
	 */
	public BaseService(String account, String password) {
		this(account, password, new HttpClientHelper());
	}
	
	/**
	 * 
	 * @param account
	 * @param password
	 * @param httpHelper
	 */
	public BaseService(String account, String password, HttpClientHelper httpHelper) {
		this.account = account;
		this.password = password;
		this.http = httpHelper;
		setDateFormat(new SimpleDateFormat(DATE_FORMAT));
	} 
	
	/**
	 * Seta o uso de ssl.
	 * 
	 * @param newvar
	 */
	public void setUseSSL(boolean newvar) {
		this.http.setUseSSL(newvar);
	}
	
	/**
	 * Seta as configuracoes de proxy.
	 * 
	 * @param proxy
	 */
	public void setProxy(ProxyConfiguration proxy) {
		this.http.setProxy(proxy);
	}
	
	/**
	 * @return the useSSL
	 */
	public boolean isUseSSL() {
		return this.http.isUseSSL();
	}
	
	/**
	 * Envia uma requisicao simples para um sevidor
	 * 
	 * @param post
	 * @return
	 * @throws ClientHumanException
	 */
	protected List<Response> sendRequest(PostMethod post) throws ClientHumanException {
		return http.simpleRequest(post);
	}
	
	/**
	 * Envia uma requisicao multipartpara o servidor
	 * 
	 * @param parts
	 * @return
	 * @throws ClientHumanException
	 */
	protected List<Response> sendRequest(Part[] parts) throws ClientHumanException {
		return http.multipartRequest(parts);
	}
	
	/**
	 * @return Conta
	 */
	public String getAccount() {
		return account;
	}
	
	/**
	 * @return Senha
	 */
	public String getPassword() {
		return password;
	}
	
	/**
	 * @return Configuracoes http
	 */
	protected HttpClientHelper getHttp() {
		return http;
	}
	
	/**
	 * @param dateFormat the dateFormat to set
	 */
	public void setDateFormat(SimpleDateFormat dateFormat) {
		this.dateFormat = dateFormat;
	}

	/**
	 * @return the dateFormat
	 */
	public SimpleDateFormat getDateFormat() {
		return dateFormat;
	}
	
	/**
	 * Valida parametros gerais da mensagem (campos obrigatorios, tamanho do texto, etc).
	 * 
	 * @param to
	 * @param message
	 * @param id
	 * @param from
	 * @param schedule
	 * @throws ClientHumanException
	 */
	protected void validateMessage(String to, String message, String id, String from, String schedule) throws ClientHumanException {
		try {
			if (schedule != null) {
				this.getDateFormat().parse(schedule);
			}
		} catch (ParseException e) {
			throw new ClientHumanException("Date invalid.");
		}
		
		this.validateMessage(to, message, id, from);
	}
	
	/**
	 * Valida parametros gerais da mensagem (campos obrigatorios, tamanho do texto, etc).
	 * 
	 * @param to
	 * @param message
	 * @param id
	 * @param from
	 * @throws ClientHumanException
	 */
	protected void validateMessage(String to, String message, String id, String from) throws ClientHumanException {
		if (id != null && id.length() > ID_MAX_LENGTH) {
			throw new ClientHumanException("Field \""+PARAM_ID+"\" can not have more than "+ID_MAX_LENGTH+" characters.");
		}
		
		this.validateMessage(to, message, from);
	}
	
	/**
	 * Valida parametros gerais da mensagem (campos obrigatorios, tamanho do texto, etc).
	 * 
	 * @param to
	 * @param message
	 * @param from
	 * @throws ClientHumanException
	 */
	protected void validateMessage(String to, String message, String from) throws ClientHumanException {
		int length = BODY_MAX_LENGTH;
		if (from != null) {
			length -= from.length();
		}
		
		this.validateMessage(to, message, length);
	}
	
	/**
	 * Valida parametros gerais da mensagem (campos obrigatorios, tamanho do texto, etc).
	 * 
	 * @param to
	 * @param message
	 * @throws ClientHumanException
	 */
	protected void validateMessage(String to, String message) throws ClientHumanException {
		int length = BODY_MAX_LENGTH;
		this.validateMessage(to, message, length);
	}
	
	/**
	 * Valida parametros gerais da mensagem (campos obrigatorios, tamanho do texto, etc).
	 * 
	 * @param to
	 * @param message
	 * @param length
	 * @throws ClientHumanException
	 */
	private void validateMessage(String to, String message, int length) throws ClientHumanException {
		if (to == null || to.trim().isEmpty()) {
			throw new ClientHumanException("Field \""+PARAM_TO+"\" is required.");
		}
		
		if (message == null || message.trim().isEmpty()) {
			throw new ClientHumanException("Field \""+PARAM_MSG+"\" is required.");
		} else {
			if (length < message.length()) {
				throw new ClientHumanException("Fields \"" + PARAM_MSG+"\" + \""+PARAM_FROM + "\" can not exceed "+BODY_MAX_LENGTH+" characters.");
			}
		}
	}
	
	/**
	 * Valida a conta e a senha.
	 * 
	 * @throws ClientHumanException
	 */
	protected void validateAccountAndPassword() throws ClientHumanException {
		if (StringUtils.isEmpty(this.getAccount())) {
			throw new ClientHumanException("Field \"" + PARAM_ACCOUNT + "\" is required.");
		}
		if (StringUtils.isEmpty(this.getPassword())) {
			throw new ClientHumanException("Field \"" + PARAM_CODE + "\" is required.");
		}
	}
}
