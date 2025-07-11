package com.human.gateway.client.bean;

import com.human.gateway.client.enumerator.LayoutTypeEnum;
import com.human.gateway.client.exception.ClientHumanException;

/**
 * Classe abstrata que é utilizada como modelos para 
 * os tipos de mensagens multiplas possiveis.
 * 
 * @author tiago martins
 * @version 2.0
 * @since 20/05/2011
 */
public abstract class MultipleMessage extends Message {
	
	/**
	 * Tipo de layout da lista ou arquivo a ser enviado
	 */
	private LayoutTypeEnum type;
	
	/**
	 * Contrutor da classe informando o tipo de layout do arquivo ou lista
	 * 
	 * @param type
	 */
	public MultipleMessage(LayoutTypeEnum type) {
		super();
		this.type = type;
	}
	
	/**
	 * Seta o tipo de layout do arquivo ou lista
	 * 
	 * @param type the type to set
	 */
	public void setType(LayoutTypeEnum type) {
		this.type = type;
	}

	/**
	 * Retorna o tipo de layout do arquivo ou lista
	 * 
	 * @return the type
	 */
	public LayoutTypeEnum getType() {
		return type;
	}
	
	/**
	 * Retorna o conteudo a ser enviado
	 * 
	 * @return
	 * @throws ClientHumanException
	 */
	public abstract String getContent() throws ClientHumanException;
}
