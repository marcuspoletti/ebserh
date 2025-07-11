package com.human.gateway.client.web;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.human.gateway.client.bean.SimpleMessage;
import com.human.gateway.client.service.QueryMessageService;


public class ConsultarMensagemRecebida {

    public static void main(String[] args) throws Exception {
        
       	String account = "minha_conta";
		String password = "minha_senha";	
				
		//Cria uma instancia do cliente de conexao
		QueryMessageService query = new QueryMessageService(account, password);            
      
		//Chama o metodo que faz a consulta de todos os SMS recebidos da conta
  		List<SimpleMessage> receivedSMS = query.listReceivedSMS();
  		  		
  		System.out.println("Mensagens recebidas ");
  		
  		//Caso tenha algum SMS recebido itera pelas mensagens e exibe os dados  
  		if(receivedSMS.size() > 0){
  			for (SimpleMessage simpleMessage : receivedSMS) {
  				String receivedDate = formatDate(simpleMessage.getSchedule());
  				String text = String.format("Message{\n id : %s, \nfrom : %s, \nmessage : %s, \nschedule : %s \n}  ", simpleMessage.getId(), simpleMessage.getFrom(), simpleMessage.getMessage(), receivedDate);
  				System.out.println(text);	
  			}  		
	  	}
  		else{
  			System.out.println("Nenhuma mensagem recebida ");		
  		}  				
		
    }
   
    private static String formatDate(Date date) throws ParseException{
		final SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		String format = df.format(date);
		return format;
	}
    

}
