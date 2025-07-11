package com.human.gateway.client.enumerator;


/**
 * Enumerador para os tipos de layout existentes
 * 
 * @author tiago martins
 * @version 2.0
 * @since 20-may-2011
 */
public enum LayoutTypeEnum {
	/**
	 * to;msg
	 */
	TYPE_A(1, 'A'),
	/**
	 * to;msg;from
	 */
	TYPE_B(2, 'B'),
	/**
	 * to;msg;id
	 */
	TYPE_C(3, 'C'),
	/**
	 * to;msg;id;from
	 */
	TYPE_D(4, 'D'),
	/**
	 * to;msg;id;from;schedule
	 */
	TYPE_E(5, 'E');
	
	private final Integer id;
	private final Character type;	
	
	public Character getType() {
		return type;
	}

	LayoutTypeEnum(Integer id, Character type) {
		this.id = id;
		this.type = type;
	}
	
	public static LayoutTypeEnum get(Character type){		
		for(LayoutTypeEnum camp : LayoutTypeEnum.values()) {
			if(camp.type.equals(type)) {
				return camp;
			}
		}
		throw new IllegalArgumentException();
	}
	
	public static Character get(int id){
		for(LayoutTypeEnum camp : LayoutTypeEnum.values()) {
			if(camp.id.equals(id)) {
				return camp.type;
			}
		}
		throw new IllegalArgumentException();
	}
	
	public Integer getId() {
		return id;
	}
}
