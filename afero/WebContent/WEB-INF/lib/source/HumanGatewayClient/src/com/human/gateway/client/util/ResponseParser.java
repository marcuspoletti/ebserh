package com.human.gateway.client.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.human.gateway.client.bean.Response;
import com.human.gateway.client.bean.SimpleMessage;
import com.human.gateway.client.exception.ClientHumanException;

/**
 * Classe utilitaria para auxilio na conversao das respostas do gateway
 * em objetos de manipulacao mais simples.  
 * @author fabio.souza
 *
 */
public final class ResponseParser {

	private ResponseParser(){}
	
	/**
	 * Busca os dados de resposta e formata em uma lista de objetos Response.
	 * 
	 * @param responseBody
	 * @return
	 * @throws ClientHumanException
	 */
	public static List<Response> getResponses(InputStream responseBody) throws ClientHumanException {		
		BufferedReader buffer = new BufferedReader(new InputStreamReader(responseBody));
		List<Response> ret = new ArrayList<Response>();
		try {
			String line = buffer.readLine();
			while (line != null) {				
				ret.add(new Response(line));
				line = buffer.readLine();
			}
			buffer.close();
		} catch (IOException e) {
			throw new ClientHumanException(e);		
		} catch (RuntimeException e) {
			throw new ClientHumanException(e);
		}
		return ret;
	}
	
	/**
	 * Busca os dados de resposta e formata em uma lista de objetos SimpleMessage.
	 * 
	 * @param responseContent
	 * @return
	 * @throws ClientHumanException
	 */
	public static List<SimpleMessage> getMessages(InputStream responseContent) throws ClientHumanException {		
		final String RETORNO_OK = "#300#301#";
		BufferedReader buffer = new BufferedReader(new InputStreamReader(responseContent));
		List<SimpleMessage> ret = new ArrayList<SimpleMessage>();
		try {
			String line = buffer.readLine();
			if( RETORNO_OK.indexOf(line.substring(0,3)) < 0 ){
				throw new ClientHumanException(line);
			}
			while ( (line=buffer.readLine()) != null) {		
				SimpleMessage message = getMessageFromContent(line);
				ret.add(message);
			}
			buffer.close();
		} catch (IOException e) {
			throw new ClientHumanException(e);
		} catch (ParseException e) {
			throw new ClientHumanException(e);		
		} catch (RuntimeException e) {
			throw new ClientHumanException(e);
		}
		return ret;
	}
			
	private static SimpleMessage getMessageFromContent(String content) throws ParseException{		
		String[] pieces = StringUtils.split(content.trim(), ";");
		SimpleMessage message = new SimpleMessage();
		message.setId(pieces[0]);
		message.setSchedule(parseDate(pieces[1]));
		message.setFrom(pieces[2]);
		message.setMessage(pieces[3]);
		return message;
	}	
	
	private static Date parseDate(String dateString) throws ParseException{
		final SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		Date parsed = df.parse(dateString);
		return parsed;
	}
	
}
