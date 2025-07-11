/**
 * 
 */
package com.human.gateway.client.enumerator;

/**
 * Enumerador para os protocolos utilizados pela API.
 * 
 * @author tiago martins
 * @version 2.0
 * @since 20-may-2011
 */
public enum ProtocolEnum {
	/**
	 * http
	 */
	PROTOCOL(1, "http"),
	/**
	 * https
	 */
	SECURE_PROTOCOL(2, "https");
	
	private final Integer id;
	private final String protocol;	
	
	ProtocolEnum(Integer id, String protocol) {
		this.id = id;
		this.protocol = protocol;
	}
	
	public static ProtocolEnum get(String protocol){		
		for(ProtocolEnum camp : ProtocolEnum.values()) {
			if(camp.protocol.equals(protocol)) {
				return camp;
			}
		}
		throw new IllegalArgumentException();
	}
	
	public static String get(int id){
		for(ProtocolEnum camp : ProtocolEnum.values()) {
			if(camp.id.equals(id)) {
				return camp.protocol;
			}
		}
		throw new IllegalArgumentException();
	}
	
	public Integer getId() {
		return id;
	}
	
	public String getValue() {
		return this.protocol;
	}
}
