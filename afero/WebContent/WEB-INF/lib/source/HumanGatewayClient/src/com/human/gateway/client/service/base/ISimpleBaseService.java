package com.human.gateway.client.service.base;

import java.util.List;

import com.human.gateway.client.bean.Response;
import com.human.gateway.client.exception.ClientHumanException;

/**
 * Interface base para envio de mensagem sms simples.
 * 
 * @author tiago martins
 * @version 2.0
 * @since 20-may-2011
 */
public interface ISimpleBaseService extends IBaseService {
	/**
	 * Envia uma requisicao ao servidor para consulta de status de sms.
	 * 
	 * @param ids
	 * @return
	 * @throws ClientHumanException
	 */
	public List<Response> query(String id) throws ClientHumanException;
}
