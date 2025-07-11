package com.human.gateway.client.bean;

/**
 * Classe responsavel por armazenar os dados do retorno da requisicao para o gateway de sms.
 * 
 * @author tiago martins
 * @version 2.0
 * @since 20-may-2011
 */
public class Response {

	/**
	 * Tipo de retorno quando OK.
	 */
	private static final String RETORNO_OK = "#000#200#100#110#111#120#";
	
	/**
	 * Informa se ocorreu erro no envio
	 */
	private boolean error;
	
	/**
	 * Codigo de retorno conforme tabela.
	 */
	private String returnCode;
	
	/**
	 * Descricao do codigo de retorno.
	 */
	private String returnDescription;
	
	public Response(){
	}
	
	public Response(String msg){
		returnCode = msg.substring(0,3);
		returnDescription = msg.substring(6);
		error = (RETORNO_OK.indexOf(returnCode) < 0);
	}

	public void finalize() throws Throwable {
	}

	/**
	 * Codigo de retorno conforme tabela.
	 * 
	 * @return Codigo de retorno
	 */
	public String getReturnCode() {
		return returnCode;
	}
	
	/**
	 * Descricao de retorno conforme tabela
	 * 
	 * @return Descricao de retorno
	 */
	public String getReturnDescription() {
		return returnDescription;
	}

	/**
	 * Informa se ocorreu erro no envio
	 */
	public boolean isError() {
		return error;
	}

	/**
	 * Informa se ocorreu erro no envio
	 * 
	 * @param newVal
	 */
	public void setError(boolean newVal){
		error = newVal;
	}

	/**
	 * Codigo de retorno conforme tabela.
	 * 
	 * @param newVal
	 */
	public void setReturnCode(String newVal){
		returnCode = newVal;
	}

	/**
	 * Seta o valor da descricao
	 * 
	 * @param newVal
	 */
	public void setReturnDescription(String newVal){
		returnDescription = newVal;
	}
	
	/**
	 * Formata uma mensagem bonita para retorno.
	 * 
	 * @return Mensagem formatada
	 */
	public String toString() {
		return "Code: "+returnCode+"\n"+
			   "Description: "+returnDescription+"\n"+
			   "Error? "+(error? "Yes" : "No");
	}

}