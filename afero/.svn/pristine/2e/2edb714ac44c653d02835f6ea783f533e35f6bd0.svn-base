package com.human.gateway.client.service.base;

import java.util.List;

import com.human.gateway.client.bean.Message;
import com.human.gateway.client.bean.Response;
import com.human.gateway.client.exception.ClientHumanException;

/**
 * Interface base para servicos que envolve envio de mensagens sms.
 * 
 * @author tiago martins
 * @version 2.0
 * @since 20-may-2011
 */
public interface IBaseService {
	/**
	 * Envia uma requisicao ao servidor para envio de mensagem sms.
	 * 
	 * @param message
	 * @return
	 * @throws ClientHumanException
	 */
	public List<Response> send(Message message) throws ClientHumanException;
}
