package com.human.gateway.client.web;

import java.util.List;

import com.human.gateway.client.bean.Response;
import com.human.gateway.client.bean.SimpleMessage;
import com.human.gateway.client.service.SimpleMessageService;


public class EnviaMensagemSimples {

    public static void main(String[] args) throws Exception {
        
    	// Configura usuario e senha
    	String account = "minha_conta";
		String password = "minha_senha";
				
    	String id = "010";
		
    	// Cria uma instancia do cliente de conexao
		SimpleMessageService clienteHuman = new SimpleMessageService(account, password);

        // Cria uma mensagem individual
    	SimpleMessage mensagem = new SimpleMessage();    	
    	
    	//Id da mensagem
    	mensagem.setId(id);
    	
        // Numero do celular de destino
        mensagem.setTo("550099990101");
        
        // Conteudo do SMS
        mensagem.setMessage("Minha mensagem de teste");
        
        // Obtem o retorno da integracao (codigo/descricao)
        List<Response> retornos = clienteHuman.send(mensagem);
        for(Response retorno : retornos) {
            System.out.print(retorno.getReturnCode());
            System.out.print(":");
            System.out.println(retorno.getReturnDescription());
        }
        
        
        // para fazer alguma consulta de status de sms, favor utilizar o 
        // metodo query passando o id do sms
    	retornos = clienteHuman.query(id);
        
        for(Response retorno : retornos) {
            System.out.print(retorno.getReturnCode());
            System.out.print(":");
            System.out.println(retorno.getReturnDescription());
        }
    }

}
