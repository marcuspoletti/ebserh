package com.human.gateway.client.bean;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

import com.human.gateway.client.enumerator.LayoutTypeEnum;
import com.human.gateway.client.exception.ClientHumanException;

/**
 * Classe responsavel por armazenar um arquivo com seu tipo de layout para ser enviada 
 * para o gateway de sms.
 * 
 * @author tiago martins
 * @version 2.0
 * @since 20-may-2011
 */
public class FileResource extends MultipleMessage{
	
	/**
	 * Arquivo que armazena o conteudo
	 */
	private File content;
	
	/**
	 * Construtor da classe onde eh informado o arquivo e o tipo de layout
	 * 
	 * @param file
	 * @param type
	 */
	public FileResource(File file, LayoutTypeEnum type) {
		super(type);
		content = file;
	}
	
	/**
	 * Retorna o arquivo amazenado
	 * 
	 * @return
	 */
	public File getFile() {
		return content;
	}
	
	@Override
	public String getContent() throws ClientHumanException {
		
		StringBuilder result = new StringBuilder();
		
		//Valida o tamanho do arquivo
		if (content.length() > (1024 * 1024)) {
			throw new ClientHumanException("File size exceeds the limit of 1MB.");
		}
		
		try {
			FileReader reader = new FileReader(content);
			BufferedReader buffer = new BufferedReader(reader);
			String line = buffer.readLine();
			while (line != null) {
				result.append(line).append("\n");
				line = buffer.readLine();
			}
			
		} catch (FileNotFoundException e) {
			throw new ClientHumanException("File not found.");
		} catch (IOException e) {
			throw new ClientHumanException("File not readable.");
		}
		
		return result.toString();
	}
	
}
