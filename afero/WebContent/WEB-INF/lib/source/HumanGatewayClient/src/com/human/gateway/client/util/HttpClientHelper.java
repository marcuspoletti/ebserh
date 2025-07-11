package com.human.gateway.client.util;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.UsernamePasswordCredentials;
import org.apache.commons.httpclient.auth.AuthScope;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.multipart.MultipartRequestEntity;
import org.apache.commons.httpclient.methods.multipart.Part;
import org.apache.commons.lang.StringUtils;

import com.human.gateway.client.bean.ProxyConfiguration;
import com.human.gateway.client.bean.Response;
import com.human.gateway.client.bean.SimpleMessage;
import com.human.gateway.client.enumerator.ProtocolEnum;
import com.human.gateway.client.exception.ClientHumanException;

/**
 * Classe responsavel por possuir ferramentas http.
 * 
 * @author tiago martins
 * @version 2.0
 * @since 20-may-2011
 */
public class HttpClientHelper {
	private String host;
	private String uri;
	private int port;
	private ProtocolEnum protocol;
	private ProxyConfiguration proxy;
	private boolean useSSL;
	private HttpClient httpClient;
	
	/**
	 * Construtor default
	 */
	public HttpClientHelper() {
		this.setUseSSL(false);
		this.httpClient = new HttpClient();
	}
	
	/**
	 * Construtor alternativo que permite fornecer uma instancia da classe
	 * HttpClient.
	 * @param httpClient
	 */
	public HttpClientHelper(HttpClient httpClient) {
		this.setUseSSL(false);
		this.httpClient = httpClient;
	}

	/**
	 * @param host the host to set
	 */
	public void setHost(String host) {
		this.host = host;
	}

	/**
	 * @return the host
	 */
	public String getHost() {
		return host;
	}

	/**
	 * @param uri the uri to set
	 */
	public void setUri(String uri) {
		this.uri = uri;
	}

	/**
	 * @return the uri
	 */
	public String getUri() {
		return uri;
	}

	/**
	 * @param port the port to set
	 */
	public void setPort(int port) {
		this.port = port;
	}

	/**
	 * @return the port
	 */
	public int getPort() {
		return port;
	}

	/**
	 * @param protocol the protocol to set
	 */
	public void setProtocol(ProtocolEnum protocol) {
		this.protocol = protocol;
	}

	/**
	 * @return the protocol
	 */
	public ProtocolEnum getProtocol() {
		return protocol;
	}

	/**
	 * @param proxy the proxy to set
	 */
	public void setProxy(ProxyConfiguration proxy) {
		this.proxy = proxy;
	}

	/**
	 * @return the proxy
	 */
	public ProxyConfiguration getProxy() {
		return proxy;
	}

	/**
	 * Seta a porta e o protocolo referente ao uso (ou nao) de ssl.
	 * 
	 * @param useSSL the useSSL to set
	 */
	public void setUseSSL(boolean useSSL) {
		this.useSSL = useSSL;
		
		if (this.useSSL) {
			this.port = 443;
			this.setProtocol(ProtocolEnum.SECURE_PROTOCOL);
		} else {
			this.port = 80;
			this.setProtocol(ProtocolEnum.PROTOCOL);
		}
	}

	/**
	 * @return the useSSL
	 */
	public boolean isUseSSL() {
		return useSSL;
	}
	
	/**
	 * Cria, executa e retorna o resultado de uma requicao multipart.
	 * 
	 * @param parts
	 * @return
	 * @throws ClientHumanException
	 */
	public List<Response> multipartRequest(Part[] parts) throws ClientHumanException {
		PostMethod post = new PostMethod();
		
		post.setRequestEntity(new MultipartRequestEntity(parts, post.getParams()));
		
		return this.simpleRequest(post);
	}
	
	/**
	 * Cria, executa e retorna o resultado de uma requicao simples.
	 * 
	 * @param post
	 * @return
	 * @throws ClientHumanException
	 */
	public List<Response> simpleRequest(PostMethod post) throws ClientHumanException {
		InputStream stream = request(post);
		List<Response> response = getResponse(stream);
		return response;
	}
	
	/**
	 * Busca por todas as mensagens recebidas(MO) da conta no gateway .
	 * 
	 * @param post
	 * @return
	 * @throws ClientHumanException
	 */
	public List<SimpleMessage> requestAndGetMessages(PostMethod post) throws ClientHumanException {
		InputStream stream = request(post);
		List<SimpleMessage> messages = ResponseParser.getMessages(stream);
		return messages;
	}
	
	/**
	 * Faz a requisição para o gateway de sms e retorna uma stream com o conteudo retornado.
	 * @param post
	 * @return stream com os dados retornados pela consulta ao gateway
	 */
	private InputStream request(PostMethod post) throws ClientHumanException{
		//Configura a conexao		
		configureConnection(httpClient);		
		post.setPath(this.uri);		
		try {
			int status = httpClient.executeMethod(post);
			if (status == HttpStatus.SC_OK) {
				return new ByteArrayInputStream(post.getResponseBodyAsString().getBytes(post.getResponseCharSet()));				 
			} else {
				throw new ClientHumanException(HttpStatus.getStatusText(status));
			}
		} catch (HttpException e) {
			throw new ClientHumanException(e);
		} catch (IOException e) {
			throw new ClientHumanException(e);
        } finally {
            post.releaseConnection();
		}
	}
		
	/**
	 * Configura uma conexao com o host
	 * 
	 * @param client
	 */
	private void configureConnection(HttpClient client) {
		client.getHostConfiguration().setHost(this.host, this.port, this.protocol.getValue());
		
		if (this.proxy != null && !StringUtils.isEmpty(this.proxy.getHost())) {
			client.getHostConfiguration().setProxy(this.proxy.getHost(), this.proxy.getPort());
			
			if (!StringUtils.isEmpty(this.proxy.getUsername()) && !StringUtils.isEmpty(this.proxy.getPassword())) {
				AuthScope auth = new AuthScope(this.proxy.getHost(), this.proxy.getPort());
				UsernamePasswordCredentials credential = new UsernamePasswordCredentials(this.proxy.getUsername(), this.proxy.getPassword());
				
				client.getState().setProxyCredentials(auth, credential);
			}
		}
	}
	
	/**
	 * Busca os dados de resposta e formata em uma lista.
	 * 
	 * @param responseBody
	 * @return
	 * @throws ClientHumanException
	 */
	private List<Response> getResponse(InputStream responseBody) throws ClientHumanException {
		return ResponseParser.getResponses(responseBody);
	}
	
}
