package com.human.gateway.client.service.base;

import java.util.List;

import com.human.gateway.client.bean.Response;
import com.human.gateway.client.exception.ClientHumanException;

/**
 * Interface base para envio de multiplos sms.
 * 
 * @author tiago martins
 * @version 2.0
 * @since 20-may-2011
 */
public interface IMultipleBaseService extends IBaseService {
	/**
	 * Envia uma requisicao ao servidor para consulta de status de sms.
	 * 
	 * @param ids
	 * @return
	 * @throws ClientHumanException
	 */
	public List<Response> query(String[] ids) throws ClientHumanException;
}
