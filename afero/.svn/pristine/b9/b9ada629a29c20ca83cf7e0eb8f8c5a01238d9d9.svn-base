package com.human.gateway.client.web;

import java.io.File;
import java.util.List;

import com.human.gateway.client.bean.FileResource;
import com.human.gateway.client.bean.MultipleMessage;
import com.human.gateway.client.bean.Response;
import com.human.gateway.client.enumerator.LayoutTypeEnum;
import com.human.gateway.client.service.MultipleMessageService;

public class EnviaMensagemMultiploLayoutE {

	public static void main(String[] args) throws Exception {
		
		String account = "minha_conta";
		String password = "meu_codigo";
		
		MultipleMessageService clienteHuman = new MultipleMessageService(account, password);
        
		//                to;           msg;           id;   from; schedule
		//String mensagem = "550098765432;Teste Layout E;id002;Human;29/03/2012 17:00:00";
		//MultipleMessage listMessage = new ListResource(mensagem, LayoutTypeEnum.TYPE_E);
		
		MultipleMessage listMessage = new FileResource(new File("\\testeEnvioLayoutE.csv"), LayoutTypeEnum.TYPE_E);		
        
        List<Response> listRetornos = clienteHuman.send(listMessage);
        for(Response retorno : listRetornos) {
            System.out.print(retorno.getReturnCode());
            System.out.print(":");
            System.out.println(retorno.getReturnDescription());
        }
    }
}
