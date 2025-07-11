package com.human.gateway.client.bean;

import com.human.gateway.client.enumerator.LayoutTypeEnum;
import com.human.gateway.client.exception.ClientHumanException;

/**
 * Classe responsavel por armazenar uma lista de sms 
 * para envio para o gateway de sms.
 * 
 * @author tiago martins
 * @version 2.0
 * @since 20-may-2011
 */
public class ListResource extends MultipleMessage {
	
	/**
	 * Lista de sms a ser enviada.
	 */
	private String content;
	
	/**
	 * Construtor da classe informando a lista de sms e o tipo de layout da mesma.
	 * 
	 * @param list
	 * @param type
	 */
	public ListResource(String list, LayoutTypeEnum type) {
		super(type);
		content = list;
	}
	
	@Override
	public String getContent() throws ClientHumanException {
		return this.content;
	}

}
