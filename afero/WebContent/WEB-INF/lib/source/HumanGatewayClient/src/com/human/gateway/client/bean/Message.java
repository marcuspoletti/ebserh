package com.human.gateway.client.bean;

import com.human.gateway.client.enumerator.CallbackTypeEnum;

/**
 * Classe abstrata utilizada como molde para construcao de todo o tipo de classe
 * para envio de sms.
 * 
 * @author tiago martins
 * @version 2.0
 * @since 20-may-2011
 */
public abstract class Message {
	/**
	 * O callback que a mensagem (ou a lista de mensagens) irá ter. 
	 */
	private CallbackTypeEnum callback;
	
	/**
	 * Construtor da classe setando o callback default (Inativo).
	 */
	public Message() {
		callback = CallbackTypeEnum.INACTIVE;
	}
	
	/**
	 * Retorna o tipo de callback
	 * 
	 * @return
	 */
	public CallbackTypeEnum getCallback() {
		return callback;
	}
	
	/**
	 * Seta o tipo de callback
	 * 
	 * @param callback
	 */
	public void setCallback(CallbackTypeEnum callback) {
		this.callback = callback;
	}
}
