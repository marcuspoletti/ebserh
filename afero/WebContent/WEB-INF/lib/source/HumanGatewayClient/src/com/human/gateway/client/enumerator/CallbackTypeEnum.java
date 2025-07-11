package com.human.gateway.client.enumerator;

/**
 * Enumerador para os tipos de callback.
 * 
 * @author tiago martins
 * @version 2.0
 * @since 20-may-2011
 */
public enum CallbackTypeEnum {
	/**
	 * Nao realiza callback (padrao)
	 */
	INACTIVE(0),
	/**
	 * Envia apenas o status final da mensagem
	 */
	FINAL(1),
	/**
	 * Envia os status intermediarios e final da mensagem.
	 */
	FULL(2);
	
	private int id;
	
	private CallbackTypeEnum(int id) {
		this.id = id;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	
	
}
