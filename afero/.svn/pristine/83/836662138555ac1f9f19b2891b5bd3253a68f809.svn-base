package com.human.gateway.client.web;

import java.io.File;
import java.util.List;

import com.human.gateway.client.bean.FileResource;
import com.human.gateway.client.bean.ListResource;
import com.human.gateway.client.bean.MultipleMessage;
import com.human.gateway.client.bean.Response;
import com.human.gateway.client.enumerator.LayoutTypeEnum;
import com.human.gateway.client.service.MultipleMessageService;


public class EnviaMensagemMultiplo {

	public static void main(String[] args) throws Exception {
        				
		String account = "minha_conta";
		String password = "minha_senha";
		
        // Cria uma instancia do cliente de conexao
	    // Configura usuario e senha
		MultipleMessageService clienteHuman = new MultipleMessageService(account, password);
        
        // Cria uma mensagem multipla a partir de um arquivo
		// Tipo do Layout do Arquivo
		//
		String arquivoExemplo = "nome-do-arquivo.txt";
		MultipleMessage fileMessage = new FileResource(new File(arquivoExemplo), LayoutTypeEnum.TYPE_A);
		// Obtem o retorno da integracao (codigo/descricao)
        List<Response> fileRetornos = clienteHuman.send(fileMessage);
		
		// ou
		
		// Cria uma mensagem multipla a partir de uma lista
		// Tipo do Layout do Arquivo
		String data = "550081000001;  Teste Grandes Volumes - Layout E - Marcos; ID0001; EMPRESA XYZ;04/09/2012 17:09:03\n550081000002;  Teste Grandes Volumes - Layout E - Marcos; ID0002; EMPRESA XYZ;04/09/2012 17:09:03\n555181000003;  Teste Grandes Volumes - Layout E - Marcos; ID0003; EMPRESA XYZ;04/09/2012 17:09:03";
		MultipleMessage listMessage = new ListResource(data, LayoutTypeEnum.TYPE_E);
        
        // ou assim:
        
        List<Response> listRetornos = clienteHuman.send(listMessage);
        
        for(Response retorno : listRetornos) {
            System.out.print(retorno.getReturnCode());
            System.out.print(":");
            System.out.println(retorno.getReturnDescription());
        }
        
        // para fazer alguma consulta de status de sms, favor utilizar o 
        // metodo query passando os ids das mensagens
        String[] ids = {"ID0001", "ID0002", "ID0003"};
        
        listRetornos = clienteHuman.query(ids);
        
        for(Response retorno : listRetornos) {
            System.out.print(retorno.getReturnCode());
            System.out.print(":");
            System.out.println(retorno.getReturnDescription());
        }
    }
	
}
